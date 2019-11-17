package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Holiday;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface HolidayService {
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	public Holiday save(Holiday holiday) throws ServiceException ;
	public boolean delete(long id,long updateby);
	public List<Map<String, Object>> importholidayprice();
	public MethodResult updateHolidayPrices(Holiday holiday);
}
