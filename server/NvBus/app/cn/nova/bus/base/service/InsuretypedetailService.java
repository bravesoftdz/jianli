package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface InsuretypedetailService {

	public Insuretypedetail save(Insuretypedetail detail) throws ServiceException;

	public boolean delete(Insuretypedetail detail);

	public boolean delete(Long id) throws ServiceException;

	public List<Insuretypedetail> query();

	public Insuretypedetail getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Long getInsuretypeid();
	
	public Long getId(Long id);

	public Insuretypedetail getInsuretypedetail(Insuretype insuretype);

	public List<Insuretypedetail> getResult(Long id);

}
