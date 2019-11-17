package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the TICKETMIXCHECK database table.
 * 
 */
@Entity
public class Ticketmixcheck implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETMIXC_ID_GENERATOR", sequenceName="SEQ_TICKETSELL", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETMIXC_ID_GENERATOR")
	private long id;

	private short actualvehicleseatnum;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date newdepartdate;

	private String newdeparttime;

	private long newscheduleid;

	private short newseatno;

    @Temporal( TemporalType.DATE)
	private Date olddepartdate;

	private String olddeparttime;

	private long oldscheduleid;

	private long oldscheduleplanid;

	private short oldseatno;

	private String oldticketno;

	private long orgid;

	private long scheduleplanid;

	private String ticketno;

	private long ticketsellid;

	private String type;

	private boolean isactive;
	
	private long updateby;


	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	
	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	
    public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Ticketmixcheck() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public short getActualvehicleseatnum() {
		return this.actualvehicleseatnum;
	}

	public void setActualvehicleseatnum(short actualvehicleseatnum) {
		this.actualvehicleseatnum = actualvehicleseatnum;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getNewdepartdate() {
		return this.newdepartdate;
	}

	public void setNewdepartdate(Date newdepartdate) {
		this.newdepartdate = newdepartdate;
	}

	public String getNewdeparttime() {
		return this.newdeparttime;
	}

	public void setNewdeparttime(String newdeparttime) {
		this.newdeparttime = newdeparttime;
	}

	public long getNewscheduleid() {
		return this.newscheduleid;
	}

	public void setNewscheduleid(long newscheduleid) {
		this.newscheduleid = newscheduleid;
	}

	public short getNewseatno() {
		return this.newseatno;
	}

	public void setNewseatno(short newseatno) {
		this.newseatno = newseatno;
	}

	public Date getOlddepartdate() {
		return this.olddepartdate;
	}

	public void setOlddepartdate(Date olddepartdate) {
		this.olddepartdate = olddepartdate;
	}

	public String getOlddeparttime() {
		return this.olddeparttime;
	}

	public void setOlddeparttime(String olddeparttime) {
		this.olddeparttime = olddeparttime;
	}

	public long getOldscheduleid() {
		return this.oldscheduleid;
	}

	public void setOldscheduleid(long oldscheduleid) {
		this.oldscheduleid = oldscheduleid;
	}

	public long getOldscheduleplanid() {
		return this.oldscheduleplanid;
	}

	public void setOldscheduleplanid(long oldscheduleplanid) {
		this.oldscheduleplanid = oldscheduleplanid;
	}

	public short getOldseatno() {
		return this.oldseatno;
	}

	public void setOldseatno(short oldseatno) {
		this.oldseatno = oldseatno;
	}

	public String getOldticketno() {
		return this.oldticketno;
	}

	public void setOldticketno(String oldticketno) {
		this.oldticketno = oldticketno;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getScheduleplanid() {
		return this.scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getTicketno() {
		return this.ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public long getTicketsellid() {
		return this.ticketsellid;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}