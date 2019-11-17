package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Menuhotkey;

public interface MenuhotkeyService {
	
	public List<Map<String,Object>> query(long roleid);
	public boolean Save(List<Menuhotkey> menuhotkeys) throws ServiceException;
	
}
