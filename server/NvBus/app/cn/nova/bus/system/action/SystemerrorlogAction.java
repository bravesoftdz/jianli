package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Systemerrorlog;
import cn.nova.bus.system.service.SystemerrorlogService;
import cn.nova.bus.system.service.impl.SystemerrorlogServiceImpl;

public class SystemerrorlogAction extends BaseAction{
	SystemerrorlogService logservice;
	
	private Systemerrorlog systemerrorlog;
	private List<Map<String,Object>> systemloglistmap;
	//查询条件
	private String module;		//action名称或EJB名称
	private String begindate;
	private String enddate;	
	private String begintime;
	private String endtime;
	private String orgname;		
	private String usernames;
	private String ip;
	
	public String saveLog(){
		try{
			logservice = new SystemerrorlogServiceImpl();
			logservice.savelog(systemerrorlog);
			System.out.println("系统日志已保存");
		}catch(Exception ex){
			System.out.println("系统日志保存失败，原因是；"+ex);
		}
		return "json";
	}
	
	public String delLog(){
		
		return "json";
	}
	
	public String findLog(){
		Map<Object,Object> where=new HashMap();
		where.put("begindatetime", begindate);
		where.put("enddatetime", enddate);
		where.put("orgname", orgname);
		where.put("usernames", usernames);
		where.put("module", module);
		where.put("ip", ip);
		logservice = new SystemerrorlogServiceImpl();
		systemloglistmap = logservice.findlogByMap(where);
		return "json";
	}

	public String getBegintime() {
		return begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public List<Map<String, Object>> getSystemloglistmap() {
		return systemloglistmap;
	}

	public void setSystemloglistmap(List<Map<String, Object>> systemloglistmap) {
		this.systemloglistmap = systemloglistmap;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public Systemerrorlog getSystemerrorlog() {
		return systemerrorlog;
	}

	public void setSystemerrorlog(Systemerrorlog systemerrorlog) {
		this.systemerrorlog = systemerrorlog;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getUsernames() {
		return usernames;
	}

	public void setUsernames(String usernames) {
		this.usernames = usernames;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getBegindate() {
		return begindate;
	}

	public void setBegindate(String begindate) {
		this.begindate = begindate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
}
