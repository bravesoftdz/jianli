/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.system.action<br/>
 * <b>文件名：</b>ScheduleplanlogAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-3-8 上午09:29:51<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.service.ScheduleplanlogService;
import cn.nova.bus.system.service.impl.ScheduleplanlogServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplanlogAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-3-8 上午09:29:52<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class ScheduleplanlogAction extends BaseAction{

	public List<Map<String, Object>> planlogMap;
	public String type;

	public String queryScheduleplanlog() {
		try {
			ScheduleplanlogService planlogService = new ScheduleplanlogServiceImpl();
			setPlanlogMap(planlogService.queryScheduleplanlog(
					ServletPropertyFilterUtil.buildFromHttpRequest(), type));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getPlanlogMap() {
		return planlogMap;
	}

	public void setPlanlogMap(List<Map<String, Object>> planlogMap) {
		this.planlogMap = planlogMap;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
