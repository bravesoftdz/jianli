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
 * The persistent class for the TICKETTYPEORG database table.
 * 
 */
@Entity
@Table(name="TICKETTYPEORG")
public class Tickettypeorg implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETTYPEORG_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETTYPEORG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=10)
	private long orgid;

	@Column(nullable=false, precision=10)
	private long tickettypeid;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    public Tickettypeorg() {
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

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getTickettypeid() {
		return this.tickettypeid;
	}

	public void setTickettypeid(long tickettypeid) {
		this.tickettypeid = tickettypeid;
	}

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