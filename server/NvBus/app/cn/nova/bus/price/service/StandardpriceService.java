package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface StandardpriceService {
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
	public List<Map<String, Object>> qryStandardPriceItem(List<PropertyFilter> propertyFilterList);
	
	public boolean genPrice(Long scheduleid,Long createby) throws ServiceException;
}
