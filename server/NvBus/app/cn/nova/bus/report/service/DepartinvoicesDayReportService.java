/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service<br/>
 * <b>文件名：</b>DepartinvoicesDayReportService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-8-31 上午11:35:24<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DepartinvoicesDayReportService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-8-31 上午11:35:24<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface DepartinvoicesDayReportService {

	/**
	 * 发往各省、地客运量日统计表
	 * @param startdate
	 * @param enddate
	 * @param orgid
	 * @return
	 */
	List<Map<String, Object>> queryDepDayReport(Date startdate, Date enddate,
			String orgid,boolean isbytime);

}
