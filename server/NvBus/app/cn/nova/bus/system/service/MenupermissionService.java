package cn.nova.bus.system.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Menupermission;

public interface MenupermissionService {
	public List<Map<String,Object>> query(long roleid);
	
	public boolean Save(List<Menupermission> menupermissions) throws ServiceException;
	
	public List<Map<String, Object>> queryByUserid(long userid);

	public boolean Save(Global global, Date now, String menuids, String functionpermissionregids, long roleid);
}
