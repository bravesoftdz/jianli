/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.base.model.Tickettypepermission;
import cn.nova.bus.base.service.TickettypepermissionService;
import cn.nova.bus.base.service.impl.TickettypepermissionServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TickettypepermissionAction extends BaseAction{

	private Tickettypepermission tickettypepermission;
	private List<Map<String, Object>> permissionmap;
	public HttpServletRequest httpServletRequest;
	private Long id;

	private TickettypepermissionService permissionService;

	public String query() {
		try {
			permissionService = new TickettypepermissionServiceImpl();
			setPermissionmap(permissionService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("查询异常：" + e.getMessage());
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			permissionService = new TickettypepermissionServiceImpl();
			if (tickettypepermission != null) {
				if (tickettypepermission.getId() > 0) {
					tickettypepermission.setUpdateby(global.getUserinfo()
							.getId());
					tickettypepermission.setUpdatetime(new Date());
					markSuccess();
					setMsg("修改成功！");
				} else {
					tickettypepermission.setCreateby(global.getUserinfo()
							.getId());
					tickettypepermission.setCreatetime(new Date());
					tickettypepermission.setUpdateby(global.getUserinfo()
							.getId());
					tickettypepermission.setUpdatetime(new Date());
					markSuccess();
					setMsg("添加成功！");
				}
				tickettypepermission = permissionService.save(tickettypepermission);
				setId(tickettypepermission.getId());
			}
		} catch (ServiceException ex) {
			markFail();
			setMsg(ex.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delete() {
		try {
			permissionService = new TickettypepermissionServiceImpl();
			if (tickettypepermission != null) {
				if (tickettypepermission.getId() > 0) {
					permissionService.delete(tickettypepermission.getId());
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常:" + e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public Tickettypepermission getTickettypepermission() {
		return tickettypepermission;
	}

	public void setTickettypepermission(
			Tickettypepermission tickettypepermission) {
		this.tickettypepermission = tickettypepermission;
	}

	public List<Map<String, Object>> getPermissionmap() {
		return permissionmap;
	}

	public void setPermissionmap(List<Map<String, Object>> permissionmap) {
		this.permissionmap = permissionmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
