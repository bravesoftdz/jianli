package cn.nova.bus.insure.vo;

import java.io.Serializable;

public class InsuredMan implements Serializable{ 
	private String insureno;
	private String etinsureno;
	private String ticketno;
	private Integer iswithchildren;
	private Long insureid;
	private Double rangkm;
	private Double price;
	private Double premium;
	private String departdate;
	private String departtime;
	private String schedulecode;
	private String seatno;
	private String passengername;
	private String passengerphone;
	private String passengeremail;
	private Integer idtype = 1;
	private String idnum;
	private String departcode;
	private String departname;
	private String reachcode;
	private String reachname;
	private String selltickettime;
	private String insureticketno;
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
	public Long getInsureid() {
		return insureid;
	}
	public void setInsureid(Long insureid) {
		this.insureid = insureid;
	}
	public Double getRangkm() {
		return rangkm;
	}
	public void setRangkm(Double rangkm) {
		this.rangkm = rangkm;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getPremium() {
		return premium;
	}
	public void setPremium(Double premium) {
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
	public String getSelltickettime() {
		return selltickettime;
	}
	public void setSelltickettime(String selltickettime) {
		this.selltickettime = selltickettime;
	}
	public String getInsureticketno() {
		return insureticketno;
	}
	public void setInsureticketno(String insureticketno) {
		this.insureticketno = insureticketno;
	}
}
