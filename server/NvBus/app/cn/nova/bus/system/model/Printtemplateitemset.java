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


/**
 * The persistent class for the PRINTTEMPLATEITEMSET database table.
 * 
 */
@Entity
public class Printtemplateitemset implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="Printtemplate_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="Printtemplate_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isprint;

	private long orgid;

	private long printtemplatetypeitemid;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicleid;

    public Printtemplateitemset() {
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

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public boolean getIsprint() {
		return this.isprint;
	}

	public void setIsprint(boolean isprint) {
		this.isprint = isprint;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getPrinttemplatetypeitemid() {
		return this.printtemplatetypeitemid;
	}

	public void setPrinttemplatetypeitemid(long printtemplatetypeitemid) {
		this.printtemplatetypeitemid = printtemplatetypeitemid;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getVehicleid() {
		return this.vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

}