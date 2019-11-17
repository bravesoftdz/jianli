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
public class Packpickup implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "PACKPICKUP_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKPICKUP_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id;//	NUMBER(10)	N			
	private long packid;//	number(10)	y			行包id
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal shipprice;//	number(6,2)	y			保管费
	@Column(nullable = false, precision = 8, scale = 2)
	private BigDecimal goodsprice;//	number(8,2)	y			货款
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal handfee;//	number(6,2)	y			装卸费
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal packfee;//	number(6,2)	y			提付费用
	@Column(nullable = false, precision = 6, scale = 2)
	private BigDecimal penalty;//	number(6,2)	y			滞纳金
	@Column(nullable = false, precision = 8, scale = 2)
	private BigDecimal totalfee;//	number(8,2)	y			合计金额
	@Column(nullable = false, precision = 6, scale = 2)
	private String signaturer;//	varchar2(30)	y			提领人
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date signdate;//	date	y			提领日期
	private long operator;//	number(10)	y			办理员
	private String remak;//	varchar2(150)	y			备注
	private long orgid;//	number(10)	y			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;//	date	n	sysdate		
	private long createby;//	number(10)	n			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;//	date	n	sysdate		
	private long updateby;//	number(10)	n
	
	private String  takecertificateno;
	
	
	public String getTakecertificateno() {
		return takecertificateno;
	}

	public void setTakecertificateno(String takecertificateno) {
		this.takecertificateno = takecertificateno;
	}

	public Packpickup() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getPackid() {
		return packid;
	}

	public void setPackid(long packid) {
		this.packid = packid;
	}

	public BigDecimal getShipprice() {
		return shipprice;
	}

	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}

	public BigDecimal getGoodsprice() {
		return goodsprice;
	}

	public void setGoodsprice(BigDecimal goodsprice) {
		this.goodsprice = goodsprice;
	}

	public BigDecimal getHandfee() {
		return handfee;
	}

	public void setHandfee(BigDecimal handfee) {
		this.handfee = handfee;
	}

	public BigDecimal getPackfee() {
		return packfee;
	}

	public void setPackfee(BigDecimal packfee) {
		this.packfee = packfee;
	}

	public BigDecimal getPenalty() {
		return penalty;
	}

	public void setPenalty(BigDecimal penalty) {
		this.penalty = penalty;
	}

	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}

	public String getSignaturer() {
		return signaturer;
	}

	public void setSignaturer(String signaturer) {
		this.signaturer = signaturer;
	}

	public Date getSigndate() {
		return signdate;
	}

	public void setSigndate(Date signdate) {
		this.signdate = signdate;
	}

	public long getOperator() {
		return operator;
	}

	public void setOperator(long operator) {
		this.operator = operator;
	}

	public String getRemak() {
		return remak;
	}

	public void setRemak(String remak) {
		this.remak = remak;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	
}
