package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners({ SyncCodeGenerate.class })
public class Insuretype implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "INSURETYPE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INSURETYPE_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@Column(nullable = false)
	private String code;

	@Column(nullable = false)
	private Long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String description;

	@Column(nullable = false)
	private BigDecimal dividedrate;

	@Column(nullable = false)
	private Long insurersid;

	@Column(nullable = false)
	private BigDecimal maxinsureamount;

	@Column(nullable = false)
	private String name;

	@Column(nullable = false)
	private Long orgid;

	@Column(nullable = false)
	private BigDecimal premium;

	@Column(nullable = false)
	private Long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, length = 40)
	private String synccode;

	// bi-directional many-to-one association to Insuretypedetail
	@OneToMany(mappedBy = "insuretype")
	private Set<Insuretypedetail> insuretypedetails;
	
	@Column()
	private BigDecimal ywmoney; //意外医疗费用
	
	@Column()
	private BigDecimal shmoney; //意外伤害费用
	
	@Column()
	private BigDecimal emoney; //意外伤害保险金额
	
	@Column()
	private BigDecimal emmoney; //意外伤害医疗保险金额
	
	
	public Insuretype() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getDividedrate() {
		return dividedrate;
	}

	public void setDividedrate(BigDecimal dividedrate) {
		this.dividedrate = dividedrate;
	}

	public Long getInsurersid() {
		return insurersid;
	}

	public void setInsurersid(Long insurersid) {
		this.insurersid = insurersid;
	}

	public BigDecimal getMaxinsureamount() {
		return maxinsureamount;
	}

	public void setMaxinsureamount(BigDecimal maxinsureamount) {
		this.maxinsureamount = maxinsureamount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getPremium() {
		return premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Set<Insuretypedetail> getInsuretypedetails() {
		return insuretypedetails;
	}

	public void setInsuretypedetails(Set<Insuretypedetail> insuretypedetails) {
		this.insuretypedetails = insuretypedetails;
	}

	public BigDecimal getYwmoney() {
		return ywmoney;
	}

	public void setYwmoney(BigDecimal ywmoney) {
		this.ywmoney = ywmoney;
	}

	public BigDecimal getShmoney() {
		return shmoney;
	}

	public void setShmoney(BigDecimal shmoney) {
		this.shmoney = shmoney;
	}

	public BigDecimal getEmoney() {
		return emoney;
	}

	public void setEmoney(BigDecimal emoney) {
		this.emoney = emoney;
	}

	public BigDecimal getEmmoney() {
		return emmoney;
	}

	public void setEmmoney(BigDecimal emmoney) {
		this.emmoney = emmoney;
	}
}