package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the CYCLESCHEMESSCHEDULE database table.
 * 
 */
@Entity
public class Cycleschemesschedule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CYCLESCHEMESSCHEDULE_ID_GENERATOR", sequenceName="SEQ_CYCLESCHEMESSCHEDULE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CYCLESCHEMESSCHEDULE_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private byte orderno;

	private long scheduleid;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	//bi-directional many-to-one association to Cyclescheme
    @ManyToOne
	@JoinColumn(name="CYCLESCHEMESID")
	private Cycleschemes cyclescheme;

    @Transient
    private String scheduleids;
    

	public String getScheduleids() {
		return scheduleids;
	}

	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}

	public Cycleschemesschedule() {
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

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
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