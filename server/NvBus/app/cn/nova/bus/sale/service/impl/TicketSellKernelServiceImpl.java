/**
 * 
 */
package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.LockModeType;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SessionContext;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.price.service.impl.TicketpriceformulaServiceImpl;
import cn.nova.bus.sale.model.Returntripticket;
import cn.nova.bus.sale.model.SaleDuration;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.sale.model.SeatlockPK;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.param.ParamFindScheduleIn;
import cn.nova.bus.sale.param.ParamLockSeatsIn;
import cn.nova.bus.sale.param.ParamSellTicketIn;
import cn.nova.bus.sale.param.ParamSellTicketsIn;
import cn.nova.bus.sale.remote.param.ParamDepartSchedule;
import cn.nova.bus.sale.remote.param.ParamFindSchedulesOut;
import cn.nova.bus.sale.remote.param.ParamLockSeatsOut;
import cn.nova.bus.sale.remote.param.ParamLockseatIn;
import cn.nova.bus.sale.remote.param.ParamLockseatOut;
import cn.nova.bus.sale.remote.param.ParamSellTicketOut;
import cn.nova.bus.sale.remote.param.ParamSellTicketsOut;
import cn.nova.bus.sale.remote.param.ParamUnLockSeatOut;
import cn.nova.bus.sale.service.TicketSellKernelService;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.dao.ExceptioninfoDao;
import cn.nova.bus.system.dao.OrganizationDao;
import cn.nova.bus.system.dao.UserinfoDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.DictionaryService;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.DictionaryServiceImpl;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class TicketSellKernelServiceImpl implements TicketSellKernelService{
	private static String TICKETBILLCODE="Ticket";

	
	private IDAO dao = new EntityManagerDaoSurport();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private TicketreturnService ticketreturnService = new TicketreturnServiceImpl();
	
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	private OrganizationDao organizationDao = new OrganizationDao();
	
	private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();
	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private DigitaldictionarydetailDao digitaldictionarydetailDao = new DigitaldictionarydetailDao();
	 
	private TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();
	
	private SchedulestatusDao schedulestatusDao = new SchedulestatusDao();
	
	private UserinfoDao userinfoDao = new UserinfoDao();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private DictionaryService dictionaryService = new DictionaryServiceImpl();
	
	@Resource 
	private SessionContext context;	
	final private Logger log=LoggerFactory.getLogger(getClass());
	final private int insideInvokFalse = -67101735;

	//TODO 校验票价和发车时间
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TicketSellKernelService#findSchedule(cn.nova.bus.sale.param.ParamFindScheduleIn)
	 */
	@Override
	public ParamFindSchedulesOut findSchedule(
			ParamFindScheduleIn paramFindScheduleIn) {
		StringBuilder sql = new StringBuilder();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		float CarrychildRate = Float.parseFloat(parameterService.findParamValue(ParamterConst.Param_1012, paramFindScheduleIn.getSellOrgID()))/100;
		
		sql.append("select sp.id as scheduleplanid,sp.departdate,ss.departtime,")
		.append("ss.departstationid,tp.reachstationid,ro.id as routeid,")
		.append("sp.isoriginator,sp.issaleafterreport,ss.isreported,ss.isdeparted,trunc((sp.seatnum-sp.fixedreserveseatnum)*").append(CarrychildRate).append("-sp.carrychildnum) as residuecarrychildnum,")
		.append("tp.id,sp.carrychildnum,sp.districttype,sp.endstationid,sp.endtime,sp.remarks,sp.islinework,")
		.append("sp.isovertime,sp.isproprietary,sp.issellreturnticket,") //sp.issellable,
		.append("sp.orgid,sp.scheduleid,sp.scheduletype,sp.spacinginterval,sp.startstationid,sp.starttime,sp.worktype,sp.workways,")
		.append("ss.buspark,ss.isbegincheck,ss.isemptyvehicle,ss.status,ss.ticketentrance,")
		.append("tp.fullprice,tp.halfprice,tp.issellable,tp.unautocancelreserveseatnum,")
		.append("tp.fixedreserveseatnum,tp.autocancelreserveseatnum,tp.runtime,tp.stationservicefee,tp.fueladditionfee,tp.seatnos,")
		.append("tp.seatnum,tp.seattype,tp.seattype as seattypecode,ddtseattype.value as seattypename,tp.soldeatnum,tp.studentprice,tp.distance,tp.balancedistance,tp.toplimitprice,tp.lowerlimitprice,");
		if("6".equals(paramFindScheduleIn.getSellway())){
		   sql.append(" tp.seatnum-tp.soldeatnum-tp.fixedreserveseatnum as residueseatnum,");
		}
		else{
		   sql.append(" tp.seatnum-tp.soldeatnum-tp.autocancelreserveseatnum-tp.unautocancelreserveseatnum-tp.fixedreserveseatnum as residueseatnum,");
		}
		sql.append("ro.name as routename,ro.returntripvaliddays,sc.code as schedulecode,sc.remarks as scheduleremarks,sc.synccode as schedulesynccode,") //
		.append("std.name as departstationname,std.code as departstationcode,str.name as reachstationname,str.code as reachstationcode,")
		.append("str.secondname as reachstationsecondname,str.isroundtrip,sts.name as startstationname,ste.name as endstationname, ")
		.append("vtsvpp.type as planvehicletype,vtsvpp.grade as planvehiclegrade,vtsvpp.customname as planvehicletypecustomname,vtsvpp.id as planvheicletypeid,")
		.append("vsvpp.vehicleno as planvehicleno,vsvpp.id as planvehicleid,usvpp.name as planunitname,usvpp.id as planunitid,")
		.append("concat(vbmsvpp.brandname,vbmsvpp.modelcode) as planbrandmodel,vbmsvpp.id as planbrandmodelid")
		.append(",tp.moreprice,tp.updatetime")
		.append(" from Scheduleplan sp, ")
		.append(" 	  Schedulevehiclepeopleplan svpp ")
		.append("      left join vehicle vsvpp on vsvpp.id=svpp.planvehicleid")
		.append("      left join unit usvpp on usvpp.id=svpp.planunitid ,")
		.append("      Vehicletype vtsvpp, ")
		.append("      Schedulestatus ss,Ticketprice tp,")
		.append(" 	  Schedule sc,Station std,Station str,Station sts,Station ste,Route ro,Vehiclebrandmodel vbmsvpp,Schedulestop scst")
		.append("     ,digitaldictionary ddseattype,digitaldictionarydetail ddtseattype")
		.append(" where sp.id=ss.scheduleplanid")
		.append("     and ddseattype.id=ddtseattype.digitaldictionaryid")
		.append("     and ddtseattype.code=tp.seattype")
		.append("     and ddseattype.tablename='handprice'")
		.append("     and ddseattype.columnname='seattype'")
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
		.append(" and scst.stationid=str.id")
		.append(" and sp.departdate=:departdate")
		.append(" and tp.departdate=:departdate")
		.append(" and ss.departdate=:departdate")
		;
		propertyFilters.add(new PropertyFilter("EQB_sp!issellable", true));
		propertyFilters.add(new PropertyFilter("EQB_tp!issellable", true));
		if(paramFindScheduleIn.getSeatTypeCode()!=null&&!paramFindScheduleIn.getSeatTypeCode().trim().equals("")){
			propertyFilters.add(new PropertyFilter("EQS_tp!seattype", paramFindScheduleIn.getSeatTypeCode().trim()));
		}
		String param1002 = parameterService.findParamValue(ParamterConst.Param_1002, paramFindScheduleIn.getSellOrgID());//只显示正常班次
		if("1".equals(param1002)){
			propertyFilters.add(new PropertyFilter("INS_ss!status", "('0','2')"));
		}
		if(!"2".equals(paramFindScheduleIn.getSellway())&&paramFindScheduleIn.getSellway()!=null&&!paramFindScheduleIn.getSellway().trim().equals("")){
			String param1003 = parameterService.findParamValue(ParamterConst.Param_1003, paramFindScheduleIn.getSellOrgID());//已发班不显示
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1003)){
				propertyFilters.add(new PropertyFilter("EQB_ss!isdeparted", false));
			}
		}
		//留票销售加上过留票人过滤条件
		if("6".equals(paramFindScheduleIn.getSellway())&&paramFindScheduleIn.getCustomerId()>0){
			//售票点不可售站点控制
			sql.append(" and exists (")
			   .append("    select sre.id from Seatreserve sre")
			   .append("     where sre.customer.id=").append(paramFindScheduleIn.getCustomerId())
			   .append("       and sre.sellstate='R'")
			   .append("       and sre.departstation.id=tp.departstationid")
			   .append("       and sre.reachstation.id=tp.reachstationid")
			   .append("       and sre.scheduleplanid=sp.id")
			   .append("     )");
		}
		if(paramFindScheduleIn.getScheduleId()!=null&&paramFindScheduleIn.getScheduleId()>0){
			propertyFilters.add(new PropertyFilter("EQL_sc!id", paramFindScheduleIn.getScheduleId()));
		}
		else if(paramFindScheduleIn.getReachStationId()!=null&&paramFindScheduleIn.getReachStationId()>0){
			propertyFilters.add(new PropertyFilter("EQL_tp!reachstationid", paramFindScheduleIn.getReachStationId()));
		}
		if(paramFindScheduleIn.getDepartStationId()!=null&&paramFindScheduleIn.getDepartStationId()>0){
			propertyFilters.add(new PropertyFilter("EQL_tp!departstationid", paramFindScheduleIn.getDepartStationId()));
			propertyFilters.add(new PropertyFilter("EQL_ss!departstationid", paramFindScheduleIn.getDepartStationId()));
		}
	    //0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票  10自助机 11邮政
		if(paramFindScheduleIn.getSellway()!=null&&!paramFindScheduleIn.getSellway().trim().equals("")){
			if("8".equals(paramFindScheduleIn.getSellway())
					||"6".equals(paramFindScheduleIn.getSellway())
					||"11".equals(paramFindScheduleIn.getSellway())
				){
					sql.append(" and sp.islinework=0");
			}
			if("6".equals(paramFindScheduleIn.getSellway())){
				//订票只显示有留座的班次
				sql.append(" and tp.autocancelreserveseatnum+tp.unautocancelreserveseatnum>0");
			}
			else{
				String param1001 = parameterService.findParamValue(ParamterConst.Param_1001, paramFindScheduleIn.getSellOrgID());//满座班次不显示
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1001)){
					sql.append(" and tp.seatnum-tp.soldeatnum-tp.autocancelreserveseatnum-tp.unautocancelreserveseatnum-tp.fixedreserveseatnum>0");
				}
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if(paramFindScheduleIn.getTicketoutletsId()!=null&&paramFindScheduleIn.getTicketoutletsId()>0){
				//售票点可售班次控制
				sql.append(" and (exists (")
				.append("select toss.id from Ticketoutletssellschedule toss")
				.append(" where toss.startdate<=:departdate") 
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(paramFindScheduleIn.getTicketoutletsId())
				.append("   and toss.type=0)")
				.append(" or exists (")
				.append("select toss.id from Ticketoutletssellschedule toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(paramFindScheduleIn.getTicketoutletsId())
				.append("   and toss.type=1")
				.append("   and toss.typeid=ro.id)")
				.append(" or exists (")
				.append("select toss.id from Ticketoutletssellschedule toss")
				.append(" where toss.startdate<=:departdate") 
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(paramFindScheduleIn.getTicketoutletsId())
				.append("   and toss.type=2")
				.append("   and toss.typeid=sc.id)")
				.append(")")
				;
				//售票点不可售站点控制
				sql.append(" and (not exists (")
				.append("select toss.id from Ticketoutletsunsellstation toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(paramFindScheduleIn.getTicketoutletsId())
				.append("   and toss.stationid=tp.reachstationid")
				.append("   and toss.type=0)")
				.append(" and not exists (")
				.append("select toss.id from Ticketoutletsunsellstation toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(paramFindScheduleIn.getTicketoutletsId())
				.append("   and toss.stationid=tp.reachstationid")
				.append("   and toss.type=1")
				.append("   and toss.typeid=ro.id)")
				.append(" and not exists (")
				.append("select toss.id from Ticketoutletsunsellstation toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(paramFindScheduleIn.getTicketoutletsId())
				.append("   and toss.stationid=tp.reachstationid")
				.append("   and toss.type=2")
				.append("   and toss.typeid=sc.id)")
				.append(")")
				;
			}

			//售票机器可售班次控制
			String parmvalue_1023 = parameterService.findParamValue(ParamterConst.Param_1023, paramFindScheduleIn.getSellOrgID());
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parmvalue_1023)&&paramFindScheduleIn.getSellIp()!=null&&!paramFindScheduleIn.getSellIp().trim().equals("")){
				sql.append(" and (exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(paramFindScheduleIn.getSellIp()).append("'")
				.append("   and pss.type=0)")
				.append(" or exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(paramFindScheduleIn.getSellIp()).append("'")
				.append("   and pss.type=1")
				.append("   and pss.typeid=ro.id)")
				.append(" or exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(paramFindScheduleIn.getSellIp()).append("'")
				.append("   and pss.type=2")
				.append("   and pss.typeid=sc.id)")
				.append(")")
				;
			}
		}
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		sql.append(" order by ss.departtime,scst.orderno");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString(),ParamDepartSchedule.class);

		
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		if(paramFindScheduleIn.getSellway()!=null&&!paramFindScheduleIn.getSellway().trim().equals("")){
			query.setParameter("departdate", paramFindScheduleIn.getDepartDate());
		}
		List<ParamDepartSchedule> result =  query.getResultList();
		
		if(paramFindScheduleIn.getSellway()==null||paramFindScheduleIn.getSellway().trim().equals("")){
			paramFindScheduleIn.setSellway("2"); //与特权补票同权限
		}
//		if(scheduleAskCondition.getSellway()!=null&&!scheduleAskCondition.getSellway().trim().equals("")){
			//过滤不符合条件的班次/////////////////////////////////////////////////////////////////////////////////////////
			class TimeParameter{
				short preSaleDays ;// 车票预售天数
				short excessSaleMinutes ;//补票截止时间
				short preSaleMinutes ;  //售票截止时间
			}
			Map<Long,TimeParameter> timeParameters = new HashMap<Long,TimeParameter>();
			Ticketoutlets ticketoutlets = (Ticketoutlets)dao.get(Ticketoutlets.class, paramFindScheduleIn.getTicketoutletsId());
			boolean ticketoutlets_in="0".equals(ticketoutlets.getType());
			
			String paramValue = parameterService.findParamValue(ParamterConst.Param_1020, paramFindScheduleIn.getSellOrgID());//报到后才允许售票
			boolean issaleafterreport =ParamterConst.COMMON_FLAG.FALG_YES.equals(paramValue);//报到后售票
	
			String needSameStation = null;
			String needSameRoute = null;
			Ticketsell ticketsell = null;
			Route route = null;
			if("4".equals(paramFindScheduleIn.getSellway())){
				needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, paramFindScheduleIn.getSellOrgID());
				ticketsell = (Ticketsell) dao.get(Ticketsell.class, paramFindScheduleIn.getTicketIdToBeChange());
				
				needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, paramFindScheduleIn.getSellOrgID());
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSameRoute)){
					Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
					route = schedule.getRoute();
				}
			}
			int originatorbeginsaletime =  new Integer(getParameterService().findParamValue(ParamterConst.Param_1034, paramFindScheduleIn.getSellOrgID()));
			for (Iterator iterator = result.iterator(); iterator.hasNext();) {
				ParamDepartSchedule row = (ParamDepartSchedule) iterator.next();
				Long departstationid = row.getDepartstationid();
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSameStation)&&(departstationid!=ticketsell.getDepartstationid()
												||row.getReachstationid()!=ticketsell.getReachstationid())){
					iterator.remove();
					continue;
				}
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSameRoute)&&row.getRouteid()!=route.getId()){
					iterator.remove();
					continue;
				}
				if(paramFindScheduleIn.getSellway()!=null&&!paramFindScheduleIn.getSellway().trim().equals("")){
					if( (
//							(row.getIsoriginator()&&originatorbeginsaletime==0)||
						  (row.getIssaleafterreport()&&originatorbeginsaletime==0)||
						  issaleafterreport
						)
						&&!row.getIsreported()
					  ){
						iterator.remove();
						continue;
					}
					//过路班次提前N分钟开始售票
					if(row.getIssaleafterreport()&&originatorbeginsaletime>0){
						Date departdatetime = DateUtils.mergerDateAndTime(row.getDepartdate(),row.getDeparttime());
						Date now = new Date();
						if(DateUtils.add(now, Calendar.MINUTE, originatorbeginsaletime).before(departdatetime)){
							iterator.remove();
							continue;
						}
					}
				}
				TimeParameter timeParameter = null;
				if(!timeParameters.containsKey(departstationid)){  
					timeParameter = new TimeParameter();
					Organization departOrg = organizationDao.getOrgByStationId(departstationid);
					Long departOrgId=null;
					if (departOrg!=null) {
						departOrgId=departOrg.getId();
					}
					timeParameter.preSaleDays = new Short(getParameterService().findParamValue(ParamterConst.Param_1017, departOrgId));// 车票预售天数
					timeParameter.excessSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1015, departOrgId));//补票截止时间
					if(ticketoutlets_in){
						timeParameter.preSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1018, departOrgId));//站内售票点售票截止时间（距离发班），单位为分钟
					}
					else{
						timeParameter.preSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1019, departOrgId));//站外售票点售票截止时间（距离发班），单位为分钟
					}
					timeParameters.put(departstationid, timeParameter);
				}
				else{
					timeParameter = timeParameters.get(departstationid);
				}
				
				String sellway = paramFindScheduleIn.getSellway();
				if(paramFindScheduleIn.getSellway()==null||paramFindScheduleIn.getSellway().trim().equals("")){
					sellway = "2"; //与特权补票同权限
				}
				if(!SaleDuration.isInTime(sellway,row.getDepartdate(),row.getDeparttime(),
						timeParameter.preSaleDays,timeParameter.preSaleMinutes,timeParameter.excessSaleMinutes,new Date())){
					iterator.remove();
					continue;
				}
			}
		ParamFindSchedulesOut paramFindSchedulesOut = new ParamFindSchedulesOut();
		paramFindSchedulesOut.setResult(MethodResult.SUCCESS);
		paramFindSchedulesOut.setDepartSchedules(result);
		if(paramFindSchedulesOut.getDepartSchedules()!=null
			&&paramFindSchedulesOut.getDepartSchedules().size()>0){
			for (ParamDepartSchedule departSchedule : paramFindSchedulesOut.getDepartSchedules()) {
				//worktype=2时，更新余票数
				if("2".equals(departSchedule.getWorktype())){
					//如果worktype=2(本区配客) 从售票表取余票数
					//根据发车站、到达站查售票表。交叉的座位不可售
					List<Ticketsell> selledseats =findSectionTicketsells(departSchedule.getDepartdate(),departSchedule.getScheduleplanid(),departSchedule.getScheduleid(),departSchedule.getDepartstationid(),departSchedule.getReachstationid(),null);
					departSchedule.setResidueseatnum((short) (departSchedule.getResidueseatnum()+departSchedule.getSoldeatnum()));
					departSchedule.setSoldeatnum((short) 0);
					if(selledseats!=null&&selledseats.size()>0){
						departSchedule.setResidueseatnum((short) (departSchedule.getResidueseatnum()-selledseats.size()));
						departSchedule.setSoldeatnum((short) selledseats.size());
					}
				}
			}
		}
		return paramFindSchedulesOut;
	}

	private List<Ticketsell> findSectionTicketsells(Date departdate,long scheduleplanid,long scheduleid,long departstationid,long reachstationid,Short seatno){
		List<Ticketsell> selledseats = null;
		//取出发车站、到达站在班次停靠点的序号
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", scheduleid));
		propertyFilters.add(new PropertyFilter("EQL_t!stationid", departstationid));
		List<Schedulestop> ssd = dao.find(Schedulestop.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", scheduleid));
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
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleplanid", scheduleplanid);
		selledseats = query.getResultList();
		return selledseats;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TicketSellKernelService#lockSeat(cn.nova.bus.sale.param.ParamLockSeatsIn)
	 */
	@Override
	public ParamLockSeatsOut lockSeat(ParamLockSeatsIn paramLockSeatsIn) throws ServiceException {
		ParamLockSeatsOut result = new ParamLockSeatsOut();
		result.setLockedseats(new ArrayList<ParamLockseatOut>()); //锁定成功座位列表
		Date locktime = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, paramLockSeatsIn.getScheduleplanId());
		MethodResult methodResult = new MethodResult();
		//校验班次状态是否可售
		Organization sellOrg = (Organization) dao.get(Organization.class, paramLockSeatsIn.getSellOrgId());
		methodResult = checkSchedulestatus(paramLockSeatsIn.getSellway(),scheduleplan.getId(),paramLockSeatsIn.getDepartStationId(),sellOrg.getIslocal());
		Schedulestatus schedulestatus = null;
		if (methodResult.getResult()==1){
			schedulestatus = (Schedulestatus) methodResult.getObject();
		}
		else{
			getContext().setRollbackOnly();
			result.setResult(methodResult.getResult());
			result.setResultMsg(methodResult.getResultMsg());
			return result;
		}
		//判断时间是否已经变化
		if(paramLockSeatsIn.getDeparttime()!=null&&!paramLockSeatsIn.getDeparttime().equals("")
			&&!schedulestatus.getDeparttime().equals(paramLockSeatsIn.getDeparttime())){
			getContext().setRollbackOnly();
			result.setResult(115);
			result.setResultMsg(new StringBuilder().append("发车时间不一致：最新的发车时间为").append(schedulestatus.getDeparttime()).toString());
			return result;
		}
		
		//如果是流水班，直接返回
		if(scheduleplan.getIslinework()){
			result.setAutounlocktime(new Date());
			result.setDeparttime(scheduleplan.getStarttime());
			initTickettyes();
			initSeattypes();
			for (ParamLockseatIn lockseatIn : paramLockSeatsIn.getLockseats()) {
				Station departstation = (Station) dao.get(Station.class, paramLockSeatsIn.getDepartStationId());
				Station reachstation = (Station) dao.get(Station.class, paramLockSeatsIn.getReachStationId());
				//校验票价
				methodResult =  checkTickettypeAndPrice(scheduleplan,departstation,reachstation,lockseatIn.getSeattypecode(),lockseatIn.getTickettypecode(),lockseatIn.getPrice());
				if(methodResult.getResult()!=1){
					getContext().setRollbackOnly();
					result.setResult(methodResult.getResult());
					result.setResultMsg(methodResult.getResultMsg());
					return result;
				}
				BigDecimal seatprice = (BigDecimal) methodResult.getObject();
				ParamLockseatOut lockseatOut = new ParamLockseatOut();
				lockseatOut.setPrice(seatprice);
				lockseatOut.setSeatno(0);
				lockseatOut.setSeattypecode(lockseatIn.getSeattypecode());
				lockseatOut.setSeattypename(seattypes.get(lockseatIn.getSeattypecode()));
				lockseatOut.setTickettypecode(lockseatIn.getTickettypecode());
				lockseatOut.setTickettypename(tickettypes.get(lockseatIn.getTickettypecode()));
				result.getLockedseats().add(lockseatOut);
			}
			result.setObject(null);
			result.setOrderno(paramLockSeatsIn.getOrderno());
			result.setResult(MethodResult.SUCCESS);
			result.setResultMsg(null);
			result.setSeatnums(paramLockSeatsIn.getLockseats().size());
			return result;
		}
		//判断此订单号是否已经提交过
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno",paramLockSeatsIn.getOrderno()));
		List<Seatlock> otherseatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		//取锁定时间
		Date unlocktime;
		Organization departorg = organizationDao.getOrgByStationId(paramLockSeatsIn.getDepartStationId());
		try {
			unlocktime = getLockTime(paramLockSeatsIn.getSellway(),otherseatlocks,paramLockSeatsIn.getLocktime(),departorg.getId(),locktime);
		} catch (Exception e) {
			getContext().setRollbackOnly();
			result.setResult(201);
			result.setResultMsg(e.toString());
			return result;
		}

		if(otherseatlocks!=null&&otherseatlocks.size()>0){
			//根据售票方式判断是叠加锁位  还是  重复锁位
			//售票途径:0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票、9单独售保险、10自助售票机售票、11邮政售票
			if(paramLockSeatsIn.getSellway().equals("7")||paramLockSeatsIn.getSellway().equals("10")||paramLockSeatsIn.getSellway().equals("11")){
				//判断重复提交座位数及座位类型是否一致
				Map<String, Integer> seattypenum = new HashMap<String, Integer>();
				for (ParamLockseatIn wsLockSeat : paramLockSeatsIn.getLockseats()) {
					if(seattypenum.containsKey(wsLockSeat.getSeattypecode())){
						seattypenum.put(wsLockSeat.getSeattypecode(), seattypenum.get(wsLockSeat.getSeattypecode())+1);
					}
					else{
						seattypenum.put(wsLockSeat.getSeattypecode(), 1);	
					}
				}
				StringBuilder sql = new StringBuilder();
				sql.append("select ss ")
				.append(" from Scheduleseats ss,Seatlock sl")
				.append(" where ss.scheduleplan.id=sl.id.scheduleplanid")
				.append(" and ss.seatno=sl.id.seatno")
				.append(" and sl.orderno='").append(paramLockSeatsIn.getOrderno()).append("'")
				.append(" order by ss.seattype");
				List<Scheduleseats> scheduleseats = dao.find(sql.toString());
				Map<String, Integer> _seattypenum = new HashMap<String, Integer>();
				for (Scheduleseats scheduleseat : scheduleseats) {
					if(_seattypenum.containsKey(scheduleseat.getSeattype())){
						_seattypenum.put(scheduleseat.getSeattype(), _seattypenum.get(scheduleseat.getSeattype())+1);
					}
					else{
						_seattypenum.put(scheduleseat.getSeattype(), 1);	
					}
				}
				if(seattypenum.size()!=_seattypenum.size()){
					getContext().setRollbackOnly();
					result.setResult(201);
					result.setResultMsg("该订单号为重复提交，但前后提交的座位类型或座位数不一致");
					return result;
				}
				for (String key : seattypenum.keySet()) {
					if(!_seattypenum.containsKey(key)||seattypenum.get(key).intValue()!=_seattypenum.get(key).intValue()){
						getContext().setRollbackOnly();
						result.setResult(201);
						result.setResultMsg("该订单号为重复提交，但前后提交的座位类型或座位数不一致");
						return result;
					}
				}
				//返回之前锁定的座位信息
				initTickettyes();
				initSeattypes();
				for (ParamLockseatIn lockSeateOrderInfo : paramLockSeatsIn.getLockseats()) {
					Station departstation = (Station) dao.get(Station.class, paramLockSeatsIn.getDepartStationId());
					Station reachstation = (Station) dao.get(Station.class, paramLockSeatsIn.getReachStationId());
					ParamLockseatOut lockedSeat = new ParamLockseatOut();
					//校验票价
					methodResult =  checkTickettypeAndPrice(scheduleplan,departstation,reachstation,lockSeateOrderInfo.getSeattypecode(),lockSeateOrderInfo.getTickettypecode(),lockSeateOrderInfo.getPrice());
					if(methodResult.getResult()!=1){
						getContext().setRollbackOnly();
						result.setResult(methodResult.getResult());
						result.setResultMsg(methodResult.getResultMsg());
						return result;
					}
					BigDecimal seatprice = (BigDecimal) methodResult.getObject();
					lockedSeat.setPrice(seatprice);
					lockedSeat.setTickettypecode(lockSeateOrderInfo.getTickettypecode());
					lockedSeat.setTickettypename(tickettypes.get(lockSeateOrderInfo.getTickettypecode()));
					lockedSeat.setSeattypecode(lockSeateOrderInfo.getSeattypecode());
					lockedSeat.setSeattypename(seattypes.get(lockSeateOrderInfo.getSeattypecode()));
					for (Scheduleseats scheduleseat : scheduleseats) {
						boolean hasused = false;
						for (ParamLockseatOut _lockSeateOrderOut : result.getLockedseats()) {
							if(_lockSeateOrderOut.getSeatno().equals((int)scheduleseat.getSeatno())){
								hasused = true;
								break;
							}
						}
						if(hasused){
							continue;
						}
						else{
							lockedSeat.setSeatno((int) scheduleseat.getSeatno());
							break;
						}
					}
					result.getLockedseats().add(lockedSeat);
				}
				result.setDeparttime(schedulestatus.getDeparttime());
				result.setOrderno(paramLockSeatsIn.getOrderno());
				result.setSeatnums(paramLockSeatsIn.getLockseats().size());
				result.setResult(result.SUCCESS);
				result.setResultMsg("该订单号为重复提交");
				return result;
			}
			else{
				//更新已锁座位的解锁时间
				for (Seatlock seatlock : otherseatlocks) {
					seatlock.setAutounlocktime(unlocktime);
					dao.merge(seatlock);
				}
			}
		}

		//开始锁位
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", paramLockSeatsIn.getScheduleplanId()));
		List<Scheduleseats> scheduleseats = dao.find(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
		
		for (ParamLockseatIn paramLockseat : paramLockSeatsIn.getLockseats()) {
			Station departstation = (Station) dao.get(Station.class, paramLockSeatsIn.getDepartStationId());
			Station reachstation = (Station) dao.get(Station.class, paramLockSeatsIn.getReachStationId());

			//校验票价
			methodResult =  checkTickettypeAndPrice(scheduleplan,departstation,reachstation,paramLockseat.getSeattypecode(),paramLockseat.getTickettypecode(),paramLockseat.getPrice());
			if(methodResult.getResult()!=1){
				getContext().setRollbackOnly();
				result.setResult(methodResult.getResult());
				result.setResultMsg(methodResult.getResultMsg());
				return result;
			}
			BigDecimal seatprice = (BigDecimal) methodResult.getObject();
			Scheduleseats scheduleseat = null;
			Integer seatno = paramLockseat.getSeatno();
			if(seatno!=null&&seatno>0){
				//试图按传入的座位号来锁位
				for (Scheduleseats _scheduleseat : scheduleseats) {
					if(_scheduleseat.getSeatno()==seatno){
						scheduleseat = _scheduleseat;
						break;
					}
				}
				//座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位  取数据字典
				if(scheduleseat==null){
					throw new ServiceException("0204");//班次座位记录不存在
				}else if(scheduleseat.getStatus().equals("2")||scheduleseat.getStatus().equals("1")){
					//试图锁定的座位号已售或被他人锁定
					scheduleseat = null;
				}
			}
			
			for (Scheduleseats _scheduleseat : scheduleseats) {
				if(paramLockSeatsIn.getSelectSeatStatus().contains(_scheduleseat.getStatus())
					&&(paramLockseat.getSeattypecode()==null||paramLockseat.getSeattypecode().equals("")||paramLockseat.getSeattypecode().equals(_scheduleseat.getSeattype()))
					){
					scheduleseat = _scheduleseat;
					break;
				}
			}
			if(scheduleseat==null){
				throw new ServiceException("0298");//剩余座位数不够
			}
			Seatlock seatlock = new Seatlock();
			seatlock.setOldstatus(scheduleseat.getStatus());
			scheduleseat.setStatus("1"); //锁定
			SeatlockPK seatlockPK = new SeatlockPK();
			seatlockPK.setScheduleplanid(paramLockSeatsIn.getScheduleplanId());
			seatlockPK.setSeatno(scheduleseat.getSeatno());
			seatlock.setId(seatlockPK);
			seatlock.setLocktime(locktime);
			seatlock.setAutounlocktime(unlocktime);
			seatlock.setDepartdate(scheduleplan.getDepartdate());
			seatlock.setLockby(paramLockSeatsIn.getSellerId());
			if(paramLockSeatsIn.getSellIp()==null||paramLockSeatsIn.getSellIp().equals("")){
				seatlock.setLockip("127.0.0.1");
			}else{
				seatlock.setLockip(paramLockSeatsIn.getSellIp());
			}
			seatlock.setLockorgid(paramLockSeatsIn.getSellOrgId());
			seatlock.setLockticketoutletsid(paramLockSeatsIn.getTicketoutletsid());
			
			seatlock.setOrderno(paramLockSeatsIn.getOrderno());
			seatlock.setScheduleid(scheduleplan.getScheduleid());
			scheduleseat.setUpdateby(paramLockSeatsIn.getSellerId());
			scheduleseat.setUpdatetime(locktime);
			dao.merge(scheduleseat);
			dao.merge(seatlock);
			ParamLockseatOut paramLockedSeat = new ParamLockseatOut();
			paramLockedSeat.setPrice(seatprice);
			paramLockedSeat.setTickettypecode(paramLockseat.getTickettypecode());
			if(paramLockedSeat.getTickettypecode()!=null&&!paramLockedSeat.getTickettypecode().trim().equals("")){
				initTickettyes();
				paramLockedSeat.setTickettypename(tickettypes.get(paramLockedSeat.getTickettypecode()));
			}
			paramLockedSeat.setSeattypecode(scheduleseat.getSeattype());
			if(paramLockedSeat.getSeattypecode()!=null&&!paramLockedSeat.getSeattypecode().trim().equals("")){
				initSeattypes();
				paramLockedSeat.setSeattypename(seattypes.get(paramLockedSeat.getSeattypecode()));
			}
			paramLockedSeat.setSeatno((int) seatlock.getId().getSeatno());
			result.getLockedseats().add(paramLockedSeat);
		}
		result.setDeparttime(schedulestatus.getDeparttime());
		result.setOrderno(paramLockSeatsIn.getOrderno());
		result.setSeatnums(paramLockSeatsIn.getLockseats().size());
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	private MethodResult checkTickettypeAndPrice(Scheduleplan scheduleplan,Station departstation,Station reachstation,String seattype,String tickettype,BigDecimal price){
		MethodResult methodResult = new MethodResult(); 
		Map<String,Ticketprice> ticketprices = new HashMap<String, Ticketprice>();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		initTickettyes();
		initSeattypes();
		if(!tickettypes.containsKey(tickettype)){
			methodResult.setResult(103);
			methodResult.setResultMsg(new StringBuilder().append(departstation.getName()).append("不支持编码为").append(tickettype).append("的票种售票").toString());
			return methodResult;
		}
		if(!checkSeattype(seattype)){
			methodResult.setResult(104);
			methodResult.setResultMsg(new StringBuilder().append(departstation.getName()).append("不支持编码为").append(seattype).append("的座位类型").toString());
			return methodResult;
		}
		if(!ticketprices.containsKey(seattype)){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", departstation.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", reachstation.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", seattype));
			List<Ticketprice> _ticketprices = dao.find(Ticketprice.class,propertyFilters);
			if(_ticketprices==null||_ticketprices.size()==0){
				methodResult.setResult(106);
				methodResult.setResultMsg(new StringBuilder().append("找不到座位类型(").append(seattypes.get(seattype))
						                 .append(")发车站(").append(departstation.getCode()).append(")至(")
										 .append(reachstation.getCode()).append(")的票价").toString());
				return methodResult;
			}
			if(!_ticketprices.get(0).getIssellable()){
				methodResult.setResult(111);
				methodResult.setResultMsg(new StringBuilder().append("座位类型(").append(seattypes.get(seattype))
		                 .append(")发车站(").append(departstation.getCode()).append(")至(")
						 .append(reachstation.getCode()).append(")的票价不可售").toString());
				return methodResult;
			}
			ticketprices.put(seattype, _ticketprices.get(0));
		}
		//校验票价
		BigDecimal _price;
		switch (tickettype.charAt(0)) {
		case 'Q':
			_price = ticketprices.get(seattype).getFullprice();
			break;
		case 'B':
			_price = ticketprices.get(seattype).getFullprice();
			break;
		case 'X':
			_price = ticketprices.get(seattype).getFullprice();
			break;
		default:
			_price = ticketpriceformulaService.getPrice(scheduleplan.getOrgid(), scheduleplan.getDepartdate(), tickettype, ticketprices.get(seattype).getFullprice());
			break;
		}
		if(price!=null){
			if(price.compareTo(_price)!=0){
				methodResult.setResult(107);
				methodResult.setResultMsg("票价不一致");
				return methodResult;
			}
		}
		methodResult.setResult(1);
		methodResult.setObject(_price);
		return methodResult;
	}
	
	private MethodResult checkSchedulestatus(String sellway,long scheduleplanid,long departstationid,boolean isSellByLocalOrg){
		MethodResult methodResult = new MethodResult();
		//检查班次状态
		Schedulestatus schedulestatus = schedulestatusDao.getSchedulestatus(scheduleplanid, departstationid);
		
		if(schedulestatus==null){
			//班次状态记录不存在
			methodResult.setResult(109);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0203"));
			return methodResult;
		}
		else if(schedulestatus.getIsdeparted()){
			boolean canSellDepartedSchedule = false;
			Organization departOrg = organizationDao.getOrgByStationId(departstationid);
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1028, departOrg.getId()))){
				canSellDepartedSchedule = true;
			}
			if(!(sellway.equals("2")&&canSellDepartedSchedule)){
				//该班次已发班
				methodResult.setResult(109);
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0198"));
				return methodResult;
			}
		}
		else if("1".equals(schedulestatus.getStatus())){
			//该班次班次已报停
			methodResult.setResult(109);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0199"));
			return methodResult;
		}
		else if("3".equals(schedulestatus.getStatus())){
			//该班次班次已被并
			methodResult.setResult(109);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0200"));
			return methodResult;
		}
		else if("4".equals(schedulestatus.getStatus())){
			//该班次班次已脱班
			methodResult.setResult(109);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0201"));
			return methodResult;
		}
		else if("5".equals(schedulestatus.getStatus())){
			//该班次班次已停售
			methodResult.setResult(109);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0202"));
			return methodResult;
		}
		
		//检查是否是专营班次
		if(!isSellByLocalOrg&&schedulestatus.getScheduleplan().getIsproprietary()){
			methodResult.setResult(116);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0351"));//该班次为发车站专营班次，不允许售联网票
			return methodResult;
		}
		//验证不可售
		if(!schedulestatus.getScheduleplan().getIssellable()){
			//班次不可售
			methodResult.setResult(110);
			methodResult.setResultMsg("班次不可售");
			return methodResult;
		}
		//报到后可售
		if( (schedulestatus.getScheduleplan().getIsoriginator()
				 || schedulestatus.getScheduleplan().getIssaleafterreport()
				)
				&&!schedulestatus.getIsreported()
			  ){
				methodResult.setResult(117);
				methodResult.setResultMsg("该班次报到后才允许售票");
				return methodResult;
			}
		methodResult.setResult(1);
		methodResult.setObject(schedulestatus);
		return methodResult;
	}
	
	
	private boolean checkSeattype(String seattype){
		boolean result = false;
		initSeattypes();
		for (String _seattype : seattypes.keySet()) {
			if(_seattype.equals(seattype)){
				result = true;
				break;
			}
		}
		return result;
	}
	
	private Map<String,String> seattypes;
	private Map<String,String> tickettypes;
	
	private void initSeattypes(){
		if(seattypes==null){
			seattypes = new HashMap<String, String>();
			List<Digitaldictionarydetail> digitaldictionarydetails;
			digitaldictionarydetails = digitaldictionarydetailDao.find("handprice","seattype");
			for (Digitaldictionarydetail digitaldictionarydetail : digitaldictionarydetails) {
				seattypes.put(digitaldictionarydetail.getCode(), digitaldictionarydetail.getValue());
			}
			
		}
	}
	
	private void initTickettyes(){
		if(tickettypes==null){
			tickettypes = new HashMap<String, String>();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
			propertyFilters.add(new PropertyFilter("GTY_t!orderno", (byte)0));
			List<Tickettype> _tickettypes = dao.find(Tickettype.class,propertyFilters);
			for (Tickettype _tickettype : _tickettypes) {
				tickettypes.put(_tickettype.getCode(), _tickettype.getName());
			}
		}
	}
	
	/**
	 * 根据售票方式、期望锁定时间、发车站所属机构ID取出可锁定时长(秒)
	 * @param sellway 售票方式
	 * @param locktime 锁定时间
	 * @param hopeLockMinute 期望锁定分钟数
	 * @param departOrgId 发车站所属机构ID
	 * @return
	 * @throws Exception
	 */
	private Date getLockTime(String sellway,List<Seatlock> otherseatlocks,float hopeLockMinute,long departOrgId,Date locktime) throws Exception {
		Calendar cld= Calendar.getInstance();
		cld.setTime(locktime);
		int locktimeout=0;
		if(hopeLockMinute>0){
			//TODO 通过售票方式，验证期望锁定时间是否超过限制
			locktimeout=(int) (hopeLockMinute*60);  //订单购票锁位时长，单位为秒钟
		}
		else{
			if(otherseatlocks!=null && otherseatlocks.size()>0){
				locktimeout=new Integer(parameterService.findParamValue(ParamterConst.Param_1009, departOrgId));  //订单购票锁位时长，单位为秒钟
			}
			else{
				locktimeout=new Integer(parameterService.findParamValue(ParamterConst.Param_1008, departOrgId));  //普通购票锁位时长，单位为秒钟
			}
		}
		cld.add(Calendar.SECOND, locktimeout);
		return cld.getTime(); 
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TicketSellKernelService#unlockSeat(java.lang.String, java.lang.Long, java.util.List)
	 */
	@Override
	public ParamUnLockSeatOut unlockSeat(String orderno, Long scheduleplanid,
			List<Short> seatnos) {
		ParamUnLockSeatOut result = new ParamUnLockSeatOut();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno.toString()));
		if(scheduleplanid!=null&&scheduleplanid>0){
			propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", scheduleplanid));
		}
		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(seatlocks!=null){
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
					if(seatlock.getCarrychildnum()!=null&&seatlock.getCarrychildnum()>0){
						Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, seatlock.getId().getScheduleplanid());
						scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-seatlock.getCarrychildnum()));
						dao.merge(scheduleplan);
					}
					dao.delete(seatlock);
				}
			}
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TicketSellKernelService#unlockSeat(java.lang.String, java.lang.Long)
	 */
	@Override
	public ParamUnLockSeatOut unlockSeat(String orderno, Long scheduleplanid) {
		return unlockSeat(orderno,scheduleplanid,null);
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TicketSellKernelService#unlockSeat(java.lang.String)
	 */
	@Override
	public ParamUnLockSeatOut unlockSeat(String orderno) {
		return unlockSeat(orderno,null);
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TicketSellKernelService#sellTicket(cn.nova.bus.sale.param.ParamSellTicketsIn)
	 */
	@Override
	public ParamSellTicketsOut sellTicket(ParamSellTicketsIn order)
			throws Exception {
		ParamSellTicketsOut result = new ParamSellTicketsOut();
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		Long ticketno = new Long(order.getStartTicketNO());
		
		//计算半票数
		int bNum = 0;
		for (Object _ticketPrintInfo : order.getSellseats()) {
			ParamSellTicketIn ticketPrintInfo =  (ParamSellTicketIn) _ticketPrintInfo;
			if("B".equals(ticketPrintInfo.getTickettypeCode())){
				bNum++;
				break;
			}
		}
		Ticketturnoverdetail ticketturnoverdetail = null;
		Billinventory billinventory = null; 
		if(!order.getBillCustomManage()){
			//计算消耗票证数
			int printticketcount = order.getSellseats().size();
			for (Object _ticketPrintInfo : order.getSellseats()) {
				ParamSellTicketIn ticketPrintInfo =  (ParamSellTicketIn) _ticketPrintInfo;
				Ticketprice ticketprice = (Ticketprice) dao.get(Ticketprice.class, ticketPrintInfo.getTicketpriceId());
				Station reachstation = (Station) dao.get(Station.class, ticketprice.getReachstationid());
				if(reachstation.getIsroundtrip()){
					printticketcount++;
				}
			}
			Billinuse billinuse = billinuseService.jumpBillinuse(order.getSellerId(),"Ticket",order.getStartTicketNO(),printticketcount);
			billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
			if(order.getSellerId()>0){
				//插入或修改应缴款表
				ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(order.getSellerId(), order.getStartTicketNO());
				if("0".equals(ticketturnoverdetail.getTicketstartno())){
					ticketturnoverdetail.setTicketstartno(order.getStartTicketNO());
				}
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(ticketno+printticketcount-1).toString(),order.getStartTicketNO().length(), "0"));
				ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getSellseats().size());
				ticketturnoverdetail.setUpdateby(order.getSellerId());
				ticketturnoverdetail.setUpdatetime(now);
				//缴款明细表加字段
				ticketturnoverdetail.setBatchno(billinventory.getBatchno());
				ticketturnoverdetail.setBillinuseid(billinuse.getId());
				ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
			}
		}
		else{
			//校验传入的票号
			StringBuilder sb = new StringBuilder();
			sb.append("select bi from Billinuse bi ")
			.append(" where bi.startno<=").append(ticketno).append(" and bi.endno>=").append(ticketno)
			.append(" and bi.recipients=").append(order.getSellerId());
			List<Billinuse> bis = dao.find(sb.toString());
			if(bis==null||bis.size()==0){
				throw new ServiceException("0170"); //传入的当前票号与数据库不一致
			}
			billinventory = (Billinventory) dao.get(Billinventory.class, bis.get(0).getBillinventoryid()); 
		}

		Map<ParamSellTicketIn,Ticketsell> ticketsells = new HashMap<ParamSellTicketIn, Ticketsell>();
		Scheduleplan scheduleplan_last = null;
		ticketno = ticketno -1;

		Organization sellOrg = (Organization) dao.get(Organization.class, order.getSellOrgId());
		for (Object _sellseat : order.getSellseats()) {
			ParamSellTicketIn sellseat =  (ParamSellTicketIn) _sellseat;
			//校验班次状态是否可售
			Ticketprice ticketprice = (Ticketprice) dao.get(LockModeType.PESSIMISTIC_READ,Ticketprice.class, sellseat.getTicketpriceId());
			Organization organization_depart = (Organization) organizationDao.get(Organization.class, ticketprice.getOrgid());
			float bRate = 1;
			if(bNum>0){
				bRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1036, organization_depart.getId()))/100;
				if(bRate<=0){
					throw new ServiceException("0371"); //半票数超出设定比例		
				}
			}
			float CarrychildRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1012, organization_depart.getId()))/100;
			methodResult = checkSchedulestatus(order.getSellway(),ticketprice.getScheduleplan().getId(),ticketprice.getDepartstationid(),sellOrg.getIslocal());
			Schedulestatus schedulestatus = null;
			if (methodResult.getResult()==1){
				schedulestatus = (Schedulestatus) methodResult.getObject();
			}
			else{
				context.setRollbackOnly();
				result.setResult(methodResult.getResult());
				result.setResultMsg(methodResult.getResultMsg());
				return result;
			}

			//锁定班次并更新剩余票数
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!id", ticketprice.getScheduleplan().getId()));
			Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
			scheduleplan_last = scheduleplan;
			if(!scheduleplan.getIslinework()&&"2".equals(scheduleplan.getWorktype())){
				//如果是非流水班而且是本区配客班次，再次校验座位是否可售
				//根据发车站、到达站查售票表。交叉的座位不可售
				List<Ticketsell> selledseat =findSectionTicketsells(ticketprice.getDepartdate(),scheduleplan.getId(),scheduleplan.getScheduleid(),ticketprice.getDepartstationid(),ticketprice.getReachstationid(),(short) sellseat.getSeatno());
				if(selledseat!=null&&selledseat.size()>0){
					//该座位已经被售出，重新选位
					//查出所有不可售的座位
					List<Ticketsell> selledseats =findSectionTicketsells(ticketprice.getDepartdate(),scheduleplan.getId(),scheduleplan.getScheduleid(),ticketprice.getDepartstationid(),ticketprice.getReachstationid(),null);
					short selseatno = 0; //可售空位
					short beforeSelledSeatno = 0;//前一个已售座位号
					for (Ticketsell ticketsell : selledseats) {
						if(ticketsell.getSeatno()>beforeSelledSeatno+1){
							selseatno = (short) (beforeSelledSeatno+1);
							break;
						}
						beforeSelledSeatno = ticketsell.getSeatno();
					}
					if(selseatno==0&&beforeSelledSeatno>0){
						selseatno = (short) (beforeSelledSeatno+1);
					}
					//如果还没有合适的座位，则返回错误
					if(selseatno==0||selseatno>scheduleplan.getSeatnum()){
						result.setResultMsg("日期:"+sellseat.getDepartDate()+"班次号:"+sellseat.getSchedulecode()+"座位号:"+sellseat.getSeatno()
												+exceptioninfoDao.getExceptioninfo("0205"));//座位不是锁定状态
						getContext().setRollbackOnly();
						return result;
					}else{
						sellseat.setSeatno(selseatno);
					}
				}
			}

			Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleplan.getScheduleid());
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()+1));
			if(sellseat.getCarrychildnum()>0
					&&CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()){
				throw new ServiceException("0270"); //该班次带儿童数量超过最大允许带儿童数量	
			}
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()));
			ticketprice.setSoldeatnum((short) (ticketprice.getSoldeatnum()+1));
			//检验半票百分比
			if(bRate<1&&"B".equals(sellseat.getTickettypeCode())){
				//计算已售半票
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ticketprice.getScheduleplan().getId()));
				propertyFilters.add(new PropertyFilter("EQD_t!departdate", ticketprice.getDepartdate()));
				propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
				propertyFilters.add(new PropertyFilter("EQS_t!tickettype", "B"));
				List<Object> ll = dao.find(Ticketsell.class,propertyFilters);
				int bNumed = ll==null?0:ll.size();
				if(bRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<bNumed+1){
					throw new ServiceException("0371"); //半票数超出设定比例		
				}
			}
			//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
			if(ticketturnoverdetail!=null){
				switch (order.getSellway().charAt(0)) {
				case '4':
					ticketturnoverdetail.setChangeservicefee(ticketturnoverdetail.getChangeservicefee().add(sellseat.getServicefee()));
					break;
				case '6':
					ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(sellseat.getServicefee()));
					break;
				default:
					ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().add(sellseat.getServicefee()));
					break;
				} 
				ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(sellseat.getPrice()).add(sellseat.getServicefee()));
				ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(sellseat.getPrice()));
				
				//0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if("1".equals(order.getPaymethod())){
					ticketturnoverdetail.setNoncashmoney(ticketturnoverdetail.getNoncashmoney().add(sellseat.getPrice()));
					ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
				}
				if("2".equals(order.getPaymethod())||"3".equals(order.getPaymethod())){
					ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().add(sellseat.getPrice()));
				}
			}
			
			Ticketsell ticketsell = new Ticketsell();
			if(!scheduleplan.getIslinework()){
				ticketsell.setSeatno((short) sellseat.getSeatno());
				if(!"2".equals(scheduleplan.getWorktype())
						&&!"3".equals(scheduleplan.getWorktype())){
					//检查座位状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketprice.getScheduleplan().getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!seatno", (short)sellseat.getSeatno()));
					Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
					if(scheduleseat==null){
						//回滚
						throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
													"0204",true); //班次座位记录不存在	
					}
					else if(!"1".equals(scheduleseat.getStatus())){
						throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0205",true); //座位不是锁定状态
					}
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", ticketprice.getScheduleplan().getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!id.seatno", (short)sellseat.getSeatno()));
					Seatlock seatlock = (Seatlock) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatlock.class, propertyFilters);
					if(seatlock==null){
						//回滚
						throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0206",true); //锁位记录不存在	
					}
					if("4".equals(seatlock.getOldstatus())||"5".equals(seatlock.getOldstatus())){
						//检查留座位记录状态
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ticketprice.getScheduleplan().getId()));
						propertyFilters.add(new PropertyFilter("EQR_t!seatno", (short)sellseat.getSeatno()));
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
							throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
									"0207",true); //留座位记录不存在,无法售出留座。
						}
						else{
							if("R".equals(seatreserve.getSellstate())){
								seatreserve.setSellstate("S");
								seatreserve.setUpdateby(order.getSellerId());
								seatreserve.setUpdatetime(now);
								dao.merge(seatreserve);
								if(seatreserve.getCarrychildnum()>0){
									//如果是订票销售  则减去带儿童数
									scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-sellseat.getCarrychildnum()));
								}
								//订票服务费  seatreserve.getServiceprice() = detail.getServicefee()
	//								ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(seatreserve.getServiceprice()));
	//								ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(seatreserve.getServiceprice()));
							}
							else{
								//回滚
								if("C".equals(seatreserve.getSellstate())){
									throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
											"0208",true); //留座位记录状态为已取消,无法售出留座。
								}
								else if("S".equals(seatreserve.getSellstate())){
									throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
											"0209",true); //留座位记录状态为已售,无法售出留座。
								}else{
									context.setRollbackOnly();
									result.setResult(208);
									result.setResultMsg("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno()+"留位状态未知,无法售出留座");
									return result;
								}
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
					scheduleseat.setTickettype(sellseat.getTickettypeCode());
					dao.delete(seatlock);
					scheduleseat.setUpdateby(order.getSellerId());
					scheduleseat.setUpdatetime(now);
					dao.merge(scheduleseat);
				}
			}
			else{
				//流水班次没有留位
				//取已售张数的最大值作为座位号
				Object seatno= dao.uniqueResult("select max(t.seatno) from Ticketsell t where t.scheduleplanid="+ticketprice.getScheduleplan().getId());
				if(seatno==null){
					ticketsell.setSeatno((short) 1);	
				}
				else{					
					ticketsell.setSeatno((short) ((Short)seatno+1));
				}					
				//往回更新
				sellseat.setSeatno(ticketsell.getSeatno());
			}
			ticketprice.setUpdateby(order.getSellerId());
			ticketprice.setUpdatetime(now);
			dao.merge(ticketprice);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketprice.getScheduleplan().getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", sellseat.getSeattypeCode()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			if(ticketprices.size()>1){
				for (Ticketprice _ticketprice : ticketprices){
					_ticketprice.setSoldeatnum(ticketprice.getSoldeatnum());
					_ticketprice.setAutocancelreserveseatnum(ticketprice.getAutocancelreserveseatnum());
					_ticketprice.setUnautocancelreserveseatnum(ticketprice.getUnautocancelreserveseatnum());
					_ticketprice.setUpdateby(order.getSellerId());
					_ticketprice.setUpdatetime(now);
					dao.merge(_ticketprice);
				}
			}
			
			scheduleplan.setUpdateby(order.getSellerId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			ticketsell.setBuspark(schedulestatus.getBuspark());
			ticketsell.setCarrychildnum(sellseat.getCarrychildnum());
			ticketsell.setCheckedby(null);
			ticketsell.setCheckstation(null);
			ticketsell.setChecktime(null);
			ticketsell.setCreateby(order.getSellerId());
			ticketsell.setCreatetime(now);
			if(sellseat.getCustomerid()==null||sellseat.getCustomerid()<=0){
				ticketsell.setCustomer(null);
			}
			else{
				Customer customer = new Customer();
				customer.setId(sellseat.getCustomerid());
				ticketsell.setCustomer(customer);
			}
			ticketsell.setDepartdate(ticketprice.getDepartdate());
			ticketsell.setDepartinvoicesby(null);
			ticketsell.setDepartinvoices(null);
			ticketsell.setDepartinvoicestime(null);
			ticketsell.setDepartstationid(ticketprice.getDepartstationid());
			ticketsell.setDeparttime(schedulestatus.getDeparttime());
			ticketsell.setDiscountrate(sellseat.getPrice().divide(ticketprice.getFullprice(),2, BigDecimal.ROUND_HALF_EVEN));
			ticketsell.setDistance((long) ticketprice.getDistance());
			ticketsell.setFullprice(ticketprice.getFullprice());
			ticketsell.setHandticketoutlets(null);
			ticketsell.setIschecked(false);
			ticketsell.setIsdepartinvoices(false);
			ticketsell.setIslinework(scheduleplan.getIslinework());
			ticketsell.setOrgid(sellOrg.getId());
			ticketsell.setPaymethod(order.getPaymethod());
			ticketsell.setPrice(sellseat.getPrice());
			ticketsell.setMoreprice(ticketprice.getMoreprice());
			ticketsell.setServicefee(sellseat.getServicefee());
			ticketsell.setReachstationid(ticketprice.getReachstationid());
			ticketsell.setScheduleid(scheduleplan.getScheduleid());
			ticketsell.setScheduleplanid(ticketprice.getScheduleplan().getId());
			ticketsell.setSellby(order.getSellerId());
			if(order.getSellIp()==null||order.getSellIp().equals("")){
				ticketsell.setSellip("127.0.0.1");
			}else{
				ticketsell.setSellip(order.getSellIp());
			}
			ticketsell.setSelltime(now);
			ticketsell.setSellway(order.getSellway());
			if(billinventory==null){
				ticketsell.setBatchno("");
			}else{
				ticketsell.setBatchno(billinventory.getBatchno());
			}
			ticketsell.setTicketentrance(schedulestatus.getTicketentrance());
			ticketno=ticketno+1;
			ticketsell.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
			ticketsell.setTicketoutletsid(order.getTicketoutletsid());
			ticketsell.setTicketoutletsname(order.getTicketoutletsname());
			ticketsell.setTicketstatus("0"); //正常
			ticketsell.setTickettype(sellseat.getTickettypeCode());
			ticketsell.setUpdateby(order.getSellerId());
			ticketsell.setUpdatetime(now);
			ticketsell.setSeattype(sellseat.getSeattypeCode());
			ticketsell.setToplimitprice(ticketprice.getToplimitprice());
			//取票价组成项费用
			//ticketsell.setFueladditionfee(ticketprice.getFueladditionfee());
			DeductInfo deductInfo = balancedeductService.getDeductfee(ticketsell);
			ticketsell.setFueladditionfee(deductInfo.getFueladditionfee());
			ticketsell.setStationservicefee(deductInfo.getStationfee());
			ticketsell.setComputefee(deductInfo.getComputefee());
			ticketsell.setCoolairfee(deductInfo.getCoolairfee());
			ticketsell.setAdditionfee(deductInfo.getAdditionfee());
			ticketsell.setWaterfee(deductInfo.getWaterfee());
			ticketsell.setInsurefee(deductInfo.getInsurefee());
			ticketsell.setOtherfee(deductInfo.getOtherfee());
			if(ticketturnoverdetail!=null){
				ticketsell.setTurnoverdetailid(ticketturnoverdetail.getId());
				ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().add(ticketsell.getFueladditionfee()));
				ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee().add(ticketsell.getStationservicefee()));
				ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().add(ticketsell.getComputefee()));
				ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().add(ticketsell.getCoolairfee()));
				ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().add(ticketsell.getAdditionfee()));
				ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().add(ticketsell.getWaterfee()));
				ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().add(ticketsell.getInsurefee()));
				ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().add(ticketsell.getOtherfee()));	
			}
			ticketsell.setOrderno(order.getOrderno());
			ticketsell = (Ticketsell) dao.merge(ticketsell);
//			detail.setId(ticketsell.getId());
			dao.getEntityManager().flush();
			ticketsells.put(sellseat,ticketsell);
			//如果到站为往返站点
			Station reachstation = (Station) dao.get(Station.class, ticketprice.getReachstationid());
			if(reachstation.getIsroundtrip()){
				Returntripticket returntripticket = new Returntripticket();
				if(billinventory==null){
					returntripticket.setBatchno("");
				}else{
					returntripticket.setBatchno(billinventory.getBatchno());
				}
				ticketno=ticketno+1;
				returntripticket.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
				returntripticket.setIsselfschedule(true);
				returntripticket.setSellid(ticketsell.getId());
				dao.merge(returntripticket);
				if(ticketturnoverdetail!=null){
					ticketturnoverdetail.setSellreturntripnum(ticketturnoverdetail.getSellreturntripnum()+1);
				}
			}

		}

		if(!scheduleplan_last.getIslinework()&&"3".equals(scheduleplan_last.getWorktype())){
			//到中心售票 
			Organization localorg =  (Organization) organizationDao.get(Organization.class, scheduleplan_last.getOrgid());
			
//			NetScheduleTicketSellService netScheduleTicketSellService = getCentreInterface(methodResult,localorg);
//			
//			if(netScheduleTicketSellService==null){
//				context.setRollbackOnly();
//				result.setResult(methodResult.getResult());
//				result.setResultMsg(methodResult.getResultMsg());
//				return result;
//			}
			TicketOrder _order = ConvertSellTicketIn(order,ticketsells.values());
//			methodResult = netScheduleTicketSellService.sellTicket(_order);
			
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("order", JsonUtil.toFormatString(_order));
			Organization centreOrg = organizationService.getDirectlyParentOrg(localorg);
			//方法不可用  SCHEDULE_SELL_TICKET做了修改
			//methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.SCHEDULE_SELL_TICKET, requestMap);		
			methodResult.setResultMsg("方法不可用！");
			methodResult.setResult(MethodResult.FAILURE);
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				context.setRollbackOnly();
				result.setResult(methodResult.getResult());
				result.setResultMsg(methodResult.getResultMsg());
				return result;
			}
			//根据售票结果更新座位号
			List<TicketPrintInfo> _ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			int i=0;
			for (ParamSellTicketIn paramSellTicketIn : ticketsells.keySet()) {
				paramSellTicketIn.setSeatno(_ticketPrintInfos.get(i).getSeatno());
				ticketsells.get(paramSellTicketIn).setSeatno((short) paramSellTicketIn.getSeatno());//更新座位号
				dao.merge(ticketsells.get(paramSellTicketIn));
				i++;
			}
		}
		List<ParamSellTicketOut> selledtickets = new ArrayList<ParamSellTicketOut>();
	
//		for (Ticketsell ticketsell : ticketsells.values()) {
//			selledtickets.add(getTicketPrintInfo(ticketsell.getId()));
//		}
		for (cn.nova.bus.sale.remote.param.ParamSellTicketIn paramSellTicketIn : order.getSellseats()) {
			selledtickets.add(getTicketPrintInfo(ticketsells.get(paramSellTicketIn).getId()));
		}

		
		if(ticketturnoverdetail!=null){
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}
		result.setResult(MethodResult.SUCCESS);
		result.setSelledtickets(selledtickets);
		return result;
	}
	
	private TicketOrder ConvertSellTicketIn(ParamSellTicketsIn order,Collection<Ticketsell> stationselledtickets){
		TicketOrder _order = new TicketOrder();
		_order.setBatchno(order.getBatchno());
		_order.setIp(order.getSellIp());
		
		Userinfo seller = (Userinfo) dao.get(Userinfo.class, order.getSellerId());
		_order.setSeller(order.getSellerId());
		_order.setSellername(seller.getName());
		_order.setSellway(order.getSellway());
		_order.setStartTicketNO(order.getStartTicketNO());
		Ticketoutlets ticketoutlets = (Ticketoutlets) dao.get(Ticketoutlets.class, order.getTicketoutletsid());
		_order.setTicketoutletsid(order.getTicketoutletsid());
		_order.setTicketoutletsname(ticketoutlets.getName());
		List<TicketPrintInfo> tickets = new ArrayList<TicketPrintInfo>();
		BigDecimal totalmoney = new BigDecimal(0);
		int i=0;
		Iterator<Ticketsell> selledTicketIterator = stationselledtickets.iterator();
		while(selledTicketIterator.hasNext()){
			Ticketsell selledTicket = selledTicketIterator.next();
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, selledTicket.getScheduleplanid());
			Organization departorg = (Organization) dao.get(Organization.class, scheduleplan.getOrgid());
			ParamSellTicketIn sellseat =  (ParamSellTicketIn) order.getSellseats().get(i);
			_order.setDepartstationcode(sellseat.getDepartStationCode());
			_order.setOrgid(selledTicket.getOrgid());
			
			TicketPrintInfo ticket = new TicketPrintInfo();
			ticket.setAdditionfee(selledTicket.getAdditionfee());
			ticket.setBuspark(selledTicket.getBuspark());
			ticket.setCarrychildnum(selledTicket.getCarrychildnum());
			ticket.setCertificateno(sellseat.getCertificateno());
			ticket.setCertificatetype(sellseat.getCertificatetype());
			ticket.setComputefee(selledTicket.getComputefee());
			ticket.setCoolairfee(selledTicket.getCoolairfee());
			ticket.setCustomerid(null);
			ticket.setDepartdate(selledTicket.getDepartdate());
			ticket.setDepartorgcode(departorg.getCode());
			ticket.setDepartstationcode(sellseat.getDepartStationCode());
//			ticket.setDepartstationid(departstationid);
//			ticket.setDepartstationname(departstationname);
			ticket.setDeparttime(selledTicket.getDeparttime());
			ticket.setDiscountrate(selledTicket.getDiscountrate());
			ticket.setDistance(selledTicket.getDistance());
//			ticket.setEndstationname(endstationname);
//			ticket.setEticketid(eticketid);
			ticket.setFueladditionfee(selledTicket.getFueladditionfee());
			ticket.setFullprice(selledTicket.getFullprice());
//			ticket.setHandticketoutletsid(handticketoutletsid);
//			ticket.setId(id);
			ticket.setInsurefee(selledTicket.getInsurefee());
			ticket.setIslinework(selledTicket.getIslinework());
			ticket.setIsovertime(scheduleplan.getIsovertime());
//			ticket.setIsroundtrip();
			ticket.setMoreprice(selledTicket.getMoreprice());
//			ticket.setOpertype(opertype);
//			ticket.setOrgid(orgid);
			ticket.setOtherfee(selledTicket.getOtherfee());
			ticket.setPaymethod(selledTicket.getPaymethod());
//			ticket.setPlanbrandmodel(planbrandmodel);
//			ticket.setPlanunitname(planunitname);
//			ticket.setPlanvehiclegrade(planvehiclegrade);
//			ticket.setPlanvehicleno(planvehicleno);
//			ticket.setPlanvehicletype(planvehicletype);
//			ticket.setPlanvehicletypecustomname(planvehicletypecustomname);
			ticket.setPrice(selledTicket.getPrice());
			ticket.setReachstationcode(sellseat.getReachStationCode());
//			ticket.setReachstationid(reachstationid);
//			ticket.setReachstationname(reachstationname);
//			ticket.setReachstationsecondname(reachstationsecondname);
//			ticket.setReturntripvaliddays();
//			ticket.setRoutename(routename);
			ticket.setSchedulecode(sellseat.getSchedulecode());
//			ticket.setScheduleid(scheduleid);
//			ticket.setScheduleplanid(scheduleplanid);
//			ticket.setScheduleremarks(scheduleremarks);
			ticket.setSchedulesynccode(sellseat.getSchedulesynccode());
			ticket.setSeatno(selledTicket.getSeatno());
			ticket.setSeatnostr((new Short(selledTicket.getSeatno())).toString());
			ticket.setSeattype(selledTicket.getSeattype());
			ticket.setServicefee(selledTicket.getServicefee());
//			ticket.setStartstationname(startstationname);
			ticket.setStationservicefee(selledTicket.getStationservicefee());
			ticket.setTicketentrance(selledTicket.getTicketentrance());
			ticket.setTicketno(selledTicket.getTicketno());
			ticket.setTickettype(selledTicket.getTickettype());
			ticket.setToplimitprice(selledTicket.getToplimitprice());
			ticket.setWaterfee(selledTicket.getWaterfee());
			ticket.setWorkways(scheduleplan.getWorkways());
			i++;
			tickets.add(ticket);
		}
		_order.setTickets(tickets);
		_order.setTotalmoney(totalmoney);
		_order.setVipcardno(null);
		_order.setVipgrade(null);
		_order.setVipmoney(null);
		_order.setVippoint(null);
		return _order;
	}
	
//	private NetScheduleTicketSellService getCentreInterface(MethodResult methodResult,Organization localorg){
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
	
	@Override
	public ParamSellTicketsOut ticketRePrintAndChangeTicketNo(
			long ticketsellid, String curTicketNo,long userid,long ticketoutletsid,String ip) throws ServiceException {
		ParamSellTicketsOut result = new ParamSellTicketsOut();
		result.setSelledtickets(new ArrayList<ParamSellTicketOut>());
		Date now = new Date();
		//只有售票人或者换票人才允许重打
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!id", ticketsellid));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
		//判断售票人
		if(ticketsell.getSellby()!=0&&ticketsell.getSellby()!=userid){
			//换票号重打车票不允许重打他人售出的车票
			throw new ServiceException("0344");
		}
		else if(ticketsell.getSellby()==0){
			//判断是否是电子票
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsellid));
			Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
			if(ticketsellother==null){
				//换票号重打车票不允许重打他人售出的车票
				throw new ServiceException("0344");
			}
			else if(!ticketsellother.getIstaked()){
				//该电子票还没有取票，不允许重打车票
				throw new ServiceException("0346");
			}
			else if (ticketsellother.getPrintby()!=userid){
				//电子票换票号重打车票不允许重打他人取出的电子票
				throw new ServiceException("0350");
			}
		}
		//校验当前票号
		Billinuse billinuse = billinuseService.jumpBillinuse(userid,"Ticket",curTicketNo,1);
		Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
		
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(userid, curTicketNo);
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

			//原票号生成坏票登记记录
			billdamaged_returntripticket = new Billdamaged();
			billdamaged_returntripticket.setAmount(1);
			billdamaged_returntripticket.setBillinuseid(billinuse.getId());
			billdamaged_returntripticket.setBilltypeid(billinuse.getBilltypeid());
			billdamaged_returntripticket.setCreateby(userid);
			billdamaged_returntripticket.setCreatetime(now);
			billdamaged_returntripticket.setDamageddscribe("换票号重打车票做废原返程票号！");
			billdamaged_returntripticket.setEndno(new Long(returntripticket.getTicketno()));
			billdamaged_returntripticket.setRecordby(userid);
			if(ip==null||ip.trim().equals("")){
				billdamaged_returntripticket.setRecordip("127.0..0.1");
			}else{
				billdamaged_returntripticket.setRecordip(ip);
			}
			billdamaged_returntripticket.setRecordtime(billdamaged_returntripticket.getCreatetime());
			billdamaged_returntripticket.setStartno(new Long(returntripticket.getTicketno()));
			billdamaged_returntripticket.setTicketoutletsid(ticketoutletsid);
			billdamaged_returntripticket.setUpdateby(userid);
			billdamaged_returntripticket.setUpdatetime(now);
			billdamaged_returntripticket.setTurnoverdetailid(ticketturnoverdetail.getId());
		}
		else{
			ticketturnoverdetail.setTicketendno(curTicketNo);
		}

		ticketturnoverdetail.setUpdateby(userid);
		ticketturnoverdetail.setUpdatetime(now);
		ticketturnoverdetail.setBilldamagednum(ticketturnoverdetail.getBilldamagednum()+1);
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		if(billdamaged_returntripticket!=null){
			dao.merge(billdamaged_returntripticket);
		}
		//原售票号生成坏票登记记录
		Billdamaged billdamaged = new Billdamaged();
		billdamaged.setAmount(1);
		billdamaged.setBillinuseid(billinuse.getId());
		billdamaged.setBilltypeid(billinuse.getBilltypeid());
		billdamaged.setCreateby(userid);
		billdamaged.setCreatetime(now);
		billdamaged.setDamageddscribe("换票号重打车票做废原票号！");
		billdamaged.setEndno(new Long(ticketsell.getTicketno()));
		billdamaged.setRecordby(userid);
		if(ip==null||ip.trim().equals("")){
			billdamaged.setRecordip("127.0..0.1");
		}else{
			billdamaged.setRecordip(ip);
		}
		billdamaged.setRecordtime(billdamaged.getCreatetime());
		billdamaged.setStartno(new Long(ticketsell.getTicketno()));
		billdamaged.setTicketoutletsid(ticketoutletsid);
		billdamaged.setUpdateby(userid);
		billdamaged.setUpdatetime(now);
		billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
		dao.merge(billdamaged);
		//修改票号
		ticketsell.setTicketno(curTicketNo);
		ticketsell.setBatchno(billinventory.getBatchno());
		ticketsell.setUpdateby(userid);
		ticketsell.setUpdatetime(now);
		dao.merge(ticketsell);
		
		//返回打印信息
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!id", ticketsellid));
		result.getSelledtickets().add(getTicketPrintInfo(ticketsellid));
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	
	private ParamSellTicketOut getTicketPrintInfo(long ticketsellid){
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class,ticketsellid);
		ParamSellTicketOut result = new ParamSellTicketOut();

		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, ticketsell.getScheduleplanid());
		Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
		Route route = schedule.getRoute();
		
		Station departStation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
		Organization departOrg = organizationDao.getOrgByStationId(departStation.getId());
		Station reachStation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
		Station startStation = (Station) dao.get(Station.class, route.getStartstationid());
		Station endStation = (Station) dao.get(Station.class, route.getEndstationid());

		List<PropertyFilter> _propertyFilters = new ArrayList<PropertyFilter>();
		_propertyFilters.clear();
		_propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",ticketsell.getScheduleplanid()));
		_propertyFilters.add(new PropertyFilter("EQR_t!orderno",(short)0));
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = (Schedulevehiclepeopleplan) dao.uniqueResult(Schedulevehiclepeopleplan.class, _propertyFilters);
		
		result.setAdditionfee(ticketsell.getAdditionfee());
		result.setBuspark(ticketsell.getBuspark());
		result.setCarrychildnum(ticketsell.getCarrychildnum());
		if(ticketsell.getCustomer()!=null){
			result.setCertificateno(ticketsell.getCustomer().getCertificateno());
			result.setCertificatetype(ticketsell.getCustomer().getCertificatetype());
			result.setCustomername(ticketsell.getCustomer().getName());
		}
		result.setComputefee(ticketsell.getComputefee());
		result.setCoolairfee(ticketsell.getCoolairfee());
		result.setDepartDate(ticketsell.getDepartdate());
		result.setDepartStationCode(departStation.getCode());
		result.setDepartStationName(departStation.getName());
		result.setDeparttime(ticketsell.getDeparttime());
		result.setDiscountrate(ticketsell.getDiscountrate());
		result.setDistance(ticketsell.getDistance());
		result.setEndStationName(endStation.getName());
		result.setFueladditionfee(ticketsell.getFueladditionfee());
		result.setFullprice(ticketsell.getFullprice());
		result.setInsurefee(ticketsell.getInsurefee());
		result.setIslinework(ticketsell.getIslinework());
		result.setIsovertime(scheduleplan.getIslinework());
		result.setIsroundtrip(reachStation.getIsroundtrip());
		result.setMoreprice(ticketsell.getMoreprice());
		result.setOrderno(ticketsell.getOrderno());
		result.setOtherfee(ticketsell.getOtherfee());
		result.setPaymethod(ticketsell.getPaymethod());
		Vehiclebrandmodel vehiclebrandmodel = (Vehiclebrandmodel) dao.get(Vehiclebrandmodel.class, schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());
		result.setPlanbrandmodel(vehiclebrandmodel.getBrandname()+vehiclebrandmodel.getModelcode());
		if(schedulevehiclepeopleplan.getPlanunit()!=null){
		  result.setPlanunitname(schedulevehiclepeopleplan.getPlanunit().getName());
		}
		Vehicle vehicle = schedulevehiclepeopleplan.getPlanvehicle();
		if(vehicle!=null){
			result.setPlanvehicleno(vehicle.getVehicleno());
		}
		Vehicletype vehicletype = (Vehicletype) dao.get(Vehicletype.class, schedulevehiclepeopleplan.getPlanvehicletypeid());
		result.setPlanvehiclegrade(vehicletype.getGrade());
		result.setPlanvehicletype(vehicletype.getType());
		result.setPlanvehicletypecustomname(vehicletype.getCustomname());
		
		result.setPrice(ticketsell.getPrice());
		result.setReachStationCode(reachStation.getCode());
		result.setReachStationName(reachStation.getName());
		result.setReachStationSecondName(reachStation.getSecondname());
		result.setReturntripvaliddays(route.getReturntripvaliddays());
		result.setRouteName(route.getName());
		result.setScheduleCode(schedule.getCode());
		result.setScheduleremarks(schedule.getRemarks());
		result.setScheduleSyncSode(schedule.getSynccode());
		result.setSeatno(ticketsell.getSeatno());
		//TODO 按座位图取备注
		result.setSeatnostr(new Short(ticketsell.getSeatno()).toString());
		result.setSeattypeCode(ticketsell.getSeattype());
		initSeattypes();
		result.setSeattypeName(seattypes.get(ticketsell.getSeattype()));
		result.setServicefee(ticketsell.getServicefee());
		result.setStartStationName(startStation.getName());
		result.setStationservicefee(ticketsell.getStationservicefee());
		result.setTicketentrance(ticketsell.getTicketentrance());
		result.setTicketno(ticketsell.getTicketno());
		result.setTicketsellid(ticketsell.getId());
		result.setTickettypeCode(ticketsell.getTickettype());
		initTickettyes();
		result.setTickettypeName(tickettypes.get(ticketsell.getTickettype()));
		result.setToplimitprice(ticketsell.getToplimitprice());
		result.setWaterfee(ticketsell.getWaterfee());
		//取数据字典
		result.setWorkways(dictionaryService.getColumnValue("schedule", "workways", scheduleplan.getWorkways()));
		return result;
	}
	
	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	public ParameterService getParameterService() {
		return parameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public BillinuseService getBillinuseService() {
		return billinuseService;
	}

	public void setBillinuseService(BillinuseService billinuseService) {
		this.billinuseService = billinuseService;
	}

	public TicketreturnService getTicketreturnService() {
		return ticketreturnService;
	}

	public void setTicketreturnService(TicketreturnService ticketreturnService) {
		this.ticketreturnService = ticketreturnService;
	}

	public BalancedeductService getBalancedeductService() {
		return balancedeductService;
	}

	public void setBalancedeductService(BalancedeductService balancedeductService) {
		this.balancedeductService = balancedeductService;
	}

	public TicketturnoverdetailService getTicketturnoverdetailService() {
		return ticketturnoverdetailService;
	}

	public void setTicketturnoverdetailService(
			TicketturnoverdetailService ticketturnoverdetailService) {
		this.ticketturnoverdetailService = ticketturnoverdetailService;
	}

	public UserinfoDao getUserinfoDao() {
		return userinfoDao;
	}

	public void setUserinfoDao(UserinfoDao userinfoDao) {
		this.userinfoDao = userinfoDao;
	}

	public BilltypeService getBilltypeService() {
		return billtypeService;
	}

	public void setBilltypeService(BilltypeService billtypeService) {
		this.billtypeService = billtypeService;
	}

	public SessionContext getContext() {
		return context;
	}

	public void setContext(SessionContext context) {
		this.context = context;
	}

	public DictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}

	@Override
	public ParamSellTicketsOut SellReceipt(ParamSellTicketsIn order)
			throws Exception {
		ParamSellTicketsOut result = new ParamSellTicketsOut();
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		Long ticketno = new Long(order.getStartTicketNO());
		
		//计算半票数
		int bNum = 0;
		for (Object _ticketPrintInfo : order.getSellseats()) {
			ParamSellTicketIn ticketPrintInfo =  (ParamSellTicketIn) _ticketPrintInfo;
			if("B".equals(ticketPrintInfo.getTickettypeCode())){
				bNum++;
				break;
			}
		}
		Ticketturnoverdetail ticketturnoverdetail = null;
		Billinventory billinventory = null; 
		if(!order.getBillCustomManage()){
			//计算消耗票证数
			int printticketcount = order.getSellseats().size();
			for (Object _ticketPrintInfo : order.getSellseats()) {
				ParamSellTicketIn ticketPrintInfo =  (ParamSellTicketIn) _ticketPrintInfo;
				Ticketprice ticketprice = (Ticketprice) dao.get(Ticketprice.class, ticketPrintInfo.getTicketpriceId());
				Station reachstation = (Station) dao.get(Station.class, ticketprice.getReachstationid());
				if(reachstation.getIsroundtrip()){
					printticketcount++;
				}
			}
			Billinuse billinuse = billinuseService.jumpBillinuse(order.getSellerId(),"Ticket",order.getStartTicketNO(),printticketcount);
			billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
			if(order.getSellerId()>0){
				//插入或修改应缴款表
				ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(order.getSellerId(), order.getStartTicketNO());
				if("0".equals(ticketturnoverdetail.getTicketstartno())){
					ticketturnoverdetail.setTicketstartno(order.getStartTicketNO());
				}
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(ticketno+printticketcount-1).toString(),order.getStartTicketNO().length(), "0"));
				ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getSellseats().size());
				ticketturnoverdetail.setUpdateby(order.getSellerId());
				ticketturnoverdetail.setUpdatetime(now);
				//缴款明细表加字段
				ticketturnoverdetail.setBatchno(billinventory.getBatchno());
				ticketturnoverdetail.setBillinuseid(billinuse.getId());
				ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
			}
		}
		else{
			//校验传入的票号
			StringBuilder sb = new StringBuilder();
			sb.append("select bi from Billinuse bi ")
			.append(" where bi.startno<=").append(ticketno).append(" and bi.endno>=").append(ticketno)
			.append(" and bi.recipients=").append(order.getSellerId());
			List<Billinuse> bis = dao.find(sb.toString());
			if(bis==null||bis.size()==0){
				throw new ServiceException("0170"); //传入的当前票号与数据库不一致
			}
			billinventory = (Billinventory) dao.get(Billinventory.class, bis.get(0).getBillinventoryid()); 
		}

		Map<ParamSellTicketIn,Ticketsell> ticketsells = new HashMap<ParamSellTicketIn, Ticketsell>();
		Scheduleplan scheduleplan_last = null;
		ticketno = ticketno -1;

		Organization sellOrg = (Organization) dao.get(Organization.class, order.getSellOrgId());
		for (Object _sellseat : order.getSellseats()) {
			ParamSellTicketIn sellseat =  (ParamSellTicketIn) _sellseat;
			//校验班次状态是否可售
			Ticketprice ticketprice = (Ticketprice) dao.get(LockModeType.PESSIMISTIC_READ,Ticketprice.class, sellseat.getTicketpriceId());
			Organization organization_depart = (Organization) organizationDao.get(Organization.class, ticketprice.getOrgid());
			float bRate = 1;
			if(bNum>0){
				bRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1036, organization_depart.getId()))/100;
				if(bRate<=0){
					throw new ServiceException("0371"); //半票数超出设定比例		
				}
			}
			float CarrychildRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1012, organization_depart.getId()))/100;
			methodResult = checkSchedulestatus(order.getSellway(),ticketprice.getScheduleplan().getId(),ticketprice.getDepartstationid(),sellOrg.getIslocal());
			Schedulestatus schedulestatus = null;
			if (methodResult.getResult()==1){
				schedulestatus = (Schedulestatus) methodResult.getObject();
			}
			else{
				context.setRollbackOnly();
				result.setResult(methodResult.getResult());
				result.setResultMsg(methodResult.getResultMsg());
				return result;
			}

			//锁定班次并更新剩余票数
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!id", ticketprice.getScheduleplan().getId()));
			Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
			scheduleplan_last = scheduleplan;
			if(!scheduleplan.getIslinework()&&"2".equals(scheduleplan.getWorktype())){
				//如果是非流水班而且是本区配客班次，再次校验座位是否可售
				//根据发车站、到达站查售票表。交叉的座位不可售
				List<Ticketsell> selledseat =findSectionTicketsells(ticketprice.getDepartdate(),scheduleplan.getId(),scheduleplan.getScheduleid(),ticketprice.getDepartstationid(),ticketprice.getReachstationid(),(short) sellseat.getSeatno());
				if(selledseat!=null&&selledseat.size()>0){
					//该座位已经被售出，重新选位
					//查出所有不可售的座位
					List<Ticketsell> selledseats =findSectionTicketsells(ticketprice.getDepartdate(),scheduleplan.getId(),scheduleplan.getScheduleid(),ticketprice.getDepartstationid(),ticketprice.getReachstationid(),null);
					short selseatno = 0; //可售空位
					short beforeSelledSeatno = 0;//前一个已售座位号
					for (Ticketsell ticketsell : selledseats) {
						if(ticketsell.getSeatno()>beforeSelledSeatno+1){
							selseatno = (short) (beforeSelledSeatno+1);
							break;
						}
						beforeSelledSeatno = ticketsell.getSeatno();
					}
					if(selseatno==0&&beforeSelledSeatno>0){
						selseatno = (short) (beforeSelledSeatno+1);
					}
					//如果还没有合适的座位，则返回错误
					if(selseatno==0||selseatno>scheduleplan.getSeatnum()){
						result.setResultMsg("日期:"+sellseat.getDepartDate()+"班次号:"+sellseat.getSchedulecode()+"座位号:"+sellseat.getSeatno()
												+exceptioninfoDao.getExceptioninfo("0205"));//座位不是锁定状态
						getContext().setRollbackOnly();
						return result;
					}else{
						sellseat.setSeatno(selseatno);
					}
				}
			}

			Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleplan.getScheduleid());
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()+1));
			if(sellseat.getCarrychildnum()>0
					&&CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()){
				throw new ServiceException("0270"); //该班次带儿童数量超过最大允许带儿童数量	
			}
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()));
			ticketprice.setSoldeatnum((short) (ticketprice.getSoldeatnum()+1));
			//检验半票百分比
			if(bRate<1&&"B".equals(sellseat.getTickettypeCode())){
				//计算已售半票
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ticketprice.getScheduleplan().getId()));
				propertyFilters.add(new PropertyFilter("EQD_t!departdate", ticketprice.getDepartdate()));
				propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
				propertyFilters.add(new PropertyFilter("EQS_t!tickettype", "B"));
				List<Object> ll = dao.find(Ticketsell.class,propertyFilters);
				int bNumed = ll==null?0:ll.size();
				if(bRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<bNumed+1){
					throw new ServiceException("0371"); //半票数超出设定比例		
				}
			}
			//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
			if(ticketturnoverdetail!=null){
				switch (order.getSellway().charAt(0)) {
				case '4':
					ticketturnoverdetail.setChangeservicefee(ticketturnoverdetail.getChangeservicefee().add(sellseat.getServicefee()));
					break;
				case '6':
					ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(sellseat.getServicefee()));
					break;
				default:
					ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().add(sellseat.getServicefee()));
					break;
				} 
				ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(sellseat.getPrice()).add(sellseat.getServicefee()));
				ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(sellseat.getPrice()));
				
				//0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if("1".equals(order.getPaymethod())){
					ticketturnoverdetail.setNoncashmoney(ticketturnoverdetail.getNoncashmoney().add(sellseat.getPrice()));
					ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
				}
				if("2".equals(order.getPaymethod())||"3".equals(order.getPaymethod())){
					ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().add(sellseat.getPrice()));
				}
			}
			
			Ticketsell ticketsell = new Ticketsell();
			if(!scheduleplan.getIslinework()){
				ticketsell.setSeatno((short) sellseat.getSeatno());
				if(!"2".equals(scheduleplan.getWorktype())
						&&!"3".equals(scheduleplan.getWorktype())){
					//检查座位状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketprice.getScheduleplan().getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!seatno", (short)sellseat.getSeatno()));
					Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
					if(scheduleseat==null){
						//回滚
						throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
													"0204",true); //班次座位记录不存在	
					}
					else if(!"1".equals(scheduleseat.getStatus())){
						throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0205",true); //座位不是锁定状态
					}
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", ticketprice.getScheduleplan().getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!id.seatno", (short)sellseat.getSeatno()));
					Seatlock seatlock = (Seatlock) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatlock.class, propertyFilters);
					if(seatlock==null){
						//回滚
						throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0206",true); //锁位记录不存在	
					}
					if("4".equals(seatlock.getOldstatus())||"5".equals(seatlock.getOldstatus())){
						//检查留座位记录状态
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ticketprice.getScheduleplan().getId()));
						propertyFilters.add(new PropertyFilter("EQR_t!seatno", (short)sellseat.getSeatno()));
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
							throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
									"0207",true); //留座位记录不存在,无法售出留座。
						}
						else{
							if("R".equals(seatreserve.getSellstate())){
								seatreserve.setSellstate("S");
								seatreserve.setUpdateby(order.getSellerId());
								seatreserve.setUpdatetime(now);
								dao.merge(seatreserve);
								if(seatreserve.getCarrychildnum()>0){
									//如果是订票销售  则减去带儿童数
									scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-sellseat.getCarrychildnum()));
								}
								//订票服务费  seatreserve.getServiceprice() = detail.getServicefee()
	//								ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(seatreserve.getServiceprice()));
	//								ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(seatreserve.getServiceprice()));
							}
							else{
								//回滚
								if("C".equals(seatreserve.getSellstate())){
									throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
											"0208",true); //留座位记录状态为已取消,无法售出留座。
								}
								else if("S".equals(seatreserve.getSellstate())){
									throw new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
											"0209",true); //留座位记录状态为已售,无法售出留座。
								}else{
									context.setRollbackOnly();
									result.setResult(208);
									result.setResultMsg("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno()+"留位状态未知,无法售出留座");
									return result;
								}
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
					scheduleseat.setTickettype(sellseat.getTickettypeCode());
					dao.delete(seatlock);
					scheduleseat.setUpdateby(order.getSellerId());
					scheduleseat.setUpdatetime(now);
					dao.merge(scheduleseat);
				}
			}
			else{
				//流水班次没有留位
				//取已售张数的最大值作为座位号
				Object seatno= dao.uniqueResult("select max(t.seatno) from Ticketsell t where t.scheduleplanid="+ticketprice.getScheduleplan().getId());
				if(seatno==null){
					ticketsell.setSeatno((short) 1);	
				}
				else{					
					ticketsell.setSeatno((short) ((Short)seatno+1));
				}					
				//往回更新
				sellseat.setSeatno(ticketsell.getSeatno());
			}
			ticketprice.setUpdateby(order.getSellerId());
			ticketprice.setUpdatetime(now);
			dao.merge(ticketprice);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketprice.getScheduleplan().getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", sellseat.getSeattypeCode()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			if(ticketprices.size()>1){
				for (Ticketprice _ticketprice : ticketprices){
					_ticketprice.setSoldeatnum(ticketprice.getSoldeatnum());
					_ticketprice.setAutocancelreserveseatnum(ticketprice.getAutocancelreserveseatnum());
					_ticketprice.setUnautocancelreserveseatnum(ticketprice.getUnautocancelreserveseatnum());
					_ticketprice.setUpdateby(order.getSellerId());
					_ticketprice.setUpdatetime(now);
					dao.merge(_ticketprice);
				}
			}
			
			scheduleplan.setUpdateby(order.getSellerId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			ticketsell.setBuspark(schedulestatus.getBuspark());
			ticketsell.setCarrychildnum(sellseat.getCarrychildnum());
			ticketsell.setCheckedby(null);
			ticketsell.setCheckstation(null);
			ticketsell.setChecktime(null);
			ticketsell.setCreateby(order.getSellerId());
			ticketsell.setCreatetime(now);
			if(sellseat.getCustomerid()==null||sellseat.getCustomerid()<=0){
				ticketsell.setCustomer(null);
			}
			else{
				Customer customer = new Customer();
				customer.setId(sellseat.getCustomerid());
				ticketsell.setCustomer(customer);
			}
			ticketsell.setDepartdate(ticketprice.getDepartdate());
			ticketsell.setDepartinvoicesby(null);
			ticketsell.setDepartinvoices(null);
			ticketsell.setDepartinvoicestime(null);
			ticketsell.setDepartstationid(ticketprice.getDepartstationid());
			ticketsell.setDeparttime(schedulestatus.getDeparttime());
			ticketsell.setDiscountrate(sellseat.getPrice().divide(ticketprice.getFullprice(),2, BigDecimal.ROUND_HALF_EVEN));
			ticketsell.setDistance((long) ticketprice.getDistance());
			ticketsell.setFullprice(ticketprice.getFullprice());
			ticketsell.setHandticketoutlets(null);
			ticketsell.setIschecked(false);
			ticketsell.setIsdepartinvoices(false);
			ticketsell.setIslinework(scheduleplan.getIslinework());
			ticketsell.setOrgid(sellOrg.getId());
			ticketsell.setPaymethod(order.getPaymethod());
			ticketsell.setPrice(sellseat.getPrice());
			ticketsell.setMoreprice(ticketprice.getMoreprice());
			ticketsell.setServicefee(sellseat.getServicefee());
			ticketsell.setReachstationid(ticketprice.getReachstationid());
			ticketsell.setScheduleid(scheduleplan.getScheduleid());
			ticketsell.setScheduleplanid(ticketprice.getScheduleplan().getId());
			ticketsell.setSellby(order.getSellerId());
			if(order.getSellIp()==null||order.getSellIp().equals("")){
				ticketsell.setSellip("127.0.0.1");
			}else{
				ticketsell.setSellip(order.getSellIp());
			}
			ticketsell.setSelltime(now);
			ticketsell.setSellway(order.getSellway());
			if(billinventory==null){
				ticketsell.setBatchno("");
			}else{
				ticketsell.setBatchno(billinventory.getBatchno());
			}
			ticketsell.setTicketentrance(schedulestatus.getTicketentrance());
			ticketno=ticketno+1;
			ticketsell.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
			ticketsell.setTicketoutletsid(order.getTicketoutletsid());
			ticketsell.setTicketstatus("0"); //正常
			ticketsell.setTickettype(sellseat.getTickettypeCode());
			ticketsell.setUpdateby(order.getSellerId());
			ticketsell.setUpdatetime(now);
			ticketsell.setSeattype(sellseat.getSeattypeCode());
			ticketsell.setToplimitprice(ticketprice.getToplimitprice());
			//取票价组成项费用
			//ticketsell.setFueladditionfee(ticketprice.getFueladditionfee());
			DeductInfo deductInfo = balancedeductService.getDeductfee(ticketsell);
			ticketsell.setFueladditionfee(deductInfo.getFueladditionfee());
			ticketsell.setStationservicefee(deductInfo.getStationfee());
			ticketsell.setComputefee(deductInfo.getComputefee());
			ticketsell.setCoolairfee(deductInfo.getCoolairfee());
			ticketsell.setAdditionfee(deductInfo.getAdditionfee());
			ticketsell.setWaterfee(deductInfo.getWaterfee());
			ticketsell.setInsurefee(deductInfo.getInsurefee());
			ticketsell.setOtherfee(deductInfo.getOtherfee());
			if(ticketturnoverdetail!=null){
				ticketsell.setTurnoverdetailid(ticketturnoverdetail.getId());
				ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().add(ticketsell.getFueladditionfee()));
				ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee().add(ticketsell.getStationservicefee()));
				ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().add(ticketsell.getComputefee()));
				ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().add(ticketsell.getCoolairfee()));
				ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().add(ticketsell.getAdditionfee()));
				ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().add(ticketsell.getWaterfee()));
				ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().add(ticketsell.getInsurefee()));
				ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().add(ticketsell.getOtherfee()));	
			}
			ticketsell.setOrderno(order.getOrderno());
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			/***************赣州自助售票机站外售票保存取票信息*****************/
			Ticketsellother ticketsellother =  new Ticketsellother();
			ticketsellother.setAgentname("自助售票机站外售票");
			ticketsellother.setCreateby(0L);
			ticketsellother.setCreatetime(now);
			ticketsellother.setEticketid(null);
			ticketsellother.setEticketno(null);
			ticketsellother.setIstaked(false);
			ticketsellother.setOrderno(order.getOrderno());
			ticketsellother.setPassword(ticketsell.getTicketno());
			ticketsellother.setPrintby(null);
			ticketsellother.setServiceprice(new BigDecimal(0));
			ticketsellother.setTicketsellid(ticketsell.getId());
			ticketsellother.setUpdateby(0);
			ticketsellother.setUpdatetime(now);
			ticketsellother.setEticketid(ticketsell.getTicketno());
			ticketsellother.setEticketno(ticketsell.getTicketno());
			dao.merge(ticketsellother);
			
//			detail.setId(ticketsell.getId());
			dao.getEntityManager().flush();
			ticketsells.put(sellseat,ticketsell);
			//如果到站为往返站点
			Station reachstation = (Station) dao.get(Station.class, ticketprice.getReachstationid());
			if(reachstation.getIsroundtrip()){
				Returntripticket returntripticket = new Returntripticket();
				if(billinventory==null){
					returntripticket.setBatchno("");
				}else{
					returntripticket.setBatchno(billinventory.getBatchno());
				}
				ticketno=ticketno+1;
				returntripticket.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
				returntripticket.setIsselfschedule(true);
				returntripticket.setSellid(ticketsell.getId());
				dao.merge(returntripticket);
				if(ticketturnoverdetail!=null){
					ticketturnoverdetail.setSellreturntripnum(ticketturnoverdetail.getSellreturntripnum()+1);
				}
			}

		}

		if(!scheduleplan_last.getIslinework()&&"3".equals(scheduleplan_last.getWorktype())){
			//到中心售票 
			Organization localorg =  (Organization) organizationDao.get(Organization.class, scheduleplan_last.getOrgid());
//			NetScheduleTicketSellService netScheduleTicketSellService = getCentreInterface(methodResult,localorg);
//			if(netScheduleTicketSellService==null){
//				context.setRollbackOnly();
//				result.setResult(methodResult.getResult());
//				result.setResultMsg(methodResult.getResultMsg());
//				return result;
//			}
			TicketOrder _order = ConvertSellTicketIn(order,ticketsells.values());
//			methodResult = netScheduleTicketSellService.sellTicket(_order);
			
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("order", JsonUtil.toFormatString(_order));
			Organization centreOrg = organizationService.getDirectlyParentOrg(localorg);
			//methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.SCHEDULE_SELL_TICKET, requestMap);		
			//方法不可用  SCHEDULE_SELL_TICKET做了修改
			methodResult.setResultMsg("方法不可用！");
			methodResult.setResult(MethodResult.FAILURE);
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				context.setRollbackOnly();
				result.setResult(methodResult.getResult());
				result.setResultMsg(methodResult.getResultMsg());
				return result;
			}
			//根据售票结果更新座位号
			List<TicketPrintInfo> _ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
			int i=0;
			for (ParamSellTicketIn paramSellTicketIn : ticketsells.keySet()) {
				paramSellTicketIn.setSeatno(_ticketPrintInfos.get(i).getSeatno());
				ticketsells.get(paramSellTicketIn).setSeatno((short) paramSellTicketIn.getSeatno());//更新座位号
				dao.merge(ticketsells.get(paramSellTicketIn));
				i++;
			}
		}
		List<ParamSellTicketOut> selledtickets = new ArrayList<ParamSellTicketOut>();
//		for (Ticketsell ticketsell : ticketsells.values()) {
//			selledtickets.add(getTicketPrintInfo(ticketsell.getId()));
//		}
//		
		for (cn.nova.bus.sale.remote.param.ParamSellTicketIn paramSellTicketIn : order.getSellseats()) {
			selledtickets.add(getTicketPrintInfo(ticketsells.get(paramSellTicketIn).getId()));
		}
		if(ticketturnoverdetail!=null){
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}
		result.setResult(MethodResult.SUCCESS);
		result.setSelledtickets(selledtickets);
		return result;
	}

}
