package cn.nova.bus.sale.model;

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
 * 混检改签表
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "TICKETMIXCHANGE")
public class TicketMixChange {

	@Id
	@SequenceGenerator(name = "TICKETMIXCHANGE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETMIXCHANGE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private String ticketno;// 票号
	private long scheduleplanid;// 新班次计划
	private long sellid;// 新票id
	private String seatno;//
	private String oldticketno;// 票号
	private long oldsellid;// 新票id
	private String oldseatno;//
	
	private String remark;//
	private long checkby;// 售票人
	private String checkip;// 售票ip
	@Temporal(TemporalType.TIMESTAMP)
	private Date checktime;// 检票时间
	private long createby;// 创建人
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// 创建时间

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public long getSellid() {
		return sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public String getSeatno() {
		return seatno;
	}

	public void setSeatno(String seatno) {
		this.seatno = seatno;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public long getCheckby() {
		return checkby;
	}

	public void setCheckby(long checkby) {
		this.checkby = checkby;
	}

	public String getCheckip() {
		return checkip;
	}

	public void setCheckip(String checkip) {
		this.checkip = checkip;
	}

	public Date getChecktime() {
		return checktime;
	}

	public void setChecktime(Date checktime) {
		this.checktime = checktime;
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

	public String getOldticketno() {
		return oldticketno;
	}

	public void setOldticketno(String oldticketno) {
		this.oldticketno = oldticketno;
	}

	public long getOldsellid() {
		return oldsellid;
	}

	public void setOldsellid(long oldsellid) {
		this.oldsellid = oldsellid;
	}

	public String getOldseatno() {
		return oldseatno;
	}

	public void setOldseatno(String oldseatno) {
		this.oldseatno = oldseatno;
	}

	
	
}
