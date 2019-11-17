package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Useronline;
import cn.nova.bus.system.service.UserService;
import cn.nova.bus.system.service.UseronlineService;
import cn.nova.bus.system.service.impl.UserServiceImpl;
import cn.nova.bus.system.service.impl.UseronlineServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class UseronlineAction extends BaseAction{
	private Useronline useronline;
	private List<Useronline> onlinelist;
	private List<Map<String, Object>> onlinemap;
	private HttpServletRequest httpServletRequest;

	private UseronlineService onlineService;

	private UserService userService;

	public String query() {
		try {
			onlineService = new UseronlineServiceImpl();
			setOnlinemap(onlineService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		if (useronline != null) {
			if (useronline.getUserid() > 0) {
				if (global.getUserinfo().getId()==(useronline.getUserid())) {
					msg = "对不起，你不能对自己的状态进行修改！";
					markFail();
					return "json";
				}
				msg = "修改成功！";
				markSuccess();
			}
			onlineService = new UseronlineServiceImpl();
			if (!onlineService.save(useronline)) {
				msg = "操作失败！！";
				markFail();
			}
		}
		return "json";
	}

	public String end() {
		Useronline online = null;
		Userinfo userinfo = null;
		Global global = CurrentUtil.getGlobal();
		// httpServletRequest.getSession().removeValue(online.getSessionid());
		try {
			onlineService = new UseronlineServiceImpl();
			online = onlineService.getByUserid(useronline.getUserid());
			userService = new UserServiceImpl();
			userinfo = userService.findById(useronline.getUserid());
			if (online != null) {
				if (global.getUserinfo().getId()==(useronline.getUserid())) {
					msg = "对不起，你不能强制自己下线！";
					markFail();
					return "json";
				}
				httpServletRequest.getSession().removeAttribute(
						online.getSessionid());
				userinfo.setIslock(false);
				online.setIsonline(false);
				msg = "强制下线成功！";
				markSuccess();
			}
			if (!onlineService.save(online)) {
				msg = "强制下线失败！";
				markFail();
			}
			userService.save(userinfo);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String enablelog() {
		Userinfo userinfo = null;
		try {
			userService = new UserServiceImpl();
			userinfo = userService.findById(useronline.getUserid());
			if (userinfo.getIslock() == true) {
				userinfo.setIslock(false);
				userinfo.setDefeatcount(0);
				msg = "该用户可以进行登录了！";
				markSuccess();
				userService.save(userinfo);
			} else {
				msg = "该用户没有被限制登录！";
				markFail();
			}

		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String logout() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				onlineService = new UseronlineServiceImpl();
				if (onlineService.logout(global.getUserinfo().getId(),global)) {
					OperationLogServiceImpl op=new OperationLogServiceImpl();
					Operationlog log=new Operationlog();
					log.setContent("用户退出系统");
					log.setIp(global.getIpAddress());
					log.setModule("退出系统");
					log.setOperatetime(new Date());
					log.setOperation("退出");
					log.setSessionid(global.getSessionID());
					log.setUserid(global.getUserinfo().getId());
					op.savelog(log);
					CurrentUtil.delGlobal(global);
					msg = "该用户已成功退出！";
					markSuccess();
				} else {
					markSuccess();
					setMsg("该用户退出失败！");
				}
			}
		} catch (Exception e) {
			markSuccess();
			setMsg("该用户退出失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public Useronline getUseronline() {
		return useronline;
	}

	public void setUseronline(Useronline useronline) {
		this.useronline = useronline;
	}

	public List<Useronline> getOnlinelist() {
		return onlinelist;
	}

	public void setOnlinelist(List<Useronline> onlinelist) {
		this.onlinelist = onlinelist;
	}

	public List<Map<String, Object>> getOnlinemap() {
		return onlinemap;
	}

	public void setOnlinemap(List<Map<String, Object>> onlinemap) {
		this.onlinemap = onlinemap;
	}

}
