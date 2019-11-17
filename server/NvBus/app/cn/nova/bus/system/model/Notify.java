package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
public class Notify implements Serializable{
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = 6958997896594440235L;

	@Id
	@SequenceGenerator(name = "NOTITY_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "NOTITY_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;
	
	private String msg;
	
	private long userid;
	
	private boolean isnotify;
	
	private String notifyfuncitem;
	
	public String getNotifyfuncitem() {
		return notifyfuncitem;
	}


	public void setNotifyfuncitem(String notifyfuncitem) {
		this.notifyfuncitem = notifyfuncitem;
	}

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	
	public Notify(){
		
	}
	
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public long getUserid() {
		return userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public boolean isIsnotify() {
		return isnotify;
	}

	public void setIsnotify(boolean isnotify) {
		this.isnotify = isnotify;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}	
}
