package cn.nova.bus.price.model;

import java.io.Serializable;
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

import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners({ SyncCodeGenerate.class })
public class Ticketoutletstypeprice implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public Ticketoutletstypeprice() {
		
	}
	
	public Ticketoutletstypeprice(long userid,Date date) {
		this.createby = userid;
		this.updateby = userid;
		this.createtime = date;
		this.updatetime = date;
	}

	@Id
	@SequenceGenerator(name = "TICKETOUTLETSTYPEPRICE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETOUTLETSTYPEPRICE_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(nullable = false)
	private long ticketoutletsid;
	
	@Column(nullable = false)
	private long routeid;
	
	@Column(nullable = false)
	private long scheduleid;

	@Column(nullable = false)
	private long createby;
	
	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	
	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date startdate;
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date enddate;

	@Column(nullable = false)
	private String fullpriceformula;

	@Column(nullable = false)
	private String halfpriceformula;

	@Column(nullable = false)
	private String studentpriceformula;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

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

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getFullpriceformula() {
		return fullpriceformula;
	}

	public void setFullpriceformula(String fullpriceformula) {
		this.fullpriceformula = fullpriceformula;
	}

	public String getHalfpriceformula() {
		return halfpriceformula;
	}

	public void setHalfpriceformula(String halfpriceformula) {
		this.halfpriceformula = halfpriceformula;
	}

	public String getStudentpriceformula() {
		return studentpriceformula;
	}

	public void setStudentpriceformula(String studentpriceformula) {
		this.studentpriceformula = studentpriceformula;
	}

	
}