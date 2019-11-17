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
public class PackDiliveryDetail implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "PACKDILIVERYDETAIL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKDILIVERYDETAIL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private Long id;
	
	private Long packid;
	private Long packdiliveryid;
	
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

	public Long getPackdiliveryid() {
		return packdiliveryid;
	}
	public void setPackdiliveryid(Long packdiliveryid) {
		this.packdiliveryid = packdiliveryid;
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
