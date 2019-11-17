package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Menu;

public interface MenuService {
	
	public List<Map<String,Object>> query();
	public Menu add(Menu menu) throws ServiceException;
	public Menu update(Menu menu) throws ServiceException;
	public boolean delete(Menu menu) throws ServiceException;
	public List<Menu> getAll();
}
