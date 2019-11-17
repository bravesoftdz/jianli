package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Orgpermission;

public interface OrgpermissionService {
	public List<Map<String, Object>> query(long roleid);
	public List<Map<String, Object>> query(long roleid,long curuserid);
	public List<Organization> queryOrgPermission(long userid);
	public boolean Save(List<Orgpermission> orgpermissions) throws ServiceException;
}
