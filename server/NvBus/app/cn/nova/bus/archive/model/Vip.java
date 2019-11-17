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

@Entity
@Table(name = "VIP")
@EntityListeners({ SyncCodeGenerate.class })
public class Vip implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7532533636776158856L;

	@Id
	@SequenceGenerator(name = "VIP_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIP_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(nullable = false, precision = 10)
	private long customerid;

	@Column(nullable = false)
	private BigDecimal cardcost;

	@Column(nullable = false)
	private Long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	private boolean isactive;

	@Column(nullable = false)
	private Long issueby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date issuedate;

	@Column(nullable = false, precision = 10)
	private Long issueorgid;

	@Column(nullable = false)
	private String issuereason;

	@Column(nullable = false)
	private Long issueticketoutletsid;

	@Column(nullable = false)
	private boolean isturnover;

	@Column(nullable = false)
	private BigDecimal money;

	@Column(nullable = true)
	private String remarks;

	@Column(nullable = false)
	private String serialnumber;

	@Column(nullable = false)
	private String status;

	@Column(nullable = true)
	private String ticketno;

	@Column(nullable = true)
	private Long turnoverid;

	@Column(nullable = false)
	private Long updateby;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date validdate;

	@Column(nullable = false)
	private BigDecimal vipamount;

	@Column(nullable = false)
	private String vipcardno;

	@Column(nullable = false)
	private String vipgrade;

	@Column(nullable = false)
	private String vipgradefirst;

	public Vip() {
	}

	public long getCustomerid() {
		return this.customerid;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public BigDecimal getCardcost() {
		return this.cardcost;
	}

	public void setCardcost(BigDecimal cardcost) {
		this.cardcost = cardcost;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Date getValiddate() {
		return this.validdate;
	}

	public void setValiddate(Date validdate) {
		this.validdate = validdate;
	}

	public BigDecimal getVipamount() {
		return this.vipamount;
	}

	public void setVipamount(BigDecimal vipamount) {
		this.vipamount = vipamount;
	}

	public String getVipcardno() {
		return this.vipcardno;
	}

	public void setVipcardno(String vipcardno) {
		this.vipcardno = vipcardno;
	}

	public String getVipgrade() {
		return this.vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

	public String getVipgradefirst() {
		return this.vipgradefirst;
	}

	public void setVipgradefirst(String vipgradefirst) {
		this.vipgradefirst = vipgradefirst;
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

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Long getIssueby() {
		return issueby;
	}

	public void setIssueby(Long issueby) {
		this.issueby = issueby;
	}

	public Date getIssuedate() {
		return issuedate;
	}

	public void setIssuedate(Date issuedate) {
		this.issuedate = issuedate;
	}

	public Long getIssueorgid() {
		return issueorgid;
	}

	public void setIssueorgid(Long issueorgid) {
		this.issueorgid = issueorgid;
	}

	public String getIssuereason() {
		return issuereason;
	}

	public void setIssuereason(String issuereason) {
		this.issuereason = issuereason;
	}

	public Long getIssueticketoutletsid() {
		return issueticketoutletsid;
	}

	public void setIssueticketoutletsid(Long issueticketoutletsid) {
		this.issueticketoutletsid = issueticketoutletsid;
	}

	public boolean isIsturnover() {
		return isturnover;
	}

	public void setIsturnover(boolean isturnover) {
		this.isturnover = isturnover;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public Long getTurnoverid() {
		return turnoverid;
	}

	public void setTurnoverid(Long turnoverid) {
		this.turnoverid = turnoverid;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}
}