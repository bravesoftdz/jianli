package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Packfee implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACKFEE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKFEE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	private int fromdistance;
	private int todistance;
	
	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal fromweight;
	
	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal toweight;
	
	@Column(nullable=false, precision=6, scale=2)
	private BigDecimal fee;
	
	@Column(nullable=false, precision=6, scale=2)
	private BigDecimal feekg;
	
	private Long orgid;
	
	private Long createby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	
	private Long updateby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	
	private long packfeetypeid;
	

	public Packfee() {
		// TODO Auto-generated constructor stub
	}

	
	public long getPackfeetypeid() {
		return packfeetypeid;
	}


	public void setPackfeetypeid(long packfeetypeid) {
		this.packfeetypeid = packfeetypeid;
	}


	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getFromdistance() {
		return fromdistance;
	}

	public void setFromdistance(int fromdistance) {
		this.fromdistance = fromdistance;
	}

	public int getTodistance() {
		return todistance;
	}

	public void setTodistance(int todistance) {
		this.todistance = todistance;
	}

	public BigDecimal getFromweight() {
		return fromweight;
	}

	public void setFromweight(BigDecimal fromweight) {
		this.fromweight = fromweight;
	}

	public BigDecimal getToweight() {
		return toweight;
	}

	public void setToweight(BigDecimal toweight) {
		this.toweight = toweight;
	}

	public BigDecimal getFee() {
		return fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	public BigDecimal getFeekg() {
		return feekg;
	}

	public void setFeekg(BigDecimal feekg) {
		this.feekg = feekg;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
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
	
}
