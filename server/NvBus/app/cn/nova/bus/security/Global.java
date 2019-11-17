package cn.nova.bus.security;

/**
 * Global
 * <p>Description: 定义系统运行期全局变量 </p>
 * <p>Copyright: Copyright (c) 2010</p>
 * <p>Company: </p>
 * @author
 * @version 1.0
 */
import java.io.Serializable;
import java.util.List;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.system.model.Department;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Role;
import cn.nova.bus.system.model.Userinfo;

public class Global implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4934032888451070118L;
	
	private Ticketoutlets ticketoutlets; // 当前登录的售票点
	
	private Userinfo userinfo;//登录的用户
	
	private Organization organization; // 用户组织
	
	private Department department; // 用户部门

	private List<Organization> organizations; // 业务数据访问权限
	
	private List<Role> userRole; //

	private String orgIDs; // 业务数据访问权限

	private boolean isonline; // 用于用户下线的标识

	private String ipAddress; // 登录的IP地址

	private String sessionID; // 应用服务器会话ID

	private String stationname; //
	
	private int expiretime; //超时时间
		
	private Long stationID;
	public Long getStationID() {
		return stationID;
	}
	public void setStationID(Long stationID) {
		this.stationID = stationID;
	}
	public String getStationname() {
		return stationname;
	}

	public void setStationname(String stationname) {
		this.stationname = stationname;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}	

	public List<Role> getUserRole() {
		return userRole;
	}

	public void setUserRole(List<Role> userRole) {
		this.userRole = userRole;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getSessionID() {
		return sessionID;
	}

	public void setSessionID(String sessionID) {
		this.sessionID = sessionID;
	}

	public Userinfo getUserinfo() {
		return userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public List<Organization> getOrganizations() {
		return organizations;
	}

	public void setOrganizations(List<Organization> organizations) {
		this.organizations = organizations;
	}

	public boolean isIsonline() {
		return isonline;
	}

	public void setIsonline(boolean isonline) {
		this.isonline = isonline;
	}

	public String getOrgIDs() {
		return orgIDs;
	}

	public void setOrgIDs(String orgIDs) {
		this.orgIDs = orgIDs;
	}
	public Ticketoutlets getTicketoutlets() {
		return ticketoutlets;
	}

	public void setTicketoutlets(Ticketoutlets ticketoutlets) {
		this.ticketoutlets = ticketoutlets;
	}
	public int getExpiretime() {
		return expiretime;
	}
	public void setExpiretime(int expiretime) {
		this.expiretime = expiretime;
	}
}