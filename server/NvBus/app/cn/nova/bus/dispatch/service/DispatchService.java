package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.dispatch.model.Roadbillprint;
import cn.nova.bus.dispatch.model.Vehicledriverreport;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface DispatchService {
	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList, long curstationid,
			Date departdate,long qrycurstationid);

	public List<Map<String, Object>> qryRouteTree(long orgid);

	public List<Map<String, Object>> qryCurOrg(String orgids);

	public List<Map<String, Object>> qryDriver(Long driverid);

	public List<Map<String, Object>> qryDriverbycardno(String cardno) ;

	// 查询车辆人员计划信息
	public List<Map<String, Object>> qrySchedulevehiclepeopleplan(
			Long scheduleid, Long departstationid, Date departdate);

	// 查询车辆报到信息
	public List<Map<String, Object>> qryVehiclereport(
			Vehiclereport vehiclereport);

	// 实现车辆报到
	//public boolean vehicleReport(Vehiclereport vehiclereport,
	//		long departstationid, String vehicleno,Global global) throws ServiceException;

	// 实现车辆报到(车辆应班信息录入)
	public MethodResult vehicleReport(Vehiclereport vehiclereport,
			Vehicledriverreport vdp, Long departstationid, String vehicleno,
			Global global) throws ServiceException;
	/*
	public MethodResult report(Vehiclereport vehiclereport, String vehicleno,
			Scheduleplan scheduleplan, Vehicle reportvehicle,
			long departstationid) throws ServiceException;*/
	
	// 根据IC卡进行车辆报到
/*	public MethodResult cardNoReport(Vehiclereport vehiclereport,
			String cardno, long departstationid) throws ServiceException;
*/
	// 根据IC卡取得车辆信息
	public List<Map<String, Object>> qryVehicle(String cardno)
			throws ServiceException;

	// 取消报到操作
	public boolean cancelReport(Vehiclereport vehiclereport, long curStationid,
			String ip) throws ServiceException;

	// 返回若为空，则不做晚点处理，否则晚点处理，请注意修改schedulestatus中状态
	public Vehiclelate vehicleLater(Vehiclereport vehiclereport,
			Scheduleplan scheduleplan, String departtime)
			throws ServiceException;

	// 判断该班次晚点分钟数，若为0表示没晚点
	public long laterMinutes(Long departstationid, Long scheduleid,
			Date departDate) throws ServiceException;

	// 脱班操作
	public boolean vehicleLost(Vehiclelost vehiclelost) throws ServiceException;

	// 顶班操作其中vehiclepeopleplan中orgid:为当前操作者的机构ID
	public boolean chanagePlanVehicle(
			Schedulevehiclepeopleplan vehiclepeopleplan)
			throws ServiceException;

	// 停售
	public boolean stopTicketsell(long scheduleplanid, long departstationid,
			Global global) throws ServiceException;

	// 发售
	public boolean allowTicketsell(long scheduleplanid, long departstationid,
			Global global) throws ServiceException;

	// 停班
	public boolean stopScheduleplan(long scheduleplanid, long departstationid,
			long createby) throws ServiceException;

	// 停班恢复
	public boolean allowScheduleplan(long scheduleplanid, long departstationid,
			String ip, long createby) throws ServiceException;

	public Roadbillprint saveRoadbill(Roadbillprint roadbillprint)
			throws ServiceException;

	// 放空操作
	public boolean departScheduleNoPrint(Vehiclereport vehiclereport)
			throws ServiceException;

	// 取消放空操作
	public boolean undodepartScheduleNoPrint(Vehiclereport vehiclereport)
			throws ServiceException;

	/**
	 * 判断车辆安检信息
	 * @param vehcielid
	 * @param departdate 
	 * @param orgid
	 * @return -1:未检 1:当日合格 0:不合格 2:无安检计划无需校验安检 3:24小时内安检合格，-2:已发班里程大于设置需要重复安检里程，提示需要再次安检
	 * @throws ServiceException
	 */
	public MethodResult checkVehicle(long vehcielid, Date departdate,long orgid)
			throws ServiceException;

	// 该IC卡该日期的营运计划运行线路
	public List<Map<String, Object>> getScheduleplanroute(Date departdate,
			long departstationid, String cardno,String serialnumber) throws ServiceException;

	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList,Long vehicleid,boolean isautodispatch);

	// 换车报到
	public boolean changeReportVehicle(Vehiclereport vehiclereport,
			long departstationid, String ip, Global global) throws ServiceException;

	// 使用车牌号码查找报到
	public List<Map<String, Object>> qryScheduleplanroute(long vehicleid)
			throws ServiceException;


	
	/*public MethodResult report(Vehiclereport vehiclereport, String vehicleno,
			Scheduleplan scheduleplan, Vehicle reportvehicle,
			long departstationid,Global global) throws ServiceException;*/
	
	
	/**
	 * 车辆运行计划查询
	 * @param vehicleid
	 * @param departdate
	 * @return
	 */
	public List<Map<String, Object>> qryVehicleRunplan(Long vehicleid, Date departdate);
	
	/**
	 * 判断车辆是否只允许车辆报到在已指定的线路中
	 * @param orgid
	 * @param routeid
	 * @param scheduleid
	 * @throws ServiceException
	 */
	public boolean isOnlyReportRoute(long vehicleid,long scheduleid) throws ServiceException ;
	
	/**
	 * 查询上次报到的非流水班发车时间     或者        流水班上次报到时间
	 * @param vehicleid
	 * @param scheduleplan
	 * @param departstationid
	 * @return
	 */
	public String checkreporttime(long vehicleid,Scheduleplan scheduleplan,long departstationid);
	
	/**
	 * 正副驾驶员的证件判断及有效期到期提示
	 * @param orgid
	 * @param driver1id
	 * @param driver2id
	 * @return
	 */
	public String showValidate(long orgid, long driver1id, long driver2id,
			long driver3id, long driver4id) throws ServiceException;

	/**
	 * 更新班次计划表座位信息 李电志 2015年6月5日 11:55:20
	 * @param scheduleplanid 班次计划id
	 * @param schedulePlanSeatnum 班次计划座位数
	 */
	public void updateSchedulePlan(Long scheduleplanid, int schedulePlanSeatnum);
	/**
	 * IC卡报班同线路间隔时间限制判断
	 * @param scheduleid
	 *@return 
	 */
	public String qryRouteReportInterval(long scheduleid);
	/**
	 * IC卡报班驾驶员两次报班的最小时间间隔限制判断
	 * @param scheduleid
	 *@return 
	 */
	public String qryDriverReportInterval(long driverid);

	/**
	 * 取消并班  李电志  2015年6月17日 10:08:49
	 * @param schedulename
	 * @param departdate
	 * @param oldscheduleplanid 
	 * @return
	 * @throws ServiceException 
	 */
	public String cancleShift(String schedulename, Date departdate, long oldscheduleplanid) throws ServiceException;

	/**
	 * 获取报道车辆信息 李电志 2015年7月29日 02:48:40
	 * @param vehicleId
	 * @return 
	 * @throws ServiceException
	 *//*
	public Vehicle getVehicleInfo(Long vehicleId) throws ServiceException;

	*//**
	 * 获取车辆品牌型号表信息  李电志  2015年7月29日 03:00:53
	 * @param vehiclebrandmodelid
	 * @return
	 *//*
	public Vehiclebrandmodel getVehiclebrandmodelInfo(Long vehiclebrandmodelid) throws ServiceException;

	*//**
	 * 获取车辆座位图明细表信息 李电志 2015年7月29日 03:12:38
	 * @param vehiclebrandmodelid
	 * @return
	 * @throws ServiceException
	 *//*
	public List<Vehicleseatplandetail> getVehicleseatplandetailInfo(Long vehiclebrandmodelid) throws ServiceException;

	*//**
	 * 获取车辆内部空间表信息 李电志 2015年7月29日 03:29:40
	 * @param vehicleSpaceId
	 * @return
	 * @throws ServiceException
	 *//*
	public Vehiclespace getVehicleSpaceInfo(Long vehicleSpaceId) throws ServiceException;

	*//**
	 * 获取执行票价表ticketprice的信息  李电志 2015年7月29日 05:49:29
	 * @param schedulePlanceId
	 * @return
	 * @throws ServiceException
	 *//*
	public List<Ticketprice> getSchTicketPriceList(
			Long schedulePlanceId) throws ServiceException;

	*//**
	 * 修改执行票价表ticketprice的座位类型 李电志 2015年7月29日 06:17:30
	 * @param ticketprice
	 * @return 
	 * @throws ServiceException
	 *//*
	public boolean updateTicketPrice(Ticketprice ticketprice) throws ServiceException;*/

	/**
	 * 报班时由车牌号自动显示正副驾驶员
	 * @param vehicleid
	 * @return
	 * @throws ServiceException
	 */
	public List qryVehicleDriver(long vehicleid, Date departdate, long scheduleid) throws ServiceException;

	public boolean updateSeattypetoTicketprice(Vehiclereport vehiclereport,Global global) throws ServiceException;
	public List qryvehiclerouteset(List<PropertyFilter> buildFromHttpRequest) throws ServiceException;

	public List qryroutebyvid(Long id);
	boolean savevehicleroute(long id, Long orgid, Long vehicleid,
			String routeid, Global global) throws Exception;

	 boolean delvehicleroutectrl(long id);

	 public String cansaleticket(long oldscheduleplanid) throws ServiceException;
	 /**
	  * 自动报班获取具体信息
	  * @param buildFromHttpRequest
	  * @return List
	  */
	 public List qryAutoReport(List<PropertyFilter> buildFromHttpRequest);
	 
	 public String showExaminCheck(long vehicleid,long orgid,long driver1id,long driver2id,long stewardid,Date departdate,long scheduleid) throws Exception;
	 	 /**
	  *检验是否具有车属单位权限(林东客运站)
	  * @param vehicleid
	  * @param unitflag
	  * @return
	  */
	public int checkUnitPermisssion(Long vehicleid, String unitflag) throws Exception;
	
	/**
	 * 修改司乘人员
	 */
	public MethodResult editDriverSteward(Global global, Vehiclereport vehiclereport)throws Exception;
	
	/**
	 * 统计车载人数
	 * @param stationid
	 * @param scheduleplanid
	 * @return
	 */
	public Integer coutVehicleLoadNum(Date printtime, Long stationid, Long scheduleplanid, Long vehiclereportid);

	/**
	 * 统计检票人数
	 * @param scheduleplanid
	 * @return
	 */
	public int countCheckednum(Long scheduleplanid);

	public Vehiclereport queryVehiclereport(long vehiclereportid);

	public Vehicle queryVehicle(long vehicleid);

	/**
	 * 根据条形码查询对应的证件信息
	 * @param codes
	 * @return
	 */
	public List<Map<String, Object>> qryLicenseByCode(String codes);

	/**
	 * 查询当天驾驶员是否已经报到过
	 * @param driverids
	 * @param departdate
	 * @return
	 */
	public List<Map<String, Object>> qryDriverReport(String driverids,
			Date departdate);
}
