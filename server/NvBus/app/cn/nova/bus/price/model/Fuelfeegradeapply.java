package cn.nova.bus.price.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Vehicletype;

@Entity
public class Fuelfeegradeapply implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = 4924924060742028946L;

	@Id
	@SequenceGenerator(name = "FUELFEEGRADEAPPLY_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FUELFEEGRADEAPPLY_ID_GENERATOR")
	private long id;

	private long fuelfeegradeid;

	@Temporal(TemporalType.DATE)
	private Date fromdate;

	@Temporal(TemporalType.DATE)
	private Date todate;

	private long routeid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@JoinColumn(name = "vehicletypeid", nullable = true)
	@OneToOne(cascade = { CascadeType.REFRESH })
	private Vehicletype vehicletype;
	 
	public Vehicletype getVehicletype() {
		return vehicletype;
	}

	public void setVehicletype(Vehicletype vehicletype) {
		this.vehicletype = vehicletype;
	}

	@Transient
	private String routes;
	
	public String getRoutes() {
		return routes;
	}

	public void setRoutes(String routes) {
		this.routes = routes;
	}

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

	public Date getFromdate() {
		return fromdate;
	}

	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public Date getTodate() {
		return todate;
	}

	public void setTodate(Date todate) {
		this.todate = todate;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
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
