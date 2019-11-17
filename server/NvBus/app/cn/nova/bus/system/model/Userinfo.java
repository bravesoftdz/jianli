package cn.nova.bus.system.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * The persistent class for the USERINFO database table.
 * 
 */
@Entity
public class Userinfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "USERINFO_ID_GENERATOR", sequenceName="SEQ_USERINFO",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERINFO_ID_GENERATOR")
	private long id;

	private String cardno;

	private String code;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long departmentid;

	private String email;

	private String idcard;

	private boolean islock;

	private boolean ismultipoint;

	private String name;

	private long orgid;

	private String password;

	private String phone;

	private BigDecimal ticketdiscount;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private boolean isactive;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastchangepasswordtime;
	
	private int defeatcount;
	
	public String getRoles() {
		return roles;
	}

	public void setRoles(String roles) {
		this.roles = roles;
	}

	@Transient
	private String roles;

	public Userinfo() {
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

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public long getDepartmentid() {
		return this.departmentid;
	}

	public void setDepartmentid(long departmentid) {
		this.departmentid = departmentid;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdcard() {
		return this.idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public boolean getIslock() {
		return this.islock;
	}

	public void setIslock(boolean islock) {
		this.islock = islock;
	}

	public boolean getIsmultipoint() {
		return this.ismultipoint;
	}

	public void setIsmultipoint(boolean ismultipoint) {
		this.ismultipoint = ismultipoint;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public BigDecimal getTicketdiscount() {
		return this.ticketdiscount;
	}

	public void setTicketdiscount(BigDecimal ticketdiscount) {
		this.ticketdiscount = ticketdiscount;
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

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Date getLastchangepasswordtime() {
		return lastchangepasswordtime;
	}

	public void setLastchangepasswordtime(Date lastchangepasswordtime) {
		this.lastchangepasswordtime = lastchangepasswordtime;
	}

	public int getDefeatcount() {
		return defeatcount;
	}

	public void setDefeatcount(int defeatcount) {
		this.defeatcount = defeatcount;
	}
	

}