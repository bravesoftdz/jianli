package controllers.buttjoin;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import jxl.read.biff.BiffException;

import oracle.sql.BLOB;
import oracle.sql.BlobDBAccess;

import controllers.BaseController;


import play.db.jpa.JPA;
import play.mvc.Catch;
import util.CurrentUtil;
import util.DateUtils;
import util.ExcelUtil;
import util.JsonUtil;
import util.TransactionUtil;
import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.service.DriverService;
import cn.nova.bus.archive.service.impl.DriverServiceImpl;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.service.RouteService;
import cn.nova.bus.base.service.StationService;
import cn.nova.bus.base.service.UnitService;
import cn.nova.bus.base.service.VehicleService;
import cn.nova.bus.base.service.impl.RouteServiceImpl;
import cn.nova.bus.base.service.impl.StationServiceImpl;
import cn.nova.bus.base.service.impl.UnitServiceImpl;
import cn.nova.bus.base.service.impl.VehicleServiceImpl;
import cn.nova.bus.check.model.Chkitem;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.check.service.SecuritycheckService;
import cn.nova.bus.check.service.impl.SecuritycheckServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.VehicleReportService;
import cn.nova.bus.dispatch.service.impl.ScheduleplanServiceImpl;
import cn.nova.bus.dispatch.service.impl.VehicleReportServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.query.service.TicketSellQryService;
import cn.nova.bus.query.service.impl.TicketSellQryServiceImpl;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
/**
 * 安全接口系统对接
 * @author feng
 *
 */
public class SecurityButtJoinAction extends BaseController{

	@Catch(Exception.class)
	public static void exceptionInterceptor(Throwable e){
		play.Logger.error(e.getMessage(), e);
		MethodResult result = new MethodResult();
		result.setResult(MethodResult.FAILURE);
		result.setResultMsg("服务器内部异常");
		renderResult(result);
	}
	/**
	 * 标准站点上传（excel文件）
	 * @param file1
	 */
	public static void uploadExcel(File file1) {
		List<List<List<String>>> list;
		MethodResult result = null;
		try {
			if(file1 == null){
				result = new MethodResult(MethodResult.SUCCESS,"文件上传失败！",null);
				renderText(JsonUtil.toFormatString(result));
			}
			//获取excel文件的的多个sheet页数据
			list = ExcelUtil.readExcelByPoi(file1);
			//处理第一个sheet页下的数据
			if(list==null || list.size()<1 || list.get(0).size()<1){
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("excel文件中没有数据！");
			}else{
				StationService stationService = new StationServiceImpl();
				//获取第一个sheet页（二维数组）
				List<List<String>> sheeplist = list.get(0);
				if(sheeplist!=null && sheeplist.size()>4){
					sheeplist.remove(sheeplist.size()-1);
					sheeplist.remove(2);
					sheeplist.remove(1);
					sheeplist.remove(0);
				}
				result = stationService.dispose(sheeplist);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			//出现异常回滚
			TransactionUtil.setRollbackOnly();
		}
		renderText(JsonUtil.toFormatString(result));
	}
	
	/**
	 * 根据票号查询是否当天的票
	 * @param datetoDay
	 * @param StrTicketNumber
	 */
	public static void getCheckedTicketValidity(String datetoDay,String strTicketNumber){
		TicketSellQryService ticketSellQryService = new TicketSellQryServiceImpl();
		if(datetoDay!=null && !datetoDay.equals("") && strTicketNumber!=null && !strTicketNumber.equals("")){
			Map<String,String> ms = ticketSellQryService.checkTicketValidity(datetoDay,strTicketNumber);
			renderText(JsonUtil.toFormatString(ms));
		}else{
			renderText("{'boolTicketValidity':'0'}");
		}
	}
	/**
	 * 根据车牌号获取车辆报班信息、驾驶员从业证号
	 * @param DateToDay
	 * @param strDriverNumbers
	 * 
	 */
	public static void getDriverReportInfo(String dateToDay,String timeToDay,String vehicleno){
		VehicleReportService vehicleReportService = new VehicleReportServiceImpl();
		if(dateToDay!=null && !dateToDay.equals("") && vehicleno!=null && !vehicleno.equals("")
				){
			List<Map<String,String>> ms = vehicleReportService.getDriverReportInfo(dateToDay,timeToDay,vehicleno);
			renderText(JsonUtil.toFormatString(ms));
		}else{
			renderText("[{'boolDriverReportValidity':'0'}]");
		}
	}
	/**
	 * 根据发车日期和报到车辆id查询检票数量以及小孩数量
	 * @param dateToDay
	 * @param repordid
	 */
	public static void getPassengerOfNumber(String dateToDay,String repordid){
		VehicleReportService vehicleReportService = new VehicleReportServiceImpl();
		if(dateToDay!=null && !dateToDay.equals("") && repordid!=null && !repordid.equals("")
				){
			Map<String,String> ms = vehicleReportService.getPassengerOfNumber(dateToDay,repordid);
			renderText(JsonUtil.toFormatString(ms));
		}else{
		}
	}
	/**
	 * 基础接口-获取车票号信息
	 */
	public static void getVehicle(){
		String status = "0";
		String message = "";
		try {
			VehicleService vehicleService = new VehicleServiceImpl();
			List<Map<String, Object>> vList = vehicleService.getVehicleInfo();
			status = "1";
			message = "调用成功";
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			map.put("data", vList);
			renderText(JsonUtil.toFormatString(map));
		} catch (Exception e) {
			status = "0";
			message = "调用失败"+e.getMessage();
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			renderText(JsonUtil.toFormatString(map));
		}
	}
	/**
	 * 基础接口-获取驾驶员信息
	 */
	public static void getDriver(){
		String status = "0";
		String message = "";
		try {
			DriverService driverService = new DriverServiceImpl();
			List<Driver> vList = driverService.getDriverInfo();
			status = "1";
			message = "调用成功";
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			map.put("data", vList);
			renderText(JsonUtil.toFormatString(map));
		} catch (Exception e) {
			status = "0";
			message = "调用失败"+e.getMessage();
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			renderText(JsonUtil.toFormatString(map));
		}
	}
	/**
	 * 基础接口-获取线路接口
	 */
	public static void getRoute(){
		String status = "0";
		String message = "";
		try {
			RouteService routeService = new RouteServiceImpl();
			List<Map<String, Object>> vList = routeService.getRouteInfo();
			status = "1";
			message = "调用成功";
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			map.put("data", vList);
			renderText(JsonUtil.toFormatString(map));
		} catch (Exception e) {
			status = "0";
			message = "调用失败"+e.getMessage();
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			renderText(JsonUtil.toFormatString(map));
		}
	}
	/**
	 * 基础接口-获取
	 */
	public static void getUnit(){
		String status = "0";
		String message = "";
		try {
			UnitService unitService = new UnitServiceImpl();
			List<Map<String, Object>> vList = unitService.getUnitInfo();
			status = "1";
			message = "调用成功";
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			map.put("data", vList);
			renderText(JsonUtil.toFormatString(map));
		} catch (Exception e) {
			status = "0";
			message = "调用失败"+e.getMessage();
			Map map = new HashMap();
			map.put("status", status);
			map.put("message", message);
			renderText(JsonUtil.toFormatString(map));
		}
	}
	
	public static void saveSecuritycheckresult(String checkitem,String vehicleno,String periodtype,String checkby,
			String checktime,String result,String notenum)
	{ 
		play.Logger.info("进入安检对接系统接口......");
		play.Logger.info("传递参数内容如下：第一个参数"+checkitem);
		SecuritycheckService securitycheckservice = new SecuritycheckServiceImpl();
		List<Chkitem> itemList = null;
		if(checkitem!=null && !"".equals(checkitem)){
			try {
				itemList = (List<Chkitem>) cn.nova.openapi.util.JsonUtil.paseJson2Collection(checkitem, Chkitem.class);
			} catch (Exception e) {
				play.Logger.info("安检参数checkitem解析异常"+e.getMessage());
				e.printStackTrace();
			}
		}
		Map<String,String> map = securitycheckservice.saveSecuritycheckresult(itemList, vehicleno, periodtype, checkby,
				 checktime, result, notenum);
		
		renderText(map);
	}
	/**
	 * 中心调用
	 * 始发站进行班次加座处理
	 */
	public static void addSeat(String schedulesynccode,String departdate,String addum) {
		play.Logger.info("中心调用始发站：schedulesynccode："+schedulesynccode+"departdate："+departdate+"addum："+addum);
		IDAO dao = new EntityManagerDaoSurport();
		Map<String,Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(schedulesynccode) && StringUtils.isNotEmpty(departdate) && 
				StringUtils.isNotEmpty(addum)){
			Date currenttime = new Date();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQS_t!synccode",schedulesynccode));
			Schedule schedule = (Schedule) dao.uniqueResult(Schedule.class, propertyFilters);
			Long scheduleid = schedule.getId();
			ScheduleplanService service = new ScheduleplanServiceImpl();
			Scheduleplan scheduleplan = new Scheduleplan();
			scheduleplan.setScheduleid(scheduleid);
			scheduleplan.setDepartdate(DateUtils.strToDate(departdate));
			scheduleplan.setSeatnum(new Short(addum));
			scheduleplan.setUpdateby(0L);
			scheduleplan.setUpdatetime(currenttime);
			scheduleplan.setUpdatetime(new Date());
			try {
				service.saveseatnum(scheduleplan, 1L, "127.0.0.1","3");
				map.put("flag", "1");
				map.put("msg", "始发站加座成功！");
			} catch (Exception e) {
				play.Logger.error("跨区配置中心调用始发站加座失败scheduleid："+scheduleid, e);
				map.put("flag", "0");
				map.put("msg", "始发站加座失败！");
			}
		}else{
			map.put("flag", "0");
			map.put("msg", "参数信息传递有误，请检查参数！");
		}
		renderText(map);
	}
	
}
