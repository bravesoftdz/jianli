package cn.nova.bus.balance.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface TicketFundsCheckService {
	
	/**
	 * 查询票款对付表信息
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String,Object>> query(String vehicleno,Date balanceStartdate,Date balanceEnddate);

}
