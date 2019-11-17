package cn.nova.bus.check.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.base.model.Vehicle;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.check.service.SecuritycheckService;
import cn.nova.bus.check.service.impl.SecuritycheckServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.UserService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.system.service.impl.UserServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SecuritycheckAction extends BaseAction{
	private Securitycheck securitycheck;
	private List<Securitycheck> securitylist;
	private List<Map<String, Object>> securitymap;
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> checkinfo;
	private List<Map<String, Object>> checkVehicle;
	private List<Map<String, Object>> checkValidatelist;

	public List<Map<String, Object>> getCheckValidatelist() {
		return checkValidatelist;
	}

	public void setCheckValidatelist(List<Map<String, Object>> checkValidatelist) {
		this.checkValidatelist = checkValidatelist;
	}

	private String name;
	private long vehicleid;
	private long driverid;
	private long driverid1;//新增要进行有效期提示的副驾驶员
	public long getDriverid1() {
		return driverid1;
	}

	public void setDriverid1(long driverid1) {
		this.driverid1 = driverid1;
	}

	private Long userid;
	private long checkid;
	private Long id;
	private String cardno;
	private boolean isautosave;
	private long orgid;
	private boolean ischeckenextday;
	private long routeid;//线路id 李电志  2015年7月8日 16:02:40
	private String unitname;

	private SecuritycheckService securityService;

	private UserService userService;

	public String query() {
		securityService = new SecuritycheckServiceImpl();
		try {
			setSecuritymap(securityService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryCheckinfo() {
		securityService = new SecuritycheckServiceImpl();
		try {
			setCheckinfo(securityService.queryCheckinfo(checkid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qrycheckinfobycard() {
		userService = new UserServiceImpl();
		securityService = new SecuritycheckServiceImpl();
		try {
			Userinfo user=userService.findByCard(cardno);
			if(user!=null){
				userid=user.getId();
				name=user.getName();
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String save() {
		userService = new UserServiceImpl();
		securityService = new SecuritycheckServiceImpl();
		ParameterService parameterService = new ParameterServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			msg = "保存成功！";
			markSuccess();
			securitycheck.setUpdateby(global.getUserinfo().getId());
			securitycheck.setUpdatetime(new Date());
			if(ischeckenextday){//安检明天车辆，则安检时间改为明早六点
				String checktime = "06:00:00";
				try{
					checktime = parameterService.findParamValue(ParamterConst.Param_6025,global.getUserinfo().getOrgid());
				}catch( Exception e)
				{
					System.out.println("安检明日车辆参数不存在！");
				}
				securitycheck.setChecktime(DateUtils.mergerDateAndTime(DateUtils.add(new Date(),1),checktime));
				if(securitycheck.getResult().equals("2")){
					securitycheck.setResult("0");
				}
			}else{
				securitycheck.setChecktime(new Date());
			}
			securitycheck.setCreatetime(new Date());
			Userinfo user = userService.findById(securitycheck.getCheckby());
//			Organization org = orgService.getById(user.getOrgid());
			securitycheck.setOrgid(user.getOrgid());
			String notenum = new Timestamp(System.currentTimeMillis())
					.toString().replace("-", "").substring(0, 8)
//					+ org.getCode()
//					+ securitycheck.getCheckby()
					//+global.getUserinfo().getCode()
					+ securityService.getSerialnumber(securitycheck
							.getCheckby());
			securitycheck.setNotenum(notenum);//年月日+安检员工号+3位序号
			securitycheck = securityService.save(securitycheck);
			unitname = securityService.getVehicleUnitName(securitycheck.getVehicleid());
			//更新车牌信息表   李电志  2015年7月8日 16:42:02
			//Vehicle vehicle = securityService.saveVehicleInfo(securitycheck.getVehicleid(),routeid);
			checkid = securitycheck.getId();
			setId(securitycheck.getId());
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markFail();
		}

		return "json";
	}

	/**
	 * 自动例检
	 * 
	 * @return
	 */
	public String autoSaveCheck() {
		securityService = new SecuritycheckServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			checkid = securityService.checkCardNO(cardno, isautosave, global);
			if (checkid > 0) {
				msg = "保存成功！";
				markSuccess();
			} else if (checkid == -1) {
				msg = "该车辆当日无例检！";
				markFail();
			} else if (checkid == -2) {
				msg = "该车辆当日已检！";
				markFail();
			} else if(checkid == -3){
				msg = "该车辆24小时内已检！";
				markFail();
			}
		} catch (ServiceException e) {
			checkid = 0;
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			checkid = 0;
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	/**
	 * 安检界面，通过 卡号 或者车辆查找要安检的车辆信息
	 * 
	 * @return
	 */
	public String qrySecurityVehicle() {
		securityService = new SecuritycheckServiceImpl();
		try {
			checkVehicle = securityService
					.qrySecurityVehicle(cardno, vehicleid,orgid);
			if (checkVehicle == null) {
				markFail();
			} else {
				markSuccess();
			}
		} catch (ServiceException se) {
			markFail();
			msg = se.getMessage();
			checkVehicle= ListUtil.listToMap(new Object[] { 
					"id"},null, new Object[] {Long.class});
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	/**
	 * 注销安检记录
	 * 
	 * @return
	 */
	public String delteChecked() {
		securityService = new SecuritycheckServiceImpl();
		try {
			if (securityService.deleteScurityCheck(checkid)) {
				markSuccess();
				msg = "注销成功";
			} else {
				markFail();
				msg = "注销失败";
			}
		} catch (ServiceException se) {
			markFail();
			msg = se.getMessage();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	/**
	 * 车辆安检月统计表
	 * 
	 * @return
	 */
	public String querySecuritycheck() {
		securityService = new SecuritycheckServiceImpl();
		try {
			setSecuritymap(securityService
					.querySecuritycheck(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 安检车辆证件有效期提醒还有过期多少天(添加安检界面和自动安检)
	 * 
	 * @return
	 */
	public String outdateshowValidate() {
		securityService = new SecuritycheckServiceImpl();
		try {
		msg = securityService.outdateshowValidate(orgid, vehicleid,cardno,driverid);
		if (msg !=null){
			markFail();
		}else{
			markSuccess();
		}
		} catch (ServiceException se) {
			markFail();
			msg = se.getMessage();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}
	
	
	
	/**
	 * 安检车辆证件有效期提醒还有多少天过期(添加安检界面和自动安检)
	 * 
	 * @return
	 */
	public String showValidate() {
		securityService = new SecuritycheckServiceImpl();
		try {
			setCheckValidatelist(securityService.showValidate(orgid, vehicleid,cardno,driverid,driverid1));
			/*if (msg !=null){
			markFail();
		}else{
			markSuccess(); 
		}*/
		} catch (ServiceException se) {
			markFail();
//			msg = se.getMessage();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}
	public String showExpire() {
		securityService = new SecuritycheckServiceImpl();
		try {
			Vehicle v = securityService.showExpire(orgid, vehicleid,cardno,driverid,driverid1);
			if(v!=null){
				//过期提示
				Date date = new Date();
				if(v.getLicenseenddate()==null || util.DateUtils.compare(v.getLicenseenddate(), date)<0
						|| v.getWorkenddate()==null || util.DateUtils.compare(v.getWorkenddate(), date)<0
						||v.getWorkenddate() == null || util.DateUtils.compare(v.getWorkenddate(), date)<0
						||v.getLiabilityinsureenddate()==null || util.DateUtils.compare(v.getLiabilityinsureenddate(), date)<0
						||v.getCompulsoryinsureenddate()==null || util.DateUtils.compare(v.getCompulsoryinsureenddate(), date)<0
						||v.getContractenddate()==null || util.DateUtils.compare(v.getContractenddate(), date)<0){
					setMsg("安检证件过期或者保险过期！");
					markFail();
				}
			}
			
			/*if (msg !=null){
			markFail();
		}else{
			markSuccess(); 
		}*/
		} catch (ServiceException se) {
			markFail();
//			msg = se.getMessage();
		} catch (Exception e) {
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}
	
	/**
	 * #11356 重打安检通知单：
	 * @return
	 */
	public String reprintSecurity(){
		securityService = new SecuritycheckServiceImpl();
		try {
			setCheckinfo(securityService.reprintSecurity(CurrentUtil.getGlobal(), checkid));
		}catch (Exception e) {
			play.Logger.error("重打安检通知单出错", e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	/**
	 * 车辆或驾驶员证件有效期到期提醒
	 * @return
	 */
	public String qrySecurityExpirydate(){
        Global global = CurrentUtil.getGlobal();
		securityService = new SecuritycheckServiceImpl();
		try {
			setResultmap(securityService.qrySecurityExpirydate(global,vehicleid,driverid));
		}catch (Exception e) {
			play.Logger.error("车辆或驾驶员证件有效期到期提醒出错", e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	public long getDriverid() {
		return driverid;
	}

	public void setDriverid(long driverid) {
		this.driverid = driverid;
	}

	public List<Securitycheck> getSecuritylist() {
		return securitylist;
	}

	public void setSecuritylist(List<Securitycheck> securitylist) {
		this.securitylist = securitylist;
	}

	public List<Map<String, Object>> getSecuritymap() {
		return securitymap;
	}

	public void setSecuritymap(List<Map<String, Object>> securitymap) {
		this.securitymap = securitymap;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Securitycheck getSecuritycheck() {
		return securitycheck;
	}

	public void setSecuritycheck(Securitycheck securitycheck) {
		this.securitycheck = securitycheck;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public long getCheckid() {
		return checkid;
	}

	public void setCheckid(long checkid) {
		this.checkid = checkid;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public List<Map<String, Object>> getCheckinfo() {
		return checkinfo;
	}

	public void setCheckinfo(List<Map<String, Object>> checkinfo) {
		this.checkinfo = checkinfo;
	}

	public boolean isIsautosave() {
		return isautosave;
	}

	public void setIsautosave(boolean isautosave) {
		this.isautosave = isautosave;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Map<String, Object>> getCheckVehicle() {
		return checkVehicle;
	}

	public void setCheckVehicle(List<Map<String, Object>> checkVehicle) {
		this.checkVehicle = checkVehicle;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public boolean isIscheckenextday() {
		return ischeckenextday;
	}

	public void setIscheckenextday(boolean ischeckenextday) {
		this.ischeckenextday = ischeckenextday;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public String getUnitname() {
		return unitname;
	}

	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}

	public void setId(long id) {
		this.id = id;
	}

    public List<Map<String, Object>> getResultmap() {
        return resultmap;
    }

    public void setResultmap(List<Map<String, Object>> resultmap) {
        this.resultmap = resultmap;
    }
}
