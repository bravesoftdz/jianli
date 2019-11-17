/**
 * 
 */
package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Menu;
import cn.nova.bus.system.service.MenuService;
import cn.nova.bus.system.service.impl.MenuServiceImpl;

/**
 * @author ice
 * 
 */
public class MenuAction  extends BaseAction{
	private MenuService menuService;
	private Menu menu;
	private List<Map<String,Object>> menuMap;
	private long menuid;

	public String query(){
		menuService = new MenuServiceImpl();
		setMenuMap(menuService.query());
		return "json";
	}
	
	public String saveFunctionreg() {
		setMsg("");
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		getMenu().setUpdateby(global.getUserinfo().getId());
		getMenu().setUpdatetime(now);
		menuService = new MenuServiceImpl();
		if(menu.getId()<=0){
			try {
				getMenu().setCreateby(global.getUserinfo().getId());
				getMenu().setCreatetime(now);
				menu = menuService.add(getMenu());
				markSuccess();
				setMsg("添加菜单成功");
				setMenuid(menu.getId());
			} catch (ServiceException e) {
				markFailure();
				setMsg(e.getExceptionMessage());
			}
		}
		else{
			try {
				menu = menuService.update(getMenu());
				markSuccess();
				setMsg("修改菜单成功");
				setMenuid(menu.getId());
			} catch (ServiceException e) {
				markFailure();
				setMsg(e.getExceptionMessage());
			}
		}
		return "json";
	}

	public String deleteMenu() {
		setMsg("");
		try {
			menuService = new MenuServiceImpl();
			if (menuService.delete(getMenu())){
				markSuccess();
				setMsg("删除菜单成功");
			}
			else{
				setMsg("删除菜单失败，未知原因");
			}
		} catch (ServiceException e) {
			markFailure();
			setMsg(e.getExceptionMessage());
		} catch (Exception e) {
			markFailure();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public void setMenuMap(List<Map<String,Object>> menuMap) {
		this.menuMap = menuMap;
	}

	public List<Map<String,Object>> getMenuMap() {
		return menuMap;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	@Transient
	public Menu getMenu() {
		return menu;
	}
	public void setMenuid(long menuid) {
		this.menuid = menuid;
	}
	public long getMenuid() {
		return menuid;
	}

}
