package cn.nova.bus.insure.vo;

import java.io.Serializable;

public class InsuranceAppntMan implements Serializable { 
	private String orderno;
	private String passengername;
	private String passengeremail;
	private String passengerphone;
	private Integer idtype;
	private String idnum;
	private String sellorgcode;
	private String sellorgname;
	private String issuingpoint;
	private String issuingperson;
	private Integer issuingtype;
	private String selltickettime;
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getPassengername() {
		return passengername;
	}
	public void setPassengername(String passengername) {
		this.passengername = passengername;
	}
	public String getPassengeremail() {
		return passengeremail;
	}
	public void setPassengeremail(String passengeremail) {
		this.passengeremail = passengeremail;
	}
	public String getPassengerphone() {
		return passengerphone;
	}
	public void setPassengerphone(String passengerphone) {
		this.passengerphone = passengerphone;
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
	public String getSellorgcode() {
		return sellorgcode;
	}
	public void setSellorgcode(String sellorgcode) {
		this.sellorgcode = sellorgcode;
	}
	public String getSellorgname() {
		return sellorgname;
	}
	public void setSellorgname(String sellorgname) {
		this.sellorgname = sellorgname;
	}
	public String getIssuingpoint() {
		return issuingpoint;
	}
	public void setIssuingpoint(String issuingpoint) {
		this.issuingpoint = issuingpoint;
	}
	public String getIssuingperson() {
		return issuingperson;
	}
	public void setIssuingperson(String issuingperson) {
		this.issuingperson = issuingperson;
	}
	public Integer getIssuingtype() {
		return issuingtype;
	}
	public void setIssuingtype(Integer issuingtype) {
		this.issuingtype = issuingtype;
	}
	public String getSelltickettime() {
		return selltickettime;
	}
	public void setSelltickettime(String selltickettime) {
		this.selltickettime = selltickettime;
	}
	
}
