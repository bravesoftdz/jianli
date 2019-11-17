package cn.nova.bus.check.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.check.model.Securitycheckitem;
import cn.nova.bus.check.service.SecuritycheckitemService;
import cn.nova.bus.check.service.impl.SecuritycheckitemServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SecuritycheckitemAction extends BaseAction{
	private Securitycheckitem securitycheckitem;
	private Long id;
	private List<Securitycheckitem> checkitemlist;
	private List<Map<String, Object>> checkitemmap;

	private SecuritycheckitemService securitycheckitemService;
	
	/**
	 * 车辆安检费统计表
	 * @return
	 */
	public String qrySecuritycheckfeeReport(){
		securitycheckitemService = new SecuritycheckitemServiceImpl();
		try {
			setCheckitemmap(securitycheckitemService
					.qrySecuritycheckfeeReport(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String query() {
		securitycheckitemService = new SecuritycheckitemServiceImpl();
		try {
			setCheckitemmap(securitycheckitemService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		securitycheckitemService = new SecuritycheckitemServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (securitycheckitem != null) {
				boolean isExist = securitycheckitemService.isUniqe(
						securitycheckitem.getName(),
						securitycheckitem.getCategorycode());
				if (securitycheckitem.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					securitycheckitem.setUpdateby(global.getUserinfo().getId());
					securitycheckitem.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					if (!securitycheckitemService.getId(
							securitycheckitem.getName(),
							securitycheckitem.getCategorycode()).equals(
							securitycheckitem.getId())) {
						if (!isExist) {
							msg = "对不起，你输入的大项名称、安检项目已经存在！请重新入！";
							markFail();
							return "json";
						}
					}
				} else {
					msg = "添加成功！";
					markSuccess();
					securitycheckitem.setCreateby(global.getUserinfo().getId());
					securitycheckitem.setUpdateby(global.getUserinfo().getId());
					securitycheckitem.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					securitycheckitem.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					if (!isExist) {
						msg = "你输入的大项名称、安检项目已经存在！请重新入!";
						markFail();
						return "json";
					}
				}
				securitycheckitem = securitycheckitemService.save(securitycheckitem);
				setId(securitycheckitem.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	public String delete() {
		securitycheckitemService = new SecuritycheckitemServiceImpl();
		try {
			if (securitycheckitem != null) {
				boolean result = securitycheckitemService.delete(securitycheckitem
						.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	public Securitycheckitem getSecuritycheckitem() {
		return securitycheckitem;
	}

	public void setSecuritycheckitem(Securitycheckitem securitycheckitem) {
		this.securitycheckitem = securitycheckitem;
	}

	public List<Securitycheckitem> getCheckitemlist() {
		return checkitemlist;
	}

	public void setCheckitemlist(List<Securitycheckitem> checkitemlist) {
		this.checkitemlist = checkitemlist;
	}

	public List<Map<String, Object>> getCheckitemmap() {
		return checkitemmap;
	}

	public void setCheckitemmap(List<Map<String, Object>> checkitemmap) {
		this.checkitemmap = checkitemmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
