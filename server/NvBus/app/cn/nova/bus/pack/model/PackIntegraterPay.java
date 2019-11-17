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
public class PackIntegraterPay  implements Serializable{
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "PACKINTEGRATERPAY_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKINTEGRATERPAY_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	private long packid;
	private long clientid;
	private long orgid;
	private long integrater; 
	private BigDecimal price;
	
	@Temporal(TemporalType.DATE)
	private Date paydate;// date n sys;//date
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n sys;//date	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n sys;//date

	@Column(nullable = false)
	private Long createby;// number(10) n
	@Column(nullable = false)
	private Long updateby;// number(10) n
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
	public long getClientid() {
		return clientid;
	}
	public void setClientid(long clientid) {
		this.clientid = clientid;
	}
	public long getOrgid() {
		return orgid;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	public long getIntegrater() {
		return integrater;
	}
	public void setIntegrater(long integrater) {
		this.integrater = integrater;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public Date getPaydate() {
		return paydate;
	}
	public void setPaydate(Date paydate) {
		this.paydate = paydate;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
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
	public Long getUpdateby() {
		return updateby;
	}
	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}
	
	
	
	
}
