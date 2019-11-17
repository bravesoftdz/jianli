package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the VIPCONSUME database table.
 * 
 */
@Entity
@Table(name = "VIPCONSUME")
@EntityListeners({ SyncCodeGenerate.class })
public class Vipconsume implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VIPCONSUME_ID_GENERATOR", sequenceName = "SEQ_PUB")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIPCONSUME_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal moneychange;

	private BigDecimal pointchange;

	private BigDecimal remainmoney;

	private BigDecimal remainpoint;

	@Column(name = "\"TYPE\"")
	private String type;

	private String vipcardno;

	private String vipgrade;

	@Column(nullable = false, precision = 10)
	private long vipid;

	@Column(nullable = false, length = 40)
	private String synccode;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	// bi-directional many-to-one association to Vipconsumeldetail
	@OneToMany(mappedBy = "vipconsume", cascade = CascadeType.ALL)
	private List<Vipconsumeldetail> vipconsumeldetails;

	public Vipconsume() {
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

	public BigDecimal getMoneychange() {
		return this.moneychange;
	}

	public void setMoneychange(BigDecimal moneychange) {
		this.moneychange = moneychange;
	}

	public BigDecimal getPointchange() {
		return this.pointchange;
	}

	public void setPointchange(BigDecimal pointchange) {
		this.pointchange = pointchange;
	}

	public BigDecimal getRemainmoney() {
		return this.remainmoney;
	}

	public void setRemainmoney(BigDecimal remainmoney) {
		this.remainmoney = remainmoney;
	}

	public BigDecimal getRemainpoint() {
		return this.remainpoint;
	}

	public void setRemainpoint(BigDecimal remainpoint) {
		this.remainpoint = remainpoint;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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

	public long getVipid() {
		return this.vipid;
	}

	public void setVipid(long vipid) {
		this.vipid = vipid;
	}

	public List<Vipconsumeldetail> getVipconsumeldetails() {
		return this.vipconsumeldetails;
	}

	public void setVipconsumeldetails(List<Vipconsumeldetail> vipconsumeldetails) {
		this.vipconsumeldetails = vipconsumeldetails;
	}

	public long getUpdateby() {
		return updateby;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
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

}