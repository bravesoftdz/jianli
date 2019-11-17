package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
@Entity
public class Fuelfeegradedetail implements Serializable{
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -7464382077071115044L;

	@Id
	@SequenceGenerator(name = "FUELFEEGRADED_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FUELFEEGRADED_ID_GENERATOR")
	private long id;

	private long fuelfeegradeid;

	private long fromdistance;

	private long todistance;

	private BigDecimal fee;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	
	public long getFuelfeegradeid() {
		return fuelfeegradeid;
	}

	public void setFuelfeegradeid(long fuelfeegradeid) {
		this.fuelfeegradeid = fuelfeegradeid;
	}

	public long getFromdistance() {
		return fromdistance;
	}

	public void setFromdistance(long fromdistance) {
		this.fromdistance = fromdistance;
	}

	public long getTodistance() {
		return todistance;
	}

	public void setTodistance(long todistance) {
		this.todistance = todistance;
	}

	public BigDecimal getFee() {
		return fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
}
