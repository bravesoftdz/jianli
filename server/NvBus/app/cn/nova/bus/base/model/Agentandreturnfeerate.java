package cn.nova.bus.base.model;

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

import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Agentandreturnfeerate<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@Entity
@Table(name = "AGENTANDRETURNFEERATE")
@EntityListeners(SyncCodeGenerate.class)
public class Agentandreturnfeerate implements Serializable {
	private static final long serialVersionUID = 2391390965932257383L;

	@Id
	@SequenceGenerator(name = "AGENTANDRETURNFEERATE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "AGENTANDRETURNFEERATE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, precision = 15, scale = 3)
	private BigDecimal agentfeerate;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = true, precision = 10)
	private Long departorgid;

	@Column(nullable = false, precision = 15, scale = 3)
	private BigDecimal departreturnrate;

	@Column(nullable = false, precision = 15, scale = 3)
	private BigDecimal insuranceagentfeerate;

	@Column(nullable = true, precision = 10)
	private Long sellorgid;

	@Column(nullable = false, precision = 15, scale = 3)
	private BigDecimal sellreturnrate;

	@Column(precision = 10, nullable = false)
	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Column(nullable = false, precision = 100)
	private String sellorgincomeformula;

	public Agentandreturnfeerate() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAgentfeerate() {
		return this.agentfeerate;
	}

	public void setAgentfeerate(BigDecimal agentfeerate) {
		this.agentfeerate = agentfeerate;
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

	public Long getDepartorgid() {
		return this.departorgid;
	}

	public void setDepartorgid(Long departorgid) {
		this.departorgid = departorgid;
	}

	public BigDecimal getDepartreturnrate() {
		return this.departreturnrate;
	}

	public void setDepartreturnrate(BigDecimal departreturnrate) {
		this.departreturnrate = departreturnrate;
	}

	public BigDecimal getInsuranceagentfeerate() {
		return this.insuranceagentfeerate;
	}

	public void setInsuranceagentfeerate(BigDecimal insuranceagentfeerate) {
		this.insuranceagentfeerate = insuranceagentfeerate;
	}

	public Long getSellorgid() {
		return this.sellorgid;
	}

	public void setSellorgid(Long sellorgid) {
		this.sellorgid = sellorgid;
	}

	public BigDecimal getSellreturnrate() {
		return this.sellreturnrate;
	}

	public void setSellreturnrate(BigDecimal sellreturnrate) {
		this.sellreturnrate = sellreturnrate;
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

	public String getSellorgincomeformula() {
		return sellorgincomeformula;
	}

	public void setSellorgincomeformula(String sellorgincomeformula) {
		this.sellorgincomeformula = sellorgincomeformula;
	}
}