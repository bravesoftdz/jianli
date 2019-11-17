package cn.nova.bus.base.model;

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
 * The persistent class for the INITCARD database table. 智能卡
 */
@Entity
public class Initcard implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "INITCARD_ID_GENERATOR", sequenceName = "SEQ_INITCARD", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INITCARD_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@Column(nullable = false)
	private String cardno;

	@Column(nullable = false)
	private String cardtype;

	@Column(nullable = false)
	private Long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	private Long orgid;

	private String otherinfo;

	@Column(nullable = false)
	private String serialnumber;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Initcard() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCardno() {
		return this.cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getCardtype() {
		return this.cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}

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

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getOtherinfo() {
		return this.otherinfo;
	}

	public void setOtherinfo(String otherinfo) {
		this.otherinfo = otherinfo;
	}

	public String getSerialnumber() {
		return this.serialnumber;
	}

	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}

	@Override
	public String toString() {
		return "Initcard [id=" + id + ", cardno=" + cardno + ", cardtype="
				+ cardtype + ", createby=" + createby + ", createtime="
				+ createtime + ", orgid=" + orgid + ", otherinfo=" + otherinfo
				+ ", serialnumber=" + serialnumber + "]";
	}
}