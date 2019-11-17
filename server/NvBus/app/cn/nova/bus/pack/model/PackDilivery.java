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

import play.db.jpa.GenericModel;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class PackDilivery extends GenericModel implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "PACKDILIVERY_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKDILIVERY_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private Long id;
	
	private Long packid;
	private Long orgid;
	private Long outbound;
	private Long diliver;
	
	@Temporal(TemporalType.DATE)
	private Date outdate;
	@Temporal(TemporalType.DATE)
	private Date dilivedate;
	private String diliveno;
	
	@Column(precision = 10, scale = 2)
	private BigDecimal deliveryfee;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private Long createby;
	private Long updateby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPackid() {
		return packid;
	}
	public void setPackid(Long packid) {
		this.packid = packid;
	}
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	public Long getOutbound() {
		return outbound;
	}
	public void setOutbound(Long outbound) {
		this.outbound = outbound;
	}
	public Long getDiliver() {
		return diliver;
	}
	public void setDiliver(Long diliver) {
		this.diliver = diliver;
	}
	
	
	public Date getOutdate() {
		return outdate;
	}
	public void setOutdate(Date outdate) {
		this.outdate = outdate;
	}
	public Date getDilivedate() {
		return dilivedate;
	}
	public void setDilivedate(Date dilivedate) {
		this.dilivedate = dilivedate;
	}
	public String getDiliveno() {
		return diliveno;
	}
	public void setDiliveno(String diliveno) {
		this.diliveno = diliveno;
	}

	public BigDecimal getDeliveryfee() {
		return deliveryfee;
	}
	public void setDeliveryfee(BigDecimal deliveryfee) {
		this.deliveryfee = deliveryfee;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
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
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
}
