/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Vehicleturnover;
import cn.nova.bus.balance.service.VehicleturnoverService;
import cn.nova.bus.balance.service.impl.VehicleturnoverServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleturnoverAction extends BaseAction{

	private Vehicleturnover vehicleturnover;
	private Long id;
	private List<Vehicleturnover> overlist;
	private List<Map<String, Object>> overmap;

	private VehicleturnoverService overService;

	public String query() {
		try {
			overService = new VehicleturnoverServiceImpl();
			setOvermap(overService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		overService = new VehicleturnoverServiceImpl();
		try {
			if (vehicleturnover != null) {
				if (vehicleturnover.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					vehicleturnover.setUpdateby(global.getUserinfo().getId());
					vehicleturnover.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					vehicleturnover.setCreateby(global.getUserinfo().getId());
					vehicleturnover.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					vehicleturnover.setUpdateby(global.getUserinfo().getId());
					vehicleturnover.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					vehicleturnover.setReceiptorgid(global.getOrganization().getId());
					vehicleturnover.setReceiptip(global.getIpAddress());
					vehicleturnover.setReceiver(global.getUserinfo().getId());
					//vehicleturnover.setBalanceid((long) 0);
					vehicleturnover.setTurnovertime(new Timestamp(System
							.currentTimeMillis()));
					vehicleturnover.setIsbalance(false);
					if (overService.vehicleidUnique(vehicleturnover
							.getVehicleid())) {
						msg = "该车牌号已经添加预交款！";
						markFail();
						return "json";
					}
				}
				vehicleturnover = overService.save(vehicleturnover);
				setId(vehicleturnover.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		overService = new VehicleturnoverServiceImpl();
		if (vehicleturnover != null) {
			try {
				boolean result = overService.delete(vehicleturnover.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:";
				markFail();
			}
		}
		return "json";
	}

	public Vehicleturnover getVehicleturnover() {
		return vehicleturnover;
	}

	public void setVehicleturnover(Vehicleturnover vehicleturnover) {
		this.vehicleturnover = vehicleturnover;
	}

	public List<Vehicleturnover> getOverlist() {
		return overlist;
	}

	public void setOverlist(List<Vehicleturnover> overlist) {
		this.overlist = overlist;
	}

	public List<Map<String, Object>> getOvermap() {
		return overmap;
	}

	public void setOvermap(List<Map<String, Object>> overmap) {
		this.overmap = overmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
