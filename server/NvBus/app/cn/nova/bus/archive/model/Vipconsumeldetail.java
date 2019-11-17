package cn.nova.bus.archive.model;

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


/**
 * The persistent class for the VIPCONSUMELDETAIL database table.
 * 
 */
@Entity
public class Vipconsumeldetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VIPCONSUMELDETAIL_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPCONSUMELDETAIL_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isselfschedule;

	private long sellid;

	//bi-directional many-to-one association to Vipconsume
    @ManyToOne
	@JoinColumn(name="VIPCONSUMEID")
	private Vipconsume vipconsume;

    public Vipconsumeldetail() {
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

	public boolean getIsselfschedule() {
		return this.isselfschedule;
	}

	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public long getSellid() {
		return this.sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public Vipconsume getVipconsume() {
		return this.vipconsume;
	}

	public void setVipconsume(Vipconsume vipconsume) {
		this.vipconsume = vipconsume;
	}
	
}