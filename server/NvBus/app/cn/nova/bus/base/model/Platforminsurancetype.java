package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners({ SyncCodeGenerate.class })
public class Platforminsurancetype implements Serializable{

	@Id
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;
	
	@Column(nullable = false)
	private String insurecompanycode;
	
	@Column(nullable = false)
	private String insurecompanyname;
	
	private String varcode;
	private String varname;
	private String productcode;
	
	@Column(nullable = false)
	private Integer insuretype;
	private String explanation;
	
	@Column(nullable = false)
	private BigDecimal premium;
	
	@Column(nullable = false)
	private BigDecimal dieinsureamount;
	
	@Column(nullable = false)
	private BigDecimal medicalinsureamount;
	
	
	
	
	@Column(nullable = false)
	private Long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	
	@Column(nullable = false)
	private Long createby;
	
	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getInsurecompanycode() {
		return insurecompanycode;
	}

	public void setInsurecompanycode(String insurecompanycode) {
		this.insurecompanycode = insurecompanycode;
	}

	public String getInsurecompanyname() {
		return insurecompanyname;
	}

	public void setInsurecompanyname(String insurecompanyname) {
		this.insurecompanyname = insurecompanyname;
	}

	public String getVarcode() {
		return varcode;
	}

	public void setVarcode(String varcode) {
		this.varcode = varcode;
	}

	public String getVarname() {
		return varname;
	}

	public void setVarname(String varname) {
		this.varname = varname;
	}

	public String getProductcode() {
		return productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public Integer getInsuretype() {
		return insuretype;
	}

	public void setInsuretype(Integer insuretype) {
		this.insuretype = insuretype;
	}

	public String getExplanation() {
		return explanation;
	}

	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}

	public BigDecimal getPremium() {
		return premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public BigDecimal getDieinsureamount() {
		return dieinsureamount;
	}

	public void setDieinsureamount(BigDecimal dieinsureamount) {
		this.dieinsureamount = dieinsureamount;
	}

	public BigDecimal getMedicalinsureamount() {
		return medicalinsureamount;
	}

	public void setMedicalinsureamount(BigDecimal medicalinsureamount) {
		this.medicalinsureamount = medicalinsureamount;
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

}
