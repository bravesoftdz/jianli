package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the CYCLESCHEMESVEHICLE database table.
 * 
 */
@Entity
public class Cycleschemesvehicle implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CYCLESCHEMESVEHICLE_ID_GENERATOR", sequenceName="SEQ_CYCLESCHEMESVEHICLE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CYCLESCHEMESVEHICLE_ID_GENERATOR")
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private byte orderno;
	
    @ManyToOne
	@JoinColumn(name="unitid")
	private Unit unit;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
    

	private long  vehiclebrandmodelid;
	


	@OneToOne
	@JoinColumn(name="VEHICLEID")
	private Vehicle vehicle;
    
	private Long vehicletypeid;

	//bi-directional many-to-one association to Cyclescheme
    @ManyToOne
	@JoinColumn(name="CYCLESCHEMESID")
	private Cycleschemes cyclescheme;

    public Cycleschemesvehicle() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public byte getOrderno() {
		return this.orderno;
	}

	public void setOrderno(byte orderno) {
		this.orderno = orderno;
	}


	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public Long getVehicletypeid() {
		return this.vehicletypeid;
	}

	public void setVehicletypeid(Long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public Cycleschemes getCyclescheme() {
		return this.cyclescheme;
	}

	public void setCyclescheme(Cycleschemes cyclescheme) {
		this.cyclescheme = cyclescheme;
	}
	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}
}