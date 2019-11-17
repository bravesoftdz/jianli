package cn.nova.bus.base.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the TICKETRETURNRATE database table.
 * 
 */
@Entity
@Table(name="TICKETRETURNRATE")
public class Ticketreturnrate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETRETURNRATE_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETRETURNRATE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=10)
	private long orgid;

	@Column(nullable=false, precision=5, scale=4)
	private BigDecimal prerate;

	@Column(nullable=false, precision=4)
	private short timepoint;

	@Column(nullable=false, precision=10)
	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    public Ticketreturnrate() {
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

	public BigDecimal getPrerate() {
		return this.prerate;
	}

	public void setPrerate(BigDecimal prerate) {
		this.prerate = prerate;
	}

	public short getTimepoint() {
		return this.timepoint;
	}

	public void setTimepoint(short timepoint) {
		this.timepoint = timepoint;
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

}