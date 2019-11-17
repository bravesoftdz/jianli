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
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners(SyncCodeGenerate.class)
public class Vehicle implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VEHICLE_ID_GENERATOR", sequenceName = "SEQ_VEHICLE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLE_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(length = 20)
	private String cardno;

	@Column(nullable = false)
	private String color;

	@Temporal(TemporalType.DATE)
	private Date compulsoryinsureenddate;

	private String compulsoryinsureno;

	@Temporal(TemporalType.DATE)
	private Date compulsoryinsurestartdate;

	private String contactperson;

	private String contactphone;

	@Temporal(TemporalType.DATE)
	private Date contractenddate;

	private String contractno;

	@Temporal(TemporalType.DATE)
	private Date contractstartdate;

	@Column(nullable = false)
	private Long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String gprs;

	@Temporal(TemporalType.DATE)
	private Date grantdate;

	@Column(nullable = false)
	private boolean isactive;

	@Column(nullable = false)
	private boolean isaudited;

	@Column(nullable = false)
	private boolean isauditpass;

	@Column(nullable = false)
	private boolean islocaldelete;

	@Temporal(TemporalType.DATE)
	private Date liabilityinsureenddate;

	private String liabilityinsureno;

	@Temporal(TemporalType.DATE)
	private Date liabilityinsurestartdate;

	private String driverlicense;

	private boolean isneedfinger;

	private String roadno;

	@Temporal(TemporalType.DATE)
	private Date roadstartdate;

	@Temporal(TemporalType.DATE)
	private Date roadenddate;

	private String fueltype;

	private String pullinagreementno;

	@Temporal(TemporalType.DATE)
	private Date pullinStartdate;

	@Temporal(TemporalType.DATE)
	private Date pullinEnddate;

	private String businesscertificateno;
	@Temporal(TemporalType.DATE)
	private Date businesscertificatestartdate;
	@Temporal(TemporalType.DATE)
	private Date businesscertificateenddate;
	
	@Temporal(TemporalType.DATE)
	private Date extinguisherstartdate;
	@Temporal(TemporalType.DATE)
	private Date extinguisherenddate;

	public String getRoadno() {
		return roadno;
	}

	public void setRoadno(String roadno) {
		this.roadno = roadno;
	}

	@Temporal(TemporalType.DATE)
	private Date maintainvaliddate;

	private long nextmaintaindistance;

	public Date getMaintainvaliddate() {
		return maintainvaliddate;
	}

	public void setMaintainvaliddate(Date maintainvaliddate) {
		this.maintainvaliddate = maintainvaliddate;
	}

	public long getNextmaintaindistance() {
		return nextmaintaindistance;
	}

	public void setNextmaintaindistance(long nextmaintaindistance) {
		this.nextmaintaindistance = nextmaintaindistance;
	}

	@Temporal(TemporalType.DATE)
	private Date licenseenddate;

	@Temporal(TemporalType.DATE)
	private Date licensestartdate;

	private BigDecimal loadamout;

	@Column(nullable = false)
	private long orgid;

	@Lob
	private byte[] picture;

	@Column(nullable = false)
	private short rationseatnum;

	private String remarks;

	@Column(nullable = false)
	private short seatnum;

	@Column(nullable = false)
	private String type;

	@Column(nullable = false)
	private String status;

	@Column(nullable = false)
	private Long unitid;

	@Column(nullable = false)
	private Long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false)
	private long vehiclebrandmodelid;

	@Column(nullable = false)
	private String vehicleno;

	@Column(nullable = false)
	private Long vehicletypeid;

	@Temporal(TemporalType.DATE)
	private Date workenddate;

	private String workno;

	@Temporal(TemporalType.DATE)
	private Date workstartdate;

	@Column(nullable = false, length = 40)
	private String synccode;

	// 结算单位不同步
	@Column(nullable = false)
	private long balanceunitid;

	private BigDecimal margin;

	private BigDecimal stopfee;

	private BigDecimal checkfee;

	private BigDecimal otherfee;

	@Temporal(TemporalType.DATE)
	private Date vehiclenodate;

	@ManyToOne
	@JoinColumn(name = "ROUTEID", nullable = true)
	private Route route;

	private String entercardno;

	@Temporal(TemporalType.DATE)
	private Date makedate;

	@Temporal(TemporalType.DATE)
	private Date cardnoprintdate;

	private boolean istempvehicle;

	private String auditroute;

	private String seattype;

	private boolean isneedcheck;

	private String twodimensionno;

	private Boolean ischargestopfee;// 是否收取停车费
	private Boolean ischargescheckfee;// 是否收取例检费
	private Boolean ischargeotherfee;// 是否收取其他费用

	@Temporal(TemporalType.DATE)
	private Date technialstartdate;
	@Temporal(TemporalType.DATE)
	private Date technialenddate; 
	public Vehicle() {
	}

	public String getAuditroute() {
		return auditroute;
	}

	public void setAuditroute(String auditroute) {
		this.auditroute = auditroute;
	}

	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
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

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public Date getCompulsoryinsureenddate() {
		return compulsoryinsureenddate;
	}

	public void setCompulsoryinsureenddate(Date compulsoryinsureenddate) {
		this.compulsoryinsureenddate = compulsoryinsureenddate;
	}

	public String getCompulsoryinsureno() {
		return compulsoryinsureno;
	}

	public void setCompulsoryinsureno(String compulsoryinsureno) {
		this.compulsoryinsureno = compulsoryinsureno;
	}

	public Date getCompulsoryinsurestartdate() {
		return compulsoryinsurestartdate;
	}

	public void setCompulsoryinsurestartdate(Date compulsoryinsurestartdate) {
		this.compulsoryinsurestartdate = compulsoryinsurestartdate;
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

	public Date getContractenddate() {
		return contractenddate;
	}

	public void setContractenddate(Date contractenddate) {
		this.contractenddate = contractenddate;
	}

	public String getContractno() {
		return contractno;
	}

	public void setContractno(String contractno) {
		this.contractno = contractno;
	}

	public Date getContractstartdate() {
		return contractstartdate;
	}

	public void setContractstartdate(Date contractstartdate) {
		this.contractstartdate = contractstartdate;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getGprs() {
		return gprs;
	}

	public void setGprs(String gprs) {
		this.gprs = gprs;
	}

	public Date getGrantdate() {
		return grantdate;
	}

	public void setGrantdate(Date grantdate) {
		this.grantdate = grantdate;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean isIsaudited() {
		return isaudited;
	}

	public boolean getIsaudited() {
		return isaudited;
	}

	public void setIsaudited(boolean isaudited) {
		this.isaudited = isaudited;
	}

	public boolean isIsauditpass() {
		return isauditpass;
	}

	public boolean getIsauditpass() {
		return isauditpass;
	}

	public void setIsauditpass(boolean isauditpass) {
		this.isauditpass = isauditpass;
	}

	public String getDriverlicense() {
		return driverlicense;
	}

	public void setDriverlicense(String driverlicense) {
		this.driverlicense = driverlicense;
	}

	public Date getLiabilityinsureenddate() {
		return liabilityinsureenddate;
	}

	public void setLiabilityinsureenddate(Date liabilityinsureenddate) {
		this.liabilityinsureenddate = liabilityinsureenddate;
	}

	public String getLiabilityinsureno() {
		return liabilityinsureno;
	}

	public void setLiabilityinsureno(String liabilityinsureno) {
		this.liabilityinsureno = liabilityinsureno;
	}

	public Date getLiabilityinsurestartdate() {
		return liabilityinsurestartdate;
	}

	public void setLiabilityinsurestartdate(Date liabilityinsurestartdate) {
		this.liabilityinsurestartdate = liabilityinsurestartdate;
	}

	public Date getLicenseenddate() {
		return licenseenddate;
	}

	public void setLicenseenddate(Date licenseenddate) {
		this.licenseenddate = licenseenddate;
	}

	public Date getLicensestartdate() {
		return licensestartdate;
	}

	public void setLicensestartdate(Date licensestartdate) {
		this.licensestartdate = licensestartdate;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public byte[] getPicture() {
		return picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public boolean isIslocaldelete() {
		return islocaldelete;
	}

	public boolean getIslocaldelete() {
		return islocaldelete;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public BigDecimal getLoadamout() {
		return loadamout;
	}

	public void setLoadamout(BigDecimal loadamout) {
		this.loadamout = loadamout;
	}

	public short getRationseatnum() {
		return rationseatnum;
	}

	public void setRationseatnum(short rationseatnum) {
		this.rationseatnum = rationseatnum;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public short getSeatnum() {
		return seatnum;
	}

	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getUnitid() {
		return unitid;
	}

	public void setUnitid(Long unitid) {
		this.unitid = unitid;
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

	public long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public Long getVehicletypeid() {
		return vehicletypeid;
	}

	public void setVehicletypeid(Long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public Date getWorkenddate() {
		return workenddate;
	}

	public void setWorkenddate(Date workenddate) {
		this.workenddate = workenddate;
	}

	public String getWorkno() {
		return workno;
	}

	public void setWorkno(String workno) {
		this.workno = workno;
	}

	public Date getWorkstartdate() {
		return workstartdate;
	}

	public void setWorkstartdate(Date workstartdate) {
		this.workstartdate = workstartdate;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public BigDecimal getMargin() {
		return margin;
	}

	public void setMargin(BigDecimal margin) {
		this.margin = margin;
	}

	public BigDecimal getStopfee() {
		return stopfee;
	}

	public void setStopfee(BigDecimal stopfee) {
		this.stopfee = stopfee;
	}

	public BigDecimal getCheckfee() {
		return checkfee;
	}

	public void setCheckfee(BigDecimal checkfee) {
		this.checkfee = checkfee;
	}

	public BigDecimal getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}

	public Date getVehiclenodate() {
		return vehiclenodate;
	}

	public void setVehiclenodate(Date vehiclenodate) {
		this.vehiclenodate = vehiclenodate;
	}

	public String getEntercardno() {
		return entercardno;
	}

	public void setEntercardno(String entercardno) {
		this.entercardno = entercardno;
	}

	public Date getMakedate() {
		return makedate;
	}

	public void setMakedate(Date makedate) {
		this.makedate = makedate;
	}

	public Date getCardnoprintdate() {
		return cardnoprintdate;
	}

	public void setCardnoprintdate(Date cardnoprintdate) {
		this.cardnoprintdate = cardnoprintdate;
	}

	public boolean isIstempvehicle() {
		return istempvehicle;
	}

	public void setIstempvehicle(boolean istempvehicle) {
		this.istempvehicle = istempvehicle;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean getIsneedfinger() {
		return isneedfinger;
	}

	public void setIsneedfinger(boolean isneedfinger) {
		this.isneedfinger = isneedfinger;
	}

	public String getSeattype() {
		return seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public boolean getIsneedcheck() {
		return isneedcheck;
	}

	public void setIsneedcheck(boolean isneedcheck) {
		this.isneedcheck = isneedcheck;
	}

	public String getTwodimensionno() {
		return twodimensionno;
	}

	public void setTwodimensionno(String twodimensionno) {
		this.twodimensionno = twodimensionno;
	}

	public Date getRoadstartdate() {
		return roadstartdate;
	}

	public void setRoadstartdate(Date roadstartdate) {
		this.roadstartdate = roadstartdate;
	}

	public Date getRoadenddate() {
		return roadenddate;
	}

	public void setRoadenddate(Date roadenddate) {
		this.roadenddate = roadenddate;
	}

	public String getFueltype() {
		return fueltype;
	}

	public void setFueltype(String fueltype) {
		this.fueltype = fueltype;
	}

	public String getPullinagreementno() {
		return pullinagreementno;
	}

	public void setPullinagreementno(String pullinagreementno) {
		this.pullinagreementno = pullinagreementno;
	}

	public Date getPullinStartdate() {
		return pullinStartdate;
	}

	public void setPullinStartdate(Date pullinStartdate) {
		this.pullinStartdate = pullinStartdate;
	}

	public Date getPullinEnddate() {
		return pullinEnddate;
	}

	public void setPullinEnddate(Date pullinEnddate) {
		this.pullinEnddate = pullinEnddate;
	}

	public Boolean getIschargestopfee() {
		return ischargestopfee;
	}

	public void setIschargestopfee(Boolean ischargestopfee) {
		this.ischargestopfee = ischargestopfee;
	}

	public Boolean getIschargescheckfee() {
		return ischargescheckfee;
	}

	public void setIschargescheckfee(Boolean ischargescheckfee) {
		this.ischargescheckfee = ischargescheckfee;
	}

	public Boolean getIschargeotherfee() {
		return ischargeotherfee;
	}

	public void setIschargeotherfee(Boolean ischargeotherfee) {
		this.ischargeotherfee = ischargeotherfee;
	}

	public String getBusinesscertificateno() {
		return businesscertificateno;
	}

	public void setBusinesscertificateno(String businesscertificateno) {
		this.businesscertificateno = businesscertificateno;
	}

	public Date getBusinesscertificatestartdate() {
		return businesscertificatestartdate;
	}

	public void setBusinesscertificatestartdate(Date businesscertificatestartdate) {
		this.businesscertificatestartdate = businesscertificatestartdate;
	}

	public Date getBusinesscertificateenddate() {
		return businesscertificateenddate;
	}

	public void setBusinesscertificateenddate(Date businesscertificateenddate) {
		this.businesscertificateenddate = businesscertificateenddate;
	}

	public Date getExtinguisherstartdate() {
		return extinguisherstartdate;
	}

	public void setExtinguisherstartdate(Date extinguisherstartdate) {
		this.extinguisherstartdate = extinguisherstartdate;
	}

	public Date getExtinguisherenddate() {
		return extinguisherenddate;
	}

	public void setExtinguisherenddate(Date extinguisherenddate) {
		this.extinguisherenddate = extinguisherenddate;
	}

	public Date getTechnialstartdate() {
		return technialstartdate;
	}

	public void setTechnialstartdate(Date technialstartdate) {
		this.technialstartdate = technialstartdate;
	}

	public Date getTechnialenddate() {
		return technialenddate;
	}

	public void setTechnialenddate(Date technialenddate) {
		this.technialenddate = technialenddate;
	}

}