/**
 * 
 */
package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Menuhotkey;
import cn.nova.bus.system.service.MenuhotkeyService;
import cn.nova.bus.system.service.impl.MenuhotkeyServiceImpl;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 * 
 */
public class MenuhotkeyAction  extends BaseAction{
	private MenuhotkeyService menuhotkeyService;
	private List<Menuhotkey> menuhotkeys;
	private List<Map<String,Object>> menuhotkeyMap;
	private long roleid;

	public String query(){
		menuhotkeyService = new MenuhotkeyServiceImpl();
		setMenuhotkeyMap(menuhotkeyService.query(getRoleid()));
		return "json";
	}
	
	public String queryEmpty(){
		setMenuhotkeyMap(ListUtil.listToMap(new Object[]{Menuhotkey.class}, null));
		return "json";
	}
	
	public String save() {
		setMsg("");
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		for (Menuhotkey menuhotkey : menuhotkeys) {
			menuhotkey.setCreateby(global.getUserinfo().getId());
			menuhotkey.setCreatetime(now);
			menuhotkey.setUpdateby(global.getUserinfo().getId());
			menuhotkey.setUpdatetime(now);
		}
		try {
			menuhotkeyService = new MenuhotkeyServiceImpl();
			if (menuhotkeyService.Save(getMenuhotkeys())){
				markSuccess();
				setMsg("保存快捷键成功");
			}
			else
			{
				markFail();
				setMsg("保存快捷键失败，未知原因");
			}
		} catch (ServiceException e) {
			markFailure();
			setMsg(e.getExceptionMessage());
		}
		return "json";
	}

	public void setMenuhotkeyMap(List<Map<String,Object>> menuhotkeyMap) {
		this.menuhotkeyMap = menuhotkeyMap;
	}

	public List<Map<String,Object>> getMenuhotkeyMap() {
		return menuhotkeyMap;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}

	public long getRoleid() {
		return roleid;
	}

	public void setMenuhotkeys(List<Menuhotkey> menuhotkeys) {
		this.menuhotkeys = menuhotkeys;
	}

	public List<Menuhotkey> getMenuhotkeys() {
		return menuhotkeys;
	}

}
