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
import cn.nova.bus.base.model.Schedulediscount;
import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.bus.base.service.SchedulediscountService;
import cn.nova.bus.base.service.impl.SchedulediscountServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class SchedulediscountAction extends BaseAction{

	private Schedulediscount schedulediscount;
	private Schedulevipdiscount schedulevipdiscount;
	private Long id;
	private List<Map<String, Object>> schmap;
	private List<Map<String, Object>> vipmap;

	private List<Schedulevipdiscount> schedulevipdiscounts;

	private String scheduleid;

	private SchedulediscountService scheduleService;

	public String query() {
		try {
			scheduleService = new SchedulediscountServiceImpl();
			setSchmap(scheduleService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryvipdiscount() {
		try {
			scheduleService = new SchedulediscountServiceImpl();
			setVipmap(scheduleService.queryvipdiscount(
					ServletPropertyFilterUtil.buildFromHttpRequest(), schedulediscount.getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		scheduleService = new SchedulediscountServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (schedulediscount != null) {
				if (schedulediscount.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					schedulediscount.setUpdateby(global.getUserinfo().getId());
					schedulediscount.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					schedulediscount.setCreateby(global.getUserinfo().getId());
					schedulediscount.setOrgid(global.getOrganization().getId());
					schedulediscount.setUpdateby(global.getUserinfo().getId());
					schedulediscount.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					schedulediscount.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				schedulediscount = scheduleService.save(schedulediscount,
						schedulevipdiscounts, scheduleid, global.getIpAddress());
				setId(schedulediscount.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作异常：" + e.getMessage();
			markFail();
		}
		return "json";
	}

	public String delete() {
		if (schedulediscount != null) {
			try {
				scheduleService = new SchedulediscountServiceImpl();
				boolean result = scheduleService.delete(schedulediscount
						.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "对不起，已找到子记录，所以不能删除！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:" + ex.getMessage();
				markFail();
			}

		}
		return "json";
	}

	public Schedulediscount getSchedulediscount() {
		return schedulediscount;
	}

	public void setSchedulediscount(Schedulediscount schedule) {
		this.schedulediscount = schedule;
	}

	public List<Map<String, Object>> getSchmap() {
		return schmap;
	}

	public void setSchmap(List<Map<String, Object>> schmap) {
		this.schmap = schmap;
	}

	public Schedulevipdiscount getSchedulevipdiscount() {
		return schedulevipdiscount;
	}

	public void setSchedulevipdiscount(Schedulevipdiscount schedulevipdiscount) {
		this.schedulevipdiscount = schedulevipdiscount;
	}

	public String getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(String scheduleid) {
		this.scheduleid = scheduleid;
	}

	public List<Map<String, Object>> getVipmap() {
		return vipmap;
	}

	public void setVipmap(List<Map<String, Object>> vipmap) {
		this.vipmap = vipmap;
	}

	public List<Schedulevipdiscount> getSchedulevipdiscounts() {
		return schedulevipdiscounts;
	}

	public void setSchedulevipdiscounts(
			List<Schedulevipdiscount> schedulevipdiscounts) {
		this.schedulevipdiscounts = schedulevipdiscounts;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
