package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners({ SyncCodeGenerate.class })
public class Platforminsureorder implements Serializable{ 

	@Id
	@SequenceGenerator(name = "INSUREORDER_ID_GENERATOR", sequenceName = "SEQ_INSUREORDER", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INSUREORDER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	
	@Column(length = 50)
	private String orderno;
	
	private String insuranceno;
	
	@Column(nullable = false, precision = 3)
	private Integer status;
	
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
	
	@Column(nullable = false)
	private Integer issuingtype;
	
	@Column(length = 50)
	private String sellorgcode;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
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

	public String getInsuranceno() {
		return insuranceno;
	}

	public void setInsuranceno(String insuranceno) {
		this.insuranceno = insuranceno;
	}

	public Integer getIssuingtype() {
		return issuingtype;
	}

	public void setIssuingtype(Integer issuingtype) {
		this.issuingtype = issuingtype;
	}

	public String getSellorgcode() {
		return sellorgcode;
	}

	public void setSellorgcode(String sellorgcode) {
		this.sellorgcode = sellorgcode;
	}
	
}
