/**
 * 
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public interface VehiclebrandmodelService {
	public List<Map<String,Object>> find(List<PropertyFilter> propertyFilterList);
	public Vehiclebrandmodel add(Vehiclebrandmodel vehiclebrandmodel,long userid) throws ServiceException;
	public Vehiclebrandmodel update(Vehiclebrandmodel vehiclebrandmodel,long userid) throws ServiceException;
	public boolean isUsed(Vehiclebrandmodel vehiclebrandmodel) throws ServiceException;
	public boolean delete(long id,long userid) throws ServiceException;

}
