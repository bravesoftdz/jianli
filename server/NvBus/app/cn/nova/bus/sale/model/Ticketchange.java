package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the TICKETCHANGE database table.
 * 
 */
@Entity
@Table(name="TICKETCHANGE")
public class Ticketchange implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETCHANGE_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETCHANGE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private Long changeby;

	@Column(nullable=false, length=40)
	private String changeip;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date changetime;

	@Column(nullable=false, precision=10)
	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date newdepartdate;

	@Column(nullable=false, precision=10)
	private Long newscheduleid;

	@Column(nullable=false, precision=4)
	private short newseatno;

	@Column(nullable=false, length=20)
	private String newticketno;

	@Column(nullable=false, precision=10)
	private long newticketsellid;

    @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date olddepartdate;

	@Column(nullable=false, precision=10)
	private Long oldscheduleid;

	@Column(nullable=false, precision=4)
	private short oldseatno;

	@Column(nullable=false, length=20)
	private String oldticketno;

	@Column(nullable=false, precision=10)
	private Long oldticketsellid;

	@Column(length=255)
	private String remarks;

	@Column(nullable=false, precision=10)
	private Long ticketoutletsid;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;
    
    private String changeticketno;
    public Ticketchange() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getChangeby() {
		return this.changeby;
	}

	public void setChangeby(Long changeby) {
		this.changeby = changeby;
	}

	public String getChangeip() {
		return this.changeip;
	}

	public void setChangeip(String changeip) {
		this.changeip = changeip;
	}

	public Date getChangetime() {
		return this.changetime;
	}

	public void setChangetime(Date changetime) {
		this.changetime = changetime;
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

	public Date getNewdepartdate() {
		return this.newdepartdate;
	}

	public void setNewdepartdate(Date newdepartdate) {
		this.newdepartdate = newdepartdate;
	}

	public Long getNewscheduleid() {
		return this.newscheduleid;
	}

	public void setNewscheduleid(Long newscheduleid) {
		this.newscheduleid = newscheduleid;
	}

	public short getNewseatno() {
		return this.newseatno;
	}

	public void setNewseatno(short newseatno) {
		this.newseatno = newseatno;
	}

	public String getNewticketno() {
		return this.newticketno;
	}

	public void setNewticketno(String newticketno) {
		this.newticketno = newticketno;
	}

	public Long getNewticketsellid() {
		return this.newticketsellid;
	}

	public void setNewticketsellid(Long newticketsellid) {
		this.newticketsellid = newticketsellid;
	}

	public Date getOlddepartdate() {
		return this.olddepartdate;
	}

	public void setOlddepartdate(Date olddepartdate) {
		this.olddepartdate = olddepartdate;
	}

	public Long getOldscheduleid() {
		return this.oldscheduleid;
	}

	public void setOldscheduleid(Long oldscheduleid) {
		this.oldscheduleid = oldscheduleid;
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

	public Long getOldticketsellid() {
		return this.oldticketsellid;
	}

	public void setOldticketsellid(Long oldticketsellid) {
		this.oldticketsellid = oldticketsellid;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Long getTicketoutletsid() {
		return this.ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
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

	public String getChangeticketno() {
		return changeticketno;
	}

	public void setChangeticketno(String changeticketno) {
		this.changeticketno = changeticketno;
	}
	
}