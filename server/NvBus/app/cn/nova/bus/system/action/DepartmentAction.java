package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Department;
import cn.nova.bus.system.service.DepartmentService;
import cn.nova.bus.system.service.impl.DepartmentServiceImpl;

public class DepartmentAction extends BaseAction{
	private Department department;
	private List<Department> deplist;
	private List<Map<String, Object>> depmap;
	private Long parentid;

	private DepartmentService depService;

	public String query() {
		try {
			depService = new DepartmentServiceImpl();
			depmap = depService.query(parentid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		depService = new DepartmentServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (department != null) {
				if (department.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					department.setUpdateby(global.getUserinfo().getId());
					department.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					department.setCreateby(global.getUserinfo().getId());
					department.setUpdateby(global.getUserinfo().getId());
					department.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					department.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				department.setIsactive(true);
				depService.save(department);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败:" + e.getMessage();
			markFail();
		}
		return "json";
	}

	public String delete() {
		Global global=CurrentUtil.getGlobal();
		try {
			depService = new DepartmentServiceImpl();
			if (department != null) {
				if(depService.qryUserByOrgId(department.getId(),parentid)){//该部门下是否存在用户
//					boolean result = depService.delete(department.getId());
					Department newdepart=depService.getById(department.getId());
					newdepart.setUpdateby(global.getUserinfo().getId());
					newdepart.setUpdatetime(new Date());
					newdepart.setIsactive(false);
					if (depService.save(newdepart)) {
						msg = "删除成功！";
						markSuccess();
					} else {
						msg = "删除失败！";
						markFail();
					}
				}else{
					msg="删除失败，该部门下存在用户！";
					markFail();
				}
				
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public List<Department> getDeplist() {
		return deplist;
	}

	public void setDeplist(List<Department> deplist) {
		this.deplist = deplist;
	}

	public List<Map<String, Object>> getDepmap() {
		return depmap;
	}

	public void setDepmap(List<Map<String, Object>> depmap) {
		this.depmap = depmap;
	}

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}

}
