package controllers.AutoGateService.service.impl;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.model.Entryticket;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.StringUtils;
import controllers.AutoGateService.service.CheckTicketAutoGateService;
import controllers.AutoGateService.socket.Message;
import controllers.AutoGateService.utils.Encryption;
import play.db.jpa.JPA;
import util.CommonUtil;
import util.AutoGateService.*;
import utils.bus365.security.RSAUtil;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.DateFormat;

import javax.persistence.Query;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

/**
 * 闸机检票方法：
 * 			旧报文：	0主机IP|1主机端口|2闸机设备号|3验票设备|4车票号码|END
 * 			新报文：	0主机IP|1主机端口|2闸机设备号|3验票设备|4检票条件1|5检票条件2|6检票条件3|7校验值|END
 * 			返回报文：SU|班次|票种|座位号|闸机设备号|通过人数|备用|END
 * 新报文与旧报文的区别：
 * 			旧报文：旧报文不支持身份证检票,不支持实名制检票、报文不做校验
 * 			新报文：旧报文支持身份证检票,支持实名制检票、报文做校验(bus365除外)
 * 
 * 共同校验内容有：系统外车票校验、是否需要实名制检票（刷身份证）、车票允许通过闸机次数、校验售票记录的密文是否正确
 * 				、集中式环境中是否允许途径配载班次在异站检票、闸机是否允许预售票通过
 * 				、检查班次状态、发车之前n分钟能通过闸机、班次发班之后n分钟内允许通过闸机、检查检票口与闸机号对应情况
 * 
 * 检票校验内容有：流水班不允许在闸机检票、班次人数超载、班次未报班
 * 
 */
public class CheckTicketAutoGateServiceImpl implements CheckTicketAutoGateService {
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	public static String eStationSellTicketPrivateKey = null;
	private static final String SPROPERTY_FILE_NAME = "options.properties";
	private InputStream roperties_file = null;
	@Override
	public Message checkByticketno(Message msg) throws BusinessException {
		long checkstationid = msg.getCheckstationid(); //检票车站id, CheckStationid
		Organization org = getOrganization(checkstationid);//供查参数等使用
		if(null == org){
			play.Logger.error("检票车站id没有对应的机构，请检查 NvBus/modules/AutoGateService/app/controllers/AutoGateService/socket/AutoGateService.properties配置文件中 CheckStationid 配置项的值是否与organization表中的stationid字段对应");
			throw new BusinessException("777", "NvBus闸机配置文件配置错误");
		}		
		msg.setErrcode("0");// 0 检票成功
		
		// 判断是否工作人员，是则通过
		if(isStationWorker(msg)){
			return msg;
		}
		
		Ticketsell ticket = null;
		String ticketno = null;

		//0 条码设备验票，1 二代身份证设备验票 2 员工卡设备验票(拓展证件类型等)
		if("0".equals(msg.getEquipment())){
			List tickets;
			if ( msg.getTicketno().length() > 25) {// 说明是窗口售电子支付的
				if (CommonUtil.isEmptyString(eStationSellTicketPrivateKey)) {// 说明是电子票的二维码
					try {
						roperties_file = getClass().getClassLoader().getResourceAsStream(SPROPERTY_FILE_NAME);
						if (roperties_file != null) {
							Properties props = new Properties();
							props.load(roperties_file);
							eStationSellTicketPrivateKey = props.getProperty("estationsellticket.privateKey");
							roperties_file.close();
							roperties_file = null;
						} else {
							play.Logger.error("options.properties 中没有estationsellticket.privateKey配置项目 ");
						}
					} catch (IOException e) {
						play.Logger.error("读取eStationSellTicketPrivateKey 失败,可能options.properties 中没有estationsellticket.privateKey配置项目");
						e.printStackTrace();
					}
				}
				if (CommonUtil.isNotEmptyString(eStationSellTicketPrivateKey)) {
					String eticketno = "";
					try {
						eticketno = RSAUtil.decryptByBase64PrivateKey( msg.getTicketno(), eStationSellTicketPrivateKey);
						if (!"".equals(eticketno)) {
							eticketno = eticketno.substring(0, eticketno.indexOf("#"));
							msg.setTicketno(eticketno);
						}
					} catch (Exception e) {
						play.Logger.error("电子票二维码解密失败:" + e.getMessage() + "  密文ticketno " + msg.getTicketno());
						throw new BusinessException("7", "电子票二维码解密失败");
					}
				}
			}
			//电子码（17位）、车票条码（20、10、8、12）            >20 说明是窗口售电子票
			if(msg.getTicketno().length() == 17 || msg.getTicketno().length() >20){
				//电子码  目前陕西西安电子票是17位
				tickets = findTicketsellother(msg.getTicketno(), org.getId());
			}else{
				//纸质票
				tickets = findTicketByTicketno(msg.getTicketno(), org.getId());
			}

			if (tickets == null || tickets.size() == 0) {
				//闸机是否控制本系统外的票号，0：不控制，1：控制
				String isallow = parameterService.findParamValue("3103",org.getId());
				if(isallow.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
					//系统外车票校验
					if(checknoexiststicket(msg)){
						return msg;
					}
				}else {
					throw new BusinessException("1", msg.getTicketno() + "：系统内车票不存在或过了补开天数");
				}
			}else{
				ticket = (Ticketsell) tickets.get(0);
				//检查是否需要实名制检票（刷身份证）
				checkneedrealname(msg,ticket,org);
			}
		}else if("1".equals(msg.getEquipment())){//身份证
			ticket = findTicketByCertificateno(msg.getCertificateno(), org.getId());
		}

		//车票允许通过闸机次数
		if(ticket != null){
			JPA.em().refresh(ticket);
			ticketno = ticket.getTicketno();
			checkNum(ticket, msg, org.getId());
		}else{
			throw new BusinessException("15", ticketno + "：系统内车票不存在或过了补开天数");
		}

		//校验售票记录的密文是否正确
		if(!checkTicketByTicket(ticket)){
			throw new BusinessException("26", "售票记录密文不正确！");
		}

		//集中式环境中是否允许途径配载班次在异站检票  0 不允许   1允许
		String isallowcheckother = parameterService.findParamValue("3020", org.getId());
		if (isallowcheckother.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {
			if (ticket.getDepartstationid() != checkstationid) {
				throw new BusinessException("9", ticket.getTicketno()+ ": 集中式环境中,不允许途径配载班次在异站检票");
			}
		}
		//闸机是否允许预售票通过
		String isnowday = parameterService.findParamValue("3069", org.getId());
		if(ParamterConst.COMMON_FLAG.FALG_NO.equals(isnowday)){
			Date curdate = new Date();
			if (DateUtils.compare(ticket.getDepartdate(), curdate) != 0) {
				throw new BusinessException("3", ticket.getTicketno()+ ":非本日车票");
			}
		}
		
		//检查检票口与闸机号对应情况
		checkticketentranceno(msg,org,ticket);

		play.Logger.info("ticket.getTicketstatus()=================");
		Scheduleplan scheduleplan = JPA.em().find(Scheduleplan.class, ticket.getScheduleplanid());
		List<Schedulestatus> schedulestatuslist = scheduleplan.getSchedulestatuslist();
		//检查班次状态
		checkschedulestatus(msg,scheduleplan,schedulestatuslist,org);
		
		// 固定的返回信息；票种：0 全票，1童票，2军残票，3优惠票，q-全票,b-半票,x-学生票,z-打折票......
		if (ticket.getTickettype().equals("Q")) {
			msg.setTicketype("0");
		} else if (ticket.getTickettype().equals("B")) {
			msg.setTicketype("1");
		} else {
			msg.setTicketype("3");
		}
		msg.setPeoples(1);
		Schedule sch = JPA.em().find(Schedule.class, ticket.getScheduleid());
		msg.setSchcode(sch.getCode());
		msg.setSeatno(String.valueOf(ticket.getSeatno()));

		if(!"1".equals(msg.getGateplacetype())){
			//闸机是否进行检票操作，0：不检票，1：检票
			String isallowcheck = parameterService.findParamValue("3102", org.getId());
			if(isallowcheck.equals(ParamterConst.COMMON_FLAG.FALG_YES)){//检票
				checkticket(msg,org,checkstationid,scheduleplan,ticket,schedulestatuslist);
			}
		}
		return msg;
	}
	
	private boolean isStationWorker(Message msg){
		if(("0".equals(msg.getEquipment())||"2".equals(msg.getEquipment())) && msg.getTicketno() != null && !"".equals(msg.getTicketno())){
			StringBuffer sql = new StringBuffer();
			msg.setTicketno(msg.getTicketno());
			sql.append(" select u from Userinfo u where u.cardno = :cardno and u.isactive = 1 ");
			Query query = JPA.em().createQuery(sql.toString());
			query.setParameter("cardno", msg.getTicketno());
			List list = query.getResultList();
			if (list != null && list.size() > 0) {
				msg.setSchcode("GZRY");
				msg.setTicketype("Q");
				msg.setSeatno("10");
				msg.setPeoples(1);
				return true;
			}
			
			String usersql = " select u.* from Userinfo u,Cardissue c where u.id = c.typeid and c.type='4' and u.isactive = 1 and c.status='0' and c.serialnumber=:serialnumber";
			Query userquery = JPA.em().createNativeQuery(usersql, Userinfo.class);
			userquery.setParameter("serialnumber", msg.getTicketno());
			list = userquery.getResultList();
			if (list != null && list.size() > 0) {
				msg.setSchcode("GZRY");
				msg.setTicketype("Q");
				msg.setSeatno("10");
				msg.setPeoples(1);
				return true;
			} else if ("2".equals(msg.getEquipment())) {
				throw new BusinessException("21", "闸机设备号Equipment=2校验员工卡设备验票(拓展证件类型等)，但未查到该员工卡！");
			}
		}
		return false;
	}

	/**
	 * 时间格式化
	 * @param departdate
	 * @param departtime
	 * @return
	 */
	private Date formatDatetime(Date departdate, String departtime) {
		try {
			String departDatestr = StringUtils.dateToStr(departdate);
			String departTimes = departDatestr + ' ' + departtime;
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date departDate;
			departDate = format.parse(departTimes);
			return departDate;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return new Date();
		}
	}

	/**
	 * 求时间差，返回相差分钟数
	 * @param startdatetime
	 * @param enddatetime
	 * @return
	 */
	private long timeintevl(Date startdatetime, Date enddatetime) {
		try {
			long s1 = startdatetime.getTime();
			long s2 = enddatetime.getTime();
			return (s1 - s2) / 1000 / 60;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return 0;
		}
	}
	
	/**
	 * 闸机检票：修改车票检票状态
	 * @param checkstationid
	 * @param ticket
	 * @param checkedby
	 * @param vehiclereport
	 * @return
	 */
	private Ticketsell savecheckticket(long checkstationid, Ticketsell ticket, long checkedby, Vehiclereport vehiclereport) {
		Station checkstation = new Station();
		checkstation.setId(checkstationid);
		ticket.setCheckstation(checkstation);
		Userinfo userinfo = new Userinfo();
		userinfo.setId(checkedby);
		ticket.setCheckedby(userinfo);
		ticket.setChecktime(new Date());
		ticket.setUpdateby(checkedby);
		ticket.setUpdatetime(new Date());
		ticket.setIschecked(true);
		ticket.setVehiclereport(vehiclereport);
		return JPA.em().merge(ticket);
	}

	/**
	 * 通过身份证号查询售票记录
	 * @param certificateno
	 * @param orgid
	 * @return
	 */
	private Ticketsell findTicketByCertificateno(String certificateno, long orgid) {
		//先查询当日和预售
		StringBuffer sql = new StringBuffer("select t.* from ticketsell t left join customer c on t.customerid=c.id");
		sql.append(" where t.departdate >= trunc(sysdate) ");
		sql.append(" and c.certificateno = :certificateno and t.ticketstatus='0' ");
		//按身份证号查询：优先查出主票。避免闸机检票出错：儿童票补票，与主票使用同一证件，且售票员与主票售票员不同，未生成新售票密文（直接复制的主票密文）。
		sql.append(" order by t.departdate, t.id, t.departtime ");
		Query query = JPA.em().createNativeQuery(sql.toString(),Ticketsell.class);
		query.setParameter("certificateno", certificateno);
		List<Ticketsell> list = query.getResultList();

		//若无当日和预售票，则需要查询过期票
		if(list == null || list.size() < 1){
			//重打\补开\注销结算单的天数
			String opendays = parameterService.findParamValue("3041", orgid);	//补开
			int days = Integer.parseInt(opendays);
			Date departdate = DateUtils.add(new Date(), -days);
			String departdatestr = util.DateUtils.formatDate(departdate);

//			sql = new StringBuffer("select t from Ticketsell t left join Customer c on t.customer.id=c.id");
//			sql.append(" where t.departdate >= to_date(:departdatestr, 'yyyy-mm-dd') ");
//			sql.append(" and c.certificateno = :certificateno and t.ticketstatus='0' ");
//			sql.append(" order by t.departdate, t.tickettype, t.departtime desc ");//过期票取距今天最近一天的车票
//			query = JPA.em().createQuery(sql.toString());
//			query.setParameter("departdatestr", departdatestr);
//			query.setParameter("certificateno", certificateno);
//			list = query.getResultList();

			sql = new StringBuffer("select t.* from ticketsell t left join customer c on t.customerid=c.id");
			sql.append(" where t.departdate >= to_date(:departdatestr, 'yyyy-mm-dd') ");
			sql.append(" and c.certificateno = :certificateno and t.ticketstatus='0' ");
			//按身份证号查询：优先查出主票。避免闸机检票出错：儿童票补票，与主票使用同一证件，且售票员与主票售票员不同，未生成新售票密文（直接复制的主票密文）。
			sql.append(" order by t.departdate, t.id, t.departtime ");
			query = JPA.em().createNativeQuery(sql.toString(),Ticketsell.class);
			query.setParameter("departdatestr", departdatestr);
			query.setParameter("certificateno", certificateno);
			list = query.getResultList();

		}

		Ticketsell ticket;
		if((null == list) ||(list.size() == 0)){
			throw new BusinessException("1", "证件号为"+certificateno + "：系统内车票不存在或过了补开天数");
		}else{
			ticket = list.get(0);
		}
		return ticket;
	}


	/**
	 * 通过票号查询售票记录
	 * @param ticketno
	 * @param orgid
	 * @return
	 */
	public List<Ticketsell> findTicketByTicketno(String ticketno, long orgid) {
		Billtype bt = billtypeService.findByCode("Ticket");
		String cuticketno = ticketno;
		//补全票号
		if (ticketno.length() > bt.getTicketnolength()) {
			int pos = (int) (ticketno.length() - bt.getTicketnolength());
			cuticketno = ticketno.substring(pos, ticketno.length());
		} else if (ticketno.length() < bt.getTicketnolength()) {
			cuticketno = StringUtils.strPad(ticketno, (int) bt.getTicketnolength(), "0");
		}

		//先查询当日和预售
		StringBuffer sql = new StringBuffer("select t from Ticketsell t ");
		sql.append(" where t.departdate >= trunc(sysdate) ");
		sql.append(" and t.ticketno = :ticketno and t.ticketstatus='0' ");
		sql.append(" order by t.departdate, t.departtime ");
		Query query = JPA.em().createQuery(sql.toString());
		query.setParameter("ticketno", cuticketno);
		List<Ticketsell> list = query.getResultList();

		//若无当日和预售票，则需要查询过期票
		if(list == null || list.size() < 1){
			//重打\补开\注销结算单的天数
			String opendays = parameterService.findParamValue("3041", orgid);	//补开
			int days = Integer.parseInt(opendays);
			Date departdate = DateUtils.add(new Date(), -days);
			String departdatestr = util.DateUtils.formatDate(departdate);
			sql = new StringBuffer("select t from Ticketsell t ");
			sql.append(" where t.departdate >= to_date(:departdatestr, 'yyyy-mm-dd') ");
			sql.append(" and t.ticketno = :ticketno and t.ticketstatus='0' ");
			sql.append(" order by t.departdate, t.departtime desc ");//过期票取距今天最近一天的车票
			query = JPA.em().createQuery(sql.toString());
			query.setParameter("departdatestr", departdatestr);
			query.setParameter("ticketno", ticketno);
			list = query.getResultList();
		}

		return list;
	}

	/**
	 * 通过电子码查询售票记录
	 * @param eticketno
	 * @param orgid
	 * @return
	 */
	public List<Ticketsell> findTicketsellother(String eticketno, long orgid){
		//先查询当日和预售
		StringBuffer sql = new StringBuffer();
		sql.append("select t from Ticketsell t, Ticketsellother ts ");
		sql.append(" where t.id = ts.ticketsellid ");
		sql.append("  and t.departdate >= trunc(sysdate) ");
		sql.append("  and ts.eticketno = :eticketno and t.ticketstatus='0' ");
		sql.append(" order by t.departdate, t.departtime ");
		Query query = JPA.em().createQuery(sql.toString(), Ticketsell.class);
		query.setParameter("eticketno", eticketno);
		List<Ticketsell> list = query.getResultList();

		//若无当日和预售票，则需要查询过期票
		if(list == null || list.size() < 1){
			//重打\补开\注销结算单的天数
			String opendays = parameterService.findParamValue("3041", orgid);	//补开
			int days = Integer.parseInt(opendays);
			Date departdate = DateUtils.add(new Date(), -days);
			sql = new StringBuffer();
			sql.append("select t from Ticketsell t, Ticketsellother ts ");
			sql.append(" where t.id = ts.ticketsellid ");
			sql.append("  and t.departdate >= trunc( :departdate ) ");
			sql.append("  and ts.eticketno = :eticketno and t.ticketstatus='0' ");
			sql.append(" order by t.departdate, t.departtime desc ");//过期票取距今天最近一天的车票
			query = JPA.em().createQuery(sql.toString(), Ticketsell.class);
			query.setParameter("eticketno", eticketno);
			query.setParameter("departdate", departdate);
		}

		return list;
	}

	/**
	 * 检票闸机允许重复刷票进行检票的最大次数
	 * @param ticketsell
	 * @param message
	 * @param orgid
	 */
	private void checkNum(Ticketsell ticketsell, Message message, long orgid){
		int checkcount  = Integer.parseInt(parameterService.findParamValue("3105", orgid));
		play.Logger.info("最大允许通过闸机次数是checkcount="+checkcount);
		String ticketnodata = ticketsell.getTicketno();
		StringBuffer sql = new StringBuffer("select t from Entryticket t ");
		sql.append(" where t.ticketno=:ticketno");
		Query query = JPA.em().createQuery(sql.toString());
		query.setParameter("ticketno", ticketnodata);
		List list = query.getResultList();
		play.Logger.info("查出记录次数是count="+list.size());
		if(list == null || list.size() < checkcount){
			//未超过最大允许通过次数
			Entryticket en = new Entryticket();
			en.setTicketno(ticketnodata);
			en.setCreatetime(new Date());
			JPA.em().merge(en);//记录车票通过闸机
			message.setErrcode("0");//Errcode : 0-SU  其他-FL
		}else{
			throw new BusinessException("10", ticketnodata + ": 该车票已超过最大允许通过闸机次数");
		}
	}

	/**
	 * 获取流水班报班信息
	 * @param scheduleid
	 * @param orgid
	 * @return
	 */
	private Vehiclereport getLineVehiclereport(long scheduleid, long orgid){
		StringBuilder a = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 ")
				.append(" and vr.scheduleplanid=:scheduleplanid and vr.reportorgid=:reportorgid and vr.isdeparted=0 order by id");
		Query b = JPA.em().createQuery(a.toString());
		b.setParameter("scheduleplanid", scheduleid);
		b.setParameter("reportorgid", orgid);
		List<Object> c = b.getResultList();
		return  (Vehiclereport) (c != null && c.size() > 0 ? c.get(0) : null);
	}

	/**
	 * 通过id查询机构信息
	 */
	public Organization getOrganization(long stationid) {
		StringBuilder sql = new StringBuilder("select o from Organization o")
				.append(" where (o.type='1' or o.type='2') and o.isactive=1")
				.append(" and o.station.id=:stationid ");
		Query query = JPA.em().createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		return (Organization) query.getSingleResult();
	}

	/**
	 * 查询正常班次的报班记录
	 */
	private Vehiclereport getVehiclereport(Scheduleplan scheduleplan, long reportorgid) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 ")
				.append(" and vr.scheduleplanid=:scheduleplanid and vr.reportorgid=:reportorgid");
		Query query = JPA.em().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		query.setParameter("reportorgid", reportorgid);
		List<Object> list = query.getResultList();
		return (Vehiclereport) (list != null && list.size() > 0 ? list.get(0) : null);
	}

	/**
	 * 班次的已检票数
	 * @param vehiclereportid
	 * @param scheduleplanid
	 * @return
	 */
	private long getCheckedcount(long vehiclereportid,long scheduleplanid) {
		StringBuilder sql = new StringBuilder(
				"select count(t) from Ticketsell t ").append(
				" where t.ticketstatus='0' and t.ischecked=1").append(
				" and t.vehiclereport.id=:vehiclereportid and t.scheduleplanid=:scheduleplanid");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		Query query = JPA.em().createQuery(sql.toString());
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 ? list.get(0) : 0);
	}
	
	//校验售票记录的密文是否正确
	private boolean checkTicketByTicket(Ticketsell ticketsell) {
		if (ticketsell == null) {
			return false;
		}
		try {
			//判断是否有Tiksno字段
//			Field fieldtiksno =  ticketsell.getClass().getField("tiksno");
//			String tiksno = (String) fieldtiksno.get(ticketsell);
			Method fieldtiksno =  ticketsell.getClass().getMethod("getTiksno");
			String tiksno = (String) fieldtiksno.invoke(ticketsell);
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String datestr = df.format(ticketsell.getSelltime());
			String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
			if(!Encryption.chkTicketno(cipherStr, tiksno)){
				return false;
			}
			return true;
		} catch (Exception e) {
			return true;
		}
	}
	
	private void checkticket(Message msg,Organization org,long checkstationid,Scheduleplan scheduleplan,Ticketsell ticket,List<Schedulestatus> schedulestatuslist){
		Vehiclereport vehiclereport;
		if (scheduleplan.getIslinework()) {
			//闸机是否检流水班
			String isnocheckline = parameterService.findParamValue("3073", org.getId());
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(isnocheckline)){//是
				vehiclereport = getLineVehiclereport(scheduleplan.getId(), org.getId());
				if (vehiclereport == null || vehiclereport.getScheduleplanid() != scheduleplan.getId()) {
					throw new BusinessException("2", "班次未报班");
				}
			}else{
				throw new BusinessException("6", "流水班不允许在闸机检票");
			}
		} else {
			vehiclereport = getVehiclereport(scheduleplan, org.getId());
			if (vehiclereport == null || vehiclereport.getScheduleplanid() != scheduleplan.getId()) {
				throw new BusinessException("2", "班次未报班");
			}
			if (scheduleplan.getSeatnum() <= getCheckedcount(vehiclereport.getId(), scheduleplan.getId())) {
				throw new BusinessException("12", "班次人数超载");
			}
		}

		if(!ticket.getIschecked()) {//未检的票，检一次
			List<Scheduleseats> scheduleseatslist = scheduleplan.getScheduleseatslist();
//			boolean isvalidsch = false;
//			for (Schedulestatus schedulestatus : schedulestatuslist) {
//				if (schedulestatus.getDepartstationid() == checkstationid) {
//					isvalidsch = true;
//				}
//			}
//			play.Logger.info("ticket.getTicketstatus()==========2=======");
//			if (!isvalidsch) {
//				throw new BusinessException("19", "不允许在本闸机检票");
//			}
//			play.Logger.info("ticket.getTicketstatus()==========end=======");
			long checkedby = msg.getCheckby();
			Ticketsell ts = savecheckticket(checkstationid, ticket, checkedby, vehiclereport);
			for (Scheduleseats seat : scheduleseatslist) {
				if (seat.getSeatno() == ts.getSeatno()) {
					seat.setStatus("7");
					seat.setUpdateby(checkedby);
					seat.setUpdatetime(new Date());
					JPA.em().merge(seat);
				}
			}
			play.Logger.info("方法结束：" + new Date());
		}
	}
	
	//检查班次状态
	private void checkschedulestatus(Message msg,Scheduleplan scheduleplan,List<Schedulestatus> schedulestatuslist,Organization org){
		for (Schedulestatus schedulestatus : schedulestatuslist) {//校验班次状态
			if (!scheduleplan.getIslinework()) {
				//发车之前，n分钟能通过闸机；0则不限制；默认为0  闸机不再使用3001参数
				long beginchecktime = new Long(parameterService.findParamValue("3074", org.getId()));
				if("1".equals(msg.getGateplacetype())){
					//3075 '发班之前，n分钟内能通过侯车室进站闸机；0则不限制；默认为0'
					beginchecktime = new Long(parameterService.findParamValue("3075", org.getId()));
				}
				long timemargin = timeintevl(formatDatetime(schedulestatus.getDepartdate(), schedulestatus.getDeparttime()), new Date());
				if (beginchecktime > 0 && timemargin > beginchecktime) {
					throw new BusinessException("4", "班次未开检");
				}

				//班次发班之后，n分钟内允许通过闸机，小于0则不允许通过，0则不限制，大于0则限制；默认-1
				long afterstart = new Long(parameterService.findParamValue("3072", org.getId()));
				long aftertime = timeintevl(new Date(), formatDatetime(schedulestatus.getDepartdate(), schedulestatus.getDeparttime()));
				if(afterstart < 0){
					if (schedulestatus.getIsdeparted()) {
						throw new BusinessException("5", "班次已发");
					}
				}else if(afterstart > 0 && aftertime > afterstart){//提示不能过闸机了
					if (schedulestatus.getIsdeparted()) {
						throw new BusinessException("5", "班次已发");
					}
				}
			}

			if (schedulestatus.getStatus().equals("4")) {
				throw new BusinessException("6", "班次已脱班");
			}
			if (schedulestatus.getStatus().equals("1")) {
				throw new BusinessException("11", "班次已停班");
			}
		}
	}

	//检查检票口与闸机号对应情况
	private void checkticketentranceno(Message msg,Organization org,Ticketsell ticket){
		String ticketentrance = msg.getGatesno();
		if(org.getCode().equals("JJKYZ")){//九江客运的
			if ("1".equals(ticketentrance)) {
				if (!"01".equals(ticket.getTicketentrance()) && !"02".equals(ticket.getTicketentrance())) {
					throw new BusinessException("19", "不允许在本闸机检票");
				}
			} else if ("2".equals(ticketentrance)) {
				if (!"03".equals(ticket.getTicketentrance()) && !"04".equals(ticket.getTicketentrance())) {
					throw new BusinessException("19", "不允许在本闸机检票");
				}
			} else {
				throw new BusinessException("20", "未知闸机");
			}
		}else if(org.getCode().equals("YCDZ")){
			if (!ticket.getTicketentrance().equals(ticketentrance)) {
				throw new BusinessException("19", "不允许在本闸机检票");
			}
		}
	}
	
	//检查是否需要实名制检票（刷身份证）
	private void checkneedrealname(Message msg,Ticketsell ticket,Organization org){

		//获取客户信息
		Customer customer = ticket.getCustomer();

		//3071闸机是否实名制验票，0否，1是
		String p3071 = parameterService.findParamValue("3071",org.getId());
		if("1".equals(msg.getGateplacetype())){
			//3076 '侯车室进站闸机是否进行身份证验票，0否，1是，默认为1',
			p3071 = parameterService.findParamValue("3076",org.getId());
		}
		if(!"1".equals(p3071)){
			return; //不需要实名过闸机
		}
		//9393是否实名制售票：0否，1全局实名制，2固定线路实名制
		if(customer==null){
			return;//没有车票信息，不需要实名过闸机
		}
		String p9393 = parameterService.findParamValue("9393",org.getId());
		if("1".equals(p9393)&&"0".equals(customer.getCertificatetype())){
			msg.setCertificateno(customer.getCertificateno());
			throw new BusinessException("25", ticket.getTicketno() + ":该车票需身份证核验");
		}else if("2".equals(p9393)&&"0".equals(customer.getCertificatetype())&&CommonUtil.isNotEmptyString(customer.getCertificateno())){
			String sql1 = "select count(1) from ticketsell ts join schedule sc on  ts.scheduleid=sc.id "
					+"join route ro on ro.id=sc.routeid where ro.isrealnameticket='1' and ts.ticketno = :ticketno ";
			Query query1 = JPA.em().createNativeQuery(sql1);
			query1.setParameter("ticketno", ticket.getTicketno());
			if(query1.getResultList().size()>0){
				msg.setCertificateno(customer.getCertificateno());
				throw new BusinessException("25", ticket.getTicketno() + "该车票需身份证核验");
			}
		}
	}
	
	//系统外车票校验
	private boolean checknoexiststicket(Message msg){
		//此部分作用为判断系统内外车票是否已检,如果没有检票则检一下，系统外票只检一次
		StringBuffer sql = new StringBuffer("select t from Entryticket t ");
		sql.append(" where t.ticketno=:ticketno");
		Query query = JPA.em().createQuery(sql.toString());
		query.setParameter("ticketno", msg.getTicketno());
		List list=query.getResultList();
		//ticketsell为空，为本库中不存在的票号，则认为是系统外票号，记录到Entryticket后返回即可;不为空，则为系统内票号，需要进行各种校验
		//站外票
		if(list == null || list.size() == 0){
			Entryticket en=new Entryticket();
			en.setTicketno(msg.getTicketno());
			en.setCreatetime(new Date());
			JPA.em().merge(en);
			msg.setSchcode("0001");
			msg.setTicketype("0");
			msg.setSeatno("1");
			msg.setPeoples(1);
			msg.setEquipment("0");
			play.Logger.info("系统外车票通过闸机，票号为：" + msg.getTicketno());
			return true;
		}else{
			throw new BusinessException("8", msg.getTicketno() + ":该车票为系统外车票，且已在闸机使用过!");
		}
	}
	 
			
}
