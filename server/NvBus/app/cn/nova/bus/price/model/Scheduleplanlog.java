package cn.nova.bus.price.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the SCHEDULEPLANLOG database table.
 * 
 */
@Entity
public class Scheduleplanlog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SCHEDULEPLANLOG_ID_GENERATOR", sequenceName="SEQ_SCHEDULEPLANLOG",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SCHEDULEPLANLOG_ID_GENERATOR")
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date enddate;

	private String ip;

	private String operationtype;

	private Long orgid;

	private String result;

    @Temporal( TemporalType.DATE)
	private Date startdate;

	private String type;

	private Long typeid;

	private Long userid;
	
	@Transient
	private String scheduleids;
	
	@Transient
	private Long departstationid;
	
	@Transient
	private boolean isautogen;
	
	public boolean getIsautogen() {
		return isautogen;
	}

	public void setIsautogen(boolean isautogen) {
		this.isautogen = isautogen;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	public String getScheduleids() {
		return scheduleids;
	}

	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}
	
    public Scheduleplanlog() {
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

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getOperationtype() {
		return this.operationtype;
	}

	public void setOperationtype(String operationtype) {
		this.operationtype = operationtype;
	}

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getResult() {
		return this.result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Long typeid) {
		this.typeid = typeid;
	}

	public Long getUserid() {
		return this.userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

}