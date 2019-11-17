/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.base.service.VehicletypeService;
import cn.nova.bus.base.service.impl.VehicletypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicletypeAction extends BaseAction{

	private Vehicletype vehicletype;
	private List<Vehicletype> vehiclelist;
	private List<Map<String, Object>> vehiclemap;

	private VehicletypeService vehicletypeService;

	public String query() {
		try {
			vehicletypeService = new VehicletypeServiceImpl();
			setVehiclemap(vehicletypeService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			vehicletypeService = new VehicletypeServiceImpl();
			if (vehicletype != null) {
				if (vehicletype.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					vehicletype.setUpdateby(global.getUserinfo().getId());
					vehicletype.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					vehicletype.setIsactive(true);
					vehicletype.setIslocaldelete(false);
					vehicletype.setUpdateby(global.getUserinfo().getId());
					vehicletype.setCreateby(global.getUserinfo().getId());
					vehicletype.setOrgid(global.getOrganization().getId());
					vehicletype.setSynccode(null);
					vehicletype.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					vehicletype.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				MethodResult result = vehicletypeService.save(vehicletype);
				if (result.getResult() == 0) {
					msg = "保存操作失败！";
					markFail();
				}
				if (result.getResultMsg() != null) {
					msg = msg + result.getResultMsg();
				}
			}
		} catch (ServiceException ex) {
			markFail();
			setMsg(ex.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败:" + e.getMessage();
			markFail();
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			vehicletypeService = new VehicletypeServiceImpl();
			if (vehicletype != null) {
				if (vehicletype.getId() > 0) {
					if (vehicletypeService.isApply(vehicletype.getId())) {
						setMsg("对不起，该车辆类型已经被使用，不能删除！");
						markSuccess();
						vehicletype=  vehicletypeService.getById(vehicletype
								.getId());
						return "json";
					}
					Vehicletype type = vehicletypeService.getById(vehicletype
							.getId());
					type.setIsactive(false);
					type.setIslocaldelete(true);
					type.setUpdateby(global.getUserinfo().getId());
					type.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					MethodResult result = vehicletypeService.save(type);
					if (result.getResult() == 0) {
						setMsg("删除失败！");
						markFail();
					} else {
						setMsg("删除成功！");
						markSuccess();
						vehicletype=null;
					}
				}
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg(ex.getMessage());
			markFail();
		}
		return "json";
	}

	@Transient
	public Vehicletype getVehicletype() {
		return vehicletype;
	}

	public void setVehicletype(Vehicletype vehicletype) {
		this.vehicletype = vehicletype;
	}

	public List<Vehicletype> getVehiclelist() {
		return vehiclelist;
	}

	public void setVehiclelist(List<Vehicletype> vehiclelist) {
		this.vehiclelist = vehiclelist;
	}

	public List<Map<String, Object>> getVehiclemap() {
		return vehiclemap;
	}

	public void setVehiclemap(List<Map<String, Object>> vehiclemap) {
		this.vehiclemap = vehiclemap;
	}

}
