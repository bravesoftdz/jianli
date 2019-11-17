/**
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.service.VehiclebrandmodelService;
import cn.nova.bus.base.service.impl.VehiclebrandmodelServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class VehiclebrandmodelAction extends BaseAction{
	private Vehiclebrandmodel vehiclebrandmodel; //添加、修改、删除接收数据
	private String picture;//接收传回的图片数据
	private List<Map<String,Object>> vehiclebrandmodelist;
	private long vehiclebrandmodelid; //返回添加、修改的id
	private VehiclebrandmodelService vehiclebrandmodelService;
	
	public String find(){
		try {
			vehiclebrandmodelService = new VehiclebrandmodelServiceImpl();
			setVehiclebrandmodelist(vehiclebrandmodelService.find(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String saveVehiclebrandmodel(){
		Global global = CurrentUtil.getGlobal();
		vehiclebrandmodelService = new VehiclebrandmodelServiceImpl();
		vehiclebrandmodel.setPicture(ConversionUtil.toByteArr(picture));
		if(vehiclebrandmodel.getId()<=0){
			try {
				vehiclebrandmodel = vehiclebrandmodelService.add(vehiclebrandmodel, global.getUserinfo().getId());
				setMsg("添加车辆品牌型号成功");
				setVehiclebrandmodelid(vehiclebrandmodel.getId());
				markSuccess();
			} catch (ServiceException e) {
				setMsg("添加车辆品牌型号失败，"+e.getExceptionMessage());
				markFail();
			}
		}
		else{
			try {
				vehiclebrandmodel = vehiclebrandmodelService.update(vehiclebrandmodel, global.getUserinfo().getId());
				setMsg("修改车辆品牌型号成功");
				setVehiclebrandmodelid(vehiclebrandmodel.getId());
				markSuccess();
			} catch (ServiceException e) {
				setMsg("修改车辆品牌型号失败，"+e.getExceptionMessage());
				markFail();
			}
		}
		return "json";
	}
	
	public String deleteVehiclebrandmodel(){
		Global global = CurrentUtil.getGlobal();
		try {
			vehiclebrandmodelService = new VehiclebrandmodelServiceImpl();
			vehiclebrandmodelService.delete(vehiclebrandmodel.getId(), global.getUserinfo().getId());
			setMsg("删除车辆品牌型号成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除车辆品牌型号失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	public String isUsed(){
		Global global = CurrentUtil.getGlobal();
		try {
			vehiclebrandmodelService = new VehiclebrandmodelServiceImpl();
			if(global!=null){
			   if (vehiclebrandmodelService.isUsed(vehiclebrandmodel)){
				   markSuccess();
			   }else{
				   markFailure();
			   }
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	
	public void setVehiclebrandmodel(Vehiclebrandmodel vehiclebrandmodel) {
		this.vehiclebrandmodel = vehiclebrandmodel;
	}

	@Transient
	public Vehiclebrandmodel getVehiclebrandmodel() {
		return vehiclebrandmodel;
	}
	public void setVehiclebrandmodelist(List<Map<String,Object>> vehiclebrandmodelist) {
		this.vehiclebrandmodelist = vehiclebrandmodelist;
	}
	public List<Map<String,Object>> getVehiclebrandmodelist() {
		return vehiclebrandmodelist;
	}

	public void setVehiclebrandmodelid(long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}

	public long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	@Transient
	public String getPicture() {
		return picture;
	}

}
