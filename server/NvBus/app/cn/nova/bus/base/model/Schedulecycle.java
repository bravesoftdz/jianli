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


/**
 * The persistent class for the SCHEDULECYCLE database table.
 * 
 */
@Entity
public class Schedulecycle implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SCHEDULECYCLE_ID_GENERATOR", sequenceName="SEQ_SCHEDULECYCLE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SCHEDULECYCLE_ID_GENERATOR")
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private String rule;

	private String type;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	//bi-directional many-to-one association to Cyclescheme
    @ManyToOne
	@JoinColumn(name="SCHEMESID")
	private Cycleschemes cyclescheme;

    public Schedulecycle() {
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

	public String getRule() {
		return this.rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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