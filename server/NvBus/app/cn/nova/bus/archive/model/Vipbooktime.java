package cn.nova.bus.archive.model;

import java.io.Serializable;
import javax.persistence.*;


import java.util.Date;


/**
 * VIP订票取消时间设置
 * The persistent class for the VIPBOOKTIME database table.
 * 
 */
@Entity
@Table(name="VIPBOOKTIME")
public class Vipbooktime implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VIPBOOKTIME_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPBOOKTIME_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=5)
	private long booktime;

	@Column(nullable=false, precision=10)
	private long createby;

	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=10)
	private long orgid;

	@Column(nullable=false, precision=10)
	private long updateby;

	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

	@Column(nullable=false, precision=10)
	private String vipgrade;

    public Vipbooktime() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBooktime() {
		return this.booktime;
	}

	public void setBooktime(long booktime) {
		this.booktime = booktime;
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

	public String getVipgrade() {
		return this.vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

}