package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.District;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface DistrictService {

	public District save(District district) throws ServiceException;
	
	public boolean delete(Long id);
	
	public List<District> query();
	
	public boolean delete(District district);
	
	public District getById(Long id);
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
	public boolean isContainSta(Long id);
	
}
