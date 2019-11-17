package cn.nova.bus.insure.vo;

import java.io.Serializable;
import java.math.BigDecimal;

public class InsuranceInfoVO implements Serializable{ 

	private Long id;
	private String insurecompanycode;
	private String insurecompanyname;
	private String varcode;
	private String varname;
	private String productcode;
	private Integer insuretype;
	private String explanation;
	private BigDecimal premium;
	private BigDecimal dieinsureamount;
	private BigDecimal medicalinsureamount;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
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
}
