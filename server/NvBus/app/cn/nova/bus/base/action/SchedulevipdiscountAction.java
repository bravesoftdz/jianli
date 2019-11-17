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
import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.bus.base.service.SchedulevipdiscountService;
import cn.nova.bus.base.service.impl.SchedulevipdiscountServiceImpl;
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
public class SchedulevipdiscountAction extends BaseAction{

	private Schedulevipdiscount schedulevipdiscount;
	private List<Map<String, Object>> vipdiscountmap;
	private Long id;

	private SchedulevipdiscountService vipdiscountService;

	public String query() {
		try {
			vipdiscountService = new SchedulevipdiscountServiceImpl();
			setVipdiscountmap(vipdiscountService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		vipdiscountService = new SchedulevipdiscountServiceImpl();
		try {
			if (schedulevipdiscount != null) {

				if (schedulevipdiscount.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					schedulevipdiscount.setUpdateby(global.getUserinfo().getId());
					schedulevipdiscount.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					Schedulevipdiscount discount = vipdiscountService
							.getByid(schedulevipdiscount.getId());
					if (!discount.getVipgrade().equals(
							schedulevipdiscount.getVipgrade())) {
						if (vipdiscountService.isExist(
								schedulevipdiscount.getSchedulediscountid(),
								schedulevipdiscount.getVipgrade())) {
							msg = "对不起，该班次已经有了对应的VIP等级、";
							markFail();
							return "json";
						}
					}
				} else {
					msg = "添加成功！";
					markSuccess();
					schedulevipdiscount.setCreateby(global.getUserinfo().getId());
					schedulevipdiscount.setUpdateby(global.getUserinfo().getId());
					schedulevipdiscount.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					schedulevipdiscount.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					if (vipdiscountService.isExist(
							schedulevipdiscount.getSchedulediscountid(),
							schedulevipdiscount.getVipgrade())) {
						msg = "对不起，该班次已经有了对应的VIP等级、";
						markFail();
						return "json";
					}
				}
				schedulevipdiscount = vipdiscountService.save(schedulevipdiscount);
				setId(schedulevipdiscount.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作异常:" + e.getMessage();
			markFail();
		}
		return "json";
	}

	public String delete() {
		if (schedulevipdiscount != null) {
			try {
				vipdiscountService = new SchedulevipdiscountServiceImpl();
				boolean result = vipdiscountService.delete(schedulevipdiscount
						.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除异常:" + ex.getMessage();
				markFail();
			}

		}
		return "json";
	}

	public Schedulevipdiscount getSchedulevipdiscount() {
		return schedulevipdiscount;
	}

	public void setSchedulevipdiscount(Schedulevipdiscount schedulevipdiscount) {
		this.schedulevipdiscount = schedulevipdiscount;
	}

	public List<Map<String, Object>> getVipdiscountmap() {
		return vipdiscountmap;
	}

	public void setVipdiscountmap(List<Map<String, Object>> vipdiscountmap) {
		this.vipdiscountmap = vipdiscountmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
