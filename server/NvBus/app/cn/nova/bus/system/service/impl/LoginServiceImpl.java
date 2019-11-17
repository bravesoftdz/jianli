package cn.nova.bus.system.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.lf5.viewer.LogFactor5InputDialog;

import play.Play;

import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.service.TicketoutletService;
import cn.nova.bus.base.service.impl.TicketoutletServiceImpl;
import cn.nova.bus.common.NvBusVerifyConst;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.UserinfoDao;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Useronline;
import cn.nova.bus.system.service.DepartmentService;
import cn.nova.bus.system.service.LoginService;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.OrgpermissionService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.RoleService;
import cn.nova.bus.system.service.UseronlineService;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import util.TransactionUtil;

public class LoginServiceImpl implements LoginService {

	private UseronlineService useronlineService = new UseronlineServiceImpl();

	private UserinfoDao userDao = new UserinfoDao();

	private RoleService roleService = new RoleServiceImpl();

	private OrganizationService orgService = new OrganizationServiceImpl();

	private DepartmentService depService = new DepartmentServiceImpl();

	private TicketoutletService ticketoutletService = new TicketoutletServiceImpl();

	private OrgpermissionService orgpermissionService = new OrgpermissionServiceImpl();

	private ParameterService parameterService = new ParameterServiceImpl();
	
	private OperationLogService operationLogService = new OperationLogServiceImpl();

	private String serverversion = null;
	
	public int logintype;
	
	@Override
	public Global login(String code, String userpwd, String ipAddress, String sessionid, String ticketoutletcode,
			String servernum, String clientversion) throws ServiceException {
		Userinfo userinfo = userDao.getUser(code, userpwd);
		if (userinfo == null) {
			// 登录失败时增加登录失败次数=====================
			Userinfo u = userDao.getUserByCode(code);
			if (u == null) {
				throw new ServiceException("0108");
			} else {
				if (u.getIslock()) {
					throw new ServiceException("0109");
				}
				String param_0037 = parameterService.findParamValue(ParamterConst.Param_0037, u.getOrgid());
				if (Integer.parseInt(param_0037) > 0) {
					TransactionUtil.begin();
					// 日志记录==================================
					String result = "登录失败：用户名：" + u.getName() + ", 登录时间：" + DateUtils.formatDate(new Date())
							+ ", 登录IP: " + ipAddress + ", 登录失败次数: " + u.getDefeatcount() + 1;
					Operationlog operationLog = new Operationlog();
					operationLog.setIp(ipAddress);
					operationLog.setContent(result);
					operationLog.setModule("登录");
					operationLog.setOperatetime(new Date());
					operationLog.setOperation("登录");
					operationLog.setSessionid(sessionid);
					operationLog.setUserid(u.getId());
					operationLogService.savelog(operationLog);
					// ===========================================
					// 如果次数超过限制, 锁定用户并做提示
					if (u.getDefeatcount() + 1 >= Integer.parseInt(param_0037)) {
						u.setIslock(true);
						userDao.merge(u);
						TransactionUtil.commit();
						throw new ServiceException("0109");
					}
					u.setDefeatcount(u.getDefeatcount() + 1);
					userDao.merge(u);
					TransactionUtil.commit();
					// =======================================
				}
			}
			throw new ServiceException("0108");
		}
		if (userinfo.getIslock()) {
			throw new ServiceException("0109");
		}
		//登录成功 重置登录失败次数
		userinfo.setDefeatcount(0);
		userDao.merge(userinfo);
		Useronline useronline = useronlineService.getByUserid(userinfo.getId());
		if (useronline == null) {
			// 第一次登录
			useronline = new Useronline();
			useronline.setIp(ipAddress);
			useronline.setIsonline(true);
			useronline.setLastlogintime(new Date());
			useronline.setSessionid(sessionid);
			useronline.setLogintime(new Date());
			useronline.setUserid(userinfo.getId());
			useronlineService.save(useronline);
		} else {
			if (logintype==0 && useronline.getIsonline()) {
				// 若允许多点登录，则需判断是否已经登录
				if (userinfo.getIsmultipoint()) {
					useronline.setIp(ipAddress);
					useronline.setIsonline(true);
					useronline.setLastlogintime(useronline.getLogintime());
					useronline.setLogintime(new Date());
					useronlineService.save(useronline);
				} else {
					// 该用户已经登录
//					if (ipAddress.equals(useronline.getIp())) {
					if (!useronline.getIsonline()) {
						useronline.setIp(ipAddress);
						useronline.setIsonline(true);
						useronline.setLastlogintime(useronline.getLogintime());
						useronline.setLogintime(new Date());
						useronlineService.save(useronline);
					} else {
						throw new ServiceException("0127");
					}
				}
			}
		}
		Global global = new Global();
		global.setDepartment(depService.getById(userinfo.getDepartmentid()));
		global.setIpAddress(ipAddress);
		global.setIsonline(true);
		Organization org=orgService.getById(userinfo.getOrgid());
		if(org.getOrgan()==null){
			throw new ServiceException("6119");
		}
		global.setOrganization(org);
		if("3".equals(org.getType())){ //兼容车队用户也可以登录系统
			global.setStationname(null);
			global.setStationID(null);
		}else{
		global.setStationname(org.getStation().getName());
			global.setStationID(org.getStation().getId());
		}
		global.setOrganizations(orgpermissionService
				.queryOrgPermission(userinfo.getId()));
		StringBuilder orgids = new StringBuilder();
		if (global.getOrganizations() != null) {
			for (Organization _organization : global.getOrganizations()) {
				if (orgids.length() > 0) {
					orgids.append(",").append(_organization.getId());
				} else {
					orgids.append(_organization.getId());
				}
			}
			if (orgids.length() > 0) {
				orgids.insert(0, "(").append(")");
			}
		}
		global.setOrgIDs(orgids.toString());
		global.setSessionID(sessionid);
		Ticketoutlets ticketoutlets = ticketoutletService.findByCode(ticketoutletcode);
		String Param_0029 = parameterService.findParamValue(ParamterConst.Param_0029, userinfo.getOrgid());
		if (ticketoutlets == null) {
			throw new ServiceException("0241"); // 找不到对应的售票点，登录失败
		} /*
			 * else if (!userinfo.getIsmultipoint()&& ticketoutlets.getOrgid()
			 * != global.getOrganization().getId()) { throw new
			 * ServiceException("0242"); // 用户所属机构与售票点所属机构不一致，不允许登录 }
			 */
		if (Param_0029.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {// 说明集中式配载数据库A机构的人不能在B机构登陆
			if (ticketoutlets.getOrgid() != userinfo.getOrgid()) {
				throw new ServiceException("1568");
			}
		}

		if ("0".equals(servernum)) {
			if (!this.checkVersion(clientversion)) {
				if(serverversion!=null){
					throw new ServiceException("(服务端版本号："+serverversion+")","6120");
				}
			}
		}
		global.setTicketoutlets(ticketoutlets);
		global.setUserinfo(userinfo);
		global.setUserRole(roleService.query(userinfo.getId()));
		return global;
	}

	public void setOrgpermissionService(OrgpermissionService orgpermissionService) {
		this.orgpermissionService = orgpermissionService;
	}

	public OrgpermissionService getOrgpermissionService() {
		return orgpermissionService;
	}

	@Override
	public boolean loginaudit(String code, String userpwd, String permissionkey) throws ServiceException {
		Userinfo userinfo = userDao.getUser(code, userpwd);
		if (userinfo == null) {
			throw new ServiceException("0108");
		}
		if (userinfo.getIslock()) {
			throw new ServiceException("0109");
		}
		// Ticketoutlets ticketoutlets = ticketoutletService
		// .findByCode(ticketoutletcode);
		// if (ticketoutlets == null) {
		// throw new ServiceException("0241"); // 找不到对应的售票点，登录失败
		// } else if (ticketoutlets.getOrgid() !=
		// CurrentUtil.getGlobal().getOrganization().getId()) {
		// throw new ServiceException("0242"); // 用户所属机构与售票点所属机构不一致，不允许登录
		// }
		boolean b = userDao.checkPermission(permissionkey, userinfo);
		return b;
	}

	@Override
	public boolean checkVersion(String clientversion) {
		File file = new File(getClass().getProtectionDomain().getCodeSource().getLocation().getPath()
				+ "/public/download/serverversion.txt");
		BufferedReader reader = null;
		try {
			if (file.exists()) {
				reader = new BufferedReader(new FileReader(file));
					serverversion = reader.readLine();
				reader.close();
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(null==serverversion || "".equals(serverversion)){
			return false;
		}

		List<Object> list = null;
		String appName = Play.applicationPath.getName();
		if(NvBusVerifyConst.NVBUS_VERIFY_APP_NAME.equals(appName)){
			list = userDao.checkVerifyServerVersion();//工程名为测试版，则查询测试版本表VersionVerify
		}else{
			list = userDao.checkserverVersion();//查询测试版本表Version
		}
		if(list!=null&&list.size()>0){
			if (!list.get(0).equals("") && list.get(0) != null
					&& !serverversion.equals("") && serverversion != null) {
				if (serverversion.equals(clientversion) && clientversion.equals(list.get(0))) {
					return true;
				} 
			} else {
				return false;
			}
		}else{
			return false;
		}
	return false;
	}
	
	//校验密码有效期
	public MethodResult verifyValidityOfPassword(Global global) {
		MethodResult result = new MethodResult();
		Userinfo userinfo = global.getUserinfo();
		//0036 ，密码有效期天数，0：无限制，N表示天
		Long param_0036 = Long.parseLong(parameterService.findParamValue(ParamterConst.Param_0036, userinfo.getOrgid()));
		if(param_0036 == 0){
			result.setResult(2);
			return result;
		}
		// 今天  5天后过期. 
		long lastchangetime = userinfo.getLastchangepasswordtime().getTime();
		Calendar c_now = Calendar.getInstance();  
		c_now.setTime(new Date());  
		c_now.set(Calendar.DATE, c_now.get(Calendar.DATE) + param_0036.intValue()); 
		long overdueTime = c_now.getTimeInMillis();
        long between_days=(overdueTime-lastchangetime)/(1000*3600*24);  
	    if(between_days>0 && between_days<=3){
	    	result.setResult(1);
	    	result.setResultMsg("您的密码还有"+between_days+"天到期!请及时更改密码!");
	    }else if(between_days<=0){
	    	result.setResult(0);
	    	result.setResultMsg("您的密码已过期!请联系管理员更改密码!");
	    }else{
	    	result.setResult(2);
	    }
		return result;
	}

	//获取系统参数0038超时时间
	public Integer getExpiretime(Global global) {
		// TODO Auto-generated method stub
		return Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_0038, global.getUserinfo().getOrgid()));
	}
}
