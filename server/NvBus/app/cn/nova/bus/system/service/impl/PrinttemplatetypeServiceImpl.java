/**
 * 
 */
package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Printtemplate;
import cn.nova.bus.system.model.Printtemplateitem;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.bus.system.service.PrinttemplatetypeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */

public class PrinttemplatetypeServiceImpl implements PrinttemplatetypeService {

	private IDAO dao = new EntityManagerDaoSurport();	
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		if(propertyFilters==null){
			propertyFilters = new ArrayList<PropertyFilter>();
		}
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", new Long(-1)));
		return ListUtil.listToMap(new Object[]{Printtemplatetype.class}, 
				dao.query(Printtemplatetype.class, propertyFilters), 
				new Object[]{Printtemplatetype.class})	;
	}

	@Override
	public List<Map<String, Object>> queryItem(
			List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[]{Printtemplatetypeitem.class}, 
				dao.query(Printtemplatetypeitem.class, propertyFilters), 
				new Object[]{Printtemplatetypeitem.class})	;
	}

	@Override
	public Printtemplatetype add(Printtemplatetype printtemplatetype) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!name", printtemplatetype.getName()));
		List<Printtemplatetype> printtemplatetypes = dao.query(Printtemplatetype.class, propertyFilters);
		if(printtemplatetypes!=null && printtemplatetypes.size()>0){
			throw new ServiceException("0020");
		}
		return (Printtemplatetype) dao.merge(printtemplatetype);
	}

	@Override
	public Printtemplatetype udpate(Printtemplatetype printtemplatetype) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!name", printtemplatetype.getName()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", (new Long(printtemplatetype.getId())).toString()));
		List<Printtemplatetype> printtemplatetypes = dao.query(Printtemplatetype.class, propertyFilters);
		if(printtemplatetypes!=null && printtemplatetypes.size()>0){
			throw new ServiceException("0020");
		}
		return (Printtemplatetype) dao.merge(printtemplatetype);
	}

	@Override
	public boolean delete(Printtemplatetype printtemplatetype) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!printtemplatetypeid", printtemplatetype.getId()));
		List<Printtemplate> printtemplates = dao.query(Printtemplate.class, propertyFilters);
		if(printtemplates!=null && printtemplates.size()>0){
			throw new ServiceException("0023");
		}
		return dao.del(printtemplatetype);
	}

	@Override
	public Printtemplatetypeitem addItem(
			Printtemplatetypeitem printtemplatetypeitem) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!itemname", printtemplatetypeitem.getItemname()));
		propertyFilters.add(new PropertyFilter("EQO_t!printtemplatetype", printtemplatetypeitem.getPrinttemplatetype()));
		List<Printtemplatetypeitem> printtemplatetypeitems = dao.query(Printtemplatetypeitem.class, propertyFilters);
		if(printtemplatetypeitems!=null && printtemplatetypeitems.size()>0){
			throw new ServiceException("0021");
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!itemcode", printtemplatetypeitem.getItemcode()));
		propertyFilters.add(new PropertyFilter("EQO_t!printtemplatetype", printtemplatetypeitem.getPrinttemplatetype()));
		propertyFilters.add(new PropertyFilter("EQB_t!islist", new Boolean(printtemplatetypeitem.getIslist()).toString()));
		printtemplatetypeitems = dao.query(Printtemplatetypeitem.class, propertyFilters);
		if(printtemplatetypeitems!=null && printtemplatetypeitems.size()>0){
			throw new ServiceException("0022");
		}
		return (Printtemplatetypeitem) dao.merge(printtemplatetypeitem);
	}

	@Override
	public Printtemplatetypeitem udpateItem(
			Printtemplatetypeitem printtemplatetypeitem) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!itemname", printtemplatetypeitem.getItemname()));
		propertyFilters.add(new PropertyFilter("EQO_t!printtemplatetype", printtemplatetypeitem.getPrinttemplatetype()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", (new Long(printtemplatetypeitem.getId())).toString()));
		List<Printtemplatetypeitem> printtemplatetypeitems = dao.query(Printtemplatetypeitem.class, propertyFilters);
		if(printtemplatetypeitems!=null && printtemplatetypeitems.size()>0){
			throw new ServiceException("0021");
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!itemcode", printtemplatetypeitem.getItemcode()));
		propertyFilters.add(new PropertyFilter("EQO_t!printtemplatetype", printtemplatetypeitem.getPrinttemplatetype()));
		propertyFilters.add(new PropertyFilter("EQB_t!islist", new Boolean(printtemplatetypeitem.getIslist()).toString()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", (new Long(printtemplatetypeitem.getId())).toString()));
		printtemplatetypeitems = dao.query(Printtemplatetypeitem.class, propertyFilters);
		if(printtemplatetypeitems!=null && printtemplatetypeitems.size()>0){
			throw new ServiceException("0022");
		}
		return (Printtemplatetypeitem) dao.merge(printtemplatetypeitem);
	}

	@Override
	public boolean deleteItem(
			Printtemplatetypeitem printtemplatetypeitem) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQO_t!printtemplatetypeitem", printtemplatetypeitem));
		List<Printtemplateitem> printtemplateitems = dao.query(Printtemplateitem.class, propertyFilters);
		if(printtemplateitems!=null && printtemplateitems.size()>0){
			throw new ServiceException("0024");
		}
		return dao.del(printtemplatetypeitem);
	}

	@Override
	public List<Map<String, Object>> queryItemAddDefault(
			long printtemplatetypeid) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!printtemplatetype.id", printtemplatetypeid));
		List<Object> printtemplatetypeitems = dao.query(Printtemplatetypeitem.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!printtemplatetype.id", new Long(-1)));
		printtemplatetypeitems.addAll(dao.query(Printtemplatetypeitem.class, propertyFilters));
		return ListUtil.listToMap(new Object[]{Printtemplatetypeitem.class}, 
				printtemplatetypeitems, 
				new Object[]{Printtemplatetypeitem.class})	;
	}

}
