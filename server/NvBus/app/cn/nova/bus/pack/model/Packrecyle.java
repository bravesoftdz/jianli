package cn.nova.bus.pack.model;

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
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "PACKRECYLE")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Packrecyle implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACK_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACK_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id;// ;//number(10) n
    
	private long packid;
	
	private Long packtturnoverid;// number(10) y 缴款id
	
	private Long recycleby;
	
	private Long  tostationid ;
	
	private Date recyletime; 
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal shipprice;// number(6,2) y 保管费
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal packprice;// number(6,2) y 保管费
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal servicefee;// number(6,2) y 保管费
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal totalfee;// number(6,2) y 保管费
	
	private long orgid;// number(10) y
	
	private Long createby;
	
	private Date createtime;
	
	private Long updateby;
	
	private Date updatetime;

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

	public Long getPacktturnoverid() {
		return packtturnoverid;
	}

	public void setPacktturnoverid(Long packtturnoverid) {
		this.packtturnoverid = packtturnoverid;
	}

	public Long getRecycleby() {
		return recycleby;
	}

	public void setRecycleby(Long recycleby) {
		this.recycleby = recycleby;
	}



	public Date getRecyletime() {
		return recyletime;
	}

	public void setRecyletime(Date recyletime) {
		this.recyletime = recyletime;
	}

	
	public BigDecimal getShipprice() {
		return shipprice;
	}

	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
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

	public Long getTostationid() {
		return tostationid;
	}

	public void setTostationid(Long tostationid) {
		this.tostationid = tostationid;
	}

	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}
	
	
	
	
}
