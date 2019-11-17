package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.service.VehicleService;
import cn.nova.bus.base.service.impl.VehicleServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 车辆管理
 * 
 * @author
 * @version 0.1
 */
public class VehicleAction extends BaseAction{
	private List<Map<String, Object>> vehiclemap;
	private List<Map<String, Object>> vehiclepic;
	private Vehicle vehicle;
	private String picture;
	private String name;
	private Long vehicleid;
	private String synccode;
	private Date validdate;
	private boolean isidcardlogin;

	private VehicleService vehicleService;

	public String save() {
		try {
			vehicleService = new VehicleServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (vehicle != null) {
				vehicle.setPicture(ConversionUtil.toByteArr(picture));
				if (vehicle.getId() > 0) {
					vehicle.setUpdateby(global.getUserinfo().getId());
					vehicle.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));

				} else {
					vehicle.setCreateby(global.getUserinfo().getId());
					vehicle.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					vehicle.setUpdateby(global.getUserinfo().getId());
					vehicle.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));

				}
				vehicle.setOrgid(global.getOrganization().getId());
				if (vehicle.getId() > 0) {
					vehicle.setSynccode(synccode);
					msg = "修改成功！";
					markSuccess();
				} else {
					msg = "添加成功！";
					markSuccess();
				}
				
				vehicle = vehicleService.save(vehicle,global,validdate);
				if (vehicle != null) {
					vehicleid = vehicle.getId();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "操作失败！";
			markFail();
		}
		return "json";

	}

	public Date getValiddate() {
		return validdate;
	}

	public void setValiddate(Date validdate) {
		this.validdate = validdate;
	}

	public String updateVehicle() {
			try {
				vehicleService = new VehicleServiceImpl();
				vehicleService.updateVehicle(vehicle);
				markSuccess();
			} catch (Exception e) {
				markFail();
				play.Logger.error(e.getMessage(), e);
			}
			return "json";
		}
	
	public String delete() {
		if (vehicle.getId() > 0) {
			vehicleService = new VehicleServiceImpl();
			boolean result = vehicleService.delete(vehicle.getId());
			if (result) {
				msg = "删除成功！";
				markSuccess();
			} else {
				msg = "删除失败！";
				markFail();
			}
		}
		return "json";
	}

	public String qryVehicles() {
		try {
			vehicleService = new VehicleServiceImpl();
			setVehiclemap(vehicleService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryVehiclePic() {
		try {
			vehicleService = new VehicleServiceImpl();
			setVehiclepic(vehicleService.getVehiclePic(vehicleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String updatePrintdate() {
		Global global = CurrentUtil.getGlobal();
		vehicleService = new VehicleServiceImpl();
		vehicleService.updatePrintdate(vehicle.getId(),global.getUserinfo().getId());
		return "json";
	}
	private String vehicleno;
	
	 public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public String qryVehiclebyIdcard() {
//			if (vehicle.getId() > 0  ||  vehicle.getCardno()!=null) {
				vehicleService = new VehicleServiceImpl();
				Vehicle veh = vehicleService.qryVehiclebyIdcard(vehicle.getId(),vehicle.getGprs(),vehicle.getCardno(),isidcardlogin);
				if (veh!=null) {
					vehicleid=veh.getId();
					vehicleno=veh.getVehicleno();				
					msg = "查询成功！";
					markSuccess();
				} else {
					vehicleno="";
					msg = "你输入的信息有误！";
					markFail();
				}
//			}
			return "json";
		}
	
	public String qryVehicleById() {
		try {
			vehicleService = new VehicleServiceImpl();
			setVehiclemap(vehicleService.qryVehicleById(vehicleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 车牌审核/取消审核
	 */
	public String vehicleAudit(){
		if (vehicle.getId() > 0) {
			vehicleService = new VehicleServiceImpl();
			boolean result = vehicleService.vehicleAudit(vehicle);
			if(vehicle.getIsaudited()){
				msg = "审核";
			}else{
				msg = "取消审核";
			}
			
			if (result) {
				msg = msg + "成功！";
				markSuccess();
			} else {
				msg = msg + "失败！";
				markFail();
			}
		}
		return "json";
	}
	
	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public List<Map<String, Object>> getVehiclemap() {
		return vehiclemap;
	}

	public void setVehiclemap(List<Map<String, Object>> vehiclemap) {
		this.vehiclemap = vehiclemap;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public List<Map<String, Object>> getVehiclepic() {
		return vehiclepic;
	}

	public void setVehiclepic(List<Map<String, Object>> vehiclepic) {
		this.vehiclepic = vehiclepic;
	}

	public boolean isIsidcardlogin() {
		return isidcardlogin;
	}

	public void setIsidcardlogin(boolean isidcardlogin) {
		this.isidcardlogin = isidcardlogin;
	}
	
}
