package cn.nova.bus.hirebus.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.hirebus.model.Hirebus;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface HirebusService {
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);
	public Hirebus saveHirebus(Hirebus hirebus,Global global) throws ServiceException;
	/**
	 * 作废
	 * @param hirebus
	 * @return
	 * @throws ServiceException
	 */
	public boolean wastePack(Hirebus hirebus) throws ServiceException; 
	
	/**
	 * 重打受理单时新添加一条记录同时把重打的数据改为废弃状态
	 * @param hirebus
	 * @return
	 * @throws ServiceException
	 */
	public Hirebus whackhirebus(Hirebus hirebus)throws ServiceException;
}
