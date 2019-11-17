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

import cn.nova.bus.archive.model.Steward;


/**
 * The persistent class for the CYCLESCHEMESSTEWARD database table.
 * 
 */
@Entity
public class Cycleschemessteward implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CYCLESCHEMESSTEWARD_ID_GENERATOR", sequenceName="SEQ_CYCLESCHEMESSTEWARD",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CYCLESCHEMESSTEWARD_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private byte orderno;
	
    @OneToOne
	@JoinColumn(name="STEWARDID")
	private Steward steward;

	public Steward getSteward() {
		return steward;
	}

	public void setSteward(Steward steward) {
		this.steward = steward;
	}

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	//bi-directional many-to-one association to Cyclescheme
    @ManyToOne
	@JoinColumn(name="CYCLESCHEMESID")
	private Cycleschemes cyclescheme;

    public Cycleschemessteward() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
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


	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
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