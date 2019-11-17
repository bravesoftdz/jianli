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
 * The persistent class for the VIPRECHARGE database table.
 * 
 */
@Entity
@Table(name = "VIPRECHARGE")
@EntityListeners({ SyncCodeGenerate.class })
public class Viprecharge implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2120691613485297817L;

	@Id
	@SequenceGenerator(name = "VIPRECHARGE_ID_GENERATOR", sequenceName = "SEQ_PUB")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIPRECHARGE_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isturnover;

	// @Column(name = "\"MONEY\"")
	private BigDecimal money;

	private long rechargeby;

	private Long rechargepromotionactivityid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date rechargetime;

	private Long turnoverid;

	@Column(nullable = false, length = 40)
	private String synccode;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long vipid;

	public Viprecharge() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public BigDecimal getMoney() {
		return this.money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public long getRechargeby() {
		return this.rechargeby;
	}

	public void setRechargeby(long rechargeby) {
		this.rechargeby = rechargeby;
	}

	public Long getRechargepromotionactivityid() {
		return this.rechargepromotionactivityid;
	}

	public void setRechargepromotionactivityid(Long rechargepromotionactivityid) {
		this.rechargepromotionactivityid = rechargepromotionactivityid;
	}

	public Date getRechargetime() {
		return this.rechargetime;
	}

	public void setRechargetime(Date rechargetime) {
		this.rechargetime = rechargetime;
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