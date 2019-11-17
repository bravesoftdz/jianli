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
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * 
 * <p>
 * Title: 驾驶员信息
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
@Table(name = "DRIVER")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Driver implements Serializable {
	private static final long serialVersionUID = 1L;

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

	@Column(length = 20)
	private String drivinglicense;

	@Temporal(TemporalType.DATE)
	private Date drivinglicenseenddate;

	@Temporal(TemporalType.DATE)
	private Date drivinglicensefirstdate;

	@Temporal(TemporalType.DATE)
	private Date drivinglicensestartdate;

	private String education;

	@Column(length = 100)
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

	@Id
	@SequenceGenerator(name = "DRIVER_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DRIVER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	private String idcard;

	@Column(precision = 10)
	private Long initialkm;

	@Column(nullable = false, precision = 1)
	private boolean isactive;

	@Column(nullable = false, precision = 1)
	private boolean islocaldelete;

	@Column(precision = 1)
	private boolean issignedresponsibility;

	@Column(nullable = false, precision = 1)
	private boolean istemporary;

	@Column(length = 20)
	private String mobilephone;

	@Column(nullable = false, length = 20)
	private String name;
	
	@Column(nullable=true,length=20)
	private String jianpin;
	
	private String nativeplace;

	@Column(nullable = false, precision = 10)
	private Long orgid;

	@Lob()
	private byte[] picture;

	private String politicsstatus;

	@Column(length = 20)
	private String qualification;

	@Temporal(TemporalType.DATE)
	private Date qualificationenddate;

	@Temporal(TemporalType.DATE)
	private Date qualificationstartdate;

	@Column(length = 10)
	private String qualificationtype;

	@Column(length = 20)
	private String qualifyvehicletype;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	private Date recruitmentdate;

	@ManyToOne
	@JoinColumn(name = "routeid", nullable = true)
	private Route route;

	private BigDecimal salary;

	private String sex;

	@Column(length = 20)
	private String subunit;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Column(nullable = false, precision = 10)
	private Long unitid;

	@Column(precision = 10, nullable = false)
	private Long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@ManyToOne
	@JoinColumn(name = "vehicleid", nullable = true)
	private Vehicle vehicle;

	@Temporal(TemporalType.DATE)
	private Date workenddate;

	@Column(length = 20)
	private String workno;

	@Temporal(TemporalType.DATE)
	private Date workstartdate;

	private String workstatus;
	
	@Temporal(TemporalType.DATE)
	private Date sincerityauditingdate; 
	
	@Temporal(TemporalType.DATE)
	private Date continuingeducationdate;
	
	@Column(nullable=true,length=50)
	private String quanpin;

	public Driver() {
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

	public String getDrivinglicense() {
		return this.drivinglicense;
	}

	public Date getDrivinglicenseenddate() {
		return this.drivinglicenseenddate;
	}

	public Date getDrivinglicensefirstdate() {
		return this.drivinglicensefirstdate;
	}

	public Date getDrivinglicensestartdate() {
		return this.drivinglicensestartdate;
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

	public long getId() {
		return this.id;
	}

	public String getIdcard() {
		return this.idcard;
	}

	public Long getInitialkm() {
		return this.initialkm;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public boolean getIssignedresponsibility() {
		return this.issignedresponsibility;
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

	public String getQualification() {
		return this.qualification;
	}

	public Date getQualificationenddate() {
		return this.qualificationenddate;
	}

	public Date getQualificationstartdate() {
		return this.qualificationstartdate;
	}

	public String getQualificationtype() {
		return this.qualificationtype;
	}

	public String getQualifyvehicletype() {
		return qualifyvehicletype;
	}

	public Date getRecruitmentdate() {
		return this.recruitmentdate;
	}

	public Route getRoute() {
		return route;
	}

	public BigDecimal getSalary() {
		return this.salary;
	}

	public String getSex() {
		return this.sex;
	}

	public String getSubunit() {
		return this.subunit;
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

	public Vehicle getVehicle() {
		return vehicle;
	}

	public Date getWorkenddate() {
		return this.workenddate;
	}

	public String getWorkno() {
		return this.workno;
	}

	public Date getWorkstartdate() {
		return this.workstartdate;
	}

	public String getWorkstatus() {
		return this.workstatus;
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

	public void setDrivinglicense(String drivinglicense) {
		this.drivinglicense = drivinglicense;
	}

	public void setDrivinglicenseenddate(Date drivinglicenseenddate) {
		this.drivinglicenseenddate = drivinglicenseenddate;
	}

	public void setDrivinglicensefirstdate(Date drivinglicensefirstdate) {
		this.drivinglicensefirstdate = drivinglicensefirstdate;
	}

	public void setDrivinglicensestartdate(Date drivinglicensestartdate) {
		this.drivinglicensestartdate = drivinglicensestartdate;
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

	public void setId(long id) {
		this.id = id;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public void setInitialkm(Long initialkm) {
		this.initialkm = initialkm;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public void setIssignedresponsibility(boolean issignedresponsibility) {
		this.issignedresponsibility = issignedresponsibility;
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

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public void setQualificationenddate(Date qualificationenddate) {
		this.qualificationenddate = qualificationenddate;
	}

	public void setQualificationstartdate(Date qualificationstartdate) {
		this.qualificationstartdate = qualificationstartdate;
	}

	public void setQualificationtype(String qualificationtype) {
		this.qualificationtype = qualificationtype;
	}

	public void setQualifyvehicletype(String qualifyvehicletype) {
		this.qualifyvehicletype = qualifyvehicletype;
	}

	public void setRecruitmentdate(Date recruitmentdate) {
		this.recruitmentdate = recruitmentdate;
	}

	public void setRoute(Route route) {
		this.route = route;
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

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public void setWorkenddate(Date workenddate) {
		this.workenddate = workenddate;
	}

	public void setWorkno(String workno) {
		this.workno = workno;
	}

	public void setWorkstartdate(Date workstartdate) {
		this.workstartdate = workstartdate;
	}

	public void setWorkstatus(String workstatus) {
		this.workstatus = workstatus;
	}

	public String getJianpin() {
		return jianpin;
	}

	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
	}

	public Date getSincerityauditingdate() {
		return sincerityauditingdate;
	}

	public void setSincerityauditingdate(Date sincerityauditingdate) {
		this.sincerityauditingdate = sincerityauditingdate;
	}

	public Date getContinuingeducationdate() {
		return continuingeducationdate;
	}

	public void setContinuingeducationdate(Date continuingeducationdate) {
		this.continuingeducationdate = continuingeducationdate;
	}

	public String getQuanpin() {
		return quanpin;
	}

	public void setQuanpin(String quanpin) {
		this.quanpin = quanpin;
	}
	
	
}