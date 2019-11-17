/**
 * 
 */
package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import util.SessionContext;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipconsume;
import cn.nova.bus.archive.model.Vipconsumeldetail;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.dao.ScheduleDao;
import cn.nova.bus.base.model.District;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.base.service.ScheduleService;
import cn.nova.bus.base.service.TicketreturnrateService;
import cn.nova.bus.base.service.impl.ScheduleServiceImpl;
import cn.nova.bus.base.service.impl.TicketreturnrateServiceImpl;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.impl.ScheduleplanServiceImpl;
import cn.nova.bus.encrypt.AuthcodeEncode;
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
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.sale.model.Ticketchange;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.BilldamagedService;
import cn.nova.bus.sale.service.TicketOpCommonService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.VipconsumeService;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.dao.ExceptioninfoDao;
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
import cn.nova.ticket.TicketOpCommonRemoteService;
import cn.nova.ticket.param.AvailableTicketOut;
import cn.nova.ticket.param.BilldamageIn;
import cn.nova.ticket.param.CancelTicketIn;
import cn.nova.ticket.param.CancelTicketOut;
import cn.nova.ticket.param.CancelTicketsIn;
import cn.nova.ticket.param.CancelTicketsOut;
import cn.nova.ticket.param.ChangeTicketsIn;
import cn.nova.ticket.param.ChangeTicketsOut;
import cn.nova.ticket.param.DepartSchedule;
import cn.nova.ticket.param.DepartStationOut;
import cn.nova.ticket.param.DepartStationsOut;
import cn.nova.ticket.param.FindScheduleIn;
import cn.nova.ticket.param.FindSchedulesOut;
import cn.nova.ticket.param.LockSeatsIn;
import cn.nova.ticket.param.LockSeatsOut;
import cn.nova.ticket.param.LockseatIn;
import cn.nova.ticket.param.LockseatOut;
import cn.nova.ticket.param.PickUpTicketIn;
import cn.nova.ticket.param.PickUpTicketOut;
import cn.nova.ticket.param.RePrintTicketsIn;
import cn.nova.ticket.param.RePrintTicketsOut;
import cn.nova.ticket.param.ReturnTicketIn;
import cn.nova.ticket.param.ReturnTicketOut;
import cn.nova.ticket.param.ReturnTicketsIn;
import cn.nova.ticket.param.ReturnTicketsOut;
import cn.nova.ticket.param.SellTicketIn;
import cn.nova.ticket.param.SellTicketOut;
import cn.nova.ticket.param.SellTicketsIn;
import cn.nova.ticket.param.SellTicketsOut;
import cn.nova.ticket.param.StationOut;
import cn.nova.ticket.param.StationsOut;
import cn.nova.ticket.param.TicketRemoteInvokeCommonProperty;
import cn.nova.ticket.param.TicketRemoteInvokeCommonProperty.TicketInvokeType;
import cn.nova.ticket.param.TicketReturnQryOut;
import cn.nova.ticket.param.TicketReturnQrysOut;
import cn.nova.ticket.param.UnLockSeatOut;
import cn.nova.ticket.param.UnLockSeatsIn;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * 本模块用于车站对外提供售、退、废票服务及相关查询
 * <pre>
 *  																															售退废影响数据
 * 																											  operateUserId>0    operateUserId==0				
 * 															 模块										 |  &&!billCustomManage	 billCustomManage eticketno==null				
 *    外部应用     	（ 查询发车站、查询到站、查询班次、锁位、解锁、售票、退票查询、退票、废票查询、废票、坏票）| （Ticketturnoverdetail、billinuse、ticketsellother、ticketsell/ticketprice/scheduleplan）   
 * 1、车站售票客户端	      ×         ×		√		√	  √		√		×		√	  ×		 √		√	 | 			√				√				×			√		 			
 * 2、车站自助售票机		  √			√		√		√	  √		√		×		×	  ×		 ×		√	 |			√				√				×			√			
 * 3、车站邮政售票		  ×			×		√		√	  √		√		√		√	  √	     √		×	 |			√				◎				×			√			
 * 4、被中心售票(各种方式) ×			×		×		√	  √		√		×		√	  ×		 √		×	 |			×				×				◎			√
 * </pre>				
 * @author ice
 */
public class TicketOpCommonServiceImpl implements TicketOpCommonService,TicketOpCommonRemoteService {
	private static String TICKETBILLCODE="Ticket";
	
	private final Logger log=LoggerFactory.getLogger(getClass());
	
	@SuppressWarnings("rawtypes")
	
	private IDAO dao = new EntityManagerDaoSurport();
	
	private BilldamagedService billdamagedService = new BilldamagedServiceImpl();

	private UserinfoDao userinfoDao = new UserinfoDao();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private TicketreturnrateService ticketreturnrateService = new TicketreturnrateServiceImpl();
	
	private ParameterService parameterService = new ParameterServiceImpl() ;
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private ScheduleDao scheduleDao = new ScheduleDao();
	
	private ScheduleplanService scheduleplanService = new ScheduleplanServiceImpl();
	
	private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();
	
	private TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();
	
	private SchedulestatusDao schedulestatusDao = new SchedulestatusDao();
	
	private DigitaldictionarydetailDao digitaldictionarydetailDao = new DigitaldictionarydetailDao();
	
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();
	
	private DictionaryService dictionaryService = new DictionaryServiceImpl();
	
	private VipService vipService = new VipServiceImpl();
	
	private VipconsumeService vipconsumeService = new VipconsumeServiceImpl();
	
	private ScheduleService scheduleService = new ScheduleServiceImpl();
	
	@Resource 
	private SessionContext context;	
	
	private boolean checkClientOrgIp(TicketRemoteInvokeCommonProperty ticketRemoteInvokeCommonProperty){
//		try {
//			String clientIp = RemoteServer.getClientHost();
//			Organization invokerOrg = getOrganizationService().getOrgByCode(ticketRemoteInvokeCommonProperty.getClientOrgcode());
//			if(invokerOrg.getServersaddressIp().equals(clientIp)){
//				ticketRemoteInvokeCommonProperty.setClientIp(clientIp);
//			}else{
//				throw new EJBException("调用者不合法");
//				return false;
//			}
//		} catch (ServerNotActiveException e) {
//			play.Logger.error(e.getMessage(), e);
//			return false;
//		}
		return true;
	}
	
	private static final String GET_ALLDEPARTSTATIONS_SQL =
		    "select station.code as stationcode,"  //organization.code
		    +"       organization.name as stationname,"
		    +"       district.code as city,"
		    +"       district.name as cityname,"
		    +"       district2.code as province,"
		    +"       district2.name as provincename,"
		    +"       organization.updatetime as updatetime,"
		    +"       organization.address as address"
		    +"  from organization" 
		    +"       join station on station.id=organization.stationid"
		    +"  left join district"
		    +"    on station.districtid = district.id"
		    +"  left join district district2"
		    +"    on district2.code = substr(district.code, 0, 2) || '000000000'"
		    +" where organization.isactive=1 and organization.islocal=1 and organization.type=2 and"
		    +" ((organization.updatetime >= :lastUpdatetime) or (organization.createtime>=:lastUpdatetime)) ";
	
	/**
	 * 查询发车站
	 */
	@SuppressWarnings("unchecked")
	@Override
	public DepartStationsOut GetAllDepartStation(Date lastUpdateTime) {
		DepartStationsOut result = new DepartStationsOut();
	    if(null!=lastUpdateTime){
	      try{
	        Query query = getDao().getEntityManager().createNativeQuery(GET_ALLDEPARTSTATIONS_SQL,DepartStationOut.class);
	        query.setParameter("lastUpdatetime", lastUpdateTime);
	        List<DepartStationOut> list = query.getResultList();
	        result.setDepartstations(list);
	      }catch(Exception e){
	    	  getContext().setRollbackOnly();
	    	  result.setResultMsg(e.toString());
	    	  return result;
	      }
	    }
	    result.setResult(MethodResult.SUCCESS);
	    return result;
	}
	
	  private static final String GET_ALLSTATION_SQL = 
			     "select station.code as stationcode,"
			    +"       station.name as stationname,"
			    +"       district.code as city,"
			    +"       station.jianpin as jianpin,"
			    +"       district.name as cityname,"
			    +"       district2.code as province,"
			    +"       district2.name as provincename,"
			    +"       station.updatetime as updatetime"
			    +"  from station"
			    +"  left join district"
			    +"    on station.districtid = district.id"
			    +"  left join district district2"
			    +"    on district2.code = substr(district.code, 0, 2) || '000000000'"
			    +" where station.isactive=1 "
			    +"   and ((station.updatetime >= :lastUpdatetime ) or (station.createtime>=:lastUpdatetime )) "
			    +"   And station.Id In (Select rs.stationid From Routestop rs)";
	  
	/**
	 * 查询到站
	 */
	@SuppressWarnings("unchecked")
	@Override
	public StationsOut GetAllStation(Date lastUpdateTime) {
		StationsOut result = new StationsOut();
	    if(null!=lastUpdateTime){
	      try{
	        Query query = getDao().getEntityManager().createNativeQuery(GET_ALLSTATION_SQL,StationOut.class);
	        query.setParameter("lastUpdatetime", lastUpdateTime);
	        List<StationOut> list = query.getResultList();
	        result.setWsstations(list);
	      } catch(Exception e){
	    	  getContext().setRollbackOnly();
	    	  result.setResultMsg(e.toString());
	    	  return result;
	      }
	    }
	    result.setResult(MethodResult.SUCCESS);
	    return result;
	}
	
	@SuppressWarnings("unchecked")
	private String checkAndConvertFindScheduleParam(cn.nova.ticket.param.local.FindScheduleIn localParamFindScheduleIn){
		String errmsg = checkAndConvertTicketRemoteInvokeCommonProperty(localParamFindScheduleIn,TicketOP.FINDSCHEDULE);
		if(errmsg!=null){
			return errmsg;
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if(localParamFindScheduleIn.getSellway()==null||localParamFindScheduleIn.getSellway().equals("")){
			return "售票方式不允许为空";
		}
		if(localParamFindScheduleIn.getDepartDate()==null){
			return "发车日期不允许为空";
		}
		if(localParamFindScheduleIn.getDepartDistrictCode()!=null&&!localParamFindScheduleIn.getDepartDistrictCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamFindScheduleIn.getDepartDistrictCode()));
			District district = (District) dao.uniqueResult(District.class,propertyFilters);
			localParamFindScheduleIn.setDepartDistrictId(district.getId());
		}else if(localParamFindScheduleIn.getDepartStationCode()!=null&&!localParamFindScheduleIn.getDepartStationCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamFindScheduleIn.getDepartStationCode()));
			Station station = (Station) dao.uniqueResult(Station.class,propertyFilters);
			localParamFindScheduleIn.setDepartStationId(station.getId());
		}
		if(localParamFindScheduleIn.getReachStationCode()!=null&&!localParamFindScheduleIn.getReachStationCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamFindScheduleIn.getReachStationCode()));
			Station station = (Station) dao.uniqueResult(Station.class,propertyFilters);
			localParamFindScheduleIn.setReachStationId(station.getId());
		}else if(localParamFindScheduleIn.getScheduleCode()!=null&&!localParamFindScheduleIn.getScheduleCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamFindScheduleIn.getScheduleCode()));
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
			Schedule schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
			localParamFindScheduleIn.setScheduleId(schedule.getId());
		}else{
			return "到达站与班次不允许同时为空";
		}
		if(localParamFindScheduleIn.getCertificateno()!=null&&!localParamFindScheduleIn.getCertificateno().equals("")
				&&localParamFindScheduleIn.getCertificatetype()!=null&&!localParamFindScheduleIn.getCertificatetype().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!certificateno", localParamFindScheduleIn.getCertificateno()));
			propertyFilters.add(new PropertyFilter("EQS_t!certificatetype", localParamFindScheduleIn.getCertificatetype()));
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
			Customer customer = (Customer) dao.uniqueResult(Customer.class,propertyFilters);
			if(customer!=null){
				localParamFindScheduleIn.setCustomerId(customer.getId());
			}
		}
		return null;
	}
	

	/* 供车站售票客户端、自助售票机、邮政售票查询
	 */
	@SuppressWarnings("unchecked")
	@Override
	public FindSchedulesOut findSchedule(FindScheduleIn paramFindScheduleIn) {
		return findSchedule(paramFindScheduleIn,false);
	}

	enum TicketOP{
		FINDSCHEDULE("查询班次"),SELL("售票"),RETURN("退票"),CANCEL("废票"),BILLDAMAGE("坏票登记");
	    // 成员变量  
	    private String name;  
	    // 构造方法  
	    private TicketOP(String name) {  
	        this.name = name;  
	    }  
	    //覆盖方法  
	    @Override  
	    public String toString() {  
	        return this.name;  
	    }  		
	}
	
	@SuppressWarnings("unchecked")
	private String checkAndConvertTicketRemoteInvokeCommonProperty(TicketRemoteInvokeCommonProperty ticketRemoteInvokeCommonProperty,TicketOP op){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Userinfo opuser = null;
		Ticketoutlets ticketoutlets = null;
		Organization organization_Operate = organizationService.getOrgByCode(ticketRemoteInvokeCommonProperty.getOperateOrgcode());
		//售票人、售票机构不同步。只在第一层被调用的中心有意义
		if(organization_Operate.getIslocal()){
			if(ticketRemoteInvokeCommonProperty.getOperateUserCode()!=null&&!ticketRemoteInvokeCommonProperty.getOperateUserCode().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticketRemoteInvokeCommonProperty.getOperateUserCode()));
				opuser = (Userinfo) dao.uniqueResult(Userinfo.class,propertyFilters);
			}

			//本中心为第一层调用，检查售票点
			if(ticketRemoteInvokeCommonProperty.getOperateTicketoutletsCode()!=null&&!ticketRemoteInvokeCommonProperty.getOperateTicketoutletsCode().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticketRemoteInvokeCommonProperty.getOperateTicketoutletsCode()));
				ticketoutlets = (Ticketoutlets) dao.uniqueResult(Ticketoutlets.class,propertyFilters);
			}
		}else{
			//非第一层被调用
			if(ticketRemoteInvokeCommonProperty.getTicketInvokeType()==TicketInvokeType.YOUZHEN){
				//上饶邮政要求各站记录 邮政代售点信息
				if(ticketRemoteInvokeCommonProperty.getOperateTicketoutletsCode()!=null&&!ticketRemoteInvokeCommonProperty.getOperateTicketoutletsCode().equals("")){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!code", ticketRemoteInvokeCommonProperty.getOperateTicketoutletsCode()));
					ticketoutlets = (Ticketoutlets) dao.uniqueResult(Ticketoutlets.class,propertyFilters);
				}
			}
		}
		if(opuser==null){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!id", 0L));
			opuser = (Userinfo) dao.uniqueResult(Userinfo.class,propertyFilters);
		}
		if(ticketoutlets==null){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!id", 0L));
			ticketoutlets = (Ticketoutlets) dao.uniqueResult(Ticketoutlets.class,propertyFilters);
		}
		ticketRemoteInvokeCommonProperty.setOperateUserId(opuser.getId());
		ticketRemoteInvokeCommonProperty.setOperateUserName(opuser.getName());
		ticketRemoteInvokeCommonProperty.setOperateUserCode(opuser.getCode());
		ticketRemoteInvokeCommonProperty.setOperateTicketoutletsId(ticketoutlets.getId());
		ticketRemoteInvokeCommonProperty.setOperateTicketoutletsName(ticketoutlets.getName());
		ticketRemoteInvokeCommonProperty.setOperateTicketoutletsCode(ticketoutlets.getCode());
		
		Organization oporg = null;
		if(ticketRemoteInvokeCommonProperty.getOperateOrgcode()!=null&&!ticketRemoteInvokeCommonProperty.getOperateOrgcode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", ticketRemoteInvokeCommonProperty.getOperateOrgcode()));
			oporg = (Organization) dao.uniqueResult(Organization.class,propertyFilters);
		}else if(opuser!=null&&opuser.getId()!=0){
			//取售票人所属的组织机构
			oporg = (Organization) dao.get(Organization.class,opuser.getOrgid());
			ticketRemoteInvokeCommonProperty.setOperateOrgcode(oporg.getCode());
		}else{
			return op+"机构编码不允许为空";
		}
		if(oporg==null){
			return op+"机构编码不存在";
		}else if(ticketRemoteInvokeCommonProperty.getOperateIp()==null||ticketRemoteInvokeCommonProperty.getOperateIp().trim().equals("")){
			ticketRemoteInvokeCommonProperty.setOperateIp(oporg.getServersaddressIp());
		}
		//目标车站信息
		if(op!=TicketOP.FINDSCHEDULE&&op!=TicketOP.BILLDAMAGE){
			if(ticketRemoteInvokeCommonProperty.getOppositeOrgcode()!=null&&!ticketRemoteInvokeCommonProperty.getOppositeOrgcode().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticketRemoteInvokeCommonProperty.getOppositeOrgcode()));
				Organization oppositeOrg = (Organization) dao.uniqueResult(Organization.class,propertyFilters);
				if(oppositeOrg==null){
					return "目标机构编码不存在";
				}
			}else{
				return "目标机构编码不允许为空";
			}
		}
		
		//调用者信息
		if(ticketRemoteInvokeCommonProperty.getClientOrgcode()!=null&&!ticketRemoteInvokeCommonProperty.getClientOrgcode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", ticketRemoteInvokeCommonProperty.getClientOrgcode()));
			Organization clietOrg = (Organization) dao.uniqueResult(Organization.class,propertyFilters);
			if(clietOrg==null){
				return "调用机构编码不存在";
			}else if(ticketRemoteInvokeCommonProperty.getClientIp()==null||ticketRemoteInvokeCommonProperty.getClientIp().trim().equals("")){
				ticketRemoteInvokeCommonProperty.setClientIp(clietOrg.getServersaddressIp());
			}
		}else{
			return "调用机构编码不允许为空";
		}

		return null;
	}
	
	@SuppressWarnings("unchecked")
	private String checkAndConvertLockParam(cn.nova.ticket.param.local.LockSeatsIn localParamLockSeatsIn){
		String errmsg = checkAndConvertTicketRemoteInvokeCommonProperty(localParamLockSeatsIn,TicketOP.SELL);
		if(errmsg!=null){
			return errmsg;
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		if(localParamLockSeatsIn.getDepartDate()==null){
			return "发车日期不允许为空";
		}
		if(localParamLockSeatsIn.getSellway()==null||localParamLockSeatsIn.getSellway().equals("")){
			return "售票方式不允许为空";
		}
		if(localParamLockSeatsIn.getOrderno()==null||localParamLockSeatsIn.getOrderno().equals("")){
			return "订单号不允许为空";
		}
		if(localParamLockSeatsIn.getDepartStationCode()!=null&&!localParamLockSeatsIn.getDepartStationCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamLockSeatsIn.getDepartStationCode()));
			Station station = (Station) dao.uniqueResult(Station.class,propertyFilters);
			localParamLockSeatsIn.setDepartStationId(station.getId());
		}else{
			return "发车站编码不允许为空";
		}
		if(localParamLockSeatsIn.getReachStationCode()!=null&&!localParamLockSeatsIn.getReachStationCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamLockSeatsIn.getReachStationCode()));
			Station station = (Station) dao.uniqueResult(Station.class,propertyFilters);
			localParamLockSeatsIn.setReachStationId(station.getId());
		}else{
			return "到达站编码不允许为空";
		}
		Schedule schedule = null;
		if(localParamLockSeatsIn.getScheduleCode()!=null&&!localParamLockSeatsIn.getScheduleCode().equals("")){
			propertyFilters.clear();
//			propertyFilters.add(new PropertyFilter("EQS_t!code", localParamLockSeatsIn.getScheduleCode()));
//			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//			schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
			StringBuilder sb = new StringBuilder();
			sb.append("select distinct sc from Schedule sc,Ticketprice scs")
			.append(" where sc.id=scs.scheduleid");
			propertyFilters.add(new PropertyFilter("EQS_sc!code", localParamLockSeatsIn.getScheduleCode()));
			propertyFilters.add(new PropertyFilter("EQL_scs!departstationid", localParamLockSeatsIn.getDepartStationId()));
			propertyFilters.add(new PropertyFilter("EQB_sc!isactive", true));
			propertyFilters.add(new PropertyFilter("EQD_scs!departdate", localParamLockSeatsIn.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQB_scs!issellable", true));
			schedule = (Schedule) dao.uniqueResult(sb.toString(), propertyFilters);
		}else if(localParamLockSeatsIn.getScheduleSyncCode()!=null&&!localParamLockSeatsIn.getScheduleSyncCode().equals("")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!synccode", localParamLockSeatsIn.getScheduleSyncCode()));
			schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
		}else{
			return "班次编码与班次同步编码不允许同时为空";
		}
		if(schedule==null){
			return "找不到班次";
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", localParamLockSeatsIn.getDepartDate()));
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(Scheduleplan.class,propertyFilters);
		if(scheduleplan==null){
			return "找不到班次计划";
		}
		localParamLockSeatsIn.setScheduleplanId(scheduleplan.getId());
		if(localParamLockSeatsIn.getSelectSeatStatus()==null||localParamLockSeatsIn.getSelectSeatStatus().size()==0){
			return "可选座位状态 不允许为空";
		}
		return null;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.ticket.remote.service.TicketSellKernelService#lockSeat(cn.nova.ticket.remote.param.ParamLockSeatsIn)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public LockSeatsOut lockSeat(LockSeatsIn paramLockSeatsIn) {
		LockSeatsOut result = new LockSeatsOut();
		checkClientOrgIp(paramLockSeatsIn);
		cn.nova.ticket.param.local.LockSeatsIn localParamLockSeatsIn = null;
		try {
			localParamLockSeatsIn = new cn.nova.ticket.param.local.LockSeatsIn(paramLockSeatsIn);
		} catch (CloneNotSupportedException e) {
			getContext().setRollbackOnly();
			result.setResultMsg(e.toString());
			return result;
		}
		String errmsg = checkAndConvertLockParam(localParamLockSeatsIn);
		if(errmsg!=null){
			getContext().setRollbackOnly();
			result.setResultMsg(errmsg);
			return result;
		}
		
		Date locktime = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, localParamLockSeatsIn.getScheduleplanId());
		int preSaleDays = new Short(getParameterService().findParamValue(ParamterConst.Param_1017, scheduleplan.getOrgid()));// 车票预售天数
		int interdays=DateUtils.getIntervalDays(locktime, paramLockSeatsIn.getDepartDate());
		if(interdays>preSaleDays){
			getContext().setRollbackOnly();
			result.setResultMsg("该班次不允许购票，超过该班次的预售天数:"+preSaleDays+"天");
			return result;
		}
		MethodResult methodResult = new MethodResult();
		//校验班次状态是否可售
		Organization sellOrg = organizationService.getOrgByCode(localParamLockSeatsIn.getOperateOrgcode());
		methodResult = checkSchedulestatus(localParamLockSeatsIn.getSellway(),scheduleplan.getId(),localParamLockSeatsIn.getDepartStationId(),sellOrg.getIslocal());
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
		if(localParamLockSeatsIn.getDeparttime()!=null&&!localParamLockSeatsIn.getDeparttime().equals("")
			&&!schedulestatus.getDeparttime().equals(localParamLockSeatsIn.getDeparttime())){
			getContext().setRollbackOnly();
			result.setResult(115);
			result.setResultMsg(new StringBuilder().append("发车时间不一致：最新的发车时间为").append(schedulestatus.getDeparttime()).toString());
			return result;
		}
		
		//如果是流水班，直接返回
		if(scheduleplan.getIslinework()){
			result = new LockSeatsOut();
			result.setAutounlocktime(new Date());
			result.setDeparttime(scheduleplan.getStarttime());
			result.setLockedseats(new ArrayList<LockseatOut>());
			initTickettyes();
			initSeattypes();
			for (LockseatIn lockseatIn : paramLockSeatsIn.getLockseats()) {
				Station departstation = (Station) dao.get(Station.class, localParamLockSeatsIn.getDepartStationId());
				Station reachstation = (Station) dao.get(Station.class, localParamLockSeatsIn.getReachStationId());
				//校验票价
				methodResult =  checkTickettypeAndPrice(scheduleplan,departstation,reachstation,lockseatIn.getSeattypecode(),lockseatIn.getTickettypecode(),lockseatIn.getPrice());
				if(methodResult.getResult()!=1){
					getContext().setRollbackOnly();
					result.setResult(methodResult.getResult());
					result.setResultMsg(methodResult.getResultMsg());
					return result;
				}
				BigDecimal seatprice = (BigDecimal) methodResult.getObject();
				LockseatOut lockseatOut = new LockseatOut();
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
		propertyFilters.add(new PropertyFilter("EQS_t!orderno",localParamLockSeatsIn.getOrderno()));
		List<Seatlock> otherseatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		//取锁定时间
		Date unlocktime;
		Organization departorg = organizationService.getOrgByStationId(localParamLockSeatsIn.getDepartStationId());
		float CarrychildRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1012, departorg.getId()))/100;
		try {
			unlocktime = getLockTime(localParamLockSeatsIn.getSellway(),otherseatlocks,localParamLockSeatsIn.getLocktime(),departorg.getId(),locktime);
		} catch (Exception e) {
			getContext().setRollbackOnly();
			result.setResult(201);
			result.setResultMsg(e.toString());
			return result;
		}

		if(otherseatlocks!=null&&otherseatlocks.size()>0){
			//根据售票方式判断是叠加锁位  还是  重复锁位
			//售票途径:0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票、9单独售保险、10自助售票机售票、11邮政售票
			if(localParamLockSeatsIn.getSellway().equals("7")||localParamLockSeatsIn.getSellway().equals("10")||localParamLockSeatsIn.getSellway().equals("11")){
				//判断重复提交座位数及座位类型是否一致
				Map<String, Integer> seattypenum = new HashMap<String, Integer>();
				for (LockseatIn wsLockSeat : localParamLockSeatsIn.getLockseats()) {
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
				.append(" and sl.orderno='").append(localParamLockSeatsIn.getOrderno()).append("'")
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
				for (LockseatIn lockSeateOrderInfo : localParamLockSeatsIn.getLockseats()) {
					Station departstation = (Station) dao.get(Station.class, localParamLockSeatsIn.getDepartStationId());
					Station reachstation = (Station) dao.get(Station.class, localParamLockSeatsIn.getReachStationId());
					LockseatOut lockedSeat = new LockseatOut();
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
						for (LockseatOut _lockSeateOrderOut : result.getLockedseats()) {
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
				result.setOrderno(localParamLockSeatsIn.getOrderno());
				result.setSeatnums(localParamLockSeatsIn.getLockseats().size());
				result.setResult(MethodResult.SUCCESS);
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
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", localParamLockSeatsIn.getScheduleplanId()));
		List<Scheduleseats> scheduleseats = dao.find(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
		
		result.setLockedseats(new ArrayList<LockseatOut>()); //锁定成功座位列表
		for (LockseatIn paramLockseat : localParamLockSeatsIn.getLockseats()) {
			Station departstation = (Station) dao.get(Station.class, localParamLockSeatsIn.getDepartStationId());
			Station reachstation = (Station) dao.get(Station.class, localParamLockSeatsIn.getReachStationId());

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
					result.setResultMsg((new ServiceException("0204")).getExceptionMessage());//班次座位记录不存在
					getContext().setRollbackOnly();
					return result;
				}else if(scheduleseat.getStatus().equals("2")||scheduleseat.getStatus().equals("1")){
					//试图锁定的座位号已售或被他人锁定
					scheduleseat = null;
				}
			}
			
			for (Scheduleseats _scheduleseat : scheduleseats) {
				if(localParamLockSeatsIn.getSelectSeatStatus().contains(_scheduleseat.getStatus())
					&&(paramLockseat.getSeattypecode()==null||paramLockseat.getSeattypecode().equals("")||paramLockseat.getSeattypecode().equals(_scheduleseat.getSeattype()))
					){
					scheduleseat = _scheduleseat;
					break;
				}
			}
			if(scheduleseat==null){
				result.setResultMsg((new ServiceException("0298")).getExceptionMessage());//剩余座位数不够
				getContext().setRollbackOnly();
				return result;
			}
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+paramLockseat.getCarrychildnum()));
			Seatlock seatlock = new Seatlock();
			//非流水班，在锁位时就要检查带儿童数，并更新班次已带儿童数
			if(paramLockseat.getCarrychildnum()>0){
				if(CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<scheduleplan.getCarrychildnum()+paramLockseat.getCarrychildnum()){
					result.setResultMsg((new ServiceException("0270")).getExceptionMessage());//该班次带儿童数量超过最大允许带儿童数量
					getContext().setRollbackOnly();
					return result;
				}
				seatlock.setCarrychildnum(paramLockseat.getCarrychildnum());
			}
			seatlock.setOldstatus(scheduleseat.getStatus());
			scheduleseat.setStatus("1"); //锁定
			SeatlockPK seatlockPK = new SeatlockPK();
			seatlockPK.setScheduleplanid(localParamLockSeatsIn.getScheduleplanId());
			seatlockPK.setSeatno(scheduleseat.getSeatno());
			seatlock.setId(seatlockPK);
			seatlock.setLocktime(locktime);
			seatlock.setAutounlocktime(unlocktime);
			seatlock.setDepartdate(scheduleplan.getDepartdate());
			seatlock.setLockby(localParamLockSeatsIn.getOperateUserId());
			seatlock.setLockip(localParamLockSeatsIn.getOperateIp());
			seatlock.setLockorgid(localParamLockSeatsIn.getOperateTicketoutletsId());
			seatlock.setLockticketoutletsid(sellOrg.getId());
			
			seatlock.setOrderno(localParamLockSeatsIn.getOrderno());
			seatlock.setScheduleid(scheduleplan.getScheduleid());
			scheduleseat.setUpdateby(localParamLockSeatsIn.getOperateUserId());
			scheduleseat.setUpdatetime(locktime);
			dao.merge(scheduleseat);
			dao.merge(seatlock);
			LockseatOut paramLockedSeat = new LockseatOut();
			paramLockedSeat.setPrice(seatprice);
			paramLockedSeat.setTickettypecode(paramLockseat.getTickettypecode());
			if(paramLockedSeat.getTickettypecode()!=null&&!paramLockedSeat.getTickettypecode().trim().equals("")){
				initTickettyes();
				paramLockedSeat.setTickettypename(tickettypes.get(paramLockedSeat.getTickettypecode()));
				paramLockedSeat.setCarrychildnum(paramLockseat.getCarrychildnum());
			}
			paramLockedSeat.setSeattypecode(scheduleseat.getSeattype());
			if(paramLockedSeat.getSeattypecode()!=null&&!paramLockedSeat.getSeattypecode().trim().equals("")){
				initSeattypes();
				paramLockedSeat.setSeattypename(seattypes.get(paramLockedSeat.getSeattypecode()));
			}
			paramLockedSeat.setSeatno((int) seatlock.getId().getSeatno());
			result.getLockedseats().add(paramLockedSeat);
		}
		dao.merge(scheduleplan);
		
		result.setDeparttime(schedulestatus.getDeparttime());
		result.setOrderno(localParamLockSeatsIn.getOrderno());
		result.setSeatnums(localParamLockSeatsIn.getLockseats().size());
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	
	@SuppressWarnings("unchecked")
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
			_price = ticketprices.get(seattype).getHalfprice();
			break;
		case 'X':
			_price = ticketprices.get(seattype).getStudentprice();
			break;
		default:
			_price = ticketpriceformulaService.getPrice(scheduleplan.getScheduleid(), 
					scheduleplan.getDepartdate(), tickettype,
					ticketprices.get(seattype).getFullprice());
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
			Organization departOrg = organizationService.getOrgByStationId(departstationid);
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
	
	@SuppressWarnings("unchecked")
	private void initTickettyes(){
		if(tickettypes==null){
			tickettypes = new HashMap<String, String>();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
			propertyFilters.add(new PropertyFilter("GTY_t!orderno", (byte)0));
			List<Tickettype> _tickettypes = dao.find(Tickettype.class,propertyFilters);
			for (Tickettype _tickettype : _tickettypes) {
				//此处改为取打印名称
				tickettypes.put(_tickettype.getCode(), _tickettype.getPrintname());
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
	 * @see cn.nova.ticket.remote.service.TicketSellKernelService#unlockSeat(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public UnLockSeatOut unlockSeat(UnLockSeatsIn paramUnLockSeatsIn) {
		UnLockSeatOut result = new UnLockSeatOut();
		checkClientOrgIp(paramUnLockSeatsIn);
		//取机构
		Organization organization_depart = organizationService.getOrgByCode(paramUnLockSeatsIn.getOppositeOrgcode());

		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", paramUnLockSeatsIn.getOrderno()));
		
		if(paramUnLockSeatsIn.getDepartDate()!=null
			&&(paramUnLockSeatsIn.getScheduleCode()!=null||paramUnLockSeatsIn.getScheduleSyncCode()!=null)){
			Schedule schedule = null;
			if(paramUnLockSeatsIn.getScheduleSyncCode()!=null){
				schedule = scheduleDao.getScheduleBySyncCode(paramUnLockSeatsIn.getScheduleSyncCode());
			}else{
				schedule = scheduleDao.getScheduleByCode(paramUnLockSeatsIn.getScheduleCode(), organization_depart.getId(), paramUnLockSeatsIn.getDepartDate());
			}
			if(schedule==null){
				result.setResultMsg("班次编码有误");
				getContext().setRollbackOnly();
				return result;
			}
			Scheduleplan scheduleplan = scheduleplanService.getByScheduleid(schedule.getId(), paramUnLockSeatsIn.getDepartDate());
			if(scheduleplan!=null){
				propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", scheduleplan.getId()));
			}
		}
		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(seatlocks!=null){
			for (Seatlock seatlock : seatlocks) {
				if(paramUnLockSeatsIn.getSeatnos()==null||paramUnLockSeatsIn.getSeatnos().size()==0
					||paramUnLockSeatsIn.getSeatnos().indexOf(seatlock.getId().getSeatno())==-1){
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

	@SuppressWarnings("unchecked")
	private String checkAndConvertSellParam(cn.nova.ticket.param.local.SellTicketsIn localParamSellTicketsIn){
		String errmsg = checkAndConvertTicketRemoteInvokeCommonProperty(localParamSellTicketsIn,TicketOP.SELL);
		if(errmsg!=null){
			return errmsg;
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		if(localParamSellTicketsIn.getSellway()==null||localParamSellTicketsIn.getSellway().equals("")){
			return "售票方式不允许为空";
		}
		if(localParamSellTicketsIn.getOrderno()==null||localParamSellTicketsIn.getOrderno().equals("")){
			return "订单号不允许为空";
		}
		if(localParamSellTicketsIn.getPaymethod()==null||localParamSellTicketsIn.getPaymethod().equals("")){
			return "支付方式不允许为空";
		}
		if(localParamSellTicketsIn.getTicketInvokeType()!=TicketInvokeType.INTERNET
			&&localParamSellTicketsIn.getTicketInvokeType()!=TicketInvokeType.ONECARD){
			//电子票号不需要检查当前票号
			if(localParamSellTicketsIn.getStartTicketNO()==null||localParamSellTicketsIn.getStartTicketNO().equals("")){
				return "当前票号不允许为空";
			}
		}
		if(localParamSellTicketsIn.getPaymethod().equals("2")
			||localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.ONECARD
			||localParamSellTicketsIn.getVipcardno()!=null){
			if(!localParamSellTicketsIn.getPaymethod().equals("2")){
				return "支付方式应为VIP卡余额支付";
			}
			if(localParamSellTicketsIn.getVipcardno()==null){
				return "VIP卡号不允许为空";
			}
		}
		
		for (SellTicketIn _paramSellTicketIn : localParamSellTicketsIn.getSellseats()) {
			cn.nova.ticket.param.local.SellTicketIn paramSellTicketIn = (cn.nova.ticket.param.local.SellTicketIn) _paramSellTicketIn;
			if(paramSellTicketIn.getServicefee()==null){
				paramSellTicketIn.setServicefee(new BigDecimal(0));
			}
			if(paramSellTicketIn.getDepartDate()==null){
				return "发车日期不允许为空";
			}
			if(paramSellTicketIn.getSeattypeCode()==null||paramSellTicketIn.getSeattypeCode().equals("")){
				return "座位类型不允许为空";
			}
			if(paramSellTicketIn.getTickettypeCode()==null||paramSellTicketIn.getTickettypeCode().equals("")){
				return "车票类型不允许为空";
			}
			Station departStation = null;
			if(paramSellTicketIn.getDepartStationCode()!=null&&!paramSellTicketIn.getDepartStationCode().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", paramSellTicketIn.getDepartStationCode()));
				departStation = (Station) dao.uniqueResult(Station.class,propertyFilters);
			}else{
				return "发车站编码不允许为空";
			}
			Station reachStation = null;
			if(paramSellTicketIn.getReachStationCode()!=null&&!paramSellTicketIn.getReachStationCode().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", paramSellTicketIn.getReachStationCode()));
				reachStation = (Station) dao.uniqueResult(Station.class,propertyFilters);
			}else{
				return "到达站编码不允许为空";
			}
			Schedule schedule = null;
			if(paramSellTicketIn.getSchedulecode()!=null&&!paramSellTicketIn.getSchedulecode().equals("")){
				propertyFilters.clear();
//				propertyFilters.add(new PropertyFilter("EQS_t!code", localParamLockSeatsIn.getScheduleCode()));
//				propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//				schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
				StringBuilder sb = new StringBuilder();
				sb.append("select distinct sc from Schedule sc,Ticketprice scs")
				.append(" where sc.id=scs.scheduleid");
				propertyFilters.add(new PropertyFilter("EQS_sc!code", paramSellTicketIn.getSchedulecode()));
				propertyFilters.add(new PropertyFilter("EQL_scs!departstationid", departStation.getId()));
				propertyFilters.add(new PropertyFilter("EQB_sc!isactive", true));
				propertyFilters.add(new PropertyFilter("EQD_scs!departdate", paramSellTicketIn.getDepartDate()));
				propertyFilters.add(new PropertyFilter("EQB_scs!issellable", true));
				schedule = (Schedule) dao.uniqueResult(sb.toString(), propertyFilters);
			}else if(paramSellTicketIn.getSchedulesynccode()!=null&&!paramSellTicketIn.getSchedulesynccode().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!synccode", paramSellTicketIn.getSchedulesynccode()));
				schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
			}else{
				return "班次编码与班次同步编码不允许同时为空";
			}
			if(schedule==null){
				return "找不到班次";
			}
			
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", paramSellTicketIn.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", departStation.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", reachStation.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", paramSellTicketIn.getSeattypeCode()));
			Ticketprice ticketprice = (Ticketprice) dao.uniqueResult(Ticketprice.class,propertyFilters);
			if(ticketprice==null){
				return "找不到班次计划";
			}
			if(paramSellTicketIn.getPrice()==null){
				switch (paramSellTicketIn.getTickettypeCode().charAt(0)) {
				case 'Q':
					paramSellTicketIn.setPrice(ticketprice.getFullprice());
					break;
				case 'B':
					paramSellTicketIn.setPrice(ticketprice.getHalfprice());
					break;
				case 'X':
					paramSellTicketIn.setPrice(ticketprice.getStudentprice());
					break;
				default:
					return "没有传入票价且车票类型未知";
				}
			}
			paramSellTicketIn.setTicketpriceId(ticketprice.getId());
			if(paramSellTicketIn.getCertificateno()!=null&&!paramSellTicketIn.getCertificateno().equals("")
					&&paramSellTicketIn.getCertificatetype()!=null&&!paramSellTicketIn.getCertificatetype().equals("")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!certificateno", paramSellTicketIn.getCertificateno()));
				propertyFilters.add(new PropertyFilter("EQS_t!certificatetype", paramSellTicketIn.getCertificatetype()));
				propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
				Customer customer = (Customer) dao.uniqueResult(Customer.class,propertyFilters);
				if(customer!=null){
					paramSellTicketIn.setCustomerid(customer.getId());
					paramSellTicketIn.setCustomersyncode(customer.getSynccode());
					if(localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.INTERNET || localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.YOUZHEN){
						if(paramSellTicketIn.getFetchPhone()!=null
								&&!paramSellTicketIn.getFetchPhone().trim().equals("")
								&&!paramSellTicketIn.getFetchPhone().equals(customer.getMobilephone())){
							customer.setMobilephone(paramSellTicketIn.getFetchPhone());
							customer = (Customer) dao.merge(customer);
						}
						if(paramSellTicketIn.getFetchMail()!=null
								&&!paramSellTicketIn.getFetchMail().trim().equals("")
								&&!paramSellTicketIn.getFetchMail().equals(customer.getEmail())){
							customer.setEmail(paramSellTicketIn.getFetchMail());
							customer = (Customer) dao.merge(customer);
						}
					}
				}else{
					if(localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.INTERNET  || localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.YOUZHEN){
						//保存顾客信息
						Date now = new Date();
						customer = new Customer();
						customer.setCertificateno(paramSellTicketIn.getCertificateno());
						customer.setCertificatetype(paramSellTicketIn.getCertificatetype());
						customer.setCreateby(localParamSellTicketsIn.getOperateUserId());
						customer.setCreatetime(now);
						customer.setEducation(null);
						customer.setEmail(paramSellTicketIn.getFetchMail());
						customer.setFamilyaddress(null);
						customer.setInputway("1");//网上售票
						customer.setIsactive(true);
						customer.setIslocaldelete(false);
						customer.setLastbuytickettime(now);
						customer.setMobilephone(paramSellTicketIn.getFetchPhone());
						customer.setName(paramSellTicketIn.getFetchName());
						Organization operateOrg = organizationService.getOrgByCode(localParamSellTicketsIn.getOperateOrgcode());
						customer.setOrgid(operateOrg.getId());
						customer.setRemarks(null);
						if("0".equals(customer.getCertificatetype())){
							if(customer.getCertificateno().length()==15){
								//15位身份证号码：第7、8位为出生年份(两位数)，第9、10位为出生月份，第11、12位代表出生日期，第15位代表性别，奇数为男，偶数为女。
								try {
									Calendar calendar = Calendar.getInstance();
									calendar.set(Integer.parseInt("19"+customer.getCertificateno().substring(6, 8)), 
											Integer.parseInt(customer.getCertificateno().substring(8, 10)), 
											Integer.parseInt(customer.getCertificateno().substring(10, 12)), 
											0,0,0);
									calendar.set(Calendar.MILLISECOND, 0);
									customer.setBirthday(calendar.getTime());
								} catch (Exception e) {
									return "身份证号码有正确！";
								}
								if(Integer.parseInt(String.valueOf(customer.getCertificateno().charAt(14))) % 2 ==0){
									customer.setSex("女");
								}else{
									customer.setSex("男");
								}
							}else if(customer.getCertificateno().length()==18){
								//18位身份证号码：第7、8、9、10位为出生年份(四位数)，第11、第12位为出生月份，第13、14位代表出生日期，第17位代表性别，奇数为男，偶数为女。
								try {
									Calendar calendar = Calendar.getInstance();
									calendar.set(Integer.parseInt(customer.getCertificateno().substring(6, 10)), 
											Integer.parseInt(customer.getCertificateno().substring(10, 12)), 
											Integer.parseInt(customer.getCertificateno().substring(12, 14)), 
											0,0,0);
									calendar.set(Calendar.MILLISECOND, 0);
									customer.setBirthday(calendar.getTime());
								} catch (Exception e) {
									return "身份证号码有正确！";
								}
								if(Integer.parseInt(String.valueOf(customer.getCertificateno().charAt(16))) % 2 ==0){
									customer.setSex("女");
								}else{
									customer.setSex("男");
								}
							}else{
								return "身份证号码长度错误！";								
							}
						}else{
							customer.setSex("男");
						}
						if(paramSellTicketIn.getCustomersyncode()!=null&&!paramSellTicketIn.getCustomersyncode().trim().equals("")){
							customer.setSynccode(paramSellTicketIn.getCustomersyncode());
						}else{
							customer.setSynccode(null);
						}
						customer.setTicketoutletsid(localParamSellTicketsIn.getOperateTicketoutletsId());
						customer.setUpdateby(localParamSellTicketsIn.getOperateUserId());
						customer.setUpdatetime(now);
						customer = (Customer) dao.merge(customer);					
						paramSellTicketIn.setCustomerid(customer.getId());
						paramSellTicketIn.setCustomersyncode(customer.getSynccode());
					}
				}
			}
		}
		return null;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.ticket.service.remote.TicketSellKernelService#sellTicket(cn.nova.ticket.remote.param.ParamSellTicketsIn)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public SellTicketsOut sellticket(SellTicketsIn order) {
		checkClientOrgIp(order);
		SellTicketsOut result = new SellTicketsOut();
		
		cn.nova.ticket.param.local.SellTicketsIn localParamSellTicketsIn = new cn.nova.ticket.param.local.SellTicketsIn(order);
		String errmsg = checkAndConvertSellParam(localParamSellTicketsIn);
		if(errmsg!=null){
			getContext().setRollbackOnly();
			result.setResultMsg(errmsg);
			return result;
		}
		//取机构
		Organization organization_depart = organizationService.getOrgByCode(localParamSellTicketsIn.getOppositeOrgcode());
		Organization organization_seller = organizationService.getOrgByCode(localParamSellTicketsIn.getOperateOrgcode());
		
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		
		//计算半票数
		int bNum = 0;
		for (Object _ticketPrintInfo : localParamSellTicketsIn.getSellseats()) {
			SellTicketIn ticketPrintInfo =  (SellTicketIn) _ticketPrintInfo;
			if("B".equals(ticketPrintInfo.getTickettypeCode())){
				bNum++;
				break;
			}
		}
		float bRate = 1;
		if(bNum>0){
			bRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1036, organization_depart.getId()))/100;
			if(bRate<=0){
				result.setResultMsg((new ServiceException("0371")).getExceptionMessage());//半票数超出设定比例
				getContext().setRollbackOnly();
				return result;
			}
		}
		Ticketturnoverdetail ticketturnoverdetail = null;
		Billinventory billinventory = null;
		//调用者属于本地机构的，才需要记录缴款明细表的票证
		if(organization_seller.getIslocal()&&localParamSellTicketsIn.getSellseats().get(0).getEticketno()==null
			&&localParamSellTicketsIn.getTicketInvokeType()!=TicketInvokeType.INTERNET
			&&localParamSellTicketsIn.getTicketInvokeType()!=TicketInvokeType.ONECARD){
			if(!localParamSellTicketsIn.getBillCustomManage()){
				//计算消耗票证数
				int printticketcount = localParamSellTicketsIn.getSellseats().size();
				for (Object _ticketPrintInfo : localParamSellTicketsIn.getSellseats()) {
					cn.nova.ticket.param.local.SellTicketIn ticketPrintInfo =  (cn.nova.ticket.param.local.SellTicketIn) _ticketPrintInfo;
					Ticketprice ticketprice = (Ticketprice) dao.get(Ticketprice.class, ticketPrintInfo.getTicketpriceId());
					Station reachstation = (Station) dao.get(Station.class, ticketprice.getReachstationid());
					if(reachstation.getIsroundtrip()){
						printticketcount++;
					}
				}
				Billinuse billinuse = null;
				try {
					billinuse = billinuseService.jumpBillinuse(localParamSellTicketsIn.getOperateUserId(),"Ticket",localParamSellTicketsIn.getStartTicketNO(),printticketcount);
				} catch (ServiceException e) {
					getContext().setRollbackOnly();
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
				if(localParamSellTicketsIn.getOperateUserId()>0){
					//插入或修改应缴款表
					ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(localParamSellTicketsIn.getOperateUserId(), localParamSellTicketsIn.getStartTicketNO());
					if("0".equals(ticketturnoverdetail.getTicketstartno())){
						ticketturnoverdetail.setTicketstartno(localParamSellTicketsIn.getStartTicketNO());
					}
					ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(new Long(localParamSellTicketsIn.getStartTicketNO())+printticketcount-1).toString(),localParamSellTicketsIn.getStartTicketNO().length(), "0"));
					ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+localParamSellTicketsIn.getSellseats().size());
					ticketturnoverdetail.setUpdateby(localParamSellTicketsIn.getOperateUserId());
					ticketturnoverdetail.setUpdatetime(now);
					//缴款明细表加字段
					ticketturnoverdetail.setBatchno(billinventory.getBatchno());
					ticketturnoverdetail.setBillinuseid(billinuse.getId());
					ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
				}
			}
			else{
				if(localParamSellTicketsIn.getBillSectionCheck()){
					//校验传入的票号
					StringBuilder sb = new StringBuilder();
					sb.append("select bi from Billinuse bi ")
					.append(" where bi.startno<=").append(localParamSellTicketsIn.getStartTicketNO()).append(" and bi.endno>=").append(localParamSellTicketsIn.getStartTicketNO())
					.append(" and bi.recipients=").append(localParamSellTicketsIn.getOperateUserId());
					List<Billinuse> bis = dao.find(sb.toString());
					if(bis==null||bis.size()==0){
						result.setResultMsg((new ServiceException("0170")).getExceptionMessage());//传入的当前票号与数据库不一致
						getContext().setRollbackOnly();
						return result;
					}
					billinventory = (Billinventory) dao.get(Billinventory.class, bis.get(0).getBillinventoryid()); 
				}
			}
		}else if (organization_seller.getIslocal()
				  &&localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.ONECARD
				  &&localParamSellTicketsIn.getOperateUserId()>0){
			//本地一卡通要记录应缴款表
			ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(localParamSellTicketsIn.getOperateUserId(), localParamSellTicketsIn.getStartTicketNO());
			ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+localParamSellTicketsIn.getSellseats().size());
			ticketturnoverdetail.setUpdateby(localParamSellTicketsIn.getOperateUserId());
			ticketturnoverdetail.setUpdatetime(now);
			//缴款明细表加字段
			ticketturnoverdetail.setBatchno(order.getBatchno());
			ticketturnoverdetail.setBillinuseid(0);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}


		Vip vip = null;
		Vipconsume vipconsume = null;
		if(localParamSellTicketsIn.getVipcardno()!=null&&"2".equals(localParamSellTicketsIn.getPaymethod())){
			vip = vipService.findByCardNo(order.getVipcardno(),"0");
			if(vip == null){
				result.setResultMsg((new ServiceException("0411")).getExceptionMessage());//找不到VIP卡信息
				getContext().setRollbackOnly();
				return result;
			}else if(!"0".equals(vip.getStatus())){//状态：0正常,1已退,2挂失,3注销,4过期,5已补卡 取数据字典
				result.setResultMsg((new ServiceException("0412")).getExceptionMessage());//VIP卡当前状态异常
				getContext().setRollbackOnly();
				return result;
			}
			vip.setVipgrade(order.getVipgrade());
			vip.setMoney(order.getVipmoney());
			vip.setVipamount(order.getVippoint());
			vipconsume = new Vipconsume();
			vipconsume.setCreateby(localParamSellTicketsIn.getOperateUserId());
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
		}else if(order.getVipcardno()==null&&"2".equals(localParamSellTicketsIn.getPaymethod())){
			//没有传入卡号，但支付方式为 余额支付或积分支付
			result.setResultMsg((new ServiceException("0413")).getExceptionMessage());///VIP卡号不允许为空
			getContext().setRollbackOnly();
			return result;
		}
		
		Map<SellTicketIn,Ticketsell> ticketsells = new HashMap<SellTicketIn, Ticketsell>();
		Long ticketno = null;
		if(localParamSellTicketsIn.getStartTicketNO()!=null){
			ticketno = new Long(localParamSellTicketsIn.getStartTicketNO());
			ticketno = ticketno -1;
		}
		float CarrychildRate = Float.valueOf(parameterService.findParamValue(ParamterConst.Param_1012, organization_depart.getId()))/100;

		List<SellTicketOut> selledtickets = new ArrayList<SellTicketOut>();
		for (Object _sellseat : localParamSellTicketsIn.getSellseats()) {
			cn.nova.ticket.param.local.SellTicketIn sellseat =  (cn.nova.ticket.param.local.SellTicketIn) _sellseat;
			//校验班次状态是否可售
			Ticketprice ticketprice = (Ticketprice) dao.get(LockModeType.PESSIMISTIC_READ,Ticketprice.class, sellseat.getTicketpriceId());
			methodResult = checkSchedulestatus(localParamSellTicketsIn.getSellway(),ticketprice.getScheduleplan().getId(),ticketprice.getDepartstationid(),organization_seller.getIslocal());
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
					result.setResultMsg((new ServiceException("0371")).getExceptionMessage());//半票数超出设定比例
					getContext().setRollbackOnly();
					return result;
				}
			}
			//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
			if(ticketturnoverdetail!=null){
				switch (localParamSellTicketsIn.getSellway().charAt(0)) {
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
				if("1".equals(localParamSellTicketsIn.getPaymethod())){
					ticketturnoverdetail.setNoncashmoney(ticketturnoverdetail.getNoncashmoney().add(sellseat.getPrice()));
					ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
				}
				if("2".equals(localParamSellTicketsIn.getPaymethod())||"3".equals(localParamSellTicketsIn.getPaymethod())){
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
						result.setResultMsg((new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0204",true)).getExceptionMessage());//班次座位记录不存在
						getContext().setRollbackOnly();
						return result;
					}
					else if(!"1".equals(scheduleseat.getStatus())){
						result.setResultMsg((new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0205",true)).getExceptionMessage());//座位不是锁定状态
						getContext().setRollbackOnly();
						return result;
					}
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", ticketprice.getScheduleplan().getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!id.seatno", (short)sellseat.getSeatno()));
					Seatlock seatlock = (Seatlock) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatlock.class, propertyFilters);
					if(seatlock==null){
						//回滚
						result.setResultMsg((new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
								"0206",true)).getExceptionMessage());//锁位记录不存在
						getContext().setRollbackOnly();
						return result;
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
							result.setResultMsg((new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
									"0207",true)).getExceptionMessage());//留座位记录不存在,无法售出留座。
							getContext().setRollbackOnly();
							return result;
						}
						else{
							if("R".equals(seatreserve.getSellstate())){
								seatreserve.setSellstate("S");
								seatreserve.setUpdateby(localParamSellTicketsIn.getOperateUserId());
								seatreserve.setUpdatetime(now);
								dao.merge(seatreserve);
								//如果是订票销售  则减去带儿童数
								if(seatreserve.getCarrychildnum()>0){
									scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-sellseat.getCarrychildnum()));
								}
								//订票服务费  seatreserve.getServiceprice() = detail.getServicefee()
	//								ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().add(seatreserve.getServiceprice()));
	//								ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(seatreserve.getServiceprice()));
							}
							else{
								//回滚
								if("C".equals(seatreserve.getSellstate())){
									result.setResultMsg((new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
											"0208",true)).getExceptionMessage());//留座位记录状态为已取消,无法售出留座。
									getContext().setRollbackOnly();
									return result;
								}
								else if("S".equals(seatreserve.getSellstate())){
									result.setResultMsg((new ServiceException("日期:"+ticketprice.getDepartdate()+"班次号:"+schedule.getCode()+"座位号:"+sellseat.getSeatno(),
											"0209",true)).getExceptionMessage());//留座位记录状态为已售,无法售出留座。
									getContext().setRollbackOnly();
									return result;
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
					//非流水班，如果锁位时没有修改已带儿童数，则售票时检查并修改
					if(seatlock.getCarrychildnum()==null||seatlock.getCarrychildnum()<1){
						if(sellseat.getCarrychildnum()>0
								&&CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()){
							result.setResultMsg((new ServiceException("0270")).getExceptionMessage());//该班次带儿童数量超过最大允许带儿童数量
							getContext().setRollbackOnly();
							return result;
						}
						scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()));
					}
					scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()));
					//更新座位状态
					scheduleseat.setStatus("2");
					scheduleseat.setTickettype(sellseat.getTickettypeCode());
					dao.delete(seatlock);
					scheduleseat.setUpdateby(localParamSellTicketsIn.getOperateUserId());
					scheduleseat.setUpdatetime(now);
					dao.merge(scheduleseat);
				}
			}
			else{
				//流水班，锁位时没有修改已带儿童数，售票时检查并修改
				if(sellseat.getCarrychildnum()>0
						&&CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()){
					result.setResultMsg((new ServiceException("0270")).getExceptionMessage());//该班次带儿童数量超过最大允许带儿童数量
					getContext().setRollbackOnly();
					return result;
				}
				scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+sellseat.getCarrychildnum()));
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
			ticketprice.setUpdateby(localParamSellTicketsIn.getOperateUserId());
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
					_ticketprice.setUpdateby(localParamSellTicketsIn.getOperateUserId());
					_ticketprice.setUpdatetime(now);
					dao.merge(_ticketprice);
				}
			}
			
			scheduleplan.setUpdateby(localParamSellTicketsIn.getOperateUserId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			ticketsell.setBuspark(schedulestatus.getBuspark());
			ticketsell.setCarrychildnum(sellseat.getCarrychildnum());
			ticketsell.setCheckedby(null);
			ticketsell.setCheckstation(null);
			ticketsell.setChecktime(null);
			ticketsell.setCreateby(localParamSellTicketsIn.getOperateUserId());
			ticketsell.setCreatetime(now);
			if(sellseat.getCustomerid()==null||sellseat.getCustomerid()<=0){
				if(vip!=null){
					Customer customer = new Customer();
					customer.setId(vip.getCustomerid());
					ticketsell.setCustomer(customer);
				}else{
					ticketsell.setCustomer(null);
				}
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
			ticketsell.setOrgid(organization_seller.getId());
			ticketsell.setPaymethod(localParamSellTicketsIn.getPaymethod());
			ticketsell.setPrice(sellseat.getPrice());
			ticketsell.setMoreprice(ticketprice.getMoreprice());
			ticketsell.setServicefee(sellseat.getServicefee());
			ticketsell.setReachstationid(ticketprice.getReachstationid());
			ticketsell.setScheduleid(scheduleplan.getScheduleid());
			ticketsell.setScheduleplanid(ticketprice.getScheduleplan().getId());
			ticketsell.setSellby(localParamSellTicketsIn.getOperateUserId());
			ticketsell.setSellip(localParamSellTicketsIn.getOperateIp());
			ticketsell.setSelltime(now);
			ticketsell.setSellway(localParamSellTicketsIn.getSellway());
			if(billinventory==null){
				ticketsell.setBatchno(localParamSellTicketsIn.getBatchno());
			}else{
				ticketsell.setBatchno(billinventory.getBatchno());
			}
			ticketsell.setTicketentrance(schedulestatus.getTicketentrance());
			ticketsell.setTicketoutletsid(localParamSellTicketsIn.getOperateTicketoutletsId());
			ticketsell.setTicketoutletsname(order.getOperateTicketoutletsName());
			ticketsell.setTicketstatus("0"); //正常
			ticketsell.setTickettype(sellseat.getTickettypeCode());
			ticketsell.setUpdateby(localParamSellTicketsIn.getOperateUserId());
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
			ticketsell.setOrderno(localParamSellTicketsIn.getOrderno());
			if(sellseat.getEticketno()!=null){
				ticketsell.setTicketno(sellseat.getEticketno());
			}else{
				ticketno=ticketno+1;
				ticketsell.setTicketno(StringUtils.strPad(ticketno.toString(),localParamSellTicketsIn.getStartTicketNO().length(), "0"));
			}
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String datestr = df.format(ticketsell.getSelltime());
			String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
			String tiksno=AuthcodeEncode.authcodeEncode(cipherStr);
			if("".equals(tiksno)||tiksno==null){
				result.setResult(0);
				result.setResultMsg("数据加密失败！");
				return result;
			}
			ticketsell.setTiksno(tiksno);
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			if(vipconsume!=null){
				//贵宾卡消费记录明细
				Vipconsumeldetail vipconsumeldetail = new Vipconsumeldetail();
				vipconsumeldetail.setCreateby(localParamSellTicketsIn.getOperateUserId());
				vipconsumeldetail.setCreatetime(now);
				vipconsumeldetail.setIsselfschedule(true);
				vipconsumeldetail.setSellid(ticketsell.getId());
				vipconsumeldetail.setVipconsume(vipconsume);
				vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
			}
			ticketsells.put(sellseat,ticketsell);
			dao.getEntityManager().flush();
			
			if((localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.INTERNET || localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.YOUZHEN)
				&&sellseat.getEticketno()!=null){
				//生成Ticketsellother
				Ticketsellother ticketsellother =  new Ticketsellother();
				ticketsellother.setAgentname(organization_seller.getName());
				ticketsellother.setCreateby(localParamSellTicketsIn.getOperateUserId());
				ticketsellother.setCreatetime(now);
				ticketsellother.setEticketid(sellseat.getEticketid());
				ticketsellother.setEticketno(sellseat.getEticketno());
				ticketsellother.setIstaked(false);
				ticketsellother.setOrderno(order.getOrderno());
				if(localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.YOUZHEN){
					ticketsellother.setPassword(ticketsell.getTicketno());
				}else{
					
					ticketsellother.setPassword(sellseat.getEticketauthcode());
				}
				ticketsellother.setPrintby(null);
				ticketsellother.setServiceprice(new BigDecimal(0));
				ticketsellother.setTicketsellid(ticketsell.getId());
				ticketsellother.setUpdateby(0);
				ticketsellother.setUpdatetime(now);
				dao.merge(ticketsellother);
				dao.getEntityManager().flush();
				
			}

			//只有本地售票支持往返站点售票
			if(organization_seller.getIslocal()&&localParamSellTicketsIn.getTicketInvokeType()==TicketInvokeType.STATIONCLIENT){
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
					returntripticket.setTicketno(StringUtils.strPad(ticketno.toString(),localParamSellTicketsIn.getStartTicketNO().length(), "0"));
					returntripticket.setIsselfschedule(true);
					returntripticket.setSellid(ticketsell.getId());
					dao.merge(returntripticket);
					if(ticketturnoverdetail!=null){
						ticketturnoverdetail.setSellreturntripnum(ticketturnoverdetail.getSellreturntripnum()+1);
					}
				}
			}

			selledtickets.add(getTicketPrintInfo(ticketsell.getId()));
		}

		if(vipconsume!=null){
			dao.merge(vipconsume);
		}
		if(ticketturnoverdetail!=null){
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}
		result.setResult(MethodResult.SUCCESS);
		result.setSelledtickets(selledtickets);
		return result;
	}

//	@Override
	@SuppressWarnings("unchecked")
	public SellTicketsOut ticketRePrintAndChangeTicketNo(
			long ticketsellid, String curTicketNo,long userid,long ticketoutletsid,String ip) throws ServiceException {
		SellTicketsOut result = new SellTicketsOut();
		result.setSelledtickets(new ArrayList<SellTicketOut>());
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
	
	@SuppressWarnings("unchecked")
	private SellTicketOut getTicketPrintInfo(long ticketsellid){
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class,ticketsellid);
		SellTicketOut result = new SellTicketOut();

		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, ticketsell.getScheduleplanid());
		Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
		Route route = schedule.getRoute();
		
		Station departStation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
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
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
		Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult(Ticketsellother.class,propertyFilters);
		if(ticketsellother!=null){
			result.setEticketauthcode(ticketsellother.getPassword());
			result.setEticketid(ticketsellother.getEticketid());
			result.setEticketno(ticketsellother.getEticketno());
		}
		//取数据字典
//		result.setWorkways(dictionaryService.getColumnValue("schedule", "workways", scheduleplan.getWorkways()));
		result.setWorkways("AB");
		return result;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public AvailableTicketOut GetAvailableTicket(String usercode,
			String curTicketNo) {
		AvailableTicketOut result = new AvailableTicketOut();
		try {
			// 取出票据类型id及长度
			Billinuse billinuse = new Billinuse();
			Billtype billtype = getBilltypeService().findByCode(TICKETBILLCODE);
			billinuse.setBilltypeid(billtype.getId());
			Userinfo userinfo = getUserinfoDao().getByCode(usercode);
			if(userinfo==null){
				getContext().setRollbackOnly();
				result.setResultMsg("找不到用户:"+usercode);
				return result;
			}
			billinuse.setRecipients(userinfo.getId());
			if(curTicketNo!=null&&!curTicketNo.trim().equals("")){
				billinuse.setNextno(new Long(curTicketNo));				
			}
			MethodResult _methodResult = billinuseService.initBillNo(billinuse);
			if (_methodResult.getObject() != null) {
				billinuse = (Billinuse) _methodResult.getObject();
				Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid());
				result.setBatchno(billinventory.getBatchno());
				result.setCurticketno(StringUtils.strPad(new Long(billinuse.getNextno()).toString(),(int) billtype.getTicketnolength(), "0"));
				result.setEndticketno(StringUtils.strPad(new Long(billinuse.getEndno()).toString(),(int) billtype.getTicketnolength(), "0"));
			}else{
				getContext().setRollbackOnly();
				result.setResultMsg("用户:"+usercode+"没有领票记录");
				return result;
			}
		} catch (Exception e) {
			getContext().setRollbackOnly();
			result.setResultMsg(e.toString());
			return result;
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	
	private String checkAndConvertBilldamageParam(BilldamageIn paramBilldamageIn){
		String errmsg = checkAndConvertTicketRemoteInvokeCommonProperty(paramBilldamageIn,TicketOP.BILLDAMAGE);
		if(errmsg!=null){
			return errmsg;
		}
		if(paramBilldamageIn.getUsercode()==null){
			return "领票人编码不允许为空";
		}
		Userinfo recipientUser = getUserinfoDao().getByCode(paramBilldamageIn.getUsercode());
		if(recipientUser==null){
			return "找不到用户:"+paramBilldamageIn.getUsercode();
		}
		if(paramBilldamageIn.getCurticketno()==null||paramBilldamageIn.getCurticketno().trim().equals("")){
			return "当前票号不允许为空";
		}
		if(paramBilldamageIn.getBatchno()==null||paramBilldamageIn.getBatchno().trim().equals("")){
			return "批次号不允许为空";
		}
		if(paramBilldamageIn.getDamagednum()<=0){
			return "坏票登记数必须大于零";
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public MethodResult billdamage(BilldamageIn paramBilldamageIn) {
		MethodResult result = new MethodResult();
		String errmsg = checkAndConvertBilldamageParam(paramBilldamageIn);
		if(errmsg!=null){
			result.setResultMsg(errmsg);
			return result;
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		try {
			Billinuse billinuse = new Billinuse();
			Userinfo recipientUser = getUserinfoDao().getByCode(paramBilldamageIn.getUsercode());
			billinuse.setRecipients(recipientUser.getId());
			billinuse.setNextno(new Long(paramBilldamageIn.getCurticketno()));				
			// 取出票据类型id及长度
			Billtype billtype = getBilltypeService().findByCode(TICKETBILLCODE);
			billinuse.setBilltypeid(billtype.getId());
			MethodResult _methodResult = getBillinuseService().initBillNo(billinuse);
			if (_methodResult.getObject() != null) {
				billinuse = (Billinuse) _methodResult.getObject();
				if(new Long(paramBilldamageIn.getCurticketno())!=billinuse.getNextno()){
					getContext().setRollbackOnly();
					result.setResultMsg("输入的当前票号错误，当前票号为："+StringUtils.strPad(new Long(billinuse.getNextno()).toString(),(int) billtype.getTicketnolength(), "0"));
					return result;
				}
				if(paramBilldamageIn.getDamagednum()>billinuse.getEndno()-billinuse.getNextno()+1){
					getContext().setRollbackOnly();
					result.setResultMsg("该票段只剩"+new Long(billinuse.getEndno()-billinuse.getNextno()+1)+"张票，小于您要登记的张数"+paramBilldamageIn.getDamagednum());
					return result;
				}
				Billdamaged billdamaged = new Billdamaged();
				billdamaged.setId(0);
				billdamaged.setAmount(paramBilldamageIn.getDamagednum());
				billdamaged.setBillinuseid(billinuse.getId());
				billdamaged.setBilltypeid(billtype.getId());
				billdamaged.setCreateby(paramBilldamageIn.getOperateUserId());
				billdamaged.setCreatetime(now);
				billdamaged.setDamageddscribe(paramBilldamageIn.getReason());
				billdamaged.setEndno(billinuse.getNextno()+paramBilldamageIn.getDamagednum()-1);
				billdamaged.setRecordby(paramBilldamageIn.getOperateUserId());
				billdamaged.setRecordip(paramBilldamageIn.getOperateIp());
				billdamaged.setRecordtime(now);
				billdamaged.setStartno(billinuse.getNextno());
				if(paramBilldamageIn.getOperateTicketoutletsCode()!=null&&!paramBilldamageIn.getOperateTicketoutletsCode().equals("")){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!code", paramBilldamageIn.getOperateTicketoutletsCode()));
					Ticketoutlets ticketoutlets = (Ticketoutlets) dao.uniqueResult(Ticketoutlets.class,propertyFilters);
					billdamaged.setTicketoutletsid(ticketoutlets.getId());
				}else{
					billdamaged.setTicketoutletsid(0L);
				}
				billdamaged.setUpdateby(paramBilldamageIn.getOperateUserId());
				billdamaged.setUpdatetime(now);
				getBilldamagedService().save(billdamaged, recipientUser.getId());
			}else{
				getContext().setRollbackOnly();
				result.setResultMsg("用户:"+paramBilldamageIn.getUsercode()+"没有领票记录");
				return result;
			}
		} catch (Exception e) {
			getContext().setRollbackOnly();
			result.setResultMsg(e.toString());
			return result;
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	@Override
	public TicketReturnQrysOut ticketRetrunQry(String orderno,
			List<String> ticketnos) {
		TicketReturnQrysOut result = new TicketReturnQrysOut();
		result = ticketCancelQry(orderno,ticketnos);
		if(result.getParamTicketReturnQryOut()!=null){
			for (TicketReturnQryOut paramTicketReturnQryOut : result.getParamTicketReturnQryOut()) {
				if(paramTicketReturnQryOut.getCharges()==null){
					paramTicketReturnQryOut.setRate(getReturnRate(paramTicketReturnQryOut.getDepartdate(),paramTicketReturnQryOut.getDeparttime(),0));
					paramTicketReturnQryOut.setCharges(paramTicketReturnQryOut.getTicketprice().multiply(paramTicketReturnQryOut.getRate()));
				}else{
					paramTicketReturnQryOut.setRate(paramTicketReturnQryOut.getCharges().divide(paramTicketReturnQryOut.getTicketprice()));
				}
			}
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public TicketReturnQrysOut ticketCancelQry(String orderno,
			List<String> ticketnos) {
		TicketReturnQrysOut result = new TicketReturnQrysOut();
		if(orderno==null||orderno.equals("")){
			result.setResultMsg("订单号不允许为空");
			return result;
		}
		if(ticketnos==null||ticketnos.size()==0){
			result.setResultMsg("订单号不允许为空");
			return result;
		}

		StringBuilder sql = new StringBuilder();
		sql.append("select ")
		.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
		.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.paymethod,")
		.append(" tsl.price as ticketprice,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
		.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
		.append(" tsl.departstationid,tsl.reachstationid,tsl.carrychildnum,")
		.append(" tsg.charges, tsg.signreason,tsg.signtime,")
		.append(" sc.code as schedulecode,")
		.append(" std.name as departstationname,")
		.append(" str.name as reachstationname,ss.status,tot.code as ticketoutletscode,tot.name as ticketoutletsidname")
		.append(" ,tsl.orderno, null as rate")
		
		.append(" from Ticketsell tsl left join Ticketsign tsg")
		.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=1")
		.append(" ,Schedule sc,Station std,Station str,Schedulestatus ss ,Userinfo usell,Ticketoutlets tot")
		.append(" where tsl.scheduleid=sc.id")
		.append(" and tsl.departstationid=std.id")
		.append(" and tsl.reachstationid=str.id")
		.append(" and tsl.departstationid=ss.departstationid")
		.append(" and tsl.scheduleplanid=ss.scheduleplanid")
		.append(" and tsl.sellby=usell.id")
		.append(" and tsl.orderno='").append(orderno).append("'")
		.append(" and tsl.ticketoutletsid=tot.id")
		;
		sql.append(" and (");
		int i=0;
		for (String ticketno : ticketnos) {
			if(i==0){
				sql.append(" tsl.ticketno='").append(ticketno).append("'");
			}else{
				sql.append(" or tsl.ticketno='").append(ticketno).append("'");
			}
			i++;
		}
		sql.append(" )");
		sql.append(" order by tsl.ticketno");

		Query query = dao.getEntityManager().createNativeQuery(sql.toString(),TicketReturnQryOut.class);
		result.setParamTicketReturnQryOut(query.getResultList());
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	
	private BigDecimal getReturnRate(Date departdate,String departtime,long orgid){
		Date departdatetime = DateUtils.mergerDateAndTime(departdate,departtime);
		Date now = new Date();
		/*long hoursbetweendeparttime = (departdatetime.getTime()-now.getTime())%1000%60%60;
		if(hoursbetweendeparttime<0){
			hoursbetweendeparttime--;
		}*/
		BigDecimal hoursbetweendeparttime=new BigDecimal(0);
		hoursbetweendeparttime=(new BigDecimal(departdatetime.getTime()-now.getTime())).
		divide(new BigDecimal(1000)).divide(
		new BigDecimal(60),BigDecimal.ROUND_UP).divide(
				new BigDecimal(60),BigDecimal.ROUND_UP);
		return getTicketreturnrateService().getticketreturnrate(orgid, hoursbetweendeparttime);
	}

	

	private String checkAndConvertReturnParam(ReturnTicketsIn paramReturnTicketsIn){
		String errmsg = checkAndConvertTicketRemoteInvokeCommonProperty(paramReturnTicketsIn,TicketOP.RETURN);
		if(errmsg!=null){
			return errmsg;
		}
		return null;
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	public ReturnTicketsOut returnticket(ReturnTicketsIn paramReturnTicketsIn){

		checkClientOrgIp(paramReturnTicketsIn);
		ReturnTicketsOut result = new ReturnTicketsOut();

		String errmsg = checkAndConvertReturnParam(paramReturnTicketsIn);
		if(errmsg!=null){
			getContext().setRollbackOnly();
			result.setResultMsg(errmsg);
			return result;
		}
		
		Organization organization_opposite = organizationService.getOrgByCode(paramReturnTicketsIn.getOppositeOrgcode());
		Organization organization_return = organizationService.getOrgByCode(paramReturnTicketsIn.getOperateOrgcode());
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		//插入或修改应缴款表
		String billtypecode = parameterService.findParamValue(ParamterConst.Param_1102,  organization_opposite.getId());
		Billtype billtype = billtypeService.findByCode(billtypecode);
//		Billinuse billinuse = null;
		Billinventory billinventory = null;
//		Schedule schedule = null;
		Ticketturnoverdetail ticketturnoverdetail = null;
		Date now = new Date();
		String param1101 = parameterService.findParamValue(ParamterConst.Param_1101, organization_opposite.getId()); 
		//调用者属于本地机构的，才需要检票票段、记录缴款明细表的票证
		if(organization_return.getIslocal()
				&&paramReturnTicketsIn.getTicketInvokeType()!=TicketInvokeType.INTERNET
				&&paramReturnTicketsIn.getTicketInvokeType()!=TicketInvokeType.ONECARD){
			int printreturnnum = 0;
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1101)){
				for (ReturnTicketIn ticketreturn : paramReturnTicketsIn.getReturnTickets()) {
					if(ticketreturn.getCharge()!=null&&ticketreturn.getCharge().floatValue()>0){
						printreturnnum++;
					}
				}
			}
			if(printreturnnum>0){
				if(paramReturnTicketsIn.getReturnPrintStartNo()==null){
					getContext().setRollbackOnly();
					result.setResultMsg("退票凭证起始票号不允许为空");
					return result;
				}
				if(!paramReturnTicketsIn.getBillCustomManage()){
					//判断当前票号是否正确
					Billinuse billinuse = null;
					try {
						billinuse = billinuseService.jumpBillinuse(paramReturnTicketsIn.getOperateUserId(),billtypecode,paramReturnTicketsIn.getReturnPrintStartNo(),printreturnnum);
					} catch (ServiceException e) {
						getContext().setRollbackOnly();
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
					billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
					
					if(paramReturnTicketsIn.getOperateUserId()>0&&billtypecode.equals("Ticket")){
						//插入或修改应缴款表
						ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(paramReturnTicketsIn.getOperateUserId(), paramReturnTicketsIn.getReturnPrintStartNo());
						if(ParamterConst.COMMON_FLAG.FALG_NO.equals(ticketturnoverdetail.getTicketstartno())){
							ticketturnoverdetail.setTicketstartno(paramReturnTicketsIn.getReturnPrintStartNo());
						}
						ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(new Long(paramReturnTicketsIn.getReturnPrintStartNo())+printreturnnum-1).toString(),paramReturnTicketsIn.getReturnPrintStartNo().length(), "0"));
						ticketturnoverdetail.setReturnprintnum(ticketturnoverdetail.getReturnprintnum()+printreturnnum);
						ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+paramReturnTicketsIn.getReturnTickets().size());
						ticketturnoverdetail.setUpdateby(paramReturnTicketsIn.getOperateUserId());
						ticketturnoverdetail.setUpdatetime(now);
						//缴款明细表加字段
						ticketturnoverdetail.setBatchno(billinventory.getBatchno());
						ticketturnoverdetail.setBillinuseid(billinuse.getId());
						ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
					}
				}
				else{
					if(paramReturnTicketsIn.getBillSectionCheck()){
						//校验传入的票号
						StringBuilder sb = new StringBuilder();
						sb.append("select bi from Billinuse bi ")
						.append(" where bi.startno<=").append(paramReturnTicketsIn.getReturnPrintStartNo()).append(" and bi.endno>=").append(paramReturnTicketsIn.getReturnPrintStartNo())
						.append(" and bi.recipients=").append(paramReturnTicketsIn.getOperateUserId());
						List<Billinuse> bis = dao.find(sb.toString());
						if(bis==null||bis.size()==0){
							result.setResultMsg((new ServiceException("0170")).getExceptionMessage());//传入的当前票号与数据库不一致
							getContext().setRollbackOnly();
							return result;
						}
						billinventory = (Billinventory) dao.get(Billinventory.class, bis.get(0).getBillinventoryid()); 
					}
				}
			}
		}else if (organization_return.getIslocal()
				  &&paramReturnTicketsIn.getTicketInvokeType()==TicketInvokeType.ONECARD
				  &&paramReturnTicketsIn.getOperateUserId()>0){
			//本地一卡通要记录应缴款表
			ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(paramReturnTicketsIn.getOperateUserId(), paramReturnTicketsIn.getReturnPrintStartNo());
			ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+paramReturnTicketsIn.getReturnTickets().size());
			ticketturnoverdetail.setUpdateby(paramReturnTicketsIn.getOperateUserId());
			ticketturnoverdetail.setUpdatetime(now);
			//缴款明细表加字段
			ticketturnoverdetail.setBatchno(paramReturnTicketsIn.getReturnbatchno());
			ticketturnoverdetail.setBillinuseid(0);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}
		
		Vip vip = null;
		Vipconsume vipconsume = null;
		List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
		result.setReturnTickets(new ArrayList<ReturnTicketOut>());
		//退票
		long voucherno = 0;
		if(paramReturnTicketsIn.getReturnPrintStartNo()!=null&&!"0".equals(paramReturnTicketsIn.getReturnPrintStartNo())){
			voucherno = new Long(paramReturnTicketsIn.getReturnPrintStartNo());
		}
		BigDecimal totalreturnhandcharge = new BigDecimal(0);
		BigDecimal totalreturnmoney = new BigDecimal(0);
		int printreturnnum = 0;
		
		for (ReturnTicketIn paramReturnTicketIn : paramReturnTicketsIn.getReturnTickets()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("GED_t!departdate", DateUtils.add(DateUtils.trunc(now), -31)));//只取近一个月内发车的车票
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", paramReturnTicketIn.getTicketno()));
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", paramReturnTicketIn.getOrderno()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
			if(ticketsell==null){
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("找不到订单号为"+paramReturnTicketIn.getOrderno()+"，票号为"+paramReturnTicketIn.getTicketno()+"的车票");
				return result;
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				ServiceException e = new ServiceException("0176");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				ServiceException e = new ServiceException("0177");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			else if(ticketsell.getIschecked()){
				ServiceException e = new ServiceException("0178");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
			String para1105 = parameterService.findParamValue(ParamterConst.Param_1105, schedule.getOrgid());
			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setId(0);
			if(paramReturnTicketIn.getCharge()==null){
				BigDecimal rate=getReturnRate(ticketsell.getDepartdate(),ticketsell.getDeparttime(),schedule.getOrgid());
				//ticketreturn.setCharges(ticketsell.getPrice().multiply(getReturnRate(ticketsell.getDepartdate(),ticketsell.getDeparttime(),schedule.getOrgid())));
				if(("1").equals(para1105)){
					ticketreturn.setCharges((ticketsell.getPrice().multiply(rate)).setScale(0, BigDecimal.ROUND_HALF_UP));
					
				}else if(("2").equals(para1105)){
					ticketreturn.setCharges(new BigDecimal((int)Math.floor(Double.parseDouble(ticketsell.getPrice().multiply(rate).toString()))));
					
				}else if(("3").equals(para1105)){
					ticketreturn.setCharges(new BigDecimal((int)Math.floor(Double.parseDouble(ticketsell.getPrice().multiply(rate).toString()))+1));
					
				}else if (("4").equals(para1105)){
					//去掉小数之后的值
					double dd = Double.parseDouble(ticketsell.getPrice().multiply(rate).toString());
					int ddint = (int) dd;
					//小数的值
					BigDecimal  decimal=new BigDecimal(dd-ddint);
					BigDecimal  returncharges=new BigDecimal((int)Math.floor(Double.parseDouble(ticketsell.getPrice().multiply(rate).toString())));
					int reslet_compareTo=decimal.compareTo(new BigDecimal(0));
					int reslet_compare=decimal.compareTo(new BigDecimal(0.5));
					if(reslet_compareTo<=0){
						ticketreturn.setCharges(returncharges);						
					}else if(reslet_compareTo>0 && reslet_compare<=0){
						//1毛进5毛
						ticketreturn.setCharges(new BigDecimal((int)Math.floor(Double.parseDouble(ticketsell.getPrice().multiply(rate).toString()))+0.5));
						
					}else{
						//5毛进一块
						ticketreturn.setCharges(new BigDecimal((int)Math.floor(Double.parseDouble(ticketsell.getPrice().multiply(rate).toString()))+1));
						
					}
				}
			
			}else{
				ticketreturn.setCharges(paramReturnTicketIn.getCharge());
			}
			ticketreturn.setCreateby(paramReturnTicketsIn.getOperateUserId());
			ticketreturn.setCreatetime(now);
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setRemarks(paramReturnTicketsIn.getRemarks());
			ticketreturn.setReturnamount(ticketsell.getPrice().subtract(ticketreturn.getCharges()));
			ticketreturn.setReturnby(paramReturnTicketsIn.getOperateUserId());
			ticketreturn.setReturnip(paramReturnTicketsIn.getOperateIp());
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnway(paramReturnTicketsIn.getReturnway());
			ticketreturn.setSellid(ticketsell.getId());
			ticketreturn.setTicketoutletsid(paramReturnTicketsIn.getOperateTicketoutletsId());
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setUpdateby(paramReturnTicketsIn.getOperateUserId());
			ticketreturn.setUpdatetime(now);
			
			//统计退票金额、打印退票凭证的数量
			totalreturnhandcharge = totalreturnhandcharge.add(ticketreturn.getCharges());
			totalreturnmoney = totalreturnmoney.add(ticketreturn.getReturnamount());
			if(ticketreturn.getCharges().floatValue()>0){
				printreturnnum++;
			}
			//普通退票过了发车时间且没有签手续费的不允许退票
			if("0".equals(ticketreturn.getReturnway())){
				//判断是否签票
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketreturn.getSellid()));
				Ticketsign ticketsign = (Ticketsign) dao.uniqueResult(Ticketsign.class, propertyFilters);
				if(ticketsign==null){
					//判断发班状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));
					Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
					if(schedulestatus.getIsdeparted()){
						ServiceException e = new ServiceException("0179"); //该车票所在的班次已经发班，不允许普通退票。请先签定手续费率或使用其它退票方式
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}

					//判断发车时间
					//0265  该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
					Calendar calendar_now = Calendar.getInstance();
					Calendar calendar_departtime = Calendar.getInstance();
					calendar_departtime.setTime(schedulestatus.getDepartdate());
					calendar_departtime.set(calendar_departtime.get(Calendar.YEAR), 
									calendar_departtime.get(Calendar.MONTH), 
									calendar_departtime.get(Calendar.DAY_OF_MONTH), 
									Integer.valueOf(schedulestatus.getDeparttime().substring(0,2)),
									Integer.valueOf(schedulestatus.getDeparttime().substring(3)),
									0);
					if(calendar_now.after(calendar_departtime)){
						ServiceException e = new ServiceException("0265"); ////该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
				}
			}
			if(!ticketsell.getIslinework()){
				//检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
				if(scheduleseat==null){
					//回滚
					ServiceException e = new ServiceException("票号"+ticketsell.getTicketno(),"0204",true); //班次座位记录不存在
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				else if(!"2".equals(scheduleseat.getStatus())){
					ServiceException e = new ServiceException("票号"+ticketsell.getTicketno(),"0263",true); //座位不是售出状态
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(paramReturnTicketsIn.getOperateUserId());
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}
			ticketsell.setTicketstatus("1"); //退票
			ticketsell.setUpdateby(paramReturnTicketsIn.getOperateUserId());
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);

			ticketreturn.setCreateby(paramReturnTicketsIn.getOperateUserId());
			ticketreturn.setCreatetime(now);
			ticketreturn.setUpdateby(paramReturnTicketsIn.getOperateUserId());
			ticketreturn.setUpdatetime(now);
			ticketreturn.setReturnby(paramReturnTicketsIn.getOperateUserId());
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnip(paramReturnTicketsIn.getOperateIp());
			
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1101)
					&&ticketreturn.getCharges()!=null
					&&ticketreturn.getCharges().floatValue()>0
					&&voucherno>0){
				ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(voucherno++).toString(),paramReturnTicketsIn.getReturnPrintStartNo().length(), "0"));
				ticketreturn.setBilltype(billtype);
				if(billinventory!=null){
					ticketreturn.setBatchno(billinventory.getBatchno());
				}else{
					ticketreturn.setBatchno(paramReturnTicketsIn.getReturnbatchno());
				}
			}
			else{
				ticketreturn.setReturnvoucherno(null);
				ticketreturn.setBilltype(null);
			}
			if(ticketturnoverdetail!=null){
				ticketreturn.setTurnoverdetailid(ticketturnoverdetail.getId());
			}
			
			ticketreturn = (Ticketreturn) dao.merge(ticketreturn);
			ticketreturns.add(ticketreturn);
			//判断是否属于VIP卡余额支付
			if(ticketsell.getPaymethod().equals("2")){
				if(paramReturnTicketsIn.getVipcardno()!=null){
					vip = vipconsumeService.getConsumeVip(true, ticketsell.getId());
					if(vip == null){
						//异站售本站票时，本站没有产生消费记录，无法查出VIP信息
						vip = vipService.findByCardNo(paramReturnTicketsIn.getVipcardno(),"0");
					}
					if(vip == null){
						ServiceException e = new ServiceException("0411");//找不到VIP卡信息		
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}else if(!"0".equals(vip.getStatus())){//状态：0正常,1已退,2挂失,3注销,4过期,5已补卡 取数据字典
						ServiceException e = new ServiceException("0411");//VIP卡当前状态异常	
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
					//判断要退票的所有车票购票所用VIP卡是否为同一张卡
					if(!vip.getVipcardno().equals(paramReturnTicketsIn.getVipcardno())){
						ServiceException e = new ServiceException("0414");
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
					if(vipconsume==null){
						vip.setVipgrade(paramReturnTicketsIn.getVipgrade());
						vip.setMoney(paramReturnTicketsIn.getVipmoney());
						vip.setVipamount(paramReturnTicketsIn.getVippoint());
						
						vipconsume = new Vipconsume();
						vipconsume.setCreateby(paramReturnTicketsIn.getOperateUserId());
						vipconsume.setCreatetime(now);
						vipconsume.setUpdateby(vipconsume.getCreateby());
						vipconsume.setUpdatetime(vipconsume.getCreatetime());
						vipconsume.setType("1"); //余额购票后退票
//						vipconsume.setMoneychange(totalreturnmoney);
//						vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
//						vipconsume.setPointchange(totalreturnmoney.multiply(new BigDecimal(-1)));
//						vipconsume.setRemainpoint(vip.getVipamount().add(vipconsume.getPointchange()));
						vipconsume.setVipcardno(vip.getVipcardno());
						vipconsume.setVipconsumeldetails(new ArrayList<Vipconsumeldetail>());
						vipconsume.setVipgrade(vip.getVipgrade());
						vipconsume.setVipid(vip.getId());
						
					}
				}else{
					//没有传入卡号，但支付方式为 余额支付或积分支付
					ServiceException e = new ServiceException("0413");//VIP卡号不允许为空
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}

				//贵宾卡消费记录明细
				Vipconsumeldetail vipconsumeldetail = new Vipconsumeldetail();
				vipconsumeldetail.setCreateby(paramReturnTicketsIn.getOperateUserId());
				vipconsumeldetail.setCreatetime(now);
				vipconsumeldetail.setIsselfschedule(true);
				vipconsumeldetail.setSellid(ticketsell.getId());
				vipconsumeldetail.setVipconsume(vipconsume);
				vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
			}

			//锁定班次并更新剩余票数
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-1));
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(paramReturnTicketsIn.getOperateUserId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum((short) (_ticketprice.getSoldeatnum()-1));
				_ticketprice.setUpdateby(paramReturnTicketsIn.getOperateUserId());
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}

			if(ticketsell.getTicketoutletsid()>0){
				//0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if(ticketturnoverdetail!=null&&"2".equals(ticketsell.getPaymethod())||"3".equals(ticketsell.getPaymethod())){
					ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
				}
			}
			//Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
			Station departstation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
			Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
			ReturnTicketOut paramReturnTicketOut = new ReturnTicketOut();

			paramReturnTicketOut.setIsselfschedule(true);//TODO 同时支持退本站售退异站票（被发车站调用）
			paramReturnTicketOut.setOrderno(ticketsell.getOrderno());
			paramReturnTicketOut.setBatchno(ticketsell.getBatchno());//售票票号的批次号
			paramReturnTicketOut.setTicketno(ticketsell.getTicketno());
			paramReturnTicketOut.setScheduleCode(schedule.getCode());
			paramReturnTicketOut.setTickettypeCode(ticketsell.getTickettype());
			paramReturnTicketOut.setDepartdate(ticketsell.getDepartdate());
			paramReturnTicketOut.setDeparttime(ticketsell.getDeparttime());
			paramReturnTicketOut.setSeatno(new Short(ticketsell.getSeatno()).toString());
			paramReturnTicketOut.setDepartStationCode(departstation.getCode());
			paramReturnTicketOut.setDepartStationName(departstation.getName());
			paramReturnTicketOut.setReachStationCode(reachstation.getCode());
			paramReturnTicketOut.setReachStationName(reachstation.getName());
			paramReturnTicketOut.setSelltime(ticketsell.getSelltime());
			paramReturnTicketOut.setPrice(ticketsell.getPrice());
			paramReturnTicketOut.setCharge(ticketreturn.getCharges());

			paramReturnTicketOut.setReturnbatchno(ticketreturn.getBatchno()); //退票凭证批次号
			paramReturnTicketOut.setReturnvoucherno(ticketreturn.getReturnvoucherno()); //退票凭证号
			if(ticketreturn.getBilltype()!=null){
				paramReturnTicketOut.setReturnBilltypecode(ticketreturn.getBilltype().getCode()); //退票凭证票据类型编码
			}else{
				paramReturnTicketOut.setReturnBilltypecode(null); //退票凭证票据类型编码
			}
			result.getReturnTickets().add(paramReturnTicketOut);
		}

		if(vipconsume!=null){
			vipconsume.setMoneychange(totalreturnmoney);
			vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
			vipconsume.setPointchange(totalreturnmoney.multiply(new BigDecimal(-1)));
			vipconsume.setRemainpoint(vip.getVipamount().add(vipconsume.getPointchange()));
			vip.setMoney(vipconsume.getRemainmoney());
			vip.setVipamount(vipconsume.getRemainpoint());
			vip = (Vip) dao.merge(vip);
			dao.merge(vipconsume);
		}
		if(ticketturnoverdetail!=null){
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(totalreturnmoney));
			ticketturnoverdetail.setReturnhandcharge(ticketturnoverdetail.getReturnhandcharge().add(totalreturnhandcharge));
			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(totalreturnmoney));
			
			ticketturnoverdetail.setUpdateby(paramReturnTicketsIn.getOperateUserId());
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	

	private String checkAndConvertCancelParam(CancelTicketsIn paramCancelTicketsIn){
		String errmsg = checkAndConvertTicketRemoteInvokeCommonProperty(paramCancelTicketsIn,TicketOP.CANCEL);
		if(errmsg!=null){
			return errmsg;
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public CancelTicketsOut cancelticket(CancelTicketsIn paramCancelTicketsIn){

		checkClientOrgIp(paramCancelTicketsIn);
		CancelTicketsOut result = new CancelTicketsOut();

		String errmsg = checkAndConvertCancelParam(paramCancelTicketsIn);
		if(errmsg!=null){
			getContext().setRollbackOnly();
			result.setResultMsg(errmsg);
			return result;
		}
		
		Organization organization_cancel = organizationService.getOrgByCode(paramCancelTicketsIn.getOperateOrgcode());
		Date now = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = null;
		if(organization_cancel.getIslocal()
				&&!paramCancelTicketsIn.getBillCustomManage()
				&&paramCancelTicketsIn.getTicketInvokeType()!=TicketInvokeType.INTERNET
				&&paramCancelTicketsIn.getTicketInvokeType()!=TicketInvokeType.ONECARD){
			ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(paramCancelTicketsIn.getOperateUserId(), null);
			ticketturnoverdetail.setCancelnum(ticketturnoverdetail.getCancelnum()+paramCancelTicketsIn.getCancelTickets().size());
			ticketturnoverdetail.setUpdateby(paramCancelTicketsIn.getOperateUserId());
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}else if (organization_cancel.getIslocal()
				  &&paramCancelTicketsIn.getTicketInvokeType()==TicketInvokeType.ONECARD
				  &&paramCancelTicketsIn.getOperateUserId()>0){
			//本地一卡通要记录应缴款表
			ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(paramCancelTicketsIn.getOperateUserId(), null);
			ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+paramCancelTicketsIn.getCancelTickets().size());
			ticketturnoverdetail.setUpdateby(paramCancelTicketsIn.getOperateUserId());
			ticketturnoverdetail.setUpdatetime(now);
			//缴款明细表加字段
			ticketturnoverdetail.setBatchno("2222");
			ticketturnoverdetail.setBillinuseid(0);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		}
		List<Ticketcancel> ticketcancels = new ArrayList<Ticketcancel>();
		Ticketoutlets ticketoutlets = null;
		Long selluserid = null;
		result.setCancelTickets(new ArrayList<CancelTicketOut>());
		for (CancelTicketIn paramCancelTicketIn : paramCancelTicketsIn.getCancelTickets()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("GED_t!departdate", DateUtils.add(DateUtils.trunc(now), -31)));//只取一个月内发车的车票
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", paramCancelTicketIn.getTicketno()));
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", paramCancelTicketIn.getOrderno()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
			if(ticketsell==null){
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("找不到订单号为"+paramCancelTicketIn.getOrderno()+"，票号为"+paramCancelTicketIn.getTicketno()+"的车票");
				return result;
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				ServiceException e = new ServiceException("0188");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				ServiceException e = new ServiceException("0189");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			else if(ticketsell.getIschecked()){
				ServiceException e = new ServiceException("0190");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());

			//普通废票过了时间不允许废票
			if("0".equals(paramCancelTicketsIn.getCancelway())){
				String outtimestr = parameterService.findParamValue(ParamterConst.Param_1401, schedule.getOrgid());
				int outtime = 10;
				try {
					outtime = new Integer(outtimestr);
				} catch (Exception e) {
					
				}
				
				Calendar cdnow = Calendar.getInstance();
				cdnow.setTime(new Date());
				Calendar cdselltime = Calendar.getInstance();
				cdselltime.setTime(ticketsell.getSelltime());
				cdselltime.add(Calendar.MINUTE, outtime);
				if(cdnow.after(cdselltime)){
					ServiceException e = new ServiceException("0191"); //普通废票过了时间不允许废票
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
			}
			
			Ticketcancel ticketcancel = new Ticketcancel();
			ticketcancel.setId(0);
			ticketcancel.setCancelway(paramCancelTicketsIn.getCancelway());
			ticketcancel.setCancelby(paramCancelTicketsIn.getOperateUserId());
			ticketcancel.setCancelip(paramCancelTicketsIn.getOperateIp());
			ticketcancel.setCanceltime(now);
			ticketcancel.setCreateby(paramCancelTicketsIn.getOperateUserId());
			ticketcancel.setCreatetime(now);
			ticketcancel.setIsselfschedule(true);
			ticketcancel.setRemarks(paramCancelTicketsIn.getRemarks());
			ticketcancel.setSellid(ticketsell.getId());
			if(ticketoutlets==null){
				ticketcancel.setTicketoutletsid(0L);
			}else{
				ticketcancel.setTicketoutletsid(ticketoutlets.getId());
			}
			ticketcancel.setTicketprice(ticketsell.getPrice());
			ticketcancel.setUpdateby(paramCancelTicketsIn.getOperateUserId());
			ticketcancel.setUpdatetime(now);
			ticketcancel.setSellby(ticketsell.getSellby());
			if(selluserid==null){
				selluserid=ticketcancel.getSellby();
			}else{
				if(selluserid!=ticketcancel.getSellby()){
					ServiceException e = new ServiceException("0192");//废票不能同时废不同售票员售出的车票
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
			}
			
			//更新应缴款表
			if(ticketturnoverdetail!=null){
				ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(ticketcancel.getTicketprice()).subtract(ticketsell.getServicefee()));
				ticketturnoverdetail.setCancelmoney(ticketturnoverdetail.getCancelmoney().add(ticketcancel.getTicketprice()));
				if("6".equals(ticketsell.getSellway())){
					ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().subtract(ticketsell.getServicefee()));
				}
				else if("1".equals(ticketsell.getSellway())||"2".equals(ticketsell.getSellway())){
					ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().subtract(ticketsell.getServicefee()));
				} 
				//0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if("2".equals(ticketsell.getPaymethod())||"3".equals(ticketsell.getPaymethod())){
					ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketcancel.getTicketprice()));
				}
				ticketcancel.setTurnoverdetailid(ticketturnoverdetail.getId());
			}

			ticketcancel=(Ticketcancel) dao.merge(ticketcancel);
			ticketcancels.add(ticketcancel);

			ticketsell.setTicketstatus("2"); //废票
			ticketsell.setUpdateby(paramCancelTicketsIn.getOperateUserId());
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);
			
			if(!ticketsell.getIslinework()){
				//检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
				if(scheduleseat==null){
					ServiceException e = new ServiceException("票号"+ticketsell.getTicketno(),"0204",true); //班次座位记录不存在
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				else if(!"2".equals(scheduleseat.getStatus())){
					ServiceException e = new ServiceException("票号"+ticketsell.getTicketno(),"0263",true); //座位不是售出状态
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(paramCancelTicketsIn.getOperateUserId());
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}

			//锁定班次并更新剩余票数
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-1));
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(paramCancelTicketsIn.getOperateUserId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum((short) (_ticketprice.getSoldeatnum()-1));
				_ticketprice.setUpdateby(paramCancelTicketsIn.getOperateUserId());
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}
			Station departstation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
			Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
			CancelTicketOut paramCancelTicketOut = new CancelTicketOut();

			paramCancelTicketOut.setIsselfschedule(true);//TODO 同时支持废本站售退异站票（被发车站调用）
			paramCancelTicketOut.setOrderno(ticketsell.getOrderno());
			paramCancelTicketOut.setBatchno(ticketsell.getBatchno());//售票票号的批次号
			paramCancelTicketOut.setOrderno(ticketsell.getOrderno());
			paramCancelTicketOut.setTicketno(ticketsell.getTicketno());
			paramCancelTicketOut.setScheduleCode(schedule.getCode());
			paramCancelTicketOut.setTickettypeCode(ticketsell.getTickettype());
			paramCancelTicketOut.setDepartdate(ticketsell.getDepartdate());
			paramCancelTicketOut.setDeparttime(ticketsell.getDeparttime());
			paramCancelTicketOut.setSeatno(new Short(ticketsell.getSeatno()).toString());
			paramCancelTicketOut.setDepartStationCode(departstation.getCode());
			paramCancelTicketOut.setDepartStationName(departstation.getName());
			paramCancelTicketOut.setReachStationCode(reachstation.getCode());
			paramCancelTicketOut.setReachStationName(reachstation.getName());
			paramCancelTicketOut.setSelltime(ticketsell.getSelltime());
			paramCancelTicketOut.setPrice(ticketsell.getPrice());
			result.getCancelTickets().add(paramCancelTicketOut);
		}
		
		result.setResult(MethodResult.SUCCESS);
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	public IDAO getDao() {
		return dao;
	}
	
	@SuppressWarnings("rawtypes")
	public void setDao(IDAO dao) {
		this.dao = dao;
	}
	
	public SessionContext getContext() {
		return context;
	}

	public void setContext(SessionContext context) {
		this.context = context;
	}

	public BilldamagedService getBilldamagedService() {
		return billdamagedService;
	}

	public void setBilldamagedService(BilldamagedService billdamagedService) {
		this.billdamagedService = billdamagedService;
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

	public BillinuseService getBillinuseService() {
		return billinuseService;
	}

	public void setBillinuseService(BillinuseService billinuseService) {
		this.billinuseService = billinuseService;
	}

	public ParameterService getParameterService() {
		return parameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public TicketturnoverdetailService getTicketturnoverdetailService() {
		return ticketturnoverdetailService;
	}

	public void setTicketturnoverdetailService(
			TicketturnoverdetailService ticketturnoverdetailService) {
		this.ticketturnoverdetailService = ticketturnoverdetailService;
	}

	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}

	public ScheduleDao getScheduleDao() {
		return scheduleDao;
	}

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	public TicketreturnrateService getTicketreturnrateService() {
		return ticketreturnrateService;
	}

	public void setTicketreturnrateService(TicketreturnrateService ticketreturnrateService) {
		this.ticketreturnrateService = ticketreturnrateService;
	}

	public VipService getVipService() {
		return vipService;
	}

	public void setVipService(VipService vipService) {
		this.vipService = vipService;
	}

	public VipconsumeService getVipconsumeService() {
		return vipconsumeService;
	}

	public void setVipconsumeService(VipconsumeService vipconsumeService) {
		this.vipconsumeService = vipconsumeService;
	}

	@Override
	public FindSchedulesOut findSchedule(FindScheduleIn paramFindScheduleIn,
			boolean fetchfromstation) {
		FindSchedulesOut result = new FindSchedulesOut();
		cn.nova.ticket.param.local.FindScheduleIn localParamFindScheduleIn = new cn.nova.ticket.param.local.FindScheduleIn(paramFindScheduleIn);
		String errmsg = checkAndConvertFindScheduleParam(localParamFindScheduleIn);
		if(errmsg!=null){
			getContext().setRollbackOnly();
			result.setResultMsg(errmsg);
			return result;
		}
		
		//取机构
		Organization organization_seller = organizationService.getOrgByCode(localParamFindScheduleIn.getOperateOrgcode());
		StringBuilder sql = new StringBuilder();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		float CarrychildRate = Float.parseFloat(parameterService.findParamValue(ParamterConst.Param_1012, organization_seller.getId()))/100;
		
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
		if("6".equals(localParamFindScheduleIn.getSellway())){
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
		if(localParamFindScheduleIn.getSeatTypeCode()!=null&&!localParamFindScheduleIn.getSeatTypeCode().trim().equals("")){
			propertyFilters.add(new PropertyFilter("EQS_tp!seattype", localParamFindScheduleIn.getSeatTypeCode().trim()));
		}
		String param1002 = parameterService.findParamValue(ParamterConst.Param_1002, organization_seller.getId());//只显示正常班次
		if("1".equals(param1002)){
			propertyFilters.add(new PropertyFilter("INS_ss!status", "('0','2')"));
		}
		if(!"2".equals(localParamFindScheduleIn.getSellway())&&localParamFindScheduleIn.getSellway()!=null&&!localParamFindScheduleIn.getSellway().trim().equals("")){
			String param1003 = parameterService.findParamValue(ParamterConst.Param_1003, organization_seller.getId());//已发班不显示
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1003)){
				propertyFilters.add(new PropertyFilter("EQB_ss!isdeparted", false));
			}
		}
		//留票销售加上过留票人过滤条件
		if("6".equals(localParamFindScheduleIn.getSellway())&&localParamFindScheduleIn.getCustomerId()>0){
			//售票点不可售站点控制
			sql.append(" and exists (")
			   .append("    select sre.id from Seatreserve sre")
			   .append("     where sre.customer.id=").append(localParamFindScheduleIn.getCustomerId())
			   .append("       and sre.sellstate='R'")
			   .append("       and sre.departstation.id=tp.departstationid")
			   .append("       and sre.reachstation.id=tp.reachstationid")
			   .append("       and sre.scheduleplanid=sp.id")
			   .append("     )");
		}
		if(localParamFindScheduleIn.getScheduleId()!=null&&localParamFindScheduleIn.getScheduleId()>0){
			propertyFilters.add(new PropertyFilter("EQL_sc!id", localParamFindScheduleIn.getScheduleId()));
		}
		else if(localParamFindScheduleIn.getReachStationId()!=null&&localParamFindScheduleIn.getReachStationId()>0){
			propertyFilters.add(new PropertyFilter("EQL_tp!reachstationid", localParamFindScheduleIn.getReachStationId()));
		}
		if(localParamFindScheduleIn.getDepartStationId()!=null&&localParamFindScheduleIn.getDepartStationId()>0){
			propertyFilters.add(new PropertyFilter("EQL_tp!departstationid", localParamFindScheduleIn.getDepartStationId()));
			propertyFilters.add(new PropertyFilter("EQL_ss!departstationid", localParamFindScheduleIn.getDepartStationId()));
		}
	    //0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
		if(localParamFindScheduleIn.getSellway()!=null&&!localParamFindScheduleIn.getSellway().trim().equals("")){
			if("8".equals(localParamFindScheduleIn.getSellway())
					||"6".equals(localParamFindScheduleIn.getSellway())){
					sql.append(" and sp.islinework=0");
				}
			if("6".equals(localParamFindScheduleIn.getSellway())){
				//订票只显示有留座的班次
				sql.append(" and tp.autocancelreserveseatnum+tp.unautocancelreserveseatnum>0");
			}
			else{
				String param1001 = parameterService.findParamValue(ParamterConst.Param_1001, organization_seller.getId());//满座班次不显示
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1001)&&!"7".equals(localParamFindScheduleIn.getSellway())){//网上售票不过滤满座班次
					sql.append(" and tp.seatnum-tp.soldeatnum-tp.autocancelreserveseatnum-tp.unautocancelreserveseatnum-tp.fixedreserveseatnum>0");
				}
			}
			if(localParamFindScheduleIn.getOperateTicketoutletsId()>0){
				//售票点可售班次控制
				sql.append(" and (exists (")
				.append("select toss.id from Ticketoutletssellschedule toss")
				.append(" where toss.startdate<=:departdate") 
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(localParamFindScheduleIn.getOperateTicketoutletsId())
				.append("   and toss.type=0)")
				.append(" or exists (")
				.append("select toss.id from Ticketoutletssellschedule toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(localParamFindScheduleIn.getOperateTicketoutletsId())
				.append("   and toss.type=1")
				.append("   and toss.typeid=ro.id)")
				.append(" or exists (")
				.append("select toss.id from Ticketoutletssellschedule toss")
				.append(" where toss.startdate<=:departdate") 
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(localParamFindScheduleIn.getOperateTicketoutletsId())
				.append("   and toss.type=2")
				.append("   and toss.typeid=sc.id)")
				.append(")")
				;
				//售票点不可售站点控制
				sql.append(" and (not exists (")
				.append("select toss.id from Ticketoutletsunsellstation toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(localParamFindScheduleIn.getOperateTicketoutletsId())
				.append("   and toss.stationid=tp.reachstationid")
				.append("   and toss.type=0)")
				.append(" and not exists (")
				.append("select toss.id from Ticketoutletsunsellstation toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(localParamFindScheduleIn.getOperateTicketoutletsId())
				.append("   and toss.stationid=tp.reachstationid")
				.append("   and toss.type=1")
				.append("   and toss.typeid=ro.id)")
				.append(" and not exists (")
				.append("select toss.id from Ticketoutletsunsellstation toss")
				.append(" where toss.startdate<=:departdate")
				.append("   and toss.enddate>=:departdate") 
				.append("   and toss.ticketoutletsid=").append(localParamFindScheduleIn.getOperateTicketoutletsId())
				.append("   and toss.stationid=tp.reachstationid")
				.append("   and toss.type=2")
				.append("   and toss.typeid=sc.id)")
				.append(")")
				;
			}

			//售票机器可售班次控制
			String parmvalue_1023 = parameterService.findParamValue(ParamterConst.Param_1023, organization_seller.getId());
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parmvalue_1023)&&organization_seller.getIslocal() //只能控制本地售票点
					&&localParamFindScheduleIn.getOperateIp()!=null
					&&!localParamFindScheduleIn.getOperateIp().trim().equals("")
					&&!localParamFindScheduleIn.getOperateIp().trim().equals("127.0.0.1")
					){
				sql.append(" and (exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(localParamFindScheduleIn.getOperateIp()).append("'")
				.append("   and pss.type=0)")
				.append(" or exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(localParamFindScheduleIn.getOperateIp()).append("'")
				.append("   and pss.type=1")
				.append("   and pss.typeid=ro.id)")
				.append(" or exists (")
				.append("select pss.id from Pcsellschedule pss")
				.append(" where pss.ip='").append(localParamFindScheduleIn.getOperateIp()).append("'")
				.append("   and pss.type=2")
				.append("   and pss.typeid=sc.id)")
				.append(")")
				;
			}
		}
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		sql.append(" order by ss.departtime,scst.orderno");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString(),DepartSchedule.class);

		
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		if(localParamFindScheduleIn.getSellway()!=null&&!localParamFindScheduleIn.getSellway().trim().equals("")){
			query.setParameter("departdate", localParamFindScheduleIn.getDepartDate());
		}
		List<DepartSchedule> schedulelist =  query.getResultList();
		
		if(localParamFindScheduleIn.getSellway()==null||localParamFindScheduleIn.getSellway().trim().equals("")){
			localParamFindScheduleIn.setSellway("2"); //与特权补票同权限
		}
//		if(scheduleAskCondition.getSellway()!=null&&!scheduleAskCondition.getSellway().trim().equals("")){
			//过滤不符合条件的班次/////////////////////////////////////////////////////////////////////////////////////////
			class TimeParameter{
				short preSaleDays ;// 车票预售天数
				short excessSaleMinutes ;//补票截止时间
				short preSaleMinutes ;  //售票截止时间
			}
			Map<Long,TimeParameter> timeParameters = new HashMap<Long,TimeParameter>();
			Ticketoutlets ticketoutlets = (Ticketoutlets)dao.get(Ticketoutlets.class, localParamFindScheduleIn.getOperateTicketoutletsId());
			boolean ticketoutlets_in="0".equals(ticketoutlets.getType());
			
			String paramValue = parameterService.findParamValue(ParamterConst.Param_1020, organization_seller.getId());//报到后才允许售票
			boolean issaleafterreport =ParamterConst.COMMON_FLAG.FALG_YES.equals(paramValue);//报到后售票
	
			String needSameStation = null;
			String needSameRoute = null;
			Ticketsell ticketsell = null;
			Route route = null;
			if("4".equals(localParamFindScheduleIn.getSellway())){
				needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, organization_seller.getId());
				ticketsell = (Ticketsell) dao.get(Ticketsell.class, localParamFindScheduleIn.getTicketIdToBeChange());
				
				needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, organization_seller.getId());
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSameRoute)){
					Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
					route = schedule.getRoute();
				}
			}
			int originatorbeginsaletime =  new Integer(getParameterService().findParamValue(ParamterConst.Param_1034, organization_seller.getId()));
			for (Iterator<DepartSchedule> iterator = schedulelist.iterator(); iterator.hasNext();) {
				DepartSchedule row = iterator.next();
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
				if(localParamFindScheduleIn.getSellway()!=null&&!localParamFindScheduleIn.getSellway().trim().equals("")){
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
					Organization departOrg = organizationService.getOrgByStationId(departstationid);
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
				
				String sellway = localParamFindScheduleIn.getSellway();
				if(localParamFindScheduleIn.getSellway()==null||localParamFindScheduleIn.getSellway().trim().equals("")){
					sellway = "2"; //与特权补票同权限
				}
				if(!SaleDuration.isInTime(sellway,row.getDepartdate(),row.getDeparttime(),
						timeParameter.preSaleDays,timeParameter.preSaleMinutes,timeParameter.excessSaleMinutes,new Date())){
					iterator.remove();
					continue;
				}
			}
		FindSchedulesOut paramFindSchedulesOut = new FindSchedulesOut();
		paramFindSchedulesOut.setResult(MethodResult.SUCCESS);
		paramFindSchedulesOut.setDepartSchedules(schedulelist);
		if(fetchfromstation //余票查询时
			&&result.getDepartSchedules()!=null
			&&result.getDepartSchedules().size()>0){
			for (DepartSchedule departSchedule : result.getDepartSchedules()) {
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
	
	@Override
	public ChangeTicketsOut changeTicket(ChangeTicketsIn changeTicketsIn) {
		ChangeTicketsOut result = new ChangeTicketsOut();
		if(changeTicketsIn.getReturnTickets().size()!=changeTicketsIn.getSellseats().size()){
			result.setResultMsg("传入参数有误,改签的数量不一致");
			return result;
		}
		Date now = new Date();
//		SellTicketsIn sellTicketsIn = new SellTicketsIn();
//		sellTicketsIn.setBatchno(changeTicketsIn.getBatchno());
//		sellTicketsIn.setBillCustomManage(changeTicketsIn.getBillCustomManage());
//		sellTicketsIn.setClientIp(changeTicketsIn.getClientIp());
//		sellTicketsIn.setClientOrgcode(changeTicketsIn.getClientOrgcode());
//		sellTicketsIn.setOperateIp(changeTicketsIn.getOperateIp());
//		sellTicketsIn.setOperateOrgcode(changeTicketsIn.getOperateOrgcode());
//		sellTicketsIn.setOperateTicketoutletsCode(changeTicketsIn.getOperateTicketoutletsCode());
//		sellTicketsIn.setOperateTicketoutletsId(changeTicketsIn.getOperateTicketoutletsId());
//		sellTicketsIn.setOperateTicketoutletsName(changeTicketsIn.getOperateTicketoutletsName());
//		sellTicketsIn.setOperateUserCode(changeTicketsIn.getOperateUserCode());
//		sellTicketsIn.setOperateUserId(changeTicketsIn.getOperateUserId());
//		sellTicketsIn.setOperateUserName(changeTicketsIn.getOperateUserName());
//		sellTicketsIn.setOppositeOrgcode(changeTicketsIn.getOppositeOrgcode());
//		sellTicketsIn.setOrderno(changeTicketsIn.getOrderno());
//		sellTicketsIn.setPaymethod(changeTicketsIn.getPaymethod());
//		sellTicketsIn.setSellseats(changeTicketsIn.getSellseats());
//		sellTicketsIn.setSellway(changeTicketsIn.getSellway());
//		sellTicketsIn.setStartTicketNO(changeTicketsIn.getStartTicketNO());
//		sellTicketsIn.setTicketInvokeType(changeTicketsIn.getTicketInvokeType());
//		sellTicketsIn.setVipcardno(changeTicketsIn.getVipcardno());
//		sellTicketsIn.setVipgrade(changeTicketsIn.getVipgrade());
//		sellTicketsIn.setVipmoney(changeTicketsIn.getVipmoney());
//		sellTicketsIn.setVippoint(changeTicketsIn.getVippoint());
//		
//		SellTicketsOut sellresult = this.sellticket(sellTicketsIn);
		
		//TODO 写入证件ID到输入参数
		SellTicketsOut sellresult = this.sellticket(changeTicketsIn);
		if(sellresult.getResult()!=MethodResult.SUCCESS){
			result.setResult(sellresult.getResult());
			result.setResultMsg(sellresult.getResultMsg());
			getContext().setRollbackOnly();
			return result;
		}
		result.setSelledtickets(sellresult.getSelledtickets());
		
		int i=0;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		for (ReturnTicketIn returnTicketIn : changeTicketsIn.getReturnTickets()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", returnTicketIn.getOrderno()));
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", returnTicketIn.getTicketno()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsell.class, propertyFilters);
			
			if(ticketsell==null){
				result.setResultMsg((new ServiceException("0214")).getExceptionMessage());
				getContext().setRollbackOnly();
				return result;
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				result.setResultMsg((new ServiceException("0215")).getExceptionMessage());
				getContext().setRollbackOnly();
				return result;
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				result.setResultMsg((new ServiceException("0216")).getExceptionMessage());
				getContext().setRollbackOnly();
				return result;
			}
			else if(ticketsell.getIschecked()){
				result.setResultMsg((new ServiceException("0217")).getExceptionMessage());
				getContext().setRollbackOnly();
				return result;
			}
			else{
				propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
				//判断发班状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));// global.getUserinfo().getId()
				Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
				if(schedulestatus.getIsdeparted()){
					result.setResultMsg((new ServiceException("0213")).getExceptionMessage());//原车票所在班次已发班不允许改签
					getContext().setRollbackOnly();
					return result;
				}
			}
			Organization oldDepartOrg = null;
			Organization newDepartOrg = null;
			oldDepartOrg = organizationService.getOrgByStationId(ticketsell.getDepartstationid());
			newDepartOrg = organizationService.getOrgByStationCode(changeTicketsIn.getSellseats().get(i).getDepartStationCode());
			String needSameStation = parameterService.findParamValue(ParamterConst.Param_1505, oldDepartOrg.getId());
			String needSameRoute = parameterService.findParamValue(ParamterConst.Param_1506, oldDepartOrg.getId());
			
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", changeTicketsIn.getSellseats().get(i).getReachStationCode()));
			Station newReachstaion = (Station) dao.uniqueResult(Station.class, propertyFilters);
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSameStation)&&(newDepartOrg.getStation().getId()!=ticketsell.getDepartstationid()
					||newReachstaion.getId()!=ticketsell.getReachstationid())){
				result.setResultMsg((new ServiceException("0211")).getExceptionMessage());
				getContext().setRollbackOnly();
				return result;
			}
			
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSameRoute)){
				Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
				Route route = schedule.getRoute();
				Schedule newschedule = scheduleService.getScheduleByCode(changeTicketsIn.getSellseats().get(i).getSchedulecode()
																		, newDepartOrg.getId()
																		, changeTicketsIn.getSellseats().get(i).getDepartDate());
				Route newroute = newschedule.getRoute();
				if(newroute.getId()!=route.getId()){
					result.setResultMsg((new ServiceException("0212")).getExceptionMessage());
					getContext().setRollbackOnly();
					return result;
				}
			}
			
			String needSamePrice = parameterService.findParamValue(ParamterConst.Param_1504, oldDepartOrg.getId());
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(needSamePrice)&&!ticketsell.getPrice().equals(changeTicketsIn.getSellseats().get(i).getPrice())){
				result.setResultMsg((new ServiceException("0210")).getExceptionMessage());
				getContext().setRollbackOnly();
				return result;
			}
			
			//TODO 退保险
			
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", result.getSelledtickets().get(i).getOrderno()));
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", result.getSelledtickets().get(i).getTicketno()));
			Ticketsell ticketsell_new = (Ticketsell) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsell.class, propertyFilters);

			Ticketchange ticketchange = new Ticketchange();
			ticketchange.setChangeby(changeTicketsIn.getOperateUserId());
			ticketchange.setChangeip(changeTicketsIn.getOperateIp());
			ticketchange.setChangetime(now);
			ticketchange.setChangeby(changeTicketsIn.getOperateUserId());
			ticketchange.setCreateby(changeTicketsIn.getOperateUserId());
			ticketchange.setCreatetime(now);

			ticketchange.setNewdepartdate(result.getSelledtickets().get(i).getDepartDate());
			ticketchange.setNewscheduleid(ticketsell_new.getScheduleid());
			ticketchange.setNewseatno(result.getSelledtickets().get(i).getSeatno());
			ticketchange.setNewticketno(result.getSelledtickets().get(i).getTicketno());
			ticketchange.setNewticketsellid(ticketsell_new.getId());
			ticketchange.setOlddepartdate(ticketsell.getDepartdate());
			ticketchange.setOldscheduleid(ticketsell.getScheduleid());
			ticketchange.setOldseatno(ticketsell.getSeatno());
			ticketchange.setOldticketno(ticketsell.getTicketno());
			ticketchange.setOldticketsellid(ticketsell.getId());
			ticketchange.setRemarks(null);
			ticketchange.setTicketoutletsid(changeTicketsIn.getOperateTicketoutletsId());
			ticketchange.setUpdateby(changeTicketsIn.getOperateUserId());
			ticketchange.setUpdatetime(now);
			dao.merge(ticketchange);
			i++;
		}

		ReturnTicketsIn returnTicketsIn = new ReturnTicketsIn();
		returnTicketsIn.setBillCustomManage(changeTicketsIn.getBillCustomManage());
		returnTicketsIn.setClientIp(changeTicketsIn.getClientIp());
		returnTicketsIn.setClientOrgcode(changeTicketsIn.getClientOrgcode());
		returnTicketsIn.setOperateIp(changeTicketsIn.getOperateIp());
		returnTicketsIn.setOperateOrgcode(changeTicketsIn.getOperateOrgcode());
		returnTicketsIn.setOperateTicketoutletsCode(changeTicketsIn.getOperateTicketoutletsCode());
		returnTicketsIn.setOperateTicketoutletsId(changeTicketsIn.getOperateTicketoutletsId());
		returnTicketsIn.setOperateTicketoutletsName(changeTicketsIn.getOperateTicketoutletsName());
		returnTicketsIn.setOperateUserCode(changeTicketsIn.getOperateUserCode());
		returnTicketsIn.setOperateUserId(changeTicketsIn.getOperateUserId());
		returnTicketsIn.setOperateUserName(changeTicketsIn.getOperateUserName());
		returnTicketsIn.setOppositeOrgcode(changeTicketsIn.getOppositeOrgcode());
		returnTicketsIn.setRemarks(changeTicketsIn.getRemarks());
		returnTicketsIn.setReturnbatchno(changeTicketsIn.getReturnbatchno());
		returnTicketsIn.setReturnPrintStartNo(changeTicketsIn.getReturnPrintStartNo());
		returnTicketsIn.setReturnTickets(changeTicketsIn.getReturnTickets());
		returnTicketsIn.setReturnway(changeTicketsIn.getReturnway());
		returnTicketsIn.setTicketInvokeType(changeTicketsIn.getTicketInvokeType());
		returnTicketsIn.setVipcardno(changeTicketsIn.getVipcardno());
		returnTicketsIn.setVipgrade(changeTicketsIn.getVipgrade());
		returnTicketsIn.setVipmoney(changeTicketsIn.getVipmoney());
		returnTicketsIn.setVippoint(changeTicketsIn.getVippoint());
		ReturnTicketsOut returnTicketsOut = this.returnticket(returnTicketsIn);
		if(returnTicketsOut.getResult()!=MethodResult.SUCCESS){
			result.setResult(returnTicketsOut.getResult());
			result.setResultMsg(returnTicketsOut.getResultMsg());
			getContext().setRollbackOnly();
			return result;
		}
		result.setReturnTickets(returnTicketsOut.getReturnTickets());
		result.setResult(returnTicketsOut.getResult());
		return result;
	}

	public ScheduleService getScheduleService() {
		return scheduleService;
	}

	public void setScheduleService(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}

	public DictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	@Override
	public RePrintTicketsOut rePrintTicket(RePrintTicketsIn rePrintTicketsIn) {
		RePrintTicketsOut result = new RePrintTicketsOut();
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_ts!orderno", rePrintTicketsIn.getOrderno()));
		propertyFilters.add(new PropertyFilter("EQS_ts!ticketno", rePrintTicketsIn.getTicketno()));
//		propertyFilters.add(new PropertyFilter("EQS_ts!seatno", rePrintTicketsIn.getTicket_id().split("_")[1]));
		propertyFilters.add(new PropertyFilter("GED_ts!departdate", DateUtils.trunc(new Date())));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult("select ts from Ticketsell ts ",propertyFilters);
		if(ticketsell==null){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("找不到车票:"+rePrintTicketsIn.getTicketno());
			log.error("找不到车票:"+rePrintTicketsIn.getTicketno());
			getContext().setRollbackOnly();
		}else if(ticketsell.getTicketstatus().equals("1")){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("车票"+rePrintTicketsIn.getTicketno()+"已退，不能重打印！");
			log.error("车票"+rePrintTicketsIn.getTicketno()+"已退，不能重打印！");
			getContext().setRollbackOnly();
		}else if(ticketsell.getTicketstatus().equals("2")){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("车票"+rePrintTicketsIn.getTicketno()+"已废，不能重打印！");
			log.error("车票"+rePrintTicketsIn.getTicketno()+"已废，不能重打印！");
			getContext().setRollbackOnly();
		}else if(ticketsell.getIschecked()){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("车票"+rePrintTicketsIn.getTicketno()+"已检票，不能重打印!");
			log.error("车票"+rePrintTicketsIn.getTicketno()+"已检票，不能重打印!");
			getContext().setRollbackOnly();
		}else{
			result.setResult(MethodResult.SUCCESS);
			ticketsell.setTicketno(rePrintTicketsIn.getNewticketno());
			ticketsell.setUpdateby(rePrintTicketsIn.getOperateUserId());
			ticketsell.setUpdatetime(new Date());
			dao.merge(ticketsell);	
		}
		
		return result;
	}

	/**
	 * 铭鸿专用
	 */
	@Override
	public PickUpTicketOut pickUpTicket(PickUpTicketIn pickUpTicketIn) {
		PickUpTicketOut result = new PickUpTicketOut();
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_ts!orderno", pickUpTicketIn.getOrderno()));
		propertyFilters.add(new PropertyFilter("EQS_ts!password", pickUpTicketIn.getCaptcha()));
		Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult("select ts from Ticketsellother ts ",propertyFilters);
		if(ticketsellother==null ){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("不是网上售票，不能取票！");
			log.error("不是网上售票，不能取票！");
			getContext().setRollbackOnly();
		}
		if(ticketsellother.getIstaked()){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("订单号:"+pickUpTicketIn.getOrderno()+"，" +
					"验证码:"+pickUpTicketIn.getCaptcha()+"的票已取票,不能再次取票！");
			log.error("订单号:"+pickUpTicketIn.getOrderno()+"，" +
					"验证码:"+pickUpTicketIn.getCaptcha()+"的票已取票,不能再次取票！");
			getContext().setRollbackOnly();
		}
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketsellother.getTicketsellid());
		if(ticketsell.getTicketstatus().equals("1")){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("订单号:"+ticketsell.getOrderno()+",座位号:"+ticketsell.getSeatno()+"已退，不能取票！");
			log.error("订单号:"+ticketsell.getOrderno()+",座位号:"+ticketsell.getSeatno()+"已退，不能取票！");
			getContext().setRollbackOnly();
		}else if(ticketsell.getTicketstatus().equals("2")){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("订单号:"+ticketsell.getOrderno()+",座位号:"+ticketsell.getSeatno()+"已废，不能取票！");
			log.error("订单号:"+ticketsell.getOrderno()+",座位号:"+ticketsell.getSeatno()+"已废，不能取票！");
			getContext().setRollbackOnly();
		}else if(ticketsell.getIschecked()){
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("订单号:"+ticketsell.getOrderno()+",座位号:"+ticketsell.getSeatno()+"已检票，不能取票!");
			log.error("订单号:"+ticketsell.getOrderno()+",座位号:"+ticketsell.getSeatno()+"已检票，不能取票!");
			getContext().setRollbackOnly();
		}else{
			Date now = new 	Date();
			ticketsellother.setIstaked(true);
			ticketsellother.setTaketime(now);
			ticketsellother.setTakeway("1");
			ticketsellother.setPrintby(pickUpTicketIn.getOperateUserId());
			ticketsellother.setUpdateby(pickUpTicketIn.getOperateUserId());
			ticketsellother.setUpdatetime(now);
			dao.merge(ticketsellother);
			
			ticketsell.setTicketno(pickUpTicketIn.getPrint_ticket_id());
			ticketsell.setUpdateby(pickUpTicketIn.getOperateUserId());
			ticketsell.setUpdatetime(now);
			ticketsell = (Ticketsell) dao.merge(ticketsell);	
			
			result.setOrder_id(ticketsellother.getOrderno());         // 订单ID                                                                         
			result.setSale_ticket_time(ticketsell.getSelltime());         // 订单时间                                                                 
			result.setOrder_status("2");         // 订单状态1：未支付  2：已支付   
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			result.setBg_date(format.format(ticketsell.getDepartdate()));         // 发车日期  yyyy-MM-dd                                                              
			result.setBg_time(ticketsell.getDeparttime());         // 发车时间hh:mm                                                                  
			result.setTicket_id(ticketsellother.getOrderno()+"_"+ticketsell.getSeatno());         // 电子票ID    
			if(ticketsell.getTicketstatus().equals("0")){
				result.setTicket_status("02");   // 票状态 00：未锁定   01：已锁定 02：已销售 03：已取票 04：已废票 05：已退票 06: 已检票        
			}else if(ticketsell.getTicketstatus().equals("1")){
				result.setTicket_status("04");  
			}else{
				result.setTicket_status("05");  
			}
			if(ticketsell.getIschecked()){
				result.setTicket_status("06");  
			}
			if(ticketsellother.getIstaked()){
				result.setTicket_status("03");  
			}
			result.setCaptcha(ticketsellother.getPassword());         // 验证码           
			
			if(ticketsell.getTicketstatus().equals("Q")){
				result.setTicket_type("01");    // 票种类型  01：全票02：半票03：学生票04：优惠票05：儿童票       
			}else if(ticketsell.getTicketstatus().equals("B")){
				result.setTicket_type("02");
			}else if(ticketsell.getTicketstatus().equals("X")){
				result.setTicket_type("03");
			}else if(ticketsell.getTicketstatus().equals("Z")){
				result.setTicket_type("04");
			}else{
				result.setTicket_type("05");//TODO BUG
			} 
			
//			result.setSeat_type(seat_type);         // 座型	  01：座位、02：卧铺                                                            
			result.setSeat_no(ticketsell.getSeatno()+"");         // 座位编号                                                                          
			result.setTicket_fee(ticketsell.getPrice().doubleValue());         // 零售票价                                                                       
			result.setMax_full_fee(ticketsell.getToplimitprice().doubleValue());         // 最高限价                                                                     
			result.setChk_ticket_no(ticketsell.getTicketentrance());         // 检票口                                                                     
			result.setRoom_no("0");         // 候车厅号                                                                          
			result.setParking_set(ticketsell.getBuspark());         // 停车位         
			
			Station departstation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
			result.setBg_station_code(departstation.getCode());         // 始发站代码         
			
			Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
			result.setEd_station_code(reachstation.getCode());         // 到达站代码             
			
			Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
			result.setBanci_code(schedule.getCode());         // 班次代码                                                                         
//			result.setPassenger_type(passenger_type);         // 客运类别  01、普通、02、直达                                                      
			result.setBg_up_station(departstation.getCode());         // 上车点 与始发站一致，如有则填写     
			
//			result.setBanci_type(banci_type);         // 班次类型   01、正班、02.加班、03.顶班                                                   
//			result.setBanci_class(banci_class);         // 班次种类   01.始发、02、、配客                                                       
//			result.setBanci_model(banci_model);         //  班次性质   01.固定班次、02.流水班次                                                   
//			result.setSale_ticket_oper_no(sale_ticket_oper_no);         //  售票员工号                                                                
			
			result.setResult(MethodResult.SUCCESS);
		}
		
		return result;
	}

}

