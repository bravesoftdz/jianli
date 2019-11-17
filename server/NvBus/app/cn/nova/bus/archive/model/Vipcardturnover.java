package cn.nova.bus.archive.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the VIPCARDTURNOVER database table.
 * 
 */
@Entity
public class Vipcardturnover implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VIPCARDTURNOVER_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPCARDTURNOVER_ID_GENERATOR")
	private long id;

	private BigDecimal cardcost;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private long issuenum;

	private BigDecimal lastlost;

	private BigDecimal lost;

	@Column(name="\"MONEY\"")
	private BigDecimal money;

	private BigDecimal moneypayable;

	private long rechargecount;

	private BigDecimal rechargemoney;

	private String remark;

	private BigDecimal returncardcost;

	private BigDecimal returnmoney;

	private long returnnum;

	private long sellerid;

    @Temporal( TemporalType.TIMESTAMP)
	private Date turnoverdate;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Vipcardturnover() {
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

	public long getIssuenum() {
		return this.issuenum;
	}

	public void setIssuenum(long issuenum) {
		this.issuenum = issuenum;
	}

	public BigDecimal getLastlost() {
		return this.lastlost;
	}

	public void setLastlost(BigDecimal lastlost) {
		this.lastlost = lastlost;
	}

	public BigDecimal getLost() {
		return this.lost;
	}

	public void setLost(BigDecimal lost) {
		this.lost = lost;
	}

	public BigDecimal getMoney() {
		return this.money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getMoneypayable() {
		return this.moneypayable;
	}

	public void setMoneypayable(BigDecimal moneypayable) {
		this.moneypayable = moneypayable;
	}

	public long getRechargecount() {
		return this.rechargecount;
	}

	public void setRechargecount(long rechargecount) {
		this.rechargecount = rechargecount;
	}

	public BigDecimal getRechargemoney() {
		return this.rechargemoney;
	}

	public void setRechargemoney(BigDecimal rechargemoney) {
		this.rechargemoney = rechargemoney;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public BigDecimal getReturncardcost() {
		return this.returncardcost;
	}

	public void setReturncardcost(BigDecimal returncardcost) {
		this.returncardcost = returncardcost;
	}

	public BigDecimal getReturnmoney() {
		return this.returnmoney;
	}

	public void setReturnmoney(BigDecimal returnmoney) {
		this.returnmoney = returnmoney;
	}

	public long getReturnnum() {
		return this.returnnum;
	}

	public void setReturnnum(long returnnum) {
		this.returnnum = returnnum;
	}

	public long getSellerid() {
		return this.sellerid;
	}

	public void setSellerid(long sellerid) {
		this.sellerid = sellerid;
	}

	public Date getTurnoverdate() {
		return this.turnoverdate;
	}

	public void setTurnoverdate(Date turnoverdate) {
		this.turnoverdate = turnoverdate;
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

}