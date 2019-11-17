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
import cn.nova.bus.system.model.Menupermission;
import cn.nova.bus.system.service.MenupermissionService;
import cn.nova.bus.system.service.impl.MenupermissionServiceImpl;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 * 
 */
public class MenupermissionAction  extends BaseAction{
	private MenupermissionService menupermissionService;
	private List<Menupermission> menupermissions;
	private List<Map<String,Object>> menupermissionMap;
	private long roleid;

	private String menuids;
	private String functionpermissionregids;
	
	public String query(){
		menupermissionService = new MenupermissionServiceImpl();
		setMenupermissionMap(menupermissionService.query(getRoleid()));
		return "json";
	}
	
	public String queryMenupermissionByUser(){
		menupermissionService = new MenupermissionServiceImpl();
		Global global = CurrentUtil.getGlobal();
		setMenupermissionMap(menupermissionService.queryByUserid(global.getUserinfo().getId()));
		return "json";
	}
	
	public String queryEmpty(){
		setMenupermissionMap(ListUtil.listToMap(new Object[]{Menupermission.class}, null));
		return "json";
	}
	
	public String save() {
		setMsg("");
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
//		for (Menupermission menupermission : menupermissions) {
//			menupermission.setCreateby(global.getUserinfo().getId());
//			menupermission.setCreatetime(now);
//		}
		try {
			menupermissionService = new MenupermissionServiceImpl();
			if (menupermissionService.Save(global,now,menuids,functionpermissionregids,roleid)){
				markSuccess();
				setMenupermissionMap(ListUtil.listToMap(new Object[]{Menupermission.class}, null));
			}
			else{
				markFail();
				setMsg("保存菜单权限失败，未知原因");
			}
		} catch (Exception e) {
			markFailure();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public void setMenupermissionMap(List<Map<String,Object>> menupermissionMap) {
		this.menupermissionMap = menupermissionMap;
	}

	public List<Map<String,Object>> getMenupermissionMap() {
		return menupermissionMap;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}

	public long getRoleid() {
		return roleid;
	}

	public void setMenupermissions(List<Menupermission> menupermissions) {
		this.menupermissions = menupermissions;
	}

	public List<Menupermission> getMenupermissions() {
		return menupermissions;
	}

	public String getMenuids() {
		return menuids;
	}

	public void setMenuids(String menuids) {
		this.menuids = menuids;
	}

	public String getFunctionpermissionregids() {
		return functionpermissionregids;
	}

	public void setFunctionpermissionregids(String functionpermissionregids) {
		this.functionpermissionregids = functionpermissionregids;
	}
	
	

}
