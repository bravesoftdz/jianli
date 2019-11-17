package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Functionpermissionreg;
import cn.nova.utils.orm.PropertyFilter;

public interface FunctionpermissionregService {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);
	public Functionpermissionreg add(Functionpermissionreg functionpermissionreg) throws ServiceException;
	public Functionpermissionreg update(Functionpermissionreg functionpermissionreg) throws ServiceException;
	public boolean delete(Functionpermissionreg functionpermissionreg);
}
