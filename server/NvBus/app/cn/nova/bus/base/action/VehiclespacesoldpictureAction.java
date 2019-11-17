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

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehiclespacesoldpicture;
import cn.nova.bus.base.service.VehiclespacesoldpictureService;
import cn.nova.bus.base.service.impl.VehiclespacesoldpictureServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehiclespacesoldpictureAction extends BaseAction{

	private Vehiclespacesoldpicture vehiclespacesoldpicture;
	private String picture;
	private Long id;
	private List<Vehiclespacesoldpicture> vehiclespacesoldpicturelist;
	private List<Map<String, Object>> vehiclespacesoldpicturemap;

	private VehiclespacesoldpictureService vehiclespacesoldpictureService;

	public String query() {
		try {
			vehiclespacesoldpictureService = new VehiclespacesoldpictureServiceImpl();
			setVehiclespacesoldpicturemap(vehiclespacesoldpictureService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			vehiclespacesoldpictureService = new VehiclespacesoldpictureServiceImpl();
			if (vehiclespacesoldpicture != null) {
				vehiclespacesoldpicture.setSoldpicture(ConversionUtil
						.toByteArr(picture));
				if (vehiclespacesoldpicture.getId() > 0) {
					vehiclespacesoldpicture.setIsactive(true);
					vehiclespacesoldpicture.setUpdateby(global.getUserinfo().getId());
					vehiclespacesoldpicture.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "修改成功！";
					markSuccess();
					Vehiclespacesoldpicture picture = vehiclespacesoldpictureService
							.getById(vehiclespacesoldpicture.getId());
					if (picture.getTicktypeid() != vehiclespacesoldpicture
							.getTicktypeid()
							|| picture.getVehiclespaceid() != vehiclespacesoldpicture
									.getVehiclespaceid()) {
						if (vehiclespacesoldpictureService.isExist(
								vehiclespacesoldpicture.getVehiclespaceid(),
								vehiclespacesoldpicture.getTicktypeid())) {
							msg = "对不起，你输入的车辆内部空间与票种已经存在！";
							markFail();
							return "json";
						}
					}
				} else {
					msg = "添加成功！";
					markSuccess();
					vehiclespacesoldpicture.setIsactive(true);
					vehiclespacesoldpicture.setIslocaldelete(false);
					vehiclespacesoldpicture.setCreateby(global.getUserinfo().getId());
					vehiclespacesoldpicture.setUpdateby(global.getUserinfo().getId());
					vehiclespacesoldpicture.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					vehiclespacesoldpicture.setCreatetime(new Timestamp(System
							.currentTimeMillis()));

					if (vehiclespacesoldpictureService.isExist(
							vehiclespacesoldpicture.getVehiclespaceid(),
							vehiclespacesoldpicture.getTicktypeid())) {
						Long id = vehiclespacesoldpictureService.getId(
								vehiclespacesoldpicture.getVehiclespaceid(),
								vehiclespacesoldpicture.getTicktypeid());
						if (id > 0) {
							Vehiclespacesoldpicture vehiclespace = vehiclespacesoldpictureService
									.getById(id);
							vehiclespacesoldpicture.setId(vehiclespace.getId());
							vehiclespacesoldpicture.setIsactive(true);
							vehiclespacesoldpicture.setTicktypeid(vehiclespace
									.getTicktypeid());
							vehiclespacesoldpicture
									.setVehiclespaceid(vehiclespace
											.getVehiclespaceid());
						} else {
							msg = "对不起，你输入的车辆内部空间与票种已经存在！";
							markFail();
							return "json";
						}
					}

				}
				vehiclespacesoldpicture = vehiclespacesoldpictureService
						.save(vehiclespacesoldpicture);
				setId(vehiclespacesoldpicture.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			vehiclespacesoldpictureService = new VehiclespacesoldpictureServiceImpl();
			if (vehiclespacesoldpicture != null) {
				Vehiclespacesoldpicture picture = vehiclespacesoldpictureService
						.getById(vehiclespacesoldpicture.getId());
				picture.setIsactive(false);
				picture.setIslocaldelete(false);
				picture.setUpdateby(global.getUserinfo().getId());
				picture.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				msg = "删除成功！";
				markSuccess();
				vehiclespacesoldpictureService.save(picture);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Vehiclespacesoldpicture getVehiclespacesoldpicture() {
		return vehiclespacesoldpicture;
	}

	public void setVehiclespacesoldpicture(
			Vehiclespacesoldpicture vehiclespacesoldpicture) {
		this.vehiclespacesoldpicture = vehiclespacesoldpicture;
	}

	public List<Vehiclespacesoldpicture> getVehiclespacesoldpicturelist() {
		return vehiclespacesoldpicturelist;
	}

	public void setVehiclespacesoldpicturelist(
			List<Vehiclespacesoldpicture> vehiclespacesoldpicturelist) {
		this.vehiclespacesoldpicturelist = vehiclespacesoldpicturelist;
	}

	public List<Map<String, Object>> getVehiclespacesoldpicturemap() {
		return vehiclespacesoldpicturemap;
	}

	public void setVehiclespacesoldpicturemap(
			List<Map<String, Object>> vehiclespacesoldpicturemap) {
		this.vehiclespacesoldpicturemap = vehiclespacesoldpicturemap;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
