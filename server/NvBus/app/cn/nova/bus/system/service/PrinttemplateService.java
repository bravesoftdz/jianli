/**
 * 
 */
package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Printtemplate;
import cn.nova.bus.system.model.Printtemplateitem;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public interface PrinttemplateService {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);
	public List<Map<String,Object>> queryItem(List<PropertyFilter> propertyFilters);
	public Printtemplate add(Printtemplate printtemplate,boolean autoGenerateItem,long userid) throws ServiceException;
	public Printtemplate udpate(Printtemplate printtemplate,long userid) throws ServiceException;
	public boolean delete(Printtemplate printtemplate,long userid);
	//批量保存
	public boolean saveItems(List<Printtemplateitem> printtemplateitems,long userid) throws ServiceException;
	//删除不可见的打印项目
	public boolean deleteInVisibleItem(Printtemplate printtemplate,long userid);
	//打印模板复制
	public Printtemplate copyPrinttemplate(Printtemplate printtemplate, Global global) throws ServiceException;

}
