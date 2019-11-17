package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface SchedulePeikeReportService {
	/**
	 * 班次配客情况表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> qrySchedulePeike(List<PropertyFilter> propertyFilterList,Date oldstartdepartdate,String schedulecode);
	public List<Map<String, Object>> qryTicketoutcodeSellticket(List<PropertyFilter> propertyFilterList,Date oldstartdepartdate,String schedulecode);
}
