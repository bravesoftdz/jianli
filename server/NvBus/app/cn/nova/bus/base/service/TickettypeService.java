package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
/**
 * @author lck
 * 
 */
public interface TickettypeService {
	public Tickettype save(Tickettype tickettype) throws ServiceException;
	public boolean delete(Long id);
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) ;
	public boolean prior(Tickettype tickettype) throws ServiceException;
	public boolean next(Tickettype tickettype) throws ServiceException;
	
	//取可售票种
	public List<Tickettype> findByPermission(long userid,long ticketoutletsid);
	public List<Map<String,Object>> find(List<PropertyFilter> propertyFilters);
	
	public String qryTicketname(String code) throws ServiceException;
	
	public byte[] getImage();

}
