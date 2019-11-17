package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface QuerySellBalanceSummaryService {
	/*
	 * 售票点结算汇总表Service
	 */
	public List<Map<String, Object>> query(String printorgids,String sellorgids,
			Date startdate,Date enddate,Long routeid,Long scheduleid,Long vehicleid);

}
