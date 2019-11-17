package cn.nova.bus.check.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.check.model.Securitycheckitem;
import cn.nova.utils.orm.PropertyFilter;

public interface SecuritycheckitemService {

	public Securitycheckitem save(Securitycheckitem security);

	public boolean delete(Long id);

	public List<Securitycheckitem> query();

	public boolean delete(Securitycheckitem security);

	public Securitycheckitem getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
	public boolean isUniqe(String name, String categorycode);
	
	public Long getId(String name, String categorycode);

	public List<Map<String, Object>> qrySecuritycheckfeeReport(
			List<PropertyFilter> propertyFilterList);
	
}
