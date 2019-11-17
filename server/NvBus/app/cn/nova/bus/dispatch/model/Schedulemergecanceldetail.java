package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the SCHEDULEMERGECANCELDETAIL database table.
 * 并班取消车票明细
 */
@Entity
public class Schedulemergecanceldetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULEMERGECANCELDETAIL_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEMERGECANCELDETAIL_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private short newseatno;

	private short oldseatno;

	private Long schedulemergecancelid;

	private Long ticketsellid;

	public Schedulemergecanceldetail() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public short getNewseatno() {
		return newseatno;
	}

	public void setNewseatno(short newseatno) {
		this.newseatno = newseatno;
	}

	public short getOldseatno() {
		return oldseatno;
	}

	public void setOldseatno(short oldseatno) {
		this.oldseatno = oldseatno;
	}

	public Long getSchedulemergecancelid() {
		return schedulemergecancelid;
	}

	public void setSchedulemergecancelid(Long schedulemergecancelid) {
		this.schedulemergecancelid = schedulemergecancelid;
	}

	public Long getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(Long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

}