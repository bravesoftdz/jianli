/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 * 班次查询返回结果类
 */
public class ParamFindSchedulesOut extends MethodResult {
	
	private static final long serialVersionUID = -8196634536719145579L;
	private List<ParamDepartSchedule> departSchedules;

	public List<ParamDepartSchedule> getDepartSchedules() {
		return departSchedules;
	}

	public void setDepartSchedules(List<ParamDepartSchedule> departSchedules) {
		this.departSchedules = departSchedules;
	}
	
}
