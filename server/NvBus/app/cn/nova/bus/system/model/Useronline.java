package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the USERONLINE database table. 
 * 用户在线管理
 */
@Entity
public class Useronline implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "userid", unique = true, nullable = false, precision = 10, scale = 0)
	private long userid;

	private String ip;

	private boolean isonline;

	@Temporal(TemporalType.TIMESTAMP)
	private Date lastlogintime;

	@Temporal(TemporalType.TIMESTAMP)
	private Date logintime;

	private String sessionid;

	public Useronline() {
	}

	public long getUserid() {
		return this.userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public boolean getIsonline() {
		return this.isonline;
	}

	public void setIsonline(boolean isonline) {
		this.isonline = isonline;
	}

	public Date getLastlogintime() {
		return this.lastlogintime;
	}

	public void setLastlogintime(Date lastlogintime) {
		this.lastlogintime = lastlogintime;
	}

	public Date getLogintime() {
		return this.logintime;
	}

	public void setLogintime(Date logintime) {
		this.logintime = logintime;
	}

	public String getSessionid() {
		return this.sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}

	@Override
	public String toString() {
		return "Useronline [userid=" + userid + ", ip=" + ip + ", isonline="
				+ isonline + ", lastlogintime=" + lastlogintime
				+ ", logintime=" + logintime + ", sessionid=" + sessionid + "]";
	}

}