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

import cn.nova.bus.archive.model.Driver;


/**
 * The persistent class for the CYCLESCHEMESDRIVE database table.
 * 
 */
@Entity
public class Cycleschemesdriver implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CYCLESCHEMESDRIVE_ID_GENERATOR", sequenceName="SEQ_CYCLESCHEMESDRIVE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CYCLESCHEMESDRIVE_ID_GENERATOR")
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @OneToOne
	@JoinColumn(name="DRIVERID")
	private Driver driver;

	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}

	private byte orderno;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	//bi-directional many-to-one association to Cyclescheme
    @ManyToOne
	@JoinColumn(name="CYCLESCHEMESID")
	private Cycleschemes cyclescheme;

    public Cycleschemesdriver() {
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

	public Cycleschemes getCyclescheme() {
		return this.cyclescheme;
	}

	public void setCyclescheme(Cycleschemes cyclescheme) {
		this.cyclescheme = cyclescheme;
	}
	
}