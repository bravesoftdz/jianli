package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the VIPCARDRETURN database table.
 * 
 */
@Entity
@Table(name = "VIPCARDRETURN")
@EntityListeners({ SyncCodeGenerate.class })
public class Vipcardreturn implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VIPCARDRETURN_ID_GENERATOR", sequenceName = "SEQ_PUB")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIPCARDRETURN_ID_GENERATOR")
	private long id;

	private BigDecimal cardcost;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isturnover;

	private BigDecimal remainmoney;

	private String remarks;

	private long returnby;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Temporal(TemporalType.TIMESTAMP)
	private Date returntime;

	private Long turnoverid;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long vipid;

	public Vipcardreturn() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getCardcost() {
		return this.cardcost;
	}

	public void setCardcost(BigDecimal cardcost) {
		this.cardcost = cardcost;
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

	public boolean getIsturnover() {
		return this.isturnover;
	}

	public void setIsturnover(boolean isturnover) {
		this.isturnover = isturnover;
	}

	public BigDecimal getRemainmoney() {
		return this.remainmoney;
	}

	public void setRemainmoney(BigDecimal remainmoney) {
		this.remainmoney = remainmoney;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public long getReturnby() {
		return this.returnby;
	}

	public void setReturnby(long returnby) {
		this.returnby = returnby;
	}

	public Date getReturntime() {
		return this.returntime;
	}

	public void setReturntime(Date returntime) {
		this.returntime = returntime;
	}

	public Long getTurnoverid() {
		return this.turnoverid;
	}

	public void setTurnoverid(Long turnoverid) {
		this.turnoverid = turnoverid;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getVipid() {
		return this.vipid;
	}

	public void setVipid(long vipid) {
		this.vipid = vipid;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

}