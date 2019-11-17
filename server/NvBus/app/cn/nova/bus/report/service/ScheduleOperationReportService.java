/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service<br/>
 * <b>文件名：</b>ScheduleOperationReportService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-20 上午10:31:49<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleOperationReportService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-20 上午10:31:49<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface ScheduleOperationReportService {

	/**
	 * 班线运营情况汇总表
	 * @param orgids
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	List<Map<String, Object>> queryScheduleOperation(String orgids,
			Date startdate, Date enddate, Long routeid);

}
