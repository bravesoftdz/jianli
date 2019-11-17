package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface TicketTurnOverReportService {

	public Map<String,Object> queryTicketErrorReport(
			List<PropertyFilter> propertyFilter,int querytype);

	public List<Map<String, Object>> qryticketusedetail(String orgids, Date departdate, Date enddate, String tickettype,
			String ticketusetype);

}
