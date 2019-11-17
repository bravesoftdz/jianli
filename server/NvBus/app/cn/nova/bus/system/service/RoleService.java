package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Role;
import cn.nova.utils.orm.PropertyFilter;

public interface RoleService {
	public Role save(Role role) throws ServiceException;

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	// public List<Role> findList();
	// public Role findById(Long id);
	public boolean delete(Role role) throws ServiceException;

	// public List<Role> findList(Map<String,Object> where) ;
	public List<Role> query(long userid);
	public List<Role> querybyid(long id);
	// public List<Map<String, Object>> query(Object[] fileds,String
	// sql,Object[] filedtype) ;
	public List<Map<String, Object>> queryroles(
			List<PropertyFilter> buildFromHttpRequest);

	public boolean qryuser(long roleid);

}
