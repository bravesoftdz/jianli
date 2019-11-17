package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <p>
 * Title: 票价公式组成项信息服务接口
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public interface TicketpriceformulaitemService {
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Ticketpriceformulaitem save(
			Ticketpriceformulaitem ticketpriceformulaitem)
			throws ServiceException;

	public boolean delete(long id, long userid) throws ServiceException;

	// 根据名称获取相应票价组成项的值
	/*public BigDecimal getFormulaitemfee(BigDecimal fullprice, long orgid,
			long scheduleid, long departstationid, long reachstationid,
			int distance, String formulaname);*/

}
