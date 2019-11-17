/**
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.base.service.VehiclespaceService;
import cn.nova.bus.base.service.impl.VehiclespaceServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class VehiclespaceAction extends BaseAction{
	private VehiclespaceService vehiclespaceservice;
	private List<Map<String,Object>> vehiclespacelist;
	private Vehiclespace vehiclespace;
	private String picture;//接收传回的图片数据
	private long vehiclespaceid; //返回添加、修改的id
	
	public String findVehiclespace(){
		vehiclespaceservice = new VehiclespaceServiceImpl();
		setVehiclespacelist(vehiclespaceservice.find(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String saveVehiclespace(){
		vehiclespaceservice = new VehiclespaceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		vehiclespace.setPicture(ConversionUtil.toByteArr(picture));
		if(getVehiclespace().getId()<=0){
			try {
				vehiclespace=vehiclespaceservice.add(getVehiclespace(), global.getUserinfo().getId());
				setMsg("添加车辆内部空间类型成功");
				markSuccess();
				setVehiclespaceid(vehiclespace.getId());
			} catch (ServiceException e) {
				setMsg("添加车辆内部空间类型失败，"+e.getExceptionMessage());
				markFail();
			}
		}
		else{
			try {
				vehiclespace=vehiclespaceservice.update(getVehiclespace(), global.getUserinfo().getId());
				setMsg("修改车辆内部空间类型成功");
				markSuccess();
				setVehiclespaceid(vehiclespace.getId());
			} catch (ServiceException e) {
				setMsg("修改车辆内部空间类型失败，"+e.getExceptionMessage());
				markFail();
			}
		}
		return "json";
	}

	public String deleteVehiclespace(){
		Global global = CurrentUtil.getGlobal();
		try {
			vehiclespaceservice = new VehiclespaceServiceImpl();
			vehiclespaceservice.delete(getVehiclespace(), global.getUserinfo().getId());
			setMsg("删除车辆内部空间类型成功");
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除车辆内部空间类型失败，"+e.getMessage());
			markFail();
		}
		return "json";
	}
	
	public void setVehiclespacelist(List<Map<String,Object>> vehiclespacelist) {
		this.vehiclespacelist = vehiclespacelist;
	}

	public List<Map<String,Object>> getVehiclespacelist() {
		return vehiclespacelist;
	}

	public void setVehiclespace(Vehiclespace vehiclespace) {
		this.vehiclespace = vehiclespace;
	}

	@Transient
	public Vehiclespace getVehiclespace() {
		return vehiclespace;
	}

	public void setVehiclespaceid(long vehiclespaceid) {
		this.vehiclespaceid = vehiclespaceid;
	}

	public long getVehiclespaceid() {
		return vehiclespaceid;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	@Transient
	public String getPicture() {
		return picture;
	}

}
