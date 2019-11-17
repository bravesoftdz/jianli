package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the VIPROOMCHECKIN database table.
 * 
 */
@Entity
public class Viproomcheckin implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VIPROOMCHECKIN_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPROOMCHECKIN_ID_GENERATOR")
	private long id;

	private long createby;

  
	private Date createtime;

	private long vipid;
	
	private long ticketsellid;
	
	private long checkinby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date checkintime;

    
	private long updateby;

	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getVipid() {
		return vipid;
	}

	public void setVipid(long vipid) {
		this.vipid = vipid;
	}

	public long getCheckinby() {
		return checkinby;
	}

	public void setCheckinby(long checkinby) {
		this.checkinby = checkinby;
	}

	public Date getCheckintime() {
		return checkintime;
	}

	public void setCheckintime(Date checkintime) {
		this.checkintime = checkintime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}
	
	@Temporal( TemporalType.TIMESTAMP)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}
	
	  @Temporal( TemporalType.TIMESTAMP)
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

    
}
