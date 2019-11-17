package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Tickettypepermission;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface TickettypepermissionService {
	
	public Tickettypepermission save(Tickettypepermission tickettypepermission) throws ServiceException;

	public boolean delete(Long id );
	
	public boolean delete(Tickettypepermission tickettypepermission);
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);

	public Tickettypepermission getById(Long id);
	
}
