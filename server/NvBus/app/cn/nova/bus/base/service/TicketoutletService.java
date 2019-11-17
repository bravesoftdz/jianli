package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketoutletService {

	public Ticketoutlets save(Ticketoutlets ticketoutlet) throws ServiceException;

	public Ticketoutlets findById(Long id);
	
	public Ticketoutlets findByCode(String code);

	public boolean delete(Long id);

	public List<Ticketoutlets> findList(Map<String, Object> where);

	public List<Ticketoutlets> query(String sql);

	public List<Map<String, Object>> query(Object[] fileds, String sql);

	public List<Map<String, Object>> query(Object[] fileds, String sql,
			Object[] filedtype);

	public List<Map<String, Object>> query(List<PropertyFilter> buildFromHttpRequest);

}
