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
 * The persistent class for the PCTICKETENTRANCE database table.
 * 
 */
@Entity
@Table(name="PCTICKETENTRANCE")
public class Pcticketentrance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="PCTICKETENTRANCE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PCTICKETENTRANCE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	private Long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date createtime;
	private String ip;
	private Long orgid;
	private Long ticketentranceid;
	private Long updateby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Pcticketentrance() {
    }


	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}


	@Column(nullable=false, precision=10)
	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
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
	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}


	@Column(nullable=false, precision=10)
	public Long getTicketentranceid() {
		return this.ticketentranceid;
	}

	public void setTicketentranceid(Long ticketentranceid) {
		this.ticketentranceid = ticketentranceid;
	}


	@Column(precision=10)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}


   
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}