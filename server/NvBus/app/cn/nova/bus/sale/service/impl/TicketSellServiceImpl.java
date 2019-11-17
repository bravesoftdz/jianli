package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.UUID;
import cn.nova.bus.base.model.District;
import javax.annotation.Resource;
import javax.persistence.LockModeType;
import javax.persistence.Query;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import models.EticketNoProdRequest;
import models.EticketNumberResponse;
import models.EticketProdResponse;
import models.TestParams;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import play.Play;
import play.db.jpa.JPA;
import util.AppConstant;
import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemFactory;
import util.TransactionUtil;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipconsume;
import cn.nova.bus.archive.model.Vipconsumeldetail;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Scheduleperselldays;
import cn.nova.bus.base.model.Schedulestationcontrol;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Ticketoutletsctr;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Tickettypepermission;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.base.service.ScheduleselltickettypeService;
import cn.nova.bus.base.service.SchedulestationcontrolService;
import cn.nova.bus.base.service.impl.ScheduleselltickettypeServiceImpl;
import cn.nova.bus.base.service.impl.SchedulestationcontrolServiceImpl;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.encrypt.AuthcodeEncode;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.service.impl.InsuranceSellServiceImpl;
import cn.nova.bus.netsale.service.NetTicketSellOtherService;
import cn.nova.bus.netsale.service.impl.NetTicketSellOtherServiceImpl;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketoutletsprice;
import cn.nova.bus.price.model.Ticketoutletsrouteprice;
import cn.nova.bus.price.model.Ticketoutletstypeprice;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.price.service.impl.RoutepriceServiceImpl;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.dao.TicketsellotherDao;
import cn.nova.bus.sale.dao.TicketturnoverdetailDao;
import cn.nova.bus.sale.model.CarryChild;
import cn.nova.bus.sale.model.NetScheduleDetail;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Returntripticket;
import cn.nova.bus.sale.model.SaleDuration;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.bus.sale.model.ScheduleDetail;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.sale.model.SeatlockPK;
import cn.nova.bus.sale.model.TicketMixChange;
import cn.nova.bus.sale.model.Ticketchange;
import cn.nova.bus.sale.model.Ticketreprint;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.model.Ticketturnoverdetailepay;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.security.Global;
//import cn.nova.bus.sync.TicketSync;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.dao.OrganizationDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

import com.ning.http.util.DateUtil;

import bus365.et.EticketService;


@SuppressWarnings({"rawtypes","unchecked"})
//@TransactionManagement(TransactionManagementType.BEAN)
public class TicketSellServiceImpl implements TicketSellService {

	private static final String eStationSellTicketBusinessId = AppConstant.getValue("estationsellticket.businessid");
	
	private static final String Wd_Factor =Play.configuration.getProperty("snowflake.wdfactor.value");
	
	
	private IDAO dao = new EntityManagerDaoSurport();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private BilltypeServiceImpl billtypeService = new BilltypeServiceImpl();
	
	private TicketreturnService ticketreturnService = new TicketreturnServiceImpl();
	
	private RoutepriceService routepriceService = new RoutepriceServiceImpl();
	
	
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();
	
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	
	private VipService vipService = new VipServiceImpl();
	
	
	private SchedulestationcontrolService schedulestationcontrolService = new SchedulestationcontrolServiceImpl();
	
	
	private ScheduleselltickettypeService scheduleselltickettypeService = new ScheduleselltickettypeServiceImpl();
	
	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private NetTicketSellOtherService netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
//	
//	private TicketDao ticketDao;
//	@Resource 
//	private UserTransaction userTransaction;	
	@Resource 
//	private SessionContext context;	

	final private Logger log=LoggerFactory.getLogger(getClass());
	final private int insideInvokFalse = -67101735;
	private String gethalfprie;
	
	private String param1074 = "0"; //免票儿童是否单独打印车票，0不打印，1打印
	private Ticketturnoverdetail childchangedetail = new Ticketturnoverdetail();//改签儿童票时取儿童票票号
	
	private DigitaldictionarydetailDao dictionaryDao = new DigitaldictionarydetailDao();
	
	private TicketsellotherDao ticketsellotherDao = new TicketsellotherDao();
	
	@Override
	public List<Map<String, Object>> findSchedule(
			ScheduleAskCondition scheduleAskCondition,Global global) {
		//更新配置班次售票情况，如有异常不做处理
		try {
			updatestowgescheduleplan(scheduleAskCondition, global);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		StringBuilder sql = new StringBuilder();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		//float CarrychildRate = Float.parseFloat(parameterService.findParamValue(ParamterConst.Param_1012, global.getOrganization().getId()))/100;
		/**
		 * 将参数1012：班次最多免票带儿童占班次座位数的百分比，单位%，修改为：班次最多免票带儿童数，0固定个数，1班次座位数的百分比，默认为1。
		 * 同时增加参数1061：班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。
		 */
		Long ticketoutletid = global.getTicketoutlets().getId();
		propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid",ticketoutletid));
		Ticketoutletsctr ticketoutletsctr = (Ticketoutletsctr) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketoutletsctr.class,propertyFilters);
		String param1012 = parameterService.findParamValue(ParamterConst.Param_1012, global.getOrganization().getId());
		String param1012sql ="";
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(param1012)) { //1102是1时 班次座位百分比
			float letoutsRate = 0;
			float carrychildRate = Float.parseFloat(parameterService.findParamValue(ParamterConst.Param_1061, global.getOrganization().getId()))/100;
			if(ticketoutletsctr!=null){
				letoutsRate = (float)(ticketoutletsctr.getCarrychildrate()/100);
				carrychildRate = Math.min(carrychildRate, letoutsRate);
			}
			param1012sql="trunc((sp.seatnum-sp.fixedreserveseatnum)*"+carrychildRate+"-sp.carrychildnum)";
			param1012sql="case when "+param1012sql+"< 0 then 0  else "+param1012sql+" end  as residuecarrychildnum,";
			 //(计划班次计划座位数-固定留位)*携带儿童比例-已售儿童			
		} else {//班次座位个数
			long carrychildcount =  Long.parseLong(parameterService.findParamValue(ParamterConst.Param_1061, global.getOrganization().getId()));
			float letoutsRate = 0;
			if(ticketoutletsctr!=null){
				letoutsRate = (float)(ticketoutletsctr.getCarrychildrate()/100);
				param1012sql=carrychildcount+"-sp.carrychildnum";//可携带儿童数-已售儿童数
				param1012sql="least(case when "+param1012sql+"< 0 then 0  else "+param1012sql+" end,case when trunc((sp.seatnum-sp.fixedreserveseatnum)*"+
				letoutsRate+"-sp.carrychildnum)<0 then 0  else trunc((sp.seatnum-sp.fixedreserveseatnum)*"+letoutsRate+"-sp.carrychildnum) end )  as residuecarrychildnum,";
			}else{
				param1012sql=carrychildcount+"-sp.carrychildnum";//可携带儿童数-已售儿童数
				param1012sql="case when "+param1012sql+"< 0 then 0  else "+param1012sql+" end  as residuecarrychildnum,";
			}
		}		
		//0：表示半票票价取全票一半，1：表示取执行票价中的半票
		gethalfprie=parameterService.findParamValue(ParamterConst.Param_1058, global.getOrganization().getId());
		//0..2
		sql.append("select sp.id as scheduleplanid,sp.departdate,trim(ss.departtime),")
		//3..5
		.append("ss.departstationid,tp.reachstationid,ro.id as routeid,")
		//6..10
		.append("sp.isoriginator,sp.issaleafterreport,ss.isreported,sp.scheduleid,tp.seatnum,")
		.append("tp.id,sp.carrychildnum,sp.districttype,sp.endstationid,sp.endtime,sp.remarks,sp.islinework,")
		.append("sp.isovertime,sp.isproprietary,sp.issellable,sp.issellreturnticket,")
		.append("sp.orgid,ss.isdeparted,sp.scheduletype,sp.spacinginterval,sp.startstationid,trim(sp.starttime),sp.worktype,sp.workways,")
		.append("ss.buspark,ss.isbegincheck,ss.isemptyvehicle,ss.status,ss.ticketentrance,")
		//.append("tp.fullprice-nvl(ttp.difprice,0),");
		.append("tp.fullprice,");
		/*if(gethalfprie.equals(ParamterConst.COMMON_FLAG.FALG_NO))
		{
			if (global.getTicketoutlets().getType().equals("0"))
				sql.append(" round(((tp.fullprice)/2),0) as halfprice,");
				
			else
				sql.append(" round(tp.fullprice/2,0) as halfprice,");
		}
		else{
			sql.append(" tp.halfprice,");
		}*/
		//改为查询出来后更新
		sql.append(" tp.halfprice,");
		sql.append(" tp.issellable,tp.unautocancelreserveseatnum,")
		.append("tp.fixedreserveseatnum,tp.autocancelreserveseatnum,tp.runtime,tp.stationservicefee,tp.fueladditionfee,tp.seatnos,")
		.append(param1012sql)
		.append( "tp.seattype,tp.soldeatnum,")
		//.append(" tp.studentprice-nvl(ttp.difprice,0),")
		.append(" tp.studentprice,")
		.append(" tp.distance,tp.balancedistance,tp.toplimitprice,tp.lowerlimitprice,")
		//.append("trunc((sp.seatnum-sp.fixedreserveseatnum)*").append(CarrychildRate).append("-sp.carrychildnum) as residuecarrychildnum,tp.seattype,tp.soldeatnum,tp.studentprice-nvl(ttp.difprice,0),tp.distance,tp.balancedistance,tp.toplimitprice,tp.lowerlimitprice,")
		
//		.append(" case when sp.islinework=0 and (sp.worktype='2' or sp.worktype='3') then sp.seatnum else tp.seatnum-tp.soldeatnum-tp.fixedreserveseatnum");
//		if(!"6".equals(scheduleAskCondition.getSellway())){
//		   sql.append(" -tp.autocancelreserveseatnum-tp.unautocancelreserveseatnum ");
//		}
		
		.append(" case when sp.islinework=0 and (sp.worktype='2' or sp.worktype='3') then sp.seatnum-sp.fixedreserveseatnum-sp.soldeatnum");
		if(!"6".equals(scheduleAskCondition.getSellway())){
				sql.append("-sp.autocancelreserveseatnum-sp.unautocancelreserveseatnum ");
		}
		sql.append(" else tp.seatnum-tp.soldeatnum-tp.fixedreserveseatnum ");
		if(!"6".equals(scheduleAskCondition.getSellway())){
		   sql.append(" -tp.autocancelreserveseatnum-tp.unautocancelreserveseatnum ");
		}
		
		sql.append(" end as residueseatnum,")
//		.append("ro.name as routename,ro.returntripvaliddays,sc.code as schedulecode,sc.remarks as scheduleremarks,sc.synccode as schedulesynccode,") 
		
		.append("ro.name as routename,ro.returntripvaliddays,sc.code as schedulecode,sc.remarks as scheduleremarks,sc.synccode as schedulesynccode,") //
		
		.append("std.name as departstationname,std.code as departstationcode,str.name as reachstationname,str.code as reachstationcode,")
		.append("trim(TRANSLATE(str.secondname USING　CHAR_CS)) as reachstationsecondname,str.isroundtrip,sts.name as startstationname,ste.name as endstationname, ")
		.append("vtsvpp.type as planvehicletype,vtsvpp.grade as planvehiclegrade,vtsvpp.customname as planvehicletypecustomname,vtsvpp.id as planvheicletypeid,")
//		.append("vsvpp.vehicleno as planvehicleno,vsvpp.id as planvehicleid,usvpp.fullname as planunitname,usvpp.id as planunitid,")
		//售票查询结果的车牌和车属单位,如果有报到的取报到的,如果没有报到的取计划的,如果都没有 为空 modify by 姜蓥瑞 2016年9月20日14:37:52
		.append(" decode(vcle.id,null, vsvpp.vehicleno,vcle.vehicleno) as planvehicleno, decode(vcle.id,null,vsvpp.id,vcle.id) as planvehicleid, decode(vcle.id, null, usvpp.fullname,vcleun.fullname) as planunitname, decode(vcle.id, null, usvpp.id,vcleun.id) as planunitid,")
		.append("concat(vbmsvpp.brandname,vbmsvpp.modelcode) as planbrandmodel,nvl(vcle.vehiclebrandmodelid,vbmsvpp.id) as planbrandmodelid")
		.append(",tp.moreprice, nvl((select ts.printname from Ticketentrance ts where ts.name = ss.ticketentrance")
        .append(" and ts.orgid = ss.orgid and rownum <= 1),ss.ticketentrance) ticketentrancename,")
        
        .append(" nvl(sdp.salenum,0) discountpriceticket,nvl(sdp.price,0) discountprice11,sdp.id sdpid,sc.endstation,sc.startstationprice,")
        .append(" vcle.seattype as vcleseattype,ro.isrealnameticket as isrealnameticket,tp.discountprice,tp.roundprice,tp.connectprice ")
		.append(" from Scheduleplan sp ")
		.append("  left join vehiclereport vrt on  vrt.scheduleplanid=sp.id and vrt.isactive='1' and sp.orgid=vrt.reportorgid ")  //新增车辆报到表，如果报到则取报到车辆的车型    加 and vrt.orderno=0 解决流水班多次报到售票出现多条记录
				.append(" and ((sp.islinework=0 and vrt.orderno=0) or (sp.islinework=1 and sp.reportorderno=vrt.orderno )) ")
		.append("  left join vehicle vcle on vrt.vehicleid=vcle.id left join Unit vcleun on vcle.unitid = vcleun.id,")
		.append(" 	  Schedulevehiclepeopleplan svpp ")
		.append("      left join vehicle vsvpp on svpp.planvehicleid=vsvpp.id")
		.append("      left join Unit usvpp on svpp.planunitid=usvpp.id ,")
		.append("      Vehicletype vtsvpp, ")
		.append("      Schedulestatus ss,Ticketprice tp,")
		//新增售票点票价差额时间设置 ,并支持日期段交叉
		/*.append("      left join (select ttp.departstationid,ttp.reachstationid,ttp.scheduleid,ttp.seattype,ttp.ticketoutletsid,ttp.difprice,ttp.vehicletypeid")
		.append("      from Ticketoutletsprice ttp where ttp.starttime <=:departdate ")
		.append("      and ttp.endtime >=:departdate and ttp.ticketoutletsid =")
		.append(scheduleAskCondition.getTicketoutletsid())
		.append("      and rownum <= 1 order by ttp.starttime desc, ttp.createtime) ttp")
		.append("      on ttp.departstationid=tp.departstationid and ttp.reachstationid=tp.reachstationid")
		.append("      and ttp.scheduleid=tp.scheduleid and ttp.seattype=tp.seattype,  ")*/		
		.append(" 	  Schedule sc left join  schedulediscountprice sdp on sc.id=sdp.scheduleid and  sdp.reachstationid =").append(scheduleAskCondition.getReachStationId()).append(" and sdp.departstationid =").append(scheduleAskCondition.getDepartStationId())
		.append(" and  sdp.startdate<=date'").append(DateUtil.formatDate(new Date(), "yyyy-MM-dd")).append("' and sdp.enddate>=date'").append(DateUtil.formatDate(new Date(), "yyyy-MM-dd")).append("'")
		.append(" 	  ,Station std,Station str,Station sts,Station ste,Route ro,Vehiclebrandmodel vbmsvpp,Schedulestop scst")
		
		.append(" where sp.id=ss.scheduleplanid")
		.append(" and sp.id=svpp.scheduleplanid")
		.append(" and sp.id=tp.scheduleplanid")
		.append(" and sp.scheduleid=sc.id")
		.append(" and sp.startstationid=sts.id")
		.append(" and sp.endstationid=ste.id")
		.append(" and svpp.orderno=0")
		.append(" and svpp.planvehicletypeid=vtsvpp.id")
		.append(" and tp.departstationid=ss.departstationid")
		.append(" and tp.departstationid=std.id")
		.append(" and tp.reachstationid=str.id ")
		.append(" and sc.routeid=ro.id ")
		.append(" and svpp.planvehiclebrandmodelid=vbmsvpp.id")
		.append(" and scst.scheduleid=sc.id")
		.append(" and scst.stationid=str.id and tp.fullprice>0");
		//.append(" and (ttp.vehicletypeid = svpp.planvehicletypeid or ttp.vehicletypeid is null)");
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_tp!issellable", true));
		propertyFilters.add(new PropertyFilter("EQB_sp!issellable", true));
		String param1002 = parameterService.findParamValue(ParamterConst.Param_1002, global.getOrganization().getId());//只显示正常班次
//		if(scheduleAskCondition.getSellway()!=null && !scheduleAskCondition.getSellway().equals("")){ //去除售票途径条件，使售票问询查出的也是正常班次
			if("1".equals(param1002)){
				propertyFilters.add(new PropertyFilter("INS_ss!status", "('0','2')"));
			}
//		}
		if(!"2".equals(scheduleAskCondition.getSellway())&&scheduleAskCondition.getSellway()!=null&&!scheduleAskCondition.getSellway().trim().equals("")){
			String param1003 = parameterService.findParamValue(ParamterConst.Param_1003, global.getOrganization().getId());//已发班不显示
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(param1003)){
				//propertyFilters.add(new PropertyFilter("EQB_ss!isdeparted", false));
				sql.append(" and ((ss.isdeparted=0 and sp.islinework=0) or (sp.islinework=1) ) ");
			}
		}
		//留票销售加上过留票人过滤条件
		if("6".equals(scheduleAskCondition.getSellway())&&scheduleAskCondition.getCustomerid()>0){
			//售票点不可售站点控制
			sql.append(" and exists (")
			   .append("    select sre.id from Seatreserve sre")
			   .append("     where sre.customer.id=").append(scheduleAskCondition.getCustomerid())
			   .append("       and sre.sellstate='R'")
			   .append("       and sre.departstation.id=tp.departstationid")
			   .append("       and sre.reachstation.id=tp.reachstationid")
			   .append("       and sre.scheduleplanid=sp.id")
			   .append("     )");
		}
		if(scheduleAskCondition.getScheduleid()>0){
			propertyFilters.add(new PropertyFilter("EQL_sc!id", scheduleAskCondition.getScheduleid()));
		}
		if(scheduleAskCondition.getReachStationId()>0){
			propertyFilters.add(new PropertyFilter("EQL_tp!reachstationid", scheduleAskCondition.getReachStationId()));
		}
		if(scheduleAskCondition.getScheduleid()>0&&scheduleAskCondition.getReachStationId()>0){
			propertyFilters.add(new PropertyFilter("GED_ss!departdate", scheduleAskCondition.getDepartDate()));
			propertyFilters.add(new PropertyFilter("GED_sp!departdate", scheduleAskCondition.getDepartDate()));
			propertyFilters.add(new PropertyFilter("GED_tp!departdate", scheduleAskCondition.getDepartDate()));
		}else{
			propertyFilters.add(new PropertyFilter("EQD_ss!departdate", scheduleAskCondition.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQD_sp!departdate", scheduleAskCondition.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQD_tp!departdate", scheduleAskCondition.getDepartDate()));
		}
		if(scheduleAskCondition.getDepartStationId()!=null&&scheduleAskCondition.getDepartStationId()>0){
			propertyFilters.add(new PropertyFilter("EQL_tp!departstationid", scheduleAskCondition.getDepartStationId()));
			propertyFilters.add(new PropertyFilter("EQL_ss!departstationid", scheduleAskCondition.getDepartStationId()));
		}
	    //0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
		String param1001 = parameterService.findParamValue(ParamterConst.Param_1001, global.getOrganization().getId());//满座班次不显示
		String param1052 = parameterService.findParamValue(ParamterConst.Param_1052, global.getOrganization().getId());//特权补票能补N天前的票，0表示当天		
		if(scheduleAskCondition.getSellway()!=null&&!scheduleAskCondition.getSellway().trim().equals("")){
			if("8".equals(scheduleAskCondition.getSellway())
					||"6".equals(scheduleAskCondition.getSellway())){
					sql.append(" and sp.islinework=0")
					.append(" and sp.worktype<>'2'")
					.append(" and sp.worktype<>'3'");
			}
			if("6".equals(scheduleAskCondition.getSellway())){
				//订票只显示有留座的班次
				sql.append(" and tp.autocancelreserveseatnum+tp.unautocancelreserveseatnum>0");
			}
			if("2".equals(scheduleAskCondition.getSellway())){
				sql.append(" and tp.departdate>=trunc(sysdate-"+param1052+")");
			}
			else{
				if(ParamterConst.COMMON_FLAG.FALG_NO.equals(param1001)&&!"7".equals(scheduleAskCondition.getSellway())){//网上售票不过滤满座班次
					sql.append(" and (tp.seatnum-tp.soldeatnum-tp.autocancelreserveseatnum-tp.unautocancelreserveseatnum-tp.fixedreserveseatnum>0")
						//.append("      or sp.worktype='2'")//本区配客和跨区配客判断满座没有意义
						//.append(" 	   or sp.worktype='3'")
						.append("    )");
				}
			}
			//售票点可售班次控制
			sql.append(" and (exists (")
			.append("select toss.id from Ticketoutletssellschedule toss")
			.append(" where toss.startdate<=:departdate") 
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
			.append("   and toss.type=0)")
			.append(" or exists (")
			.append("select toss.id from Ticketoutletssellschedule toss")
			.append(" where toss.startdate<=:departdate")
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
			.append("   and toss.type=1")
			.append("   and toss.typeid=ro.id)")
			.append(" or exists (")
			.append("select toss.id from Ticketoutletssellschedule toss")
			.append(" where toss.startdate<=:departdate") 
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
			.append("   and toss.type=2")
			.append("   and toss.typeid=sc.id)")
			.append(")")
			;

			//售票机器可售班次控制
			String parmvalue_1023 = parameterService.findParamValue(ParamterConst.Param_1023, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parmvalue_1023)){
				sql.append(" and (exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(scheduleAskCondition.getIp()).append("'")
				.append("   and pss.type=0)")
				.append(" or exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(scheduleAskCondition.getIp()).append("'")
				.append("   and pss.type=1")
				.append("   and pss.typeid=ro.id)")
				.append(" or exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(scheduleAskCondition.getIp()).append("'")
				.append("   and pss.type=2")
				.append("   and pss.typeid=sc.id)")
				.append(")")
				;
			}
			//售票点不可售站点控制/
			sql.append(" and (not exists (")
			.append("select toss.id from Ticketoutletsunsellstation toss")
			.append(" where toss.startdate<=:departdate")
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
			.append(" and (toss.stationid = tp.reachstationid or toss.stationid is null) ")
			.append("   and toss.type=0)")
			.append(" and not exists (")
			.append("select toss.id from Ticketoutletsunsellstation toss")
			.append(" where toss.startdate<=:departdate")
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
				.append(" and  (toss.stationid = tp.reachstationid or toss.stationid is null) ")
			.append("   and toss.type=1")
			.append("   and toss.typeid=ro.id)")
			.append(" and not exists (")
			.append("select toss.id from Ticketoutletsunsellstation toss")
			.append(" where toss.startdate<=:departdate")
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
			.append(" and (toss.stationid = tp.reachstationid or toss.stationid is null) ")
			.append("   and toss.type=2")
			.append("   and toss.typeid=sc.id)")
			.append(" and not exists (")
			.append("select toss.id from Ticketoutletsunsellstation toss")
			.append(" where toss.startdate<=:departdate")
			.append("   and toss.enddate>=:departdate") 
			.append("   and toss.ticketoutletsid=").append(scheduleAskCondition.getTicketoutletsid())
			.append(" and (toss.stationid = tp.reachstationid or toss.stationid is null) ")
			.append("   and toss.type=3")
			.append("   and toss.typeid=scst.stationid)")
			.append(")")
			;
		}
		//当前售票站点只能售当前站及始发站发班的票，0不启用，1启用，默认为0.
		String parmvalue_1112 = parameterService.findParamValue(ParamterConst.Param_1112, global.getOrganization().getId());
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parmvalue_1112)){
			Ticketoutlets tos = (Ticketoutlets)dao.get(Ticketoutlets.class, scheduleAskCondition.getTicketoutletsid());
			if(tos!=null){
				long destartid = scheduleAskCondition.getDepartStationId();
				long nowstationid = tos.getStartstation().getId();
				if(destartid==0){
					sql.append(" and tp.departstationid in (ro.startstationid,'"+nowstationid+"')");
					sql.append(" and ss.departstationid in (ro.startstationid,'"+nowstationid+"')");
				}else{
					if(nowstationid!=destartid){
						sql.append(" and ro.startstationid="+destartid);
					}
				}
			}
		}
		
		//班次预售天数条件过滤
		if (dao.countTotalRows(Scheduleperselldays.class, "id")>0){
			sql.append("  and not exists (select max(spd.type||'-'||spd.perserlldays) from Scheduleperselldays spd where spd.orgid=tp.orgid and") 
				.append("      ((spd.type=1 and spd.typeid=sc.routeid ) or spd.type=0  or (spd.type=2 and spd.typeid=tp.scheduleid) )")
				.append(" group by spd.orgid having tp.departdate-trunc(sysdate)>substr(max(spd.type||'-'||spd.perserlldays),3)")
				.append(" )");
		}
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		sql.append(" order by sp.departdate,case when sc.islinework = 1 then sc.starttime else ss.departtime end,scst.orderno");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		if(scheduleAskCondition.getSellway()!=null&&!scheduleAskCondition.getSellway().trim().equals("")){
			query.setParameter("departdate", scheduleAskCondition.getDepartDate());
//			for (int i=1;i<=12;i++){
//				query.setParameter("departdate"+i, scheduleAskCondition.getDepartDate());
//			}
		}
		List<Object> result =  query.getResultList();
		
		////////////////////////////////过滤不符合条件的班次///////////////////////////////////////////////////////////
		Ticketoutlets ticketoutlets = (Ticketoutlets)dao.get(Ticketoutlets.class, scheduleAskCondition.getTicketoutletsid());
		boolean ticketoutlets_in="0".equals(ticketoutlets.getType());
		
		String paramValue = parameterService.findParamValue(ParamterConst.Param_1020, global.getOrganization().getId());//报到后才允许售票
		boolean issaleafterreport =ParamterConst.COMMON_FLAG.FALG_YES.equals(paramValue);//报到后售票

		String needSameStation = null;
		String needSameRoute = null;
		Ticketsell ticketsell = null;
		Route route_tobchangeticket = null;
		if("4".equals(scheduleAskCondition.getSellway())){
			needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, global.getOrganization().getId());
			ticketsell = (Ticketsell) dao.get(Ticketsell.class, scheduleAskCondition.getTicketIdToBeChange());
			
			needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameRoute)){
				Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
				route_tobchangeticket = schedule.getRoute();
			}
		}
		int originatorbeginsaletime =  new Integer(getParameterService().findParamValue(ParamterConst.Param_1034, global.getOrganization().getId()));
		Date now = new Date();
		class TimeParameter{
			short preSaleDays ;// 车票预售天数
			short excessSaleMinutes ;//补票截止时间
			short preSaleMinutes ;  //售票截止时间
		}
		Map<Long,TimeParameter> timeParameters = new HashMap<Long,TimeParameter>();
		// 查询有条件中的停靠点的所有线路售票点差额控制信息 LIST
		Schedule sch = (Schedule) dao.get(Schedule.class, scheduleAskCondition.getScheduleid());
		List<Ticketoutletsrouteprice> ttrplist=findTicketoutletsrouteprice(scheduleAskCondition.getDepartDate(),
				scheduleAskCondition.getTicketoutletsid(), sch==null?scheduleAskCondition.getReachStationId():sch.getRoute().getEndstationid());
		String pricerule = parameterService.findParamValue(ParamterConst.Param_1042, global.getOrganization().getId());
		for (Iterator iterator = result.iterator(); iterator.hasNext();) {
			Object[] row = (Object[])iterator.next();
			Long departstationid = new Long(row[3].toString());
			Long scheduleid = new Long(row[9].toString());
			Long vehicletypeid=new Long(row[70].toString());
			
			//相同到站才允许改签
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameStation)&&(departstationid!=ticketsell.getDepartstationid()
											||new Long(row[4].toString())!=ticketsell.getReachstationid())){
				iterator.remove();
				continue;
			}
			//相同线路才允许改签
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameRoute)&&(new Long(row[5].toString()))!=route_tobchangeticket.getId()){
				iterator.remove();
				continue;
			}
			//取售、补票截止时间，预售天数等参数
			TimeParameter timeParameter = null;
			if(!timeParameters.containsKey(departstationid)){  
				timeParameter = new TimeParameter();
				Organization org = getOrgByStationId(departstationid);
				Long orgid=null;
				if (org!=null) {
					orgid=org.getId();
				}
				timeParameter.preSaleDays = new Short(getParameterService().findParamValue(ParamterConst.Param_1017, orgid));// 车票预售天数
				timeParameter.excessSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1015, orgid));//补票截止时间
				if(ticketoutlets_in){
					timeParameter.preSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1018, orgid));//站内售票点售票截止时间（距离发班），单位为分钟
				}
				else{
					timeParameter.preSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1019, orgid));//站外售票点售票截止时间（距离发班），单位为分钟
				}
				timeParameters.put(departstationid, timeParameter);
			}
			else{
				timeParameter = timeParameters.get(departstationid);
			}
			
			String sellway = scheduleAskCondition.getSellway();
			if(sellway!=null&&!sellway.trim().equals("")){
				Date departdatetime = DateUtils.mergerDateAndTime((Date)row[1], (String)row[2]);
//				//报到后售票   
//				if( (
//						(Integer.parseInt(row[7].toString())==1&&originatorbeginsaletime==0)||
//						issaleafterreport
//						)
//						&&Integer.parseInt(row[8].toString())==0
//						){
//					iterator.remove();
//					continue;
//				}
//				//过路班次提前N分钟开始售票
//				if(Integer.parseInt(row[7].toString())==1&&originatorbeginsaletime>0){
//					if(DateUtils.add(now, Calendar.MINUTE, originatorbeginsaletime).before(departdatetime)){
//						iterator.remove();
//						continue;
//					}
//				}
				// 班次是否报到
				int isreported = Integer.parseInt(row[8].toString());
				//是否是报到后售票  班次计划里面的属性  班次是否是报到后售票
				int issaleafterreportstatus = Integer.parseInt(row[7].toString());  
				//过路班次
				int isoriginator = Integer.parseInt(row[6].toString()); 
				
				//1020参数开启 并且班次没有报到    移除
				if(issaleafterreport && isreported == 0 ){
					iterator.remove();
					continue;	
				}
				//如果班次报到后售票并且班次没有报到  移除
				if(issaleafterreportstatus ==1 && isreported == 0  ){
					iterator.remove();
					continue;	
				}
				//如果是过路班次 并且参数 1034  为0   移除
				if(isoriginator == 1 && originatorbeginsaletime == 0 ){
					iterator.remove();
					continue;	
				}
				//过路班次提前N分钟开始售票      如果是过路班次 并且1034>0 
				if(isoriginator==1 && originatorbeginsaletime>0){
					if(DateUtils.add(now, Calendar.MINUTE, originatorbeginsaletime).before(departdatetime)){
						iterator.remove();
						continue;
					}
				}
				//1047 补票界面只显示售票截止时间之前的班次
				if("1".equals(sellway)
						&&ParamterConst.COMMON_FLAG.FALG_NO.equals(getParameterService().findParamValue(ParamterConst.Param_1047, global.getOrganization().getId()))){
					if(DateUtils.add(departdatetime, Calendar.MINUTE, -1*timeParameter.preSaleMinutes).after(now)){
						iterator.remove();//未到售票截止时间，则删除
						continue;
					}
				}
				//班次站点售票控制 过滤示到时间及超过可售数的站点
				Schedulestationcontrol schedulestationcontrol = schedulestationcontrolService.getSchedulestationcontrol(new Long(row[5].toString()), new Long(row[4].toString()));
				if(schedulestationcontrol!=null){
					if(schedulestationcontrol.getCansellnum()==0
						||DateUtils.add(departdatetime, Calendar.MINUTE, -1*schedulestationcontrol.getCanselltime()).after(now)){
						iterator.remove();//站点不可售或未到站点开始售票时间，则过滤
						continue;
					}
					//检查已售票数
					if(schedulestationcontrol.getCansellnum()>0&&schedulestationcontrol.getCansellnum()<Integer.parseInt(row[10].toString())
						&&ParamterConst.COMMON_FLAG.FALG_NO.equals(param1001)&&!"7".equals(scheduleAskCondition.getSellway())){//网上售票不过滤满座班次
						Map<String,Object> conditionmap = new HashMap<String, Object>();
						conditionmap.put("departdate", (Date)row[1]);
						conditionmap.put("scheduleid", new Long(row[9].toString()));
						conditionmap.put("reachstationid", new Long(row[4].toString()));
						conditionmap.put("ticketstatus", "0");
						int stationsellcount = (int) dao.countTotalRows(Ticketsell.class, conditionmap, "id");
						if(stationsellcount>=schedulestationcontrol.getCansellnum()){
							iterator.remove();//站点可售张数已经售完，则过滤
							continue;
						}
					}
				}
				
			}
			if(sellway==null||sellway.trim().equals("")){
				sellway = "2"; //与特权补票同权限
			}
			//过滤售补票截止时间、预售期过滤
			if(!SaleDuration.isInTime(sellway,(Date)row[1],(String)row[2],
					timeParameter.preSaleDays,timeParameter.preSaleMinutes,timeParameter.excessSaleMinutes,now)){
				iterator.remove();
				continue;
			}
			//更新售票点价差信息
			//全票
			BigDecimal fullprice = new BigDecimal(row[35].toString());
			BigDecimal halfprice = new BigDecimal(row[36].toString());
			BigDecimal studentprice = new BigDecimal(row[48].toString());	
			int interday=-1;
			
			//参数1090: 是否开启票价差额功能: 0否,1是;控制范围包含售票点票价差额,线路售票点票价差额,售票点票种差额
			String p1090 = getParameterService().findParamValue(ParamterConst.Param_1090, global.getOrganization().getId());
			if (ParamterConst.COMMON_FLAG.FALG_YES.equals(p1090)) {
				List<Ticketoutletsprice> ttflist = findTicketoutletsprice(scheduleAskCondition.getDepartDate(),
						scheduleAskCondition.getTicketoutletsid(), scheduleAskCondition.getReachStationId());
				// 售票点票价差额===============================
				Ticketoutletsprice tsp = null;
				for (Ticketoutletsprice ttf : ttflist) {
					if (ttf.getDepartstationid() == departstationid && ttf.getScheduleid() == scheduleid
							&& ttf.getVehicletypeid() == vehicletypeid) {
						int curinterday = 0;
						int curinterday1 = DateUtils.compare(scheduleAskCondition.getDepartDate(), ttf.getStarttime());
						int curinterday2 = DateUtils.compare(scheduleAskCondition.getDepartDate(), ttf.getStarttime());
						if (curinterday1 < curinterday2) {
							curinterday = curinterday1;
						} else {
							curinterday = curinterday2;
						}
						if (interday == -1) {
							interday = curinterday;
							tsp = ttf;
						} else {
							if (curinterday < interday) {
								tsp = ttf;
							}
						}
					}
				}
				if (tsp != null) {
					// 0：表示半票票价取全票一半，1：表示取执行票价中的半票
					if (ParamterConst.COMMON_FLAG.FALG_NO.equals(gethalfprie)) {// 0：表示半票票价取全票一半
						if (CurrentUtil.getGlobal().getTicketoutlets().getType().equals("0")) {
							halfprice = routepriceService.mathPriceByRule(pricerule,
									fullprice.subtract(tsp.getDifprice()).divide(new BigDecimal(2)));
						} else {
							halfprice = routepriceService.mathPriceByRule(pricerule,
									fullprice.divide(new BigDecimal(2)));
						}
					} else {
						halfprice = routepriceService.mathPriceByRule(pricerule, halfprice.subtract(tsp.getDifprice()));
					}
					row[36] = halfprice;
					fullprice = fullprice.subtract(tsp.getDifprice());
					row[35] = fullprice;
					studentprice = studentprice.subtract(tsp.getDifprice());
					row[48] = studentprice;
				}
				// ==========================================
				// 线路票价差额控制 ===============================
				Ticketoutletsrouteprice trp = null;
				if (tsp == null && ttrplist != null) {
					for (Ticketoutletsrouteprice ttf : ttrplist) {
						Route r = (Route) dao.get(Route.class, ttf.getRouteid());
						if (r.getStartstationid() == departstationid) {
							int curinterday = 0;
							int curinterday1 = DateUtils.compare(scheduleAskCondition.getDepartDate(),
									ttf.getStartdate());
							int curinterday2 = DateUtils.compare(scheduleAskCondition.getDepartDate(),
									ttf.getEnddate());
							if (curinterday1 < curinterday2) {
								curinterday = curinterday1;
							} else {
								curinterday = curinterday2;
							}
							if (interday == -1) {
								interday = curinterday;
								trp = ttf;
							} else {
								if (curinterday < interday) {
									trp = ttf;
								}
							}
						}
					}
				}
				if (trp != null) {
					// 0：表示半票票价取全票一半，1：表示取执行票价中的半票
					if (ParamterConst.COMMON_FLAG.FALG_NO.equals(gethalfprie)) {// 0：表示半票票价取全票一半
						if (CurrentUtil.getGlobal().getTicketoutlets().getType().equals("0")) {
							halfprice = routepriceService.mathPriceByRule(pricerule,
									fullprice.subtract(trp.getPrice()).divide(new BigDecimal(2)));
						} else {
							halfprice = routepriceService.mathPriceByRule(pricerule,
									fullprice.divide(new BigDecimal(2)));
						}
					} else {
						halfprice = routepriceService.mathPriceByRule(pricerule, halfprice.subtract(trp.getPrice()));
					}
					row[36] = halfprice;
					fullprice = fullprice.subtract(trp.getPrice());
					row[35] = fullprice;
					studentprice = studentprice.subtract(trp.getPrice());
					row[48] = studentprice;

				}
				// ==================================
				// 售票点票种差额控制======================
				Ticketoutletstypeprice typ = null;
				long schid_temp = new Long(row[9].toString());
				if (tsp == null && trp == null && ttrplist.isEmpty()) {
					List<Ticketoutletstypeprice> typlist = findTicketoutletstypeprice(
							scheduleAskCondition.getDepartDate(), scheduleAskCondition.getTicketoutletsid(),
							schid_temp);
					typ = typlist != null && typlist.size() > 0 ? typlist.get(0) : null;
				}
				if (typ != null) {
					try {
						ScriptEngineManager manager = new ScriptEngineManager();
						final ScriptEngine engine = manager.getEngineByName("js");
						if (engine == null) {
							play.Logger.info("No engine for JavaScript");
						}
						if (typ.getFullpriceformula().indexOf("Q") < 0 || typ.getHalfpriceformula().indexOf("Q") < 0
								|| typ.getStudentpriceformula().indexOf("Q") < 0) {
							play.Logger.error("发车日期" + scheduleAskCondition.getDepartDate() + ",班次ID:"
									+ scheduleAskCondition.getScheduleid() + ",售票点ID:"
									+ scheduleAskCondition.getTicketoutletsid() + "的票种公式设置有误,请检查!");
						}
						String fullprice_formual = typ.getFullpriceformula().replaceAll("Q", fullprice.toString());
						String halfprice_formual = typ.getHalfpriceformula().replaceAll("Q", fullprice.toString());
						String studentprice_formual = typ.getStudentpriceformula().replaceAll("Q", fullprice.toString());
						BigDecimal fullprice_temp = new BigDecimal(engine.eval(fullprice_formual).toString());
						BigDecimal halfprice_temp = new BigDecimal(engine.eval(halfprice_formual).toString());
						BigDecimal studentprice_temp = new BigDecimal(engine.eval(studentprice_formual).toString());
						row[36] = routepriceService.mathPriceByRule(pricerule, halfprice_temp);
						row[35] = routepriceService.mathPriceByRule(pricerule, fullprice_temp);
						row[48] = routepriceService.mathPriceByRule(pricerule, studentprice_temp);
					} catch (Exception e) {
						e.printStackTrace();
						row[36] = halfprice;
						row[35] = fullprice;
						row[48] = studentprice;
					}

				}
				//==============================
			}
		}
		return ListUtil.listToMap(new Object[]{"scheduleplanid","departdate","departtime",
											   "departstationid","reachstationid","routeid",
											   "isoriginator","issaleafterreport","isreported","scheduleid","seatnum",
											   
											   "id","carrychildnum","districttype","endstationid","endtime","remarks","islinework",
											   "isovertime","isproprietary","issellable","issellreturnticket",
											   "orgid","isdeparted","scheduletype","spacinginterval","startstationid","starttime","worktype","workways",
							
											   "buspark","isbegincheck","isemptyvehicle","status","ticketentrance",
											   "fullprice","halfprice","issellable","unautocancelreserveseatnum",
											   "fixedreserveseatnum","autocancelreserveseatnum","runtime","stationservicefee","fueladditionfee","seatnos",
											   "residuecarrychildnum","seattype","soldeatnum","studentprice","distance","balancedistance","toplimitprice","lowerlimitprice",
				   
												"residueseatnum","routename","returntripvaliddays","schedulecode","scheduleremarks","schedulesynccode",
												"departstationname","departstationcode","reachstationname","reachstationcode","reachstationsecondname","isroundtrip","startstationname","endstationname",
												"planvehicletype","planvehiclegrade","planvehicletypecustomname","planvheicletypeid",
												 "planvehicleno","planvehicleid","planunitname", "planunitid",
												 "planbrandmodel","planbrandmodelid"
												 ,"moreprice","ticketentrancename","discountpriceticket","discountprice11","sdpid","endstation","startstationprice","vcleseattype","isrealnameticket"
												,"discountprice","roundprice","connectprice"}, 
								  result,
								  new Object[]{Long.class,Date.class,String.class,
											   Long.class,Long.class,Long.class,
											   Boolean.class,Boolean.class,Boolean.class,Long.class,Integer.class,
											   
											   Long.class,Short.class,String.class,Long.class,String.class,String.class,Boolean.class,
											   Boolean.class,Boolean.class,Boolean.class,Boolean.class,
											   Long.class,Boolean.class,String.class,Short.class,Long.class,String.class,String.class,String.class,
							
											   String.class,Boolean.class,Boolean.class,String.class,String.class,
											   BigDecimal.class,BigDecimal.class,Boolean.class,Short.class,
											   Short.class,Short.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,String.class,
											   Short.class,String.class,Short.class,BigDecimal.class,Integer.class,Integer.class,BigDecimal.class,BigDecimal.class,
				
												Integer.class,String.class,Short.class,String.class,String.class,String.class,
												String.class,String.class,String.class,String.class,String.class,Boolean.class,String.class,String.class,
												String.class,String.class,String.class,Long.class,
												String.class,Long.class,String.class,Long.class,
												String.class,Long.class
												,BigDecimal.class,String.class,Short.class,BigDecimal.class,Long.class,String.class,BigDecimal.class,String.class,Boolean.class
												,BigDecimal.class,BigDecimal.class,BigDecimal.class}
								  );
	}
	
	
	
	/**
	 * 查询售票点票种差额
	 * @param departDate
	 * @param ticketoutletsid
	 * @param scheduleid
	 * @return
	 */
	private List<Ticketoutletstypeprice> findTicketoutletstypeprice(Date departDate, long ticketoutletsid,
			long scheduleid) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", scheduleid));
		propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid", ticketoutletsid));
		propertyFilters.add(new PropertyFilter("LED_t!startdate", departDate));
		propertyFilters.add(new PropertyFilter("GED_t!enddate", departDate));		
		return  dao.find(Ticketoutletstypeprice.class, propertyFilters);
	}




	private List<Ticketoutletsrouteprice> findTicketoutletsrouteprice(Date departdate,long ticketoutletsid,long reachstationid) {
		//处理售票点价差
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if(reachstationid>0){
			propertyFilters.add(new PropertyFilter("EQL_t!routestopid", reachstationid));
		}
		propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid", ticketoutletsid));
		propertyFilters.add(new PropertyFilter("LED_t!startdate", departdate));
		propertyFilters.add(new PropertyFilter("GED_t!enddate", departdate));		
//		propertyFilters.add(new PropertyFilter("EQL_t!routeid", routeid));		
		return  dao.find(Ticketoutletsrouteprice.class, propertyFilters);
	}
	
	private List<Ticketoutletsprice> findTicketoutletsprice(Date departdate,long ticketoutletsid,long reachstationid) {
		//处理售票点价差
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if(reachstationid>0){
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", reachstationid));
		}
		propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid", ticketoutletsid));
		propertyFilters.add(new PropertyFilter("LED_t!starttime", departdate));
		propertyFilters.add(new PropertyFilter("GED_t!endtime", departdate));		
		return  dao.find(Ticketoutletsprice.class, propertyFilters);
	}
	
	private Organization getOrgByStationId(long departstationid){
		//根据departStationid取orgId
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!station.id", departstationid));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
		return org;	
	}

	@Override
	public MethodResult sellTicket(String transationId, TicketOrder order,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		param1074 = parameterService.findParamValue(ParamterConst.Param_1074, global.getOrganization().getId());//免票儿童是否单独打印车票，0不打印，1打印
		 //窗口是否售电子票及出票方式，0窗口不售电子票，1售电子票仅打印纸质小票，2售电子票仅打印纸质车票，3售电子票且打印（纸质小票+纸质车票），4售电子票但不打印（纸质小票+纸质车票），默认0
		String param1096 = parameterService.findParamValue(ParamterConst.Param_1096, global.getOrganization().getId());
		List<Ticketsell> listEstationsell =  new ArrayList<Ticketsell>();//车站售电子票list(非单独儿童)
		List<String> eticketnos= new ArrayList<String>();//电子票号返回结果集
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		
		//计算消耗票证数
		int printticketcount = order.getTickets().size();
		//计算半票数
		int bNum = 0;
		//计算团体票或包车票数
		int tOrhNum = 0;
		
		int changeServiceFeeBillNum = 0; //改签手续费凭证打印张数
		int supplementServiceFeeBillNum = 0; //补票凭证打印张数
		
		boolean isEstationsell = false;//是否是车站售电子票
		boolean isprintonsellestation = false;//电子票是否打印车票
		int tickets =order.getTickets().size();
		String batchno = util.DateUtils.DateToStrNoAcross(now);
		if("2".equals(param1096)){
			isprintonsellestation = true;
		}
		if("3".equals(param1096)){
			isprintonsellestation = true;
		}
		
		play.Logger.info("-------计算团体票数开始---------");
		BigDecimal totalmoney = new BigDecimal(0);//累计票价
		for (TicketPrintInfo ticketPrintInfo : order.getTickets()) {
			totalmoney = totalmoney.add(ticketPrintInfo.getPrice());
			if("B".equals(ticketPrintInfo.getTickettype())){
				bNum++;
			}
			Station reachstation = (Station) dao.get(Station.class, ticketPrintInfo.getReachstationid());
			if(reachstation.getIsroundtrip()){
				printticketcount++;
			}
			
			if("T".equals(ticketPrintInfo.getTickettype())||"H".equals(ticketPrintInfo.getTickettype())){
				tOrhNum++;
			}
			if(ticketPrintInfo.isIsestationsell() && ! isEstationsell && !"0".equals(param1096)){
				isEstationsell = true;
			}
		}
		play.Logger.info("-------计算团体票数结束---------");
		if(isEstationsell && !isprintonsellestation){
			order.setStartTicketNO("0");
		}
		Long ticketno = new Long(order.getStartTicketNO());
		if(tOrhNum>0){
		    printticketcount = printticketcount-tOrhNum+1;
		}
		//如果是团体票或包车票、只打印一张车票
		if("T".equals(order.getTickets().get(0).getTickettype())||"H".equals(order.getTickets().get(0).getTickettype())){
			if(tOrhNum==order.getTickets().size()){
				printticketcount=1;
			}
		}
		
		int isSetServicefee = order.getTickets().get(0).getServicefee().compareTo(new BigDecimal(0));
		boolean isPrintBookService = false;
		if(isSetServicefee==1){//设置改签或补票手续费
		
			//改签消耗票证数
		   if(order.getSellway().equals("4")){
			   if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1066, global.getOrganization().getId()))){
				   printticketcount++;
				   changeServiceFeeBillNum++;
			   }
		   }		
		   //补票消耗票证数
		   if((order.getSellway().equals("1")||order.getSellway().equals("2"))&&
				   (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1069, global.getOrganization().getId())))){
//			   for(int i=0;i<order.getTickets().size();i++){
//				   printticketcount++;
//			   }
			   printticketcount++;
			   supplementServiceFeeBillNum++; // 补票凭证打印张数
			   isPrintBookService = true;
		   }		
		}
		
		List<TicketPrintInfo> returntripticketPrintInfos = new ArrayList<TicketPrintInfo>();
		play.Logger.info("-------售票跳号开始---------");
		int jumpNums = 0;
		if ((!isEstationsell) || (isEstationsell && isprintonsellestation)) {
			 jumpNums = printticketcount;//售票总跳号数：包含车票、改签凭证、补票凭证数
		}
		Billinuse billinuse = null;
		if (isSetServicefee == 1 && order.getSellway().equals("4")) { // 改签时跳号
			if ("T".equals(order.getTickets().get(0).getTickettype())) {
				// 如果改签后车票为团体票
				billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(), "Ticket",
						order.getStartTicketNO(), printticketcount);
			} else {
				// int
				// changeprintticketcount=printticketcount+(order.getTickets().size()-1);
				// billinuse =
				// billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),changeprintticketcount);
				
				/*int changeprintticketcount = printticketcount + (order.getTickets().size() - 1);
				jumpNums = changeprintticketcount;
				if (ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074)) {// 参数1074：免票儿童是否单独打印车票，0不打印，1打印
					changeprintticketcount = changeprintticketcount + childprintnum;// 加上需要打印的儿童票数
					billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(), "Ticket",
							order.getStartTicketNO(), changeprintticketcount);
				} else {
					billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(), "Ticket",
							order.getStartTicketNO(), changeprintticketcount);
				}*/
				int changeprintticketcount = printticketcount;
				if ((!isEstationsell) || (isEstationsell && isprintonsellestation)) {
					// 改签，非团体票，使用新票号，儿童票：若打印儿童票，则需要跳儿童票张数
					if (ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074)) {// 参数1074：免票儿童是否单独打印车票，0不打印，1打印
						changeprintticketcount = changeprintticketcount + childprintnum;// 加上需要打印的儿童票数
					}
					billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(), "Ticket",
							order.getStartTicketNO(), changeprintticketcount);
				}
				jumpNums = changeprintticketcount;
			}

		} else {
			if( (!isEstationsell) || (isEstationsell && isprintonsellestation)){
				billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),printticketcount);
			}
		}
		play.Logger.info("-------售票跳号结束---------");
		
		Billinventory billinventory =  null;
		if(null != billinuse){
			 billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid());	
		}
		//查询售票点售票管理儿童数量以及售票点最大售票金额,携带儿童数量与系统配置取其低
		Long ticketoutletid = order.getTicketoutletsid();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid",ticketoutletid));
		Ticketoutletsctr ticketoutletsctr = (Ticketoutletsctr) dao.uniqueResult(Ticketoutletsctr.class,propertyFilters);
		if(ticketoutletsctr!=null){
			TicketturnoverdetailDao detailDao = new TicketturnoverdetailDao();
			BigDecimal sumMoney = detailDao.querySumMoneyByLetoutsid(ticketoutletid);
			if(sumMoney.add(totalmoney).compareTo(new BigDecimal(0).valueOf(ticketoutletsctr.getMaxsellmoney())) > 0){
				throw new ServiceException("0482"); //售票点不能超过上缴金额最大值
			}
		}
		//插入或修改应缴款表
		play.Logger.info("-------插入或修改应缴款表开始-------");
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(global.getUserinfo().getId(), order.getStartTicketNO());
		ticketturnoverdetail.setTicketprintnum(ticketturnoverdetail.getTicketprintnum() + jumpNums);//加跳号数：跳号数即物理票使用张数
		ticketturnoverdetail.setChangeprintnum(ticketturnoverdetail.getChangeprintnum() + changeServiceFeeBillNum);//改签打印凭证数
		ticketturnoverdetail.setSupplementprintnum(ticketturnoverdetail.getSupplementprintnum() + supplementServiceFeeBillNum);//改签打印凭证数
		
		if("0".equals(ticketturnoverdetail.getTicketstartno())){
			ticketturnoverdetail.setTicketstartno(order.getStartTicketNO());
		}
		if(isSetServicefee==1 && order.getSellway().equals("4")){ //改签时售票员营收缴款明细表中的截止票号 
			if("T".equals(order.getTickets().get(0).getTickettype())){
				//团体票改签时，截止票号 = 开始票号 数(改签后票号)+ 消耗票证数 - 1
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(ticketno + printticketcount - 1).toString(),order.getStartTicketNO().length(), "0"));
			}else{
//				ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(ticketno+printticketcount-1+order.getTickets().size()-1).toString(),order.getStartTicketNO().length(), "0"));
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074)){//参数1074：免票儿童是否单独打印车票，0不打印，1打印
					printticketcount = printticketcount + childprintnum;//加上需要打印的儿童票数
				}
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(ticketno+printticketcount-1+order.getTickets().size()-1).toString(),order.getStartTicketNO().length(), "0"));
			}
		}else{
			if( (!isEstationsell) || (isEstationsell && isprintonsellestation)){
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(ticketno+printticketcount-1).toString(),order.getStartTicketNO().length(), "0"));
			}
		}
		//团体票营收应该存售票数为1
		TicketPrintInfo tp =  order.getTickets().get(0);
		if("T".equals(tp.getTickettype())){
			ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+1);
		}else{
			if("1".equals(param1074)){
				ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getTickets().size());
//				ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getTickets().size() + childprintnum);//缴款明细中加上改签新售儿童票票数
				//ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getTickets().size() + newChildList.size());//缴款明细中加上改签新售儿童票票数
			}else{
				ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getTickets().size());
			}
		}
		//paymethod 2为贵宾卡
		if(!"0".equals(tp.getPaymethod())&&!"2".equals(tp.getPaymethod())){
//			查询支付订单表
			Map<String,Object> payinfomap = new HashMap<String, Object>();
			payinfomap.put("orderno", order.getOrderno());
			payinfomap.put("paystatus", 1);
			int payinfocount = (int) dao.countTotalRows(Payinfo.class,payinfomap,"id");
			if(payinfocount<=0){
				throw new BusinessException("电子支付订单未找到对应的支付订单信息!");	
			}
		}
		if("1".equals(tp.getPaymethod()) || "4".equals(tp.getPaymethod()) || "5".equals(tp.getPaymethod()) || "2".equals(tp.getPaymethod())
				|| "6".equals(tp.getPaymethod()) || "3".equals(tp.getPaymethod())
				|| "10".equals(tp.getPaymethod())|| "11".equals(tp.getPaymethod())){//非现金统计票数
			if("T".equals(tp.getTickettype())){
				ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
			}else{
				ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+order.getTickets().size());
			}
		}
		Map<TicketPrintInfo,Ticketsell> ticketsells = new HashMap<TicketPrintInfo, Ticketsell>();
		ticketno = ticketno -1;
		boolean canSellDepartedSchedule = false;
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1028, global.getOrganization().getId()))){
			canSellDepartedSchedule = true;
		}

		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		//缴款明细表加字段
		if(null != billinventory){
			ticketturnoverdetail.setBatchno(billinventory.getBatchno());
			order.setBatchno(billinventory.getBatchno());	
		}else{
			order.setBatchno(batchno);	
			ticketturnoverdetail.setBatchno(batchno);
		}
		if(null != billinuse){
			ticketturnoverdetail.setBillinuseid(billinuse.getId());	
		}
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		
		childchangedetail = ticketturnoverdetail;//赋值给儿童票detail
		
		//start 电子支付明细表
		Ticketturnoverdetailepay ticketturnoverdetailepay = null;
		if(order.getTickets().size()>0 ){
			ticketturnoverdetailepay = getTicketturnoverdetailService().getCurTicketturnoverdetailepay(ticketturnoverdetail,global.getUserinfo().getId(),order.getTickets().get(0).getPaymethod());
			ticketturnoverdetailepay.setTicketnum(ticketturnoverdetailepay.getTicketnum()+order.getTickets().size());
			ticketturnoverdetailepay.setUpdateby(global.getUserinfo().getId());
			ticketturnoverdetailepay.setUpdatetime(new Date());
		}
		//end 电子支付明细表
		play.Logger.info("-------插入或修改应缴款表结束-------");
		//1051:售票员缴款金额上限（达到金额后，必须缴款）
		play.Logger.info("-------售票员缴款金额上限判断开始-------");
		Float turnovermaney = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1051, global.getOrganization().getId()));
		if(turnovermaney>0){
			BigDecimal totolprice=getTicketturnoverdetailService().qryNoTicketturnoverPrice(global.getUserinfo().getId());
			if(totolprice.floatValue()>=  turnovermaney){			
				throw new ServiceException("0461"); //未缴款金额达到上限，请先缴款
			}
		}
		play.Logger.info("-------售票员缴款金额上限判断结束-------");
		Vip vip = null;
		Vipconsume vipconsume = null;
		/**
		 * 将参数1012：班次最多免票带儿童占班次座位数的百分比，单位%，修改为：班次最多免票带儿童数，0固定个数，1班次座位数的百分比，默认为1。
		 * 同时增加参数1061：班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。
		 */
		String param1012 = parameterService.findParamValue(ParamterConst.Param_1012, global.getOrganization().getId());
		String param1061 = parameterService.findParamValue(ParamterConst.Param_1061, global.getOrganization().getId());
		if(order.getVipcardno()!=null&&"2".equals(order.getTickets().get(0).getPaymethod())){
			vip = vipService.findByCardNo(order.getVipcardno(),"0");
			if(vip == null){
				throw new ServiceException("0411"); //找不到VIP卡信息		
			}else if(!"0".equals(vip.getStatus())){//状态：0正常,1已退,2挂失,3注销,4过期,5已补卡 取数据字典
				throw new ServiceException("0412"); //VIP卡当前状态异常
			}
			vip.setVipgrade(order.getVipgrade());
			vip.setMoney(order.getVipmoney());
			vip.setVipamount(order.getVippoint());

			vipconsume = new Vipconsume();
			vipconsume.setCreateby(order.getSeller());
			vipconsume.setCreatetime(now);
			vipconsume.setUpdateby(vipconsume.getCreateby());
			vipconsume.setUpdatetime(vipconsume.getCreatetime());
//			if("2".equals(order.getTickets().get(0).getPaymethod())){
				vipconsume.setType("0"); //余额购票
				vipconsume.setMoneychange(order.getTotalmoney().multiply(new BigDecimal(-1)));
				vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
//			}else{
//				vipconsume.setType("3"); //只积分
//			}
			vipconsume.setPointchange(order.getTotalmoney());
			vipconsume.setRemainpoint(vip.getVipamount().add(vipconsume.getPointchange()));
			vipconsume.setVipcardno(vip.getVipcardno());
			vipconsume.setVipconsumeldetails(new ArrayList<Vipconsumeldetail>());
			vipconsume.setVipgrade(vip.getVipgrade());
			vipconsume.setVipid(vip.getId());
			
			vip.setMoney(vipconsume.getRemainmoney());
			vip.setVipamount(vipconsume.getRemainpoint());
			vip = (Vip) dao.merge(vip);
		}else if(order.getVipcardno()==null&&"2".equals(order.getTickets().get(0).getPaymethod())){
			//没有传入卡号，但支付方式为 余额支付或积分支付
			throw new ServiceException("0413"); //VIP卡号不允许为空
		}
		Ticketoutlets ticketoutlets = (Ticketoutlets) dao.get(Ticketoutlets.class, order.getTicketoutletsid());
		Scheduleplan scheduleplan_last = null;
		
		if(tOrhNum>0){
			int a = order.getTickets().size()-tOrhNum;
			
			Long b = Long.parseLong(order.getStartTicketNO())+new Long(a);
			String str = StringUtils.strPad(String.valueOf(b),order.getStartTicketNO().length(), "0");
			order.setStartTicketNO(str);
			
		}
		int changeticketnum = 0; //记录改签车票数		
		
		String p1074 = parameterService.findParamValue("1074", global.getOrganization().getId());//参数1074，免票儿童是否单独打印车票，0不打印，1打印
		List<TicketPrintInfo> kidList = new ArrayList<TicketPrintInfo>();//order:携童票信息
		List<Ticketsell> carryList = new ArrayList<Ticketsell>();//携童票所属售票记录list，供生成返回打印车票信息使用
//		Ticketsell kidTemplate = null;//儿童票记录模板，取自售票记录
		List<TicketPrintInfo> allList = order.getTickets();//order中所有车票
		Iterator<TicketPrintInfo> iterator = allList.iterator();
		while (iterator.hasNext()) {
			TicketPrintInfo tpi = iterator.next();
			if("E".equals(tpi.getTickettype())){
				//免票儿童费用字段设置为0
				tpi.setFullprice(java.math.BigDecimal.ZERO);
				tpi.setPrice(java.math.BigDecimal.ZERO);
				tpi.setMoreprice(java.math.BigDecimal.ZERO);
				tpi.setServicefee(java.math.BigDecimal.ZERO);
				tpi.setToplimitprice(java.math.BigDecimal.ZERO);
				tpi.setFueladditionfee(java.math.BigDecimal.ZERO);
				tpi.setStationservicefee(java.math.BigDecimal.ZERO);
				tpi.setComputefee(java.math.BigDecimal.ZERO);
				tpi.setCoolairfee(java.math.BigDecimal.ZERO);
				tpi.setAdditionfee(java.math.BigDecimal.ZERO);
				tpi.setWaterfee(java.math.BigDecimal.ZERO);
				tpi.setInsurefee(java.math.BigDecimal.ZERO);
				tpi.setOtherfee(java.math.BigDecimal.ZERO);
				
				kidList.add(tpi);
				iterator.remove();//移除order中携童票信息，只售其他非免票的车票
			}
		}
		Map<Long,Scheduleplan> splists=new HashMap<Long,Scheduleplan>();
		List<Ticketprice> tplists=new ArrayList<Ticketprice>();
		//判断是否都是跨区配载班次,防止加入购物车的有跨区配载和其他的班次类型(单营)一起
		boolean worktype3  = false;//本次售票有跨区配载班次
		boolean notworktype3 = false;// 本次售票有非跨区配载班次
		//如果1076参数是0  实名制售票是不允许同一证件购买同一班次的多张车票
		boolean Param_1076 = parameterService.findParamValue(ParamterConst.Param_1076, global.getOrganization().getId()).equals("0");
		int cut=0;
		for (TicketPrintInfo detail : order.getTickets()) {
			Schedule schedule = (Schedule) dao.get(Schedule.class, detail.getScheduleid());
			changeticketnum++;
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!id", detail.getScheduleplanid()));
			play.Logger.info("--------查找班次计划开始----------");
			Scheduleplan scheduleplan=null;
			if(schedule.getIslinework()){
			    if(!splists.containsKey(detail.getScheduleplanid())){
			    	scheduleplan = (Scheduleplan) dao.uniqueResult(Scheduleplan.class, propertyFilters);
					dao.getEntityManager().detach(scheduleplan);
					splists.put(detail.getScheduleplanid(), scheduleplan);
			    }else{
			    	scheduleplan=splists.get(detail.getScheduleplanid());
			    }
				//dao.getEntityManager().flush();
			}else{
				scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
			}
			
			play.Logger.info(" 本次售票的班次类型 scheduleplan.getWorktype() : " + scheduleplan.getWorktype()+"  scheduleplanId   : "+ scheduleplan.getId());
			if("3".equals(scheduleplan.getWorktype())){
				worktype3 = true;
			}else{
				notworktype3 = true;
			}
			if(worktype3 && notworktype3){
				methodResult.setResult(0);
				methodResult.setResultMsg("跨区配载班次不能与其他班次类型一起出售!");
				return methodResult;
			}
			play.Logger.info("--------查找班次计划结束----------");
			//检查班次状态
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", detail.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", detail.getDepartstationid()));
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));			
			play.Logger.info("-----根据班次计划ID和发车站ID查找班次状态开始----------");
			Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(Schedulestatus.class, propertyFilters);
			play.Logger.info("-----根据班次计划ID和发车站ID查找班次状态结束 ----------");
			if(schedulestatus==null){
				//回滚
				throw new ServiceException("0203"); //班次状态记录不存在				
			}
			if(!scheduleplan.getIslinework() &&
					schedulestatus.getIsdeparted()&&!(order.getSellway().equals("2")&&canSellDepartedSchedule)){
				throw new ServiceException("0198"); //该班次已发班		
			}
			else if("1".equals(schedulestatus.getStatus())){
				throw new ServiceException("0199"); //该班次班次已报停		
			}
			else if("3".equals(schedulestatus.getStatus())){
				throw new ServiceException("0200"); //该班次班次已被并	
			}
			else if("4".equals(schedulestatus.getStatus())){
				throw new ServiceException("0201"); //该班次班次已脱班			
			}
			else if("5".equals(schedulestatus.getStatus())){
				throw new ServiceException("0202"); //该班次班次已停售		
			}
			
			Date departdatetime = DateUtils.mergerDateAndTime(schedulestatus.getDepartdate(),schedulestatus.getDeparttime());
			String sellway=order.getSellway();	
			// 售票
			if("0".equals(sellway)){
				if(departdatetime.before(now)){
					throw new ServiceException("0465"); //已过发车时间
				}
			}			
			//锁定班次并更新剩余票数
			scheduleplan_last = scheduleplan;
			if(!scheduleplan.getIslinework()&&"2".equals(scheduleplan.getWorktype())){
				//如果是非流水班而且是本区配客班次，再次校验座位是否可售
				//根据发车站、到达站查售票表。交叉的座位不可售
				play.Logger.info("----根据发车站和到达站查售票表开始----------");
				List<Ticketsell> selledseat =findSectionTicketsells(scheduleplan,detail.getDepartstationid(),detail.getReachstationid(),detail.getSeatno());
				play.Logger.info("----根据发车站和到达站查售票表开始----------");
				if(selledseat!=null&&selledseat.size()>0){
					//该座位已经被售出，重新选位
					//查出所有不可售的座位
					play.Logger.info("----查出所有不可售的座位开始----------");
					List<Ticketsell> selledseats =findSectionTicketsells(scheduleplan,detail.getDepartstationid(),detail.getReachstationid(),null);
					play.Logger.info("----查出所有不可售的座位结束----------");
					short selseatno = 0; //可售空位
					short beforeSelledSeatno = 0;//前一个已售座位号
					for (Ticketsell ticketsell : selledseats) {
						if(ticketsell.getSeatno()>beforeSelledSeatno+1){
							selseatno = (short) (beforeSelledSeatno+1);
							break;
						}
						beforeSelledSeatno = ticketsell.getSeatno();
					}
					//如果还没有合适的座位，则返回错误
					if(selseatno==0||selseatno>scheduleplan.getSeatnum()){
						throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
								"0205",true); //座位不是锁定状态
					}else{
						detail.setSeatno(selseatno);
					}
				}
			}
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()+1));	
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+detail.getCarrychildnum()));
			
			scheduleplan.setCursoldeatnum(scheduleplan.getCursoldeatnum()+1);
			scheduleplan.setCurcarrychildnum(scheduleplan.getCurcarrychildnum()+detail.getCarrychildnum());
			//检验半票百分比
			float bRate = 1;
			if(bNum>0){
				bRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1036, scheduleplan.getOrgid()))/100;
				if(bRate<=0){
					throw new ServiceException("0371"); //半票数超出设定比例		
				}
			}
			if(bRate<1&&"B".equals(detail.getTickettype())){
				//计算已售半票
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", detail.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));
				propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
				propertyFilters.add(new PropertyFilter("EQS_t!tickettype", "B"));
				play.Logger.info("----------查询半票开始------------");
				List<Object> ll = dao.find(Ticketsell.class,propertyFilters);
				play.Logger.info("----------查询半票结束------------");
				int bNumed = ll==null?0:ll.size();
				if(bRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<bNumed+1){
					throw new ServiceException("0371"); //半票数超出设定比例		
				}
			}			
			//查询班次的可售票种控制
			play.Logger.info("---------查询班次的可售票种控制开始---------");

			List<Map<String, Object>> scheduleselltckettype = null;
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_spd!orgid", schedule.getOrgid()));
			propertyFilters.add(new PropertyFilter("EQS_spd!type", "2")); //班次的可售票总控制
			propertyFilters.add(new PropertyFilter("EQL_spd!typeid", detail.getScheduleid()));//班次ID
			propertyFilters.add(new PropertyFilter("EQS_ty!code", detail.getTickettype()));//票种
			scheduleselltckettype =  scheduleselltickettypeService.findselltickettype(propertyFilters);
			if(scheduleselltckettype!=null && scheduleselltckettype.size()==1){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_spd!orgid", schedule.getOrgid()));
				propertyFilters.add(new PropertyFilter("EQS_spd!type", "1"));//线路的可售票种空
				propertyFilters.add(new PropertyFilter("EQL_spd!typeid",schedule.getRoute().getId() ));//线路ID
				propertyFilters.add(new PropertyFilter("EQS_ty!code", detail.getTickettype()));//票种
				scheduleselltckettype =  scheduleselltickettypeService.findselltickettype(propertyFilters);				
			}
			if(scheduleselltckettype!=null && scheduleselltckettype.size()==1){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_spd!orgid", schedule.getOrgid()));
				propertyFilters.add(new PropertyFilter("EQS_spd!type", "0"));//机构可售票种空
				propertyFilters.add(new PropertyFilter("EQL_spd!typeid","0" ));//全部班次
				propertyFilters.add(new PropertyFilter("EQS_ty!code", detail.getTickettype()));//票种
				scheduleselltckettype =  scheduleselltickettypeService.findselltickettype(propertyFilters);				
			}
			if(scheduleselltckettype!=null && scheduleselltckettype.size()>1){					
				//班次对应票种已售票
				Map<String,Object> scheduleselledmap = new HashMap<String, Object>();
				scheduleselledmap.put("departdate", detail.getDepartdate());
				scheduleselledmap.put("scheduleid", detail.getScheduleid());
				scheduleselledmap.put("tickettype", detail.getTickettype());
				scheduleselledmap.put("ticketstatus", "0");
				int scheduleselledcount = (int) dao.countTotalRows(Ticketsell.class, scheduleselledmap, "id");
				
				if(scheduleselledcount>0){				
					String canselltype = (String) scheduleselltckettype.get(0).get("canselltype");
					String cansellvalues =  scheduleselltckettype.get(0).get("cansellvalue").toString( );
					String tickettypename = scheduleselltckettype.get(0).get("tickettypename").toString();
					if(canselltype.endsWith("0")){//可售类型是张数						
						int cansellNum = Integer.parseInt( cansellvalues);
						if(scheduleselledcount>=cansellNum){
							throw new ServiceException(tickettypename,"0458",false);//全票  票种可售张数已售完							
						}
					}else{ //可售类型是比例
						float cansellRate = Float.parseFloat( cansellvalues);
						if(scheduleselledcount >= scheduleplan.getSeatnum() *cansellRate){
							throw new ServiceException(tickettypename,"0458");//该票种的可售张数已售完							
						}	
					}
				}
				
			}
			play.Logger.info("--------查询班次的可售票种控制结束 ---------");
			Route route = schedule.getRoute();
			//班次站点售票控制 过滤示到时间及超过可售数的站点
			play.Logger.info("--------班次站点售票控制 过滤示到时间及超过可售数的站点开始 ---------");
			Schedulestationcontrol schedulestationcontrol = schedulestationcontrolService.getSchedulestationcontrol(route.getId(), detail.getReachstationid());
			//检查已售票数
			if(schedulestationcontrol!=null&&schedulestationcontrol.getCansellnum()>0&&schedulestationcontrol.getCansellnum()<scheduleplan.getSeatnum()){
				Map<String,Object> conditionmap = new HashMap<String, Object>();
				conditionmap.put("departdate", detail.getDepartdate());
				conditionmap.put("scheduleid", detail.getScheduleid());
				conditionmap.put("reachstationid",detail.getReachstationid());
				conditionmap.put("ticketstatus", "0");
				int stationsellcount = (int) dao.countTotalRows(Ticketsell.class, conditionmap, "id");
				if(stationsellcount>=schedulestationcontrol.getCansellnum()){
					throw new ServiceException("0457");//该站点可售张数已经售完
				}
			}
			play.Logger.info("--------班次站点售票控制 过滤示到时间及超过可售数的站点结束---------");
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", detail.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", detail.getDepartstationid()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", detail.getReachstationid()));
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));			
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", detail.getSeattype()));
			play.Logger.info("--------查询票价开始---------");
			Ticketprice ticketprice =null;
			if(schedule.getIslinework()){
				ticketprice =(Ticketprice) dao.uniqueResult(Ticketprice.class, propertyFilters);
				dao.getEntityManager().detach(ticketprice);
			}else
			{
				ticketprice =(Ticketprice) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			}
			play.Logger.info("--------查询票价结束---------");
			if(!ticketprice.getIssellable()){
				throw new ServiceException("0374"); //该停靠点不可售
			}
			ticketprice.setSoldeatnum((short) (ticketprice.getSoldeatnum()+1));
			//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
			switch (order.getSellway().charAt(0)) {
			case '4':
				ticketturnoverdetail.setChangeservicefee(ticketturnoverdetail.getChangeservicefee().add(detail.getServicefee()));
				break;
			case '6':
				ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(detail.getServicefee()));
				break;
			default:
				ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().add(detail.getServicefee()));
				break;
			} 
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(detail.getPrice()).add(detail.getServicefee()));
			ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(detail.getPrice()));
			
			//0现金、1银联卡、2贵客卡余额、3贵客卡积分、4支付宝、5微信、6公务卡
			if("1".equals(detail.getPaymethod()) || "4".equals(detail.getPaymethod()) || "5".equals(detail.getPaymethod()) || "2".equals(detail.getPaymethod())
					|| "6".equals(detail.getPaymethod()) || "3".equals(detail.getPaymethod())
					|| "10".equals(detail.getPaymethod())|| "11".equals(detail.getPaymethod())){
				ticketturnoverdetail.setNoncashmoney(ticketturnoverdetail.getNoncashmoney().add(detail.getPrice()));
				ticketturnoverdetail.setNoncashmoneypayable(ticketturnoverdetail.getNoncashmoneypayable().add(detail.getPrice()).add(detail.getServicefee()));
//				ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
				switch (order.getSellway().charAt(0)) {
				case '4':
					ticketturnoverdetail.setEchangeservicefee(ticketturnoverdetail.getEchangeservicefee().add(detail.getServicefee()));
					break;
				case '6':
					ticketturnoverdetail.setEbookservicefee(ticketturnoverdetail.getEbookservicefee().add(detail.getServicefee()));
					break;
				default:
					ticketturnoverdetail.setEservicefee(ticketturnoverdetail.getEservicefee().add(detail.getServicefee()));
					break;
				} 
			}
			ticketturnoverdetailepay.setPrice(ticketturnoverdetailepay.getPrice()+detail.getPrice().doubleValue());
			if("2".equals(detail.getPaymethod())||"3".equals(detail.getPaymethod())){
				ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().add(detail.getPrice()));
			}
			Ticketsell ticketsell = new Ticketsell();
			if(!detail.getIslinework()){
				ticketsell.setSeatno(detail.getSeatno());
				play.Logger.info("---------检查和更新座位状态开始-----------");
				if(!"2".equals(scheduleplan.getWorktype())
					&&!"3".equals(scheduleplan.getWorktype())
					){
					//检查座位状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", detail.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter("EQR_t!seatno", detail.getSeatno()));
					Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
					if(scheduleseat==null){
						//回滚
						throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
													"0204",true); //班次座位记录不存在	
					}
					else if(!"1".equals(scheduleseat.getStatus())){
						throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
								"0205",true); //座位不是锁定状态
					}
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", detail.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter("EQR_t!id.seatno", detail.getSeatno()));
					Seatlock seatlock = (Seatlock) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatlock.class, propertyFilters);
					if(seatlock==null){
						//回滚
						throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
								"0206",true); //锁位记录不存在	
					}
					if("4".equals(seatlock.getOldstatus())||"5".equals(seatlock.getOldstatus())){
						//检查留座位记录状态
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", detail.getScheduleplanid()));
						propertyFilters.add(new PropertyFilter("EQR_t!seatno", detail.getSeatno()));
	//					Seatreserve seatreserve = (Seatreserve) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatreserve.class, propertyFilters);
						List<Seatreserve> seatreserves = dao.find(LockModeType.PESSIMISTIC_READ,Seatreserve.class, propertyFilters);
						Seatreserve seatreserve = null;
						if(seatreserves!=null&&seatreserves.size()>0){
							//查找状态为留票状态的记录
							for (Seatreserve _seatreserve : seatreserves) {
								if(_seatreserve.getSellstate().equals("R")){
									seatreserve = _seatreserve;
									break;
								}
							}
							if(seatreserve==null){
								//查找状态为已售的记录	
								for (Seatreserve _seatreserve : seatreserves) {
									if(_seatreserve.getSellstate().equals("S")){
										seatreserve = _seatreserve;
										break;
									}
								}
							}
							if(seatreserve==null){
								//取第一条记录
								seatreserve = seatreserves.get(0);
							}
						}
						if(seatreserve==null){
							//回滚
							throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
									"0207",true); //留座位记录不存在,无法售出留座。
						}
						else{
							if("R".equals(seatreserve.getSellstate())){
								seatreserve.setSellstate("S");
								seatreserve.setUpdateby(global.getUserinfo().getId());
								seatreserve.setUpdatetime(now);
								dao.merge(seatreserve);
								if(seatreserve.getCarrychildnum()>0){
									//如果是订票销售  则减去带儿童数
									scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-detail.getCarrychildnum()));
								}
								//订票服务费  seatreserve.getServiceprice() = detail.getServicefee()
	//								ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(seatreserve.getServiceprice()));
	//								ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(seatreserve.getServiceprice()));
							}
							else{
								//回滚
								if("C".equals(seatreserve.getSellstate())){
									throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
											"0208",true); //留座位记录状态为已取消,无法售出留座。
								}
								else if("S".equals(seatreserve.getSellstate())){
									throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno(),
											"0209",true); //留座位记录状态为已售,无法售出留座。
								}
								return methodResult;
							}
						}
						if("4".equals(seatlock.getOldstatus())){
				            ticketprice.setAutocancelreserveseatnum((short) (ticketprice.getAutocancelreserveseatnum()-1));
				            scheduleplan.setAutocancelreserveseatnum((short) (scheduleplan.getAutocancelreserveseatnum()-1));
				          }
				          else if("5".equals(seatlock.getOldstatus())){
				            ticketprice.setUnautocancelreserveseatnum((short) (ticketprice.getUnautocancelreserveseatnum()-1));
				            scheduleplan.setUnautocancelreserveseatnum((short) (scheduleplan.getUnautocancelreserveseatnum()-1));
				          }  
					}
					//更新座位状态
					scheduleseat.setStatus("2");
					scheduleseat.setTickettype(detail.getTickettype());
					dao.delete(seatlock);
					scheduleseat.setUpdateby(global.getUserinfo().getId());
					scheduleseat.setUpdatetime(now);
					dao.merge(scheduleseat);
				}
				play.Logger.info("---------检查和更新座位状态结束-----------");
				//若是本区配载、跨区配载也更新座位表
				play.Logger.info("---------若是本区配载、跨区配载也更新座位表开始-----------");
				if ("2".equals(scheduleplan.getWorktype()) || "3".equals(scheduleplan.getWorktype()))
				{
					//检查座位状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", detail.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter("EQR_t!seatno", detail.getSeatno()));
					Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
					if(scheduleseat!=null){
						if(scheduleseat.getStatus().equals("2")){
							throw new ServiceException("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+"已售出！",
									"0450",true); //班次的已售座位发车变化，请重新选择
						}
						//更新座位状态
						scheduleseat.setStatus("2");
						scheduleseat.setTickettype(detail.getTickettype());
						scheduleseat.setUpdateby(global.getUserinfo().getId());
						scheduleseat.setUpdatetime(now);
						dao.merge(scheduleseat);
					}					
				}
				play.Logger.info("---------若是本区配载、跨区配载也更新座位表结束 -----------");
			}
			else{
				//流水班次没有留位
				//取已售张数的最大值作为座位号
				play.Logger.info("-----取已售张数的最大值作为座位号开始------");
				Object seatno= dao.uniqueResult("select max(t.seatno) from Ticketsell t where t.scheduleplanid="+detail.getScheduleplanid());
				play.Logger.info("-----取已售张数的最大值作为座位号结束------");
				if(seatno==null){
					ticketsell.setSeatno((short) 1);	
				}
				else{					
					ticketsell.setSeatno((short) ((Short)seatno+1));
				}					
				//往回更新
				detail.setSeatno(ticketsell.getSeatno());
			}
			//检查带儿童数量 start
			int maxchildnum=0;
			if(detail.getCarrychildnum()>0){
				//取售票点带儿童数量
				int letoutCarryChild = 0;
				if(ticketoutletsctr!=null){
					double CarrychildRate = ticketoutletsctr.getCarrychildrate()/100;
					letoutCarryChild = (int) (CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum()));
				}else{
					letoutCarryChild = 99999999;
				}
				//0固定数
				if (param1012.equals("0")){
					maxchildnum=new Integer(param1061);
				}else{
					float CarrychildRate = Float.valueOf(param1061)/100;
					maxchildnum=(int) (CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum()));
				}
				maxchildnum = Math.min(letoutCarryChild, maxchildnum);
				if(maxchildnum<scheduleplan.getCarrychildnum()){
					throw new ServiceException("0270"); //该班次带儿童数量超过最大允许带儿童数量
				}
			}
			//检查带儿童数量 end
			//add by zhangqingfeng 售票前检查保险服务器是否连接畅通 start
			String param2626 = parameterService.findParamValue(ParamterConst.Param_2626, order.getOrgid());
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
				String checkeSellPlateformInsurance = InsuranceSellServiceImpl.checkPlateformCanSellInsrance();
				if("0".equals(checkeSellPlateformInsurance)){
					throw new ServiceException("0484");
				}
			}
			//add by zhangqingfeng 售票前检查保险服务器是否连接畅通 start
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", detail.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", detail.getSeattype()));
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));			
			play.Logger.info("------票价表要更新开始----------");
			if(!schedule.getIslinework()){
				List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
				if(ticketprices.size()>1){
					for (Ticketprice _ticketprice : ticketprices){
						_ticketprice.setSoldeatnum(ticketprice.getSoldeatnum());
						_ticketprice.setAutocancelreserveseatnum(ticketprice.getAutocancelreserveseatnum());
						_ticketprice.setUnautocancelreserveseatnum(ticketprice.getUnautocancelreserveseatnum());
						_ticketprice.setUpdateby(order.getSeller());
						_ticketprice.setUpdatetime(now);
						dao.merge(_ticketprice);
					}
				}	
			}
			play.Logger.info("------票价表要更新结束----------");
			scheduleplan.setUpdateby(order.getSeller());
			scheduleplan.setUpdatetime(now);
			//dao.merge(scheduleplan);
			ticketsell.setBuspark(detail.getBuspark());
			ticketsell.setCarrychildnum(detail.getCarrychildnum());
			ticketsell.setCheckedby(null);
			ticketsell.setCheckstation(null);
			ticketsell.setChecktime(null);
			ticketsell.setCreateby(order.getSeller());
			ticketsell.setCreatetime(now);
//			String Param_1076 =parameterService.findParamValue(ParamterConst.Param_1076, global.getOrganization().getId());
			if(detail.getCustomerid()==null||detail.getCustomerid()<=0){
				if(vip!=null){
					Customer customer = (Customer) dao.get(Customer.class, vip.getCustomerid());
					Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
					
					if(Param_1076){
					//非流水班走 1076
						if(!detail.getIslinework()){
							//1076为0时，不允许同一证件类型相同证件号在同一天购买同一班次的多张车票，进行校验，是否已经买过票
							if(checkCustomerIsSold(certificatetype.getValue(),customer.getCertificateno(),scheduleplan.getId())){
								methodResult.setResult(0);
								methodResult.setResultMsg("同一证件类型相同证件号在同一天只能购买同一班次的一张车票!");
								return methodResult;
							}
						}else{
							//流水班走 1064
							String param1064 = parameterService.findParamValue(ParamterConst.Param_1064, global.getOrganization().getId());
							Integer intervalhour = Integer.parseInt(param1064);
							BigDecimal lastsellhour =  checkCustomerIsInTime(certificatetype.getValue(),customer.getCertificateno());
							if(lastsellhour !=null && lastsellhour.intValue() < intervalhour){
								methodResult.setResult(0);
								methodResult.setResultMsg("此客户在"+intervalhour+"小时内已经购票！");
								return methodResult;
							}
						}
					}
					ticketsell.setCustomer(customer);
					detail.setCertificateno(customer.getCertificateno());
					detail.setCustomername(customer.getName());		
					//售票表增加冗余字段 customername、certificateno、certificatetypename
					ticketsell.setCustomername(customer.getName());//旅客姓名
					ticketsell.setCertificateno(customer.getCertificateno());//证件号码
					if(certificatetype != null){
						ticketsell.setCertificatetypename(certificatetype.getValue());//证件类型名称
					}
				}else{
					ticketsell.setCustomer(null);
				}
			}
			else{
				play.Logger.info("判断同一证件类型相同证件号在同一天只能购买同一班次的一张车票");
				Customer customer = (Customer) dao.get(Customer.class, detail.getCustomerid());
				if(customer!=null && customer.getId()>1)//过滤默认旅客 
				{
					Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
					if(Param_1076){
					//非流水班走 1076
						if(!detail.getIslinework()){
							//1076为0时，不允许同一证件类型相同证件号在同一天购买同一班次的多张车票，进行校验，是否已经买过票
							if(checkCustomerIsSold(certificatetype.getValue(),customer.getCertificateno(),scheduleplan.getId()) && !"4".equals(sellway)){
								methodResult.setResult(0);
								methodResult.setResultMsg("同一证件类型相同证件号在同一天只能购买同一班次的一张车票!");
								return methodResult;
							}
						}else{
							//流水班走 1064
							String param1064 = parameterService.findParamValue(ParamterConst.Param_1064, global.getOrganization().getId());
							Integer intervalhour = Integer.parseInt(param1064);
							//若间隔为0，则不需要判断
							if(intervalhour>0){
								BigDecimal lastsellhour =  checkCustomerIsInTime(certificatetype.getValue(),customer.getCertificateno());
								if(lastsellhour !=null && lastsellhour.intValue() < intervalhour && !"4".equals(sellway)){
									methodResult.setResult(0);
									methodResult.setResultMsg("此客户在"+intervalhour+"小时内已经购票！");
									return methodResult;
								}
							}
						}
					}
					ticketsell.setCustomer(customer);
					detail.setCertificateno(customer.getCertificateno());
					detail.setCustomername(customer.getName());
					//售票表增加冗余字段 customername、certificateno、certificatetypename
					ticketsell.setCustomername(customer.getName());//旅客姓名
					ticketsell.setCertificateno(customer.getCertificateno());//证件号码
					if(certificatetype != null){
						ticketsell.setCertificatetypename(certificatetype.getValue());//证件类型名称
					}
				}
			}
			//实名制 增加日志记录 输出证件号、姓名信息
			if(ticketsell.getCustomer()!=null){
				
				if(CommonUtil.isEmptyString(ticketsell.getCustomer().getMobilephone())&& isEstationsell){
					methodResult.setResult(0);
					methodResult.setResultMsg("售电子票电话号码不能为空!");
					return methodResult;	
				}
				detail.setMobilephone(ticketsell.getCustomer().getMobilephone());
				play.Logger.info("实名制信息------姓名："+ticketsell.getCustomer().getName()+
								 ",证件类型："+ticketsell.getCertificatetypename()+
						         ",证件号："+ticketsell.getCustomer().getCertificateno()+"------");
			}else{				
				if(isEstationsell){
					methodResult.setResult(0);
					methodResult.setResultMsg("售电子票客户不能为空!");
					return methodResult;	
				}
				//防止是默认旅客打印出来证件信息
				detail.setCertificateno(null);
				detail.setCustomername(null);
				detail.setCustomerid(null);
			}
			ticketsell.setDepartdate(detail.getDepartdate());
			ticketsell.setDepartinvoicesby(null);
			ticketsell.setDepartinvoices(null);
			ticketsell.setDepartinvoicestime(null);
			ticketsell.setReturnfeemode("0");//默认为车站垫付
			ticketsell.setDepartstationid(detail.getDepartstationid());
			ticketsell.setDeparttime(detail.getDeparttime());
			if(detail.getDiscountrate().compareTo(new BigDecimal(1))<0){
				ticketsell.setDiscountrate(detail.getDiscountrate());
			}else{
				ticketsell.setDiscountrate(new BigDecimal(0));
			}
			ticketsell.setDistance(detail.getDistance());
			ticketsell.setFullprice(detail.getFullprice());
			ticketsell.setHandticketoutlets(null);
			ticketsell.setIschecked(false);
			ticketsell.setIsdepartinvoices(false);
			ticketsell.setIslinework(detail.getIslinework());
			ticketsell.setOrgid(order.getOrgid());
			ticketsell.setPaymethod(detail.getPaymethod());
			ticketsell.setPrice(detail.getPrice());
			ticketsell.setMoreprice(ticketprice.getMoreprice());
			detail.setMoreprice(ticketsell.getMoreprice());
			ticketsell.setServicefee(detail.getServicefee());
			ticketsell.setReachstationid(detail.getReachstationid());
			ticketsell.setScheduleid(detail.getScheduleid());
			ticketsell.setScheduleplanid(detail.getScheduleplanid());
			//售票表增加冗余字段：报到车辆ID、计划报到车辆品牌型号ID
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",detail.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQR_t!orderno",(short)0));
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));				
			Schedulevehiclepeopleplan schedulevehiclepeopleplan = (Schedulevehiclepeopleplan) dao.uniqueResult(Schedulevehiclepeopleplan.class, propertyFilters);
			if(schedulevehiclepeopleplan != null){
				if(schedulevehiclepeopleplan.getPlanvehicle() != null){
					ticketsell.setVehicleid(schedulevehiclepeopleplan.getPlanvehicle().getId());
				}
				ticketsell.setVehiclebrandmodelid(schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());
			}
			ticketsell.setSellby(order.getSeller());
			ticketsell.setSellip(order.getIp());
			ticketsell.setSelltime(now);
			ticketsell.setSellway(order.getSellway());
			if(null != billinventory){
				ticketsell.setBatchno(billinventory.getBatchno());	
			}else{
				ticketsell.setBatchno(batchno);
			}
			ticketsell.setTicketentrance(detail.getTicketentrance());
			ticketno=ticketno+1;
			
			//如果是团体票或包车票、只打印一张车票
//			if("T".equals(order.getTickets().get(0).getTickettype())||"H".equals(order.getTickets().get(0).getTickettype())){
			if("T".equals(detail.getTickettype())||"H".equals(detail.getTickettype())){
				//团体票或包车票第一张售票记录的票号为真实票号、其它车票生成虚拟票号
				if(ticketno.longValue()==Long.parseLong(order.getStartTicketNO())){
					ticketsell.setTicketno(order.getStartTicketNO());
				}else{
					ticketsell.setTicketno(order.getStartTicketNO()+new Long(ticketno-Long.parseLong(order.getStartTicketNO())));
				}
			}else{
				if(isSetServicefee==1 && order.getSellway().equals("4") && changeticketnum>1){//改签时票号值					
					Long changeticketno=ticketno+(changeticketnum-1);
					ticketsell.setTicketno(StringUtils.strPad(changeticketno.toString(),order.getStartTicketNO().length(), "0"));
				}else{
				   ticketsell.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
				}	
			}
			//校验票号和批次号是否存在，暂时不增加，票号入库时有校验
//			if(checkTicketnoAndBatchno(ticketsell.getTicketno(),ticketsell.getBatchno())){
//				methodResult.setResult(0);
//				methodResult.setResultMsg("票号："+ticketsell.getTicketno()+" 已存在，请更换票号段！");
//				return methodResult;
//			}
			
			//往回更新,此处更新座位号，因为在售跨区配载班次时以中心返回的座位号为准进行售票
			detail.setSeatno(ticketsell.getSeatno());
			detail.setTicketno(ticketsell.getTicketno());
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String datestr = df.format(ticketsell.getSelltime());
			String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
			String tiksno=AuthcodeEncode.authcodeEncode(cipherStr);
			if("".equals(tiksno)||tiksno==null){
				methodResult.setResult(0);
				methodResult.setResultMsg("数据加密失败！");
				return methodResult;
			}
			ticketsell.setTiksno(tiksno);
			ticketsell.setTicketoutletsname(ticketoutlets.getName());
			ticketsell.setTicketoutletsid(order.getTicketoutletsid());
			ticketsell.setTicketstatus("0"); //正常
			ticketsell.setTickettype(detail.getTickettype());
			ticketsell.setUpdateby(order.getSeller());
			ticketsell.setUpdatetime(now);
			ticketsell.setSeattype(detail.getSeattype());
			ticketsell.setToplimitprice(detail.getToplimitprice());
			//取票价组成项费用
			//ticketsell.setFueladditionfee(ticketprice.getFueladditionfee());
			play.Logger.info("售票操作-----票号："+ticketsell.getTicketno()+"---修改站务费开始");
			DeductInfo deductInfo = balancedeductService.getDeductfee(ticketsell);
			ticketsell.setFueladditionfee(deductInfo.getFueladditionfee());
			ticketsell.setStationservicefee(deductInfo.getStationfee());
			play.Logger.info("售票操作-----票号："+ticketsell.getTicketno()+"---修改站务费为："+deductInfo.getStationfee());
			ticketsell.setComputefee(deductInfo.getComputefee());
			ticketsell.setCoolairfee(deductInfo.getCoolairfee());
			ticketsell.setAdditionfee(deductInfo.getAdditionfee());
			ticketsell.setWaterfee(deductInfo.getWaterfee());
			ticketsell.setInsurefee(deductInfo.getInsurefee());
			ticketsell.setOtherfee(deductInfo.getOtherfee());
			detail.setFueladditionfee(ticketsell.getFueladditionfee());
			detail.setStationservicefee(ticketsell.getStationservicefee());
			detail.setComputefee(ticketsell.getComputefee());
			detail.setCoolairfee(ticketsell.getCoolairfee());
			detail.setAdditionfee(ticketsell.getAdditionfee());
			detail.setWaterfee(ticketsell.getWaterfee());
			detail.setInsurefee(ticketsell.getInsurefee());
			detail.setOtherfee(ticketsell.getOtherfee());
			detail.setIsaudited(schedule.getIsaudited());
			detail.setIsauditpass(schedule.getIsauditpass());			
			Station st=(Station) dao.get(Station.class, detail.getDepartstationid());
			detail.setDepartstationdescription(st.getDescription());
			detail.setDepartstationsecondname(st.getSecondname());
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", detail.getScheduleid()));
			propertyFilters.add(new PropertyFilter("EQL_t!stationid", detail.getReachstationid()));
			List<Schedulestop> slist=dao.find(Schedulestop.class,propertyFilters);
			if(slist!=null&&slist.size()>0){
				Schedulestop st1=slist.get(0);
				detail.setSchedulestopremark1(st1.getRemark1());
				detail.setSchedulestopremark2(st1.getRemark2());
				detail.setSchedulestopremark3(st1.getRemark3());
				detail.setSchedulestopremark4(st1.getRemark4());
				detail.setSchedulestopremark5(st1.getRemark5());
			}
			ticketsell.setTurnoverdetailid(ticketturnoverdetail.getId());
			ticketsell.setOrderno(order.getOrderno());
			play.Logger.info("---------向车票销售表中添加售票信息开始----------");
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			if(ticketsell.getCarrychildnum() > 0){
				carryList.add(ticketsell);//若此票为携童票，则添加到carryList中，供打印儿童票使用
			}
			play.Logger.info("---------向车票销售表中添加售票信息结束 ----------");
			ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().add(ticketsell.getFueladditionfee()));
			ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee().add(ticketsell.getStationservicefee()));
			ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().add(ticketsell.getComputefee()));
			ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().add(ticketsell.getCoolairfee()));
			ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().add(ticketsell.getAdditionfee()));
			ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().add(ticketsell.getWaterfee()));
			ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().add(ticketsell.getInsurefee()));
			ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().add(ticketsell.getOtherfee()));			
			detail.setId(ticketsell.getId());
			if(vipconsume!=null){
				//贵宾卡消费记录明细
				Vipconsumeldetail vipconsumeldetail = new Vipconsumeldetail();
				vipconsumeldetail.setCreateby(order.getSeller());
				vipconsumeldetail.setCreatetime(now);
				vipconsumeldetail.setIsselfschedule(true);
				vipconsumeldetail.setSellid(ticketsell.getId());
				vipconsumeldetail.setVipconsume(vipconsume);
				vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
			}
			dao.getEntityManager().flush();
//			移到外层处理,防止跨区配载班次到中心的免票儿童是0
//			//参数1074，免票儿童是否单独打印车票，0不打印，1打印。参数设置为1时，全票上不再标记‘带儿童’字样
//			if("1".equals(p1074)){
//				detail.setCarrychildnum(Byte.parseByte("0"));
//			}
			ticketsells.put(detail,ticketsell);
			//如果到站为往返站点
			if(detail.getIsroundtrip()){
				Returntripticket returntripticket = new Returntripticket();
				returntripticket.setBatchno(billinventory.getBatchno());
				ticketno=ticketno+1;
				returntripticket.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
				returntripticket.setIsselfschedule(true);
				returntripticket.setSellid(ticketsell.getId());
				dao.merge(returntripticket);
				ticketturnoverdetail.setSellreturntripnum(ticketturnoverdetail.getSellreturntripnum()+1);
			}
			//发车站所属区域
			String departstationdis="";
			try
			{
				StringBuilder sql = new StringBuilder();
				sql.append("select  tr.name from district tr, station s where tr.id = s.districtid and s.id=:departstationid");
				Query query = dao.getEntityManager().createNativeQuery(sql.toString());
				query.setParameter("departstationid", detail.getDepartstationid());
				departstationdis = query.getSingleResult().toString();
			}catch(Exception e){
				play.Logger.error(e.getMessage(), e);
			}
			detail.setDepartstationdis(departstationdis);
			detail.setTicketoutletsname(ticketoutlets.getName());
			listEstationsell.add(ticketsell);
		}
		
		if(TestParams.getNewest().sellTicket == 1){
			SystemFactory.markRtException();
		}
		dao.getEntityManager().flush();	
		
		if (isEstationsell) {// 调用电子票
			EticketNumberResponse response = new EticketNumberResponse();
			EticketService ser = new EticketService();
			try {
				// 调用生成电子票接口
				response = ser.getEticketNumber(tickets);
			} catch (Exception e) {
				play.Logger.error("生成电子票号失败 :" + e.getMessage());
				response.setResultCode("0003");
				response.setMessage("生成电子票号失败");
			}
			if (!"0000".equals(response.getResultCode())) {
				methodResult.setResultMsg("生成电子票失败");
				methodResult.setResult(0);
				return methodResult;
			}
			if (response.getListNum().size() != tickets) {
				methodResult.setResultMsg("生成电子票失败");
				play.Logger.error("生成电子票失败:生成电子票数据与返回数据不一致");
				methodResult.setResult(0);
				return methodResult;
			}
			//将返回的电子票号集合赋值给eticketnos
			eticketnos = response.getListNum();
			// 将返回的电子票号分别赋值给ticketsell
			for (int k = 0; k < listEstationsell.size(); k++) {
				Ticketsell t = listEstationsell.get(k);
				t.setEticketno(eticketnos.get(k));
				t.setIseticketsell(true);
				for (TicketPrintInfo ticketPrintInfo2 : order.getTickets()) {
					if (ticketPrintInfo2.getId() == t.getId()) {
						ticketPrintInfo2.setEticketno(t.getEticketno());
						if (!isprintonsellestation) {
							// 这个循环是为了不打车票打印保险,防止保险上票号为 0 1
							ticketPrintInfo2.setTicketno(t.getEticketno());
							ticketPrintInfo2.setIsjumpEticketno(false);
							t.setTicketno(t.getEticketno());
						} else {
							ticketPrintInfo2.setIsjumpEticketno(true);
						}
						break;
					}
				}
				dao.merge(t);
			}
			try {
				// 防止数据库报错
				dao.getEntityManager().flush();
			} catch (Exception e) {
				play.Logger.error("生成电子票号失败:" + e.getMessage());
				methodResult.setResultMsg("生成电子票号失败");
				methodResult.setResult(0);
				return methodResult;
			}
		}
		
		play.Logger.info("scheduleplan_last.getWorktype()="+scheduleplan_last.getWorktype());
		if(!scheduleplan_last.getIslinework()&&"3".equals(scheduleplan_last.getWorktype())){
			//到中心售票 
//	
//			NetScheduleTicketSellService netScheduleTicketSellService = (methodResult,global.getOrganization());
//			if(netScheduleTicketSellService==null){
//				return methodResult;
//			}
//			methodResult = netScheduleTicketSellService.sellTicket(order);
			TicketOrder order2 = (TicketOrder) order.clone();
			Iterator<TicketPrintInfo> ticketPrintInfos = order2.getTickets().iterator();
			while (ticketPrintInfos.hasNext()) {
				TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) ticketPrintInfos.next();
				Scheduleplan scheduleplan=	(Scheduleplan) dao.get(Scheduleplan.class, ticketPrintInfo.getScheduleplanid());
				if(!scheduleplan.getWorktype().equals("3")){
					ticketPrintInfos.remove();
				}
			}
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("order", JsonUtil.toFormatString(order2));
			requestMap.put("transactionid", transationId);

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			
			CurrentUtil.setFlash("remoteurl", centreOrg.getServersaddress());
			
			if(TestParams.getNewest().sellTicket == 2){
				SystemFactory.markRtException();
			}
			play.Logger.info("--------售跨区配载班次票开始----------");
			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.SCHEDULE_SELL_TICKET3, requestMap);		
			play.Logger.info("--------售跨区配载班次票结束----------");
			if(methodResult.getResult()!=MethodResult.SUCCESS){
//				context.setRollbackOnly();
				return methodResult;
			}else{
				//check Ticket is sell  
				Map<String, String> checkRequestMap = new HashMap<String, String>();
				checkRequestMap.put("orderno", order.getOrderno());
				MethodResult countResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_TICKET_SELL_BY_ORDERNO, checkRequestMap);	
				if(countResult.getResult() != MethodResult.SUCCESS ||
						Integer.parseInt(countResult.getResultMsg().toString()) < 1){
					countResult.setResult(MethodResult.FAILURE);
					return countResult;
				}
			}
			/*      跨区配载班次中心锁座 所以不用更新座位图
			//根据售票结果更新座位号
//			List<TicketPrintInfo> _ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			List<TicketPrintInfo> _ticketPrintInfos = JsonUtil.parseArray(methodResult.getObject(), TicketPrintInfo.class);
			int i=0;
			play.Logger.info("---------跨区配载班次检查或更新座位状态开始----------");
			for (TicketPrintInfo ticketPrintInfo : order.getTickets()) {
				ticketPrintInfo.setSeatno(_ticketPrintInfos.get(i).getSeatno());
				ticketPrintInfo.setSeatnostr(_ticketPrintInfos.get(i).getSeatno()+"");
				ticketsells.get(ticketPrintInfo).setSeatno(ticketPrintInfo.getSeatno());
				dao.merge(ticketsells.get(ticketPrintInfo));
				i++;
				//检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan_last.getId()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketPrintInfo.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
				if(scheduleseat!=null){
					//更新座位状态
					scheduleseat.setStatus("2");
					scheduleseat.setTickettype(ticketPrintInfo.getTickettype());
					scheduleseat.setUpdateby(global.getUserinfo().getId());
					scheduleseat.setUpdatetime(now);
					dao.merge(scheduleseat);
				}	
			}
			play.Logger.info("---------跨区配载班次检查或更新座位状态结束----------");*/
		}
		
		if(vipconsume!=null){
			dao.merge(vipconsume);
		}
		
		if(TestParams.getNewest().sellTicket == 3){
			SystemFactory.markRtException();
		}
		
		//处理团体票的座位号开始
		if("T".equals(order.getTickets().get(0).getTickettype())){
			List<TicketPrintInfo> infolist = order.getTickets();
			List<Short> list = new ArrayList<Short>();
			for (TicketPrintInfo tpi : infolist) {
				list.add(tpi.getSeatno());
			}
			//将团体票的座位号转化为特殊字符串
			String seatnostr = seatnoToSeatstr(list);
			for (TicketPrintInfo tpi : infolist) {
				tpi.setSeatnostr(seatnostr);
			}
		}
		//单独处理是因为如果是跨区配载的到中心的儿童数是0了
		for (TicketPrintInfo detail : order.getTickets()) {
			//参数1074，免票儿童是否单独打印车票，0不打印，1打印。参数设置为1时，全票上不再标记‘带儿童’字样
			if("1".equals(p1074)){
				detail.setCarrychildnum(Byte.parseByte("0"));
			}
		}
		//处理团体票的座位号结束
		
		//生成免票儿童记录
		if("1".equals(p1074) && kidList.size() > 0){
//			long firstKidno = billinuse.getNextno() - order.getTickets().size() - 1;//打印儿童票时，第一免票儿童票票号
			long firstKidno = 0;
			if(null != billinuse){
				firstKidno = billinuse.getNextno() - kidList.size() - (isPrintBookService?1:0);//打印儿童票时，第一免票儿童票票号
			}	
					
			int i = 0;
			for (TicketPrintInfo ticketPrintInfo : kidList) {
//				Ticketsell ts = (Ticketsell) kidTemplate.clone();
//				Ticketsell ts = (Ticketsell) carryList.get(i).clone();
				Ticketsell pticketsell = (Ticketsell) carryList.get(i);//主票售票记录
				Ticketsell ts = (Ticketsell) pticketsell.clone();
				ts.setId(0L);
				ts.setTicketno(StringUtils.strPad(Long.valueOf(firstKidno).toString(),order.getStartTicketNO().length(), "0"));
				firstKidno++;
				ts.setTickettype("E");
//				ts.setSeatno(Short.valueOf("-1"));
				ts.setSeatno(pticketsell.getSeatno());
				ts.setFullprice(java.math.BigDecimal.ZERO);
				ts.setPrice(java.math.BigDecimal.ZERO);
				ts.setMoreprice(java.math.BigDecimal.ZERO);
				ts.setServicefee(java.math.BigDecimal.ZERO);
				ts.setToplimitprice(java.math.BigDecimal.ZERO);
				ts.setFueladditionfee(java.math.BigDecimal.ZERO);
				ts.setStationservicefee(java.math.BigDecimal.ZERO);
				ts.setComputefee(java.math.BigDecimal.ZERO);
				ts.setCoolairfee(java.math.BigDecimal.ZERO);
				ts.setAdditionfee(java.math.BigDecimal.ZERO);
				ts.setWaterfee(java.math.BigDecimal.ZERO);
//				ts.setInsurefee(java.math.BigDecimal.ZERO);
//				ts.setInsurefee( order.getTickets().get(order.getTickets().size() - kidList.size() - 1 + i).getInsurefee());
				ts.setOtherfee(java.math.BigDecimal.ZERO);
				ts.setCarrychildnum(Byte.parseByte("0"));
				if(isEstationsell){
					ts.setEticketno(eticketnos.get(listEstationsell.size() + i));//获取从主票之后的电子票号
					ts.setIseticketsell(true);
					ticketPrintInfo.setEticketno(ts.getEticketno());
					if (!isprintonsellestation) {
						ticketPrintInfo.setTicketno(ts.getEticketno());
						ticketPrintInfo.setIsjumpEticketno(false);
						ts.setTicketno(ts.getEticketno());
					} else {
						ticketPrintInfo.setIsjumpEticketno(true);
					}	
				}
				if(ticketPrintInfo.getCustomerid() != null && ticketPrintInfo.getCustomerid()>1){
					Customer customer = (Customer) dao.get(Customer.class, ticketPrintInfo.getCustomerid());
					if(customer!=null)
					{
						if(CommonUtil.isEmptyString(customer.getMobilephone())&& isEstationsell){
							methodResult.setResult(0);
							methodResult.setResultMsg("售电子票电话号码不能为空!");
							return methodResult;	
						}
						ticketPrintInfo.setMobilephone(customer.getMobilephone());
						ts.setCustomer(customer);
						ts.setCustomername(customer.getName());
						ts.setCertificateno(customer.getCertificateno());
						Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
						ts.setCertificatetypename(certificatetype.getValue());
						ticketPrintInfo.setCertificateno(customer.getCertificateno());
						ticketPrintInfo.setCustomername(customer.getName());
						
					}
				}else{
					if(isEstationsell){
						methodResult.setResult(0);
						methodResult.setResultMsg("售电子票客户不能为空!");
						return methodResult;	
					}
				}
				
				ts = (Ticketsell) dao.merge(ts);
				
				//生成主票-儿童票记录
				CarryChild carryChild = new CarryChild();
				carryChild.setQticketid(pticketsell.getId());
				carryChild.setChildticketid(ts.getId());
				carryChild.setCreatetime(ts.getCreatetime());
				carryChild.setCreateby(ts.getCreateby());
				carryChild.setUpdatetime(ts.getUpdatetime());
				carryChild.setUpdateby(ts.getUpdateby());
				carryChild.setRemark("售票" + DateUtils.formatDatetime(carryChild.getCreatetime()));
				carryChild = (CarryChild) dao.merge(carryChild);
				
				play.Logger.info("售携童票并打印儿童票，主票票号="
						+ pticketsell.getTicketno() + ", 携童票票号="
						+ ts.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId());
				ticketPrintInfo.setId(ts.getId());//儿童票id
				ticketPrintInfo.setDepartdate(ts.getDepartdate());
				ticketPrintInfo.setDeparttime(ts.getDeparttime());
				ticketPrintInfo.setTicketno(ts.getTicketno());
				ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
				ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
//				ticketPrintInfo.setSeatno(Short.valueOf("-1"));
//				ticketPrintInfo.setSeatnostr("-1");
				ticketPrintInfo.setSeatno(ts.getSeatno());
				ticketPrintInfo.setSeatnostr(Short.toString(ts.getSeatno()));
				order.getTickets().add(ticketPrintInfo);
//				if(!"0".equals(pticketsell.getPaymethod())) {
//					ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
//				}
				i++;
			}
		}
		/*try{
			(new TicketSync(global.getOrganization().getCode(),order)).now();
		}catch(Exception e){
			play.Logger.error("窗口售票数据同步失败：TicketSync fail:",e);
		}*/
		
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		if(ticketturnoverdetailepay!=null){
			if(ticketturnoverdetailepay.getTicketturnoverdetailid()==null){
				ticketturnoverdetailepay.setTicketturnoverdetailid(ticketturnoverdetail.getId());
			}
			dao.merge(ticketturnoverdetailepay);
		}
		dao.getEntityManager().flush();		
		methodResult.setResult(1);
		order.getTickets().addAll(returntripticketPrintInfos);
		methodResult.setObject(order.getTickets());
		updateScheduleplan(splists);
		
		return methodResult;
	}
	
	private void updateScheduleplan(Map<Long,Scheduleplan> splist){
		for(long scheduleplanid:splist.keySet()){
			Scheduleplan sp=splist.get(scheduleplanid);
			if(sp.getIslinework()){
				//流水班单独语句
				int carrychildnums=sp.getCurcarrychildnum();
				int soldeatnum = sp.getCursoldeatnum();
				String scheplan_sql = "update scheduleplan t set t.soldeatnum=t.soldeatnum+"+soldeatnum+
				 " ,t.carrychildnum=t.carrychildnum+"+carrychildnums+",t.updateby="+sp.getUpdateby()+
				 " ,t.updatetime=sysdate where t.id="+scheduleplanid+" and departdate =:departdate";
				Query updateSchplan = JPA.em().createNativeQuery(scheplan_sql);
				updateSchplan.setParameter("departdate", sp.getDepartdate());
				updateSchplan.executeUpdate();
				
				scheplan_sql = "update ticketprice t set t.soldeatnum=t.soldeatnum+"+soldeatnum+
				 ",t.updateby="+sp.getUpdateby()+
				 " ,t.updatetime=sysdate where t.scheduleplanid="+scheduleplanid+" and departdate =:departdate";
				updateSchplan = JPA.em().createNativeQuery(scheplan_sql);
				updateSchplan.setParameter("departdate", sp.getDepartdate());
				updateSchplan.executeUpdate();				
			}else{
				dao.merge(sp);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Date lockSeat(UUID orderno, long scheduleplanid,List<Short> seatnos,List<String> selectSeatStatus,String selectSeattype,Global global) throws Exception {
		Date locktime = new Date();
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, scheduleplanid);
		//判断此订单号是普通购票还是订单购票
		List<PropertyFilter> _propertyFilters = new ArrayList<PropertyFilter>();
		_propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno.toString()));
		List<Seatlock> otherseatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,_propertyFilters);
		//取锁定时间
		int locktimeout=0;
		if(otherseatlocks!=null && otherseatlocks.size()>0){
			locktimeout=new Integer(parameterService.findParamValue(ParamterConst.Param_1009, global.getOrganization().getId()));  //订单购票锁位时长，单位为秒钟
		}
		else{
			locktimeout=new Integer(parameterService.findParamValue(ParamterConst.Param_1008, global.getOrganization().getId()));  //普通购票锁位时长，单位为秒钟
		}
		Calendar cld= Calendar.getInstance();
		cld.setTime(locktime);
		cld.add(Calendar.SECOND, locktimeout);
		Date unlocktime = cld.getTime(); 
		if("2".equals(scheduleplan.getWorktype())
			){//||"3".equals(scheduleplan.getWorktype())
			return unlocktime; //本区配客班次无法锁位，直接返回
		}
		if("3".equals(scheduleplan.getWorktype())){//跨区配载班次到中心锁座
			MethodResult methodResult = new MethodResult();
			Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleplan.getScheduleid());
			
			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("departdate", CommonUtil.dateToFullString(scheduleplan.getDepartdate()));
			requestMap.put("schedulesynccode", schedule.getSynccode());
			requestMap.put("orderno", orderno.toString());
			requestMap.put("seatnos", JsonUtil.toFormatString(seatnos));
			requestMap.put("selectSeatStatus", JsonUtil.toFormatString(selectSeatStatus));
			requestMap.put("selectSeattype", selectSeattype);
			requestMap.put("locktimeout",String.valueOf(locktimeout));
			

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.LOCK_SEAT_Worktype3, requestMap);	
			//如果成功
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new BusinessException(methodResult.getResultMsg());
			}else{
				Object[] returnresult= JsonUtil.toObjctArray( methodResult.getObject());
				List<Short> _seatnos = JsonUtil.parseArray(returnresult[1], Short.class);
				
				ListIterator<Short> itSeatnos = seatnos.listIterator();
				int i=0;
				while(itSeatnos.hasNext()){
					itSeatnos.next();
					itSeatnos.set(_seatnos.get(i));
					i++;
				}
			}
		}
		//更新已锁座位的解锁时间
		if(otherseatlocks!=null && otherseatlocks.size()>0){
			for (Seatlock seatlock : otherseatlocks) {
				seatlock.setAutounlocktime(unlocktime);
				dao.merge(seatlock);
			}
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplanid));
		List<Scheduleseats> scheduleseats = dao.find(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters,new String[]{"seatno"});
		ListIterator<Short> itSeatnos = seatnos.listIterator();
//		Iterator<Short> itSeatnos = seatnos.iterator();
//		int falseCount = 0;
		while(itSeatnos.hasNext()){
			Short seatno = itSeatnos.next();
			Scheduleseats scheduleseat = null;
			for (Scheduleseats _scheduleseat : scheduleseats) {
				if(_scheduleseat.getSeatno()==seatno.shortValue()){
					scheduleseat = _scheduleseat;
					break;
				}
			}
			//座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位  取数据字典
			if(scheduleseat==null){
				throw new ServiceException("0204");//班次座位记录不存在
			}else  //增加已检、已开结算单状态判断，避免重号
				if(scheduleseat.getStatus().equals("2")||scheduleseat.getStatus().equals("1")
					||scheduleseat.getStatus().equals("7")||scheduleseat.getStatus().equals("8")){
				scheduleseat = null;
				for (Scheduleseats _scheduleseat : scheduleseats) {
					if(selectSeatStatus.contains(_scheduleseat.getStatus())
						&&(selectSeattype==null||selectSeattype.equals("")||selectSeattype.equals(_scheduleseat.getSeattype()))
						&&!seatnos.contains(_scheduleseat.getSeatno())){
						scheduleseat = _scheduleseat;
						itSeatnos.set(_scheduleseat.getSeatno());
//						seatnos.add(scheduleseat.getSeatno());
//						itSeatnos.remove();
						seatno=_scheduleseat.getSeatno();
						break;
					}
				}
			}
//			if(scheduleseat.getStatus().equals("4")||scheduleseat.getStatus().equals("5")){
//				throw new javax.xml.rpc.ServiceException("操作人员进行了留位，请刷新座位图在售票！");
//			}
			if(scheduleseat==null){
				throw new ServiceException("0298");//剩余座位数不够
			}
			Seatlock seatlock = new Seatlock();
			seatlock.setOldstatus(scheduleseat.getStatus());
			scheduleseat.setStatus("1"); //锁定
			SeatlockPK seatlockPK = new SeatlockPK();
			seatlockPK.setScheduleplanid(scheduleplanid);
			seatlockPK.setSeatno(seatno);
			seatlock.setId(seatlockPK);
			seatlock.setLocktime(locktime);
			seatlock.setAutounlocktime(unlocktime);
			seatlock.setDepartdate(scheduleplan.getDepartdate());
			seatlock.setLockby(global.getUserinfo().getId());
			seatlock.setLockip(global.getIpAddress());
			seatlock.setLockorgid(global.getOrganization().getId());
			seatlock.setLockticketoutletsid(global.getTicketoutlets().getId());
			
			seatlock.setOrderno(orderno.toString());
			seatlock.setScheduleid(scheduleplan.getScheduleid());
			scheduleseat.setUpdateby(global.getUserinfo().getId());
			scheduleseat.setUpdatetime(locktime);
			dao.merge(scheduleseat);
			dao.merge(seatlock);
		}
		return unlocktime;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean unlockSeat(UUID orderno, Long scheduleplanid,List<Short> seatnos) throws Exception {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno.toString()));
		if(scheduleplanid!=null&&scheduleplanid>0){
			propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", scheduleplanid));
		}
		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(seatlocks==null){
			return true;
		}
		Scheduleplan scheduleplan = null;
		boolean isconncenter = false;
		for (Seatlock seatlock : seatlocks) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", seatlock.getDepartdate()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", seatlock.getScheduleid()));
			scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ ,Scheduleplan.class, propertyFilters);
			//如果有跨区配载的要去中心解锁
			if(scheduleplan.getWorktype().equals("3")){
				isconncenter = true;
				break;
			}
		}
		if(isconncenter){
			Map<String, String> requestMap = new HashMap<String, String>();
			//将订单号传到中心 在中心解锁
			requestMap.put("orderno", orderno.toString());
			Organization centreOrg = organizationService.getDirectlyParentOrg(CurrentUtil.getGlobal().getOrganization());
			 RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.UNLOCK_SEAT3, requestMap);	
		}
		for (Seatlock seatlock : seatlocks) {
			if(seatnos==null||seatnos.contains(seatlock.getId().getSeatno())){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", seatlock.getId().getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatlock.getId().getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
				if(scheduleseat!=null){
					scheduleseat.setStatus(seatlock.getOldstatus());
					dao.merge(scheduleseat);
				}
				dao.delete(seatlock);
			}
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Ticketprice> findTicketPrices(List<PropertyFilter> propertyFilters) {
		return dao.find(Ticketprice.class, propertyFilters);
	}
	
//	@Override
	public List<Map<String, Object>> findScheduleseats(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[]{Scheduleseats.class}, dao.find(Scheduleseats.class, propertyFilters,new String[]{"t.seatno"}));
	}
	
	@Override
	public MethodResult findScheduleseatsByTicketpriceId(long ticketpriceid,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		Ticketprice ticketprice = (Ticketprice) dao.get(Ticketprice.class, ticketpriceid);
		Scheduleplan scheduleplan = ticketprice.getScheduleplan();
		if(scheduleplan.getIslinework()){
			methodResult.setObject(null);
		}else if("2".equals(scheduleplan.getWorktype())
				||"3".equals(scheduleplan.getWorktype())){//2 本区配载
			//模拟座位图
			List<Object> scheduleseatss = new ArrayList<Object>();
			Date now = new Date();
			for (int i = 0; i < scheduleplan.getSeatnum(); i++) {
				Scheduleseats scheduleseats = new Scheduleseats();
				dao.getEntityManager().detach(scheduleseats);
				scheduleseats.setCreateby(0L);
				scheduleseats.setCreatetime(now);
				scheduleseats.setDepartdate(scheduleplan.getDepartdate());
				scheduleseats.setId(i);
				scheduleseats.setOrgid(scheduleplan.getOrgid());
				scheduleseats.setScheduleid(scheduleplan.getScheduleid());
				scheduleseats.setSeatno((short) (i+1));
				scheduleseats.setSeattype(ticketprice.getSeattype());
				scheduleseats.setStatus("0");
				scheduleseats.setTickettype(null);
				scheduleseats.setUpdateby(0L);
				scheduleseats.setUpdatetime(now);
				scheduleseatss.add(scheduleseats);
			}
			if("2".equals(scheduleplan.getWorktype())){
				//根据发车站、到达站查售票表。交叉的座位不可售
				List<Ticketsell> selledseats =findSectionTicketsells(scheduleplan,ticketprice.getDepartstationid(),ticketprice.getReachstationid(),null);
				for (Ticketsell selledseat : selledseats) {
					try {
						Scheduleseats scheduleseats = ((Scheduleseats)scheduleseatss.get(selledseat.getSeatno()-1));
						scheduleseats.setStatus("2");
						scheduleseats.setTickettype(selledseat.getTickettype());
					} catch (Exception e) {
					}
				}
			}else if("3".equals(scheduleplan.getWorktype())){
				Schedule schedule = (Schedule) dao.get(Schedule.class, ticketprice.getScheduleid());
				Station departstation = (Station) dao.get(Station.class, ticketprice.getDepartstationid());
				Station reachstation = (Station) dao.get(Station.class, ticketprice.getReachstationid());

				//到中心取座位图
//				NetScheduleTicketSellService netScheduleTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//				if(netScheduleTicketSellService==null){
//					return methodResult;
//				}
//				methodResult = netScheduleTicketSellService.findSectionTicketsells(ticketprice.getDepartdate(), schedule.getSynccode(), departstation.getCode(), reachstation.getCode());
//				
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("departdate", CommonUtil.dateToFullString(ticketprice.getDepartdate()));
				requestMap.put("schedulesynccode", schedule.getSynccode());
				requestMap.put("departstationcode", departstation.getCode());
				requestMap.put("reachstationcode", reachstation.getCode());
				requestMap.put("seattype", ticketprice.getSeattype());

				Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_SECTION_TICKET_AND_CHECK_PRICE, requestMap);		
				
				if(methodResult.getResult()==MethodResult.SUCCESS){
					//根据发车站、到达站查售票表。交叉的座位不可售
					List<Object> selledseats = (List<Object>) methodResult.getObject();
					for (Object selledseat : selledseats) {
//						Object[] _selledseat = (Object[]) selledseat;
						Object[] _selledseat = JsonUtil.parseArray(selledseat, Object.class).toArray();
						try {
							Scheduleseats scheduleseats = ((Scheduleseats)scheduleseatss.get(Integer.parseInt(_selledseat[0].toString())-1));
							//scheduleseats.setStatus("2");
							scheduleseats.setStatus(_selledseat[3].toString());
							scheduleseats.setTickettype(_selledseat[1].toString());
							
						} catch (Exception e) {
						}
					}
					
					//同步票价
					if(org.apache.commons.lang.StringUtils.isNotEmpty(methodResult.getResultMsg())){
						HashMap map = JsonUtil.parseObject(methodResult.getResultMsg(), HashMap.class);
						java.math.BigDecimal full = new BigDecimal(map.get("full").toString());
						java.math.BigDecimal half = new BigDecimal(map.get("half").toString());
						java.math.BigDecimal student = new BigDecimal(map.get("student").toString());
						if(!full.equals(ticketprice.getFullprice())
								|| !half.equals(ticketprice.getHalfprice())
								|| !student.equals(ticketprice.getStudentprice())){
							ticketprice.setFullprice((full));
							ticketprice.setHalfprice(half);
							ticketprice.setStudentprice(student);
							dao.merge(ticketprice);
						}
					}
				}else{
					return methodResult;
				}
			}
			//将最新的已售状态更新到车站班次座位表**************临时代码，当留位、混检都到中心去操作后，本代码可删除
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			List<Scheduleseats> localscheduleseatss = dao.find(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
			
			for (Scheduleseats scheduleseats : localscheduleseatss) {
				if(scheduleseats.getSeatno()>scheduleseatss.size()){
					break;
				}
				Scheduleseats truescheduleseats = (Scheduleseats) scheduleseatss.get(scheduleseats.getSeatno()-1);
				if("2".equals(truescheduleseats.getStatus())){
					scheduleseats.setStatus("2");
					scheduleseats.setTickettype(truescheduleseats.getTickettype());
					dao.merge(scheduleseats);
				}
			}
			//***********************临时代码，当留位、混检都到中心去操作后，本代码可删除
			methodResult.setObject(ListUtil.listToMap(new Object[]{Scheduleseats.class}, scheduleseatss));
		}else{
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			methodResult.setObject(ListUtil.listToMap(new Object[]{Scheduleseats.class}, dao.find(Scheduleseats.class, propertyFilters,new String[]{"t.seatno"})));
		}
		methodResult.setResult(MethodResult.SUCCESS);
		return methodResult;
	}
	
	
//	private NetScheduleTicketSellService (MethodResult methodResult,Organization localorg){
//		Organization centreOrg = getOrganizationService().getDirectlyParentOrg(localorg);
//		if(centreOrg==null){
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到"+localorg.getName()+"的上级机构");
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//		try {
//			return (NetScheduleTicketSellService) EJBFactory.getRemoteEJB(NetScheduleTicketSellService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:"+e.getMessage());
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//	}
//	
	private List<Ticketsell> findSectionTicketsells(Scheduleplan scheduleplan,long departstationid,long reachstationid,Short seatno){
		List<Ticketsell> selledseats = null;
		//取出发车站、到达站在班次停靠点的序号
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", scheduleplan.getScheduleid()));
		propertyFilters.add(new PropertyFilter("EQL_t!stationid", departstationid));
		List<Schedulestop> ssd = dao.find(Schedulestop.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", scheduleplan.getScheduleid()));
		propertyFilters.add(new PropertyFilter("EQL_t!stationid", reachstationid));
		List<Schedulestop> ssr = dao.find(Schedulestop.class, propertyFilters);
		//根据发车站、到达站查售票表。交叉的座位不可售
		StringBuilder sql = new StringBuilder();
		sql.append("select ts.* from Ticketsell ts ");
		if(ssd!=null && ssd.size()>0 && ssr!=null && ssr.size()>0){
			//班次停靠点如果取不到数据，则当做交叉了
			sql.append(" left join Schedulestop ssd on ts.scheduleid=ssd.scheduleid and ts.departstationid=ssd.stationid ")
			.append(" left join Schedulestop ssr on ts.scheduleid=ssr.scheduleid and ts.reachstationid=ssr.stationid ");
		}
		sql.append(" where ts.departdate=:departdate ")
		.append("   and ts.scheduleplanid=:scheduleplanid ")
		.append("   and ts.ticketstatus='0' ");
		if(seatno!=null&&seatno>0){
			sql.append(" and ts.seatno=").append(seatno);
		}
		if(ssd!=null && ssd.size()>0 && ssr!=null && ssr.size()>0){
			sql.append(" and (ssd.stationid is null ")
			.append(" or ssr.stationid is null ")
			.append(" or (not ssd.orderno >").append(ssr.get(0).getOrderno()).append(")")
			.append(" or (not ssr.orderno <").append(ssd.get(0).getOrderno()).append(")")
			.append(" )");
		}
		sql.append("   order by ts.seatno ");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString(),Ticketsell.class);
		query.setParameter("departdate", scheduleplan.getDepartdate());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		selledseats = query.getResultList();
		return selledseats;
	}
	
	public List<TicketPrintInfo> getTicketPrintInfo(List<PropertyFilter> propertyFilters,String oldticketno){
		List<Ticketsell> ticketsells = dao.find(Ticketsell.class,propertyFilters);
		List<TicketPrintInfo> result = new ArrayList<TicketPrintInfo>();
		TicketMixChange tmc = null;
		Station station;
		Scheduleplan scheduleplan;
		Route route;
		Schedule schedule;
		Schedulevehiclepeopleplan schedulevehiclepeopleplan;
//		Ticketprice ticketprice;
		List<PropertyFilter> _propertyFilters = new ArrayList<PropertyFilter>();
		for (Ticketsell ticketsell : ticketsells) {
			schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
			scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, ticketsell.getScheduleplanid());
			route = schedule.getRoute();
			_propertyFilters.clear();
			_propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",ticketsell.getScheduleplanid()));
			_propertyFilters.add(new PropertyFilter("EQR_t!orderno",(short)0));
			schedulevehiclepeopleplan = (Schedulevehiclepeopleplan) dao.uniqueResult(Schedulevehiclepeopleplan.class, _propertyFilters);
			Ticketoutlets tol = (Ticketoutlets) dao.get(Ticketoutlets.class, ticketsell.getTicketoutletsid());
			TicketPrintInfo ticketPrintInfo = new TicketPrintInfo();
			ticketPrintInfo.setBuspark(ticketsell.getBuspark());
			ticketPrintInfo.setCarrychildnum(ticketsell.getCarrychildnum());
			ticketPrintInfo.setDepartdate(ticketsell.getDepartdate());
			ticketPrintInfo.setDepartstationid(ticketsell.getDepartstationid());
			ticketPrintInfo.setTicketoutletsname(tol.getName());
			station = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
			if(station != null){
				District district =  (District) dao.get(District.class, station.getDistrictid());
				if(district != null){
					ticketPrintInfo.setDepartstationdis(district.getName());
				}
			}
			ticketPrintInfo.setDepartstationname(station.getName());
			ticketPrintInfo.setDepartstationdescription(station.getDescription());//发车站备注信息
			ticketPrintInfo.setDepartstationsecondname(station.getSecondname());//发车站第二语言
			ticketPrintInfo.setDeparttime(ticketsell.getDeparttime());
			ticketPrintInfo.setDiscountrate(ticketsell.getDiscountrate());
			ticketPrintInfo.setDistance(ticketsell.getDistance());
			station = (Station) dao.get(Station.class, route.getEndstationid());
			ticketPrintInfo.setEndstationname(station.getName());
			ticketPrintInfo.setFueladditionfee(ticketsell.getFueladditionfee());
			ticketPrintInfo.setFullprice(ticketsell.getFullprice());
			Ticketoutlets ticketoutlets = ticketsell.getHandticketoutlets();
			if(ticketoutlets!=null){
				ticketPrintInfo.setHandticketoutletsid(ticketoutlets.getId());
			}
			ticketPrintInfo.setId(ticketsell.getId());
			ticketPrintInfo.setIslinework(ticketsell.getIslinework());
			ticketPrintInfo.setIsovertime(scheduleplan.getIsovertime());

			ticketPrintInfo.setOrgid(ticketsell.getOrgid());
			ticketPrintInfo.setPaymethod(ticketsell.getPaymethod());
			Vehiclebrandmodel vehiclebrandmodel = (Vehiclebrandmodel) dao.get(Vehiclebrandmodel.class, schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());
		
			ticketPrintInfo.setPlanbrandmodel(vehiclebrandmodel.getBrandname()+vehiclebrandmodel.getModelcode());
			
			if(schedulevehiclepeopleplan.getPlanunit()!=null){
			  ticketPrintInfo.setPlanunitname(schedulevehiclepeopleplan.getPlanunit().getName());
			}
			Vehicle vehicle = schedulevehiclepeopleplan.getPlanvehicle();
			if(vehicle!=null){
				ticketPrintInfo.setPlanvehicleno(vehicle.getVehicleno());
			}
			Vehicletype vehicletype = (Vehicletype) dao.get(Vehicletype.class, schedulevehiclepeopleplan.getPlanvehicletypeid());
			ticketPrintInfo.setPlanvehiclegrade(vehicletype.getGrade());
			ticketPrintInfo.setPlanvehicletype(vehicletype.getType());
			ticketPrintInfo.setPlanvehicletypecustomname(vehicletype.getCustomname());
			ticketPrintInfo.setPrice(ticketsell.getPrice());
			ticketPrintInfo.setReachstationid(ticketsell.getReachstationid());
			station = (Station) dao.get(Station.class, ticketsell.getReachstationid());
			ticketPrintInfo.setReachstationname(station.getName());
			ticketPrintInfo.setReachstationsecondname(station.getSecondname());
			ticketPrintInfo.setIsroundtrip(station.getIsroundtrip());
			ticketPrintInfo.setRoutename(route.getName());
			ticketPrintInfo.setReturntripvaliddays(route.getReturntripvaliddays());
			ticketPrintInfo.setSchedulecode(schedule.getCode());
			ticketPrintInfo.setScheduleid(ticketsell.getScheduleid());
			ticketPrintInfo.setScheduleplanid(ticketsell.getScheduleplanid());
			ticketPrintInfo.setScheduleremarks(scheduleplan.getRemarks());
			ticketPrintInfo.setSeatno(ticketsell.getSeatno());
			
			_propertyFilters.clear();
			_propertyFilters.add(new PropertyFilter("EQL_t!vehicleseatplan.vehiclebrandmodelid",schedulevehiclepeopleplan.getPlanvehiclebrandmodelid()));
			_propertyFilters.add(new PropertyFilter("EQR_t!seatno",ticketsell.getSeatno()));
			List<Vehicleseatplandetail> vts = dao.find(Vehicleseatplandetail.class, _propertyFilters);
			//重打、取票增加取座位图中的备注信息
			if("T".equals(ticketsell.getTickettype())){
				if(oldticketno==null||"".equals(oldticketno)){
					oldticketno=ticketsell.getTicketno();
				}
				List<Ticketsell> tuants =findTuanTicketsell(oldticketno, ticketsell.getDepartdate(),ticketsell.getScheduleplanid());
				List<Short> list = new ArrayList<Short>();
//				BigDecimal price = BigDecimal.ZERO;
//				BigDecimal fueladditionfee = BigDecimal.ZERO;
//				BigDecimal stationservicefee = BigDecimal.ZERO;
//				BigDecimal servicefee = BigDecimal.ZERO;
				byte carrychildnum = 0;
				for (Ticketsell ts : tuants) {
					list.add(ts.getSeatno());
//					price = price.add(ts.getPrice());
//					fueladditionfee = fueladditionfee.add(ts.getFueladditionfee());
//					stationservicefee = stationservicefee.add(ts.getStationservicefee());
//					servicefee = servicefee.add(ts.getServicefee());
//					carrychildnum = (byte) (carrychildnum + ts.getCarrychildnum());
//			
				}
//				ticketPrintInfo.setPrice(price);
//				ticketPrintInfo.setFueladditionfee(fueladditionfee);
//				ticketPrintInfo.setStationservicefee(stationservicefee);
//				ticketPrintInfo.setServicefee(servicefee);
//				ticketPrintInfo.setCarrychildnum(carrychildnum);
				//将团体票的座位号转化为特殊字符串
				String seatno = seatnoToSeatstr(list);
				ticketPrintInfo.setSeatnostr(seatno.substring(0,seatno.length()-1));
			}else{
				if(vts!=null&&vts.size()>0&&vts.get(0).getRemarks()!=null
						&&vts.get(0).getRemarks().length()>0){
					ticketPrintInfo.setSeatnostr(vts.get(0).getRemarks());
				}
				else{
					ticketPrintInfo.setSeatnostr(new Short(ticketsell.getSeatno()).toString());
				}
			}
			
			ticketPrintInfo.setSeattype(ticketsell.getSeattype());
			ticketPrintInfo.setServicefee(ticketsell.getServicefee());
			station = (Station) dao.get(Station.class, route.getStartstationid());
			ticketPrintInfo.setStartstationname(station.getName());
			ticketPrintInfo.setDepartstationcode(station.getCode());
			ticketPrintInfo.setStationservicefee(ticketsell.getStationservicefee());
			ticketPrintInfo.setTicketentrance(ticketsell.getTicketentrance());
			_propertyFilters.clear();
			_propertyFilters.add(new PropertyFilter("EQS_t!name",ticketsell.getTicketentrance()));
			_propertyFilters.add(new PropertyFilter("EQL_t!orgid",scheduleplan.getOrgid()));
			_propertyFilters.add(new PropertyFilter("EQB_t!isactive",true));
			Ticketentrance tt= (Ticketentrance) dao.uniqueResult(Ticketentrance.class, _propertyFilters);
			if(tt!=null){
				ticketPrintInfo.setTicketentrancename(tt.getPrintname());
			}
			_propertyFilters.clear();
			_propertyFilters.add(new PropertyFilter("EQS_t!ticketno",ticketsell.getTicketno()));
			tmc = (TicketMixChange) dao.uniqueResult(TicketMixChange.class, _propertyFilters);
			
			if(tmc!=null) ticketPrintInfo.setTicketno(tmc.getOldticketno());
			else ticketPrintInfo.setTicketno(ticketsell.getTicketno());
			
			ticketPrintInfo.setTickettype(ticketsell.getTickettype());
			ticketPrintInfo.setToplimitprice(ticketsell.getToplimitprice());
			ticketPrintInfo.setWorkways(schedule.getWorkways());
			if(ticketsell.getCustomer()!=null){			   
			   ticketPrintInfo.setCustomerid(ticketsell.getCustomer().getId());
			   ticketPrintInfo.setCertificatetype(ticketsell.getCustomer().getCertificatetype());
			   ticketPrintInfo.setCertificateno(ticketsell.getCustomer().getCertificateno());
			   ticketPrintInfo.setCustomername(ticketsell.getCustomer().getName());
			}
			ticketPrintInfo.setIsaudited(schedule.getIsaudited());
			ticketPrintInfo.setIsauditpass(schedule.getIsauditpass());
			Schedulestop stp = getSchedulestop(schedule.getId(),ticketsell.getReachstationid());
			if(stp!=null){
				ticketPrintInfo.setSchedulestopremark1(stp.getRemark1());
				ticketPrintInfo.setSchedulestopremark2(stp.getRemark2());
				ticketPrintInfo.setSchedulestopremark3(stp.getRemark3());
				ticketPrintInfo.setSchedulestopremark4(stp.getRemark4());
				ticketPrintInfo.setSchedulestopremark5(stp.getRemark5());
			}else{
				ticketPrintInfo.setSchedulestopremark1("");
				ticketPrintInfo.setSchedulestopremark2("");
				ticketPrintInfo.setSchedulestopremark3("");
				ticketPrintInfo.setSchedulestopremark4("");
				ticketPrintInfo.setSchedulestopremark5("");
			}
			
			result.add(ticketPrintInfo);
		}
		return result;
	}
	
	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public ParameterService getParameterService() {
		return parameterService;
	}

	@Override
	public boolean unlockSeat(UUID orderno, Long scheduleplanid) throws Exception {
		return unlockSeat(orderno, scheduleplanid, null);
	}

	@Override
	public boolean unlockSeat(UUID orderno) throws Exception {
		return unlockSeat(orderno, null);
	}
	
	//之前改签方法：即本地改本地
	@Override
	public MethodResult changeTicket(String transationId, TicketOrder order, List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		if(ticketIdToBeChanges.size()!=insuranceIdToBeChanges.size()
		  || ticketIdToBeChanges.size()!=order.getTickets().size()){
			methodResult.setResultMsg("传入参数有误");
			return methodResult;
		}
		Date now = new Date();
		methodResult = this.sellTicket(transationId, order,global);
		if(methodResult.getResult()!=1){
			return methodResult;
		}
		int i=0;
		for (Long ticketIdToBeChange : ticketIdToBeChanges) {
			List<PropertyFilter> propertyFiltersinsu = new ArrayList<PropertyFilter>();
			Long insuranceIdToBeChange = insuranceIdToBeChanges.get(i);
			Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketIdToBeChange);
			
			if(ticketsell==null){
				throw new ServiceException("0214");
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0215");
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0216");
			}
			else if(ticketsell.getIschecked()){
				throw new ServiceException("0217");
			}
			else{
				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
				//判断发班状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));// global.getUserinfo().getId()
				
				String para_1503 = parameterService.findParamValue(ParamterConst.Param_1503, global.getOrganization().getId());
				Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
				if(ParamterConst.COMMON_FLAG.FALG_NO.equals(para_1503)&&schedulestatus.getIsdeparted()){
					throw new ServiceException("0213"); //原车票所在班次已发班不允许改签
				}

				//1507, 判断车票是否只允许改签一次
				String onlyonce = parameterService.findParamValue(ParamterConst.Param_1507, global.getOrganization().getId());
				if(!ParamterConst.COMMON_FLAG.FALG_YES.equals(onlyonce)){
					Map conditionmap = new HashMap<String, Object>();
					conditionmap.put("newticketsellid", ticketsell.getId());
					int haschange = (int) dao.countTotalRows(Ticketchange.class, conditionmap,"id");
					if(haschange>0){
						throw new ServiceException("0453"); //车票已经改签过，只允许改签一次
					}
				}
				//1508, 判断发车时间前N分钟内的车票不得改签
				String stopchangeminute = parameterService.findParamValue(ParamterConst.Param_1508, global.getOrganization().getId());
				Date departdatetime = DateUtils.mergerDateAndTime(ticketsell.getDepartdate(), ticketsell.getDeparttime());
				if(DateUtils.add(departdatetime, Calendar.MINUTE, -1*Integer.parseInt(stopchangeminute)).before(now)){
//					throw new ServiceException(); //超过允许改签的时间
					throw new ServiceException("请参考参数1508", "0454");
				}
			}
			//是否允许改签到低票价
			String ischangelowprce = parameterService.findParamValue(ParamterConst.Param_1509, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(ischangelowprce)&&(order.getTickets().get(i).getPrice().compareTo(ticketsell.getPrice())<0)){
				throw new ServiceException("0470");
			}
			String needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, global.getOrganization().getId());
			String needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameStation)&&(order.getTickets().get(i).getDepartstationid()!=ticketsell.getDepartstationid()
					||order.getTickets().get(i).getReachstationid()!=ticketsell.getReachstationid())){
				throw new ServiceException("0211");
			}
			
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameRoute)){
				Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
				Route route = schedule.getRoute();
				Schedule newschedule = (Schedule) dao.get(Schedule.class, order.getTickets().get(i).getScheduleid());
				Route newroute = newschedule.getRoute();
				if(newroute.getId()!=route.getId()){
					throw new ServiceException("0212");
				}
			}
			
			String needSamePrice = parameterService.findParamValue(ParamterConst.Param_1504, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSamePrice)&&!ticketsell.getPrice().equals(order.getTickets().get(i).getPrice())){
				throw new ServiceException("0210");
			}
			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setBilltype(null);
			ticketreturn.setCharges(new BigDecimal(0));
			if(insuranceIdToBeChange!=null&&insuranceIdToBeChange>0){
				ticketreturn.setIsreturninsure(true);
				ticketreturn.setReturninsureid(insuranceIdToBeChange);
			}
			else{
				ticketreturn.setIsreturninsure(false);
				ticketreturn.setReturninsureid(null);
			}
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setRemarks("改签退票");
			ticketreturn.setReturnamount(ticketsell.getPrice());
			ticketreturn.setReturnvoucherno(null);
			ticketreturn.setReturnway("3");//改签自动退
			ticketreturn.setSellid(ticketIdToBeChange);
			ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setIsreturnticket(true);
			ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(Long.parseLong(order.getStartTicketNO())+order.getTickets().size()).toString(),order.getStartTicketNO().length(), "0"));
			List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
			ticketreturns.add(ticketreturn);
			ticketreturnService.returnTickets(ticketreturns, global,order.getVipcardno(),order.getVipgrade(),order.getVipmoney(),order.getVippoint(),true,global.getUserinfo().getId());
			
			Ticketchange ticketchange = new Ticketchange();
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setChangeip(global.getIpAddress());
			ticketchange.setChangetime(now);
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setCreateby(global.getUserinfo().getId());
			ticketchange.setCreatetime(now);
			List<TicketPrintInfo> ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			ticketchange.setNewdepartdate(ticketPrintInfos.get(i).getDepartdate());
			ticketchange.setNewscheduleid(ticketPrintInfos.get(i).getScheduleid());
			ticketchange.setNewseatno(ticketPrintInfos.get(i).getSeatno());
			ticketchange.setNewticketno(ticketPrintInfos.get(i).getTicketno());
			ticketchange.setNewticketsellid(ticketPrintInfos.get(i).getId());
			String cuticketno = "0";

			//改签是否打印手续费，0不打印，1打印，默认为0
			if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1066, global.getOrganization().getId()))) {
				if(ticketPrintInfos.get(i).getTicketno().length()<=20){
					String schangeno = Long.valueOf(ticketPrintInfos.get(i).getTicketno())+1+"";	
					//将改签票号插入改签表中
					Billtype bt = billtypeService.findByCode("Ticket");
					if (schangeno.length() < bt.getTicketnolength()) {
						cuticketno = StringUtils.strPad(schangeno,
								(int) bt.getTicketnolength(), "0");
					}	
				}
			}
			
			ticketchange.setChangeticketno(cuticketno);
			
			ticketchange.setOlddepartdate(ticketsell.getDepartdate());
			ticketchange.setOldscheduleid(ticketsell.getScheduleid());
			ticketchange.setOldseatno(ticketsell.getSeatno());
			ticketchange.setOldticketno(ticketsell.getTicketno());
			ticketchange.setOldticketsellid(ticketsell.getId());
			ticketchange.setRemarks(null);
			ticketchange.setTicketoutletsid(order.getTicketoutletsid());
			ticketchange.setUpdateby(global.getUserinfo().getId());
			ticketchange.setUpdatetime(now);
			propertyFiltersinsu.clear();
			propertyFiltersinsu.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
			Insurance ins = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,propertyFiltersinsu);
//			if(null != ins){
			if(null != ins && !("10".equals(ins.getSellway()) || "7".equals(ins.getSellway()))){//自助机的和网售的保险不改签到新票上
				ins.setSellid(ticketchange.getNewticketsellid());
				dao.merge(ins);
			}
			
			dao.merge(ticketchange);
			dao.getEntityManager().flush();
			i++;
		}
		
		param1074 = parameterService.findParamValue(ParamterConst.Param_1074, global.getOrganization().getId());//参数1074，免票儿童是否单独打印车票，0不打印，1打印
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074) && childprintnum > 0){
			long childTicketno = Long.valueOf(childchangedetail.getTicketendno()) - childprintnum + 1;//儿童票(第一张)票号
			int billtypeLength = (int) billtypeService.findByCode("Ticket").getTicketnolength();
			String ticketno = "";
			TicketDao ticketdao = new TicketDao();
			List<TicketPrintInfo> printinfos = (List<TicketPrintInfo>) methodResult.getObject();//全票打印信息
			List<PropertyFilter> filter = new ArrayList<PropertyFilter>();
			
			int newChildIndex = 0;//取新生成的儿童票List元素
			for (int j = 0; j < ticketIdToBeChanges.size(); j++) {
				Long ticketIdToBeChange = ticketIdToBeChanges.get(j);
				boolean isNeedNewChildTicket = childinfoMap.get(ticketIdToBeChange);//是否需要新生成儿童票记录
				if(isNeedNewChildTicket){
					//需要新生成售票记录
					TicketPrintInfo newchildPrintInfo = newChildList.get(newChildIndex);
					newChildIndex++;
					
					TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) printinfos.get(j).clone();//车票打印信息
					
					Ticketsell quanpiao =  ticketdao.findNewTicketByOldTicket(ticketIdToBeChange);//新售出的全票
					Ticketsell ts = (Ticketsell) quanpiao.clone();//clone得到儿童票
					
					if(!"0".equals(quanpiao.getPaymethod())) {
						childchangedetail.setNoncashnum(childchangedetail.getNoncashnum()+1);
					}
//					childchangedetail.setChangenum(childchangedetail.getChangenum()+1);
					childchangedetail.setSellnum(childchangedetail.getSellnum()+1);
					dao.merge(childchangedetail);
					
					ts.setId(0L);
					ticketno = (StringUtils.strPad(Long.valueOf(childTicketno).toString(), billtypeLength, "0"));
					childTicketno++;
					ts.setTicketno(ticketno);
					ts.setTickettype("E");
					ts.setSeatno(quanpiao.getSeatno());
					ts.setFullprice(java.math.BigDecimal.ZERO);
					ts.setPrice(java.math.BigDecimal.ZERO);
					ts.setMoreprice(java.math.BigDecimal.ZERO);
					ts.setServicefee(java.math.BigDecimal.ZERO);
					ts.setToplimitprice(java.math.BigDecimal.ZERO);
					ts.setFueladditionfee(java.math.BigDecimal.ZERO);
					ts.setStationservicefee(java.math.BigDecimal.ZERO);
					ts.setComputefee(java.math.BigDecimal.ZERO);
					ts.setCoolairfee(java.math.BigDecimal.ZERO);
					ts.setAdditionfee(java.math.BigDecimal.ZERO);
					ts.setWaterfee(java.math.BigDecimal.ZERO);
					ts.setInsurefee(newchildPrintInfo.getInsurefee());//改签儿童不售保险
					ts.setOtherfee(java.math.BigDecimal.ZERO);
					ts.setCarrychildnum(Byte.parseByte("0"));
					Customer customer = (Customer) dao.get(Customer.class, childCustomerMap.get(ticketIdToBeChange));
					if(customer!=null)
					{
						ts.setCustomer(customer);
						ts.setCustomername(customer.getName());
						ts.setCertificateno(customer.getCertificateno());
						Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
						ts.setCertificatetypename(certificatetype.getValue());
						ticketPrintInfo.setCertificateno(customer.getCertificateno());
						ticketPrintInfo.setCustomername(customer.getName());
					}
					
					ts = (Ticketsell) dao.merge(ts);
					dao.getEntityManager().flush();
					
					//生成主票-儿童票记录
					CarryChild carryChild = new CarryChild();
					carryChild.setQticketid(quanpiao.getId());
					carryChild.setChildticketid(ts.getId());
					carryChild.setCreatetime(ts.getCreatetime());
					carryChild.setCreateby(ts.getCreateby());
					carryChild.setUpdatetime(ts.getUpdatetime());
					carryChild.setUpdateby(ts.getUpdateby());
					carryChild.setRemark(carryChild.getRemark() + ",改签新售出儿童票" + DateUtils.formatDatetime(carryChild.getCreatetime()));
					carryChild = (CarryChild) dao.merge(carryChild);
					
					play.Logger.info("改签新售出儿童票并打印儿童票，主票票号="
							+ quanpiao.getTicketno() + ", 携童票票号="
							+ ts.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId());
					ticketPrintInfo.setId(ts.getId());//儿童票id
					ticketPrintInfo.setCarrychildnum(Byte.parseByte("0"));
					ticketPrintInfo.setPrice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFullprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setMoreprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setServicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setToplimitprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFueladditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setStationservicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setComputefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setCoolairfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setAdditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setWaterfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setInsurefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setOtherfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setDepartdate(ts.getDepartdate());
					ticketPrintInfo.setDeparttime(ts.getDeparttime());
					ticketPrintInfo.setTicketno(ts.getTicketno());
					ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
					ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
					ticketPrintInfo.setTickettype("E");
					ticketPrintInfo.setSeatno(ts.getSeatno());
					ticketPrintInfo.setSeatnostr(Short.toString(ts.getSeatno()));
					order.getTickets().add(ticketPrintInfo);
					
					//修改保险记录
					filter.clear();
					filter.add(new PropertyFilter("EQL_t!sellid", ts.getId()));
					Insurance insurance = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,filter);
					if(insurance != null){
						insurance.setSellid(ts.getId());
						insurance.setUpdateby(insurance.getUpdateby());
						insurance.setUpdatetime(ts.getUpdatetime());
						ticketdao.merge(insurance);
					}
					
				}else{
					//不需要新生成售票记录，则修改原儿童票记录
					TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) printinfos.get(j).clone();//车票打印信息
					
					Ticketsell newquanpiao =  ticketdao.findNewTicketByOldTicket(ticketIdToBeChange);//新售出的全票
					newquanpiao.setCarrychildnum(Byte.parseByte("1"));//修改携童数为1
					ticketdao.getEntityManager().merge(newquanpiao);
					
					if(!"0".equals(newquanpiao.getPaymethod())) {
						childchangedetail.setNoncashnum(childchangedetail.getNoncashnum()+1);
					}
					childchangedetail.setChangenum(childchangedetail.getChangenum()+1);
					childchangedetail.setSellnum(childchangedetail.getSellnum()+1);
//					childchangedetail.setReturnnum(childchangedetail.getReturnnum()+1);
					dao.merge(childchangedetail);
					
					Ticketsell oldchild =  ticketdao.findChildByQticket(ticketIdToBeChange);//过主票sellid查到老的儿童票记录
					oldchild.setTicketstatus("1");//1已退
					oldchild.setUpdateby(newquanpiao.getUpdateby());
					oldchild.setUpdatetime(newquanpiao.getUpdatetime());
					ticketdao.merge(oldchild);
					
					Ticketsell newchild = (Ticketsell) newquanpiao.clone();
					newchild.setId(0L);
					ticketno = (StringUtils.strPad(Long.valueOf(childTicketno).toString(), billtypeLength, "0"));
					childTicketno++;
					newchild.setTicketno(ticketno);
					newchild.setTickettype("E");
					newchild.setSeatno(newquanpiao.getSeatno());
					newchild.setFullprice(oldchild.getFullprice());
					newchild.setPrice(oldchild.getPrice());
					newchild.setMoreprice(oldchild.getMoreprice());
					newchild.setServicefee(oldchild.getServicefee());
					newchild.setToplimitprice(oldchild.getToplimitprice());
					newchild.setFueladditionfee(oldchild.getFueladditionfee());
					newchild.setStationservicefee(oldchild.getStationservicefee());
					newchild.setComputefee(oldchild.getComputefee());
					newchild.setCoolairfee(oldchild.getCoolairfee());
					newchild.setAdditionfee(oldchild.getAdditionfee());
					newchild.setWaterfee(oldchild.getWaterfee());
					newchild.setInsurefee(oldchild.getInsurefee());
					newchild.setOtherfee(oldchild.getOtherfee());
					newchild.setCarrychildnum(Byte.parseByte("0"));
					if(oldchild.getCustomer()!=null) {
						Customer customer = (Customer) dao.get(Customer.class, oldchild.getCustomer().getId());
						if(customer!=null)
						{
							newchild.setCustomer(customer);
							newchild.setCustomername(customer.getName());
							newchild.setCertificateno(customer.getCertificateno());
							Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
							newchild.setCertificatetypename(certificatetype.getValue());
							ticketPrintInfo.setCertificateno(customer.getCertificateno());
							ticketPrintInfo.setCustomername(customer.getName());
						}
					}
					
					newchild = (Ticketsell) dao.merge(newchild);
					
					//修改保险记录
					filter.clear();
					filter.add(new PropertyFilter("EQL_t!sellid", oldchild.getId()));
					Insurance insurance = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,filter);
//					if(insurance != null){
					if(null != insurance && !("10".equals(insurance.getSellway()) || "7".equals(insurance.getSellway()))){//自助机的和网售的保险不改签到新票上
						insurance.setSellid(newchild.getId());
						insurance.setUpdateby(insurance.getUpdateby());
						insurance.setUpdatetime(newchild.getUpdatetime());
						ticketdao.merge(insurance);
					}
					
//					Ticketreturn ticketreturn = new Ticketreturn();
//					ticketreturn.setBilltype(null);
//					ticketreturn.setCharges(new BigDecimal(0));
////					if(insurance!=null){
//					if(null != insurance && !("10".equals(insurance.getSellway()) || "7".equals(insurance.getSellway()))){//自助机的和网售的保险不改签到新票上
//						ticketreturn.setIsreturninsure(true);
//						ticketreturn.setReturninsureid(insurance.getId());
//					}
//					else{
//						ticketreturn.setIsreturninsure(false);
//						ticketreturn.setReturninsureid(null);
//					}
//					ticketreturn.setIsselfschedule(true);
//					ticketreturn.setRemarks("改签退票");
//					ticketreturn.setReturnamount(java.math.BigDecimal.ZERO);
//					ticketreturn.setReturnvoucherno(null);
//					ticketreturn.setReturnway("3");//改签自动退
//					ticketreturn.setSellid(oldchild.getId());
//					ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
//					ticketreturn.setTicketprice(java.math.BigDecimal.ZERO);
//					ticketreturn.setIsreturnticket(true);
//					ticketreturn.setReturnby(newchild.getCreateby());
//					ticketreturn.setReturntime(newchild.getCreatetime());
//					ticketreturn.setReturnip(global.getIpAddress());
//					ticketreturn.setCreateby(newchild.getCreateby());
//					ticketreturn.setCreatetime(newchild.getCreatetime());
//					ticketreturn.setUpdateby(newchild.getUpdateby());
//					ticketreturn.setUpdatetime(newchild.getUpdatetime());
//					ticketdao.merge(ticketreturn);
					
					//生成主票-儿童票记录
					CarryChild carryChild = new CarryChild();
					carryChild.setQticketid(newquanpiao.getId());
					carryChild.setChildticketid(newchild.getId());
					carryChild.setCreatetime(newchild.getCreatetime());
					carryChild.setCreateby(newchild.getCreateby());
					carryChild.setUpdatetime(newchild.getUpdatetime());
					carryChild.setUpdateby(newchild.getUpdateby());
					carryChild.setRemark("改签儿童票,原儿童票为" + oldchild.getTicketno() + ", " + DateUtils.formatDatetime(carryChild.getCreatetime()));
					carryChild = (CarryChild) dao.merge(carryChild);
					
					play.Logger.info("改签儿童票并打印儿童票，主票票号="
							+ newquanpiao.getTicketno() + ", 携童票票号="
							+ newchild.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId() + ",原儿童票号=" + oldchild.getTicketno());
					ticketPrintInfo.setId(newchild.getId());//儿童票id
					ticketPrintInfo.setCarrychildnum(Byte.parseByte("0"));
					ticketPrintInfo.setPrice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFullprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setMoreprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setServicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setToplimitprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFueladditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setStationservicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setComputefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setCoolairfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setAdditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setWaterfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setInsurefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setOtherfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setDepartdate(newchild.getDepartdate());
					ticketPrintInfo.setDeparttime(newchild.getDeparttime());
					ticketPrintInfo.setTicketno(newchild.getTicketno());
					ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
					ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
					ticketPrintInfo.setTickettype("E");
					ticketPrintInfo.setSeatno(newchild.getSeatno());
					ticketPrintInfo.setSeatnostr(Short.toString(newchild.getSeatno()));
					order.getTickets().add(ticketPrintInfo);
					
					//生成改签记录
					Ticketchange ticketchange = new Ticketchange();
					ticketchange.setChangeby(global.getUserinfo().getId());
					ticketchange.setChangeip(global.getIpAddress());
					ticketchange.setChangetime(now);
					ticketchange.setChangeby(global.getUserinfo().getId());
					ticketchange.setCreateby(global.getUserinfo().getId());
					ticketchange.setCreatetime(now);
					ticketchange.setNewdepartdate(newchild.getDepartdate());
					ticketchange.setNewscheduleid(newchild.getScheduleid());
					ticketchange.setNewseatno(newchild.getSeatno());
					ticketchange.setNewticketno(newchild.getTicketno());
					ticketchange.setNewticketsellid(newchild.getId());
					ticketchange.setChangeticketno("--");//改签凭证号
					ticketchange.setOlddepartdate(oldchild.getDepartdate());
					ticketchange.setOldscheduleid(oldchild.getScheduleid());
					ticketchange.setOldseatno(oldchild.getSeatno());
					ticketchange.setOldticketno(oldchild.getTicketno());
					ticketchange.setOldticketsellid(oldchild.getId());
					ticketchange.setRemarks("改签儿童票，原票号为：" + oldchild.getTicketno());
					ticketchange.setTicketoutletsid(order.getTicketoutletsid());
					ticketchange.setUpdateby(global.getUserinfo().getId());
					ticketchange.setUpdatetime(now);
					ticketdao.merge(ticketchange);
				}
			}
			
			childTicketno++;//票号+1
		}
		
		return methodResult;
	}
	
	//改签方法：
	//改签方法：(1)原票是携童票，改签时不需要再输入儿童票；(2)原票不是携童票，改签时改为携童票，则需要在页面输入携童数。
	int childprintnum = 0;//儿童票打印张数
//	List<Long> primaryIdList = new ArrayList<Long>();//所有的改签（主）票的id
	Map<Long, Boolean> childinfoMap = new HashMap<Long, Boolean>();//保存全票id和是否需要新售出儿童票
	Map<Long, Long> childCustomerMap = new HashMap<Long, Long>();//保存全票id和对应儿童票的customerid，记录新生成儿童票的顾客信息
	List<TicketPrintInfo> newChildList = new ArrayList<TicketPrintInfo>();//改签时新售出的儿童票
	@Override
	public MethodResult changeTicket_All(String transationId, TicketOrder order, List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		
		//儿童票在主票改签完之后，单独处理
		int index = 0;
		StringBuffer info = null;
		Ticketsell childTicket = null;
		TicketDao tkdao = new TicketDao();
		Iterator<TicketPrintInfo> iterator = order.getTickets().iterator();
		int count = 0;//遍历条数
		while (iterator.hasNext()) {
			TicketPrintInfo tpi = iterator.next();
			if (!tpi.getTickettype().equals("E")) {
				Ticketsell oldticket = (Ticketsell) dao.get(Ticketsell.class, ticketIdToBeChanges.get(index));
				if(oldticket != null){
					Schedule oldschedule = (Schedule) dao.get(Schedule.class, oldticket.getScheduleid());
					tpi.setOldSchedulecode(oldschedule.getCode());
					tpi.setOldTicketno(oldticket.getTicketno());
					childTicket = tkdao.findChildByQticket(ticketIdToBeChanges.get(index));	
				}
				
//				index++;
			}else{
				tpi.setCarrychildnum(Byte.valueOf("0"));
			}
			
			if (tpi.getCarrychildnum() > 0) {
				if(childTicket != null){
					info = new StringBuffer();
					info.append("此票已为携童票，改签时无需再输入携童数。儿童票票号为：").append(childTicket.getTicketno());
					play.Logger.error(info.toString());
					throw new BusinessException(info.toString());
				}else{
					//新售出儿童票
					childprintnum++;//儿童票打印张数+1
//					primaryIdList.add(ticketIdToBeChanges.get(index));
					childinfoMap.put(ticketIdToBeChanges.get(index), true);// 此票需要新售儿童票
					childCustomerMap.put(ticketIdToBeChanges.get(index), tpi.getCustomerid());// 记录此全票对应的儿童票的顾客id
					newChildList.add(tpi);//改签时新售出的儿童票
				}
			} 
			else {
				if(childTicket != null){
					childprintnum++;//原票为携童票，儿童票打印张数+1
					childinfoMap.put(ticketIdToBeChanges.get(index), false);//此票不需要新售儿童票
//					childCustomerMap.put(ticketIdToBeChanges.get(index), childTicket.getCustomer().getId());// 记录此全票对应的儿童票的顾客id
//					primaryIdList.add(ticketIdToBeChanges.get(index));
				}
			}
			
			if (tpi.getTickettype().equals("E")) {
				TicketPrintInfo lastQuan = order.getTickets().get(count - 1);//将儿童票保险费用加到上一张主票上的order参数中,供售票记录儿童票保险费使用
				if(lastQuan.getInsurefee() != null){
					if(lastQuan.getInsurefee().compareTo(java.math.BigDecimal.ZERO) > 0){
						//主票也要新售保险
						order.getTickets().get(count - 1).setInsurefee(lastQuan.getInsurefee().add(tpi.getInsurefee()));
					}else{
						//主票不售保险
						order.getTickets().get(count - 1).setInsurefee(tpi.getInsurefee());
					}
				}else{
					order.getTickets().get(count - 1).setInsurefee(tpi.getInsurefee());
				}
				
				iterator.remove();// 移除儿童票
				index++;
			}
			
			count++;
		}
		
		if(ticketIdToBeChanges.size()!=insuranceIdToBeChanges.size()
		  || ticketIdToBeChanges.size()!=order.getTickets().size()){
			methodResult.setResultMsg("传入参数有误");
			return methodResult;
		}
		
		Ticketsell ticketsell;
		Ticketsellagent ticketsellagent;//本售异
		int changeType = 0; //0本售本改到本地（本地改本地）；1本售本改到他站（本地改联网）；2异售本改到本地（联网改本地）；3异售本改到原站或第三站（联网改联网）；5本售异改原站（联网改联网）；6本售异改本地（联网改本地）；7本售异改第三站，不允许（联网改联网）
		
		//判断是否符合改签条件，暂时不支持 联网票改签到联网票
		Long ticketIdToBeChange = ticketIdToBeChanges.get(0);//第一张改签信息中的原票id，用来判断改签方式
		Long newOrgid = order.getTickets().get(0).getOrgid();//第一张改签信息中的新发车机构
		Long newDepartstationid = order.getTickets().get(0).getDepartstationid();//第一张改签信息中的新到达站
		ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketIdToBeChange);
		if(ticketsell == null){
			 ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketIdToBeChange);
			 if(ticketsellagent == null){
				 throw new ServiceException("0214");//车票不存在
			 }else{
				 if(global.getOrganization().getId() != newOrgid){
					 changeType = 5;//5本售异改原站（联网改联网）
//					 throw new BusinessException("本售异车票，只允许改为本站车票！");
				 }else{
					 if(global.getStationID().longValue() == newDepartstationid){
						 changeType = 6;//6本售异改本地（联网改本地）
					 }else{
						 changeType = 7;//7本售异改第三站，不允许（联网改联网）
//						 throw new BusinessException("本售异车票，只允许改为本站车票！");
//						 throw new ServerException("本售异车票，不允许改为非本站或原车站之外的车站班次！");
					 }
				 }
			 }
		}else{
			if(global.getOrganization().getId() == ticketsell.getOrgid()){
				//本地售票
				if(ticketsell.getDepartstationid() == newDepartstationid){
					changeType = 0;//0本售本改到本地（本地改本地）
				}else{
					changeType = 1;//1本售本改到他站（本地改联网）
				}
			}else{
				//异售本，即联网票，暂时只支持联网改本地
				if(global.getStationID().longValue() == newDepartstationid){
					changeType = 2;//2异售本改到本地（联网改本地）
				}else{
					changeType = 3;//3异售本改到原站或第三站（联网改联网）
//					throw new BusinessException("异售本车票,改签暂不支持联网票改为联网票！");
				}
			}
			
		}
		//具体选择不同的改签方法
		switch (changeType) {
			case 0:
				//0本售本改到本地（本地改本地）
				methodResult = changeTicket(transationId, order, ticketIdToBeChanges, 
									insuranceIdToBeChanges, global);
			break;
			case 1:
				//1本售本改到他站（本地改联网）
				methodResult = changeSelfticketToNet(transationId, order,
						ticketIdToBeChanges, insuranceIdToBeChanges, global);
				break;
			case 2:
				//2异售本改到本地（联网改本地）
				methodResult = changeOtherticketToSelfticket(transationId, order,
						ticketIdToBeChanges, insuranceIdToBeChanges, global);
				break;
			case 3:
				methodResult.setResultMsg("异售本车票,改签暂不支持联网票改为联网票！");//3异售本改到原站或第三站（联网改联网）
				break;
			case 4:
				methodResult.setResultMsg("异售本车票,改签暂不支持联网票改为联网票！");//4异售本改到原站或第三站（联网改联网）
				break;
			case 5:
				methodResult.setResultMsg("本售异车票，只允许改为本站车票！");//5本售异改原站（联网改联网）
				break;
			case 6:
				//6本售异改本地（联网改本地）
				methodResult = changeTicketagentToSelfticket(transationId, order,
						ticketIdToBeChanges, insuranceIdToBeChanges, global);
				break;
			case 7:
				methodResult.setResultMsg("本售异车票，只允许改为本站车票！");//7本售异改第三站，不允许（联网改联网）
				break;
			default:
				methodResult.setResultMsg("改签车票失败！");
				break;
		}
		
		return methodResult;
	}
	
	//1本售本改到他站（本地改联网）
	private MethodResult changeSelfticketToNet(String transationId, TicketOrder order, List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws Exception{
		MethodResult methodResult = new MethodResult();
		
		Date now = new Date();
		int i = 0;
		//校验车票是否允许改签
		for (Long ticketIdToBeChange : ticketIdToBeChanges) {
			Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketIdToBeChange);
			
			if(ticketsell==null){
				throw new ServiceException("0214");
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0215");
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0216");
			}
			else if(ticketsell.getIschecked()){
				throw new ServiceException("0217");
			}
			else{
				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
				//判断发班状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));// global.getUserinfo().getId()
				
				String para_1503 = parameterService.findParamValue(ParamterConst.Param_1503, global.getOrganization().getId());
				Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
				if(ParamterConst.COMMON_FLAG.FALG_NO.equals(para_1503)&&schedulestatus.getIsdeparted()){
					throw new ServiceException("0213"); //原车票所在班次已发班不允许改签
				}

				//1507, 判断车票是否只允许改签一次
				String onlyonce = parameterService.findParamValue(ParamterConst.Param_1507, global.getOrganization().getId());
				if(!ParamterConst.COMMON_FLAG.FALG_YES.equals(onlyonce)){
					Map conditionmap = new HashMap<String, Object>();
					conditionmap.put("newticketsellid", ticketsell.getId());
					int haschange = (int) dao.countTotalRows(Ticketchange.class, conditionmap,"id");
					if(haschange>0){
						throw new ServiceException("0453"); //车票已经改签过，只允许改签一次
					}
				}
				//1508, 判断发车时间前N分钟内的车票不得改签
				String stopchangeminute = parameterService.findParamValue(ParamterConst.Param_1508, global.getOrganization().getId());
				Date departdatetime = DateUtils.mergerDateAndTime(ticketsell.getDepartdate(), ticketsell.getDeparttime());
				if(DateUtils.add(departdatetime, Calendar.MINUTE, -1*Integer.parseInt(stopchangeminute)).before(now)){
//					throw new ServiceException(); //超过允许改签的时间
					throw new ServiceException("请参考参数1508", "0454");
				}
			}
			//是否允许改签到低票价
			String ischangelowprce = parameterService.findParamValue(ParamterConst.Param_1509, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(ischangelowprce)&&(order.getTickets().get(i).getPrice().compareTo(ticketsell.getPrice())<0)){
				throw new ServiceException("0470");
			}
			String needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, global.getOrganization().getId());
			String needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameStation)&&(order.getTickets().get(i).getDepartstationid()!=ticketsell.getDepartstationid()
					||order.getTickets().get(i).getReachstationid()!=ticketsell.getReachstationid())){
				throw new ServiceException("0211");
			}
			
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameRoute)){
				Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
				Route route = schedule.getRoute();
				Schedule newschedule = (Schedule) dao.get(Schedule.class, order.getTickets().get(i).getScheduleid());
				Route newroute = newschedule.getRoute();
				if(newroute.getId()!=route.getId()){
					throw new ServiceException("0212");
				}
			}
			
			String needSamePrice = parameterService.findParamValue(ParamterConst.Param_1504, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSamePrice)&&!ticketsell.getPrice().equals(order.getTickets().get(i).getPrice())){
				throw new ServiceException("0210");
			}
			
			i++;
		}
		
		//售联网票
		methodResult = netTicketSellOtherService.sellTicket(transationId, order, global);
		if (methodResult.getResult() != 1) {
			return methodResult;
		}
		
		//增加退票、改签记录
		i = 0;
		for (Long ticketIdToBeChange : ticketIdToBeChanges) {
			List<PropertyFilter> propertyFiltersinsu = new ArrayList<PropertyFilter>();
			Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketIdToBeChange);
			Long insuranceIdToBeChange = insuranceIdToBeChanges.get(i);
			
			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setBilltype(null);
			ticketreturn.setCharges(new BigDecimal(0));
			if(insuranceIdToBeChange!=null&&insuranceIdToBeChange>0){
				ticketreturn.setIsreturninsure(true);
				ticketreturn.setReturninsureid(insuranceIdToBeChange);
			}
			else{
				ticketreturn.setIsreturninsure(false);
				ticketreturn.setReturninsureid(null);
			}
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setRemarks("改签退票");
			ticketreturn.setReturnamount(ticketsell.getPrice());
			ticketreturn.setReturnvoucherno(null);
			ticketreturn.setReturnway("3");//改签自动退
			ticketreturn.setSellid(ticketIdToBeChange);
			ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setIsreturnticket(true);
			ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(Long.parseLong(order.getStartTicketNO())+order.getTickets().size()).toString(),order.getStartTicketNO().length(), "0"));
			List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
			ticketreturns.add(ticketreturn);
			ticketreturnService.returnTickets(ticketreturns, global,order.getVipcardno(),order.getVipgrade(),order.getVipmoney(),order.getVippoint(),true,global.getUserinfo().getId());
			
			Ticketchange ticketchange = new Ticketchange();
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setChangeip(global.getIpAddress());
			ticketchange.setChangetime(now);
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setCreateby(global.getUserinfo().getId());
			ticketchange.setCreatetime(now);
			List<TicketPrintInfo> ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			ticketchange.setNewdepartdate(ticketPrintInfos.get(i).getDepartdate());
			ticketchange.setNewscheduleid(ticketPrintInfos.get(i).getScheduleid());
			ticketchange.setNewseatno(ticketPrintInfos.get(i).getSeatno());
			ticketchange.setNewticketno(ticketPrintInfos.get(i).getTicketno());
			ticketchange.setNewticketsellid(ticketPrintInfos.get(i).getId());
			//将改签票号插入改签表中
			Billtype bt = billtypeService.findByCode("Ticket");
			String schangeno = Long.valueOf(ticketPrintInfos.get(i).getTicketno())+1+"";
			String cuticketno = schangeno;
			if (schangeno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(schangeno, (int) bt.getTicketnolength(), "0");
			}			
			ticketchange.setChangeticketno(cuticketno);
			ticketchange.setOlddepartdate(ticketsell.getDepartdate());
			ticketchange.setOldscheduleid(ticketsell.getScheduleid());
			ticketchange.setOldseatno(ticketsell.getSeatno());
			ticketchange.setOldticketno(ticketsell.getTicketno());
			ticketchange.setOldticketsellid(ticketsell.getId());
			ticketchange.setRemarks(null);
			ticketchange.setTicketoutletsid(order.getTicketoutletsid());
			ticketchange.setUpdateby(global.getUserinfo().getId());
			ticketchange.setUpdatetime(now);
			propertyFiltersinsu.clear();
			propertyFiltersinsu.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
			Insurance ins = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,propertyFiltersinsu);
//			if(null != ins){
			if(null != ins && !("10".equals(ins.getSellway()) || "7".equals(ins.getSellway()))){//自助机的和网售的保险不改签到新票上
				ins.setSellid(ticketchange.getNewticketsellid());
				dao.merge(ins);
			}
			
			dao.merge(ticketchange);
			i++;
		}
		
		return methodResult;
	}
	
	//2异售本改到本地（联网改本地）
	private MethodResult changeOtherticketToSelfticket(String transationId, TicketOrder order, List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws Exception{
		MethodResult methodResult = new MethodResult();
		if(ticketIdToBeChanges.size()!=insuranceIdToBeChanges.size()
		  || ticketIdToBeChanges.size()!=order.getTickets().size()){
			methodResult.setResultMsg("传入参数有误");
			return methodResult;
		}
		Date now = new Date();
		methodResult = this.sellTicket(transationId, order,global);//售票
		if(methodResult.getResult()!=1){
			return methodResult;
		}
		int i=0;
		for (Long ticketIdToBeChange : ticketIdToBeChanges) {
			List<PropertyFilter> propertyFiltersinsu = new ArrayList<PropertyFilter>();
			Long insuranceIdToBeChange = insuranceIdToBeChanges.get(i);
			Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketIdToBeChange);
			
			if(ticketsell==null){
				throw new ServiceException("0214");
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0215");
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0216");
			}
			else if(ticketsell.getIschecked()){
				throw new ServiceException("0217");
			}
			else{
				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
				//判断发班状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));// global.getUserinfo().getId()
				
				String para_1503 = parameterService.findParamValue(ParamterConst.Param_1503, global.getOrganization().getId());
				Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
				if(ParamterConst.COMMON_FLAG.FALG_NO.equals(para_1503)&&schedulestatus.getIsdeparted()){
					throw new ServiceException("0213"); //原车票所在班次已发班不允许改签
				}

				//1507, 判断车票是否只允许改签一次
				String onlyonce = parameterService.findParamValue(ParamterConst.Param_1507, global.getOrganization().getId());
				if(!ParamterConst.COMMON_FLAG.FALG_YES.equals(onlyonce)){
					Map conditionmap = new HashMap<String, Object>();
					conditionmap.put("newticketsellid", ticketsell.getId());
					int haschange = (int) dao.countTotalRows(Ticketchange.class, conditionmap,"id");
					if(haschange>0){
						throw new ServiceException("0453"); //车票已经改签过，只允许改签一次
					}
				}
				//1508, 判断发车时间前N分钟内的车票不得改签
				String stopchangeminute = parameterService.findParamValue(ParamterConst.Param_1508, global.getOrganization().getId());
				Date departdatetime = DateUtils.mergerDateAndTime(ticketsell.getDepartdate(), ticketsell.getDeparttime());
				if(DateUtils.add(departdatetime, Calendar.MINUTE, -1*Integer.parseInt(stopchangeminute)).before(now)){
//					throw new ServiceException(); //超过允许改签的时间
					throw new ServiceException("请参考参数1508", "0454");
				}
			}
			//是否允许改签到低票价
			String ischangelowprce = parameterService.findParamValue(ParamterConst.Param_1509, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(ischangelowprce)&&(order.getTickets().get(i).getPrice().compareTo(ticketsell.getPrice())<0)){
				throw new ServiceException("0470");
			}
			String needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, global.getOrganization().getId());
			String needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameStation)&&(order.getTickets().get(i).getDepartstationid()!=ticketsell.getDepartstationid()
					||order.getTickets().get(i).getReachstationid()!=ticketsell.getReachstationid())){
				throw new ServiceException("0211");
			}
			
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameRoute)){
				Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
				Route route = schedule.getRoute();
				Schedule newschedule = (Schedule) dao.get(Schedule.class, order.getTickets().get(i).getScheduleid());
				Route newroute = newschedule.getRoute();
				if(newroute.getId()!=route.getId()){
					throw new ServiceException("0212");
				}
			}
			
			String needSamePrice = parameterService.findParamValue(ParamterConst.Param_1504, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSamePrice)&&!ticketsell.getPrice().equals(order.getTickets().get(i).getPrice())){
				throw new ServiceException("0210");
			}
			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setBilltype(null);
			ticketreturn.setCharges(new BigDecimal(0));
			if(insuranceIdToBeChange!=null&&insuranceIdToBeChange>0){
				ticketreturn.setIsreturninsure(true);
				ticketreturn.setReturninsureid(insuranceIdToBeChange);
			}
			else{
				ticketreturn.setIsreturninsure(false);
				ticketreturn.setReturninsureid(null);
			}
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setRemarks("改签退票");
			ticketreturn.setReturnamount(ticketsell.getPrice());
			ticketreturn.setReturnvoucherno(null);
			ticketreturn.setReturnway("3");//改签自动退
			ticketreturn.setSellid(ticketIdToBeChange);
			ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setIsreturnticket(true);
			ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(Long.parseLong(order.getStartTicketNO())+order.getTickets().size()).toString(),order.getStartTicketNO().length(), "0"));
			List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
			ticketreturns.add(ticketreturn);
			
			Ticketchange ticketchange = new Ticketchange();
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setChangeip(global.getIpAddress());
			ticketchange.setChangetime(now);
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setCreateby(global.getUserinfo().getId());
			ticketchange.setCreatetime(now);
			List<TicketPrintInfo> ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			ticketchange.setNewdepartdate(ticketPrintInfos.get(i).getDepartdate());
			ticketchange.setNewscheduleid(ticketPrintInfos.get(i).getScheduleid());
			ticketchange.setNewseatno(ticketPrintInfos.get(i).getSeatno());
			ticketchange.setNewticketno(ticketPrintInfos.get(i).getTicketno());
			ticketchange.setNewticketsellid(ticketPrintInfos.get(i).getId());
			//将改签票号插入改签表中
			Billtype bt = billtypeService.findByCode("Ticket");
			String schangeno = Long.valueOf(ticketPrintInfos.get(i).getTicketno())+1+"";
			String cuticketno = schangeno;
			if (schangeno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(schangeno,
						(int) bt.getTicketnolength(), "0");
			}			
			ticketchange.setChangeticketno(cuticketno);
			ticketchange.setOlddepartdate(ticketsell.getDepartdate());
			ticketchange.setOldscheduleid(ticketsell.getScheduleid());
			ticketchange.setOldseatno(ticketsell.getSeatno());
			ticketchange.setOldticketno(ticketsell.getTicketno());
			ticketchange.setOldticketsellid(ticketsell.getId());
			ticketchange.setRemarks(null);
			ticketchange.setTicketoutletsid(order.getTicketoutletsid());
			ticketchange.setUpdateby(global.getUserinfo().getId());
			ticketchange.setUpdatetime(now);
			
			//异售本改签为本地票时，将原售票站的车票状态改为改签
			ticketreturnService.changeOtherSellLocalTickets(ticketreturns, ticketchange, global,
					order.getVipcardno(), order.getVipgrade(),
					order.getVipmoney(), order.getVippoint(), true);
			
			propertyFiltersinsu.clear();
			propertyFiltersinsu.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
			Insurance ins = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,propertyFiltersinsu);
//			if(null != ins){
			if(null != ins && !("10".equals(ins.getSellway()) || "7".equals(ins.getSellway()))){//自助机的和网售的保险不改签到新票上
				ins.setSellid(ticketchange.getNewticketsellid());
				dao.merge(ins);
			}
			
			dao.merge(ticketchange);
			i++;
		}
		if(methodResult.getResult() != 1){
			play.Logger.error("异售本车票改签为本地票失败！ticketIdToBeChanges=" + JsonUtil.parseObject(ticketIdToBeChanges)
					+ ", TicketOrder=" + JsonUtil.parseObject(order));
			throw new BusinessException("改签失败！");
		}
		
		param1074 = parameterService.findParamValue(ParamterConst.Param_1074, global.getOrganization().getId());//参数1074，免票儿童是否单独打印车票，0不打印，1打印
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074) && childprintnum > 0){
			long childTicketno = Long.valueOf(childchangedetail.getTicketendno()) - childprintnum + 1;//儿童票(第一张)票号
			int billtypeLength = (int) billtypeService.findByCode("Ticket").getTicketnolength();
			String ticketno = "";
			TicketDao ticketdao = new TicketDao();
			List<TicketPrintInfo> printinfos = (List<TicketPrintInfo>) methodResult.getObject();//全票打印信息
			List<PropertyFilter> filter = new ArrayList<PropertyFilter>();
			
			dao.getEntityManager().flush();
			
			int newChildIndex = 0;//取新生成的儿童票List元素
			for (int j = 0; j < ticketIdToBeChanges.size(); j++) {
				Long ticketIdToBeChange = ticketIdToBeChanges.get(j);
				boolean isNeedNewChildTicket = childinfoMap.get(ticketIdToBeChange);//是否需要新生成儿童票记录
				if(isNeedNewChildTicket){
					//需要新生成售票记录
					TicketPrintInfo newchildPrintInfo = newChildList.get(newChildIndex);
					newChildIndex++;
					
					TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) printinfos.get(j).clone();//车票打印信息
					
					Ticketsell quanpiao =  ticketdao.findNewTicketByOldTicket(ticketIdToBeChange);//新售出的全票
					Ticketsell ts = (Ticketsell) quanpiao.clone();//clone得到儿童票
					
					if(!"0".equals(quanpiao.getPaymethod())) {
						childchangedetail.setNoncashnum(childchangedetail.getNoncashnum()+1);
					}
//					childchangedetail.setChangenum(childchangedetail.getChangenum()+1);
					childchangedetail.setSellnum(childchangedetail.getSellnum()+1);
					dao.merge(childchangedetail);
					
					ts.setId(0L);
					ticketno = (StringUtils.strPad(Long.valueOf(childTicketno).toString(), billtypeLength, "0"));
					childTicketno++;
					ts.setTicketno(ticketno);
					ts.setTickettype("E");
					ts.setSeatno(quanpiao.getSeatno());
					ts.setFullprice(java.math.BigDecimal.ZERO);
					ts.setPrice(java.math.BigDecimal.ZERO);
					ts.setMoreprice(java.math.BigDecimal.ZERO);
					ts.setServicefee(java.math.BigDecimal.ZERO);
					ts.setToplimitprice(java.math.BigDecimal.ZERO);
					ts.setFueladditionfee(java.math.BigDecimal.ZERO);
					ts.setStationservicefee(java.math.BigDecimal.ZERO);
					ts.setComputefee(java.math.BigDecimal.ZERO);
					ts.setCoolairfee(java.math.BigDecimal.ZERO);
					ts.setAdditionfee(java.math.BigDecimal.ZERO);
					ts.setWaterfee(java.math.BigDecimal.ZERO);
//					ts.setInsurefee(java.math.BigDecimal.ZERO);//改签儿童不售保险
					ts.setInsurefee(newchildPrintInfo.getInsurefee());
					ts.setOtherfee(java.math.BigDecimal.ZERO);
					ts.setCarrychildnum(Byte.parseByte("0"));
					Customer customer = (Customer) dao.get(Customer.class, childCustomerMap.get(ticketIdToBeChange));
					if(customer!=null)
					{
						ts.setCustomer(customer);
						ts.setCustomername(customer.getName());
						ts.setCertificateno(customer.getCertificateno());
						Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
						ts.setCertificatetypename(certificatetype.getValue());
						ticketPrintInfo.setCertificateno(customer.getCertificateno());
						ticketPrintInfo.setCustomername(customer.getName());
					}
					
					ts = (Ticketsell) dao.merge(ts);
					dao.getEntityManager().flush();
					
					//生成主票-儿童票记录
					CarryChild carryChild = new CarryChild();
					carryChild.setQticketid(quanpiao.getId());
					carryChild.setChildticketid(ts.getId());
					carryChild.setCreatetime(ts.getCreatetime());
					carryChild.setCreateby(ts.getCreateby());
					carryChild.setUpdatetime(ts.getUpdatetime());
					carryChild.setUpdateby(ts.getUpdateby());
					carryChild.setRemark(carryChild.getRemark() + ",改签新售出儿童票" + DateUtils.formatDatetime(carryChild.getCreatetime()));
					carryChild = (CarryChild) dao.merge(carryChild);
					
					play.Logger.info("改签新售出儿童票并打印儿童票，主票票号="
							+ quanpiao.getTicketno() + ", 携童票票号="
							+ ts.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId());
					ticketPrintInfo.setId(ts.getId());//儿童票id
					ticketPrintInfo.setCarrychildnum(Byte.parseByte("0"));
					ticketPrintInfo.setPrice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFullprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setMoreprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setServicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setToplimitprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFueladditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setStationservicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setComputefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setCoolairfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setAdditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setWaterfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setInsurefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setOtherfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setDepartdate(ts.getDepartdate());
					ticketPrintInfo.setDeparttime(ts.getDeparttime());
					ticketPrintInfo.setTicketno(ts.getTicketno());
					ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
					ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
					ticketPrintInfo.setTickettype("E");
					ticketPrintInfo.setSeatno(ts.getSeatno());
					ticketPrintInfo.setSeatnostr(Short.toString(ts.getSeatno()));
					order.getTickets().add(ticketPrintInfo);
					
					
				}else{
					//不需要新生成售票记录，则修改原儿童票记录
					TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) printinfos.get(j).clone();//车票打印信息
					
					Ticketsell newquanpiao =  ticketdao.findNewTicketByOldTicket(ticketIdToBeChange);//新售出的全票
					newquanpiao.setCarrychildnum(Byte.parseByte("1"));//修改携童数为1
					ticketdao.getEntityManager().merge(newquanpiao);
					
					Ticketsell oldchild =  ticketdao.findChildByQticket(ticketIdToBeChange);//过主票sellid查到老的儿童票记录
					oldchild.setTicketstatus("1");//1已退
					oldchild.setUpdateby(newquanpiao.getUpdateby());
					oldchild.setUpdatetime(newquanpiao.getUpdatetime());
					ticketdao.merge(oldchild);
					
					if(!"0".equals(oldchild.getPaymethod())) {
						childchangedetail.setNoncashnum(childchangedetail.getNoncashnum()+1);
					}
					childchangedetail.setChangenum(childchangedetail.getChangenum()+1);
					childchangedetail.setSellnum(childchangedetail.getSellnum()+1);
//					childchangedetail.setReturnnum(childchangedetail.getReturnnum()+1);
					dao.merge(childchangedetail);
					
					Ticketsell newchild = (Ticketsell) newquanpiao.clone();
					newchild.setId(0L);
					ticketno = (StringUtils.strPad(Long.valueOf(childTicketno).toString(), billtypeLength, "0"));
					childTicketno++;
					newchild.setTicketno(ticketno);
					newchild.setTickettype("E");
					newchild.setSeatno(newquanpiao.getSeatno());
					newchild.setFullprice(oldchild.getFullprice());
					newchild.setPrice(oldchild.getPrice());
					newchild.setMoreprice(oldchild.getMoreprice());
					newchild.setServicefee(oldchild.getServicefee());
					newchild.setToplimitprice(oldchild.getToplimitprice());
					newchild.setFueladditionfee(oldchild.getFueladditionfee());
					newchild.setStationservicefee(oldchild.getStationservicefee());
					newchild.setComputefee(oldchild.getComputefee());
					newchild.setCoolairfee(oldchild.getCoolairfee());
					newchild.setAdditionfee(oldchild.getAdditionfee());
					newchild.setWaterfee(oldchild.getWaterfee());
					newchild.setInsurefee(oldchild.getInsurefee());
					newchild.setOtherfee(oldchild.getOtherfee());
					newchild.setCarrychildnum(Byte.parseByte("0"));
//					if(childCustomerMap.get(ticketIdToBeChange) != null){
						Customer customer = (Customer) dao.get(Customer.class, oldchild.getCustomer().getId());
						if(customer!=null)
						{
							newchild.setCustomer(customer);
							newchild.setCustomername(customer.getName());
							newchild.setCertificateno(customer.getCertificateno());
							Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
							newchild.setCertificatetypename(certificatetype.getValue());
							ticketPrintInfo.setCertificateno(customer.getCertificateno());
							ticketPrintInfo.setCustomername(customer.getName());
						}
//					}
					
					newchild = (Ticketsell) dao.merge(newchild);
					
					//修改保险记录
					filter.clear();
					filter.add(new PropertyFilter("EQL_t!sellid", oldchild.getId()));
					Insurance insurance = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,filter);
//					if(insurance != null){
					if(null != insurance && !("10".equals(insurance.getSellway()) || "7".equals(insurance.getSellway()))){//自助机的和网售的保险不改签到新票上
						insurance.setSellid(newchild.getId());
						insurance.setUpdateby(insurance.getUpdateby());
						insurance.setUpdatetime(newchild.getUpdatetime());
						ticketdao.merge(insurance);
					}
					
//					Ticketreturn ticketreturn = new Ticketreturn();
//					ticketreturn.setBilltype(null);
//					ticketreturn.setCharges(new BigDecimal(0));
////					if(insurance!=null){
//					if(null != insurance && !("10".equals(insurance.getSellway()) || "7".equals(insurance.getSellway()))){//自助机的和网售的保险不改签到新票上
//						ticketreturn.setIsreturninsure(true);
//						ticketreturn.setReturninsureid(insurance.getId());
//					}
//					else{
//						ticketreturn.setIsreturninsure(false);
//						ticketreturn.setReturninsureid(null);
//					}
//					ticketreturn.setIsselfschedule(true);
//					ticketreturn.setRemarks("改签退票");
//					ticketreturn.setReturnamount(java.math.BigDecimal.ZERO);
//					ticketreturn.setReturnvoucherno(null);
//					ticketreturn.setReturnway("3");//改签自动退
//					ticketreturn.setSellid(oldchild.getId());
//					ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
//					ticketreturn.setTicketprice(java.math.BigDecimal.ZERO);
//					ticketreturn.setIsreturnticket(true);
//					ticketreturn.setReturnby(newchild.getCreateby());
//					ticketreturn.setReturntime(newchild.getCreatetime());
//					ticketreturn.setReturnip(global.getIpAddress());
//					ticketreturn.setCreateby(newchild.getCreateby());
//					ticketreturn.setCreatetime(newchild.getCreatetime());
//					ticketreturn.setUpdateby(newchild.getUpdateby());
//					ticketreturn.setUpdatetime(newchild.getUpdatetime());
//					ticketdao.merge(ticketreturn);
					
					//生成主票-儿童票记录
					CarryChild carryChild = new CarryChild();
					carryChild.setQticketid(newquanpiao.getId());
					carryChild.setChildticketid(newchild.getId());
					carryChild.setCreatetime(newchild.getCreatetime());
					carryChild.setCreateby(newchild.getCreateby());
					carryChild.setUpdatetime(newchild.getUpdatetime());
					carryChild.setUpdateby(newchild.getUpdateby());
					carryChild.setRemark("改签儿童票,原儿童票为" + oldchild.getTicketno() + ", " + DateUtils.formatDatetime(carryChild.getCreatetime()));
					carryChild = (CarryChild) dao.merge(carryChild);
					
					play.Logger.info("改签儿童票并打印儿童票，主票票号="
							+ newquanpiao.getTicketno() + ", 携童票票号="
							+ newchild.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId() + ",原儿童票号=" + oldchild.getTicketno());
					ticketPrintInfo.setId(newchild.getId());//儿童票id
					ticketPrintInfo.setCarrychildnum(Byte.parseByte("0"));
					ticketPrintInfo.setPrice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFullprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setMoreprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setServicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setToplimitprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFueladditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setStationservicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setComputefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setCoolairfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setAdditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setWaterfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setInsurefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setOtherfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setDepartdate(newchild.getDepartdate());
					ticketPrintInfo.setDeparttime(newchild.getDeparttime());
					ticketPrintInfo.setTicketno(newchild.getTicketno());
					ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
					ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
					ticketPrintInfo.setTickettype("E");
					ticketPrintInfo.setSeatno(newchild.getSeatno());
					ticketPrintInfo.setSeatnostr(Short.toString(newchild.getSeatno()));
					order.getTickets().add(ticketPrintInfo);
					
					//生成改签记录
					Ticketchange ticketchange = new Ticketchange();
					ticketchange.setChangeby(global.getUserinfo().getId());
					ticketchange.setChangeip(global.getIpAddress());
					ticketchange.setChangetime(now);
					ticketchange.setChangeby(global.getUserinfo().getId());
					ticketchange.setCreateby(global.getUserinfo().getId());
					ticketchange.setCreatetime(now);
					ticketchange.setNewdepartdate(newchild.getDepartdate());
					ticketchange.setNewscheduleid(newchild.getScheduleid());
					ticketchange.setNewseatno(newchild.getSeatno());
					ticketchange.setNewticketno(newchild.getTicketno());
					ticketchange.setNewticketsellid(newchild.getId());
					ticketchange.setChangeticketno("--");//改签凭证号
					ticketchange.setOlddepartdate(oldchild.getDepartdate());
					ticketchange.setOldscheduleid(oldchild.getScheduleid());
					ticketchange.setOldseatno(oldchild.getSeatno());
					ticketchange.setOldticketno(oldchild.getTicketno());
					ticketchange.setOldticketsellid(oldchild.getId());
					ticketchange.setRemarks("改签儿童票，原票号为：" + oldchild.getTicketno());
					ticketchange.setTicketoutletsid(order.getTicketoutletsid());
					ticketchange.setUpdateby(global.getUserinfo().getId());
					ticketchange.setUpdatetime(now);
					ticketdao.merge(ticketchange);
				}
			}
			
			childTicketno++;//票号+1
		}
		return methodResult;
	}
	
	//6本售异改本地（联网改本地）
	private MethodResult changeTicketagentToSelfticket(String transationId, TicketOrder order, List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws Exception{
		MethodResult methodResult = new MethodResult();

		methodResult = this.sellTicket(transationId, order, global);//售本地票
		if(methodResult.getResult()!=1){
			return methodResult;
		}
		
		Date now = new Date();
		int i = 0;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		for (Long ticketIdToBeChange : ticketIdToBeChanges) {
			List<PropertyFilter> propertyFiltersinsu = new ArrayList<PropertyFilter>();
			Long insuranceIdToBeChange = insuranceIdToBeChanges.get(i);
			//本售异车票
			Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketIdToBeChange);
			
			if(ticketsellagent == null){
				throw new ServiceException("0214");
			}
			else if("1".equals(ticketsellagent.getTicketstatus())){
				throw new ServiceException("0215");
			}
			else if("2".equals(ticketsellagent.getTicketstatus())){
				throw new ServiceException("0216");
			}
//			else if(ticketsellAgent.getIschecked()){.
//				throw new ServiceException("0217");//车票已检
//			}
			else{
//				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
//				propertyFilters.clear();
//				propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsellAgent.getId()));
//				//判断发班状态
//				propertyFilters.clear();
//				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsellAgent.getScheduleplanid()));
//				propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsellAgent.getDepartstationid()));
//				
//				String para_1503 = parameterService.findParamValue(ParamterConst.Param_1503, global.getOrganization().getId());
////				Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
//				if(ParamterConst.COMMON_FLAG.FALG_NO.equals(para_1503)&&schedulestatus.getIsdeparted()){
//					throw new ServiceException("0213"); //原车票所在班次已发班不允许改签
//				}

				//1507, 判断车票是否只允许改签一次
				String onlyonce = parameterService.findParamValue(ParamterConst.Param_1507, global.getOrganization().getId());
				if(!ParamterConst.COMMON_FLAG.FALG_YES.equals(onlyonce)){
					Map conditionmap = new HashMap<String, Object>();
					conditionmap.put("oldticketsellid", ticketsellagent.getId());
					int haschange = (int) dao.countTotalRows(Ticketchange.class, conditionmap,"id");
					if(haschange>0){
						throw new ServiceException("0453"); //车票已经改签过，只允许改签一次
					}
				}
				//1508, 判断发车时间前N分钟内的车票不得改签
				String stopchangeminute = parameterService.findParamValue(ParamterConst.Param_1508, global.getOrganization().getId());
				Date departdatetime = DateUtils.mergerDateAndTime(ticketsellagent.getDepartdate(), ticketsellagent.getDeparttime());
				if(DateUtils.add(departdatetime, Calendar.MINUTE, -1*Integer.parseInt(stopchangeminute)).before(now)){
					throw new ServiceException("请参考参数1508", "0454");//超过允许改签的时间
				}
			}
			
			//是否允许改签到低票价
			String ischangelowprce = parameterService.findParamValue(ParamterConst.Param_1509, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(ischangelowprce)&&(order.getTickets().get(i).getPrice().compareTo(ticketsellagent.getPrice())<0)){
				throw new ServiceException("0470");
			}
			
			//1505不同到达站是否允许改签;
			String needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameStation)&&(order.getTickets().get(i).getDepartstationid()!=ticketsellagent.getDepartstationid()
					||order.getTickets().get(i).getReachstationid()!=ticketsellagent.getReachstationid())){
				throw new ServiceException("0211");
			}
			
			// 1506不同线路是否允许改签
			String needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSameRoute)){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticketsellagent.getSchedulecode()));
				Schedule schedule = (Schedule) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedule.class,propertyFilters);
				if(schedule == null){
					play.Logger.error("本售异车票改签时，未查到原票班次信息，schedulecode=" + ticketsellagent.getSchedulecode());
					throw new ServiceException("0212");
				}else{
					Route route = schedule.getRoute();
					Schedule newschedule = (Schedule) dao.get(Schedule.class, order.getTickets().get(i).getScheduleid());
					Route newroute = newschedule.getRoute();
					if(newroute.getId()!=route.getId()){
						throw new ServiceException("0212");
					}
				}
			}
			
			//1504不同票价是否允许改签
			String needSamePrice = parameterService.findParamValue(ParamterConst.Param_1504, global.getOrganization().getId());
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(needSamePrice)&&!ticketsellagent.getPrice().equals(order.getTickets().get(i).getPrice())){
				throw new ServiceException("0210");
			}
			
			//记录改签自动退票、改签表数据
			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setBilltype(null);
			ticketreturn.setCharges(new BigDecimal(0));
			if(insuranceIdToBeChange!=null&&insuranceIdToBeChange>0){
				ticketreturn.setIsreturninsure(true);
				ticketreturn.setReturninsureid(insuranceIdToBeChange);
			}
			else{
				ticketreturn.setIsreturninsure(false);
				ticketreturn.setReturninsureid(null);
			}
			ticketreturn.setIsselfschedule(false);
			ticketreturn.setRemarks("改签退票");
			ticketreturn.setReturnamount(ticketsellagent.getPrice());
			ticketreturn.setReturnvoucherno(null);
			ticketreturn.setReturnway("3");//改签自动退
			ticketreturn.setSellid(ticketIdToBeChange);
			ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
			ticketreturn.setTicketprice(ticketsellagent.getPrice());
			ticketreturn.setIsreturnticket(true);
			ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(Long.parseLong(order.getStartTicketNO())+order.getTickets().size()).toString(),order.getStartTicketNO().length(), "0"));
			List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
			ticketreturns.add(ticketreturn);
		
			Ticketchange ticketchange = new Ticketchange();
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setChangeip(global.getIpAddress());
			ticketchange.setChangetime(now);
			ticketchange.setChangeby(global.getUserinfo().getId());
			ticketchange.setCreateby(global.getUserinfo().getId());
			ticketchange.setCreatetime(now);
			List<TicketPrintInfo> ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			ticketchange.setNewdepartdate(ticketPrintInfos.get(i).getDepartdate());
			ticketchange.setNewscheduleid(ticketPrintInfos.get(i).getScheduleid());
			ticketchange.setNewseatno(ticketPrintInfos.get(i).getSeatno());
			ticketchange.setNewticketno(ticketPrintInfos.get(i).getTicketno());
			ticketchange.setNewticketsellid(ticketPrintInfos.get(i).getId());
			//将改签票号插入改签表中
			Billtype bt = billtypeService.findByCode("Ticket");
			String schangeno = Long.valueOf(ticketPrintInfos.get(i).getTicketno())+1+"";
			String cuticketno = schangeno;
			if (schangeno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(schangeno,
						(int) bt.getTicketnolength(), "0");
			}			
			ticketchange.setChangeticketno(cuticketno);
			ticketchange.setOlddepartdate(ticketsellagent.getDepartdate());
//			ticketchange.setOldscheduleid(ticketsell.getScheduleid());
			ticketchange.setOldscheduleid(0L);//****************************无法获得原班次id****************************
			ticketchange.setOldseatno(ticketsellagent.getSeatno());
			ticketchange.setOldticketno(ticketsellagent.getTicketno());
			ticketchange.setOldticketsellid(ticketsellagent.getId());
			ticketchange.setRemarks(null);
			ticketchange.setTicketoutletsid(order.getTicketoutletsid());
			ticketchange.setUpdateby(global.getUserinfo().getId());
			ticketchange.setUpdatetime(now);
			propertyFiltersinsu.clear();
			propertyFiltersinsu.add(new PropertyFilter("EQL_t!sellid", ticketsellagent.getId()));
			Insurance ins = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,propertyFiltersinsu);
//			if(null != ins){
			if(null != ins && !("10".equals(ins.getSellway()) || "7".equals(ins.getSellway()))){//自助机的和网售的保险不改签到新票上
				ins.setSellid(ticketchange.getNewticketsellid());
				dao.merge(ins);
			}
			
			ticketreturnService.changeOtherSellLocalTickets(ticketreturns, ticketchange, global, null, null, null, null, true);
			
			dao.merge(ticketchange);
			i++;
		}
		
		param1074 = parameterService.findParamValue(ParamterConst.Param_1074, global.getOrganization().getId());//参数1074，免票儿童是否单独打印车票，0不打印，1打印
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074) && childprintnum > 0){
			long childTicketno = Long.valueOf(childchangedetail.getTicketendno()) - childprintnum + 1;//儿童票(第一张)票号
			int billtypeLength = (int) billtypeService.findByCode("Ticket").getTicketnolength();
			String ticketno = "";
			TicketDao ticketdao = new TicketDao();
			List<TicketPrintInfo> printinfos = (List<TicketPrintInfo>) methodResult.getObject();//全票打印信息
			List<PropertyFilter> filter = new ArrayList<PropertyFilter>();
			
			int newChildIndex = 0;//取新生成的儿童票List元素
			for (int j = 0; j < ticketIdToBeChanges.size(); j++) {
				Long ticketIdToBeChange = ticketIdToBeChanges.get(j);
				boolean isNeedNewChildTicket = childinfoMap.get(ticketIdToBeChange);//是否需要新生成儿童票记录
				if(isNeedNewChildTicket){
					//需要新生成售票记录
					TicketPrintInfo newchildPrintInfo = newChildList.get(newChildIndex);
					newChildIndex++;
					
					TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) printinfos.get(j).clone();//车票打印信息
					
					filter.clear();
					filter.add(new PropertyFilter("EQL_t!oldticketsellid", ticketPrintInfo.getId()));
					Ticketchange oldticket = (Ticketchange) dao.uniqueResult(LockModeType.PESSIMISTIC_READ, Ticketchange.class, filter);//通过改签表得到改签记录
					Ticketsell quanpiao =  ticketdao.findNewTicketByOldTicket(oldticket.getNewticketsellid());//新售出的全票
					Ticketsell ts = (Ticketsell) quanpiao.clone();//clone得到儿童票
					
					if(!"0".equals(quanpiao.getPaymethod())) {
						childchangedetail.setNoncashnum(childchangedetail.getNoncashnum()+1);
					}
//					childchangedetail.setChangenum(childchangedetail.getChangenum()+1);
					childchangedetail.setSellnum(childchangedetail.getSellnum()+1);
					dao.merge(childchangedetail);
					
					ts.setId(0L);
					ticketno = (StringUtils.strPad(Long.valueOf(childTicketno).toString(), billtypeLength, "0"));
					childTicketno++;
					ts.setTicketno(ticketno);
					ts.setTickettype("E");
					ts.setSeatno(quanpiao.getSeatno());
					ts.setFullprice(java.math.BigDecimal.ZERO);
					ts.setPrice(java.math.BigDecimal.ZERO);
					ts.setMoreprice(java.math.BigDecimal.ZERO);
					ts.setServicefee(java.math.BigDecimal.ZERO);
					ts.setToplimitprice(java.math.BigDecimal.ZERO);
					ts.setFueladditionfee(java.math.BigDecimal.ZERO);
					ts.setStationservicefee(java.math.BigDecimal.ZERO);
					ts.setComputefee(java.math.BigDecimal.ZERO);
					ts.setCoolairfee(java.math.BigDecimal.ZERO);
					ts.setAdditionfee(java.math.BigDecimal.ZERO);
					ts.setWaterfee(java.math.BigDecimal.ZERO);
//					ts.setInsurefee(java.math.BigDecimal.ZERO);//改签儿童不售保险
					ts.setInsurefee(newchildPrintInfo.getInsurefee());
					ts.setOtherfee(java.math.BigDecimal.ZERO);
					ts.setCarrychildnum(Byte.parseByte("0"));
					Customer customer = (Customer) dao.get(Customer.class, childCustomerMap.get(ticketIdToBeChange));
					if(customer!=null)
					{
						ts.setCustomer(customer);
						ts.setCustomername(customer.getName());
						ts.setCertificateno(customer.getCertificateno());
						Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
						ts.setCertificatetypename(certificatetype.getValue());
						ticketPrintInfo.setCertificateno(customer.getCertificateno());
						ticketPrintInfo.setCustomername(customer.getName());
					}
					
					ts = (Ticketsell) dao.merge(ts);
					dao.getEntityManager().flush();
					
					//生成主票-儿童票记录
					CarryChild carryChild = new CarryChild();
					carryChild.setQticketid(quanpiao.getId());
					carryChild.setChildticketid(ts.getId());
					carryChild.setCreatetime(ts.getCreatetime());
					carryChild.setCreateby(ts.getCreateby());
					carryChild.setUpdatetime(ts.getUpdatetime());
					carryChild.setUpdateby(ts.getUpdateby());
					carryChild.setRemark(carryChild.getRemark() + ",改签新售出儿童票" + DateUtils.formatDatetime(carryChild.getCreatetime()));
					carryChild = (CarryChild) dao.merge(carryChild);
					
					play.Logger.info("改签新售出儿童票并打印儿童票，主票票号="
							+ quanpiao.getTicketno() + ", 携童票票号="
							+ ts.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId());
					ticketPrintInfo.setId(ts.getId());//儿童票id
					ticketPrintInfo.setCarrychildnum(Byte.parseByte("0"));
					ticketPrintInfo.setPrice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFullprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setMoreprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setServicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setToplimitprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFueladditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setStationservicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setComputefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setCoolairfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setAdditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setWaterfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setInsurefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setOtherfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setDepartdate(ts.getDepartdate());
					ticketPrintInfo.setDeparttime(ts.getDeparttime());
					ticketPrintInfo.setTicketno(ts.getTicketno());
					ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
					ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
					ticketPrintInfo.setTickettype("E");
					ticketPrintInfo.setSeatno(ts.getSeatno());
					ticketPrintInfo.setSeatnostr(Short.toString(ts.getSeatno()));
					order.getTickets().add(ticketPrintInfo);
					
				}else{
					//不需要新生成售票记录，则修改原儿童票记录
					TicketPrintInfo ticketPrintInfo = (TicketPrintInfo) printinfos.get(j).clone();//车票打印信息
					
					Ticketsell newquanpiao =  ticketdao.findNewTicketByOldTicket(ticketIdToBeChange);//新售出的全票
					newquanpiao.setCarrychildnum(Byte.parseByte("1"));//修改携童数为1
					ticketdao.getEntityManager().merge(newquanpiao);
					
					Ticketsell oldchild =  ticketdao.findChildByQticket(ticketIdToBeChange);//过主票sellid查到老的儿童票记录
					oldchild.setTicketstatus("1");//1已退
					oldchild.setUpdateby(newquanpiao.getUpdateby());
					oldchild.setUpdatetime(newquanpiao.getUpdatetime());
					ticketdao.merge(oldchild);
					
					if(!"0".equals(oldchild.getPaymethod())) {
						childchangedetail.setNoncashnum(childchangedetail.getNoncashnum()+1);
					}
					childchangedetail.setChangenum(childchangedetail.getChangenum()+1);
					childchangedetail.setSellnum(childchangedetail.getSellnum()+1);
//					childchangedetail.setReturnnum(childchangedetail.getReturnnum()+1);
					dao.merge(childchangedetail);
					
					Ticketsell newchild = (Ticketsell) newquanpiao.clone();
					newchild.setId(0L);
					ticketno = (StringUtils.strPad(Long.valueOf(childTicketno).toString(), billtypeLength, "0"));
					childTicketno++;
					newchild.setTicketno(ticketno);
					newchild.setTickettype("E");
					newchild.setSeatno(newquanpiao.getSeatno());
					newchild.setFullprice(oldchild.getFullprice());
					newchild.setPrice(oldchild.getPrice());
					newchild.setMoreprice(oldchild.getMoreprice());
					newchild.setServicefee(oldchild.getServicefee());
					newchild.setToplimitprice(oldchild.getToplimitprice());
					newchild.setFueladditionfee(oldchild.getFueladditionfee());
					newchild.setStationservicefee(oldchild.getStationservicefee());
					newchild.setComputefee(oldchild.getComputefee());
					newchild.setCoolairfee(oldchild.getCoolairfee());
					newchild.setAdditionfee(oldchild.getAdditionfee());
					newchild.setWaterfee(oldchild.getWaterfee());
					newchild.setInsurefee(oldchild.getInsurefee());
					newchild.setOtherfee(oldchild.getOtherfee());
					newchild.setCarrychildnum(Byte.parseByte("0"));
//					if(childCustomerMap.get(ticketIdToBeChange) != null){
						Customer customer = (Customer) dao.get(Customer.class, oldchild.getCustomer().getId());
						if(customer!=null)
						{
							newchild.setCustomer(customer);
							newchild.setCustomername(customer.getName());
							newchild.setCertificateno(customer.getCertificateno());
							Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
							newchild.setCertificatetypename(certificatetype.getValue());
							ticketPrintInfo.setCertificateno(customer.getCertificateno());
							ticketPrintInfo.setCustomername(customer.getName());
						}
//					}
					
					newchild = (Ticketsell) dao.merge(newchild);
					
					//修改保险记录
					filter.clear();
					filter.add(new PropertyFilter("EQL_t!sellid", oldchild.getId()));
					Insurance insurance = (Insurance) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Insurance.class,filter);
//					if(insurance != null){
					if(null != insurance && !("10".equals(insurance.getSellway()) || "7".equals(insurance.getSellway()))){//自助机的和网售的保险不改签到新票上
						insurance.setSellid(newchild.getId());
						insurance.setUpdateby(insurance.getUpdateby());
						insurance.setUpdatetime(newchild.getUpdatetime());
						ticketdao.merge(insurance);
					}
					
//					Ticketreturn ticketreturn = new Ticketreturn();
//					ticketreturn.setBilltype(null);
//					ticketreturn.setCharges(new BigDecimal(0));
////					if(insurance!=null){
//					if(null != insurance && !("10".equals(insurance.getSellway()) || "7".equals(insurance.getSellway()))){//自助机的和网售的保险不改签到新票上
//						ticketreturn.setIsreturninsure(true);
//						ticketreturn.setReturninsureid(insurance.getId());
//					}
//					else{
//						ticketreturn.setIsreturninsure(false);
//						ticketreturn.setReturninsureid(null);
//					}
//					ticketreturn.setIsselfschedule(true);
//					ticketreturn.setRemarks("改签退票");
//					ticketreturn.setReturnamount(java.math.BigDecimal.ZERO);
//					ticketreturn.setReturnvoucherno(null);
//					ticketreturn.setReturnway("3");//改签自动退
//					ticketreturn.setSellid(oldchild.getId());
//					ticketreturn.setTicketoutletsid(order.getTicketoutletsid());
//					ticketreturn.setTicketprice(java.math.BigDecimal.ZERO);
//					ticketreturn.setIsreturnticket(true);
//					ticketreturn.setReturnby(newchild.getCreateby());
//					ticketreturn.setReturntime(newchild.getCreatetime());
//					ticketreturn.setReturnip(global.getIpAddress());
//					ticketreturn.setCreateby(newchild.getCreateby());
//					ticketreturn.setCreatetime(newchild.getCreatetime());
//					ticketreturn.setUpdateby(newchild.getUpdateby());
//					ticketreturn.setUpdatetime(newchild.getUpdatetime());
//					ticketdao.merge(ticketreturn);
					
					//生成主票-儿童票记录
					CarryChild carryChild = new CarryChild();
					carryChild.setQticketid(newquanpiao.getId());
					carryChild.setChildticketid(newchild.getId());
					carryChild.setCreatetime(newchild.getCreatetime());
					carryChild.setCreateby(newchild.getCreateby());
					carryChild.setUpdatetime(newchild.getUpdatetime());
					carryChild.setUpdateby(newchild.getUpdateby());
					carryChild.setRemark("改签儿童票,原儿童票为" + oldchild.getTicketno() + ", " + DateUtils.formatDatetime(carryChild.getCreatetime()));
					carryChild = (CarryChild) dao.merge(carryChild);
					
					play.Logger.info("改签儿童票并打印儿童票，主票票号="
							+ newquanpiao.getTicketno() + ", 携童票票号="
							+ newchild.getTicketno() + ", 主票-携童票关联表的id=" + carryChild.getId() + ",原儿童票号=" + oldchild.getTicketno());
					ticketPrintInfo.setId(newchild.getId());//儿童票id
					ticketPrintInfo.setCarrychildnum(Byte.parseByte("0"));
					ticketPrintInfo.setPrice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFullprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setMoreprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setServicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setToplimitprice(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setFueladditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setStationservicefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setComputefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setCoolairfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setAdditionfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setWaterfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setInsurefee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setOtherfee(java.math.BigDecimal.ZERO);
					ticketPrintInfo.setDepartdate(newchild.getDepartdate());
					ticketPrintInfo.setDeparttime(newchild.getDeparttime());
					ticketPrintInfo.setTicketno(newchild.getTicketno());
					ticketPrintInfo.setIsaudited(true);//儿童票是否打印座位号
					ticketPrintInfo.setIsauditpass(true);//儿童票是否打印发车时间
					ticketPrintInfo.setTickettype("E");
					ticketPrintInfo.setSeatno(newchild.getSeatno());
					ticketPrintInfo.setSeatnostr(Short.toString(newchild.getSeatno()));
					order.getTickets().add(ticketPrintInfo);
					
					//生成改签记录
					Ticketchange ticketchange = new Ticketchange();
					ticketchange.setChangeby(global.getUserinfo().getId());
					ticketchange.setChangeip(global.getIpAddress());
					ticketchange.setChangetime(now);
					ticketchange.setChangeby(global.getUserinfo().getId());
					ticketchange.setCreateby(global.getUserinfo().getId());
					ticketchange.setCreatetime(now);
					ticketchange.setNewdepartdate(newchild.getDepartdate());
					ticketchange.setNewscheduleid(newchild.getScheduleid());
					ticketchange.setNewseatno(newchild.getSeatno());
					ticketchange.setNewticketno(newchild.getTicketno());
					ticketchange.setNewticketsellid(newchild.getId());
					ticketchange.setChangeticketno("--");//改签凭证号
					ticketchange.setOlddepartdate(oldchild.getDepartdate());
					ticketchange.setOldscheduleid(oldchild.getScheduleid());
					ticketchange.setOldseatno(oldchild.getSeatno());
					ticketchange.setOldticketno(oldchild.getTicketno());
					ticketchange.setOldticketsellid(oldchild.getId());
					ticketchange.setRemarks("改签儿童票，原票号为：" + oldchild.getTicketno());
					ticketchange.setTicketoutletsid(order.getTicketoutletsid());
					ticketchange.setUpdateby(global.getUserinfo().getId());
					ticketchange.setUpdatetime(now);
					ticketdao.merge(ticketchange);
				}
			}
			
			childTicketno++;//票号+1
		}
		
		return methodResult;
	}

	public void setTicketreturnService(TicketreturnService ticketreturnService) {
		this.ticketreturnService = ticketreturnService;
	}

	public TicketreturnService getTicketreturnService() {
		return ticketreturnService;
	}

	public BalancedeductService getBalancedeductService() {
		return balancedeductService;
	}

	public void setBalancedeductService(BalancedeductService balancedeductService) {
		this.balancedeductService = balancedeductService;
	}

	@Override
	public Ticketprice findTicketPrices(long ticketpriceid,long ticketoutletsid) {
		Ticketprice ticketprice = (Ticketprice) dao.get(Ticketprice.class, ticketpriceid);
		dao.getEntityManager().detach(ticketprice);
		//参数1090: 是否开启票价差额功能: 0否,1是;控制范围包含售票点票价差额,线路售票点票价差额,售票点票种差额
		String p1090 = getParameterService().findParamValue(ParamterConst.Param_1090, ticketprice.getOrgid());
		String pricerule = parameterService.findParamValue(ParamterConst.Param_1042, ticketprice.getOrgid());
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(p1090)) {
			// 处理售票点价差
			BigDecimal difprice = new BigDecimal(0);
			// 处理售票点价差
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", ticketprice.getDepartstationid()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", ticketprice.getReachstationid()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", ticketprice.getScheduleid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketprice.getSeattype()));
			propertyFilters.add(new PropertyFilter("EQL_t!vehicletypeid",
					ticketprice.getScheduleplan().getSchedulevehiclepeopleplanlist().get(0).getPlanvehicletypeid()));
			propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid", ticketoutletsid));
			propertyFilters.add(new PropertyFilter("LED_t!starttime", ticketprice.getDepartdate()));
			propertyFilters.add(new PropertyFilter("GED_t!endtime", ticketprice.getDepartdate()));
			List<Ticketoutletsprice> ttflist = dao.find(Ticketoutletsprice.class, propertyFilters);
			int interday = -1;
			Ticketoutletsprice tsp = null;
			Ticketoutletsrouteprice trp = null;
			List<Ticketoutletsrouteprice> trplist = null;
			for (Ticketoutletsprice ttf : ttflist) {
				int curinterday = 0;
				int curinterday1 = DateUtils.compare(ticketprice.getDepartdate(), ttf.getStarttime());
				int curinterday2 = DateUtils.compare(ticketprice.getDepartdate(), ttf.getStarttime());
				if (curinterday1 < curinterday2) {
					curinterday = curinterday1;
				} else {
					curinterday = curinterday2;
				}
				if (interday == -1) {
					interday = curinterday;
					tsp = ttf;
				} else {
					if (curinterday < interday) {
						tsp = ttf;
					}
				}
			}
			if (tsp != null) {
				difprice = tsp.getDifprice();
				// 0：表示半票票价取全票一半，1：表示取执行票价中的半票
				gethalfprie = parameterService.findParamValue(ParamterConst.Param_1058,
						CurrentUtil.getGlobal().getOrganization().getId());
				if (ParamterConst.COMMON_FLAG.FALG_NO.equals(gethalfprie)) {// 0：表示半票票价取全票一半
					if (CurrentUtil.getGlobal().getTicketoutlets().getType().equals("0")) {
						ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule,
								ticketprice.getFullprice().subtract(difprice).divide(new BigDecimal(2))));
					} else {
						ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule,
								ticketprice.getFullprice().divide(new BigDecimal(2))));
					}
				} else if (ParamterConst.COMMON_FLAG.FALG_YES.equals(gethalfprie)) { // 1：表示取执行票价中的半票
					ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule,
							ticketprice.getHalfprice().subtract(difprice)));
				}
				ticketprice.setFullprice(ticketprice.getFullprice().subtract(difprice));
				ticketprice.setStudentprice(ticketprice.getStudentprice().subtract(difprice));
			} else {
				// 处理售票点价差
				propertyFilters = new ArrayList<PropertyFilter>();
				propertyFilters.add(new PropertyFilter("EQL_t!routestopid", ticketprice.getReachstationid()));
				propertyFilters.add(new PropertyFilter("EQL_t!ticketoutletsid", ticketoutletsid));
				propertyFilters.add(new PropertyFilter("LED_t!startdate", ticketprice.getDepartdate()));
				propertyFilters.add(new PropertyFilter("GED_t!enddate", ticketprice.getDepartdate()));
				// propertyFilters.add(new PropertyFilter("EQL_t!routeid",
				// routeid));
				trplist = (List<Ticketoutletsrouteprice>) dao.find(Ticketoutletsrouteprice.class, propertyFilters);
				if (trplist != null) {
					for (Ticketoutletsrouteprice ttf : trplist) {
						int curinterday = 0;
						int curinterday1 = DateUtils.compare(ticketprice.getDepartdate(), ttf.getStartdate());
						int curinterday2 = DateUtils.compare(ticketprice.getDepartdate(), ttf.getEnddate());
						if (curinterday1 < curinterday2) {
							curinterday = curinterday1;
						} else {
							curinterday = curinterday2;
						}
						if (interday == -1) {
							interday = curinterday;
							trp = ttf;
						} else {
							if (curinterday < interday) {
								trp = ttf;
							}
						}
					}
				}
				if (trp != null) {
					difprice = trp.getPrice();
					// 0：表示半票票价取全票一半，1：表示取执行票价中的半票
					gethalfprie = parameterService.findParamValue(ParamterConst.Param_1058,
							CurrentUtil.getGlobal().getOrganization().getId());
					if (ParamterConst.COMMON_FLAG.FALG_NO.equals(gethalfprie)) {// 0：表示半票票价取全票一半
						if (CurrentUtil.getGlobal().getTicketoutlets().getType().equals("0")) {
							ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule,
									ticketprice.getFullprice().subtract(difprice).divide(new BigDecimal(2))));
						} else {
							ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule,
									ticketprice.getFullprice().divide(new BigDecimal(2))));
						}
					} else if (ParamterConst.COMMON_FLAG.FALG_YES.equals(gethalfprie)) { // 1：表示取执行票价中的半票
						ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule,
								ticketprice.getHalfprice().subtract(difprice)));
					}
					ticketprice.setFullprice(ticketprice.getFullprice().subtract(difprice));
					ticketprice.setStudentprice(ticketprice.getStudentprice().subtract(difprice));
					ticketprice.setDiscountprice(ticketprice.getDiscountprice().subtract(difprice));
					ticketprice.setRoundprice(ticketprice.getRoundprice().subtract(difprice));
					ticketprice.setConnectprice(ticketprice.getConnectprice().subtract(difprice));
				}

				// 售票点票种差额控制======================
				Ticketoutletstypeprice typ = null;
				if (tsp == null && trp == null && ttflist.isEmpty()) {
					List<Ticketoutletstypeprice> typlist = findTicketoutletstypeprice(ticketprice.getDepartdate(),
							ticketoutletsid, ticketprice.getScheduleid());
					typ = typlist != null && typlist.size() > 0 ? typlist.get(0) : null;
				}
				if (typ != null) {
					try {
						ScriptEngineManager manager = new ScriptEngineManager();
						final ScriptEngine engine = manager.getEngineByName("js");
						if (engine == null) {
							play.Logger.info("No engine for JavaScript");
						}
						if (typ.getFullpriceformula().indexOf("Q") < 0 || typ.getHalfpriceformula().indexOf("Q") < 0
								|| typ.getStudentpriceformula().indexOf("Q") < 0) {
							play.Logger.error("发车日期" + ticketprice.getDepartdate() + ",班次ID:"
									+ ticketprice.getScheduleid() + ",售票点ID:" + ticketoutletsid + "的票种公式设置有误,请检查!");
						}
						String fullprice_formual = typ.getFullpriceformula().replaceAll("Q",
								ticketprice.getFullprice().toString());
						String halfprice_formual = typ.getHalfpriceformula().replaceAll("Q",
								ticketprice.getFullprice().toString());
						String studentprice_formual = typ.getStudentpriceformula().replaceAll("Q",
								ticketprice.getFullprice().toString());
						BigDecimal fullprice_temp = new BigDecimal(engine.eval(fullprice_formual).toString());
						BigDecimal halfprice_temp = new BigDecimal(engine.eval(halfprice_formual).toString());
						BigDecimal studentprice_temp = new BigDecimal(engine.eval(studentprice_formual).toString());
						ticketprice.setFullprice(routepriceService.mathPriceByRule(pricerule, fullprice_temp));
						ticketprice.setHalfprice(routepriceService.mathPriceByRule(pricerule, halfprice_temp));
						ticketprice.setStudentprice(routepriceService.mathPriceByRule(pricerule, studentprice_temp));
					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				// ==============================
			}

			if (ticketprice.getFullprice().floatValue() < 0) {
				ticketprice.setFullprice(new BigDecimal(0));
			}
			if (ticketprice.getHalfprice().floatValue() < 0) {
				ticketprice.setHalfprice(new BigDecimal(0));
			}
			if (ticketprice.getStudentprice().floatValue() < 0) {
				ticketprice.setStudentprice(new BigDecimal(0));
			}
			if (ticketprice.getDiscountprice().floatValue()<0){
				ticketprice.setDiscountprice(new BigDecimal(0));
			}
			if (ticketprice.getRoundprice().floatValue()<0){
				ticketprice.setRoundprice(new BigDecimal(0));
			}
			if (ticketprice.getConnectprice().floatValue()<0){
				ticketprice.setConnectprice(new BigDecimal(0));
			}
		}
		return ticketprice;
	}

	@Override
	public TicketPrintInfo getTicketPrintInfoAndChangeTicketNo(
			long ticketsellid, String curTicketNo,Global global) throws ServiceException {
		Date now = new Date();
		//只有售票人或者换票人才允许重打
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!id", ticketsellid));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
		String oldticketno = ticketsell.getTicketno();
		String ticketstatus = ticketsell.getTicketstatus();
		// 正常、退票、废票
		if ("1".equals(ticketstatus)) {
			// 该车票已退
			throw new ServiceException(ticketsell.getTicketno(),"0121");
		} else if ("2".equals(ticketstatus)) {
			// 该车票已废
			throw new ServiceException(ticketsell.getTicketno(), "0122");
		} else if ("4".equals(ticketstatus)) {
			// 该车票挂失
			throw new ServiceException(ticketsell.getTicketno(), "0471");
		}
		if (ticketsell.getIschecked()) {
			// 该车票已检！
			throw new ServiceException("0117");
		}
//		//判断售票人
//		if(ticketsell.getSellby()!=global.getUserinfo().getId()){
//			if(!ticketsell.getSellway().equals("7")){
//				//换票号重打车票不允许重打他人售出的车票
//				throw new ServiceException("0344");
//			}
//		}
		if(ticketsell.getSellway().equals("7")){
			//判断是否是电子票
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsellid));
			Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
			if(ticketsellother==null){
				//换票号重打车票不允许重打他人售出的车票
				throw new ServiceException("0344");
			}
			/*else if(!ticketsellother.getIstaked()){
				//该电子票还没有取票，不允许重打车票
				throw new ServiceException("0346");
			}
			else if (ticketsellother.getPrintby()!=global.getUserinfo().getId()){
				//电子票换票号重打车票不允许重打他人取出的电子票
				throw new ServiceException("0350");
			}*/
		}
		//校验当前票号
		Billinuse billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",curTicketNo,1);
		Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
		Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid()); 
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(global.getUserinfo().getId(), curTicketNo);
		if("0".equals(ticketturnoverdetail.getTicketstartno())){
			ticketturnoverdetail.setTicketstartno(curTicketNo);
		}
		
		Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
		Billdamaged billdamaged_returntripticket = null;
		if(reachstation.getIsroundtrip()){
			ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(curTicketNo+1).toString(),curTicketNo.length(), "0"));

			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule", true));
			propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
			Returntripticket returntripticket = (Returntripticket) dao.uniqueResult(Returntripticket.class,propertyFilters);
			Ticketreprint tp=new Ticketreprint();
			tp.setChangeby(global.getUserinfo().getId());
			tp.setChangetime(now);
			tp.setIsselfschedule(true);
			tp.setCreateby(global.getUserinfo().getId());
			tp.setCreatetime(now);
			tp.setDepartdate(ticketsell.getDepartdate());
			tp.setDepartstationid(ticketsell.getDepartstationid());
			tp.setDeparttime(ticketsell.getDeparttime());
			tp.setNewbatchno(billinventory.getBatchno());
			tp.setNewticketno(ticketturnoverdetail.getTicketendno());
			tp.setOldticketno(returntripticket.getTicketno());
			tp.setOldbatchno(returntripticket.getBatchno());
			tp.setPrice(ticketsell.getPrice());
			tp.setReachstationid(ticketsell.getReachstationid());
			tp.setSchedulecode(schedule.getCode());
			tp.setSeatno(ticketsell.getSeatno());
			tp.setSellby(ticketsell.getSellby());
			tp.setSellid(ticketsell.getId());
			tp.setSellorgid(ticketsell.getOrgid());
			tp.setSelltime(ticketsell.getSelltime());
			tp.setUpdateby(global.getUserinfo().getId());
			tp.setUpdatetime(now);
			dao.merge(tp);
			//原票号生成坏票登记记录
			billdamaged_returntripticket = new Billdamaged();
			billdamaged_returntripticket.setAmount(1);
			billdamaged_returntripticket.setBillinuseid(billinuse.getId());
			billdamaged_returntripticket.setBilltypeid(billinuse.getBilltypeid());
			billdamaged_returntripticket.setCreateby(global.getUserinfo().getId());
			billdamaged_returntripticket.setCreatetime(now);
			billdamaged_returntripticket.setDamageddscribe("换票号重打车票做废原返程票号！");
			billdamaged_returntripticket.setEndno(new Long(returntripticket.getTicketno()));
			billdamaged_returntripticket.setRecordby(global.getUserinfo().getId());
			billdamaged_returntripticket.setRecordip(global.getIpAddress());
			billdamaged_returntripticket.setRecordtime(billdamaged_returntripticket.getCreatetime());
			billdamaged_returntripticket.setStartno(new Long(returntripticket.getTicketno()));
			billdamaged_returntripticket.setTicketoutletsid(global.getTicketoutlets().getId());
			billdamaged_returntripticket.setUpdateby(global.getUserinfo().getId());
			billdamaged_returntripticket.setUpdatetime(now);
			billdamaged_returntripticket.setTurnoverdetailid(ticketturnoverdetail.getId());
		}
		else{
			ticketturnoverdetail.setTicketendno(curTicketNo);
		}

		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		ticketturnoverdetail.setBilldamagednum(ticketturnoverdetail.getBilldamagednum()+1);
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		if(billdamaged_returntripticket!=null){
			dao.merge(billdamaged_returntripticket);
		}
		Ticketreprint tp=new Ticketreprint();
		tp.setChangeby(global.getUserinfo().getId());
		tp.setChangetime(now);
		tp.setIsselfschedule(true);
		tp.setCreateby(global.getUserinfo().getId());
		tp.setCreatetime(now);
		tp.setDepartdate(ticketsell.getDepartdate());
		tp.setDepartstationid(ticketsell.getDepartstationid());
		tp.setDeparttime(ticketsell.getDeparttime());
		tp.setNewbatchno(billinventory.getBatchno());
		tp.setNewticketno(curTicketNo);
		tp.setOldticketno(ticketsell.getTicketno());
		tp.setOldbatchno(ticketsell.getBatchno());
		tp.setPrice(ticketsell.getPrice());
		tp.setReachstationid(ticketsell.getReachstationid());
		tp.setSchedulecode(schedule.getCode());
		tp.setSeatno(ticketsell.getSeatno());
		tp.setSellby(ticketsell.getSellby());
		tp.setSellid(ticketsell.getId());
		tp.setSellorgid(ticketsell.getOrgid());
		tp.setSelltime(ticketsell.getSelltime());
		tp.setUpdateby(global.getUserinfo().getId());
		tp.setUpdatetime(now);
		dao.merge(tp);
		//原售票号生成坏票登记记录
		Billdamaged billdamaged = new Billdamaged();
		billdamaged.setAmount(1);
		billdamaged.setBillinuseid(billinuse.getId());
		billdamaged.setBilltypeid(billinuse.getBilltypeid());
		billdamaged.setCreateby(global.getUserinfo().getId());
		billdamaged.setCreatetime(now);
		billdamaged.setDamageddscribe("换票号重打车票做废原票号！");
		billdamaged.setEndno(new Long(ticketsell.getTicketno()));
		billdamaged.setRecordby(global.getUserinfo().getId());
		billdamaged.setRecordip(global.getIpAddress());
		billdamaged.setRecordtime(billdamaged.getCreatetime());
		billdamaged.setStartno(new Long(ticketsell.getTicketno()));
		billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
		billdamaged.setUpdateby(global.getUserinfo().getId());
		billdamaged.setUpdatetime(now);
		billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
		dao.merge(billdamaged);
		//修改票号
		if("T".equals(ticketsell.getTickettype())){
			List<Ticketsell> tuan_ticketsell =findTuanTicketsell(oldticketno, ticketsell.getDepartdate(),ticketsell.getScheduleplanid());
			for (Ticketsell ts : tuan_ticketsell) {
				String tuan_ticketno = ts.getTicketno();
				tuan_ticketno =tuan_ticketno.replace(oldticketno,curTicketNo);
				ts.setTicketno(tuan_ticketno);
				ts.setBatchno(billinventory.getBatchno());
				ts.setUpdateby(global.getUserinfo().getId());
				ts.setUpdatetime(now);
				dao.merge(ts);
			}
		}else{
			ticketsell.setTicketno(curTicketNo);
			ticketsell.setBatchno(billinventory.getBatchno());
			ticketsell.setUpdateby(global.getUserinfo().getId());
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);
		}
		
		//返回打印信息
//		Ticketsell ts = (Ticketsell) dao.get(Ticketsell.class,ticketsellid);
//		propertyFilters.clear();
//		if(ts.getTicketno().length()!=8 & ts.getTicketno().length() !=12) {
//			propertyFilters.add(new PropertyFilter("EQL_t!id", ts.getId()));
//		}else {
//			propertyFilters.add(new PropertyFilter("LIKELS_t!ticketno", oldticketno));
//		}
//		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ts.getScheduleplanid()));
//		propertyFilters.add(new PropertyFilter("EQD_t!departdate", ts.getDepartdate()));
//		propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
//		return getTicketPrintInfo(propertyFilters,oldticketno).get(0);
		return null;
	}

	
	
	@Override
	public List<Map<String, Object>> qryseatreserve(
			List<PropertyFilter> propertyFilterList,long orgid) {
		String certificateno = "";//证件号
		for(PropertyFilter propertyFilter: propertyFilterList){
			if("c!certificateno".equals(propertyFilter.getPropertyFullName())){
				certificateno = (String) propertyFilter.getMatchValue();
				propertyFilterList.remove(propertyFilter);//从propertyFilterList移除该参数，在后面手动添加证件号查询条件(为解决证件号不区分大小写字母问题)
				break;
			}
		}
		//增加参数控制订票销售是否自动选中记录
		String isselect=parameterService.findParamValue(ParamterConst.Param_1307, orgid);
		StringBuffer sql = new StringBuffer()
		
				.append("select t.scheduleplanid,t.id,t.scheduleid,t.orgid,t.departstationid,t.reachstationid")
				.append(" ,t.departdate, trim(t.departtime), ")
				.append(" tp.fullprice-nvl(ttp.difprice, 0) as fullprice, tp.fullprice-nvl(ttp.difprice, 0) as price,round(((tp.fullprice - nvl(ttp.difprice, 0)) / 2), 0) as halfprice,tp.studentprice-nvl(ttp.difprice, 0) as studentprice ")
				.append(" ,t.seatno, t.serviceprice, t.reservetime,t.sellstate,")
				.append(" t.createtime, t.updatetime, sc.code as schedulecode,sc.remarks as scheduleremarks, o.name as orgname, t.sellstate,")
				.append(" sd.name as departstationname, sr.name as reachstationname,'' as reachstationsecondname,sr.isroundtrip, ti.name as ticketoutletname, ")
				.append(" u.name as reservename, ro.name as routename,ro.returntripvaliddays, ")
				.append(" t.tickettype, c.name as customername, c.certificatetype, c.certificateno, c.familyphone,") //tt.name as tickettypename,
				.append(" c.mobilephone, t.customerid, t.autocanceltime, t.canceltime, t.isautocancel ")
				.append(" ,sts.name as startstationname, ste.name as endstationname")
				.append(" ,sp.workways,sp.islinework,sp.isovertime")
				.append(" ,ss.seattype,tp.distance,tp.toplimitprice,tp.fueladditionfee,tp.stationservicefee")
				.append(" ,case t.sellstate when 'R' then (case "+isselect+" when 0 then 0 else 1 end ) else null end as isselect")
//				.append(" ,0 as istakekid,1 as carrychildnum")
				.append(" ,case t.carrychildnum when 0 then 0 else 1 end as istakekid,t.carrychildnum")
				.append(" ,ssu.ticketentrance,ssu.buspark")
				.append(" ,vtsvpp.type as planvehicletype,vtsvpp.grade as planvehiclegrade,vtsvpp.customname as planvehicletypecustomname,vtsvpp.id as planvheicletypeid,")
				.append(" vsvpp.vehicleno as planvehicleno,vsvpp.id as planvehicleid,usvpp.name as planunitname,usvpp.id as planunitid,")
				.append(" concat(vbmsvpp.brandname,vbmsvpp.modelcode) as planbrandmodel,vbmsvpp.id as planbrandmodelid,")
				.append(" nvl((select ts.printname from Ticketentrance ts where ts.name = ssu.ticketentrance")
				.append(" and ts.orgid = ssu.orgid and rownum <= 1),ssu.ticketentrance) ticketentrancename")
				.append(" , 0 as isnetseat, sc.synccode as schedulesynccode, sd.code as departstationcode, sr.code as reachstationcode ")
				.append(" , ro.isrealnameticket as isrealnameticket,tp.discountprice,tp.roundprice,tp.connectprice  from seatreserve t ")
				.append("	   left join station sd on t.departstationid=sd.id ")
				.append("      left join station sr on t.reachstationid=sr.id ")
				//.append("      left join tickettype tt on t.tickettype=tt.code ") 
				.append("      left join customer c on t.customerid=c.id ")
				.append("      left join Scheduleseats ss on ss.scheduleplanid=t.scheduleplanid and ss.departdate=t.departdate and ss.seatno=t.seatno")
				.append("      left join Ticketprice tp on tp.scheduleplanid=t.scheduleplanid and tp.departdate=t.departdate and tp.departstationid=t.departstationid and tp.reachstationid=t.reachstationid and tp.seattype=ss.seattype")
				//新增售票点票价差额时间设置 
				.append("      left join Ticketoutletsprice ttp on ttp.departstationid=tp.departstationid and ttp.reachstationid=tp.reachstationid")
				.append("      and ttp.scheduleid=tp.scheduleid and ttp.seattype=tp.seattype  ")
				.append(" 	and ((tp.departdate >= ttp.starttime and tp.departdate <= ttp.endtime) ) ")
				.append("      and ttp.ticketoutletsid= t.ticketoutletsid")
		
				.append("      left join Schedulestatus ssu on ssu.scheduleplanid=t.scheduleplanid and ssu.departdate=t.departdate and ssu.departstationid=t.departstationid")
				.append("      ,Scheduleplan sp,Schedulevehiclepeopleplan svpp ")
				.append("      left join vehicle vsvpp on svpp.planvehicleid=vsvpp.id")
				.append("      left join unit usvpp on svpp.planunitid=usvpp.id")
				.append("      ,Vehicletype vtsvpp, Vehiclebrandmodel vbmsvpp,schedule sc, organization o, ticketoutlets ti,userinfo u, route ro,station sts,Station ste ")
				.append(" where t.scheduleplanid = sp.id")
				.append("	and t.departdate=sp.departdate")
				.append("	and t.departdate=svpp.departdate")
				.append("   and sp.id=svpp.scheduleplanid")
				.append("   and sp.scheduleid=sc.id")
				.append("   and sc.routeid=ro.id ")
				.append("   and ro.startstationid=sts.id")
				.append("   and ro.endstationid=ste.id")
				.append("   and t.orgid=o.id ")
				.append("	and t.ticketoutletsid=ti.id ")
				.append("   and t.reserveby=u.id")
				.append(" 	and svpp.orderno=0")
				.append(" 	and svpp.planvehicletypeid=vtsvpp.id")
				.append(" 	and svpp.planvehiclebrandmodelid=vbmsvpp.id");
		if(!"".equals(certificateno)){
			sql.append(" and upper(c.certificateno) = upper('").append(certificateno).append("')");//证件号转换为大写
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		
		sql.append(" union all ");
		sql.append("select t.scheduleplanid, t.id, 0 as scheduleid, t.orgid, ")
		.append(" t.departstationid, t.reachstationid, t.departdate,trim(t.departtime), ")
		.append(" t.fullprice as fullprice, t.fullprice as price, ")
		.append(" round((t.fullprice  / 2), 0) as halfprice, ")
		.append(" t.fullprice as studentprice, ")
		.append(" t.seatno, t.serviceprice, t.reservetime,t.sellstate, ")
		.append(" t.createtime, t.updatetime, t.schedulecode as schedulecode, '' as scheduleremarks, ")
		.append(" o.name as orgname, t.sellstate, sd.name as departstationname, ")
		.append(" sr.name as reachstationname, '' as reachstationsecondname, sr.isroundtrip, ")
		.append(" ti.name as ticketoutletname, u.name as reservename, t.routename as routename, ")
		.append(" 0 returntripvaliddays, t.tickettype, c.name as customername,c.certificatetype, ")
		.append(" c.certificateno, c.familyphone,c.mobilephone, t.customerid,t.autocanceltime, ")
		.append(" t.canceltime, t.isautocancel, '' as startstationname, '' as endstationname, ")
		.append(" '' workways, null islinework, null isovertime, t.seattype seattype, 0 distance, ")
		.append(" 0 toplimitprice, 0 fueladditionfee, 0 stationservicefee, ")
		.append(" case t.sellstate when 'R' then (case ").append(isselect).append(" when 0 then 0 else 1 end ) else null end as isselect, ")
		.append(" case t.carrychildnum when 0 then 0 else 1  end as istakekid, ")
		.append(" t.carrychildnum,'' ticketentrance,'' buspark, ")
		.append(" '' as planvehicletype, '' as planvehiclegrade, ")
		.append(" '' as planvehicletypecustomname, null as planvheicletypeid, ")
		.append(" '' as planvehicleno, null planvehicleid, '' as planunitname, null as planunitid, ")
		.append(" '' as planbrandmodel, null as planbrandmodelid, '' ticketentrancename ")
		.append(" , 1 as isnetseat, t.schedulesynccode as schedulesynccode ")
		.append(" , sd.code as departstationcode, sr.code as reachstationcode ")
		.append(" , 0 as isrealnameticket , t.fullprice as discountprice,t.fullprice as roundprice,t.fullprice as connectprice  from seatreserveagent t ")
		.append("  left join organization o on t.reserveorgid = o.id ")
		.append("  left join station sd on t.departstationid = sd.id ")
		.append("  left join station sr on t.reachstationid = sr.id ")
		.append("  left join ticketoutlets ti on t.ticketoutletsid = ti.id ")
		.append("  left join userinfo u on t.reserveby = u.id ")
		.append("  left join customer c on t.customerid = c.id ")
		.append("where 1 = 1  ");
		if(!"".equals(certificateno)){
			sql.append(" and upper(c.certificateno) = upper('").append(certificateno).append("')");//证件号转换为大写
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		
		Query query = dao.getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return ListUtil.listToMap(new Object[] { "scheduleplanid","id","scheduleid","orgid","departstationid","reachstationid"
				, "departdate",	"departtime", "fullprice","price", "halfprice","studentprice","seatno", "serviceprice",
				"reservetime", "sellstate", "createtime", "updatetime",
				"schedulecode", "scheduleremarks","orgname", "sellstate", "departstationname",
				"reachstationname","reachstationsecondname","isroundtrip", "ticketoutletname", "reservename",
				"routename","returntripvaliddays","tickettype", //"tickettypename",
				"customername", "certificatetype", "certificateno",	"familyphone", "mobilephone"
				, "customerid", "autocanceltime","canceltime", "isautocancel"
				,"startstationname", "endstationname","workways"
				,"islinework","isovertime"
				,"seattype","distance","toplimitprice","fueladditionfee","stationservicefee"
				,"isselect","istakekid","carrychildnum"
				,"ticketentrance","buspark"
				,"planvehicletype","planvehiclegrade","planvehicletypecustomname","planvheicletypeid"
				,"planvehicleno","planvehicleid","planunitname","planunitid"
				,"planbrandmodel","planbrandmodelid","ticketentrancename", "isnetseat", "schedulesynccode", "departstationcode", "reachstationcode","isrealnameticket",
				"discountprice","roundprice","connectprice"
				},
				query.getResultList(), new Object[] { Long.class,Long.class,Long.class,Long.class,Long.class,Long.class,
						Timestamp.class, String.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,Short.class, BigDecimal.class
						, Timestamp.class,String.class, Timestamp.class, Timestamp.class,
						String.class,String.class, String.class, String.class, String.class,
						String.class, String.class,Boolean.class, String.class,String.class
						, String.class,Short.class, String.class //,String.class
						, String.class,	String.class, String.class, String.class, String.class,
						Long.class, Timestamp.class, Timestamp.class, Boolean.class
						, String.class, String.class, String.class
						, Boolean.class, Boolean.class
						, String.class,Integer.class, BigDecimal.class, BigDecimal.class, BigDecimal.class
						, Boolean.class, Boolean.class,Integer.class
						, String.class, String.class
						, String.class,	String.class, String.class, Long.class
						, String.class,	Long.class, String.class,Long.class
						, String.class,	Long.class, String.class, Boolean.class, String.class, String.class, String.class,Boolean.class
						, BigDecimal.class, BigDecimal.class, BigDecimal.class});
	}
	
	public Ticketsell getTicketsellById(Long id){
		return (Ticketsell) dao.get(Ticketsell.class, id);
	}
	
	public TicketturnoverdetailService getTicketturnoverdetailService() {
		return ticketturnoverdetailService;
	}

	public void setTicketturnoverdetailService(
			TicketturnoverdetailService ticketturnoverdetailService) {
		this.ticketturnoverdetailService = ticketturnoverdetailService;
	}

	public VipService getVipService() {
		return vipService;
	}

	public void setVipService(VipService vipService) {
		this.vipService = vipService;
	}

	public SchedulestationcontrolService getSchedulestationcontrolService() {
		return schedulestationcontrolService;
	}

	public void setSchedulestationcontrolService(
			SchedulestationcontrolService schedulestationcontrolService) {
		this.schedulestationcontrolService = schedulestationcontrolService;
	}

	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}
//
//	public SessionContext getContext() {
//		return context;
//	}
//
//	public void setContext(SessionContext context) {
//		this.context = context;
//	}

	@Override
	public int updateTicketStatusById(Long id, int statusCode) {
		// TODO Auto-generated method stub
		String sql = "update ticketsell ts set ts.TICKETSTATUS="+statusCode+" where ts.id="+id;
		Query query = JPA.em().createNativeQuery(sql);
		return query.executeUpdate();
	}

	/*
	@Override
	public List<Map<String, Object>> findScheduleDetail(
			ScheduleDetail sd) {
		StringBuffer sb = new StringBuffer();
//		sb.append("select (select name from organization where id=t.orgid) as orgname, count(1) as sold, (select count(1) from seatreserve where scheduleid=:scheduleid and departtime=:departtime and departdate=:departdate and orgid=t.orgid ) as reservation ");
//		sb.append("from ticketsell t  where  t.scheduleid=:scheduleid and t.departtime=:departtime and t.departdate=:departdate group by t.orgid");
		sb.append("select (select name from organization where id = ua.orgid) as orgname,sum(sold),sum(reservation) from ");
		sb.append(" (select t.orgid as orgid,count(1) as sold,0 as reservation from ticketsell t where ticketstatus = '0' and ");
		sb.append("  t.scheduleid=:scheduleid and t.departtime=:departtime and t.departdate=:departdate  group by t.orgid");
		sb.append(" union all ");
		sb.append(" select sr.orgid,0 as sold,count(1) as reservation from seatreserve sr");
		sb.append(" where sellstate = 'R' and scheduleid=:scheduleid and departtime=:departtime and departdate=:departdate");
		sb.append(" group by sr.orgid) ua group by ua.orgid ");
		Query query = dao.getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("scheduleid", sd.getScheduleid());
		query.setParameter("departtime", sd.getDeparttime());
		query.setParameter("departdate", sd.getDepartDate());
		return ListUtil.listToMap(new Object[]{"orgname","sold","reservation"}, 
		  query.getResultList(),
		  new Object[]{String.class,Long.class,Long.class}
		  );
	}
	
	@Override
	public List<Map<String, Object>> findScheduleDetail2(
			ScheduleDetail sd) {
		StringBuffer sb = new StringBuffer();
		if(sd.isIslinework()){
			sb.append("select ua.seatno");
		}else{
			sb.append("select sc.seatno");
		}
		sb.append(",ua.organizationname,ua.departstationname,ua.reachstationname,ua.price,ua.ticketno,ua.tickettype,ua.seller,ua.remarks ");
		if(sd.isIslinework()){
			sb.append(" from");
		}else{
			sb.append(" from Scheduleseats sc left join ");
		}
		sb.append(" (select seatno,oz.name as organizationname,s1.name as departstationname,s2.name as reachstationname,");
		sb.append("price,ticketno,tp.name as tickettype,uf.name as seller,'' as remarks,scheduleplanid,scheduleid,departdate ");
		sb.append("from ticketsell ts left join organization oz on oz.id = ts.orgid ");
		sb.append("left join station s1 on s1.id = ts.departstationid   left join station s2 on s2.id = ts.reachstationid  ");
		sb.append(" left join tickettype tp on ts.tickettype = tp.code  left join userinfo uf on uf.id=ts.sellby  ");
		sb.append("where ticketstatus = '0' and scheduleid =:scheduleid   and departtime =:departtime  and departdate =:departdate ");
		sb.append("union all ");
		sb.append("select seatno,oz.name as organizationname,s1.name as departstationname,s2.name as reachstationname,");
		sb.append("fullprice as price,'' as ticketno,'留位' as tickettype,uf.name as seller,remarks,scheduleplanid,scheduleid,departdate ");
		sb.append("from seatreserve st left join organization oz on oz.id = st.orgid  left join station s1 on s1.id = st.departstationid ");
		sb.append(" left join station s2 on s2.id = st.reachstationid  left join userinfo uf on uf.id=st.reserveby  ");
		sb.append(" where sellstate = 'R' and scheduleid =:scheduleid   and departtime =:departtime  and departdate =:departdate ) ua ");
		if(!(sd.isIslinework())){
			sb.append("on ua.scheduleplanid=sc.scheduleplanid and ua.scheduleid=sc.scheduleid and sc.departdate=ua.departdate  and ua.seatno=sc.seatno ");
			sb.append("where sc.scheduleid =:scheduleid and  sc.departdate =:departdate ");
		}
		sb.append("order by seatno");
		Query query = dao.getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("scheduleid", sd.getScheduleid());
//		query.setParameter("scheduleplanid", sd.getScheduleplanid());
		query.setParameter("departtime", sd.getDeparttime());
		query.setParameter("departdate", sd.getDepartDate());
		return ListUtil.listToMap(new Object[]{"seatno","organizationname","departstationname","reachstationname","price",
				"ticketno","tickettype","seller","remarks"}, 
		  query.getResultList(),
		  new Object[]{Long.class,String.class,String.class,String.class,BigDecimal.class,
				String.class,String.class,String.class,String.class,}
		  );
	}
	*/
	
	public List<Map<String, Object>> findScheduleDetail(
			ScheduleDetail sd) {	
		StringBuffer sb = new StringBuffer();
		sb.append("select (select name from organization where id = ua.orgid) as orgname,sum(sold),sum(reservation) from ");
		sb.append(" (select t.orgid as orgid,count(1) as sold,0 as reservation from ticketsell t where ticketstatus = '0' and ");
		sb.append("  t.scheduleid=:scheduleid and  t.departdate=:departdate  group by t.orgid");
		sb.append(" union all ");
		sb.append(" select sr.orgid,0 as sold,count(1) as reservation from seatreserve sr");
		sb.append(" where sellstate = 'R' and scheduleid=:scheduleid  and departdate=:departdate");
		sb.append(" group by sr.orgid " );
		sb.append("union all ");
		//更新固定留位时，使用的是scheduleseats，所以这里也用scheduleseats查询固定留位，详情查询一样
		sb.append("select ss.orgid,0 as sold ,count(1) as reservation  from scheduleseats ss where ss.status='3' and ss.scheduleid=:scheduleid and departdate=:departdate group by ss.orgid )ua group by ua.orgid  ");
		Query query = dao.getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("scheduleid", sd.getScheduleid());
		query.setParameter("departdate", sd.getDepartDate());
		return ListUtil.listToMap(new Object[]{"orgname","sold","reservation"}, 
		  query.getResultList(),
		  new Object[]{String.class,Long.class,Long.class}
		  );
	}
	
	public List<Map<String, Object>> findScheduleDetail2(
			ScheduleDetail sd) {
		StringBuffer sb = new StringBuffer();
		if(sd.isIslinework()){
			sb.append("select ua.seatno");
			sb.append(",ua.organizationname,ua.departstationname,ua.startstationname,ua.reachstationname,ua.price,ua.ticketno,ua.tickettype,ua.seller,ua.remarks,ua.sellway ");
		}else{
			sb.append("select sc.seatno");
			sb.append(",decode(sc.status,'3',og.name,ua.organizationname) as organizationname,")
			.append(" ua.departstationname,ua.startstationname,ua.reachstationname,ua.price,ua.ticketno,")
			.append("case sc.status when '3' then '固定留位' else ua.tickettype end as tickettype,ua.seller,ua.remarks,ua.sellway ");
		}
		if(sd.isIslinework()){
			sb.append(" from");
		}else{
			sb.append(" from Scheduleseats sc left join ");
		}
		sb.append(" (select seatno,oz.name as organizationname,s1.name as departstationname,s1.name as startstationname,s2.name as reachstationname,");
		sb.append("price,ticketno,tp.name as tickettype,uf.name as seller,'' as remarks,scheduleplanid,scheduleid,departdate,dt.value sellway ");
		sb.append("from ticketsell ts left join organization oz on oz.id = ts.orgid ");
		sb.append("left join station s1 on s1.id = ts.departstationid   left join station s2 on s2.id = ts.reachstationid  ");
		sb.append(" left join tickettype tp on ts.tickettype = tp.code  left join userinfo uf on uf.id=ts.sellby,digitaldictionary dd,digitaldictionarydetail dt  ");
		sb.append(" where dd.id=dt.digitaldictionaryid and ts.paymethod=dt.code and dd.tablename='ticketsell' and dd.columnname='paymethod' ");
		sb.append(" and ticketstatus = '0' and scheduleid =:scheduleid  and departdate =:departdate ");
		sb.append("union all ");
		sb.append("select seatno,oz.name as organizationname,s1.name as departstationname,s1.name as startstationname,s2.name as reachstationname,");
		sb.append("fullprice as price,'' as ticketno,'留位' as tickettype,uf.name as seller,remarks,scheduleplanid,scheduleid,departdate,'' sellway ");
		sb.append("from seatreserve st left join organization oz on oz.id = st.orgid  left join station s1 on s1.id = st.departstationid ");
		sb.append(" left join station s2 on s2.id = st.reachstationid  left join userinfo uf on uf.id=st.reserveby  ");
		sb.append(" where sellstate = 'R' and scheduleid =:scheduleid   and departdate =:departdate ) ua ");
		if(!(sd.isIslinework())){
			sb.append("on ua.scheduleplanid=sc.scheduleplanid and ua.scheduleid=sc.scheduleid and sc.departdate=ua.departdate  and ua.seatno=sc.seatno ");
			sb.append(" left join organization og on sc.orgid=og.id ");
			sb.append("where sc.scheduleid =:scheduleid and  sc.departdate =:departdate ");
		}
		sb.append("order by seatno");
		Query query = dao.getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("scheduleid", sd.getScheduleid());
		query.setParameter("departdate", sd.getDepartDate());
		return ListUtil.listToMap(new Object[]{"seatno","organizationname","departstationname","startstationname","reachstationname","price",
				"ticketno","tickettype","seller","remarks","sellway"}, 
		  query.getResultList(),
		  new Object[]{Long.class,String.class,String.class,String.class,String.class,BigDecimal.class,
				String.class,String.class,String.class,String.class,String.class}
		  );
	}
	
	//根据班次编码取车站班次id
	@Override
	public Schedule findScheduleByCode(NetScheduleDetail sd) {
		String sql = "select s from Schedule s where synccode ='"+sd.getSchedulesynccode()+"'";
		Query query = dao.getEntityManager().createQuery(sql);
		return (Schedule)query.getResultList().get(0);
	}
	
	//更新本地的售票数和留位数
	public void updateTicketpriceAndScheduleplan(long scheduleplanid,short autonum,short unautonum,short soldnum){
		Scheduleplan sp =(Scheduleplan)dao.get(Scheduleplan.class, scheduleplanid);
		if(sp==null){
			return;
		}
		sp.setAutocancelreserveseatnum(autonum);
		sp.setUnautocancelreserveseatnum(unautonum);
		sp.setSoldeatnum(soldnum);
		dao.merge(sp);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplanid));
		List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
		if(ticketprices.size()>=1){
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum(soldnum);
				_ticketprice.setAutocancelreserveseatnum(autonum);
				_ticketprice.setUnautocancelreserveseatnum(unautonum);
				dao.merge(_ticketprice);
			}
		}
	}
	
	public void updatestowgescheduleplan(ScheduleAskCondition scheduleAskCondition,Global global){
		List<PropertyFilter> Filters = new ArrayList<PropertyFilter>();
		StringBuilder  schsql = new StringBuilder("select sp.id,sp.synccode,sp.soldeatnum,sp.autocancelreserveseatnum,sp.unautocancelreserveseatnum ,sp.worktype from scheduleplan sp where sp.worktype='3' ");
		if(scheduleAskCondition.getReachStationId()>0){
			Filters.add(new PropertyFilter("EQL_sp!endstationid", scheduleAskCondition.getReachStationId()));
			Filters.add(new PropertyFilter("EQD_sp!departdate", scheduleAskCondition.getDepartDate()));
		}else{
			return;
		}
		if(scheduleAskCondition.getDepartStationId()>0){
			Filters.add(new PropertyFilter("EQL_sp!startstationid", scheduleAskCondition.getDepartStationId()));
		}
		schsql.append(PropertyFilter.toJpql(Filters, true));
		Query q = dao.getEntityManager().createNativeQuery(schsql.toString());
		JPAPropertyFilterUtil.setParameter(q, Filters);
		List<Object> planlist = q.getResultList();
		List<Map<String, Object>> schplanlist = new ArrayList<Map<String,Object>>();
		//转化为List<Map<String, Object>> 格式
		if(planlist.size()<=0){
			return;
		}
		for (Object o : planlist) {
			Object[] obj = (Object[])o;
			Map<String,Object> m = new HashMap<String, Object>();
			m.put("scheduleplanid", obj[0]);
			m.put("synccode", obj[1]);
			schplanlist.add(m);
		}
		List<Map<String, Object>> netresult =null;
		try {
			//调用中心进行查询售票数
			if(schplanlist.size()>0){
				MethodResult methodResult = netTicketSellOtherService.findStowageNetSchedule(schplanlist, global);
				if(methodResult.getResult()==1){
					netresult = (List<Map<String, Object>>)methodResult.getObject();
					//进行更新
					for (Map<String, Object> map : netresult) {
						short netsoldnum =Short.parseShort(map.get("soldnum").toString());
						short netautocancelreserveseatnum =Short.parseShort(map.get("autocancelreserveseatnum").toString());
						short netunautocancelreserveseatnum =Short.parseShort(map.get("unautocancelreserveseatnum").toString());
						long netscheduleplanid = Long.parseLong(map.get("scheduleplanid").toString());
						for (Object o : planlist) {
							Object[] obj = (Object[])o;
	//						short soldnum = Short.parseShort(obj[2].toString());
	//						short autocancelreserveseatnum = Short.parseShort(obj[3].toString());
	//						short unautocancelreserveseatnum = Short.parseShort(obj[4].toString());
							long scheduleplanid = Long.parseLong(obj[0].toString());
							//判断是否需要更新，如果已售和留位相等 则不更新
							if(scheduleplanid==netscheduleplanid){
	//							if(soldnum!=netsoldnum||autocancelreserveseatnum!=netautocancelreserveseatnum||unautocancelreserveseatnum!=netunautocancelreserveseatnum){
								netTicketSellOtherService.updateTicketpriceAndScheduleplan(netsoldnum, netautocancelreserveseatnum, netunautocancelreserveseatnum, netscheduleplanid);
	//							}
								break;
							}
						}
						
					}
				}
			}
		} catch (Exception e) {
			System.out.println("更新中心班次售票情况失败："+e.toString());
		}
	}
	
	public Schedulestop getSchedulestop(long scheduleid, long stationid) {
		StringBuilder sql = new StringBuilder("select ss")
				.append(" from Schedulestop ss ")
				.append(" where ss.schedule.id=:scheduleid")
				.append(" and ss.stationid=:stationid");
		Query query = dao.getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("stationid", stationid);
		List<Object> list = query.getResultList();
		return (Schedulestop) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}
	
	public boolean checkTicketnoAndBatchno(String ticketno,String batchno){
		StringBuilder sql = new StringBuilder()
				.append(" select count(1)  from ticketsell ts ")
				.append(" where ts.ticketno=:ticketno")
				.append(" and ts.batchno=:batchno");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		query.setParameter("batchno", batchno);
		int count = ((BigDecimal) query.getSingleResult()).intValue();
		return count>0?true:false;
	}
	
	//校验同一个证件是否已经售同一班次的票
	public boolean checkCustomerIsSold(String certificatetypename,String certificateno,long scheduleplanid){
		StringBuilder sql = new StringBuilder()
				.append(" select count(1)  from ticketsell ts ")
				.append(" where ts.certificatetypename=:certificatetypename and ts.ticketstatus='0' ")
				.append(" and ts.certificateno=:certificateno and ts.scheduleplanid=:scheduleplanid " );
		Query query = dao.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("certificatetypename", certificatetypename);
		query.setParameter("certificateno", certificateno);
		query.setParameter("scheduleplanid", scheduleplanid);
		int count = ((BigDecimal) query.getSingleResult()).intValue();
		return count>0?true:false;
	}
	
	// 计算同一个证件号购票时间差
	public BigDecimal checkCustomerIsInTime(String certificatetypename, String certificateno) {
		StringBuilder sql = new StringBuilder().append(" select trunc((sysdate - max(ts.selltime))*24) from ticketsell ts ")
				.append(" where ts.certificatetypename=:certificatetypename")
				.append(" and ts.certificateno=:certificateno and ts.ticketstatus = 0 and ts.departdate >=sysdate-10 ");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("certificatetypename", certificatetypename);
		query.setParameter("certificateno", certificateno);
		List list = query.getResultList();
		BigDecimal count =(BigDecimal) (list != null && list.size()>0? list.get(0) : null);
		return count;
	}
	@Override
	public List<Ticketsell> findTuanTicketsell(String ticketno,Date departdate, long scheduleplanid){
		StringBuilder sql = new StringBuilder()
				.append(" select  ts from Ticketsell ts ")
				.append(" where ts.ticketno like '"+ticketno+"%'" )
				.append(" and ts.departdate=:departdate and ts.scheduleplanid = :scheduleplanid order by ts.seatno " );
		Query query = dao.getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Ticketsell> list = query.getResultList();
		return list;
	}
	@Override
	public String seatnoToSeatstr(List<Short> seatnolist){
		String seatno = "";
		Map<Short, Short> map = new LinkedHashMap<Short, Short>();
		if(seatnolist.size()>0){
			List<Short> list = new ArrayList<Short>();
			list.add(seatnolist.get(0)); //保存所有的间断的开始座位号
			for(int i =0;i<seatnolist.size()-1;i++){
				if((seatnolist.get(i)+1)!=seatnolist.get(i+1)){
					list.add(seatnolist.get(i+1)); 
				}
			}
			//将连续的座位号放入map中 例如 1，2，3 则map.put(1,3)
			for(int i =0;i<list.size();i++){
				for(int j =0;j<seatnolist.size()-1;j++){
					if(list.get(i)==seatnolist.get(j)){
						for(int k =j;k<seatnolist.size()-1;k++){
							if((seatnolist.get(k)+1)!=seatnolist.get(k+1)){
								map.put(list.get(i), seatnolist.get(k));
								break;
							}else{
								if(k==seatnolist.size()-2){
									map.put(list.get(i), seatnolist.get(k+1));
								}
							}
							
						}
						break;
					}
					if(list.get(i)==seatnolist.get(seatnolist.size()-1)){
						map.put(list.get(i), list.get(i));
						break;
					}
				}
			}
		}
		for(Map.Entry<Short, Short> entry: map.entrySet()){
			if(entry.getKey()==entry.getValue()){
				seatno =seatno+entry.getKey()+",";
			}else{
				seatno =seatno+entry.getKey()+"-"+entry.getValue()+",";
			}
		}
		return seatno;
	}



	@Override
	public void qryTicketsellotherByTicketsellid(long ticketsellid) throws ServiceException {
		Ticketsellother ticketsellother = ticketsellotherDao.qryTicketsellotherByTicketsellid(ticketsellid);
		if (ticketsellother != null) {
			if (!ticketsellother.getIstaked()) {
				throw new ServiceException("0346");  //电子票没取，不能重打
			}
		}
	}
	@Override
	public MethodResult proEticketsell(MethodResult methodResult) {
		List<TicketPrintInfo> ticketprintinfos = (List<TicketPrintInfo>) methodResult.getObject();
		try {
			OrganizationDao odao = new  OrganizationDao();
			// 不是电子票直接返回
			if (!ticketprintinfos.get(0).isIsestationsell()) {
				return methodResult;
			}
			List<EticketNoProdRequest> requestlist = new ArrayList<EticketNoProdRequest>();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			EticketService ser = new EticketService();
			// 构造请求参数
			for (TicketPrintInfo ticketPrintInfo : ticketprintinfos) {
				Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketPrintInfo.getId());
				Organization o = (Organization) dao.get(Organization.class, ticketsell.getOrgid());
				Schedule s = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
				Ticketsellother other = new Ticketsellother();
				other.setTicketsellid(ticketsell.getId());
				other.setPassword(getGuid());
				other.setServiceprice(BigDecimal.ZERO);
				other.setAgentname(o.getName());
				if(ticketPrintInfo.isIsjumpEticketno()){
					other.setIstaked(true);
					other.setTaketime(ticketsell.getCreatetime());
					other.setTakeway("0");
					other.setPrintby(ticketsell.getCreateby());
				}else{
					other.setIstaked(false);
				}
				other.setCreatetime(ticketsell.getCreatetime());
				other.setCreateby(ticketsell.getCreateby());
				other.setUpdatetime(ticketsell.getUpdatetime());
				other.setUpdateby(ticketsell.getUpdateby());
				other.setEticketno(ticketsell.getEticketno());
				other.setOrderno(ticketsell.getOrderno());
				dao.merge(other);
				// 班次计划
				Scheduleplan sp = (Scheduleplan) dao.get(Scheduleplan.class, ticketsell.getScheduleplanid());
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", sp.getId()));
				propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
				propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", ticketsell.getReachstationid()));
				// 票价
				Ticketprice tp = (Ticketprice) dao.uniqueResult(Ticketprice.class, propertyFilters);
				EticketNoProdRequest request = new EticketNoProdRequest();
				Station departstation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
				Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
				// 乘车站编码(必填)
				request.setBusStationCode(departstation.getCode());
				request.setBusStationName(departstation.getName());
				// 购票时间
				request.setBuyTicketsTime(util.DateUtils.formatDatetime(ticketsell.getSelltime()));
				// 购票途径：0-自助机、1-窗口、2-网售、3-手持机 4-车载终端(必填)
				request.setBuyTicketsType("窗口");
				// 乘车卡位(必填)
				request.setCarCardPosition(ticketsell.getBuspark());
				// 证件号码(必填)
				request.setCertificateNo(ticketsell.getCustomer().getCertificateno());
				// 证件类型：0：身份证，1：学生证，2：军官证，3：驾驶证，4：护照，5：港澳通行证(必填)
				request.setCertificateType(ticketsell.getCertificatetypename());
				// 取票码(必填)
				request.setCheckCode("");
				// 检票状态:未检:0/已检:1(必填)
				request.setCheckedTicketStatus("0");
				// 保额(有保险必填)
				request.setCoverage(null);
				// 旅客姓名(必填)
				request.setCustomerName(ticketsell.getCustomer().getName());
				// 发车日期
				request.setDepartDate(util.DateUtils.formatDate(ticketsell.getDepartdate()));
				List<Organization> organizationlist=odao.getOrganizationlist(tp.getDepartstationid(),"station");
				if(null != organizationlist && organizationlist.size()>0){
					Organization depart = organizationlist.get(0);
					String codetransstr ="";
					try {
					  codetransstr = odao.getCodetranscode(depart.getCode());
					} catch (Exception e) {
						play.Logger.error("售电子票时机构转码失败!");
					}
					 if("".equals(codetransstr)){
						 request.setDepartOrgCode(depart.getCode());
						 request.setDepartOrgName(depart.getName()); 
					 }else{
					 request.setDepartOrgCode(codetransstr);
					 request.setDepartOrgName(depart.getName());
					 }
				}
				// 发车时间
				request.setDepartTime(ticketsell.getDeparttime());
				// 电子票号
				// 保单号(有保险必填)
				request.setGuaranteeSlipNo(null);
				// 发票代码
				if (ticketsell.getTicketno().length() <= 20) {
					request.setInvoiceCode(ticketsell.getTicketno());
				}
				// 是否携童
				request.setIsCarryChildren(ticketsell.getCarrychildnum() > 0 ? "1" : "0");
				// 是否流水班
				request.setIsFlowClass(ticketsell.getIslinework() ? "1" : "0");
				// 是否加班
				request.setIsOverTime(sp.getIsovertime() ? "1" : "0");
				// 公里数(
				request.setKilometers(String.valueOf(tp.getDistance()));
				// 订单号
				request.setOrderNo(ticketsell.getOrderno());
				// 预留参数
				request.setPara1(null);
				// 预留参数
				request.setPara2(null);
				// 手机号码
				request.setPhone(ticketsell.getCustomer().getMobilephone());
				// 物理票号
				if (ticketsell.getTicketno().length() <= 20) {
					request.setPhysicalTicketNo(ticketsell.getTicketno());
				}
				// 取票状态：已取: 1/未取:0(必填)
				request.setPickTicketStatus("0");
				// 保费(有保险必填)
				request.setPremium(null);
				// 到达站编码
				request.setReachStationCode(reachstation.getCode());
				// 到达站名称
				request.setReachStationName(reachstation.getName());
				request.setPremium("0");
				request.setCoverage("0");
				// 车次
				request.setScheduleCode(s.getCode());
				// 座位号(
				request.setSeatNo(String.valueOf(ticketsell.getSeatno()));
				// 座位类型
				switch(Integer.valueOf(ticketsell.getSeattype())) {
				case 0:
					request.setSeatType("普通座");
					break;
				case 1:
					request.setSeatType("上铺");
					break;
				case 2:
					request.setSeatType("商务座");
					break;
				case 3:
					request.setSeatType("下铺");
					break;
				case 4:
					request.setSeatType("麻将坐");
					break;
				default:
					request.setSeatType("未知");
					break;
				} 
				// 车票类型：0：汽车票，1：专车 (必填)
				request.setServiceType("0");
				// 售票机构（比如畅途，网站）必填
				request.setTicketAgency(o.getName());
				// 售票机构编码(必填)
				request.setTicketAgencyCode(o.getCode());
				// 检票口(必填)
				request.setTicketEntrance(ticketsell.getTicketentrance());
				// 票状态：正常:0/已退:1/已废:2/作废:3(必填)
				request.setTicketStatus("0");
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticketsell.getTickettype()));
				// 票种(必填)
				Tickettype t = (Tickettype) dao.uniqueResult(Tickettype.class, propertyFilters);
				if(null != t){
					request.setTicketType(t.getName());	
				}else{
					request.setTicketType(ticketsell.getTickettype());	
				}
				// 车牌号(必填)
				request.setVehicleNo("");
				request.setTicketDelivery(ticketsell.getCertificatetypename());
				request.setEticketNumber(ticketsell.getEticketno());
				request.setBusinessId(eStationSellTicketBusinessId.trim());
				if(CommonUtil.isEmptyString(Wd_Factor)){
					methodResult.setResult(0);
					methodResult.setResultMsg("生成电子票失败! snowflake.wdfactor.value 未配置!");	
				}else{
					request.setWdFactor(Wd_Factor);
				}
				requestlist.add(request);
				play.Logger.info("窗口售电子票 ticketsell info"+JsonUtil.parseObject(ticketsell));
				dao.getEntityManager().flush();
			}
			EticketProdResponse response = new EticketProdResponse();
			try {
				// 调用接口生成电子票
				response = ser.eticketProd(requestlist);
				if (!"0000".equals(response.getResultCode())) {
					methodResult.setResult(0);
					methodResult.setResultMsg("生成电子票失败");
				}
				play.Logger.info("窗口售电子票 调用接口生成电子票结果:"+response.getMessage());
			} catch (Exception e) {
				play.Logger.error("生成电子票失败 :" + e.getMessage());
				methodResult.setResult(0);
				methodResult.setResultMsg("生成电子票失败");
			}
		} catch (Exception e) {
			play.Logger.error("生成电子票失败 :" + e.getMessage());
			methodResult.setResult(0);
			methodResult.setResultMsg("生成电子票失败");
		}
		return methodResult;
	} 
	
	public static int Guid=100;
	 
	public static String getGuid() {
		
		TicketSellServiceImpl.Guid+=1;

		long now = System.currentTimeMillis();  
		//获取4位年份数字  
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy");  
		//获取时间戳  
		String time=dateFormat.format(now);
		String info=now+"";
		//获取三位随机数  
		//int ran=(int) ((Math.random()*9+1)*100); 
		//要是一段时间内的数据连过大会有重复的情况，所以做以下修改
		int ran=0;
		if(TicketSellServiceImpl.Guid>999){
			TicketSellServiceImpl.Guid=100;    	
		}
		ran=TicketSellServiceImpl.Guid;
				
		return time+info.substring(2, info.length())+ran;  
	}
}
