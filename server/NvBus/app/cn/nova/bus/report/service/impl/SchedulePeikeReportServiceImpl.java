package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.SchedulePeikeReportDao;
import cn.nova.bus.report.service.SchedulePeikeReportService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class SchedulePeikeReportServiceImpl implements
		SchedulePeikeReportService {

	private SchedulePeikeReportDao dao = new  SchedulePeikeReportDao();
	@Override
	public List<Map<String, Object>> qrySchedulePeike(
			List<PropertyFilter> propertyFilterList,Date oldstartdepartdate,String schedulecode) {
		// TODO Auto-generated method stub
		return ListUtil.listToMap(new Object[]{"seatno","reachstation","oldschedulecode","oldseatno","seatno2","reachstation2","oldschedulecode2","oldseatno2"}, 
				dao.qrySchedulePeike(propertyFilterList, oldstartdepartdate, schedulecode),
				new Object[]{Short.class,String.class,String.class,Short.class,Short.class,String.class,String.class,Short.class});
	}
	@Override
	public List<Map<String, Object>> qryTicketoutcodeSellticket(
			List<PropertyFilter> propertyFilterList, Date oldstartdepartdate,
			String schedulecode) {
		// TODO Auto-generated method stub
		return ListUtil.listToMap(new Object[]{"ticketoutcode","countticket"}, 
				dao.qryTicketoutcodeSellticket(propertyFilterList, oldstartdepartdate, schedulecode),
				new Object[]{String.class,Short.class});
	}
	

}
