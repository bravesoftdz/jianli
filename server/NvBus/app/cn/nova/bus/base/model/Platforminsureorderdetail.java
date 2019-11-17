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

import cn.nova.utils.orm.listener.SyncCodeGenerate;
@Entity
@EntityListeners({ SyncCodeGenerate.class })
public class Platforminsureorderdetail implements Serializable{

	@Id
	@SequenceGenerator(name = "INSUREORDER_ID_GENERATOR", sequenceName = "SEQ_INSUREORDER", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INSUREORDER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private long insuranceid;
	private long insureorderid;
	private String insureno;
	private String etinsureno;
	private String ticketno;
	private Integer iswithchildren;
	private long insureid;
	private BigDecimal rangkm;
	private BigDecimal price;
	private BigDecimal premium;
	private String departdate;
	private String departtime;
	private String schedulecode;
	private String seatno;
	private String passengername;
	private String passengerphone;
	private String passengeremail;
	private Integer idtype;
	private String idnum;
	private String departcode;
	private String departname;
	private String reachcode;
	private String reachname;
	private Integer status;//售保状态1-申请售保2-售保成功4-退保申请5-退保成功
	@Temporal(TemporalType.TIMESTAMP)
	private Date selltickettime;
	private String insureticketno;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getInsuranceid() {
		return insuranceid;
	}

	public void setInsuranceid(long insuranceid) {
		this.insuranceid = insuranceid;
	}

	public long getInsureorderid() {
		return insureorderid;
	}

	public void setInsureorderid(long insureorderid) {
		this.insureorderid = insureorderid;
	}


	public String getInsureno() {
		return insureno;
	}

	public void setInsureno(String insureno) {
		this.insureno = insureno;
	}

	public String getEtinsureno() {
		return etinsureno;
	}

	public void setEtinsureno(String etinsureno) {
		this.etinsureno = etinsureno;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public Integer getIswithchildren() {
		return iswithchildren;
	}

	public void setIswithchildren(Integer iswithchildren) {
		this.iswithchildren = iswithchildren;
	}

	public long getInsureid() {
		return insureid;
	}

	public void setInsureid(long insureid) {
		this.insureid = insureid;
	}

	public BigDecimal getRangkm() {
		return rangkm;
	}

	public void setRangkm(BigDecimal rangkm) {
		this.rangkm = rangkm;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getPremium() {
		return premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public String getDepartdate() {
		return departdate;
	}

	public void setDepartdate(String departdate) {
		this.departdate = departdate;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public String getSeatno() {
		return seatno;
	}

	public void setSeatno(String seatno) {
		this.seatno = seatno;
	}

	public String getPassengername() {
		return passengername;
	}

	public void setPassengername(String passengername) {
		this.passengername = passengername;
	}

	public String getPassengerphone() {
		return passengerphone;
	}

	public void setPassengerphone(String passengerphone) {
		this.passengerphone = passengerphone;
	}

	public String getPassengeremail() {
		return passengeremail;
	}

	public void setPassengeremail(String passengeremail) {
		this.passengeremail = passengeremail;
	}

	public Integer getIdtype() {
		return idtype;
	}

	public void setIdtype(Integer idtype) {
		this.idtype = idtype;
	}

	public String getIdnum() {
		return idnum;
	}

	public void setIdnum(String idnum) {
		this.idnum = idnum;
	}

	public String getDepartcode() {
		return departcode;
	}

	public void setDepartcode(String departcode) {
		this.departcode = departcode;
	}

	public String getDepartname() {
		return departname;
	}

	public void setDepartname(String departname) {
		this.departname = departname;
	}

	public String getReachcode() {
		return reachcode;
	}

	public void setReachcode(String reachcode) {
		this.reachcode = reachcode;
	}

	public String getReachname() {
		return reachname;
	}

	public void setReachname(String reachname) {
		this.reachname = reachname;
	}

	public Date getSelltickettime() {
		return selltickettime;
	}

	public void setSelltickettime(Date selltickettime) {
		this.selltickettime = selltickettime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getInsureticketno() {
		return insureticketno;
	}

	public void setInsureticketno(String insureticketno) {
		this.insureticketno = insureticketno;
	}

	
}
