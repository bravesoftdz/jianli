package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;
import javax.transaction.UserTransaction;

import org.wltea.expression.ExpressionEvaluator;

import cn.nova.bus.balance.dao.BalancedeductDao;
import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.dao.DepartinvoicesotherDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.model.Departinvoicesothersell;
import cn.nova.bus.checkticket.service.DepartinvoicesotherService;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import oracle.net.aso.a;
import play.db.jpa.JPA;
import util.CommonUtil;
import util.CurrentUtil;
import util.CurrentUtil;
import util.DateUtils;

import util.DateUtils;

@SuppressWarnings("unchecked")
public class DepartinvoicesotherServiceImpl implements
		DepartinvoicesotherService {

	private BalancedeductDao balancedeductDao = new BalancedeductDao();

	private DepartinvoicesotherDao dao = new DepartinvoicesotherDao();
	//private UserTransaction usertransaction = new UserTransaction();
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	private ParameterService parameterService = new ParameterServiceImpl();//获取参数
    private List tsoldids = null;
    
    private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		if(propertyFilters!=null && propertyFilters.size() >0){
			for(int i=propertyFilters.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilters.get(i);
				if("d!scheduleid".equals(propertyFilter.getPropertyFullName())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=balancedeductDao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilters.remove(propertyFilter);
						propertyFilters.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "ischoose", "unname",
				"createby", "scheduleid", "id", "isreturntrip", "isoriginator",
				"departinvoicesno", "departdate", "departtime", "ticketnum",
				"totalmoney", "balancemoney", "stationfee", "agentfee",
				"recordip", "balancedate", "createtime", "updatetime",
				"d1name", "d2name", "d3name", "d4name", "orgname", "ste1name",
				"ste2name", "schedulecode", "departname", "vehiclename",
				"createname", "updatename", "balancestationname",
				"balancename", "statusname", "selfdepartdate", "orgid",
				"vehicleid", "departstationid", "driver1id", "driver2id",
				"driver3id", "driver4id", "steward1id", "steward2id",
				"starttime", "datafrom", "datafromname", "balanceunitid",
				"balanceunitname", "unitname", "isauditvalue", "sellerid",
				"seller", "workwayname","routename", "unfullname",
				"reachstationname", "distance", "seatnum", "vehicletypename","OTHTERFEE","unitcode" },
				dao.query(propertyFilters), new Object[] { Boolean.class,
						String.class, String.class, Long.class, Long.class,
						Boolean.class, Boolean.class, String.class, Date.class,
						String.class, Long.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, Timestamp.class, Timestamp.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, Date.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, String.class,
						String.class, String.class, Long.class, String.class,
						String.class, String.class, long.class, String.class,
						String.class, String.class, String.class, String.class,
						int.class, int.class, String.class, BigDecimal.class, String.class });
	}

	@Override
	public Departinvoicesother save(Departinvoicesother departinvoicesother) throws ServiceException{
		if (departinvoicesother.getDriver1().getId() == 0) {
			departinvoicesother.setDriver1(null);
		}
		if (departinvoicesother.getDriver2().getId() == 0) {
			departinvoicesother.setDriver2(null);
		}
//		if (departinvoicesother.getDriver3().getId() == 0) {
//			departinvoicesother.setDriver3(null);
//		}
//		if (departinvoicesother.getDriver4().getId() == 0) {
//			departinvoicesother.setDriver4(null);
//		}
		if (departinvoicesother.getSteward1().getId() == 0) {
			departinvoicesother.setSteward1(null);
		}
//		if (departinvoicesother.getSteward2().getId() == 0) {
//			departinvoicesother.setSteward2(null);
//		}
		if (departinvoicesother.getSchedule().getId() == 0){
			departinvoicesother.setSchedule(null);
		}
		
		Billtype billtype = billtypeService
		.findByCode(ConstDefiniens.BalanceBill);
		String departinvoicesno = departinvoicesother.getDepartinvoicesno();
		//添加操作的时候进行跳号，如果是修改操作则不再进行跳号了
		if (departinvoicesother.getId() == 0) {
			//票据领用记录表操作 ， 对结算单号进行调号    begin by（仉）2017年11月20日08:57:32
			String p3098 = parameterService.findParamValue(ParamterConst.Param_3089, departinvoicesother.getOrgid());
			if ("1".equals(p3098)) {
				long createby = departinvoicesother.getUpdateby();
				Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
						createby, new Long(departinvoicesno));
				String curDepartinvoicesno =departinvoicesno;
				if (billinuse == null || "2".equals(billinuse.getStatus())) {
					// 您的票据已经用完
					throw new ServiceException("0143");
				}
				// 补零操作         当前在使用的票号
				curDepartinvoicesno = String.valueOf(billinuse.getNextno()); 
				
				if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
					curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno, 
							(int) billtype.getTicketnolength(), "0");
				}
				if (!curDepartinvoicesno.equals(departinvoicesno)) {
					// 您的票据当前号码与系统的号码不一致，请重置票号！
					throw new ServiceException("0144");
				}
				//票号调号
				billinuse.setNextno(billinuse.getNextno() + 1);    
				if (billinuse.getNextno() > billinuse.getEndno()+1) {
					// 当前票段剩余票数不够打印
					throw new ServiceException("0171");
				}
				// 本次若是最后一张票据
				if (billinuse.getNextno() > billinuse.getEndno()) {
					billinuse.setStatus("2");
				}
				billinuse.setUpdateby(createby);
				billinuse.setUpdatetime(new Date());
				dao.getEntityManager().merge(billinuse);
			}   
		}
		//end by(仉)
		
		List<Departinvoicesotherdetail> list = new ArrayList<Departinvoicesotherdetail>();
		List<Departinvoicesotherdetail> list1 = new ArrayList<Departinvoicesotherdetail>();
		//Boolean isupdate = false;
		// 补零操作
		if (billtype.getTicketnolength() != departinvoicesno.length()) {
			departinvoicesno = StringUtils.strPad(departinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		String flag = parameterService.findParamValue(ParamterConst.Param_3068, departinvoicesother.getOrgid());
		departinvoicesother.setDepartinvoicesno(departinvoicesno);
		int distance = dao.getDepartinvoicesOtherDistance(departinvoicesother.getSchedule()
				.getId(), departinvoicesother.getReachstationid());
		Date now=new Date();
		if (departinvoicesother.getId() == 0) {
				Departinvoicesotherdetail dd=new Departinvoicesotherdetail();
				dd.setAgentfee(departinvoicesother.getAgentfee());
				dd.setBalanceamount(departinvoicesother.getBalancemoney());
				dd.setCreateby(departinvoicesother.getCreateby());
				dd.setCreatetime(now);
				dd.setDepartdate(departinvoicesother.getDepartdate());
				dd.setDeparttime(departinvoicesother.getDeparttime());
				dd.setDistance(distance);
				dd.setFromstationid(departinvoicesother.getDepartstationid());
				dd.setOthterfee(departinvoicesother.getOthterfee());
				dd.setPrice(departinvoicesother.getPrice());
				dd.setReachstationid(departinvoicesother.getReachstationid());
				dd.setSchedule(departinvoicesother.getSchedule());
				dd.setStationservicefee(departinvoicesother.getStationfee());
				dd.setStatus("0");
				dd.setTicketnum(departinvoicesother.getTicketnum());
				dd.setTickettypeid(departinvoicesother.getTickettypeid());
				dd.setTotalamount(departinvoicesother.getTotalmoney());
				dd.setUpdateby(departinvoicesother.getCreateby());
				dd.setUpdatetime(now);
				dd.setBalanceprice(departinvoicesother.getBalanceprice());
				//是否应用扣费项目进行扣费
				if(flag.equals("1")){
					qryBalancededuct(departinvoicesother.getOrgid(),departinvoicesother.getVehicleid(),dd);
					departinvoicesother.setStationfee(dd.getStationservicefee());
					departinvoicesother.setOthterfee(dd.getOthterfee());
					departinvoicesother.setAgentfee(dd.getAgentfee());
					departinvoicesother.setBalancemoney(dd.getBalanceamount());
				}else{
					departinvoicesother.setStationfee(departinvoicesother.getStationfee());
					departinvoicesother.setOthterfee(departinvoicesother.getOthterfee());
					departinvoicesother.setAgentfee(departinvoicesother.getAgentfee());
					departinvoicesother.setBalancemoney(departinvoicesother.getBalancemoney());
				}
				departinvoicesother=(Departinvoicesother) dao.merge(departinvoicesother);
				long departinvoicesotherid=departinvoicesother.getId();
				dd.setDepartinvoicesotherid(departinvoicesotherid);
				dao.merge(dd);
		} else {
			Departinvoicesother other = getById(departinvoicesother.getId());
			if(other.getSchedule().getId()!=departinvoicesother.getSchedule().getId()){
				//0761同一结算单号只能补录一个班次，请重新选择班次
				throw new ServiceException("0761");
			}
			if(DateUtils.compare(other.getDepartdate(), departinvoicesother.getDepartdate())!=0){
				other.setDepartdate(departinvoicesother.getDepartdate());
				other.setSelfdepartdate(departinvoicesother.getDepartdate());
				//一张结算单不同站点发车日期一致
				dao.updateDepartinvoicedetailDateById(departinvoicesother.getId(),departinvoicesother.getDepartdate());
			}
			if ("2".equals(other.getStatus())) {
				throw new ServiceException("0391");
			}
			long departinvoicesotherid=departinvoicesother.getId();
			BigDecimal totalmoney=new BigDecimal(0);
			BigDecimal stationfee=new BigDecimal(0);
			BigDecimal agentfee=new BigDecimal(0);
			BigDecimal otherfee=new BigDecimal(0);
			BigDecimal balancemoney = new BigDecimal(0);
			int tickets=0;
			if(departinvoicesother.getDepartinvoicesotherdetailid()==0){
				
				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("GEL_t!departinvoicesotherid", departinvoicesotherid));
				List<Departinvoicesotherdetail> dlist =dao.find(Departinvoicesotherdetail.class,propertyFilters);
				boolean isexist=false;
				Departinvoicesotherdetail dd=new Departinvoicesotherdetail();
				dd.setAgentfee(departinvoicesother.getAgentfee());
				dd.setBalanceamount(departinvoicesother.getBalancemoney());
				dd.setCreateby(departinvoicesother.getCreateby());
				dd.setCreatetime(now);
				dd.setDepartdate(departinvoicesother.getDepartdate());
				dd.setDeparttime(departinvoicesother.getDeparttime());
				dd.setDistance(distance);
				dd.setFromstationid(departinvoicesother.getDepartstationid());
				dd.setOthterfee(departinvoicesother.getOthterfee());
				dd.setPrice(departinvoicesother.getPrice());
				dd.setReachstationid(departinvoicesother.getReachstationid());
				dd.setSchedule(departinvoicesother.getSchedule());
				dd.setStationservicefee(departinvoicesother.getStationfee());
				dd.setStatus("0");
				dd.setTicketnum(departinvoicesother.getTicketnum());
				dd.setTickettypeid(departinvoicesother.getTickettypeid());
				dd.setTotalamount(departinvoicesother.getTotalmoney());
				dd.setUpdateby(departinvoicesother.getCreateby());
				dd.setUpdatetime(now);
				dd.setBalanceprice(departinvoicesother.getBalanceprice());
				for(Departinvoicesotherdetail dst:dlist){
					if(dst.getReachstationid().longValue()==dd.getReachstationid().longValue()&&
						dst.getFromstationid().longValue()==dd.getFromstationid().longValue()&&
						dst.getTickettypeid().longValue()==dd.getTickettypeid().longValue()&&
						dst.getPrice().compareTo(dd.getPrice())==0
						){
						isexist=true;
						//是否应用扣费项目进行扣费
						if(flag.equals("1")){
							qryBalancededuct(departinvoicesother.getOrgid(),departinvoicesother.getVehicleid(),dd);
							departinvoicesother.setStationfee(dd.getStationservicefee());
							departinvoicesother.setOthterfee(dd.getOthterfee());
							departinvoicesother.setAgentfee(dd.getAgentfee());
							departinvoicesother.setBalancemoney(dd.getBalanceamount());
						}
						dst.setAgentfee(dst.getAgentfee().add(dd.getAgentfee()));
						dst.setTotalamount(dst.getTotalamount().add(dd.getTotalamount()));
						dst.setStationservicefee(dst.getStationservicefee().add(dd.getStationservicefee()));
						dst.setOthterfee(dst.getOthterfee().add(dd.getOthterfee()));
						dst.setTicketnum(dst.getTicketnum()+dd.getTicketnum());
						dst.setUpdateby(departinvoicesother.getCreateby());
						dst.setUpdatetime(now);
						dao.merge(dst);
						break;
					}
				}
				departinvoicesother.setStationfee(departinvoicesother.getStationfee());
				departinvoicesother.setOthterfee(departinvoicesother.getOthterfee());
				departinvoicesother.setAgentfee(departinvoicesother.getAgentfee());
				departinvoicesother.setBalancemoney(departinvoicesother.getBalancemoney());
				if(!isexist){				
					dd.setDepartinvoicesotherid(departinvoicesotherid);
					//是否应用扣费项目进行扣费
					if(flag.equals("1")){
						qryBalancededuct(departinvoicesother.getOrgid(),departinvoicesother.getVehicleid(),dd);
						departinvoicesother.setStationfee(dd.getStationservicefee());
						departinvoicesother.setOthterfee(dd.getOthterfee());
						departinvoicesother.setAgentfee(dd.getAgentfee());
						departinvoicesother.setBalancemoney(dd.getBalanceamount());
					}
					dao.merge(dd);
				}
				totalmoney=totalmoney.add(dd.getTotalamount());
				stationfee=stationfee.add(dd.getStationservicefee());
				agentfee=agentfee.add(dd.getAgentfee());
				otherfee=otherfee.add(dd.getOthterfee());
				balancemoney= balancemoney.add(dd.getBalanceamount());
				tickets=(int) (tickets+dd.getTicketnum());
			}else{
				Departinvoicesotherdetail dd=(Departinvoicesotherdetail) dao.get(Departinvoicesotherdetail.class, departinvoicesother.getDepartinvoicesotherdetailid());

				
				dd.setAgentfee(departinvoicesother.getAgentfee());
				dd.setBalanceamount(departinvoicesother.getBalancemoney());
				dd.setDistance(distance);
				dd.setFromstationid(departinvoicesother.getDepartstationid());
				dd.setOthterfee(departinvoicesother.getOthterfee());
				dd.setPrice(departinvoicesother.getPrice());
				dd.setReachstationid(departinvoicesother.getReachstationid());
				dd.setStationservicefee(departinvoicesother.getStationfee());
				dd.setTicketnum(departinvoicesother.getTicketnum());
				dd.setTickettypeid(departinvoicesother.getTickettypeid());
				dd.setTotalamount(departinvoicesother.getTotalmoney());
				dd.setUpdateby(departinvoicesother.getCreateby());
				dd.setUpdatetime(now);
				dd.setBalanceprice(departinvoicesother.getBalanceprice());
				//是否应用扣费项目进行扣费
				if(flag.equals("1")){
					qryBalancededuct(departinvoicesother.getOrgid(),departinvoicesother.getVehicleid(),dd);
					departinvoicesother.setStationfee(dd.getStationservicefee());
					departinvoicesother.setOthterfee(dd.getOthterfee());
					departinvoicesother.setAgentfee(dd.getAgentfee());
					departinvoicesother.setBalancemoney(dd.getBalanceamount());
				}else{
					departinvoicesother.setStationfee(departinvoicesother.getStationfee());
					departinvoicesother.setOthterfee(departinvoicesother.getOthterfee());
					departinvoicesother.setAgentfee(departinvoicesother.getAgentfee());
					departinvoicesother.setBalancemoney(departinvoicesother.getBalancemoney());
				}
				dao.merge(dd);
				list.add(dd);
				//isupdate = true;
			}
			dao.getEntityManager().flush();
			//重新计算主表数据
			totalmoney=new BigDecimal(0);
			stationfee=new BigDecimal(0);
			agentfee=new BigDecimal(0);
			otherfee=new BigDecimal(0);
			balancemoney = new BigDecimal(0);
			tickets=0;
			list1 = dao.qryDepartinvoicesotherdetail(departinvoicesotherid);
			for(Departinvoicesotherdetail dst:list1){
					totalmoney=totalmoney.add(dst.getTotalamount());
					stationfee=stationfee.add(dst.getStationservicefee());
					agentfee=agentfee.add(dst.getAgentfee());
					otherfee=otherfee.add(dst.getOthterfee());
					balancemoney=balancemoney.add(dst.getBalanceamount());
					tickets=(int) (tickets+dst.getTicketnum());	
			}
			other.setAgentfee(agentfee);
			other.setStationfee(stationfee);
			other.setTotalmoney(totalmoney);
			other.setOthterfee(otherfee);
			other.setTicketnum(tickets);
			other.setBalancemoney(balancemoney);
			//BigDecimal balancemoney=other.getTotalmoney().subtract(other.getAgentfee()).subtract(other.getStationfee()).subtract(otherfee);
			//other.setBalancemoney(balancemoney);
			departinvoicesother=(Departinvoicesother) dao.merge(other);
		}
		return departinvoicesother;
	}

	private void qryBalancededuct(long orgid,long vehicleid,Departinvoicesotherdetail dd){
		/*List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!departdate",departdate));
		filters.add(new PropertyFilter("EQL_t!scheduleid",scheduleid));
		*/
		Date departdate=dd.getDepartdate();
		long scheduleid=dd.getSchedule().getId();
		Schedule schedule=(Schedule) balancedeductDao.get(Schedule.class, scheduleid);
		Vehicle vehicle=(Vehicle) balancedeductDao.get(Vehicle.class, vehicleid);
		//取固定扣费不是表达式的begin
		List<Balancedeductitem> ditems = balancedeductDao.findBalancedeductite(
				orgid, departdate, schedule, vehicle, true,false);
		List<Departinvoicesdeductdetail> dvs=new ArrayList<Departinvoicesdeductdetail>();
		Balancedeductapply bp;
		boolean ischilditem;
		BigDecimal paperfee = new BigDecimal(0);// 若有按张数扣的合计到该值
		boolean isexitstationfee = false;
		for (Balancedeductitem ditem : ditems) {
			Balancedeductapply ba = balancedeductDao
					.findBalancedeductitemapply(orgid,
							departdate, schedule, vehicle, true, ditem.getId());
			if (ba == null) {
				continue;
			}

			bp = balancedeductDao.findChilddeductitemapply(
					ba.getBalancedeductitemid(), departdate, schedule,
					vehicle.getUnitid(), vehicle.getId(), true);
			Balancedeductitem bi = null;
			String deductname = "";
			if (bp == null) {
				bp = ba;
				bi = (Balancedeductitem) balancedeductDao.get(
						Balancedeductitem.class, bp.getBalancedeductitemid());
				deductname = bi.getName();
				ischilditem = false;
			} else {
				bi = (Balancedeductitem) balancedeductDao.get(
						Balancedeductitem.class, bp.getBalancedeductitemid());
				deductname = ditem.getName();
				ischilditem = true;
			}
			Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
			dv.setUpdatetime(new Date());
			dv.setBalanceapplyid(bp.getId());
			dv.setBalanceitemid(bp.getBalancedeductitemid());
			BigDecimal deductmoney = new BigDecimal(0);//总扣费
			dv.setName(deductname);
			dv.setCode(bi.getCode());
			// 若是票价组成项目
			if (bi.isIsticketpriceitem()) {	
				    //当前其中一项扣费
					BigDecimal curdectmoney = new BigDecimal(0);
					//ddt.setName(deductname);
					if (deductname.indexOf("站务费") >= 0) {
						isexitstationfee = true;
						if (ischilditem) {
							dd.setStationservicefee(bi.getDeductmoney()
									.multiply(new BigDecimal(dd.getTicketnum())));
							curdectmoney = dd.getStationservicefee();
							deductmoney = deductmoney.add(dd
									.getStationservicefee());
						} else {
							//优先从票价区间取站务费
							List<Object> stationfeeList = balancedeductDao.getStationserviceFee((dd.getPrice().toEngineeringString()));
							if((null != stationfeeList) && (stationfeeList.size() > 0)){
								curdectmoney = (BigDecimal) stationfeeList.get(0);
							}else{
								//没有设置票价区间站务费，则取固定项
								curdectmoney = balancedeductDao.qryTicketDeduct(
										 departdate, scheduleid,dd.getFromstationid(),dd.getReachstationid(),
										 deductname);
							}
							dd.setStationservicefee(curdectmoney
									.multiply(new BigDecimal(dd.getTicketnum())));
							curdectmoney = dd.getStationservicefee();
							deductmoney = deductmoney.add(dd
									.getStationservicefee());
						}
					} else {
						if (ischilditem) {
							curdectmoney = (bi.getDeductmoney()
									.multiply(new BigDecimal(dd.getTicketnum())));
						} else {
							curdectmoney = balancedeductDao.qryTicketDeduct(
									 departdate, scheduleid,dd.getFromstationid(),dd.getReachstationid(),
									 deductname);
						}
						//dd.setOthterfee(curdectmoney.multiply(new BigDecimal(dd.getTicketnum())));
						deductmoney = deductmoney.add(curdectmoney.multiply(new BigDecimal(dd.getTicketnum())));
						curdectmoney = deductmoney;
						dd.setOthterfee(dd.getOthterfee().add(deductmoney));
					}
					dv.setCode(bi.getCode());
					dv.setDeductmoney(curdectmoney);
					dvs.add(dv);
			} else {
				// 打单时其他扣费类型必须都为 0为按人扣款
				// 1为按班次扣款,2为按天扣款，3为按月扣款，4为手工输入
				if ("0".equals(bi.getDeducttype())) {
					BigDecimal curdectmoney = new BigDecimal(0);
					curdectmoney = bi.getDeductmoney().multiply(new BigDecimal(dd.getTicketnum()));
					dd.setOthterfee(dd.getOthterfee().add(curdectmoney));
					deductmoney = deductmoney.add(curdectmoney);
					dv.setCode(bi.getCode());
					dv.setDeductmoney(deductmoney);
					dvs.add(dv);
				} else if ((bi.getDeducttype().equals("7"))) {
					deductmoney = bi.getDeductmoney();
					paperfee = paperfee.add(deductmoney);
				} else {
					deductmoney = new BigDecimal(0);
				}
			}
		}			
		// 获取客运代理费
		Departinvoicesdeductdetail ds1 = null;
		if (!isexitstationfee) {
			dd.setStationservicefee(new BigDecimal(0));
		}
		List<Balanceformulaitem> balanceformulaitems = setBalanceformulaitem(dd,dvs);
		try {
			ds1 = getAgentfee(departdate, schedule, vehicle, balanceformulaitems);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		if (ds1 != null) {
			dd.setAgentfee(ds1.getDeductmoney());
		} else {
			dd.setAgentfee(new BigDecimal(0));
		}
		BigDecimal bamount = dd.getTotalamount().subtract(dd.getAgentfee())
				.subtract(dd.getStationservicefee())
				.subtract(dd.getOthterfee());
		dd.setBalanceamount(bamount);
		// 客运代理费

	}
	private Balanceformulaitem addBalanceformulaitem(String shortname,
			BigDecimal calvalue) {
		Balanceformulaitem balanceformulaitem = new Balanceformulaitem();
		balanceformulaitem.setShortname(shortname);
		balanceformulaitem.setCalValue(calvalue);
		return balanceformulaitem;
	}
	private List<Balanceformulaitem> setBalanceformulaitem(Departinvoicesotherdetail dd,List<Departinvoicesdeductdetail> dvs) {
		List<Balanceformulaitem> balanceformulaitems = new ArrayList<Balanceformulaitem>();
		balanceformulaitems
				.add(addBalanceformulaitem("A", dd.getTotalamount()));
		balanceformulaitems.add(addBalanceformulaitem("B",
				new BigDecimal(dd.getTicketnum())));// 人数
		balanceformulaitems.add(addBalanceformulaitem("K",new BigDecimal(0)));// 燃油费
		for (Departinvoicesdeductdetail ddi : dvs) {
			String shortname = balancedeductDao
					.getBalanceformulaitemShortname(ddi.getName());
				balanceformulaitems.add(addBalanceformulaitem(shortname,
						ddi.getDeductmoney()));
		}
		return balanceformulaitems;
	}
	private Departinvoicesdeductdetail getAgentfee(Date departdate,
			Schedule schedule, Vehicle vehicle,
			List<Balanceformulaitem> balanceformulaitems)
			throws ServiceException {
		Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
		BigDecimal result = new BigDecimal("0");
		String formula = "";
		// 根级公式
		Balanceformulaapply ba = balancedeductDao.getFormulaapply(departdate,
				vehicle, schedule);
		if (ba == null) {
			return null;
		}
		// 查找子扣费公式
		/*
		 * Balanceformulaapply bfa = balancedeductDao.findChildFormulaapply( ba.getBalanceformulaid(), departdate,
		 * schedule, vehicle); if (bfa != null) { ba = bfa; }
		 */
		Balanceformula bf = (Balanceformula) balancedeductDao.get(
				Balanceformula.class, ba.getBalanceformulaid());
		formula = bf.getFormula();
		for (Balanceformulaitem bi : balanceformulaitems) {
			if (!bi.getShortname().equals("") && bi.getCalValue() != null) {
				formula = formula.replaceAll(bi.getShortname(), bi
						.getCalValue().toString());
			}
		}
		for (int i = 0; i < formula.length(); i++) {
			char item = formula.charAt(i);
			if (ConstDefiniens.ITEM.indexOf(item) > 0) {
				formula = formula.replaceAll(String.valueOf(item), "0");
			}
		} 
		try {
			result = new BigDecimal(ExpressionEvaluator.evaluate(formula)
					.toString());
			result = result.divide(new BigDecimal(1), 2,
					BigDecimal.ROUND_HALF_UP);
		} catch (Exception ex) {
			play.Logger.error("扣费公式计算出现异常：" + formula);
		}
		dv.setBalanceapplyid(ba.getId());
		dv.setBalanceitemid(ba.getBalanceformulaid());
		dv.setDeductmoney(result);
		dv.setDepartdate(departdate);
		dv.setIsdeductbeforebalance(true);
		dv.setParentbalanceitemid(bf.getParentid());
		dv.setScheduleid(schedule.getId());
		dv.setStatus("0");
		dv.setType("1");// 1扣费公式 2固定扣费
		return dv;
	}
	
	@Override
	public Departinvoicesother getById(Long departinvoicesotherid) {
		return (Departinvoicesother) dao.get(Departinvoicesother.class,
				departinvoicesotherid);
	}

	@Override
	public boolean delete(long id) throws ServiceException {
		@SuppressWarnings("rawtypes")
		List<Departinvoicesotherdetail> list = dao.getResult(id);
		for (Departinvoicesotherdetail obj : list) {
			dao.del(obj);
		}
		/*
		 * if (!list.isEmpty()) { throw new ServiceException("0181"); }
		 */
		return dao.delete(Departinvoicesother.class, id);
	}

	// 根据结算车辆获取该车辆的回程结算信息
	@Override
	public List<Departinvoicesother> getInvoicesotherBalance(long balanceunitid) {
		return dao.getInvoicesotherBalance(balanceunitid);
	}

	@Override
	public List<Departinvoicesother> qryInvoicesotherBalance(String vehicleids) {
		return dao.qryInvoicesotherBalance(vehicleids);
	}

	@Override
	public List<Map<String, Object>> qrySchHelp(Date departdate, String schcode) {
		StringBuilder sql = new StringBuilder();
		Global global = CurrentUtil.getGlobal();
		List<Object> list = new ArrayList<Object>();
		if(schcode==null || schcode.length() < 1){
			Object[] fileds = { "id", "schedulename", "routeid", "routename",
					"vehicleid", "vehicleno", "departdate", "departtime",
					"worktype", "name", "worktype","unname","stationid" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, Long.class,
					String.class, Long.class, String.class, Date.class,
					String.class, String.class, String.class, String.class, String.class, Long.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, list, filedtypes);
		}
		//新增参数判断当前结算单补录是否取当天班次  参数1：取所有，0只取当天计划发班
		Query query = null;
		String flag = parameterService.findParamValue(ParamterConst.Param_4025, global.getUserinfo().getOrgid());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(flag))	{
			sql.append(
			" select s.id,s.code as schedulename,r.id as routeid,r.name as routename,v.id as vehicleid,")
			.append(" v.vehicleno,sp.departdate,trim(decode(s.islinework,0,sp.starttime,1,")
			.append(" to_char(vr.reporttime,'hh24:mi'))) as departtime,s.worktype, trim(st.name),")
			.append(" sp.worktype, u.name unname, st.id stationid")
			.append(" from Scheduleplan sp left join Vehiclereport vr on sp.id = vr.scheduleplanid and vr.isactive = '1'")
			.append("  left join Vehicle v on vr.vehicleid=v.id left join unit u on v.balanceunitid = u.id,")
			.append(" Schedule s, Schedulestatus ss,Route r,")
			.append(" station st ")
			.append(" where sp.scheduleid = s.id and sp.id = ss.scheduleplanid and ss.scheduleid = s.id ")
			.append(" and s.routeid = r.id  and st.id=sp.endstationid ")
			.append(" and (s.code like '").append(schcode)
			.append("%' or st.jianpin like '").append(schcode)
			.append("%') and sp.departdate=:departdate order by s.code, departtime");
		}else{
			sql.append(
			" select s.id,s.code as schedulename,r.id as routeid,r.name as routename,nvl(v.id,0) as vehicleid,")
			.append(" nvl(v.vehicleno,'') vehicleno ,sp.departdate,trim(decode(s.islinework,0,")
			.append(" nvl(sp.starttime,s.starttime),1,nvl(to_char(vr.reporttime, 'hh24:mi'),s.starttime))) as departtime,")
			.append(" s.worktype, trim(st.name),s.worktype, nvl(u.name,'') unname,st.id stationid  ")
			.append(" from Schedule s left join Scheduleplan sp on s.id= sp.scheduleid and sp.departdate=:departdate ")
			.append(" left join Vehiclereport vr  on sp.id=vr.scheduleplanid and  vr.isactive = '1' and vr.departdate=:departdate")
			.append(" left join Vehicle v on vr.vehicleid=v.id left join Route r on s.routeid = r.id ")
			.append(" left join station st on st.id = sp.endstationid left join unit u on v.balanceunitid = u.id ")
			.append(" where (s.code like '").append(schcode)
			.append("%' or st.jianpin like '").append(schcode)
			.append("%') and  s.isdelete=0 order by s.code,departtime");   //禅道号3134 【楚都站】结算单补录，查询班次时会显示已被删除的班次
		}
		query = dao.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		list = query.getResultList();
		Object[] fileds = { "id", "schedulename", "routeid", "routename",
				"vehicleid", "vehicleno", "departdate", "departtime",
				"worktype", "name", "worktype","unname","stationid" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, Long.class,
				String.class, Long.class, String.class, Date.class,
				String.class, String.class, String.class, String.class, String.class,Long.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, list, filedtypes);
	}

	@Override
	public boolean audit(String departinvoiceid) {
		return dao.audit(departinvoiceid);
	}

	@Override
	public boolean cancelaudit(String departinvoiceid) {
		return dao.cancelaudit(departinvoiceid);
	}
	
	//售票员手工单营收汇总表
	@Override
	public List<Map<String, Object>> querySum(List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] {"seller","num","ticketnum","totalmoney"},
				dao.querySum(propertyFilterList), new Object[] {String.class,Integer.class,Integer.class,BigDecimal.class});
		
	}
	
	//查询  结算单补录（精简）
	public List<Map<String, Object>> queryDepartinvoicesotherSimple(List<PropertyFilter> propertyFilterList){

		return ListUtil.listToMap(new Object[]{
					"id", "departinvoicesno", "vehicleid", "vehicleno",
					"scheduleid", "schedulecode", "routeid", "routename", "departdate",
					"departtime", "ticketnum", "pieces", "totalmoney", "sellerid",
					"sellername"},
				dao.queryDepartinvoicesotherSimple(propertyFilterList), 
				new Object[]{
					Long.class, String.class, Long.class, String.class,
					Long.class, String.class, Long.class, String.class, Date.class,
					String.class, Integer.class, Integer.class, BigDecimal.class, Long.class,
					String.class});
	}
	
	public Departinvoicesother saveSimple(Long routeid, Departinvoicesother departinvoicesother) throws ServiceException{
		//洮阳客运站精简版  给非空字段且不填的字段赋值
		departinvoicesother.setIsreturntrip(false);
		departinvoicesother.setIsoriginator(true);
		departinvoicesother.setSelfdepartdate(departinvoicesother.getDepartdate());
		departinvoicesother.setBalancemoney(BigDecimal.valueOf(0));
		departinvoicesother.setStationfee(BigDecimal.valueOf(0));
		departinvoicesother.setAgentfee(BigDecimal.valueOf(0));
		
		departinvoicesother.setStatus("0");	//运量单状态 0正常 2已结算 取数据字典
		
		Billtype billtype = billtypeService.findByCode(ConstDefiniens.BalanceBill);
		String departinvoicesno = departinvoicesother.getDepartinvoicesno();
		// 补零操作
		if (billtype.getTicketnolength() != departinvoicesno.length()) {
			departinvoicesno = StringUtils.strPad(departinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		departinvoicesother.setDepartinvoicesno(departinvoicesno);
		departinvoicesother.setSchedule(dao.getScheduleByRouteid(routeid));//洮阳客运站精简版 将routeid下的一个班次赋给scheduleid字段
		if (dao.qryDepartinvoicesother(departinvoicesno,departinvoicesother.getId())){
			throw new ServiceException("0385");	//
		}
		if (departinvoicesother.getId() == 0) {
			departinvoicesother=(Departinvoicesother) dao.merge(departinvoicesother);
		} else {
			Departinvoicesother other = getById(departinvoicesother.getId());
			if ("2".equals(other.getStatus())) {
				throw new ServiceException("0391");	//该结算单补录信息已经结算，请选择其它信息进行处理！
			}
			departinvoicesother.setDepartstationid(other.getDepartstationid());
			departinvoicesother.setRecordip(other.getRecordip());
			departinvoicesother.setStatus(other.getStatus());
			departinvoicesother.setRecordip(other.getRecordip());
			departinvoicesother.setBalance(other.getBalance());
			departinvoicesother.setOrgid(other.getOrgid());
			departinvoicesother.setCreateby(other.getCreateby());
			departinvoicesother.setCreatetime(other.getUpdatetime());

			departinvoicesother=(Departinvoicesother) dao.merge(departinvoicesother);
			
		}
		return departinvoicesother;
	}
	
	public boolean deletedepartinvoicesotherSimple(long id) throws ServiceException{
		return dao.delete(Departinvoicesother.class, id);
	}

	@Override
	public List<Map<String, Object>> departinvoiceisexsit(String departinvoiceno)
			throws ServiceException {
		//补零操作
		Billtype billtype = billtypeService.findByCode(ConstDefiniens.BalanceBill);
		if (billtype.getTicketnolength() != departinvoiceno.length()) {
			departinvoiceno = StringUtils.strPad(departinvoiceno,
					(int) billtype.getTicketnolength(), "0");
		}
		return ListUtil.listToMap(new Object[]{
				"isexist"},
			dao.queryInvoiceByNo(departinvoiceno), 
			new Object[]{
				 String.class});
	}
	
	//查询  结算单补录（票号）
	public List<Map<String, Object>> queryDepartinvoicesotherTicketno(List<PropertyFilter> propertyFilterList){
	if(propertyFilterList!=null && propertyFilterList.size() >0){
		for(int i=propertyFilterList.size()-1;i>=0;i--){	
			PropertyFilter propertyFilter=propertyFilterList.get(i);
			if("s!id".equals(propertyFilter.getPropertyFullName())){
				long id= (Long) propertyFilter.getMatchValue();
				if(id>0){
					String schedulecode=balancedeductDao.queryScheduleCode(id);
					PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
					propertyFilterList.remove(propertyFilter);
					propertyFilterList.add(propertyFilter_new);			
				}
			}
		}
	}
		return ListUtil.listToMap(new Object[]{
				"id", "departinvoicesno", "vehicleid", "vehicleno","reachstationid","reachstationname",
				"scheduleid", "schedulecode",  "departdate",
				"ticketnum", "prices", "totalmoney","agentfee","stationfee", 
				"seller","sellername","balanceby","balancename","createtime","othterfee",
				"balancemoney", "datafrom", "datafromname","unitname" },
				dao.queryDepartinvoicesotherTicketno(propertyFilterList), 
				new Object[]{
						Long.class, String.class, Long.class, String.class,Long.class, String.class,
						BigDecimal.class, String.class,  Date.class,
						Integer.class, BigDecimal.class,BigDecimal.class,  BigDecimal.class, BigDecimal.class,
						BigDecimal.class,String.class,BigDecimal.class,String.class,Timestamp.class,
						BigDecimal.class,BigDecimal.class,String.class,String.class,String.class});
	}
	//保存  结算单补录（票号）
	public Departinvoicesother saveTicketno(Departinvoicesother departinvoicesother,String ticketsellids) throws ServiceException{
		if (departinvoicesother.getSchedule().getId() == 0){
			departinvoicesother.setSchedule(null);
		}
		Departinvoicesother other = null;
		Departinvoicesotherdetail dd = null;
		BigDecimal reAgentfee = new BigDecimal(0);
		BigDecimal Othterfee = new BigDecimal(0);
		BigDecimal Stationfee = new BigDecimal(0);
		BigDecimal Totalmoney = new BigDecimal(0);
		long Ticketnum = 0;
		
		Billtype billtype = billtypeService.findByCode(ConstDefiniens.BalanceBill);
		String departinvoicesno = departinvoicesother.getDepartinvoicesno();
		//添加的时候跳号，修改的时候不跳号
		if (departinvoicesother.getId() == 0) {
			//票据领用记录表操作 ， 对结算单号进行调号    begin by（仉）
			String p3098 = parameterService.findParamValue(ParamterConst.Param_3089, departinvoicesother.getOrgid());
			if ("1".equals(p3098)) {
				long createby = departinvoicesother.getUpdateby();
				Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
						createby, new Long(departinvoicesno));
				String curDepartinvoicesno =departinvoicesno;
				if (billinuse == null || "2".equals(billinuse.getStatus())) {
					// 您的票据已经用完
					throw new ServiceException("0143");
				}
				// 补零操作         当前在使用的票号
				curDepartinvoicesno = String.valueOf(billinuse.getNextno()); 
				
				if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
					curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno, 
							(int) billtype.getTicketnolength(), "0");
				}
				if (!curDepartinvoicesno.equals(departinvoicesno)) {
					// 您的票据当前号码与系统的号码不一致，请重置票号！
					throw new ServiceException("0144");
				}
				//票号调号
				billinuse.setNextno(billinuse.getNextno() + 1);    
				if (billinuse.getNextno() > billinuse.getEndno()+1) {
					// 当前票段剩余票数不够打印
					throw new ServiceException("0171");
				}
				// 本次若是最后一张票据
				if (billinuse.getNextno() > billinuse.getEndno()) {
					billinuse.setStatus("2");
				}
				billinuse.setUpdateby(createby);
				billinuse.setUpdatetime(new Date());
				dao.getEntityManager().merge(billinuse);
			}   
		}
		//end by(仉)
		List<Departinvoicesotherdetail> departinvoicesotherdetails = new ArrayList<Departinvoicesotherdetail>();
		List<Departinvoicesotherdetail> newdepartinvoicesotherdetails = new ArrayList<Departinvoicesotherdetail>();
		List<Departinvoicesothersell> departinvoicesothersells = new ArrayList<Departinvoicesothersell>();
		// 补零操作
		if (billtype.getTicketnolength() != departinvoicesno.length()) {
			departinvoicesno = StringUtils.strPad(departinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		departinvoicesother.setDepartinvoicesno(departinvoicesno);
		Schedule schedule = (Schedule)dao.get(Schedule.class,departinvoicesother.getSchedule().getId());
		departinvoicesother.setSchedule(schedule);
		departinvoicesother.setStatus("0");
		departinvoicesother.setIsoriginator(schedule.getIsoriginator());
		departinvoicesother.setIsreturntrip(schedule.getIssellreturnticket());
		departinvoicesother.setDeparttime(schedule.getStarttime());
		Vehicle vehicle = (Vehicle)dao.get(Vehicle.class, departinvoicesother.getVehicleid());
		if(null == departinvoicesother.getDepartstationid()){
			departinvoicesother.setDepartstationid(schedule.getRoute().getStartstationid());
		}
		if(null == departinvoicesother.getAgentfee()){
			departinvoicesother.setAgentfee(BigDecimal.ZERO);
		}
		if(null == departinvoicesother.getStationfee()){
			departinvoicesother.setStationfee(BigDecimal.ZERO);
		}
		if(null == departinvoicesother.getOthterfee()){
			departinvoicesother.setOthterfee(BigDecimal.ZERO);
		}
		if(null == departinvoicesother.getBalanceprice()){
			departinvoicesother.setBalanceprice(BigDecimal.ZERO);
		}
		if(null == departinvoicesother.getTotalmoney()){
			departinvoicesother.setTotalmoney(BigDecimal.ZERO);
		}
		if(null == departinvoicesother.getPrice()){
			departinvoicesother.setPrice(departinvoicesother.getTotalmoney());
		}
		if(null == departinvoicesother.getBalancemoney()){
			departinvoicesother.setBalancemoney(BigDecimal.ZERO);
		}
		departinvoicesother.setPieces(departinvoicesother.getPrice().intValue());
		if(departinvoicesother.getId() == 0){
			departinvoicesother.setPieces(departinvoicesother.getPrice().intValue());
			departinvoicesother=(Departinvoicesother) dao.merge(departinvoicesother);
			other = (Departinvoicesother) dao.get(Departinvoicesother.class, departinvoicesother.getId());
		}else{
			if(!departinvoicesother.isIsdeleteticket()){
				departinvoicesotherdetails = dao.queryDepartinvoicesotherdetailById(departinvoicesother.getId(),ticketsellids.substring(0,ticketsellids.length()-1));
				departinvoicesothersells = dao.querydepartinvoicesothersells(departinvoicesother.getId(),ticketsellids.substring(0,ticketsellids.length()-1));
					for(Departinvoicesothersell ds:departinvoicesothersells){
						ticketsellids = ticketsellids.replace(ds.ticketsellid+",","");
						if(ticketsellids.equals("")){
							return departinvoicesother;
						}
					}
			}
			other = (Departinvoicesother) dao.get(Departinvoicesother.class, departinvoicesother.getId());
		}
		play.Logger.info("===========createDepartinvoicesdetailNo-=------begin="+departinvoicesotherdetails.size());
		departinvoicesotherdetails = createDepartinvoicesdetailNo(departinvoicesotherdetails,departinvoicesother,ticketsellids);
		play.Logger.info("===========createDepartinvoicesdetailNo-=------end="+departinvoicesotherdetails.size());
		if ("2".equals(other.getStatus())) {
			throw new ServiceException("0391");
		}
		//设置手工单 来源
		String datafrom = departinvoicesother.getDatafrom();
		if(CommonUtil.isNotEmptyString(datafrom)){
			other.setDatafrom(datafrom);
		}
		other.setDepartinvoicesno(departinvoicesno);
		other.setVehicleid(departinvoicesother.getVehicleid());
		other.setReachstationid(departinvoicesother.getReachstationid());
		other.setSeller(departinvoicesother.getSeller());
		other.setSchedule(schedule);
		if(null != vehicle){
			other.setBalanceunitid(vehicle.getBalanceunitid());
		}
		play.Logger.info("===========departinvoicesotherdetails.size()="+departinvoicesotherdetails.size());
		for(Departinvoicesotherdetail d :departinvoicesotherdetails){
			if(d.getId()>0){
				dao.merge(d);
				if(d.getTicketids()!=null){
					String[] ids = d.getTicketids().split(",");
					mergeDepartinvoicesothersellByticketsellids(ids,d.getId());
				}
			}else{
				dd = (Departinvoicesotherdetail) dao.merge(d);
				String[] ids = d.getTicketids().split(",");
				mergeDepartinvoicesothersellByticketsellids(ids,dd.getId());
			}
		}
		JPA.em().flush();
		newdepartinvoicesotherdetails = dao.querydepartinvoicesotherd(departinvoicesother.getId());
		if(newdepartinvoicesotherdetails.size()<1){
			newdepartinvoicesotherdetails.addAll(departinvoicesotherdetails);
		}
		for(Departinvoicesotherdetail dt:newdepartinvoicesotherdetails){
			reAgentfee = reAgentfee.add(dt.getAgentfee());
			Ticketnum = Ticketnum + dt.getTicketnum();
			Othterfee = Othterfee.add(dt.getOthterfee());
			Stationfee = Stationfee.add(dt.getStationservicefee());
			Totalmoney = Totalmoney.add(dt.getTotalamount());
		}
		other.setOthterfee(Othterfee);
		other.setStationfee(Stationfee);
		other.setTotalmoney(Totalmoney);
		other.setTicketnum(Ticketnum);
		other.setAgentfee(reAgentfee);
		other.setBalancemoney(other.getTotalmoney().subtract(other.getAgentfee()).subtract(other.getStationfee()).subtract(other.getOthterfee()));
		departinvoicesother=(Departinvoicesother) dao.merge(other);
		return departinvoicesother;
	}
	/**
	 * @Title updateTicketCheckstatusById
	 * @param tsoldids2 
	 * void 
	 * @author tianhb
	 * @date 2016年6月28日-下午7:07:36
	 * @update 
	 * @throws
	 */
	public void updateTicketCheckstatusById(List tsoldids) {
		if(null == tsoldids || tsoldids.size() == 0)	return;
		Date now = new Date();
		Long ticketsellid = null;
		Ticketsell ts = null;
//		if(null != tsoldids && tsoldids.size() > 0){
			for(int i = 0;i <= tsoldids.size() - 1 ;i++){
				ticketsellid = Long.valueOf(tsoldids.get(i).toString());
				ts = (Ticketsell)dao.get(Ticketsell.class, ticketsellid);
				if(null != ts && ts.getIschecked()){
					//设置车票状态：未检票，未打单
					ts.setCheckedby(null);
					ts.setCheckstation(null);
					ts.setChecktime(null);
					ts.setIschecked(false);
					ts.setDepartinvoices(null);
					ts.setDepartinvoicesno("");
					ts.setIsdepartinvoices(false);
					ts.setUpdatetime(now);
					dao.merge(ts);
				}
			}
//		}
	}

	/**
	 * @return 
	 * @Title qryTicketsellidByOtherid
	 * @Description 根据结算单补录 ID 查询车票ID
	 * @param departinvoicesotherdetailid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月28日-下午3:16:16
	 * @update 
	 * @throws
	 */
	public List qryTicketsellidByOtherid(Long otherid) {
		return dao.qryTicketsellidByOtherid(otherid);
	}
	/**
	 * @Title qryTicketsellidByOtherdetailid
	 * @Description 根据结算单补录明细 ID 查询车票ID
	 * @param otherdetailid
	 * @return List 
	 * @author tianhb
	 * @date 2016年6月28日-下午7:03:37
	 * @update 
	 * @throws
	 */
	public List qryTicketsellidByOtherdetailid(Long otherdetailid) {
		return dao.qryTicketsellidByOtherdetailid(otherdetailid);
	}

	/**
	 * @Title mergeDepartinvoicesothersellDyDicketsellids
	 * @Description 根据车票 ID 保存关联表数据
	 * @param ids 
	 * void 
	 * @author tianhb
	 * @date 2016年6月14日-上午9:27:04
	 * @update 
	 * @throws
	 */
	private void mergeDepartinvoicesothersellByticketsellids(String[] ids,Long departinvoicesotherid) {
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		Long userId = global.getUserinfo().getId();
		Long ticketsellid = 0L;
		Ticketsell ts = null;
		BigDecimal oldtsid = null;
		Departinvoicesother departinvoicesother = null;
		Departinvoicesotherdetail departinvoicesotherdetail = null;
		for(int i = 0;i < ids.length;i++){
			ticketsellid = Long.valueOf(ids[i]);
			dao.merge(new Departinvoicesothersell(ticketsellid,departinvoicesotherid,userId,userId));
			ts = (Ticketsell)dao.get(Ticketsell.class, ticketsellid);
			departinvoicesotherdetail = (Departinvoicesotherdetail) dao.get(Departinvoicesotherdetail.class, departinvoicesotherid);
			departinvoicesother = (Departinvoicesother) dao.get(Departinvoicesother.class, departinvoicesotherdetail.getDepartinvoicesotherid());
			Station station = (Station) dao.get(Station.class,departinvoicesother.getDepartstationid());
			Userinfo user = (Userinfo) dao.get(Userinfo.class,departinvoicesother.getCreateby());
			Departinvoices d = new Departinvoices();
			d.setId(departinvoicesother.getId());
			if(null != ts && !ts.getIschecked()){
				//设置车票已经检票，已经打单
				if(null != departinvoicesother.getSeller()){
					Userinfo ur = new Userinfo();
					ur.setId(departinvoicesother.getSeller().longValue());
					ts.setCheckedby(ur);
				}
				ts.setChecktime(now);
				ts.setIschecked(true);
				ts.setIsdepartinvoices(true);
				ts.setCheckstation(station);
				ts.setUpdatetime(now);
				ts.setDepartinvoicesno(departinvoicesother.getDepartinvoicesno());
				ts.setVehicleid(departinvoicesother.getVehicleid());
				ts.setDepartinvoicesby(user);
				ts.setDepartinvoicestime(now);
				ts.setDepartinvoices(d);
				dao.merge(ts);
			}
			//修改时判断是否有原车票被删除
			oldtsid = BigDecimal.valueOf(ticketsellid);
			if(null != tsoldids && tsoldids.size() >0){
				if(tsoldids.contains(oldtsid)){
					tsoldids.remove(oldtsid);
				}
			}
		}
	}
	/**
	 * @Title deleteDepartinvoicesothersellByDepartinvoicesotherid
	 * @Description 根据 它站运量单明细 ID 删除 关联表数据
	 * @param departinvoicesotherid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月14日-上午9:34:49
	 * @update 
	 * @throws
	 */
	public void deleteDepartinvoicesothersellByDetailid(Long departinvoicesotherdetailid){
		dao.deleteDepartinvoicesothersellByDetailid(departinvoicesotherdetailid);
	}
	/**
	 * @Title deleteDepartinvoicesothersellByDepartinvoicesotherid
	 * @Description 根据 它站运量单明细 ID 删除 关联表数据
	 * @param departinvoicesotherid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月14日-上午9:34:49
	 * @update 
	 * @throws
	 */
	public void deleteDepartinvoicesothersellByotherid(Long departinvoicesotherid){
		dao.deleteDepartinvoicesothersellByotherid(departinvoicesotherid);
	}
	
	//删除  结算单补录（票号）
	public boolean deletedepartinvoicesotherTicketno(long id) throws ServiceException{
		boolean flag =  dao.delete(Departinvoicesother.class, id);
		if(flag){
			tsoldids = qryTicketsellidByOtherid(id);
			deleteDepartinvoicesothersellByotherid(id);
			updateTicketCheckstatusById(tsoldids);
		}
		return flag;
	}
	/**
	 * @Title getTicketnoAgent
	 * @Description 获取客运代理费
	 * @param schedule
	 * @param vehicle
	 * @param dd void 
	 * @author tianhb
	 * @date 2016年7月1日-上午11:08:23
	 * @update 
	 * @throws
	 */
	public void getTicketnoAgent (Schedule schedule ,Vehicle vehicle,Departinvoicesotherdetail dd ){
		// 获取客运代理费
		Departinvoicesdeductdetail ds1 = null;
		List<Balanceformulaitem> balanceformulaitems = setTicketnoBalanceformulaitem(dd);
		try {
			ds1 = getAgentfee(new Date(), schedule, vehicle, balanceformulaitems);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		if (ds1 != null) {
			dd.setAgentfee(ds1.getDeductmoney());
		} else {
			dd.setAgentfee(new BigDecimal(0));
		}
		BigDecimal bamount = dd.getTotalamount().subtract(dd.getAgentfee())
				.subtract(dd.getOthterfee().subtract(dd.getStationservicefee()));
		dd.setBalanceamount(bamount);
		// 客运代理费
	}
	/**
	 * @Title setTicketnoBalanceformulaitem
	 * @Description 获取 结算固定扣费项目表
	 * @param dd
	 * @return 
	 * List<Balanceformulaitem> 
	 * @author tianhb
	 * @date 2016年7月1日-上午11:09:17
	 * @update 
	 * @throws
	 */
	private List<Balanceformulaitem> setTicketnoBalanceformulaitem(Departinvoicesotherdetail dd) {
		List<Balanceformulaitem> balanceformulaitems = new ArrayList<Balanceformulaitem>();
		balanceformulaitems
				.add(addBalanceformulaitem("A", dd.getTotalamount()));
		balanceformulaitems.add(addBalanceformulaitem("B",
				new BigDecimal(dd.getTicketnum())));// 人数
		balanceformulaitems.add(addBalanceformulaitem("E",
				dd.getOthterfee()));// 人数
//		balanceformulaitems.add(addBalanceformulaitem("K",new BigDecimal(0)));// 燃油费
		return balanceformulaitems;
	}
	@Override
	public List<Map<String, Object>> qryUnitHelp(long id) {
		StringBuilder sql = new StringBuilder();
		//新增参数判断当前结算单补录是否取当天班次  参数1：取所有，0只取当天计划发班
		sql.append(
		" select t.id,t.vehicleno, t.unitid,u.name as unitname,t.balanceunitid,u2.name as balancename,t.type,dd.value ")
		.append(" from Vehicle  t, Unit u, Unit u2,Digitaldictionary d,Digitaldictionarydetail dd ")
		.append(" where t.isactive = 1 and t.unitid = u.id and d.tablename = 'vehicle' and d.columnname = 'type' ")
		.append(" and dd.digitaldictionaryid = d.id and dd.code = t.type and t.balanceunitid = u2.id and t.id=:id ");
		
		Query query = dao.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		Object[] fileds = { "id", "vehicleno", "unitid", "unitname",
				"balanceunitid", "balancename", "type", "value"};// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, Long.class,String.class,
				 Long.class, String.class, String.class, String.class};// 初始化要查询的字段
		return ListUtil.listToMap(fileds, query.getResultList(), filedtypes);
	}
	public List<Departinvoicesotherdetail> createDepartinvoicesdetailNo(List<Departinvoicesotherdetail> departinvoicesotherdetails
			,Departinvoicesother departinvoicesother,String ticketsellids) throws ServiceException{
		play.Logger.info("createDepartinvoicesdetailNo="+departinvoicesotherdetails.size()+",departinvoicesother.getVehicleid()="+departinvoicesother.getVehicleid());
		for(Departinvoicesotherdetail dd:departinvoicesotherdetails){
			play.Logger.info("dd.getTicketids()=="+dd.getTicketids());
		}
		Long tickettypeid = 0L;
		boolean isexist = false;
		Date now=new Date();
		List<Ticketsell> tslist = dao.getTicketsellList(ticketsellids.substring(0,ticketsellids.length()-1));
		long departinvoicesotherid = departinvoicesother.getId();
		Vehicle vehicle = JPA.em().createQuery(" from Vehicle v where v.id = "+departinvoicesother.getVehicleid(), Vehicle.class).getSingleResult();
		for(Ticketsell ticket : tslist){
			play.Logger.info("ticket.getTicketno()=="+ticket.getTicketno());
			//判断当前输入的车票是否已经被补录过了
			Integer list = findotherdetailsellbysellid(ticket.getId());
			//若已被补录
			if(list > 0){
				//提示业务异常：XXX车票已经补录到XXXX结算单号了
				throw new ServiceException(ticket.getTicketno()+"车票已经补录到"+departinvoicesother.getDepartinvoicesno()+"结算单号了","");
			}
			
			BigDecimal reAgentfee = new BigDecimal(0);
			 //目前手工单重新计算只计算了客运代理费和总结算金额 		
			List<Balanceformulaitem> balanceformulaitems = new ArrayList<Balanceformulaitem>();				
			Balanceformulaitem balanceformulaitemA = new Balanceformulaitem();
			balanceformulaitemA.setShortname("A");
			balanceformulaitemA.setCalValue(ticket.getPrice());
			balanceformulaitems.add(balanceformulaitemA);//总金额				
			Balanceformulaitem balanceformulaitemB = new Balanceformulaitem();
			balanceformulaitemB.setShortname("B");
			balanceformulaitemB.setCalValue(new BigDecimal(1));
			balanceformulaitems.add(balanceformulaitemB);//人数				
			Balanceformulaitem balanceformulaitemE = new Balanceformulaitem();
			balanceformulaitemE.setShortname("E");
			balanceformulaitemE.setCalValue(ticket.getComputefee());
			balanceformulaitems.add(balanceformulaitemE);//其他扣费
			String formula = "";
			// 根级公式
			Balanceformulaapply ba = balancedeductDao.getFormulaapply(departinvoicesother.getDepartdate(),
					vehicle, departinvoicesother.getSchedule());
			//不为空时才计算代理费扣费
			if (ba != null) {					
				// 查找子扣费公式
				Balanceformula bf = (Balanceformula) balancedeductDao.get(
						Balanceformula.class, ba.getBalanceformulaid());
				formula = bf.getFormula();
				for (Balanceformulaitem bi : balanceformulaitems) {
					if (!bi.getShortname().equals("") && bi.getCalValue() != null) {
						formula = formula.replaceAll(bi.getShortname(), bi.getCalValue().toString());
					}
				}
				for (int i = 0; i < formula.length(); i++) {
					char item = formula.charAt(i);
					if (ConstDefiniens.ITEM.indexOf(item) > 0) {
						formula = formula.replaceAll(String.valueOf(item), "0");
					}
				}
				reAgentfee = new BigDecimal(ExpressionEvaluator.evaluate(formula).toString());
				reAgentfee = reAgentfee.divide(new BigDecimal(1), 2,BigDecimal.ROUND_HALF_UP);
			}
			tickettypeid = dao.queryTicketTypeByTypeCode(ticket.getTickettype());
			isexist = false;
			for (Departinvoicesotherdetail dd : departinvoicesotherdetails) {
				play.Logger.info("for Departinvoicesotherdetail()");
				// 起点站、到达站、票种、票价都相等才归一类
				if (dd.getFromstationid() == ticket.getDepartstationid()
						&& dd.getReachstationid() == ticket.getReachstationid()
						&& dd.getTickettypeid()==tickettypeid) {
					dd.setTicketnum(dd.getTicketnum() + 1);
					dd.setStationservicefee(dd.getStationservicefee().add(ticket.getStationservicefee()));
					if(dd.getTicketids()!=null){
						dd.setTicketids(dd.getTicketids() + ticket.getId() + ",");
					}else{
						dd.setTicketids(ticket.getId() + ",");
					}
					dd.setOthterfee(dd.getOthterfee().add(ticket.getComputefee()));
					dd.setTotalamount(dd.getTotalamount().add(ticket.getPrice()));
					dd.setBalanceamount(dd.getBalanceamount().add(ticket.getPrice().subtract(ticket.getOtherfee()).subtract(ticket.getStationservicefee()).subtract(reAgentfee)));
					dd.setAgentfee(dd.getAgentfee().add(reAgentfee));
					isexist = true;
				}
			}
			play.Logger.info("isexist="+isexist);
			if (!isexist) {			
				play.Logger.info("new Departinvoicesotherdetail()");
				Departinvoicesotherdetail departinvoicesotherdetail = new Departinvoicesotherdetail();
				departinvoicesotherdetail.setTicketids(ticket.getId() + ",");
				departinvoicesotherdetail.setBalanceamount(ticket.getPrice().subtract(ticket.getOtherfee()).subtract(ticket.getStationservicefee()).subtract(reAgentfee));
				departinvoicesotherdetail.setCreateby(departinvoicesother.getCreateby());
				departinvoicesotherdetail.setCreatetime(now);
				departinvoicesotherdetail.setDepartdate(ticket.getDepartdate());
				departinvoicesotherdetail.setDeparttime(ticket.getDeparttime());
				departinvoicesotherdetail.setDistance(ticket.getDistance());
				departinvoicesotherdetail.setFromstationid(ticket.getDepartstationid());
				departinvoicesotherdetail.setOthterfee(ticket.getComputefee());
				departinvoicesotherdetail.setPrice(ticket.getPrice());
				departinvoicesotherdetail.setReachstationid(ticket.getReachstationid());
				departinvoicesotherdetail.setSchedule(departinvoicesother.getSchedule());
				departinvoicesotherdetail.setStationservicefee(ticket.getStationservicefee());
				departinvoicesotherdetail.setStatus("0");
				departinvoicesotherdetail.setTicketnum(1);
				departinvoicesotherdetail.setTickettypeid(tickettypeid);
				departinvoicesotherdetail.setTotalamount(ticket.getPrice());
				departinvoicesotherdetail.setUpdateby(departinvoicesother.getCreateby());
				departinvoicesotherdetail.setUpdatetime(now);
				departinvoicesotherdetail.setBalanceprice(ticket.getPrice());//结算票价
				departinvoicesotherdetail.setDepartinvoicesotherid(departinvoicesotherid);
				departinvoicesotherdetail.setAgentfee(reAgentfee);
				departinvoicesotherdetails.add(departinvoicesotherdetail);
				play.Logger.info("new Departinvoicesotherdetail()"+departinvoicesotherdetails.size());
			}
		}
		return departinvoicesotherdetails;
	}
	/**
	 * 根据售票Id和手工单明细id删除票号
	 * @return
	 */
	@Override
	public void deleteByticketidAndDepartinvoicesdeatilid(Long departinvoicesotherid) {
		List<Departinvoicesotherdetail> departinvoicesotherdetails = new ArrayList<Departinvoicesotherdetail>();
		List list = null;
		Departinvoicesother other = (Departinvoicesother) dao.get(Departinvoicesother.class,departinvoicesotherid);
		other.setBalancemoney(new BigDecimal(0));
		other.setAgentfee(new BigDecimal(0));
		other.setOthterfee(new BigDecimal(0));
		other.setStationfee(new BigDecimal(0));
		other.setTotalmoney(new BigDecimal(0));
		other.setTicketnum(0);
		other.setId(departinvoicesotherid);
		dao.merge(other);
		departinvoicesotherdetails = dao.queryDepartinvoicesotherdetailById(departinvoicesotherid);
		for(Departinvoicesotherdetail d:departinvoicesotherdetails){
				dao.delete(Departinvoicesotherdetail.class,d.getId());
				list = dao.qryTicketsellidByOtherdetailid(d.getId());
				updateTicketCheckstatusById(list);
				deleteDepartinvoicesellByticketid(list);//删除售票关联表数据
		}
	}

	private void deleteDepartinvoicesellByticketid(List tsoldids) {
		if(null == tsoldids || tsoldids.size() == 0)	return;
		String ticketsellid = "";
		for(int i = 0;i <= tsoldids.size() - 1 ;i++){
			if(ticketsellid.equals("")){
				ticketsellid = tsoldids.get(i).toString();
			}else{
				ticketsellid = ticketsellid +","+ tsoldids.get(i).toString();
			}
		}
		dao.deleteDepartinvoicesellByticketid(ticketsellid);
		
	}
	
	private Integer findotherdetailsellbysellid(Long sellid){
		return	dao.findotherdetailsellbysellid(sellid);
	}

	@Override
	public List<Map<String,Object>> checkdepartinvoicesell(Long departinvoicesotherid) {
		return ListUtil.listToMap(new Object[]{Departinvoicesothersell.class},
				dao.checkdepartinvoicesell(departinvoicesotherid)
				,new Object[]{Departinvoicesothersell.class
		});
	}
}

