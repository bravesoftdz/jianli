package cn.nova.bus.base.model;

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
import javax.persistence.Transient;


/**
 * The persistent class for the SCHEDULEVIPDISCOUNT database table.
 * 班次折扣率子表
 */
@Entity
public class Schedulevipdiscount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SCHEDULEVIPDISCOUNT_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SCHEDULEVIPDISCOUNT_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal defaultdiscountrate;

	private Long schedulediscountid;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private String vipgrade;

	
	//该字段作为记录的操作类型字段，不对数据库表进行映射
    @Transient
    private String opertype;
    
    
    public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public Schedulevipdiscount() {
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

	public BigDecimal getDefaultdiscountrate() {
		return this.defaultdiscountrate;
	}

	public void setDefaultdiscountrate(BigDecimal defaultdiscountrate) {
		this.defaultdiscountrate = defaultdiscountrate;
	}

	public Long getSchedulediscountid() {
		return this.schedulediscountid;
	}

	public void setSchedulediscountid(Long schedulediscountid) {
		this.schedulediscountid = schedulediscountid;
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

	public String getVipgrade() {
		return this.vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

	@Override
	public String toString() {
		return "Schedulevipdiscount [id=" + id + ", createby=" + createby
				+ ", createtime=" + createtime + ", defaultdiscountrate="
				+ defaultdiscountrate + ", schedulediscountid="
				+ schedulediscountid + ", updateby=" + updateby
				+ ", updatetime=" + updatetime + ", vipgrade=" + vipgrade + "]";
	}

}