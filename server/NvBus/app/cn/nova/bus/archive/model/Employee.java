package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * 
 * <p>
 * Title: 员工信息
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author huanghz
 * @version 0.1
 */
@Entity
@Table(name="EMPLOYEE")
public class Employee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="EMPLOYEE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="EMPLOYEE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

  @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date birthday;

	@Column(nullable=false, length=10)
	private String code;

	@Column(nullable=false, precision=10)
	private Long createby;

  @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, length=10)
	private String education;

	@Column(length=100)
	private String familyaddress;

	@Column(length=20)
	private String familyphone;

	@Column(nullable=false, length=18)
	private String idcard;

	@Column(nullable=false, precision=1)
	private boolean isactive;

	@Column(nullable=false, precision=1)
	private boolean istemporary;

	@Column(length=20)
	private String mobilephone;

	@Column(nullable=false, length=20)
	private String name;

	@Column(length=30)
	private String nativeplace;

	@Column(nullable=false, precision=10)
	private Long orgid;

  @Lob()
	private byte[] picture;

	@Column(nullable=false, length=10)
	private String position;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal salary;

	@Column(nullable=false, length=2)
	private String sex;

	@Column(nullable=false, precision=10)
	private Long updateby;

  @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

  public Employee() {
  }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getFamilyaddress() {
		return this.familyaddress;
	}

	public void setFamilyaddress(String familyaddress) {
		this.familyaddress = familyaddress;
	}

	public String getFamilyphone() {
		return this.familyphone;
	}

	public void setFamilyphone(String familyphone) {
		this.familyphone = familyphone;
	}

	public String getIdcard() {
		return this.idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIstemporary() {
		return this.istemporary;
	}

	public void setIstemporary(boolean istemporary) {
		this.istemporary = istemporary;
	}

	public String getMobilephone() {
		return this.mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNativeplace() {
		return this.nativeplace;
	}

	public void setNativeplace(String nativeplace) {
		this.nativeplace = nativeplace;
	}

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public byte[] getPicture() {
		return this.picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}

	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public BigDecimal getSalary() {
		return this.salary;
	}

	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
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