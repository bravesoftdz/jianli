package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Functionreg;
import cn.nova.utils.orm.PropertyFilter;

public interface FunctionregService {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);
	public Functionreg add(Functionreg functionreg) throws ServiceException;
	public Functionreg update(Functionreg functionreg) throws ServiceException;
	public boolean delete(Functionreg functionreg) throws ServiceException;
	public List<Map<String,Object>> qryFuncByKey(String key);
}
