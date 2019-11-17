package cn.nova.bus.sale.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the SEATLOCK database table.
 * 
 */
@Embeddable
public class SeatlockPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(unique=true, nullable=false, precision=10)
	private long scheduleplanid;

	@Column(unique=true, nullable=false, precision=3)
	private short seatno;

    public SeatlockPK() {
    }
	public long getScheduleplanid() {
		return this.scheduleplanid;
	}
	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}
	public short getSeatno() {
		return this.seatno;
	}
	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof SeatlockPK)) {
			return false;
		}
		SeatlockPK castOther = (SeatlockPK)other;
		return 
			(this.scheduleplanid == castOther.scheduleplanid)
			&& (this.seatno == castOther.seatno);

    }
    
	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.scheduleplanid ^ (this.scheduleplanid >>> 32)));
		hash = hash * prime + ((int) (this.seatno ^ (this.seatno >>> 32)));
		
		return hash;
    }
}