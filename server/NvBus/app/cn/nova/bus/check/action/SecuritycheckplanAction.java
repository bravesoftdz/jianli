package cn.nova.bus.check.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.check.model.Securitycheckplan;
import cn.nova.bus.check.service.SecuritycheckplanService;
import cn.nova.bus.check.service.impl.SecuritycheckplanServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SecuritycheckplanAction extends BaseAction{
	private Securitycheckplan securitycheckplan;
	private Long id;
	private List<Securitycheckplan> securitylist;
	private List<Map<String, Object>> securitymap;

	private SecuritycheckplanService securityService;

	public String query() {
		try {
			securityService = new SecuritycheckplanServiceImpl();
			setSecuritymap(securityService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		securityService = new SecuritycheckplanServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (securitycheckplan.getId() > 0) {
				setMsg("修改成功！");
				markSuccess();
				securitycheckplan.setUpdateby(global.getUserinfo().getId());
				securitycheckplan.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			} else {
				setMsg("添加成功！");
				markSuccess();
				securitycheckplan.setUpdateby(global.getUserinfo().getId());
				securitycheckplan.setCreateby(global.getUserinfo().getId());
				securitycheckplan.setCreatetime(new Timestamp(System
						.currentTimeMillis()));
				securitycheckplan.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			}
			securitycheckplan = securityService.save(securitycheckplan);
			setId(securitycheckplan.getId());
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

	public String delete() {
		securityService = new SecuritycheckplanServiceImpl();
		try {
			if (securitycheckplan != null) {
				boolean result = securityService.delete(securitycheckplan
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

	public List<Securitycheckplan> getSecuritylist() {
		return securitylist;
	}

	public void setSecuritylist(List<Securitycheckplan> securitylist) {
		this.securitylist = securitylist;
	}

	public List<Map<String, Object>> getSecuritymap() {
		return securitymap;
	}

	public void setSecuritymap(List<Map<String, Object>> securitymap) {
		this.securitymap = securitymap;
	}

	public Securitycheckplan getSecuritycheckplan() {
		return securitycheckplan;
	}

	public void setSecuritycheckplan(Securitycheckplan securitycheckplan) {
		this.securitycheckplan = securitycheckplan;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
