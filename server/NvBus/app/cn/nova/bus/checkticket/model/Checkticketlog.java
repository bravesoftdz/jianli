package cn.nova.bus.checkticket.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Checkticketlog {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "CHECKTICKETLOG_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CHECKTICKETLOG_ID_GENERATOR")
	private long id;
	
	private Date departdate;
	
	private String departtime;
	
	private String schedulecode;
	
	private String reachstation;
	
	private String ticketno;
	
	private String checkedby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date checktime;
	
	private String checkedip;
	
	private String checkedbycode;
	
	private String checktype;
	
	private String operationtype;
	
	private String customername;
	
	private String certificatetype;
	
	private String certificateno;

	public long getId() {
		return id;
	}

	public void setId(long id) {
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

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public String getReachstation() {
		return reachstation;
	}

	public void setReachstation(String reachstation) {
		this.reachstation = reachstation;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getCheckedby() {
		return checkedby;
	}

	public void setCheckedby(String checkedby) {
		this.checkedby = checkedby;
	}

	public Date getChecktime() {
		return checktime;
	}

	public void setChecktime(Date checktime) {
		this.checktime = checktime;
	}

	public String getCheckedip() {
		return checkedip;
	}

	public void setCheckedip(String checkedip) {
		this.checkedip = checkedip;
	}

	public String getCheckedbycode() {
		return checkedbycode;
	}

	public void setCheckedbycode(String checkedbycode) {
		this.checkedbycode = checkedbycode;
	}

	public String getChecktype() {
		return checktype;
	}

	public void setChecktype(String checktype) {
		this.checktype = checktype;
	}

	public String getOperationtype() {
		return operationtype;
	}

	public void setOperationtype(String operationtype) {
		this.operationtype = operationtype;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getCertificatetype() {
		return certificatetype;
	}

	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}
}
