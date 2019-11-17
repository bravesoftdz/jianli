package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.dispatch.model.Schedulemergecancel;
import cn.nova.bus.dispatch.service.SchedulemergecancelService;
import cn.nova.bus.dispatch.service.impl.SchedulemergecancelServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SchedulemergecancelAction extends BaseAction{
	private Schedulemergecancel schedulemergecancel;
	private List<Map<String, Object>> mergecancelmap;
	private Long oldscheduleplanid;

	private SchedulemergecancelService schedulemergecancelService;

	public String query() {
		try {
			schedulemergecancelService = new SchedulemergecancelServiceImpl();
			setMergecancelmap(schedulemergecancelService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			schedulemergecancelService = new SchedulemergecancelServiceImpl();
			if (schedulemergecancel != null) {
				if (schedulemergecancelService.isExist(schedulemergecancel
						.getSchedulemergeid())) {
					schedulemergecancel.setCreateby(global.getUserinfo().getId());
					schedulemergecancel.setCreatetime(new Date());
					schedulemergecancel.setCanceluserid(global.getUserinfo().getId());
					markSuccess();
					setMsg("操作成功");
				}
				if (!schedulemergecancelService.save(schedulemergecancel, oldscheduleplanid)) {
					markSuccess();
					setMsg("保存操作失败！");
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("操作异常:" + e.getMessage());
		}
		return "json";
	}

	public Schedulemergecancel getSchedulemergecancel() {
		return schedulemergecancel;
	}

	public void setSchedulemergecancel(Schedulemergecancel schedulemergecancel) {
		this.schedulemergecancel = schedulemergecancel;
	}

	public List<Map<String, Object>> getMergecancelmap() {
		return mergecancelmap;
	}

	public void setMergecancelmap(List<Map<String, Object>> mergecancelmap) {
		this.mergecancelmap = mergecancelmap;
	}

	public Long getOldscheduleplanid() {
		return oldscheduleplanid;
	}

	public void setOldscheduleplanid(Long oldscheduleplanid) {
		this.oldscheduleplanid = oldscheduleplanid;
	}

}
