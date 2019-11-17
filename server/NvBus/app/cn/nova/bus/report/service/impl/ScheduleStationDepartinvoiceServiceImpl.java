/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.price.service.impl<br/>
 * <b>文件名：</b>ScheduleStationDepartinvoicesServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-29 下午01:44:24 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.ScheduleStationDepartinvoiceDao;
import cn.nova.bus.report.service.ScheduleStationDepartinvoiceService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：班线和停靠点运量汇总表</b><br/>
 * <b>类名称：</b>ScheduleStationDepartinvoicesServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-29 下午01:44:24 <br/>
 * <b>关键修改：添加线路查询条件</b><br/>
 * <b>修改时间：20120629</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public class ScheduleStationDepartinvoiceServiceImpl implements
		ScheduleStationDepartinvoiceService {

	private ScheduleStationDepartinvoiceDao scheduleStationDepDao = new ScheduleStationDepartinvoiceDao();

	@Override
	public List<Map<String, Object>> query(String orgid, Date startdate,
			Date enddate, Long routeid,Long scheduleid) {
		scheduleStationDepDao = new ScheduleStationDepartinvoiceDao();
		String schedulecode="";
		if(scheduleid!=null && scheduleid>0){
			schedulecode=scheduleStationDepDao.queryScheduleCode(scheduleid);
		}
		return ListUtil
				.listToMap(new Object[] { "name","unitname", "reachename",
						"ticketnum", "rate1", "totalamount", "rate2",
						"peopledistance", "rate3" }, scheduleStationDepDao
						.query(orgid, startdate, enddate, routeid,schedulecode),
						new Object[] {String.class,String.class,
								String.class, String.class, String.class,
								BigDecimal.class, String.class, String.class,
								String.class });
	}

}
