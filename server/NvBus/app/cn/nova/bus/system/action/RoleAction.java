/**
 * 
 */
package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Role;
import cn.nova.bus.system.service.RoleService;
import cn.nova.bus.system.service.impl.RoleServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author lanckun
 * 
 */
public class RoleAction extends BaseAction{
	private List<Map<String, Object>> rolemap;
	// private Page<Role> page = new Page<Role>(5);//每页5条记录
	private Role role;
	private long userid;
	private String roledataset;
	private long roleid; 

	public long getUserid() {
		return userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	private RoleService roleService;

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			roleService = new RoleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (role.getId() == 0) {
					role.setCreateby(global.getUserinfo().getId());
					role.setUpdateby(global.getUserinfo().getId());
					msg = "添加成功！";
					markSuccess();
				} else {
					role.setUpdateby(global.getUserinfo().getId());
					msg = "修改成功！";
					markSuccess();
				}
				role = roleService.save(role);
				setRoleid(role.getId());
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}
	
	public String queryRole() {
		try {
			roleService = new RoleServiceImpl();
			setRolemap(roleService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryallRole() {
		try {
			roleService = new RoleServiceImpl();
			setRolemap(roleService.queryroles(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			roleService = new RoleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (roleService.delete(role)) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}
	
	public String qryuser(){
		try {
			roleService=new RoleServiceImpl();
			if(roleService.qryuser(roleid)){ //查询角色下是否存在用户
				msg="查询成功";
				markSuccess();
			}else{
				msg=null;
				markSuccess();
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}
	@Transient
	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getRoledataset() {
		return roledataset;
	}

	public void setRoledataset(String roledataset) {
		this.roledataset = roledataset;
	}

	public List<Map<String, Object>> getRolemap() {
		return rolemap;
	}

	public void setRolemap(List<Map<String, Object>> rolemap) {
		this.rolemap = rolemap;
	}

	public long getRoleid() {
		return roleid;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}
}
