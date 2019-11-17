package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the PCSELLSCHEDULE database table.
 * 
 */
@Entity
@Table(name="PCSELLSCHEDULE")
public class Pcsellschedule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="PCSELLSCHEDULE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PCSELLSCHEDULE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	private long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;
	private String ip;
	private long orgid;
	private String type;
	private long typeid;
	private long updateby;
	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    public Pcsellschedule() {
    }


	public long getId() {
		return this.id;
	}

	public void setId(long id) {
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


	@Column(nullable=false, length=40)
	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}


	@Column(nullable=false, precision=10)
	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}


	@Column(nullable=false, precision=10)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}


	@Column(nullable=false, precision=10)
	public long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(long typeid) {
		this.typeid = typeid;
	}


	@Column(precision=10)
	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}


    @Temporal( TemporalType.DATE)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}