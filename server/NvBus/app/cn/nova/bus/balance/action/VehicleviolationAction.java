/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.balance.action<br/>
 * <b>文件名：</b>VehicleviolationAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-9-12 上午11:39:53<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.balance.service.VehicleviolationService;
import cn.nova.bus.balance.service.impl.VehicleviolationServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleviolationAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-9-12 上午11:39:53<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleviolationAction extends BaseAction{

	private Vehicleviolation vehicleviolation;
	private Long id;
	private long vehicleid;
	private List<Map<String, Object>> resultmap;

	private VehicleviolationService violationService;

	public String query() {
		try {
			violationService = new VehicleviolationServiceImpl();
			setResultmap(violationService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			violationService = new VehicleviolationServiceImpl();
			if (vehicleviolation != null) {
				if (vehicleviolation.getId() == 0) {
					setMsg("添加成功！");
				} else {
					setMsg("修改成功！");
				}
				markSuccess();
				setId(violationService.save(vehicleviolation, global));
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markSuccess();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public String delVehicleviolation() {
		try {
			violationService = new VehicleviolationServiceImpl();
			if (violationService.delete(vehicleviolation.getId())) {
				setMsg("删除成功！");
				markSuccess();
			} else {
				setMsg("删除失败！");
				markSuccess();
			}
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String processVehicleviolation() {
		Global global = CurrentUtil.getGlobal();
		try {
			violationService = new VehicleviolationServiceImpl();
			if (vehicleviolation != null) {
				setMsg("处理成功!");
				markSuccess();
			}
			setId(violationService.processVehicleviolation(
					vehicleviolation, global));
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markSuccess();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String getRoutename() {
		try {
			violationService = new VehicleviolationServiceImpl();
			if (vehicleid != 0) {
				String result=violationService.getRoutename(vehicleid);
				setMsg(result);
			}
		} catch (Exception e) {
			setMsg(null);
			markSuccess();
		}
		return "json";
	}

	public Vehicleviolation getVehicleviolation() {
		return vehicleviolation;
	}

	public void setVehicleviolation(Vehicleviolation vehicleviolation) {
		this.vehicleviolation = vehicleviolation;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

}
