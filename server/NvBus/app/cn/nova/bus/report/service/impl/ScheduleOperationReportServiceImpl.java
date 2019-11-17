/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>ScheduleOperationReportServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-20 上午10:33:52<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.ScheduleOperationReportDao;
import cn.nova.bus.report.service.ScheduleOperationReportService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleOperationReportServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-20 上午10:33:52<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class ScheduleOperationReportServiceImpl implements
		ScheduleOperationReportService {

	private ScheduleOperationReportDao dao = new ScheduleOperationReportDao();

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.report.service.ScheduleOperationReportService#
	 * queryScheduleOperation(java.lang.String, java.util.Date, java.util.Date)
	 */
	@Override
	public List<Map<String, Object>> queryScheduleOperation(String orgids,
			Date startdate, Date enddate, Long routeid) {
		dao = new ScheduleOperationReportDao();
		return ListUtil.listToMap(new Object[] { "name", "planschedule","stopschedule","lateschedule",
				"departed","routedistance", "overtime",  
				"ticketnum", "totalamount", "peopledistance", "seatnum",
				"ratedistance", "rateschedule", "ratelateschedule" }, dao
				.queryScheduleOperationReport(orgids, startdate, enddate,
						routeid), new Object[] { String.class, Long.class,
				Long.class, Long.class,Long.class, Long.class, Long.class, Long.class,
				BigDecimal.class, BigDecimal.class, Long.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class });
	}

}
