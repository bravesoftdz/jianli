package cn.nova.bus.system.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

/**
 * The primary key class for the USERROLE database table.
 * 
 */
@Embeddable
public class UserrolePK implements Serializable {

	private static final long serialVersionUID = 1L;

	private long roleid;

	private long userid;

	public UserrolePK() {

	}

	public UserrolePK(long roleid, long userid) {
		this.roleid = roleid;
		this.userid = userid;
	}

	public long getRoleid() {
		return this.roleid;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}

	public long getUserid() {
		return this.userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof UserrolePK)) {
			return false;
		}
		UserrolePK castOther = (UserrolePK) other;
		return (this.roleid == castOther.roleid)
				&& (this.userid == castOther.userid);

	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.roleid ^ (this.roleid >>> 32)));
		hash = hash * prime + ((int) (this.userid ^ (this.userid >>> 32)));

		return hash;
	}
}