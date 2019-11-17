package cn.nova.bus.system.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.MenuDao;
import cn.nova.bus.system.model.Menu;
import cn.nova.bus.system.service.MenuService;

public class MenuServiceImpl implements MenuService {

	MenuDao menuDao;

	@Override
	public List<Map<String, Object>> query() {
		menuDao=new MenuDao();
		return menuDao.query();
	}

	@Override
	public Menu add(Menu menu) throws ServiceException {
		menuDao=new MenuDao();
		return menuDao.merge(menu);
	}

	@Override
	public Menu update(Menu menu) throws ServiceException {
		menuDao=new MenuDao();
		return menuDao.merge(menu);
	}

	@Override
	public boolean delete(Menu menu) throws ServiceException {
		menuDao=new MenuDao();
		return menuDao.delete(menu);
	}

	@Override
	public List<Menu> getAll() {
		menuDao=new MenuDao();
		return menuDao.getAll();
	}

}
