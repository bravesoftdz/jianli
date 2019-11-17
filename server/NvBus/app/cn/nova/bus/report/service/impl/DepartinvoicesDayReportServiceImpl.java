/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>DepartinvoicesDayReportServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-8-31 上午11:38:40<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.DepartinvoicesDayReportDao;
import cn.nova.bus.report.service.DepartinvoicesDayReportService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DepartinvoicesDayReportServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-8-31 上午11:38:40<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class DepartinvoicesDayReportServiceImpl implements
		DepartinvoicesDayReportService {
	private DepartinvoicesDayReportDao depDayReportDao = new DepartinvoicesDayReportDao();
	/*
	 * (non-Javadoc)
	 * 发往各省、地客运量日统计表
	 * @see
	 * cn.nova.bus.report.service.DepartinvoicesDayReportService#queryDepDayReport
	 * (java.util.Date, java.util.Date, java.lang.String)
	 */
	@Override
	public List<Map<String, Object>> queryDepDayReport(Date startdate,
			Date enddate, String orgid,boolean isbytime) {
		depDayReportDao = new DepartinvoicesDayReportDao();
		return ListUtil.listToMap(new Object[] { "name", "stationname","starttime",
				"vehiclenum", "schedulenum", "ticketnum", "overschedulenum","allschedulenum",
				"overticketnum"
				,"moneypayable","peopledistance","rate","needpeopledistance" },
				depDayReportDao.queryDepDayReport(startdate, enddate, orgid,isbytime),
				new Object[] { String.class, String.class,  String.class, Long.class,
						Long.class, Long.class, Long.class, Long.class, Long.class
						,BigDecimal.class,Long.class,String.class,Long.class});
	}

}
