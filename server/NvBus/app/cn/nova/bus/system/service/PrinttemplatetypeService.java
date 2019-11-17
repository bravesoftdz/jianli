/**
 * 打印模板类型服务
 */
package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public interface PrinttemplatetypeService {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);
	public List<Map<String,Object>> queryItem(List<PropertyFilter> propertyFilters);
	public List<Map<String,Object>> queryItemAddDefault(long printtemplatetypeid);
	public Printtemplatetype add(Printtemplatetype printtemplatetype) throws ServiceException;
	public Printtemplatetype udpate(Printtemplatetype printtemplatetype) throws ServiceException;
	public boolean delete(Printtemplatetype printtemplatetype) throws ServiceException;
	public Printtemplatetypeitem addItem(Printtemplatetypeitem printtemplatetypeitem) throws ServiceException;
	public Printtemplatetypeitem udpateItem(Printtemplatetypeitem printtemplatetypeitem) throws ServiceException;
	public boolean deleteItem(Printtemplatetypeitem printtemplatetypeitem) throws ServiceException;
}
