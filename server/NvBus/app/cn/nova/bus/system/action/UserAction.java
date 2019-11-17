package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;
import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.encrypt.MD5;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Userticketoutlets;
import cn.nova.bus.system.service.UserService;
import cn.nova.bus.system.service.impl.UserServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author ice
 * 
 */
public class UserAction extends BaseAction{
	private static final long serialVersionUID = -8499273442033268163L;
	// private Page<Userinfo> page = new Page<Userinfo>(3);//每页4条记录
	private Userinfo user;
	private UserService userService;
	private List<Map<String, Object>> usermap;
	public HttpServletRequest httpServletRequest;

	private String sResult;
	private long nResult;
	private String pass;
	private String newpassword;
	private long userid;
	private long ticketoutlet;

	public long getUserid() {
		return userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public String save() {
		userService = new UserServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (global != null) {
			if (user != null) {
				if (user.getId() != 0) {
					Userinfo info = userService.findById(user.getId());
					if (!user.getPassword().equals(info.getPassword())) {
						String md5temp = new String(MD5.cryptPassword(user
								.getPassword()));
						user.setPassword(md5temp);
					}
					user.setUpdateby(global.getUserinfo().getId());
					user.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				} else {
					user.setUpdateby(global.getUserinfo().getId());
					user.setUpdatetime(new Timestamp(System.currentTimeMillis()));

					user.setCreateby(global.getUserinfo().getId());
					user.setCreatetime(new Timestamp(System.currentTimeMillis()));
					String md5temp = new String(MD5.cryptPassword(user
							.getPassword()));
					user.setPassword(md5temp);
				}
				user.setIsactive(true);
				user.setLastchangepasswordtime(new Date());
				if (user.getId() > 0) {
					sResult = "修改成功！";
					nResult = new Long(1);
				} else {
					sResult = "添加成功！";
					nResult = new Long(1);
				}
				try {
					user = userService.save(user);
					userService.saveticketoutlet(user,ticketoutlet);
				} catch (ServiceException e) {
					setNResult((long) -1);
					setSResult(e.getMessage());
				}
				userid = user.getId();
			}

		} else {
			sResult = "未登陆！";
			nResult = new Long(-1);
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			userService = new UserServiceImpl();
			if (user.getId() != 0) {
				Userinfo userinfo = userService.findById(user.getId());
				userinfo.setUpdateby(global.getUserinfo().getId());
				userinfo.setUpdatetime(new Date());
				userinfo.setIsactive(false);
				user = userService.save(userinfo);
				if (user.getId() > 0) {
					sResult = "删除成功！";
					nResult = new Long(1);
				} else {
					sResult = "删除失败！";
					nResult = new Long(-1);
				}
			}
		} catch (ServiceException e) {
			setSResult(e.getMessage());
		}
		return "json";
	}

	public String list() {
		try {
			userService = new UserServiceImpl();
			setUsermap(userService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String listEntrypacker() {
		try {
			userService = new UserServiceImpl();
			setUsermap(userService.queryEntrypacker(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String password() {
		Global global = CurrentUtil.getGlobal();
		String md5temp = new String(MD5.cryptPassword(user.getPassword()));
		user.setPassword(md5temp);
		userService = new UserServiceImpl();
		boolean ischeckpass = userService.checkPassword(global.getUserinfo()
				.getName(), user.getPassword());
		if (ischeckpass) {
			if (getNewpassword().equals(getPass())) {
				nResult = new Long(1);
				sResult = "密码修改成功！";
				Userinfo userinfo = userService.findById(global.getUserinfo()
						.getId());
				String password = new String(
						MD5.cryptPassword(getNewpassword()));
				userinfo.setPassword(password);
				userinfo.setUpdateby(global.getUserinfo().getId());
				userinfo.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				if (!userService.updatepass(userinfo)) {
					nResult = new Long(-1);
					sResult = "密码修改失败！";
				}
			} else {
				nResult = new Long(-1);
				sResult = "对不起，你二次输入的密码不正确！";
			}
		} else {
			nResult = new Long(-1);
			sResult = "对不起，你输入的旧密码不正确！";
		}
		return "json";
	}
	
	public String getSResult() {
		return sResult;
	}

	public void setSResult(String sResult) {
		this.sResult = sResult;
	}

	public long getNResult() {
		return nResult;
	}

	public void setNResult(long nResult) {
		this.nResult = nResult;
	}

	// public Page<Userinfo> getPage() {
	// return page;
	// }
	// public void setPage(Page<Userinfo> page) {
	// this.page = page;
	// }
	@Transient
	public Userinfo getUser() {
		return user;
	}

	public void setUser(Userinfo user) {
		this.user = user;
	}

	public List<Map<String, Object>> getUsermap() {
		return usermap;
	}

	public void setUsermap(List<Map<String, Object>> usermap) {
		this.usermap = usermap;
	}

	public String getNewpassword() {
		return newpassword;
	}

	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public long getTicketoutlet() {
		return ticketoutlet;
	}

	public void setTicketoutlet(long ticketoutlet) {
		this.ticketoutlet = ticketoutlet;
	}

}
