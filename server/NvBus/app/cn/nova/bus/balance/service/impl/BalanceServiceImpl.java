package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.Query;

import org.wltea.expression.ExpressionEvaluator;


import models.ActionNode;
import play.db.jpa.JPA;
import util.Appvar;
import util.CommonUtil;
import util.CurrentUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.balance.dao.BalanceDao;
import cn.nova.bus.balance.dao.BalancedeductDao;
import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.model.Balancescheduleminimum;
import cn.nova.bus.balance.model.Balancestationdeduct;
import cn.nova.bus.balance.model.Balanceunitdeduct;
import cn.nova.bus.balance.model.Balancevehicleagentrate;
import cn.nova.bus.balance.model.Balancevehiclededuct;
import cn.nova.bus.balance.model.ScheduleLostTreatments;
import cn.nova.bus.balance.model.VehicleParkFee;
import cn.nova.bus.balance.model.Vehicleturnover;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.balance.service.BalanceService;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.BalancedeductitemService;
import cn.nova.bus.balance.vo.CalculateItem;
import cn.nova.bus.balance.vo.OtherBalanceinfo;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BillinventoryService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BillinventoryServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.dao.DepartinvoicesotherDao;
import cn.nova.bus.checkticket.dao.DepartinvoicesotherdetailDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.service.DepartinvoicesotherService;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesotherServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.dispatch.service.VehiclelateService;
import cn.nova.bus.dispatch.service.VehiclelostService;
import cn.nova.bus.dispatch.service.impl.VehiclelateServiceImpl;
import cn.nova.bus.dispatch.service.impl.VehiclelostServiceImpl;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.util.PluginFunctionUtil;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalanceServiceImpl implements BalanceService {

	
	private BalanceDao balanceDao = new BalanceDao();
	
	private BalancedeductDao balancedeductDao = new BalancedeductDao();
	
	private VehiclelateService vehiclelateService = new VehiclelateServiceImpl();
	
	private VehiclelostService vehiclelostService = new VehiclelostServiceImpl();
	
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();

	
	private BalancedeductitemService balancedeductitemService = new BalancedeductitemServiceImpl();

	
	private DepartinvoicesotherService departinvoicesotherService = new DepartinvoicesotherServiceImpl();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	public BillinventoryService billinventoryService = new BillinventoryServiceImpl();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private UserTransaction usertransaction = new UserTransaction();

	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	@Override
	public List<Map<String, Object>> createTree(long orgid) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code",
				"arealevel", "pcode" }, balanceDao.createTree(orgid),
				new Object[] { Long.class, String.class, String.class,
						Integer.class, String.class });
	}

	@Override
	public boolean genBalanceData(Date fromdepart, Date todepart,
			String invoinceids, long createby) throws ServiceException {
		long a = System.currentTimeMillis();
		List<Departinvoices> dis = balanceDao.qryInvoinces(fromdepart,
				todepart, invoinceids);
		long b = System.currentTimeMillis();
		System.out.println(b - a);
		for (Departinvoices di : dis) {
			// 生成结算扣费数据
			balancedeductService.genOthterfee(di, createby,0);
			// 生成班次保底信息
			/*
			 * Scheduleminimum sm = scheduleminimumService.getScheduleminimum( di.getScheduleid(), di.getVehicleid());
			 * if (sm != null) { if (di.getTicketnum() < sm.getNum()) { Balancescheduleminimum bs = new
			 * Balancescheduleminimum(); BigDecimal lessmoney = new BigDecimal(0); bs.setCreateby(createby);
			 * bs.setCreatetime(new Date()); bs.setDepartinvoicesid(di.getId()); bs.setDepartdate(di.getDepartdate());
			 * Ticketprice ticketprice = balanceDao.qryTicketprice(di); bs.setFullprice(ticketprice.getFullprice());
			 * long lessnum = sm.getNum() - di.getTicketnum(); bs.setLessnum(lessnum); lessmoney =
			 * ticketprice.getFullprice().multiply( new BigDecimal(lessnum)); bs.setLessmoney(lessmoney);
			 * bs.setMinimum(sm.getNum()); bs.setScheduleid(di.getScheduleid()); bs.setUpdateby(createby);
			 * bs.setUpdatetime(new Date()); bs.setVehicleid(di.getVehicleid());
			 * balanceDao.getEntityManager().merge(bs); } }
			 */
		}
		String packfeededuct = parameterService.findParamValue(ParamterConst.Param_8020, null);
		// 行包扣费进行结算
		if (packfeededuct.equals(ParamterConst.COMMON_FLAG.FALG_YES) && dis.size() > 0) {
			long vehicleid = dis.get(0).getVehicleid();
			long balanceunitid = dis.get(0).getBalanceunitid();
			Schedule schedule = (Schedule) balanceDao.get(Schedule.class, dis
					.get(0).getScheduleid());
			long orgid = schedule.getOrgid();
			BigDecimal packfee = balanceDao.qryPackBalance(vehicleid,
					fromdepart, todepart);
			Balancedeductdetail bd = balanceDao.qryPackDeduct(vehicleid, orgid);
			if (bd == null) {
				bd = new Balancedeductdetail();
				bd.setCreateby(createby);
				bd.setCreatetime(new Date());
			}
			if (packfee!=null&&packfee.compareTo(BigDecimal.ZERO) > 0) {
				Balancedeductitem bi = balancedeductitemService
						.savePackDuctitem(createby, orgid);
				bd.setBalancedeductitemid(bi.getId());
				bd.setBalanceunitid(balanceunitid);
				bd.setBalancevehicleid(vehicleid);
				bd.setName(bi.getName());
				bd.setOrgid(orgid);
				bd.setDeductmoney(packfee);
				bd.setDivdedeductmoney(new BigDecimal(0));
				bd.setStatus("0");
				bd.setUpdateby(createby);
				bd.setUpdatetime(new Date());
				balanceDao.save(bd);
			}
		}
		long c = System.currentTimeMillis();
		System.out.println(c - b);
		return true;
	}
	
	public boolean genBalanceData(Date fromdapart, Date todapart,
			String invoinceids, Global global) throws ServiceException{
		long createby = global.getUserinfo().getId();
		List<Departinvoices> dis = balanceDao.qryInvoinces(fromdapart,
				todapart, invoinceids);
		List <Balancedeductdetail> balancedeductdetaillist =null ;
		List<Departinvoicesother> diso = balanceDao.qryDepartinvoicesother(fromdapart,
				todapart, invoinceids);
		long balanceunitid = 0;
		String[] invoinceidsList = invoinceids.split(",");
		if(dis!=null&&dis.size()>0){
			//取第一个结算单位,上面的查询没有次序，需要按照invoinceids中的第一个为准
			long dvid = Long.valueOf(invoinceidsList[0]); 
			Departinvoices dv = (Departinvoices)balanceDao.get(Departinvoices.class,dvid);
			if(dv!=null){
				balanceunitid = dv.getBalanceunitid();
			}else{
				Departinvoicesother dvo =  (Departinvoicesother)balanceDao.get(Departinvoicesother.class,dvid);
				balanceunitid = dvo.getBalanceunitid();
			}
		}else{
			if(diso!=null&&diso.size()>0){//如果只有手工单，则取第一个的结算单位
				for (Departinvoicesother dother : diso) {
					if(dother.getId() == Long.valueOf(invoinceidsList[0])){
						balanceunitid = dother.getBalanceunitid();
						break;
					}
				}
				
			}
		}
		for (Departinvoicesother di : diso) {
			Departinvoices d=new Departinvoices();
			d.setTotalamount(di.getTotalmoney());
			d.setStationservicefee(di.getStationfee());
			d.setAgentfee(di.getAgentfee());
			d.setBalance(di.getBalance());
			d.setBalanceunitid(di.getBalanceunitid());
			d.setBalancestation(di.getBalancestation());
			d.setDepartinvoicesno(di.getDepartinvoicesno());
			d.setDepartstationid(di.getDepartstationid());
			d.setScheduleid(di.getSchedule().getId());
			d.setVehicleid(di.getVehicleid());
			d.setDepartdate(di.getDepartdate());
			d.setTicketnum(di.getTicketnum());
			d.setPrintorgid(di.getOrgid());
			dis.add(d);
		}
		
		for (Departinvoices di : dis) {
			// 生成结算扣费数据
//			Departinvoices departinvoiceblanceunitid = dis.get(0);
			balancedeductdetaillist = balancedeductService.genOthterfee(di, createby,balanceunitid);
		}
//		for(int i=0;i<balancedeductdetaillist.size();i++)
//		{
//			balancedeductdetaillist.get(i).setDeductmoney(balancedeductdetaillist.get(i).getDeductmoney().setScale(2, BigDecimal.ROUND_HALF_UP));
//			balancedeductDao.merge(balancedeductdetaillist.get(i));
//			balancedeductDao.getEntityManager().flush(); 
//		}

		//20160810 九江客运站：生成停车费
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!code", "cltcffee"));
		List list = balancedeductDao.find(Balancedeductitem.class, propertyFilters);
		if(list != null && list.size() > 0){
			Balancedeductitem parkFeeItem = (Balancedeductitem) list.get(0);//停车费扣费项
			String curids = "";
			BigDecimal parkfee = BigDecimal.ZERO;
			
			//避免结算结算单条数过多
			while (invoinceids.length() > 0) {
				if (invoinceids.length() > 1000) {
					curids = invoinceids.substring(0, 980);
					curids = curids.substring(0, curids.lastIndexOf(","));
					invoinceids = invoinceids.substring(curids.length() + 1,
							invoinceids.length());
				} else {
					curids = invoinceids;
					invoinceids = "";
				}
				parkfee = parkfee.add(balancedeductDao.qryVehicleParkFee(fromdapart, todapart, curids, global.getOrganization().getId()));
			}
//			List<VehicleParkFee> parkfee = balancedeductDao.qryVehicleParkFee(fromdapart, todapart, invoinceids, global.getOrganization().getId());
			if(parkfee.compareTo(BigDecimal.ZERO) > 0){//有停车费才生成扣费明细
				Balancedeductdetail parkfeeDetail = new Balancedeductdetail();
				parkfeeDetail.setBalancedeductitemid(parkFeeItem.getId());
				parkfee = parkfee.divide(BigDecimal.ONE, 2, BigDecimal.ROUND_HALF_UP);// 取两位小数
				parkfeeDetail.setDeductmoney(parkfee);
				parkfeeDetail.setBalanceunitid(balanceunitid);
				parkfeeDetail.setStatus("0");
				parkfeeDetail.setOrgid(global.getOrganization().getId());
				parkfeeDetail.setCreateby(global.getUserinfo().getId());
				parkfeeDetail.setCreatetime(new Date());
				parkfeeDetail.setUpdateby(global.getUserinfo().getId());
				parkfeeDetail.setUpdatetime(new Date());
				parkfeeDetail.setDivdedeductmoney(BigDecimal.ZERO);
				parkfeeDetail.setBalancevehicleid(null);
				parkfeeDetail.setDeductitemname(null);
				balancedeductDao.merge(parkfeeDetail);
			}
		}
		
		String packfeededuct = parameterService.findParamValue(ParamterConst.Param_8020, global.getUserinfo().getOrgid());
		// 行包扣费进行结算
		if (packfeededuct.equals(ParamterConst.COMMON_FLAG.FALG_YES) && dis.size() > 0) {
			long vehicleid = dis.get(0).getVehicleid();
//			long balanceunitid = dis.get(0).getBalanceunitid();
			Schedule schedule = (Schedule) balanceDao.get(Schedule.class, dis
					.get(0).getScheduleid());
			long orgid = schedule.getOrgid();
			BigDecimal packfee = balanceDao.qryPackBalance(vehicleid,
					fromdapart, todapart);
			if(packfee==null){
				packfee=BigDecimal.ZERO;
			}
			List<Pack> packlist = balanceDao.getPack(vehicleid, fromdapart, todapart);
			if (packfee.compareTo(BigDecimal.ZERO) >= 0 && packlist.size() > 0 && packlist.get(0) != null) {
				for (Pack pack : packlist) {
					if (pack.getScheduleid() != null  && pack.getScheduleid() != schedule.getId()) {
						BigDecimal fee = pack.getPackfee().add(pack.getHandfee()).add(pack.getCustodial())
								.add(pack.getTransitfee()).add(pack.getInsurancefee()).add(pack.getInsurance())
								.add(pack.getDeliveryfee()).add(pack.getOtherfee());
						packfee = packfee.subtract(fee);
					}
				}
			}
			Balancedeductdetail bd = balanceDao.qryPackDeduct(vehicleid, orgid);
			if (bd == null) {
				bd = new Balancedeductdetail();
				bd.setCreateby(createby);
				bd.setCreatetime(new Date());
			}
			if (packfee!=null&&packfee.compareTo(BigDecimal.ZERO) > 0) {
				Balancedeductitem bi = balancedeductitemService
						.savePackDuctitem(createby, orgid);
				bd.setBalancedeductitemid(bi.getId());
				bd.setBalanceunitid(balanceunitid);
				bd.setBalancevehicleid(vehicleid);
				bd.setName(bi.getName());
				bd.setOrgid(orgid);
				bd.setDeductmoney(packfee);
				bd.setDivdedeductmoney(new BigDecimal(0));
				bd.setStatus("0");
				bd.setUpdateby(createby);
				bd.setUpdatetime(new Date());
				balanceDao.save(bd);
			}
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delBalanceData(Date fromdapart, Date todapart,
			String invoinceids) throws ServiceException {
		List<Departinvoicesdeductdetail> dds = balanceDao
				.qryDepartinvoicesdeductdetail(fromdapart, todapart,
						invoinceids);
		for (Departinvoicesdeductdetail dd : dds) {
			balanceDao.del(dd);
		}
		List<Balancedeductdetail> bds = balanceDao.qryBalancedeductdetail("("
				+ invoinceids + ")");
		for (Balancedeductdetail dd : bds) {
			balanceDao.delete(dd);
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> qryDepartinvoices(
			List<PropertyFilter> propertyFilterList, String invoinceids,String orgids,int departinvoicestype) {
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
			PropertyFilter propertyFilter=propertyFilterList.get(i);
			if("s!id".equals(propertyFilter.getPropertyFullName())){
				long id= (Long) propertyFilter.getMatchValue();
				if(id>0){
					String schedulecode=balanceDao.queryScheduleCode(id);
					PropertyFilter propertyFilter_new =new PropertyFilter("EQS_s!code",schedulecode);
					propertyFilterList.remove(propertyFilter);
					propertyFilterList.add(propertyFilter_new);			
				}
			}
			}
		}
		return ListUtil.listToMap(new Object[] { "isaudit","routename", "id",
				"endstation", "departinvoicesno", "departdate", "code",
				"departtime", "ticketnum", "totalamount", "balanceamount",
				"printname", "printtime", "unitname", "vehicleno",
				"stationservicefee", "fueladditionfee", "agentfee",
				"othterfee", "supplyticketnum", "supplyamount",
				"supplybalanceamount", "status", "vehicleid", "routeid",
				"balanceunitid", "balanceunitname","iscomputerno","departinvoicetypename",
				"vehicleUnitFullName","balanceUnitFullName","datafrom","pieces","balanceno" },
				balanceDao.qryDepartinvoices(propertyFilterList, invoinceids,orgids,departinvoicestype),
				new Object[] { Integer.class,String.class, Long.class, String.class,
						String.class, Date.class, String.class, String.class,
						Integer.class, BigDecimal.class, BigDecimal.class,
						String.class, Timestamp.class, String.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, Integer.class,
						BigDecimal.class, BigDecimal.class, String.class,
						Long.class, Long.class, Long.class, String.class,Integer.class,String.class,
						String.class,String.class,String.class,Integer.class,String.class});
	}

	@Override
	public List<Map<String, Object>> qryInvoicesdeductdetail(
			long departinvoicesid) {
		return ListUtil
				.listToMap(new Object[] { "deducttype", "name",
						"isdeductbeforebalance", "deductmoney", "target",
						"startdate", "enddate" },
						balanceDao.qryInvoicesdeductdetail(departinvoicesid),
						new Object[] { String.class, String.class,
								boolean.class, BigDecimal.class, String.class,
								Date.class, Date.class });
	}

	@Override
	public List<Map<String, Object>> qryInvoicesdeductdetail(String invoicesids) {
		return ListUtil.listToMap(new Object[] { "id", "departinvoicesno",
				"name", "deductmoney", "isticketpriceitem" },
				balanceDao.qryInvoicesdeductdetail(invoicesids), new Object[] {
						Long.class, String.class, String.class,
						BigDecimal.class, boolean.class });
	}

	/*
	 * qryOtherBalance方法：<br/> <br/>
	 * 
	 * @param orgid
	 * 
	 * @param fromdepart
	 * 
	 * @param todepart
	 * 
	 * @param vehicleids
	 * 
	 * @param balanceobject
	 * 
	 * @param objectid
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#qryOtherBalance(long, java.util.Date, java.util.Date,
	 * java.lang.String, java.lang.String, long)
	 * 
	 * @exception
	 */
	@Override
	public OtherBalanceinfo qryOtherBalance(long orgid, Date fromdepart,
			Date todepart, String vehicleids, String balanceobject,
			long objectid, String invoicesids,Global global) {
		OtherBalanceinfo ob = new OtherBalanceinfo();
		vehicleids = "(" + vehicleids + ")";
		
		ActionNode actionNode = Appvar.routes.get("SCHEDULELOSTTREATMENT");//判断是否有插件【班次晚点脱班管理】
		// 晚点信息
		BigDecimal lateforfeit = new BigDecimal(0);
		// 脱班信息
		BigDecimal lostforfeit = new BigDecimal(0);
		String sltId = null;
		if (actionNode == null) {
			//晚点
			lateforfeit = vehiclelateService.qryVehiclelatesDeduct(fromdepart,
					todepart, vehicleids);
			//脱班
			lostforfeit = vehiclelostService.getVehiclelostDeduct(fromdepart,
					todepart, vehicleids);
		} else {
			//脱班
			Object[] objlate = vehiclelostService.qryScheduleLostTreatment(fromdepart,
					todepart, vehicleids, "2"); //晚点
			if (objlate != null) {
				sltId = (String)objlate[0];    //脱班晚点罚金表的id
				lateforfeit = (BigDecimal)objlate[1]; //晚点罚金
			}
			Object[] objlost = vehiclelostService.qryScheduleLostTreatment(fromdepart,
					todepart, vehicleids, "4"); //脱班
			if (objlost != null) {
				if (sltId == null) {
					sltId = (String)objlost[0];    //脱班晚点罚金表的id
				} else {
					sltId = sltId + "," + (String)objlost[0]; 
				}
				lostforfeit = (BigDecimal)objlost[1];  //脱班罚金
			}
		}
		ob.setSltId(sltId);
		ob.setLateforfeit(lateforfeit);  //晚点
		ob.setLostforfeit(lostforfeit);  //脱班
		// 回程结算金额
		BigDecimal balancemoney = new BigDecimal(0);
		long returnpeople = 0;
		List<Departinvoicesother> dis = departinvoicesotherService
				.getInvoicesotherBalance(objectid);
		for (Departinvoicesother d : dis) {
			balancemoney = balancemoney.add(d.getBalancemoney());
			returnpeople = returnpeople + d.getTicketnum();
		}
		ob.setBalancemoney(balancemoney);
		ob.setReturnpeople(returnpeople);
		// 上次结帐溢欠款(车方欠车站)
		Balance ba = balanceDao.qryLastBalance(orgid, objectid);
		if (ba == null) {
			ob.setLastlost(new BigDecimal(0));
		} else {
			ob.setLastlost(ba.getLost());
		}
		// 班次保底信息
		long minpeople = 0;
		long lessnum = 0;
		BigDecimal lessmoney = new BigDecimal(0);
		/*
		 * List<Balancescheduleminimum> bslist = balanceDao .qryBalancescheduleminimum(invoicesids); for
		 * (Balancescheduleminimum bs : bslist) { minpeople = minpeople + bs.getMinimum(); lessnum = lessnum +
		 * bs.getLessnum(); lessmoney = lessmoney.add(bs.getLessmoney()); }
		 */
		ob.setMinpeople(minpeople);
		ob.setLessnum(lessnum);
		ob.setLessmoney(lessmoney);
		// 车辆预缴款
		BigDecimal preupmoney = new BigDecimal(0);
		// 若是结算单位结算
		if (balanceobject.equals("0")) {
			List<Vehicleturnover> vos = balanceDao.qryVehicleturnover(
					vehicleids, orgid);
			for (Vehicleturnover vo : vos) {
				preupmoney = preupmoney.add(vo.getMoney());
			}
		} else {
			List<Vehicleturnover> vos = balanceDao.qryVehicleturnover(
					vehicleids, orgid);
			for (Vehicleturnover vo : vos) {
				preupmoney = preupmoney.add(vo.getMoney());
			}
		}
		ob.setPreupmoney(preupmoney);
		ob.setIntegralmoney(new BigDecimal(0));
		//参数4008，营运车辆违规结算模块，违规结算类型，0罚金，1暂扣款，默认为0
		String p4008 = parameterService.findParamValue(ParamterConst.Param_4008,
				global.getUserinfo().getOrgid());
		if ("0".equals(p4008)) {
			BigDecimal totalViolation = new BigDecimal(0);
			//根据结算单ID查询所对应的违规罚金,invoicesids
			List<Vehicleviolation> vehicleviolationlist = balanceDao.qryVehicleviolationByInvoicesid(invoicesids);
			if (vehicleviolationlist != null) {
				for (Vehicleviolation vehicleviolation : vehicleviolationlist) {			
					//vehicleviolation.setStatus("1");    //将该车对应状态为“已打单”的违规记录更新为“已罚款”状态
					//vehicleviolation.setUpdateby(global.getUserinfo().getId());
					//vehicleviolation.setUpdatetime(new Date());
					totalViolation=totalViolation.add(vehicleviolation.getDebit());
					//balanceDao.merge(vehicleviolation);          //更新到表中
				}
				ob.setDebit(totalViolation);  //违规罚金的获取
			}
		}else{
			ob.setDebit(balanceDao.qryVehicleviolation(vehicleids, orgid));
		}
		Balance lstb = balanceDao.qryLastBalance(orgid, objectid);
		if (lstb != null) {
			ob.setBackmoney(lstb.getDebit());
		}
		BigDecimal packfee = new BigDecimal(0);
		// balanceDao.qryPackBalance(orgid,vehicleids,fromdepart,todepart);
		ob.setPackfee(packfee);
		return ob;
	}

	/*
	 * invoicesBalance方法实现结算单结算：<br/> <br/>
	 * 
	 * @param balanceobject
	 * 
	 * @param objectid
	 * 
	 * @param invoicesids
	 * 
	 * @param dds
	 * 
	 * @param global
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#invoicesBalance(java.lang. String, long, java.lang.String,
	 * java.util.List, cn.nova.bus.security.Global)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Balance invoicesBalance(Balance balance, int balancetype,
			String invoicesids, String vehicleids,
			List<Balancedeductdetail> dds, Global global,String otherinvoicesids, Date qryfromdate, Date qrytodate, String schedulelosttreatmentIds)
			throws ServiceException {
		Billtype billtype = billtypeService
				.findByCode(ConstDefiniens.AccountBill);
		//4069 :结算单结算是否需要领用结算通知单，0不需要，1需要，默认0
		
		String p4069 = parameterService.findParamValue(ParamterConst.Param_4069,
				global.getUserinfo().getOrgid());
		Billinuse billinuse = null;
		String balanceno = null;
		//0：走原来的逻辑 直接使用票库票号  1：需要用户领用结算通知单票据
		if (CommonUtil.isNotEmptyString(p4069) && p4069.equals("1")) {//领用票据
			balanceno = balance.getBalanceno();
			if (CommonUtil.isEmptyString(balanceno)) { // 1：需要用户领用结算通知单票据， balanceno前台传的空
				// 您的票据当前号码与系统的号码不一致，请重置票号！
				throw new BusinessException("您的票据当前号码与系统的号码不一致，请重置票号！");
			}
			billinuse = billinuseService.getBilluse(billtype.getId(),
					global.getUserinfo().getId(), new Long(balanceno));
			if (billinuse == null || "2".equals(billinuse.getStatus())) {
				// 您的票据已经用完
				throw new BusinessException("您的票据已经用完");
			}
			
			// 前台传的结算通知单号补零操作
			if (billtype.getTicketnolength() != balance.getBalanceno().length()) {
				balanceno = StringUtils.strPad(balanceno,
									(int) billtype.getTicketnolength(), "0");
			}
			// 数据库nextno
			String nextno = String.valueOf(billinuse.getNextno());
			
			//数据库nextno 补零操作
			if (billtype.getTicketnolength() != nextno.length()) {
				nextno = StringUtils.strPad(nextno,
						(int) billtype.getTicketnolength(), "0");
			}
			if (!nextno.equals(balanceno)) {
				// 您的票据当前号码与系统的号码不一致，请重置票号！
				throw new BusinessException("您的票据当前号码与系统的号码不一致，请重置票号！");
			}
			//判断是否存在这个结算通知单号
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQS_t!balanceno", balanceno));
			propertyFilters.add(new PropertyFilter("EQL_t!orgid", balance.getOrgid()));
			List<Balance> list = balanceDao.find(Balance.class, propertyFilters);
			if (list!=null && list.size()>0) {
				// 该结算通知单号已经存在！
				throw new BusinessException("该结算通知单号已经存在！");
			}
			if (billinuse.getNextno() > billinuse.getEndno()+1) {
				// 当前票段剩余票数不够使用
				throw new BusinessException("当前票段剩余票数不够使用");
			}
		}else{
			Billinventory bt = billinventoryService.qryBillinventory(global
					.getOrganization().getId(), ConstDefiniens.AccountBill);
			if (bt == null) {
				// 您的票据已经用完
				throw new ServiceException("0143");
			}
			if (bt.getAvailableenno() < bt.getAvailablestartno()) {
				// 您的票据已经用完
				throw new ServiceException("0143");
			}
			balanceno = String.valueOf(bt.getAvailablestartno());
			// 取号后直接提交，避免并发
			if (bt.getAvailablestartno() <= bt.getAvailableenno()) {
				bt.setAvailablestartno(bt.getAvailablestartno() + 1);
				bt.setUpdateby(global.getUserinfo().getId());
				bt.setUpdatetime(new Date());
				balanceDao.getEntityManager().merge(bt);
			}
		}
		
		// 补零操作
		if (billtype.getTicketnolength() != balanceno.length()) {
			balanceno = StringUtils.strPad(balanceno,
				(int) billtype.getTicketnolength(), "0");
		}
		if (balanceDao.isExistBalancedeNo(balanceno)) {
			// 该结算通知单号已经存在
			throw new ServiceException(balanceno, "0392");
		}

		

		BigDecimal preupmoney = new BigDecimal(0);
		List<Vehicleturnover> vos;
		// 根据结算单位结算
		if (balance.getBalanceobject().equals("0")) {
			vos = balanceDao.qryVehicleturnover("(" + vehicleids + ")",
					balance.getOrgid());
			for (Vehicleturnover vo : vos) {
				preupmoney = preupmoney.add(vo.getMoney());
			}
		} else {
			vos = balanceDao.qryVehicleturnoverBycontractor(
					balance.getObjectid(), balance.getOrgid());
			for (Vehicleturnover vo : vos) {
				preupmoney = preupmoney.add(vo.getMoney());
			}
		}
		if (preupmoney.compareTo(balance.getPreupmoney()) != 0) {
			// 车辆预缴款金额发生变动，请重新查询
			throw new ServiceException("0315");
		}
		// 更新客运代理费比例
		String vehicles[] = vehicleids.split(",");
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		for (String vehid : vehicles) {
			filters.clear();
			filters.add(new PropertyFilter("EQL_t!vehicleid", new Long(vehid)));
			filters.add(new PropertyFilter("EQL_t!orgid", global
					.getOrganization().getId()));
			List<Balancevehicleagentrate> lists = balanceDao
					.qryBalancevehicleagentrate(filters);
			if (lists != null && lists.size() > 0) {
				Balancevehicleagentrate bv = lists.get(0);
				bv.setAgentrate(balance.getAgentrate());
				bv.setUpdateby(global.getUserinfo().getId());
				bv.setUpdatetime(new Date());
				balanceDao.merge(bv);
			} else {
				Balancevehicleagentrate bv = new Balancevehicleagentrate();
				bv.setCreateby(global.getUserinfo().getId());
				bv.setCreatetime(new Date());
				bv.setOrgid(global.getOrganization().getId());
				bv.setVehicleid(new Long(vehid));
				bv.setAgentrate(balance.getAgentrate());
				bv.setUpdateby(global.getUserinfo().getId());
				bv.setUpdatetime(new Date());
				balanceDao.merge(bv);
			}
		}
		long dipersonkilometre = 0;
		long dipersonkilometreother = 0;
		if(!invoicesids.isEmpty()){
			dipersonkilometre = balanceDao.qryPersonkilometre(invoicesids);
		}  
		if(!otherinvoicesids.isEmpty()){
			dipersonkilometreother = balanceDao.qryPersonkilometreOther(otherinvoicesids);
		}				
		balance.setDipersonkilometre(dipersonkilometre+dipersonkilometreother);
		balance.setBalanceno(balanceno);		
		balance.setOrgid(global.getOrganization().getId());
		balance.setBalancby(global.getUserinfo().getId());
		balance.setCreateby(global.getUserinfo().getId());
		balance.setCreatetime(new Date());
		if (balance.getVipscoremoney() == null)
			balance.setVipscoremoney(new BigDecimal(0));
		balance.setUpdateby(global.getUserinfo().getId());
		balance.setStatus("0");// 正常
		balance.setBalancetime(new Date());
		balance.setBalanceip(global.getIpAddress());
		balance.setUpdatetime(new Date());
		
		//如果结算通知单需要领取票据
		if (CommonUtil.isNotEmptyString(p4069) && p4069.equals("1")) {
			billinuse.setNextno(billinuse.getNextno() + 1);
			if (billinuse.getNextno() > billinuse.getEndno()+1) {
				// 当前票段剩余票数不够使用
				throw new BusinessException("当前票段剩余票数不够使用");
			}
			// 本次若是最后一张票据
			if (billinuse.getNextno() > billinuse.getEndno()) {
				billinuse.setStatus("2");
			}
			billinuse.setUpdateby(balance.getCreateby());
			billinuse.setUpdatetime(new Date());
			balanceDao.getEntityManager().merge(billinuse);
		}
		balance = balanceDao.getEntityManager().merge(balance);

		// 更新车辆预缴款
		for (Vehicleturnover vo : vos) {
			vo.setIsbalance(true);
			vo.setBalance(balance);
			vo.setUpdateby(balance.getCreateby());
			vo.setUpdatetime(new Date());
			balanceDao.getEntityManager().merge(vo);
		}
		
		// 更新结算单补录信息
		if(!otherinvoicesids.isEmpty()){
		balanceDao.updateDepartinvoicesother(balance, otherinvoicesids, global
				.getOrganization().getStation());
		}
/**
 * 		

		BigDecimal addbalancemoney = new BigDecimal(0);
		List<Departinvoicesother> dis = departinvoicesotherService
				.getInvoicesotherBalance(balance.getObjectid());
		for (Departinvoicesother d : dis) {
			addbalancemoney = addbalancemoney.add(d.getBalancemoney());
		}
		if (addbalancemoney.compareTo(balance.getReturnmoney()) != 0) {
			// 补录金额发生变动，请重新查询后结算
			throw new ServiceException("0316");
		}
		for (Departinvoicesother d : dis) {
			d.setStatus("2");// 已结算
			d.setBalance(balance);
			d.setUpdateby(balance.getCreateby());
			d.setUpdatetime(new Date());
			balanceDao.getEntityManager().merge(d);
		}    */
		vehicleids = "(" + vehicleids + ")";
		// 更新车辆违规罚金

		BigDecimal debit = new BigDecimal(0);
		
		//参数4008，营运车辆违规结算模块，违规结算类型，0罚金，1暂扣款，默认为0
		String p4008 = parameterService.findParamValue(ParamterConst.Param_4008,
				global.getUserinfo().getOrgid());
		List<Vehicleviolation> vlist = new ArrayList<Vehicleviolation>();
		if ("0".equals(p4008)) {
			//根据结算单ID查询所对应的违规罚金,invoicesids
		    vlist = balanceDao.qryVehicleviolationByInvoicesid(invoicesids);
			if (vlist != null) {
				for (Vehicleviolation v : vlist) {			
					v.setStatus("1");    //将该车对应状态为“已打单”的违规记录更新为“已罚款”状态
					v.setIshandle(true);  //已处理
					v.setUpdateby(global.getUserinfo().getId());
					v.setUpdatetime(new Date());
					debit=debit.add(v.getDebit());
					balanceDao.merge(v);          //更新到表中
				}
			}
		}else{
			//ob.setDebit(balanceDao.qryVehicleviolation(vehicleids, orgid));
			vlist = balanceDao.qryVehicleviolations(
					vehicleids, global.getOrganization().getId());
			for (Vehicleviolation v : vlist) {
				debit = debit.add(v.getDebit());
			}
		}		
		
		if (debit.compareTo(balance.getDebit()) != 0) {
			// 车辆违规罚金发生变动，请重新查询
			throw new ServiceException("0395");
		}

		// 更新晚点罚金
		List<Vehiclelate> vllist = balanceDao.qryVehiclelate(vehicleids);
		for (Vehiclelate vc : vllist) {
			vc.setBalance(balance);
			balanceDao.merge(vc);
		}
		String isvioliation = parameterService.findParamValue("4008", global.getOrganization().getId());
		if (isvioliation.equals("0")) {
			for (Vehicleviolation v : vlist) {
				v.setBalance(balance);
				v.setStatus("1");
				v.setUpdateby(balance.getCreateby());
				v.setUpdatetime(new Date());
				balanceDao.merge(v);
			}
		} else {
			for (Vehicleviolation v : vlist) {
				v.setBalance(balance);
				v.setStatus("2");
				v.setUpdateby(balance.getCreateby());
				v.setUpdatetime(new Date());
				balanceDao.merge(v);
			}
		}
		// 更新结算单
		if(!invoicesids.isEmpty()){
			balanceDao.updateDepartinvoices(balance, invoicesids, global
					.getOrganization().getStation());
		}
		
		// 更新结算单明细
		// balanceDao.updateDepartinvoicesdetail(balance, invoicesids);

		// 更新结算单扣费明细		
		if(!invoicesids.isEmpty()){
			balanceDao.updateDepartinvoicesdeductdetail(balance, invoicesids);
		}
		
		// 更新结算单补录扣费明细
		if(!otherinvoicesids.isEmpty()){
			balanceDao.updateDepartinvoicesdeductdetailother(balance, otherinvoicesids);
		}
		
		
		// 更新手动输入扣费
		if (dds != null) { 
			for (Balancedeductdetail ds : dds) {
				Balancedeductdetail obj = (Balancedeductdetail) balanceDao.get(
						Balancedeductdetail.class, ds.getId());
				obj.setDeductmoney(ds.getDeductmoney());
				obj.setDivdedeductmoney(ds.getDivdedeductmoney());
				obj.setBalance(balance);
				obj.setUpdateby(global.getUserinfo().getId());
				obj.setUpdatetime(new Date());
				balanceDao.merge(obj);
				// 若是一辆车结算
				if (vehicles.length == 1) {
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!vehicleid", new Long(
							vehicles[0])));
					filters.add(new PropertyFilter("EQL_t!orgid", global
							.getOrganization().getId()));
					filters.add(new PropertyFilter("EQL_t!balancedeductitemid",
							obj.getBalancedeductitemid()));
					List<Balancevehiclededuct> lists = balanceDao
							.qryBalancevehiclededuct(filters);
					if (lists == null || lists.size() == 0) {
						Balancevehiclededuct bd = new Balancevehiclededuct();
						bd.setVehicleid(new Long(vehicles[0]));
						bd.setBalancedeductitemid(obj.getBalancedeductitemid());
						bd.setOrgid(global.getOrganization().getId());
						bd.setDeductmoney(ds.getDeductmoney());
						bd.setDivdedeductmoney(ds.getDivdedeductmoney());
						bd.setCreateby(global.getUserinfo().getId());
						bd.setUpdateby(global.getUserinfo().getId());
						bd.setCreatetime(new Date());
						bd.setUpdatetime(new Date());
						balanceDao.merge(bd);
						balanceDao.getEntityManager().flush();
					} else {
						Balancevehiclededuct bd = lists.get(0);
						bd.setDeductmoney(ds.getDeductmoney());
						bd.setDivdedeductmoney(ds.getDivdedeductmoney());
						bd.setUpdateby(global.getUserinfo().getId());
						bd.setUpdatetime(new Date());
						balanceDao.merge(bd);
						balanceDao.getEntityManager().flush();
					}
				}
				// 多车结算,则保存结算对象对应的扣费信息
				else {
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!balanceunitid",
							balance.getObjectid()));
					filters.add(new PropertyFilter("EQL_t!orgid", global
							.getOrganization().getId()));
					filters.add(new PropertyFilter("EQL_t!balancedeductitemid",
							obj.getBalancedeductitemid()));
					List<Balanceunitdeduct> lists = balanceDao
							.qryBalanceunitdeduct(filters);
					if (lists == null || lists.size() == 0) {
						Balanceunitdeduct bd = new Balanceunitdeduct();
						bd.setBalanceunitid(balance.getObjectid());
						bd.setBalancedeductitemid(obj.getBalancedeductitemid());
						bd.setOrgid(global.getOrganization().getId());
						bd.setDeductmoney(ds.getDeductmoney());
						bd.setDivdedeductmoney(ds.getDivdedeductmoney());
						bd.setCreateby(global.getUserinfo().getId());
						bd.setUpdateby(global.getUserinfo().getId());
						bd.setCreatetime(new Date());
						bd.setUpdatetime(new Date());
						balanceDao.merge(bd);
						balanceDao.getEntityManager().flush();
					} else {
						Balanceunitdeduct bd = lists.get(0);
						bd.setDeductmoney(ds.getDeductmoney());
						bd.setDivdedeductmoney(ds.getDivdedeductmoney());
						bd.setUpdateby(global.getUserinfo().getId());
						bd.setUpdatetime(new Date());
						balanceDao.merge(bd);
						balanceDao.getEntityManager().flush();
					}

				}
			}
		}
		
		//将车辆停车费扣费记录修改为已结算状态
		if ((invoicesids != null && invoicesids.length() > 0) || (otherinvoicesids != null && otherinvoicesids.length() > 0)) {
			List<VehicleParkFee> parkfeeList = balancedeductDao.qryVehicleParkFeeObjs(qryfromdate, qrytodate, invoicesids, otherinvoicesids, global.getOrganization().getId());
			if(parkfeeList != null && parkfeeList.size() > 0){
				for (VehicleParkFee vehicleParkFee : parkfeeList) {
					vehicleParkFee.setIsbalanced(true);
					vehicleParkFee.setBalanceid(balance.getId());
					vehicleParkFee.setUpdateby(global.getUserinfo().getId());
					vehicleParkFee.setUpdatetime(new Date());
					balanceDao.merge(vehicleParkFee);
				}
			}
		}
		
		if (schedulelosttreatmentIds != null) {  //班次晚点脱班管理
			List<ScheduleLostTreatments> listSchedulelosttreatment = balancedeductDao.qrySchedulelosttreatment(schedulelosttreatmentIds);
			if (listSchedulelosttreatment != null && listSchedulelosttreatment.size() > 0) {
				Date date = new Date();
				for (ScheduleLostTreatments scheduleLostTreatment : listSchedulelosttreatment) {
					scheduleLostTreatment.setIsbalance(true);
					scheduleLostTreatment.setBalancedate(date);
					scheduleLostTreatment.setBalanceid(balance.getId());
					
				}
			}
		}

		return balance;
	}

	/*
	 * getOtherDeduct方法：<br/> <br/>
	 * 
	 * @param invoicesids
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#getOtherDeduct(java.lang.String )
	 * 
	 * @exception
	 */
	@Override
	public BigDecimal getOtherDeduct(String invoicesids) {
		return balancedeductService.getOthterfee(invoicesids);
	}

	/*
	 * delBalanceData方法：<br/> <br/>
	 * 
	 * @param invoicesids
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#delBalanceData(java.lang.String )
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean delBalanceData(String invoicesids) throws ServiceException {
		List<Departinvoicesdeductdetail> dds = balanceDao
				.qryDepartinvoicesdeductdetail(invoicesids);
		for (Departinvoicesdeductdetail dd : dds) {
			balanceDao.delete(dd);
		}
		List<Balancedeductdetail> bds = balanceDao
				.qryBalancedeductdetail(invoicesids);
		for (Balancedeductdetail dd : bds) {
			balanceDao.delete(dd);
		}
		List<Balancescheduleminimum> bslist = balanceDao
				.qryBalancescheduleminimum(invoicesids);
		for (Balancescheduleminimum bs : bslist) {
			balanceDao.delete(bs);
		}
		return true;
	}

	/*
	 * qryBalanceDeduct方法：查询扣费明细并打印<br/> <br/>
	 * 
	 * @param balanceid
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#qryBalanceDeduct(long)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryBalanceDeduct(long balanceid,
			Boolean isdeductbeforebalance) {
		return balancedeductService.qryBalanceDeduct(balanceid,
				isdeductbeforebalance);
	}

	/*
	 * qryDepartinvoicesByNo方法：<br/> <br/>
	 * 
	 * @param departinvoicesno
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#qryDepartinvoicesByNo(java .lang.String)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryDepartinvoicesByNo(
			String departinvoicesno) {
		return ListUtil.listToMap(new Object[] { "id", "departinvoicesno",
				"status" }, balanceDao.qryDepartinvoicesByNo(departinvoicesno),
				new Object[] { Long.class, String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryBalanced(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "vehicleno", "preupmoney",
				"routename", "status", "id", "balanceno", "ditotalnum",
				"ditotalmoney", "distationservicefee", "fueladditionfee",
				"diotherpredeductifee", "diagentfee", "dibalanceablemoney",
				"dipersonkilometre", "dideductmoney", "dibalancemoney",
				"returnmoney", "vipscoremoney", "lastlost", "lost",
				"deratemoney", "lateforfeit", "lostforfeit", "balancemoney",
				"remarks", "balancetime", "balanceip", "cleartime", "cancelip",
				"orgname", "balancebyname", "cancelbyname", "statusname",
				"objecttype", "objectname", "invoicesnum","vehicleunitname", "ticketincome",
				"packmoney", "balancemonth", "departstartdate",
				"departenddate", "additionfee", "divide", "dividename",
				"packprice", "rentmoney", "rentprice", "debit", "backmoney",
				"balanceobject","bysj","syqj","goodsagent" },
				balanceDao.queryBalanced(propertyFilterList), new Object[] {
						String.class, BigDecimal.class, String.class,
						String.class, Long.class, String.class, Integer.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						Long.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class,
						String.class, String.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, long.class,String.class,
						BigDecimal.class, BigDecimal.class, String.class,
						Date.class, Date.class, BigDecimal.class,
						BigDecimal.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class,BigDecimal.class, BigDecimal.class,BigDecimal.class });
	}

	// 注销结账单(结算通知单)
	@SuppressWarnings("unchecked")
	@Override
	public boolean cancelBalanceno(long balanceid, long cancelby,
			String cancelip) throws ServiceException {
		Balance balance = (Balance) balanceDao.get(Balance.class, balanceid);
		List<Balancedeductdetail> ddlist = balance.getBalancedeductdetaillist();
		for (Balancedeductdetail dd : ddlist) {
			dd.setBalance(null);
			balanceDao.merge(dd);
		}
		Userinfo userinfo = (Userinfo) balanceDao.get(Userinfo.class, cancelby);
		balance.setCancelby(userinfo);
		balance.setCancelip(cancelip);
		balance.setCleartime(new Date());
		balance.setStatus("1");
		balance.setUpdateby(cancelby);
		balance.setUpdatetime(new Date());
		// 还原车辆预缴款
		List<Vehicleturnover> volist = balanceDao
				.qryBalanceVehicleturnover(balanceid);
		for (Vehicleturnover ov : volist) {
			ov.setBalance(null);
			ov.setIsbalance(false);
			ov.setUpdateby(cancelby);
			ov.setUpdatetime(new Date());
			balanceDao.getEntityManager().merge(ov);
		}
		// 更新晚点罚金
		List<Vehiclelate> vllist = balanceDao.qryVehiclelate(balanceid);
		for (Vehiclelate vc : vllist) {
			vc.setBalance(null);
			balanceDao.merge(vc);
		}
		//
		List<Vehicleviolation> vvlist = balanceDao
				.qryVehicleviolation(balanceid);
		for (Vehicleviolation vv : vvlist) {
			vv.setBalance(null);
			if ("1".equals(vv.getStatus())) {  //已罚款
				vv.setStatus("4");     //已打单
			} else {
				vv.setStatus("0");// 未结算
			}
			vv.setIshandle(false); //未处理
			vv.setUpdateby(cancelby);
			vv.setUpdatetime(new Date());
			balanceDao.getEntityManager().merge(vv);
		}
		// 还原补录信息
		List<Departinvoicesother> dis = balanceDao
				.getInvoicesotherBalance(balance.getId());
		for (Departinvoicesother d : dis) {
			d.setStatus("3");// 正常
			d.setBalance(null);
			d.setUpdateby(balance.getCreateby());
			d.setUpdatetime(new Date());
			balanceDao.getEntityManager().merge(d);
		}

		// 更新结算单
		balanceDao.updateDepartinvoices(balanceid, cancelby);
		// 更新结算单明细
		// balanceDao.updateDepartinvoicesdetail(balance, invoicesids);
		// 更新扣费明细
		balanceDao.updateDepartinvoicesdeductdetail(balanceid, cancelby);
		
		//查看是否有路单结算插件
		ActionNode actionNode = Appvar.routes.get("COMPRECHARGEHAVEDEPARTINVOICE");// 由插件名,获得插件		
		try {
			Map<Object,Object> map = PluginFunctionUtil.DoPlugin(new Object(),new Global(),actionNode);			
			if (map!=null){ 
			  Object objresult = map.get("isresult");
			  int intresult = Integer.parseInt(String.valueOf(objresult));
			  if(intresult==1){
			    //注销时更新实际收费管理
				balanceDao.updateActualfee(balanceid,cancelby);
				//注销时清除结算明细数据
				balanceDao.delBalancedetail(balanceid);
			  }
			}  			
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//还原车辆停车废扣费
		List<VehicleParkFee> vehicleParkFeeList = balanceDao.qryBalancedVehicleParkFees(balanceid);
		if(vehicleParkFeeList != null && vehicleParkFeeList.size() > 0){
			for (VehicleParkFee vehicleParkFee : vehicleParkFeeList) {
				vehicleParkFee.setIsbalanced(false);
				vehicleParkFee.setBalanceid(null);
				vehicleParkFee.setUpdateby(cancelby);
				vehicleParkFee.setUpdatetime(new Date());
				balanceDao.merge(vehicleParkFee);
			}
		}
		
		return true;
	}

	@Override
	public String qryBalanceByNo(String departinvoicesno) {
		Balance ba = balanceDao.qryBalanceByNo(departinvoicesno);
		if (ba == null) {
			return "没有该结算单信息！";
		} else {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String balancedate = sf.format(ba.getBalancetime());
			return "该结算单已经结算，结账日期为:" + balancedate + ",单号为："
					+ ba.getBalanceno();
		}
	}

	/*
	 * recalDepartinvoices方法: <br/> <br/>
	 * 
	 * @param startdate
	 * 
	 * @param enddate
	 * 
	 * @param orgid
	 * 
	 * @param routeid
	 * 
	 * @param vehicleid
	 * 
	 * @param updateby
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.balance.service.BalanceService#recalDepartinvoices(java.util .Date, java.util.Date, long, long,
	 * long, long)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean recalDepartinvoices(Date startdate, Date enddate,
			String invoinceids,String otherinvoinceids, long updateby,Global global) throws ServiceException {
		List<Departinvoices> dsp = balanceDao.qryInvoinces(startdate, enddate,
				invoinceids);
		List<Departinvoicesother> otherdsp = balanceDao.qryDepartinvoicesother(startdate, enddate,
				otherinvoinceids);	
		String ticketids = "";// 售票ID用于更新车票
		Vehicle vehicle = null;
		Scheduleplan scheduleplan = null;
		for (Departinvoices ds : dsp) {
			scheduleplan = (Scheduleplan) balanceDao.get(Scheduleplan.class,
					ds.getScheduleplanid());
			vehicle = (Vehicle) balanceDao
					.get(Vehicle.class, ds.getVehicleid());
			List<Ticketsell> ticketsells = balanceDao.qryTickets(
					ds.getDepartdate(), ds.getId());
			ticketids = "";
			for (Ticketsell ticket : ticketsells) {
				ticketids = ticketids + "," + ticket.getId();
			}
			if (ticketids.length() > 0) {
				ticketids = "(" + ticketids.substring(1) + ")";
			} else {
				ticketids = "(0)";
			}
			Departinvoices newds = balancedeductService.createDepartinvoices(
					scheduleplan, vehicle, ticketsells, ds.getDeparttime(),
					ds.getCreateby(),global);
			ds.setStationservicefee(newds.getStationservicefee());
			ds.setAgentfee(newds.getAgentfee());
			ds.setFueladditionfee(newds.getFueladditionfee());
			ds.setOthterfee(newds.getOthterfee());
			ds.setBalanceamount(newds.getBalanceamount());
			List<Departinvoicesdetail> dds = ds.getDepartinvoicesdetails();
			List<Departinvoicesdetail> ndds = newds.getDepartinvoicesdetails();
			for (Departinvoicesdetail dd : dds) {
				for (Departinvoicesdetail ndd : ndds) {
					if (dd.getFromstationid() == ndd.getFromstationid()
							&& dd.getReachstationid() == ndd
									.getReachstationid()
							&& dd.getTickettype().equals(ndd.getTickettype())
							&& dd.getPrice().compareTo(ndd.getPrice()) == 0) {
						dd.setStationservicefee(ndd.getStationservicefee());
						dd.setAgentfee(ndd.getAgentfee());
						dd.setFueladditionfee(ndd.getFueladditionfee());
						dd.setOthterfee(ndd.getOthterfee());
						dd.setBalanceamount(ndd.getBalanceamount());
					}
				}
			}
			List<Departinvoicesdeductdetail> ddts = ds
					.getDepartinvoicesdeductdetails();
			for (Departinvoicesdeductdetail ddt : ddts) {
				ddt.setStatus("1");
				ddt.setUpdateby(updateby);
				ddt.setUpdatetime(new Date());
			}
			List<Departinvoicesdeductdetail> nddts = newds
					.getDepartinvoicesdeductdetails();
			for (Departinvoicesdeductdetail ddt : nddts) {
				ddt.setDepartinvoices(ds);
				ddts.add(ddt);
			}
			balanceDao.merge(ds);
		}
		
		//手工单重新计算。
		DepartinvoicesotherDao dao = new DepartinvoicesotherDao();
		DepartinvoicesotherdetailDao daod = new DepartinvoicesotherdetailDao();
		for (Departinvoicesother otherds : otherdsp) {
			String flag = parameterService.findParamValue(ParamterConst.Param_3068, otherds.getOrgid());
			//是否应用扣费项目进行扣费
			if(flag.equals("1")){
				 Query query = JPA.em().createQuery(" from Departinvoicesotherdetail dtl where dtl.departinvoicesotherid ="+otherds.getId(), Departinvoicesotherdetail.class);
				 List<Departinvoicesotherdetail> ddlist =query.getResultList(); 
				 BigDecimal newAgentfee = new BigDecimal(0);
				 BigDecimal newBalancemoney = new BigDecimal(0);
				for(Departinvoicesotherdetail dd:ddlist){
					vehicle = JPA.em().createQuery(" from Vehicle v where v.id = "+otherds.getVehicleid(), Vehicle.class).getSingleResult();
					BigDecimal preAgentfee = dd.getAgentfee();							
					//-----------根据公式重新计算begin---------------
	                //目前手工单重新计算只计算了客运代理费和总结算金额 		
					List<Balanceformulaitem> balanceformulaitems = new ArrayList<Balanceformulaitem>();				
					Balanceformulaitem balanceformulaitemA = new Balanceformulaitem();
					balanceformulaitemA.setShortname("A");
					balanceformulaitemA.setCalValue(dd.getTotalamount());
					balanceformulaitems.add(balanceformulaitemA);//总金额				
					Balanceformulaitem balanceformulaitemB = new Balanceformulaitem();
					balanceformulaitemB.setShortname("B");
					balanceformulaitemB.setCalValue(new BigDecimal(dd.getTicketnum()));
					balanceformulaitems.add(balanceformulaitemB);//人数				
					Balanceformulaitem balanceformulaitemE = new Balanceformulaitem();
					balanceformulaitemE.setShortname("E");
					balanceformulaitemE.setCalValue(dd.getOthterfee());
					balanceformulaitems.add(balanceformulaitemE);//其他扣费
					String formula = "";
					// 根级公式
					Balanceformulaapply ba = balancedeductDao.getFormulaapply(dd.getDepartdate(),
							vehicle, dd.getSchedule());
					if (ba == null) {
						continue;
					}
					// 查找子扣费公式
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
					
						BigDecimal reAgentfee = new BigDecimal(ExpressionEvaluator.evaluate(formula)
								.toString());
						reAgentfee = reAgentfee.divide(new BigDecimal(1), 2,
								BigDecimal.ROUND_HALF_UP);
						dd.setAgentfee(reAgentfee);
						dd.setBalanceamount(dd.getBalanceamount().subtract(reAgentfee).add(preAgentfee));
						newAgentfee = newAgentfee.add(dd.getAgentfee());
						newBalancemoney = newBalancemoney.add(dd.getBalanceamount().subtract(reAgentfee).add(preAgentfee));
						daod.merge(dd);	
				}
				otherds.setAgentfee(newAgentfee);
				otherds.setBalancemoney(newBalancemoney);
				//-----------根据公式重新计算end---------------
				dao.merge(otherds);
			}
		}		
		return true;
	}

	// 结算界面查询扣费明细信息
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> qryBalanceDeduct(int balancetype,
			long orgid, long balanceunitid, String invoinceids,
			String vehicleids) {
		int count = invoinceids.split(",").length;
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		// 按结算单位结算
		if (balancetype == 0) {
			filters.add(new PropertyFilter("EQL_d!balanceunitid", balanceunitid));
			filters.add(new PropertyFilter("EQL_d!orgid", orgid));
		} else {
			// 按单车结算
			long vehicleid = new Long(vehicleids);
			filters.add(new PropertyFilter("EQL_d!balancevehicleid", vehicleid));
			filters.add(new PropertyFilter("EQL_d!orgid", orgid));

		}
		List<Balancedeductdetail> bds = balanceDao
				.qryBalanceDeductDetail2(filters);
		String vehicles[] = vehicleids.split(",");
		String gentype = parameterService.findParamValue(ParamterConst.Param_4006, orgid);
		for (Balancedeductdetail bd : bds) {
			if (bd.getBalance() == null) {
				Balancedeductitem bi = (Balancedeductitem) balanceDao.get(
						Balancedeductitem.class, bd.getBalancedeductitemid());
				// 按运量单张数扣费
				if (bi.getDeducttype().equals("7")) {
					bd.setDeductmoney(bi.getDeductmoney().multiply(
							new BigDecimal(count)));
					balanceDao.merge(bd);
					balanceDao.getEntityManager().flush();
				} else {
					// 若是需要取上次的结算扣费信息
					if (gentype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
						// 若是单车结算
						if (vehicles.length == 1) {
							filters.clear();
							filters.add(new PropertyFilter("EQL_t!vehicleid",
									new Long(vehicles[0])));
							filters.add(new PropertyFilter("EQL_t!orgid", orgid));
							filters.add(new PropertyFilter(
									"EQL_t!balancedeductitemid", bd
											.getBalancedeductitemid()));
							List<Balancevehiclededuct> bvs = balanceDao
									.qryBalancevehiclededuct(filters);
							if (bvs != null && bvs.size() > 0) {
								bd.setDeductmoney(bvs.get(0).getDeductmoney());
								balanceDao.merge(bd);
								balanceDao.getEntityManager().flush();
							}
						} else {
							filters.clear();
							filters.add(new PropertyFilter(
									"EQL_t!balanceunitid", balanceunitid));
							filters.add(new PropertyFilter("EQL_t!orgid", orgid));
							filters.add(new PropertyFilter(
									"EQL_t!balancedeductitemid", bd
											.getBalancedeductitemid()));
							List<Balanceunitdeduct> bvs = balanceDao
									.qryBalanceunitdeduct(filters);
							if (bvs != null && bvs.size() > 0) {
								bd.setDeductmoney(bvs.get(0).getDeductmoney());
								balanceDao.merge(bd);
								balanceDao.getEntityManager().flush();
							}
						}
					}
				}
			}
		}
		if (balancetype == 0) {
			return ListUtil.listToMap(new Object[] { "id", "name",
					"deductmoney", "divdedeductmoney" },
					balanceDao.qryBalanceductdetail(orgid, balanceunitid),
					new Object[] { Long.class, String.class, BigDecimal.class,
							BigDecimal.class });
		} else {
			long vehicleid = new Long(vehicleids);
			return ListUtil.listToMap(new Object[] { "id", "name",
					"deductmoney", "divdedeductmoney" }, balanceDao
					.qryBalanceductdetailByVehicleid(orgid, vehicleid),
					new Object[] { Long.class, String.class, BigDecimal.class,
							BigDecimal.class });
		}
	}

	@Override
	public List<Map<String, Object>> qryBalanceDeductDetail(long balanceid) {
		Balance ba = (Balance) balanceDao.get(Balance.class, balanceid);
		String isprint = parameterService.findParamValue(ParamterConst.Param_4005, ba.getOrgid());
		return ListUtil.listToMap(new Object[] { "name", "deductmoney",
				"divdedeductmoney", "code" },
				balanceDao.qryBalanceDeductDetail(balanceid, isprint),
				new Object[] { String.class, BigDecimal.class,
						BigDecimal.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryAdditionFee(String invoicesids,
			long vehicleid, long orgid,String otherinvoicesids) {
		return ListUtil.listToMap(new Object[] { "id", "stationid", "name",
				"ticketnum", "deductmoney", "vehicleid", "orgid", "totalfee" },
				balanceDao.qryAdditionFee(invoicesids, vehicleid, orgid,otherinvoicesids),
				new Object[] { Long.class, Long.class, String.class,
						Long.class, BigDecimal.class, Long.class, Long.class,
						BigDecimal.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean updateAdditionFee(List<Balancestationdeduct> bsds,
			long createby) {
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		for (Balancestationdeduct bsd : bsds) {
			filters.clear();
			filters.add(new PropertyFilter("EQL_t!vehicleid", bsd
					.getVehicleid()));
			filters.add(new PropertyFilter("EQL_t!stationid", bsd
					.getStationid()));
			filters.add(new PropertyFilter("EQL_t!orgid", bsd.getOrgid()));
			List<Balancestationdeduct> bss = balanceDao
					.qryBalancestationdeduct(filters);
			if (bss == null || bss.size() == 0) {
				Balancestationdeduct newbs = new Balancestationdeduct();
				newbs.setCreateby(createby);
				newbs.setCreatetime(new Date());
				newbs.setDeductmoney(bsd.getDeductmoney());
				newbs.setOrgid(bsd.getOrgid());
				newbs.setStationid(bsd.getStationid());
				newbs.setUpdateby(createby);
				newbs.setUpdatetime(new Date());
				newbs.setVehicleid(bsd.getVehicleid());
				balanceDao.merge(newbs);
			} else {
				Balancestationdeduct bs = bss.get(0);
				bs.setDeductmoney(bsd.getDeductmoney());
				bs.setUpdateby(createby);
				bs.setUpdatetime(new Date());
				balanceDao.merge(bs);
			}

		}

		return true;
	}

	@Override
	public boolean additionFeeIsSame(String vehicleids, long orgid) {
		String vehicleid[] = vehicleids.split(",");
		if (vehicleid.length > 1) {
			long curvehicleid = new Long(vehicleid[0]);
			List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
			filters.add(new PropertyFilter("EQL_t!vehicleid", curvehicleid));
			filters.add(new PropertyFilter("EQL_t!orgid", orgid));
			List<Balancestationdeduct> bas = balanceDao
					.qryBalancestationdeduct(filters);
			for (Balancestationdeduct bs : bas) {
				for (String id : vehicleid) {
					long curid = new Long(id);
					if (curid != curvehicleid) {
						filters.clear();
						filters.add(new PropertyFilter("EQL_t!stationid", bs
								.getStationid()));
						filters.add(new PropertyFilter("EQL_t!vehicleid", curid));
						filters.add(new PropertyFilter("EQL_t!orgid", orgid));
						List<Balancestationdeduct> lists = balanceDao
								.qryBalancestationdeduct(filters);
						for (Balancestationdeduct list : lists) {
							if (bs.getDeductmoney().compareTo(
									list.getDeductmoney()) != 0) {
								return false;
							}
						}
					}
				}

			}
			return true;
		} else {
			return true;
		}

	}

	@Override
	public BigDecimal qryAdditionFee(String invoicesids, String vehicleids,
			long orgid) {
		BigDecimal additionfee = new BigDecimal(0);
		String vehicleid[] = vehicleids.split(",");
		if (vehicleid.length == 1 || additionFeeIsSame(vehicleids, orgid)) {
			long curvehicleid = new Long(vehicleid[0]);
			additionfee = balanceDao.qryStatioinAdditionFee(invoicesids,
					curvehicleid, orgid);
		}
		return additionfee;
	}

	@Override
	public BigDecimal qryAgentrate(String vehicleids, long orgid) {
		String vehicleid[] = vehicleids.split(",");
		BigDecimal agentrate = new BigDecimal(0);
		if (vehicleid.length >= 1) {
			List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
			filters.add(new PropertyFilter("EQL_t!vehicleid", new Long(
					vehicleid[0])));
			filters.add(new PropertyFilter("EQL_t!orgid", orgid));
			List<Balancevehicleagentrate> lists = balanceDao
					.qryBalancevehicleagentrate(filters);
			if (lists != null && lists.size() > 0) {
				agentrate = lists.get(0).getAgentrate();
			}
		}
		return agentrate;
	}

	@Override
	public String qryRoutename(String vehicleno) {
		return balanceDao.qryRoutename(vehicleno);
	}

	// 查询单车已结算信息
	@Override
	public List<Map<String, Object>> qryVehicleBalanced(Date startdate,
			Date enddate, String orgids, long vehicleid, long unitid) {
		List<Object> list = new ArrayList<Object>();
		// 结算信息
		List<Object> objlist = balanceDao.qryVehicleBalanced(startdate,
				enddate, orgids, vehicleid, unitid);
		// 所有扣费项目
		List<Object> items = balanceDao.qryVehicleBalancedItem(startdate,
				enddate, orgids, vehicleid, unitid);
		String[] itemsname = new String[items.size()];
		String[] itemscode = new String[items.size()];
		int i = 0;
		for (Object obj : items) {
			Object[] item = (Object[]) obj;
			itemsname[i] = item[0].toString();
			itemscode[i] = item[1].toString();
			i = i + 1;
		}

		boolean isexist = false;
		// 排序
		int len = 7 + items.size();
		Object[] newObject = new Object[len];
		newObject[0] = "0";
		for (i = 1; i < len - 1; i++) {
			newObject[i] = i;
		}
		newObject[len - 1] = "" + (len - 1);
		list.add(0, newObject);
		newObject = null;
		//
		for (Object obj : objlist) {
			Object[] objdetail = (Object[]) obj;
			Object[] objs = new Object[7 + items.size()];

			long balanceid = new Long(objdetail[0].toString());
			objs[0] = objdetail[1];
			objs[1] = objdetail[2];
			objs[2] = objdetail[3];
			objs[3] = objdetail[4];
			objs[4] = objdetail[5];
			objs[5] = objdetail[6];
			// objs[6]=objdetail[6];
			int j = 6;
			List<Object> delist = balanceDao.qryBalanceductdetail(balanceid);
			for (String itemcode : itemscode) {
				isexist = false;
				for (Object de : delist) {
					Object[] deitem = (Object[]) de;
					String code = deitem[1].toString();
					if (itemcode.equals(code)) {
						objs[j] = deitem[2];
						isexist = true;
						break;
					}
				}
				if (!isexist) {
					objs[j] = new BigDecimal(0);
				}
				j = j + 1;
			}
			objs[6 + items.size()] = objdetail[7];
			list.add(objs);
		}
		Object[] field = new Object[7 + items.size()];
		Object[] fieldType = new Object[7 + items.size()];
		Object[] oldfield = new Object[] { "结账时间", "车牌号", "车属单位", "票款", "结算金额",
				"扣费|客代费" };

		Object[] oldfieldType = new Object[] { String.class, String.class,
				String.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class };
		for (i = 0; i < oldfield.length; i++) {
			field[i] = oldfield[i];
		}
		for (i = 0; i < oldfieldType.length; i++) {
			fieldType[i] = oldfieldType[i];
		}
		for (i = 0; i < itemsname.length; i++) {
			field[6 + i] = "扣费|" + itemsname[i];
			fieldType[6 + i] = BigDecimal.class;
		}
		field[6 + items.size()] = "实结金额";
		fieldType[6 + items.size()] = BigDecimal.class;
		if (list.size() > 0) {
			return ListUtil.listToMap(field, list, fieldType);
		} else {
			return ListUtil.listToMap(new Object[] { "无数据" }, null,
					new Object[] { String.class });
		}
	}

	// 结算月报表
	@Override
	public List<Map<String, Object>> qryBalancedMonth(Date startdate,
			Date enddate) {
		List<Object> list = balanceDao.qryBalancedMonth(startdate, enddate);
		return ListUtil.listToMap(new Object[] { "totalamount",
				"stationservicefee", "returnhandcharge", "outprice",
				"balancemoney", "returnmoney", "income" }, list, new Object[] {
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class });
	}

	// 查询单车企业运输费
	@Override
	public List<Map<String, Object>> qryBalancedBusTransport(
			List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { "orgname", "routename",
				"vehicleno", "deductmoney" },
				balanceDao.qryBalancedBusTransport(propertyFilters),
				new Object[] { String.class, String.class, String.class,
						BigDecimal.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public BigDecimal calDepartinvoices(Date startdate, Date enddate, String invoinceids,Global global) {
		BigDecimal result=new BigDecimal(0);
		List<Departinvoices> dsp = balanceDao.qryInvoinces(startdate,enddate,invoinceids);
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.add(new PropertyFilter("EQL_t!orgid", global.getOrganization().getId()));
		
		//formulatype=3 为高级公式表达式
		filters.add(new PropertyFilter("EQS_t!formulatype", "3"));
		List<Balanceformula> lists = balanceDao.query(
				Balanceformula.class, filters);
		if (lists != null && lists.size() > 0){
			Balanceformula bf=lists.get(0);
			String formula=bf.getFormula().replaceAll("如果", " if ");
			formula=formula.replaceAll("否则", " else ");			
			formula=formula.replaceAll("并且", " && ");
			CalculateItem citem=new CalculateItem();
			SimpleDateFormat sf=new SimpleDateFormat("yyyyMM");
			for (Departinvoices ds : dsp) {
				citem.init();
				citem.setPeoples((int) ds.getTicketnum());
				citem.setTotalprice(ds.getTotalamount());
				citem.setDepartdate(ds.getDepartdate());
				citem.setBalancedate(new Date());
				//int intervalsday=DateUtils.getIntervalDays(citem.getDepartdate(), citem.getBalancedate());
				int departmonth=new Integer(sf.format(citem.getDepartdate()));
				int balancemonth=new Integer(sf.format(citem.getBalancedate()));
				citem.setIntervalmonths(balancemonth-departmonth);
				List<Departinvoicesdeductdetail> dslist=ds.getDepartinvoicesdeductdetails();
				for(Departinvoicesdeductdetail dst:dslist){
					Balancedeductitem bt=(Balancedeductitem) balanceDao.get(Balancedeductitem.class, dst.getBalanceitemid());
					if(bt==null){
						System.out.println("Departinvoicesno="+ds.getDepartinvoicesno()+ ",itemid="+dst.getBalanceitemid());
						continue;
					}
					//1	C	站务费
					if(bt.getCode().equals("C")){
						citem.setStationfee(dst.getDeductmoney());
					}else if(bt.getCode().equals("D")){//附加费
						citem.setAdditionfee(dst.getDeductmoney());
					}else if(bt.getCode().equals("E")){
						citem.setComputefee(dst.getDeductmoney());//微机费
					}else if(bt.getCode().equals("G")){
						citem.setCoolairfee(dst.getDeductmoney());//空调费
					}if(bt.getCode().equals("H")){
						citem.setWaterfee(dst.getDeductmoney());//配水费
					}if(bt.getCode().equals("I")){
						citem.setInsurefee(dst.getDeductmoney());//保险费
					}if(bt.getCode().equals("J")){
						citem.setOtherfee(dst.getDeductmoney());//其它
					}if(bt.getCode().equals("K")){
						citem.setFueladditionfee(dst.getDeductmoney());//燃油费
					}					
				}
				result=result.add(CalculateAgentfee.calculate(citem, formula));
			}
		}
		return result;
	}

	@Override
	public Departinvoices editDepartinvoices(String ticketsellids,
			long departinvoicesid,long fromstationid,long reachstationid,String tickettype,BigDecimal price) {
		// TODO Auto-generated method stub
		
		try {
			usertransaction.begin();
			balanceDao.updateTicketsellinfo(ticketsellids); //更新车票销售表
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		//更新结算单明细表
		List<Departinvoicesdetail> listdetail = balanceDao.qryDepartinvoicesDetail(departinvoicesid,fromstationid,reachstationid,tickettype,price);
		if(listdetail!=null&&listdetail.size()>0){
			
			for(Departinvoicesdetail departinvoicesdetail:listdetail){
				try {					
					usertransaction.begin();										
					balanceDao.updateDepartinvoicesdetail(departinvoicesdetail);
					usertransaction.commit();
				} catch (SystemException e) {
					// TODO Auto-generated catch block
					try {
						usertransaction.rollback();
					} catch (SystemException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					e.printStackTrace();
				}
				
			}
			
		}						
		//更新结算单
		Departinvoices departinvoices = getDepartinvoicesById(departinvoicesid);
		
		try {
			usertransaction.begin();
			getpriceinfo(departinvoicesid, departinvoices);
			departinvoices = (Departinvoices)balanceDao.merge(departinvoices);
			
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		return departinvoices;
	}
	
	public Departinvoices getDepartinvoicesById(Long departinvoicesid) {
		return (Departinvoices) balanceDao.get(Departinvoices.class,
				departinvoicesid);
	}
	
	private void getpriceinfo(long departinvoicesid,Departinvoices departinvoices) {
		
		departinvoices.setTicketnum(balanceDao.getTicketnum(departinvoicesid));
		
		departinvoices.setAgentfee(balanceDao.getAgentfee(departinvoicesid));		
		
		departinvoices.setTotalamount(balanceDao.getTotalamount(departinvoicesid));
		
		departinvoices.setStationservicefee(balanceDao.getStationfee(departinvoicesid));
		
		departinvoices.setBalanceamount(balanceDao.getBalanceamount(departinvoicesid));
		
		departinvoices.setFueladditionfee(balanceDao.getFueladditionfee(departinvoicesid));
		
		departinvoices.setOthterfee(balanceDao.getOtherfee(departinvoicesid));
	}

	@Override
	public List<Map<String, Object>> qryvehicleno(String param,
			List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code","seatnum"
		}, balanceDao.qryvehicleno(param, propertyFilters),
		new Object[] { Long.class, String.class, String.class,
			Long.class });
	}

	@Override
	public List<Map<String, Object>> isHaveDepartinvoicePlugin(Global global) {
		// TODO Auto-generated method stub
		//查看是否有路单结算插件
		ActionNode actionNode = Appvar.routes.get("COMPRECHARGEHAVEDEPARTINVOICE");// 由插件名,获得插件		
		try {
			Map<Object,Object> map = PluginFunctionUtil.DoPlugin(new Object(),global,actionNode);
			List<Object> list = new ArrayList<Object>();
			if (map!=null){ 
			  list.add(map.get("isresult"));
			}  
			return ListUtil.listToMap(new Object[] { "isHaveDepart"}, list,new Object[] { int.class });
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	//20151109 liyi 对结算金额进行四舍五入，根据参数规则，参照1105参数
	@Override
	public String roundLeaveBalance(long orgid,String leaveBalance) {
		String para4068 = parameterService.findParamValue(ParamterConst.Param_4068, orgid);
		String result ="";
		
		if(("1").equals(para4068)){
			result = new BigDecimal(leaveBalance).setScale(0, BigDecimal.ROUND_HALF_UP).toString();
			
		}else if(("2").equals(para4068)){
			result = new BigDecimal((int)Math.floor(Double.parseDouble(leaveBalance))).toString();
			
		}else if(("3").equals(para4068)){
			result = (new BigDecimal((int)Math.floor(Double.parseDouble(leaveBalance))+1)).toString();
			
		}else if (("4").equals(para4068)){
			//去掉小数之后的值
			double dd = Double.parseDouble(leaveBalance);
			int ddint = (int) dd;
			//小数的值
			BigDecimal  decimal=new BigDecimal(dd-ddint);
			//整数的值
			BigDecimal  returncharges=new BigDecimal((int)Math.floor(Double.parseDouble(leaveBalance)));
			int reslet_compareTo=decimal.compareTo(new BigDecimal(0));
			int reslet_compare=decimal.compareTo(new BigDecimal(0.5));
			if(reslet_compareTo<=0){
				result = returncharges.toString();						
			}else if(reslet_compareTo>0 && reslet_compare<=0){
				//1毛进5毛
				result = (new BigDecimal((int)Math.floor(Double.parseDouble(leaveBalance))+0.5)).toString();
				
			}else{
				//5毛进一块
				result=(new BigDecimal((int)Math.floor(Double.parseDouble(leaveBalance))+1)).toString();
				
			}
		}
		else
		{
			result = new BigDecimal(leaveBalance).toString();
		}
		
		return result;
	}

	@Override
	public List<Map<String, Object>> qrybalanceACPrintinfo(Long balanceid) {
		return ListUtil.listToMap(new Object[] { "vehicleno","routename","jyglfee","sghzjprice", 
						"jcfkdeduct","skdeduct","qtitem88","dqtcl","bqqrw","clzj","phc","hpkdffee","hffee","aqcbjprice","zwrffee","hpbalanceamount" },
				balanceDao.qrybalanceACPrintinfo(balanceid),
				new Object[] { String.class, String.class, BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class
						,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class});
	}

	@Override
	public boolean saveagentfee(long departinvoicesid, String deductmoney,BigDecimal balanceamount) {
		return balanceDao.saveagentfee(departinvoicesid,deductmoney,balanceamount);
	}
	
	@Override
	public String getVehicleUnitname(long id) {
		return balanceDao.getVehicleUnitname(id);
	}
	
	@Override
	public BigDecimal qryBaoChePrice(String otherinvoicesids) {
		// TODO Auto-generated method stub
		return "".equals(otherinvoicesids) ? BigDecimal.ZERO : balanceDao.qryBaoChePrice(otherinvoicesids);
	}
	
	/**
	 * 从 redis中增加或删除 结算单数据
	 */
	public MethodResult savetoredis(long departinvoicesid, String savemode) {
		MethodResult result = new MethodResult();
		result.setResult(1);

		Global global = CurrentUtil.getGlobal();
		String key = "BALANCE" + global.getUserinfo().getId();

		// 1 为保存单条
		if ("1".equals(savemode)) {
			play.Logger.info("Redis ADD " + key);
			Long sadd = RedisUtil.sadd(RedisDBApp.temp7, key, String.valueOf(departinvoicesid));
			play.Logger.info("Redis ADD " + key + ", result :" + sadd);
			// 2 为删除单条
		} else if ("2".equals(savemode)) {
			play.Logger.info("Redis DEL " + key);
			Long srem = RedisUtil.srem(RedisDBApp.temp7, key, String.valueOf(departinvoicesid));
			play.Logger.info("Redis ADD " + key + ", result :" + srem);
			// 3 为清空所有
		} else if ("3".equals(savemode)) {
			play.Logger.info("Redis CLEAN " + key);
			RedisUtil.delete(RedisDBApp.temp7, key); 
		}
		return result;
	}
	
	@Override
	public List<Map<String, Object>> checktempfromredis(Global global) {
		String key = "BALANCE" + global.getUserinfo().getId();
		Set<String> smembers = RedisUtil.smembers(RedisDBApp.temp7, key);
		List<String> list = new ArrayList<String>();
		list.addAll(smembers);

		Object[] field = new Object[] { "isaudit", "routename", "id", "endstation", "departinvoicesno", "departdate",
				"code", "departtime", "ticketnum", "totalamount", "balanceamount", "printname", "printtime", "unitname",
				"vehicleno", "stationservicefee", "fueladditionfee", "agentfee", "othterfee", "supplyticketnum",
				"supplyamount", "supplybalanceamount", "status", "vehicleid", "routeid", "balanceunitid",
				"balanceunitname", "iscomputerno", "departinvoicetypename", "vehicleUnitFullName",
				"balanceUnitFullName", "datafrom", "pieces", "balanceno" };
		Object[] type = new Object[] { Integer.class, String.class, Long.class, String.class, String.class, Date.class,
				String.class, String.class, Integer.class, BigDecimal.class, BigDecimal.class, String.class,
				Timestamp.class, String.class, String.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, Integer.class, BigDecimal.class, BigDecimal.class, String.class, Long.class,
				Long.class, Long.class, String.class, Integer.class, String.class, String.class, String.class,
				String.class, Integer.class, String.class };
		if (list.isEmpty()) {
			return ListUtil.listToMap(field, null, type);
		}
		return ListUtil.listToMap(field, balanceDao.qryDepartinvoices(list), type);
	}

	@Override
	public List<Map<String, Object>> qryCleanfee(Long balanceid) {
		ActionNode actionNode = Appvar.routes.get("COMPRECHARGEHAVEDEPARTINVOICE");// 由插件名,获得插件
		if (actionNode != null) {
			return ListUtil.listToMap(new Object[] { "aaa","vehicleid", "cleanfee", "adfee", "otherfee", "recefee" },
					balanceDao.qryCleanfee(balanceid), new Object[] {String.class, Long.class, BigDecimal.class, BigDecimal.class,
							BigDecimal.class, BigDecimal.class });
		} else {
			return ListUtil.listToMap(new Object[] { "aaa","vehicleid", "cleanfee", "adfee", "otherfee", "recefee" }, null,
					new Object[] {String.class, Long.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
							BigDecimal.class });
		}
	}
}
