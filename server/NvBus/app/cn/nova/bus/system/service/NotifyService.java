package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;

public interface NotifyService {
	public List<Map<String, Object>> queryNotify(Global global)
			throws ServiceException;

	public boolean updateNotify(long id) throws ServiceException;
}
