package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the UNIT database table. 车属单位
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Unit implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "UNIT_ID_GENERATOR", sequenceName = "SEQ_UNIT", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "UNIT_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private String accountno;

	@Column(nullable = false)
	private String code;

	private String contactperson;

	private String contactphone;

	@Column(nullable = false)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false)
	private Long districtid;

	@Column(nullable = false)
	private String fullname;

	@Column(nullable = false)
	private boolean isactive;

	@Column(nullable = false)
	private boolean islocaldelete;

	private String jianpin;

	@Column(nullable = false)
	private String name;

	@Column(nullable = false)
	private Long orgid;

	@Column(nullable = false)
	private String type;

	@Column(nullable = false)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	private String cardno;

	@Column(precision = 3, scale = 2)
	private BigDecimal taxrate;

	@Column(nullable = false, length = 40)
	private String synccode;

	public Unit() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getAccountno() {
		return accountno;
	}

	public void setAccountno(String accountno) {
		this.accountno = accountno;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContactperson() {
		return contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getContactphone() {
		return contactphone;
	}

	public void setContactphone(String contactphone) {
		this.contactphone = contactphone;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getDistrictid() {
		return districtid;
	}

	public void setDistrictid(Long districtid) {
		this.districtid = districtid;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIslocaldelete() {
		return islocaldelete;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public String getJianpin() {
		return jianpin;
	}

	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public BigDecimal getTaxrate() {
		return taxrate;
	}

	public void setTaxrate(BigDecimal taxrate) {
		this.taxrate = taxrate;
	}

	@Override
	public String toString() {
		return "Unit [id=" + id + ", accountno=" + accountno + ", code=" + code
				+ ", contactperson=" + contactperson + ", contactphone="
				+ contactphone + ", createby=" + createby + ", createtime="
				+ createtime + ", districtid=" + districtid + ", fullname="
				+ fullname + ", isactive=" + isactive + ", islocaldelete="
				+ islocaldelete + ", jianpin=" + jianpin + ", name=" + name
				+ ", orgid=" + orgid + ", type=" + type + ", updateby="
				+ updateby + ", updatetime=" + updatetime + "]";
	}

}