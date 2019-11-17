/**
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehicleseatplan;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.base.service.VehicleseatplanService;
import cn.nova.bus.base.service.impl.VehicleseatplanServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class VehicleseatplanAction extends BaseAction{
	private VehicleseatplanService vehicleseatplanService;
	private List<Map<String,Object>> vehicleseatplanlist;
	private List<Map<String,Object>> vehicleseatplandetaillist;
	private Vehicleseatplan vehicleseatplan;  //接收编辑的座位图及明细数据
	private List<Vehicleseatplandetail> saveVehicleseatplandetails;
	
	public String findVehicleseatplan(){
		try {
			vehicleseatplanService = new VehicleseatplanServiceImpl();
			setVehicleseatplanlist(vehicleseatplanService.find(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String findVehicleseatplandetail(){
		vehicleseatplanService = new VehicleseatplanServiceImpl();
		setVehicleseatplandetaillist(vehicleseatplanService.finddetail(vehicleseatplan.getVehiclebrandmodelid()));
		return "json";
	}
	
	public String deleteVehicleseatplan(){
		vehicleseatplanService = new VehicleseatplanServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			vehicleseatplanService.delete(vehicleseatplan.getVehiclebrandmodelid(), global.getUserinfo().getId());
			markSuccess();
			setMsg("删除车辆座位图成功");
		} catch (Exception e) {
			markFail();
			setMsg("删除车辆座位图失败"+e.getMessage());
		}
		return "json";
	}
	
	public String saveVehicleseatplan(){
		vehicleseatplanService = new VehicleseatplanServiceImpl();
		Global global = CurrentUtil.getGlobal();
		vehicleseatplan.setVehicleseatplandetails(getSaveVehicleseatplandetails());
		try {
			vehicleseatplanService.save(vehicleseatplan, global.getUserinfo().getId());
			markSuccess();
			setMsg("设置车辆座位图成功");
		} catch (ServiceException e){
			markFail();
			setMsg("设置车辆座位图失败"+e.getExceptionMessage());
		} catch (Exception e) {
			markFail();
			setMsg("设置车辆座位图失败"+e.getMessage());
		}
		return "json";
	}

	public void setVehicleseatplanlist(List<Map<String,Object>> vehicleseatplanlist) {
		this.vehicleseatplanlist = vehicleseatplanlist;
	}

	public List<Map<String,Object>> getVehicleseatplanlist() {
		return vehicleseatplanlist;
	}

	public void setVehicleseatplandetaillist(
			List<Map<String,Object>> vehicleseatplandetaillist) {
		this.vehicleseatplandetaillist = vehicleseatplandetaillist;
	}

	public List<Map<String,Object>> getVehicleseatplandetaillist() {
		return vehicleseatplandetaillist;
	}

	public void setVehicleseatplan(Vehicleseatplan vehicleseatplan) {
		this.vehicleseatplan = vehicleseatplan;
	}

	/**
	 * @return
	 */
	@Transient
	public Vehicleseatplan getVehicleseatplan() {
		return vehicleseatplan;
	}

	public void setSaveVehicleseatplandetails(
			List<Vehicleseatplandetail> saveVehicleseatplandetails) {
		this.saveVehicleseatplandetails = saveVehicleseatplandetails;
	}

	public List<Vehicleseatplandetail> getSaveVehicleseatplandetails() {
		return saveVehicleseatplandetails;
	}

}
