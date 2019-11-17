package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;



/**
 * The persistent class for the TICKETTURNOVEROTHER database table.
 * 手工单缴款
 */
@Entity
@Table(name="TICKETTURNOVEROTHER")
public class TicketTurnOverOther implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "TICKETTURNOVEROTHER_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETTURNOVEROTHER_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date tickettime;

	private long seller;

	private double money;
	
	private String remarks;
	
	private long orgid;
	
    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
	
	private long updateby;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getTickettime() {
		return tickettime;
	}

	public void setTickettime(Date tickettime) {
		this.tickettime = tickettime;
	}

	public long getSeller() {
		return seller;
	}

	public void setSeller(long seller) {
		this.seller = seller;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}
	
	
	
}
