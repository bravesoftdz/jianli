package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.base.model.Unit;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * 
 * <p>
 * Title: 乘务员信息
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
@Table(name = "STEWARD")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Steward implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(nullable = false, precision = 10)
	private Long vehicleid;
	
	private String vehicleno;

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	@Column(length = 20)
	private String archiveno;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	private Date birthday;

	@Column(length = 20)
	private String cardno;

	@Column(nullable = false, length = 10)
	private String code;

	@Column(nullable = false, precision = 10)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, length = 10)
	private String education;

	@Column(length = 200)
	private String familyaddress;

	@Column(length = 20)
	private String familyphone;

	@Lob()
	private byte[] fingerprint1;

	@Lob()
	private byte[] fingerprint2;

	@Lob()
	private byte[] fingerprint3;

	private String fingerstr1;

	private String fingerstr2;

	private String fingerstr3;

	@Column(nullable = false, length = 10)
	private String grade;

	@Id
	@SequenceGenerator(name = "STEWARD_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "STEWARD_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, length = 18)
	private String idcard;

	@Column(nullable = false, precision = 1)
	private boolean isactive;

	@Column(nullable = false, precision = 1)
	private boolean islocaldelete;

	@Column(nullable = false, precision = 1)
	private boolean istemporary;

	@Column(length = 20)
	private String mobilephone;

	@Column(nullable = false, length = 20)
	private String name;

	@Column(length = 30)
	private String nativeplace;

	@Column(nullable = false, precision = 10)
	private Long orgid;

	@Lob()
	private byte[] picture;

	@Column(nullable = false, length = 10)
	private String politicsstatus;

	@Temporal(TemporalType.DATE)
	private Date qualificationenddate;

	@Column(length = 30)
	private String qualificationno;

	@Temporal(TemporalType.DATE)
	private Date qualificationstartdate;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal salary;

	private String sex;

	@Column(nullable = true)
	private String subunit;

	@Column(nullable = false, length = 40)
	private String synccode;
	@Column(nullable = false, precision = 10)
	private Long unitid;

	@Column(precision = 10, nullable = false)
	private Long updateby;

	@Column(nullable=true,length=20)
	private String jianpin;
	
	public String getJianpin() {
		return jianpin;
	}

	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
	}

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	public Steward() {
	}

	public String getArchiveno() {
		return this.archiveno;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public String getCardno() {
		return this.cardno;
	}

	public String getCode() {
		return this.code;
	}

	public Long getCreateby() {
		return this.createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public String getEducation() {
		return this.education;
	}

	public String getFamilyaddress() {
		return this.familyaddress;
	}

	public String getFamilyphone() {
		return this.familyphone;
	}

	public byte[] getFingerprint1() {
		return fingerprint1;
	}

	public byte[] getFingerprint2() {
		return fingerprint2;
	}

	public byte[] getFingerprint3() {
		return fingerprint3;
	}

	public String getFingerstr1() {
		return fingerstr1;
	}

	public String getFingerstr2() {
		return fingerstr2;
	}

	public String getFingerstr3() {
		return fingerstr3;
	}

	public String getGrade() {
		return this.grade;
	}

	public long getId() {
		return this.id;
	}

	public String getIdcard() {
		return this.idcard;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public boolean getIstemporary() {
		return this.istemporary;
	}

	public String getMobilephone() {
		return this.mobilephone;
	}

	public String getName() {
		return this.name;
	}

	public String getNativeplace() {
		return this.nativeplace;
	}

	public Long getOrgid() {
		return this.orgid;
	}

	public byte[] getPicture() {
		return this.picture;
	}

	public String getPoliticsstatus() {
		return this.politicsstatus;
	}

	public Date getQualificationenddate() {
		return this.qualificationenddate;
	}

	public String getQualificationno() {
		return this.qualificationno;
	}

	public Date getQualificationstartdate() {
		return this.qualificationstartdate;
	}

	public BigDecimal getSalary() {
		return this.salary;
	}

	public String getSex() {
		return this.sex;
	}

	public String getSubunit() {
		return subunit;
	}

	public String getSynccode() {
		return synccode;
	}

	public Long getUnitid() {
		return this.unitid;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setArchiveno(String archiveno) {
		this.archiveno = archiveno;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public void setFamilyaddress(String familyaddress) {
		this.familyaddress = familyaddress;
	}

	public void setFamilyphone(String familyphone) {
		this.familyphone = familyphone;
	}

	public void setFingerprint1(byte[] fingerprint1) {
		this.fingerprint1 = fingerprint1;
	}

	public void setFingerprint2(byte[] fingerprint2) {
		this.fingerprint2 = fingerprint2;
	}

	public void setFingerprint3(byte[] fingerprint3) {
		this.fingerprint3 = fingerprint3;
	}

	public void setFingerstr1(String fingerstr1) {
		this.fingerstr1 = fingerstr1;
	}

	public void setFingerstr2(String fingerstr2) {
		this.fingerstr2 = fingerstr2;
	}

	public void setFingerstr3(String fingerstr3) {
		this.fingerstr3 = fingerstr3;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public void setIstemporary(boolean istemporary) {
		this.istemporary = istemporary;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setNativeplace(String nativeplace) {
		this.nativeplace = nativeplace;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}

	public void setPoliticsstatus(String politicsstatus) {
		this.politicsstatus = politicsstatus;
	}

	public void setQualificationenddate(Date qualificationenddate) {
		this.qualificationenddate = qualificationenddate;
	}

	public void setQualificationno(String qualificationno) {
		this.qualificationno = qualificationno;
	}

	public void setQualificationstartdate(Date qualificationstartdate) {
		this.qualificationstartdate = qualificationstartdate;
	}

	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public void setSubunit(String subunit) {
		this.subunit = subunit;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public void setUnitid(Long unitid) {
		this.unitid = unitid;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}
	
}