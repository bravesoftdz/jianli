package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Initcard;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface InitcardService {
	public Initcard save(Initcard initcard, Long endcardno, String ip) throws ServiceException;

	public boolean delete(Initcard initcard);

	public boolean delete(Long id);

	public List<Initcard> query();

	public Initcard getById(Long id);

	public boolean isExist(String serialnumber);
	
	public boolean isExist(String cardno, String cardtype);
	
	public Long findId(String serialnumber);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
}
