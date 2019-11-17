package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.utils.orm.PropertyFilter;

public interface PackfeeService {
	
	/**根据条件查询收费标准设置
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);
	public List<Map<String, Object>> query();
	public Packfee savePackfee(Packfee packfee) throws ServiceException;
	public boolean deletePackfee(Packfee packfee,long userid) throws ServiceException; 
	
}
