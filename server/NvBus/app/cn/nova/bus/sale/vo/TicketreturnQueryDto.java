package cn.nova.bus.sale.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.jpa.DelphiDS;

/**
 * 
 * @ClassName:  TicketreturnQueryVo   
 * @Description: 退票时查询数据库返回对象
 * @author: ZhaoHH
 * @date:   2018-1-5
 *
 */
@Entity
public class TicketreturnQueryDto implements Serializable {
	private static final long serialVersionUID = 5226866231800975064L;

	private Boolean isselfschedule;

	private Boolean isselected;

	private Boolean isreturninsure;

	@Id
	private Long id;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private String departtime;

	private BigDecimal fullprice;

	private Boolean ischecked;

	private Boolean isdepartinvoices;

	private Boolean islinework;

	private Long orgid;

	private Long scheduleorgid;

	private String paymethod;

	private BigDecimal price;

	private BigDecimal servicefee;

	private Short seatno;

	private Long sellby;

	private String sellbyname;

	private Timestamp selltime;

	private String ticketno;

	private String sellway;

	private String ticketstatus;

	private String tickettype;

	private Integer childnum;

	private Long departstationid;

	private Long reachstationid;

	private Long ticketsignid;

	private BigDecimal signcharges;

	private String signreason;

	private Timestamp signtime;

	private Long signby;

	private Long insuranceid;

	private BigDecimal premium;

	private String insurancepaymethod;

	private String insuranceno;

	private String signbyname;

	private String schedulecode;

	private String customername;

	private String departstationname;

	private String reachstationname;
	
	/**
	 * 班次状态
	 */
	private String status;

	private String ticketstatusname;

	private boolean canreturnmoneyback;

	private String openapiorgname;

	private BigDecimal signrate;

	private BigDecimal rate;

	private BigDecimal charges;

	private String insurancesellway;
	
	/**
	 * 是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票
	 */
	private boolean isohteragent;
 
	private String orderno;
	
	private String insuorderno ;
	
	private String certificateno;
	
	private String certificatetype;


	public Boolean getIsselfschedule() {
		return isselfschedule;
	}

	public void setIsselfschedule(Boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public Boolean getIsselected() {
		return isselected;
	}

	public void setIsselected(Boolean isselected) {
		this.isselected = isselected;
	}

	public Boolean getIsreturninsure() {
		return isreturninsure;
	}

	public void setIsreturninsure(Boolean isreturninsure) {
		this.isreturninsure = isreturninsure;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public BigDecimal getFullprice() {
		return fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public Boolean getIschecked() {
		return ischecked;
	}

	public void setIschecked(Boolean ischecked) {
		this.ischecked = ischecked;
	}

	public Boolean getIsdepartinvoices() {
		return isdepartinvoices;
	}

	public void setIsdepartinvoices(Boolean isdepartinvoices) {
		this.isdepartinvoices = isdepartinvoices;
	}

	public Boolean getIslinework() {
		return islinework;
	}

	public void setIslinework(Boolean islinework) {
		this.islinework = islinework;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Long getScheduleorgid() {
		return scheduleorgid;
	}

	public void setScheduleorgid(Long scheduleorgid) {
		this.scheduleorgid = scheduleorgid;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public Short getSeatno() {
		return seatno;
	}

	public void setSeatno(Short seatno) {
		this.seatno = seatno;
	}

	public Long getSellby() {
		return sellby;
	}

	public void setSellby(Long sellby) {
		this.sellby = sellby;
	}

	public String getSellbyname() {
		return sellbyname;
	}

	public void setSellbyname(String sellbyname) {
		this.sellbyname = sellbyname;
	}

	public Timestamp getSelltime() {
		return selltime;
	}

	public void setSelltime(Timestamp selltime) {
		this.selltime = selltime;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getSellway() {
		return sellway;
	}

	public void setSellway(String sellway) {
		this.sellway = sellway;
	}

	public String getTicketstatus() {
		return ticketstatus;
	}

	public void setTicketstatus(String ticketstatus) {
		this.ticketstatus = ticketstatus;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public Integer getChildnum() {
		return childnum;
	}

	public void setChildnum(Integer childnum) {
		this.childnum = childnum;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	public Long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(Long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public Long getTicketsignid() {
		return ticketsignid;
	}

	public void setTicketsignid(Long ticketsignid) {
		this.ticketsignid = ticketsignid;
	}

	public BigDecimal getSigncharges() {
		return signcharges;
	}

	public void setSigncharges(BigDecimal signcharges) {
		this.signcharges = signcharges;
	}

	public String getSignreason() {
		return signreason;
	}

	public void setSignreason(String signreason) {
		this.signreason = signreason;
	}

	public Timestamp getSigntime() {
		return signtime;
	}

	public void setSigntime(Timestamp signtime) {
		this.signtime = signtime;
	}

	public Long getSignby() {
		return signby;
	}

	public void setSignby(Long signby) {
		this.signby = signby;
	}

	public Long getInsuranceid() {
		return insuranceid;
	}

	public void setInsuranceid(Long insuranceid) {
		this.insuranceid = insuranceid;
	}

	public BigDecimal getPremium() {
		return premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public String getInsurancepaymethod() {
		return insurancepaymethod;
	}

	public void setInsurancepaymethod(String insurancepaymethod) {
		this.insurancepaymethod = insurancepaymethod;
	}

	public String getInsuranceno() {
		return insuranceno;
	}

	public void setInsuranceno(String insuranceno) {
		this.insuranceno = insuranceno;
	}

	public String getSignbyname() {
		return signbyname;
	}

	public void setSignbyname(String signbyname) {
		this.signbyname = signbyname;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTicketstatusname() {
		return ticketstatusname;
	}

	public void setTicketstatusname(String ticketstatusname) {
		this.ticketstatusname = ticketstatusname;
	}

	public boolean isCanreturnmoneyback() {
		return canreturnmoneyback;
	}

	public void setCanreturnmoneyback(boolean canreturnmoneyback) {
		this.canreturnmoneyback = canreturnmoneyback;
	}

	public String getOpenapiorgname() {
		return openapiorgname;
	}

	public void setOpenapiorgname(String openapiorgname) {
		this.openapiorgname = openapiorgname;
	}

	public BigDecimal getSignrate() {
		return signrate;
	}

	public void setSignrate(BigDecimal signrate) {
		this.signrate = signrate;
	}

	public BigDecimal getRate() {
		return rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}

	public BigDecimal getCharges() {
		return charges;
	}

	public void setCharges(BigDecimal charges) {
		this.charges = charges;
	}

	public String getInsurancesellway() {
		return insurancesellway;
	}

	public void setInsurancesellway(String insurancesellway) {
		this.insurancesellway = insurancesellway;
	}

	public boolean isIsohteragent() {
		return isohteragent;
	}

	public void setIsohteragent(boolean isohteragent) {
		this.isohteragent = isohteragent;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getInsuorderno() {
		return insuorderno;
	}

	public void setInsuorderno(String insuorderno) {
		this.insuorderno = insuorderno;
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

}
