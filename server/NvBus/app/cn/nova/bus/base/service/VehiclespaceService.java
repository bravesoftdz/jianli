/**
 * 
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public interface VehiclespaceService {
	public List<Map<String,Object>> find(List<PropertyFilter> propertyFilters);
	public Vehiclespace add(Vehiclespace vehiclespace,long userid) throws ServiceException;
	public Vehiclespace update(Vehiclespace vehiclespace,long userid) throws ServiceException;
	public boolean delete(Vehiclespace vehiclespace,long userid) throws ServiceException;
}
