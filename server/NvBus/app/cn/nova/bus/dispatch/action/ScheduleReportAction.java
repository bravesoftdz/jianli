package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.ScheduleReportService;
import cn.nova.bus.dispatch.service.impl.ScheduleReportServiceImpl;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;

public class ScheduleReportAction extends BaseAction{
	public List<Map<String, Object>> getReportmap() {
		return reportmap;
	}

	public void setReportmap(List<Map<String, Object>> reportmap) {
		this.reportmap = reportmap;
	}
	
	private Vehiclereport vehiclereport;  //车辆报到Bean	
	private Organization organization;  //机构表Bean	
	public Vehiclereport getVehiclereport() {
		return vehiclereport;
	}

	public void setVehiclereport(Vehiclereport vehiclereport) {
		this.vehiclereport = vehiclereport;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public Schedulestatus getSchedulestatus() {
		return schedulestatus;
	}

	public void setSchedulestatus(Schedulestatus schedulestatus) {
		this.schedulestatus = schedulestatus;
	}

	private Vehicle vehicle;    //车辆表	
	private Schedulestatus schedulestatus;  //班次运行状态Bean
	
	private List<Map<String, Object>> reportmap;	

	public String query() {
		try {			
			ScheduleReportService scheduleReportService = new ScheduleReportServiceImpl();
			reportmap = scheduleReportService.query(vehiclereport.getFlag(),organization.getId(),schedulestatus.getDepartdate(),vehicle.getVehicleno());			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String reportbyIC() {
		Global global = CurrentUtil.getGlobal();
		try {
			//暂时注释掉
			//msg = scheduleReportService.reportbycard(vehiclereport,organization.getId(),vehicle.getCardno(),schedulestatus.getDepartdate(),global.getUserID());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "IC卡报班失败!";
			markFail();
		}
		return "json";
	}

}
