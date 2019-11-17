package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.common.ConstDefiniens;

import java.util.Date;
import java.util.Map;

import play.mvc.Http;
import play.mvc.Http.Request;
import play.mvc.Scope.Session;
import util.CurrentUserID;
import util.CurrentUtil;
import cn.nova.bus.encrypt.MD5;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Useronline;
import cn.nova.bus.system.service.LoginService;
import cn.nova.bus.system.service.UseronlineService;
import cn.nova.bus.system.service.impl.LoginServiceImpl;
import cn.nova.bus.system.service.impl.UseronlineServiceImpl;
import cn.nova.utils.commons.MethodResult;

public class LoginAction extends BaseAction{
	private String username;
	private String userpwd;
	private String ticketoutletcode;
	private Global global;
	private String permissionkey;
	private String clientversion;
	private String servernum;
	private String verifyMsg;
	private int logintype;//登录方式、0：正常登录，1：锁屏后登录
	public int getLogintype() {
		return logintype;
	}

	public void setLogintype(int logintype) {
		this.logintype = logintype;
	}

	/**
	 * 退票页面登陆审核
	 * @return
	 */
	public String loginaudit(){
		try {
			LoginService loginService = new LoginServiceImpl();
			if (username != null && userpwd != null) {			
				String md5password = new String(MD5.cryptPassword(userpwd));
				boolean b =loginService.loginaudit(username, md5password,permissionkey);
				if(b){
					setMsg("权限校验成功！");
					markSuccess();
				}else{
					setMsg("该用户没有权限授权!");
					markFail();
				}
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("权限校验失败！");
		}
		return "json";
	}
	
	public String login() {
		try {
			UseronlineService onlineService = new UseronlineServiceImpl();
			LoginServiceImpl loginService = new LoginServiceImpl();

			if (username != null && userpwd != null) {			
				String md5password = new String(MD5.cryptPassword(userpwd));
				String remoteIP = getIpAddr();
				loginService.logintype=logintype;
				String key=Session.current().getId()+username;
				Session.current().put(ConstDefiniens.ZW_SEEESIONKEY,key);
				global=loginService.login(username, md5password, remoteIP,key,ticketoutletcode,servernum,clientversion);
				// 0036 密码有效期校验
				MethodResult methodresult = loginService.verifyValidityOfPassword(global);
				verifyMsg = "";
				if(methodresult.getResult()==0){
					//密码过期
					markFail();
					setMsg("登录失败！"+methodresult.getResultMsg());
				}else if(methodresult.getResult()==1){
					//密码即将过期
					setVerifyMsg(methodresult.getResultMsg());
				}else if(methodresult.getResult()==2){
					//参数未开启或不在提示范围内
				}else{
					//其他情况
				}
				
				CurrentUserID.setId(global.getUserinfo().getId());
				CurrentUserID.setOrgid(global.getUserinfo().getOrgid());
				
				// 0038 超时时间
				int expiretime = loginService.getExpiretime(global);
				global.setExpiretime(expiretime);
				if(expiretime <= 0){
					CurrentUtil.setGlobal(global);
				}else{
					CurrentUtil.setGlobal(global,expiretime);
				}
				
				Useronline useronline = new Useronline();
				useronline.setIp(global.getIpAddress());
				useronline.setIsonline(true);
				useronline.setUserid(global.getUserinfo().getId());
				useronline.setSessionid(global.getSessionID());
				useronline.setLastlogintime(onlineService.getById(global.getUserinfo().getId()));
				useronline.setLogintime(new Date());
				onlineService.save(useronline);
				setMsg("登录成功！");
				markSuccess();
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("登录失败！");
		}
		return "json";
	}

	private String getIpAddr() {
		Request request = Request.current();
		Map<String, Http.Header> headerMap = request.headers;
		Http.Header ip = headerMap.get("x-forwarded-for");
		if (ip == null || ip.value().length() == 0 || "unknown".equalsIgnoreCase(ip.name)) {
			ip = headerMap.get("Proxy-Client-IP");
		}
		if (ip == null || ip.value().length() == 0  || "unknown".equalsIgnoreCase(ip.name)) {
			ip = headerMap.get("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.value().length() == 0  || "unknown".equalsIgnoreCase(ip.name)) {
			return request.remoteAddress;
		}
		return ip.name;
	}

	public Global getGlobal() {
		return global;
	}

	public void setGlobal(Global global) {
		this.global = global;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userpwd) {
		try {
			// 加密
			// String md5temp=new String(MD5.cryptPassword(userpwd));
			this.userpwd = userpwd;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}

	}

	public void setTicketoutletcode(String ticketoutletcode) {
		this.ticketoutletcode = ticketoutletcode;
	}

	public String getTicketoutletcode() {
		return ticketoutletcode;
	}
	public String getPermissionkey() {
		return permissionkey;
	}

	public void setPermissionkey(String permissionkey) {
		this.permissionkey = permissionkey;
	}
	
	public String getClientversion() {
		return clientversion;
	}

	public void setClientversion(String clientversion) {
		this.clientversion = clientversion;
	}
	
	public String getServernum() {
		return servernum;
	}

	public void setServernum(String servernum) {
		this.servernum = servernum;
	}

	public String getVerifyMsg() {
		return verifyMsg;
	}

	public void setVerifyMsg(String verifyMsg) {
		this.verifyMsg = verifyMsg;
	}

}
