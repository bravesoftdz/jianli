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
import cn.nova.bus.system.model.Orgpermission;
import cn.nova.bus.system.service.OrgpermissionService;
import cn.nova.bus.system.service.impl.OrgpermissionServiceImpl;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 * 
 */
public class OrgpermissionAction  extends BaseAction{
	private OrgpermissionService orgpermissionService;
	private List<Orgpermission> orgpermissions;
	private List<Map<String,Object>> orgpermissionMap;
	private long roleid;

	public String query(){
		Global global = CurrentUtil.getGlobal();
		orgpermissionService = new OrgpermissionServiceImpl();
		setOrgpermissionMap(orgpermissionService.query(roleid,global.getUserinfo().getId()));
		return "json";
	}
	
	public String queryEmpty(){
		setOrgpermissionMap(ListUtil.listToMap(new Object[]{Orgpermission.class}, null));
		return "json";
	}
	
	public String save() {
		setMsg("");
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		for (Orgpermission orgpermission : orgpermissions) {
			orgpermission.setCreateby(global.getUserinfo().getId());
			orgpermission.setCreatetime(now);
		}
		try {
			orgpermissionService = new OrgpermissionServiceImpl();
			if (orgpermissionService.Save(getOrgpermissions())){
				markSuccess();
				setMsg("保存权限成功,请重新登录系统");
			}
			else
			{
				markFail();
				setMsg("保存机构权限失败，未知原因");
			}
		} catch (ServiceException e) {
			markFailure();
			setMsg(e.getExceptionMessage());
		}
		return "json";
	}

	public void setOrgpermissionMap(List<Map<String,Object>> orgpermissionMap) {
		this.orgpermissionMap = orgpermissionMap;
	}

	public List<Map<String,Object>> getOrgpermissionMap() {
		return orgpermissionMap;
	}

	public void setOrgpermissions(List<Orgpermission> orgpermissions) {
		this.orgpermissions = orgpermissions;
	}

	public List<Orgpermission> getOrgpermissions() {
		return orgpermissions;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}

	public long getRoleid() {
		return roleid;
	}

}
