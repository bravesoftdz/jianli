package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the USERROLE database table.
 * 
 */

@Entity
public class Userrole implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private UserrolePK id;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	public Userrole() {
	}

	public UserrolePK getId() {
		return id;
	}

	public void setId(UserrolePK id) {
		this.id = id;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

}