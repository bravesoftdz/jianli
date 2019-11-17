package cn.nova.bus.check.model;

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


/**
 * The persistent class for the VEHICLEDISTANCEACTIVE database table. 
 * 车辆里程限制激活记录
 */
@Entity
public class Vehicledistanceactive implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name="VEHICLEDISTANCEACTIVE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VEHICLEDISTANCEACTIVE_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10 )
	private long id;
	
	@Column(nullable=false)
	private Long vehicleid;
	
	@Column(nullable=false, precision=10)
	private Long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;
	
	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date lastactivetime;
	
	@Column(nullable=false)
	private BigDecimal departdistance;
	
	private BigDecimal limitdistance;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
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

	public BigDecimal getDepartdistance() {
		return departdistance;
	}

	public void setDepartdistance(BigDecimal departdistance) {
		this.departdistance = departdistance;
	}

	public Date getLastactivetime() {
		return lastactivetime;
	}

	public void setLastactivetime(Date lastactivetime) {
		this.lastactivetime = lastactivetime;
	}

	public BigDecimal getLimitdistance() {
		return limitdistance;
	}

	public void setLimitdistance(BigDecimal limitdistance) {
		this.limitdistance = limitdistance;
	}	

}
