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
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * 
 * <p>
 * Title: 顾客信息
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
@Table(name = "CUSTOMER")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "CUSTOMER_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CUSTOMER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Temporal(TemporalType.DATE)
	private Date birthday;

	@Column(nullable = false, length = 50)
	private String certificateno;

	@Column(nullable = false, length = 10)
	private String certificatetype;

	@Column(nullable = false, precision = 10)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(length = 10)
	private String education;

	@Column(length = 100)
	private String familyaddress;

	@Column(length = 20)
	private String familyphone;

	@Column(nullable = false, length = 10)
	private String inputway;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date lastbuytickettime;

	@Column(length = 20)
	private String mobilephone;

	@Column(nullable = false, length = 20)
	private String name;

	@Column(precision = 10, nullable = false)
	private Long orgid;

	@Column(length = 100)
	private String remarks;

	@Column(nullable = false, length = 2)
	private String sex;

	@Column(precision = 10)
	private Long ticketoutletsid;

	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, precision = 1)
	private boolean isactive;

	@Column(nullable = false, precision = 1)
	private boolean islocaldelete;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Transient
	private String opertype;

	@Column(length = 100)
	private String email;
	
	private String nation;
	
	@Column(nullable = true, precision = 1)
	private boolean isblack = false;
	
	@Column(nullable = true, precision = 1)
	private boolean isred = false;

	public Customer() {
	}
	
	private String departstationname; //发车站
	private String reachstationname;  //到达站
	private String endstationname;  //终点站
	private String schcode;  //班次
	private String planvehicleno; //车牌号码
	private String ticketno;  //票号
	private Date departdate;   //发车日期
	private String departtime; //发车时间
	private String ticketstatus; //车票状态
	private Long seatno;  //座位号

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
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

	public String getCertificateno() {
		return this.certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getCertificatetype() {
		return this.certificatetype;
	}

	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
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

	public String getInputway() {
		return this.inputway;
	}

	public void setInputway(String inputway) {
		this.inputway = inputway;
	}

	public Date getLastbuytickettime() {
		return this.lastbuytickettime;
	}

	public void setLastbuytickettime(Date lastbuytickettime) {
		this.lastbuytickettime = lastbuytickettime;
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

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Long getTicketoutletsid() {
		return this.ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
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

	public boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public boolean getIslocaldelete() {
		return islocaldelete;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public boolean isIsblack() {
		return isblack;
	}

	public void setIsblack(boolean isblack) {
		this.isblack = isblack;
	}

	public boolean isIsred() {
		return isred;
	}

	public void setIsred(boolean isred) {
		this.isred = isred;
	}

	public String getDepartstationname() {
		return departstationname;
	}

	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}

	public String getReachstationname() {
		return reachstationname;
	}

	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}

	public String getEndstationname() {
		return endstationname;
	}

	public void setEndstationname(String endstationname) {
		this.endstationname = endstationname;
	}

	public String getSchcode() {
		return schcode;
	}

	public void setSchcode(String schcode) {
		this.schcode = schcode;
	}

	public String getPlanvehicleno() {
		return planvehicleno;
	}

	public void setPlanvehicleno(String planvehicleno) {
		this.planvehicleno = planvehicleno;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public String getTicketstatus() {
		return ticketstatus;
	}

	public void setTicketstatus(String ticketstatus) {
		this.ticketstatus = ticketstatus;
	}

	public Long getSeatno() {
		return seatno;
	}

	public void setSeatno(Long seatno) {
		this.seatno = seatno;
	}

    


	
}