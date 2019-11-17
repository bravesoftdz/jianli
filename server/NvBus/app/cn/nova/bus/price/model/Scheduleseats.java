package cn.nova.bus.price.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the SCHEDULESEATS database table.
 * 
 */
@Entity
@Table(name="SCHEDULESEATS")
public class Scheduleseats implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SCHEDULESEATS_ID_GENERATOR", sequenceName="SEQ_SCHEDULESEATS",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SCHEDULESEATS_ID_GENERATOR")
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date departdate;

	private Long orgid;

	private Long scheduleid;

	private short seatno;

	private String seattype;

	private String status;

	private String tickettype;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	@JoinColumn(name = "SCHEDULEPLANID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH,CascadeType.PERSIST})
	private Scheduleplan scheduleplan;   
    
    
    public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}

	public Scheduleseats() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}


	public short getSeatno() {
		return this.seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

	public String getSeattype() {
		return this.seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTickettype() {
		return this.tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
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

}