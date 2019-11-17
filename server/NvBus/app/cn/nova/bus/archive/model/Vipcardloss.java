package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the VIPCARDLOSS database table.
 * 
 */
@Entity
public class Vipcardloss implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VIPCARDLOSS_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPCARDLOSS_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isactive;

	private long lossby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date losstime;

	private String remarks;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vipid;

    public Vipcardloss() {
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

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public long getLossby() {
		return this.lossby;
	}

	public void setLossby(long lossby) {
		this.lossby = lossby;
	}

	public Date getLosstime() {
		return this.losstime;
	}

	public void setLosstime(Date losstime) {
		this.losstime = losstime;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public long getVipid() {
		return this.vipid;
	}

	public void setVipid(long vipid) {
		this.vipid = vipid;
	}

}