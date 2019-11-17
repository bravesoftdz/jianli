package cn.nova.bus.sale.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface TicketStaticsQryService {

	/**
	 * 查询车票营收统计
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> query(int sellticketunit,Date beginselltime,Date endselltime);
	
}
