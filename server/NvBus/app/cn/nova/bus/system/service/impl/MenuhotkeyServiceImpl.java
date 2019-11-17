package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.MenuhotkeyDao;
import cn.nova.bus.system.model.Menuhotkey;
import cn.nova.bus.system.service.MenuhotkeyService;
import cn.nova.utils.orm.PropertyFilter;


public class MenuhotkeyServiceImpl implements MenuhotkeyService{

	private MenuhotkeyDao menuhotkeyDao = new MenuhotkeyDao();

	@Override
	public List<Map<String, Object>> query(long roleid) {
		return getMenuhotkeyDao().query(roleid);
	}

	@Override
	public boolean Save(List<Menuhotkey> menuhotkeys)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!roleid", menuhotkeys.get(0).getRoleid()));
//		propertyFilters.add(new PropertyFilter("EQL_t!menuid", menuhotkeys.get(0).getMenuid()));
		List<Menuhotkey> _menuhotkeys = menuhotkeyDao.find(Menuhotkey.class,propertyFilters);
		for (Menuhotkey menuhotkey : menuhotkeys) {
			boolean find = false;
			Menuhotkey oldmenuhotkey = null;
			for (Menuhotkey _menuhotkey : _menuhotkeys) {
				if(_menuhotkey.getMenuid()==menuhotkey.getMenuid()){
					find = true;
					oldmenuhotkey = _menuhotkey;
					break;
				}
			}
			if(menuhotkey.getHotkey()==null||"".equals(menuhotkey.getHotkey())){
				if(find&&oldmenuhotkey.getHotkey()!=null&&!"".equals(oldmenuhotkey.getHotkey())){
					oldmenuhotkey.setHotkey(null);
					oldmenuhotkey.setUpdateby(menuhotkey.getUpdateby());
					oldmenuhotkey.setUpdatetime(menuhotkey.getUpdatetime());
					menuhotkeyDao.merge(oldmenuhotkey);
				}
			}
			else{
				if(find){
					menuhotkey.setId(oldmenuhotkey.getId());
					menuhotkey.setCreateby(oldmenuhotkey.getCreateby());
					menuhotkey.setCreatetime(oldmenuhotkey.getCreatetime());
				}
				menuhotkeyDao.merge(menuhotkey);
			}
		}
		return true;
	}

	public void setMenuhotkeyDao(MenuhotkeyDao menuhotkeyDao) {
		this.menuhotkeyDao = menuhotkeyDao;
	}

	public MenuhotkeyDao getMenuhotkeyDao() {
		return menuhotkeyDao;
	}



}
