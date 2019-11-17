package cn.nova.bus.dispatch.action;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.service.SecuritycheckService;
import cn.nova.bus.check.service.impl.SecuritycheckServiceImpl;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.impl.DepartinvoiceServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Roadbillprint;
import cn.nova.bus.dispatch.model.Vehicledriverreport;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.DispatchService;
import cn.nova.bus.dispatch.service.VehiclelateService;
import cn.nova.bus.dispatch.service.impl.DispatchServiceImpl;
import cn.nova.bus.dispatch.service.impl.VehiclelateServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class DispatchAction extends BaseAction{
	private long id;
	private String routeids;
	private Long orgid;
	private Long driverid;
	private Long driver1id;
	private Long driver2id;
	private String isneedfinger;
	//IC卡刷卡带出来的证件信息 begin
	private String licenseenddate;
	private String liabilityinsureenddate;
	private String workenddate;
	private String roadno;
	private String compulsoryinsureenddate;
	//IC卡刷卡带出来的证件信息 end
	private Long driver3id;
	private String orgids;
	private String cardno;// IC卡报到
	private String vehicleno;
	private String code;// 按省、市、线路查询时使用
	private Long departstationid;
	private List<Map<String, Object>> routetreelist;
	private List<Map<String, Object>> list;
	private Vehiclereport vehiclereport;
	private Vehiclelost vehiclelost;
	private Long scheduleplanid;
	private Roadbillprint roadbillprint;
	private String unitflag;
	private Schedulevehiclepeopleplan vehiclepeopleplan;
	private List<Map<String, Object>> scheduleplanlist;
	private List<Map<String, Object>> lineworkreportlist;
	private List<Map<String, Object>> vehiclerunplanlist;
	private List<Map<String, Object>> resultlist;
	private List<Map<String, Object>> driverList;
	private String driverids;
	
	private Integer vehicleloadnum;//车载人数
	
	private long scheduleid;
	// 车辆信息
	private Long vehicleid;
	private Short seatnum;
	private Vehicledriverreport vdp;
	private Long unitid;
	private String unitname;
	private Long balanceunitid;
	private String balanceunitname;
	private long stewardid;
	private String codes; //条形码
	private List<Map<String, Object>> licenseinfo;  //根据条形码查询的证件信息
	public Long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(Long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public String getBalanceunitname() {
		return balanceunitname;
	}

	public void setBalanceunitname(String balanceunitname) {
		this.balanceunitname = balanceunitname;
	}

	private Long vehicletypeid;
	private String vehicletypename;
	private Date departdate;
	private String ip;
	private String serialnumber;
	private long schedulestatusid;
	private boolean ischeckplan;
	
	private long qrycurstationid;

	private DispatchService dispatchService;
	
	//班次计划座位数 2015年6月5日 11:53:56 李电志
	private int schedulePlanSeatnum;
	//是否修改计划车辆信息  0 ：不修改，1：修改    李电志 2015年6月6日 17:45:57
//	private String isupdatevehcleplan;
	
	//班次号 李电志  2015年6月17日 09:45:38
	private String schedulename;
	//原班次计划id 李电志 
	private long oldscheduleplanid;
	private long  vehiclenoid;
	private boolean isautodispatch;
	private int checkednum;
	private String workno;
	
	private BigDecimal waybillnumber;   //路单编号
	
	public String qryRouteTree() {
		try {
			dispatchService = new DispatchServiceImpl();
			setRoutetreelist(dispatchService.qryRouteTree(orgid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryCurOrg() {
		try {
			dispatchService = new DispatchServiceImpl();
			setList(dispatchService.qryCurOrg(orgids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryDriver() {
		try {
			dispatchService = new DispatchServiceImpl();
			setList(dispatchService.qryDriver(driverid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryDriverbycardno() {
		try {
			dispatchService = new DispatchServiceImpl();
			setList(dispatchService.qryDriverbycardno(cardno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// IC卡报到界面查询
	public String qryScheduleplanByCard() {
		try {
			dispatchService = new DispatchServiceImpl();
			scheduleplanlist = dispatchService
					.qryScheduleplan(ServletPropertyFilterUtil
							.buildFromHttpRequest(),vehiclenoid,isautodispatch);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	//
	public String qryScheduleplan() {
		try {
			dispatchService = new DispatchServiceImpl();
			setScheduleplanlist(dispatchService.qryScheduleplan(
					ServletPropertyFilterUtil.buildFromHttpRequest(), departstationid,departdate,qrycurstationid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String vehicleIsLater() {
		try {
			dispatchService = new DispatchServiceImpl();
			setFlag(dispatchService.laterMinutes(departstationid,
					vehiclereport.getScheduleid(),
					vehiclereport.getDepartdate()));
			setMsg("该班次已晚点！");
		} catch (Exception e) {
			markFailure();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qrySchedulevehiclepeopleplan() {
		try {
			dispatchService = new DispatchServiceImpl();
			setList(dispatchService.qrySchedulevehiclepeopleplan(
					vehiclereport.getScheduleid(), departstationid,
					vehiclereport.getDepartdate()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryvehicleReport() {
		try {
			dispatchService = new DispatchServiceImpl();
			setLineworkreportlist(dispatchService
					.qryVehiclereport(vehiclereport));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 车牌报到
//	public String vehicleReport() {
//		Global global = CurrentUtil.getGlobal();
//		try {
//			if (global != null && global.getUserinfo().getId() > 0) {
//				dispatchService = new DispatchServiceImpl();
//				dispatchService.vehicleReport(vehiclereport, departstationid,
//						vehicleno,global);
//				markSuccess();
//				setMsg("报到成功！");
//			}
//		} catch (ServiceException se) {
//			markFail();
//			setMsg(se.getMessage());
//		} catch (Exception e) {
//			markFail();
//			setMsg("报到失败！");
//			play.Logger.error(e.getMessage(), e);
//		}
//		return "json";
//	}
	
	/**
	 * 车牌报到 李电志 2015年6月5日 11:38:16 
	 * @return
	 */
	public String vehicleReport() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
//				dispatchService.vehicleReport(vehiclereport, departstationid,
//						vehicleno,global);
				if(vehiclereport.getOrgid()==0){
					vehiclereport.setOrgid(global.getOrganization().getId());
				}
				if(vehiclereport.getReportorgid()==0){
					vehiclereport.setReportorgid(global.getOrganization().getId());
				}
				MethodResult result = dispatchService.vehicleReport(vehiclereport,vdp,departstationid,
						vehicleno,global);
				 //boolean isupdate =  dispatchService.updateSeattypetoTicketprice(vehiclereport,global);
						
			/*	//同步车辆空间座位类型和车辆座位类型到票价表中的座位类型
				if (flag)
				{
					//先通过车辆报到表找到车辆信息，找到车辆类型Id在找到厂牌型号，判断厂牌型号中是否设置座位信息
					//获取报道车辆信息
					Long vehicleId = vehiclereport.getVehicleid();//报到车辆ID
					Vehicle vehicle = dispatchService.getVehicleInfo(vehicleId);
					//获取车辆品牌型号表信息
					Long vehiclebrandmodelid = vehicle.getVehiclebrandmodelid();//车辆品牌型号表Id
//					Vehiclebrandmodel vehiclebrandmodel = dispatchService.getVehiclebrandmodelInfo(vehiclebrandmodelid);
					//获取车辆座位图明细表信息  根据vehiclebrandmodelid
					List<Vehicleseatplandetail> vehicleseatplandetailList = dispatchService.getVehicleseatplandetailInfo(vehiclebrandmodelid);
					String seattype = "";//座位类型：车辆内部空间表如果有数据则取其中的数据，如果没有则取车辆表中的数据
					if (vehicleseatplandetailList != null && vehicleseatplandetailList.size() > 0) {//车辆内部空间表座位类型
						Long vehicleSpaceId = vehicleseatplandetailList.get(vehicleseatplandetailList.size()-1).getVehiclespaceid();
						//获取车辆内部空间表信息  根据vehicleSpaceId
						Vehiclespace vehiclespace = dispatchService.getVehicleSpaceInfo(vehicleSpaceId);
						seattype=vehiclespace.getSeattype();
					} else {
						seattype = vehicle.getSeattype();//车辆表中的座位类型
					}
					//把seattype结果同步到ticketprice表中的seattype字段，
					//获取班次运行计划id
					Long schedulePlanceId = vehiclereport.getScheduleplanid();
					//获取执行票价表ticketprice的信息
					List<Ticketprice> ticketpricelist = dispatchService.getSchTicketPriceList(schedulePlanceId);
					//修改执行票价表的seattype
					int len = ticketpricelist.size();
					for (int i = 0; i < len; i++) {
						Ticketprice ticketprice = ticketpricelist.get(i);
						ticketprice.setSeattype(seattype);
						//更新
						dispatchService.updateTicketPrice(ticketprice);
					}
				}*/
				if(result.getResult()==1){
					markSuccess();
					setMsg(result.getResultMsg());
				}else{
					markFail();
					setMsg(result.getResultMsg());
				}
				//更新班次计划座位数 
//				dispatchService.updateSchedulePlan(scheduleplanid,schedulePlanSeatnum);
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 根据IC卡查询车辆信息
	public String qryVehicleinfo() {
		markSuccess();
		setMsg("查询成功！");
		try {
			dispatchService = new DispatchServiceImpl();
			list = dispatchService.qryVehicle(cardno);
			//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
			list=ListUtil.listToMap(new Object[] { "id", "vehicleno", "seatnum",
					"unitid", "unitname","balanceunitid","balanceunitname", "vehicletypeid", "vehicletypename","isneedfinger",
					"licenseenddate","liabilityinsureenddate","workenddate","roadno","compulsoryinsureenddate","contractenddate"},
					null, new Object[] { Long.class, String.class, Short.class,
							Long.class, String.class,Long.class,String.class, Long.class, String.class, String.class,
							String.class,String.class,String.class,String.class,String.class,String.class});
		} catch (Exception e) {
			markFail();
			setMsg("系统异常！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String cancelReport() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.cancelReport(vehiclereport,
						departstationid, global.getIpAddress())) {
					markSuccess();
					setMsg("取消成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("取消失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String vehicleLost() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.vehicleLost(vehiclelost)) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String chanagePlanVehicle() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.chanagePlanVehicle(vehiclepeopleplan)) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 停售
	public String stopTicketsell() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.stopTicketsell(vehiclepeopleplan
						.getScheduleplan().getId(), departstationid, global)) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 发售
	public String allowTicketsell() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.allowTicketsell(vehiclepeopleplan
						.getScheduleplan().getId(), departstationid, global)) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 停班
	public String stopScheduleplan() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.stopScheduleplan(vehiclepeopleplan
						.getScheduleplan().getId(), departstationid,
						vehiclepeopleplan.getCreateby())) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 停班恢复
	public String allowScheduleplan() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.allowScheduleplan(vehiclepeopleplan
						.getScheduleplan().getId(), departstationid, ip,
						vehiclepeopleplan.getCreateby())) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveroadbill() {
		Global global = CurrentUtil.getGlobal();
		try {
			dispatchService = new DispatchServiceImpl();
			DepartinvoiceService departinvoiceService = new DepartinvoiceServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				roadbillprint.setPrintby(global.getUserinfo().getId());
				roadbillprint.setPrinttime(new Date());				
				Roadbillprint roadbill = dispatchService.saveRoadbill(roadbillprint);
				setWaybillnumber(roadbill.getWaybillnumber());  //路单编号
				vehicleloadnum = dispatchService
						.coutVehicleLoadNum(roadbillprint.getPrinttime(), global.getOrganization()
								.getStation().getId(), scheduleplanid, roadbillprint.getVehiclereportid());// #11356：车载人数=实载人数（未发班则统计截止打印路单时的已售数，已发班则统计检票数）+报到驾驶员人数+报到乘务员人数
				//检票人数     线路标志牌号     道路运输证号
				setCheckednum(dispatchService.countCheckednum(scheduleplanid));
				Vehiclereport vr = dispatchService.queryVehiclereport(roadbillprint.getVehiclereportid());
				Vehicle v = dispatchService.queryVehicle(vr.getVehicleid());
				setRoadno(v.getRoadno());
				setWorkno(v.getWorkno());
				list=departinvoiceService.qryInvoicesDetailtoRoadbill(scheduleplanid);
				markSuccess();
				setMsg("保存成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("保存失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 放空
	public String departScheduleNoPrint() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.departScheduleNoPrint(vehiclereport)) {
					markSuccess();
					setMsg("操作成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("操作失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 取消放空
	public String undodepartScheduleNoPrint() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				dispatchService = new DispatchServiceImpl();
				if (dispatchService.undodepartScheduleNoPrint(vehiclereport)) {
					markSuccess();
					setMsg("取消成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("取消失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 获取车辆安检信息
	public String qryVehiclecheckinfo() {
		Global global = CurrentUtil.getGlobal();
		try {
			SecuritycheckService securitycheckService = new SecuritycheckServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				MethodResult result = securitycheckService
						.getVehicleCheckResult(vehiclereport.getVehicleid(),
								vehiclereport.getDepartdate(), global
										.getOrganization().getId());
				this.ischeckplan = securitycheckService.querycheckplan(
						vehiclereport.getVehicleid(), vehiclereport
								.getDepartdate(), global.getOrganization()
								.getId());
				
				markFlag(result.getResult());
				setMsg(result.getResultMsg());
			}
		} catch (Exception e) {
			markFail();
			setMsg("系统异常！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询车辆对应的营运线路信息
	public String qryVehicleroute() {
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			dispatchService = new DispatchServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (vehicleid != null) {
					list = dispatchService.qryScheduleplanroute(vehicleid);
				} else {
					list = dispatchService.getScheduleplanroute(departdate,
							departstationid, cardno,serialnumber);
				}
			}
		} catch (ServiceException se) {
			list = ListUtil.listToMap(new Object[] { "id", "routeid",
					"vehicleno","isneedfinger" }, null, new Object[] { Long.class, Long.class,
					String.class,boolean.class });
		} catch (Exception e) {
			markFail();
			setMsg("系统异常！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 换车报到
	public String changeReportVehicle() {
		Global global = CurrentUtil.getGlobal();
		try {
			dispatchService = new DispatchServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (dispatchService.changeReportVehicle(vehiclereport,
						departstationid, ip, global)) {
					markSuccess();
					setMsg("换车报到成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		}  catch (Exception e) {
			markFail();
			setMsg("换车报到失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 班次晚点处理
	public String schVehicleLater() {
		Global global = CurrentUtil.getGlobal();
		try {
			VehiclelateService vehiclelateService = new VehiclelateServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (vehiclelateService.schVehicleLater(schedulestatusid, global)) {
					markSuccess();
					setMsg("处理成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("处理失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 车辆运行计划查询
	 * @return
	 */
	public String qryVehicleRunplan(){
		try {
			dispatchService = new DispatchServiceImpl();
			setVehiclerunplanlist(dispatchService.qryVehicleRunplan(vehicleid, departdate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 车判断车辆是否只允许车辆报到在已指定的线路中
	 * @return
	 */
	public String vehicleIsOnlyReportRoute(){
		try {
			dispatchService = new DispatchServiceImpl();
			dispatchService.isOnlyReportRoute(vehicleid, scheduleid);
			markSuccess();
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("判断车辆指定线路失败！");
			play.Logger.error(e.getMessage(), e);;
		}
		return "json";
	}
	
	/**
	 * 正副驾驶员的证件判断 和 有效期到期提示
	 *  
	 * @return
	 */
	public String showValidate() {
		try {
			dispatchService = new DispatchServiceImpl();
			setMsg(dispatchService.showValidate( orgid, driverid, driver1id, driver2id, driver3id));
			if (msg !=null){
				markFailure();
			}else{
				markSuccess();
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}
	/**
	 * IC卡报班同线路间隔时间限制判断
	 * @return
	 */
	public String qryRouteReportInterval(){
		dispatchService = new DispatchServiceImpl();
		setMsg( dispatchService.qryRouteReportInterval(scheduleid) );
		if(msg!=null){
			markFailure();
		}
		else{
			markSuccess();
		}
		return "json";
	}
	/**
	 * IC卡报班驾驶员两次报班的最小时间间隔限制判断
	 * @return
	 */
	public String qryDriverReportInterval(){
		dispatchService = new DispatchServiceImpl();
		setMsg( dispatchService.qryDriverReportInterval(driverid) );
		if(msg!=null){
			markFailure();
		}
		else{
			markSuccess();
		}
		return "json";
	}

	/**
	 * cancleShift  取消并班
	 * 李电志  2015年6月17日 09:25:00
	 * @return
	 */
	public String cancleShift(){
		try {
			dispatchService = new DispatchServiceImpl();
			setMsg(dispatchService.cancleShift(schedulename,departdate,oldscheduleplanid));
			markSuccess();
			setMsg("取消并班成功！");
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			e.printStackTrace();
//			setMsg(e.getMessage());
			setMsg("取消并班失败！");
			markFail();
		}
		return "json";
	}
	
	
	/**
	 * 恢复售票
	 * 姜蓥瑞 2015年8月3日16:59:44
	 * @return
	 */
		public String cansaleticket(){
			try {
				dispatchService = new DispatchServiceImpl();
				setMsg(dispatchService.cansaleticket(oldscheduleplanid));//成功！
				markSuccess();
			} catch (ServiceException se) {
				setMsg(se.getMessage());
				markFail();
			} catch (Exception e) {
				e.printStackTrace();
				setMsg("被并班次恢复售票失败！");
				markFail();
			}
			return "json";
		}

	/**
	 * 报班时由车牌号自动显示正副驾驶员	
	 * @return
	 */
	public String qryVehicleDriver(){
		try {
			dispatchService = new DispatchServiceImpl();
			setList(dispatchService.qryVehicleDriver(vehicleid,departdate,scheduleid));
		} catch (Exception e) {
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
//	车辆运营线路设置查询 姜蓥瑞 2015年10月14日14:16:28
	public String qryvehiclerouteset() {
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			dispatchService = new DispatchServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				 setResultlist(dispatchService.qryvehiclerouteset(ServletPropertyFilterUtil.buildFromHttpRequest()));
			}
		} catch (ServiceException se) {
			list = ListUtil.listToMap(new Object[] { "id", "routeid",
					"vehicleno","isneedfinger" }, null, new Object[] { Long.class, Long.class,
					String.class,boolean.class });
		} catch (Exception e) {
			markFail();
			setMsg("系统异常！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 查询要设置的线路 姜蓥瑞 2015年10月14日14:16:28 
	 * @return
	 */
	public String qryroutebyrid(){
		dispatchService = new DispatchServiceImpl();
		try {
			setResultlist(dispatchService.qryroutebyvid(vehicleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 添加保存营运线路  姜蓥瑞 2015年10月14日15:08:02
	 * @return
	 */
	public String savevehicleroute(){
		dispatchService = new DispatchServiceImpl();
		Global global = new Global();
		try {
			dispatchService.savevehicleroute(id,orgid,vehicleid,routeids,global);
			setMsg("保存成功！");
			markSuccess();
		} catch (Exception e) {
			setMsg("保存失败！"+e.getMessage());
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 删除保存营运线路 姜蓥瑞2015年10月14日20:11:25
	 */
	public String delvehicleroutectrl(){
		dispatchService = new DispatchServiceImpl();
		try {
		boolean	delvehicleschctrl = dispatchService.delvehicleroutectrl(id);
			if(delvehicleschctrl){
				setMsg("删除成功！");
				markSuccess();
			}else{
				setMsg("删除失败！");
				markFail();
			}
		} catch (Exception e) {
			setMsg("删除失败！"+e.getMessage());
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 自动报班获取具体信息
	 * @return 
	 */
	public String qryAutoReport(){
		try {
			dispatchService = new DispatchServiceImpl();
			setList(dispatchService.qryAutoReport(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/*
	 * 校验是IC卡报班时,校验司乘人员是否进站、五证三险一卡有效期检查是否通过、驾驶员是否进行安全学习
	 */
	public String examinCheck(){
		try {
			dispatchService = new DispatchServiceImpl();
			String resultstr =dispatchService.showExaminCheck( vehicleid,orgid, driverid, driver1id, stewardid, departdate,scheduleid);
			if (resultstr==null||"".equals(resultstr)){
				markSuccess();
			}else{
				markSuccess();
				setMsg("未完成"+resultstr+"不能报班");
			}
		} catch (Exception e) {
			markFailure();
			setMsg(e.getMessage());
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
		}
		
		return "json";
	}
	/**
	 * 验证车属单位权限
	 * @return
	 */
	public String checkUnitPermission(){
		dispatchService = new DispatchServiceImpl();
		try {
			int msg = dispatchService.checkUnitPermisssion(vehicleid,unitflag);
			if(msg>0){
				markSuccess();
			}else{
				markFail();
				if("1".equals(unitflag)){
					setMsg("无权限报到外司车辆！");
				}else if("2".equals(unitflag)){
					setMsg("无权限报到本司车辆！");
				}
			}
		} catch (Exception e) {
			markFailure();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 修改司乘人员
	 * @return
	 */
	public String editDriverSteward(){
		dispatchService = new DispatchServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			MethodResult result = dispatchService.editDriverSteward(global, vehiclereport);
			if(result.getResult() == 1){
				markSuccess();
			}else{
				markFailure();
			}
			setMsg(result.getResultMsg());
		} catch (Exception e) {
			e.printStackTrace();
			markFailure();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 根据条形码codes查询对应的证件信息
	 * @return
	 */
	public String qryLicenseByCode () {
		try {
			dispatchService = new DispatchServiceImpl();
			setLicenseinfo(dispatchService.qryLicenseByCode(codes));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 查询报到的驾驶员当天已经有效报班次数超过一次以上
	 * @return
	 */
	public String qryDriverReport() {
		try {
			dispatchService = new DispatchServiceImpl();
			setDriverList(dispatchService.qryDriverReport(driverids,departdate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public List<Map<String, Object>> getRoutetreelist() {
		return routetreelist;
	}

	public void setRoutetreelist(List<Map<String, Object>> routetreelist) {
		this.routetreelist = routetreelist;
	}

	public List<Map<String, Object>> getScheduleplanlist() {
		return scheduleplanlist;
	}

	public void setScheduleplanlist(List<Map<String, Object>> scheduleplanlist) {
		this.scheduleplanlist = scheduleplanlist;
	}

	public Long getDriverid() {
		return driverid;
	}

	public void setDriverid(Long driverid) {
		this.driverid = driverid;
	}

	public List<Map<String, Object>> getList() {
		return list;
	}

	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}

	@Transient
	public Vehiclereport getVehiclereport() {
		return vehiclereport;
	}

	public void setVehiclereport(Vehiclereport vehiclereport) {
		this.vehiclereport = vehiclereport;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	@Transient
	public Vehiclelost getVehiclelost() {
		return vehiclelost;
	}

	public void setVehiclelost(Vehiclelost vehiclelost) {
		this.vehiclelost = vehiclelost;
	}

	@Transient
	public Schedulevehiclepeopleplan getVehiclepeopleplan() {
		return vehiclepeopleplan;
	}

	public void setVehiclepeopleplan(Schedulevehiclepeopleplan vehiclepeopleplan) {
		this.vehiclepeopleplan = vehiclepeopleplan;
	}

	public List<Map<String, Object>> getLineworkreportlist() {
		return lineworkreportlist;
	}

	public void setLineworkreportlist(
			List<Map<String, Object>> lineworkreportlist) {
		this.lineworkreportlist = lineworkreportlist;
	}

	@Transient
	public Roadbillprint getRoadbillprint() {
		return roadbillprint;
	}

	public void setRoadbillprint(Roadbillprint roadbillprint) {
		this.roadbillprint = roadbillprint;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Short getSeatnum() {
		return seatnum;
	}

	public void setSeatnum(Short seatnum) {
		this.seatnum = seatnum;
	}

	public Long getUnitid() {
		return unitid;
	}

	public void setUnitid(Long unitid) {
		this.unitid = unitid;
	}

	public String getUnitname() {
		return unitname;
	}

	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}

	public Long getVehicletypeid() {
		return vehicletypeid;
	}

	public void setVehicletypeid(Long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public String getVehicletypename() {
		return vehicletypename;
	}

	public void setVehicletypename(String vehicletypename) {
		this.vehicletypename = vehicletypename;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
	public long getSchedulestatusid() {
		return schedulestatusid;
	}

	public void setSchedulestatusid(long schedulestatusid) {
		this.schedulestatusid = schedulestatusid;
	}

	public List<Map<String, Object>> getVehiclerunplanlist() {
		return vehiclerunplanlist;
	}

	public void setVehiclerunplanlist(List<Map<String, Object>> vehiclerunplanlist) {
		this.vehiclerunplanlist = vehiclerunplanlist;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getDriver1id() {
		return driver1id;
	}

	public void setDriver1id(Long driver1id) {
		this.driver1id = driver1id;
	}
	
	public Long getDriver2id() {
		return driver2id;
	}

	public void setDriver2id(Long driver2id) {
		this.driver2id = driver2id;
	}

	public Long getDriver3id() {
		return driver3id;
	}

	public void setDriver3id(Long driver3id) {
		this.driver3id = driver3id;
	}

	public String getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}

	public boolean isIscheckplan() {
		return ischeckplan;
	}

	public void setIscheckplan(boolean ischeckplan) {
		this.ischeckplan = ischeckplan;
	}
	public String getIsneedfinger() {
		return isneedfinger;
	}

	public void setIsneedfinger(String isneedfinger) {
		this.isneedfinger = isneedfinger;
	}

	public long getQrycurstationid() {
		return qrycurstationid;
	}

	public void setQrycurstationid(long qrycurstationid) {
		this.qrycurstationid = qrycurstationid;
	}
	
	public int getSchedulePlanSeatnum() {
		return schedulePlanSeatnum;
	}

	public void setSchedulePlanSeatnum(int schedulePlanSeatnum) {
		this.schedulePlanSeatnum = schedulePlanSeatnum;
	}
	
	public String getSchedulename() {
		return schedulename;
	}

	public void setSchedulename(String schedulename) {
		this.schedulename = schedulename;
	}

	public long getOldscheduleplanid() {
		return oldscheduleplanid;
	}

	public void setOldscheduleplanid(long oldscheduleplanid) {
		this.oldscheduleplanid = oldscheduleplanid;
	}

	public Vehicledriverreport getVdp() {
		return vdp;
	}

	public void setVdp(Vehicledriverreport vdp) {
		this.vdp = vdp;
	}

	public long getVehiclenoid() {
		return vehiclenoid;
	}

	public void setVehiclenoid(long vehiclenoid) {
		this.vehiclenoid = vehiclenoid;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getRouteids() {
		return routeids;
	}

	public void setRouteids(String routeids) {
		this.routeids = routeids;
	}

	public List<Map<String, Object>> getResultlist() {
		return resultlist;
	}

	public void setResultlist(List<Map<String, Object>> resultlist) {
		this.resultlist = resultlist;
	}
	public String getLicenseenddate() {
		return licenseenddate;
	}

	public void setLicenseenddate(String licenseenddate) {
		this.licenseenddate = licenseenddate;
	}

	public String getLiabilityinsureenddate() {
		return liabilityinsureenddate;
	}

	public void setLiabilityinsureenddate(String liabilityinsureenddate) {
		this.liabilityinsureenddate = liabilityinsureenddate;
	}

	public String getWorkenddate() {
		return workenddate;
	}

	public void setWorkenddate(String workenddate) {
		this.workenddate = workenddate;
	}

	public String getRoadno() {
		return roadno;
	}

	public void setRoadno(String roadno) {
		this.roadno = roadno;
	}

	public String getCompulsoryinsureenddate() {
		return compulsoryinsureenddate;
	}

	public void setCompulsoryinsureenddate(String compulsoryinsureenddate) {
		this.compulsoryinsureenddate = compulsoryinsureenddate;
	}

	public long getStewardid() {
		return stewardid;
	}

	public void setStewardid(long stewardid) {
		this.stewardid = stewardid;
	}
	public String getUnitflag() {
		return unitflag;
	}

	public void setUnitflag(String unitflag) {
		this.unitflag = unitflag;
	}

	public boolean isIsautodispatch() {
		return isautodispatch;
	}

	public void setIsautodispatch(boolean isautodispatch) {
		this.isautodispatch = isautodispatch;
	}

	public Integer getVehicleloadnum() {
		return vehicleloadnum;
	}

	public void setVehicleloadnum(Integer vehicleloadnum) {
		this.vehicleloadnum = vehicleloadnum;
	}

	public int getCheckednum() {
		return checkednum;
	}

	public void setCheckednum(int checkednum) {
		this.checkednum = checkednum;
	}

	public String getWorkno() {
		return workno;
	}

	public void setWorkno(String workno) {
		this.workno = workno;
	}

	public BigDecimal getWaybillnumber() {
		return waybillnumber;
	}

	public void setWaybillnumber(BigDecimal waybillnumber) {
		this.waybillnumber = waybillnumber;
	}

	public String getCodes() {
		return codes;
	}

	public void setCodes(String codes) {
		this.codes = codes;
	}

	public List<Map<String, Object>> getLicenseinfo() {
		return licenseinfo;
	}

	public void setLicenseinfo(List<Map<String, Object>> licenseinfo) {
		this.licenseinfo = licenseinfo;
	}

	public List<Map<String, Object>> getDriverList() {
		return driverList;
	}

	public void setDriverList(List<Map<String, Object>> driverList) {
		this.driverList = driverList;
	}

	public String getDriverids() {
		return driverids;
	}

	public void setDriverids(String driverids) {
		this.driverids = driverids;
	}
    
	
}
