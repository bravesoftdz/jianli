package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface VehicletypeService {

	public MethodResult save(Vehicletype vehicle) throws ServiceException;

	public boolean delete(Vehicletype vehicle);

	public boolean delete(Long id);

	public List<Vehicletype> query();

	public Vehicletype getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
	// 查询该车辆类型是否已经被使用
	public boolean isApply(long id);
	
}
