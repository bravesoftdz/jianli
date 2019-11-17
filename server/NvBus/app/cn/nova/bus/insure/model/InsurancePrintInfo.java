package cn.nova.bus.insure.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.jpa.DelphiDS;

/**
 * 保险票打印信息
 * @author ice
 */
@DelphiDS
public class InsurancePrintInfo implements Serializable {
	private static final long serialVersionUID = 1L;
	//该字段作为记录的操作类型字段
    private String opertype;
    //是否售保险
    private boolean issell;
	
	//车票信息
	private long sellid;
	private long scheduleplanid;
	@Temporal(value=TemporalType.DATE)
	private Date departdate;
	private String schedulecode;
	private boolean islinework;
	private boolean isestationsell;//是否是车站售电子票
    private String departstationname;
	private String reachstationname;
	private String reachstationsecondname;
	private String departtime;
	private Long distance;
    private String ticketno;
    private short seatno;
    private String seatnostr;
    private String tickettype;
    private byte carrychildnum;
    private long departstationid;
    private long reachstationid;
	//被保险人信息
    private Long customerid;
	private String certificateno;
	private String certificatetype;
	private String customername;
	private String education;
	private String familyaddress;
	private String familyphone;
//	private Date lastbuytickettime;
	private String mobilephone;
	private String customerremarks;
	private String nation;
	//保单信息
	private long id;
	private String insuranceno; //保险票据号
	private BigDecimal insureamount;
	private long insurersid;
	private long insuretypeid;
	private boolean isselfschedule;
//	private long orgid;
	private BigDecimal premium;
	private String paymethod;
	@Temporal(value=TemporalType.TIMESTAMP)
	private Date selltime;
	private String ticketoutletsname;

	private String polnumber;//保单号
	
	private BigDecimal emoney;//意外伤害保险金额
	private BigDecimal emmoney;//意外伤害医疗保险金额
	private String reprintdatetime;//保险票出票时间
	
	private int isnet;
	public int getIsnet() {
		return isnet;
	}
	public void setIsnet(int isnet) {
		this.isnet = isnet;
	}
	
	public InsurancePrintInfo() {
		
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public long getSellid() {
		return sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public boolean isIslinework() {
		return islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
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

	public String getReachstationsecondname() {
		return reachstationsecondname;
	}

	public void setReachstationsecondname(String reachstationsecondname) {
		this.reachstationsecondname = reachstationsecondname;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public Long getDistance() {
		return distance;
	}

	public void setDistance(Long distance) {
		this.distance = distance;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public short getSeatno() {
		return seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

	public byte getCarrychildnum() {
		return carrychildnum;
	}

	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

	public Long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(Long customerid) {
		this.customerid = customerid;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getCertificatetype() {
		return certificatetype;
	}

	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getInsuranceno() {
		return insuranceno;
	}

	public void setInsuranceno(String insuranceno) {
		this.insuranceno = insuranceno;
	}

	public BigDecimal getInsureamount() {
		return insureamount;
	}

	public void setInsureamount(BigDecimal insureamount) {
		this.insureamount = insureamount;
	}

	public long getInsurersid() {
		return insurersid;
	}

	public void setInsurersid(long insurersid) {
		this.insurersid = insurersid;
	}

	public long getInsuretypeid() {
		return insuretypeid;
	}

	public void setInsuretypeid(long insuretypeid) {
		this.insuretypeid = insuretypeid;
	}

	public boolean getIsselfschedule() {
		return isselfschedule;
	}

	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public BigDecimal getPremium() {
		return premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public Date getSelltime() {
		return selltime;
	}

	public void setSelltime(Date selltime) {
		this.selltime = selltime;
	}

	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getFamilyaddress() {
		return familyaddress;
	}

	public void setFamilyaddress(String familyaddress) {
		this.familyaddress = familyaddress;
	}

	public String getFamilyphone() {
		return familyphone;
	}

	public void setFamilyphone(String familyphone) {
		this.familyphone = familyphone;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public String getCustomerremarks() {
		return customerremarks;
	}

	public void setCustomerremarks(String customerremarks) {
		this.customerremarks = customerremarks;
	}

	public void setIssell(boolean issell) {
		this.issell = issell;
	}

	public boolean getIssell() {
		return issell;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public String getTickettype() {
		return tickettype;
	}

	/**
	 * 
	 * @return 座位号打印信息（座位号或者座位号备注信息）
	 */
	public String getSeatnostr() {
		return seatnostr;
	}

	public void setSeatnostr(String seatnostr) {
		this.seatnostr = seatnostr;
	}

	public String getPolnumber() {
		return polnumber;
	}

	public void setPolnumber(String polnumber) {
		this.polnumber = polnumber;
	}

	public BigDecimal getEmoney() {
		return emoney;
	}

	public void setEmoney(BigDecimal emoney) {
		this.emoney = emoney;
	}

	public BigDecimal getEmmoney() {
		return emmoney;
	}

	public void setEmmoney(BigDecimal emmoney) {
		this.emmoney = emmoney;
	}

	public String getReprintdatetime() {
		return reprintdatetime;
	}

	public void setReprintdatetime(String reprintdatetime) {
		this.reprintdatetime = reprintdatetime;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public boolean isIsestationsell() {
		return isestationsell;
	}

	public void setIsestationsell(boolean isestationsell) {
		this.isestationsell = isestationsell;
	}
	public long getDepartstationid() {
		return departstationid;
	}
	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}
	public long getReachstationid() {
		return reachstationid;
	}
	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}
	
}