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


/**
 * The persistent class for the SCHEDULEDISCOUNT database table.
 * 班次折扣率
 */
@Entity
public class Schedulediscount implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SCHEDULEDISCOUNT_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SCHEDULEDISCOUNT_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private Long createby;

    @Temporal( TemporalType.DATE)
	private Date createtime;

    private BigDecimal mindiscountrate;

    private BigDecimal defaultdiscountrate;

    @Temporal( TemporalType.DATE)
	private Date enddate;

	private short endnum;

	private short fromnum;

	private Long orgid;

	private Long scheduleid;

    @Temporal( TemporalType.DATE)
	private Date startdate;

	private Long updateby;

    @Temporal( TemporalType.DATE)
	private Date updatetime;

    public Schedulediscount() {
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public BigDecimal getMindiscountrate() {
		return mindiscountrate;
	}

	public void setMindiscountrate(BigDecimal mindiscountrate) {
		this.mindiscountrate = mindiscountrate;
	}

	public BigDecimal getDefaultdiscountrate() {
		return defaultdiscountrate;
	}

	public void setDefaultdiscountrate(BigDecimal defaultdiscountrate) {
		this.defaultdiscountrate = defaultdiscountrate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public short getEndnum() {
		return endnum;
	}

	public void setEndnum(short endnum) {
		this.endnum = endnum;
	}

	public short getFromnum() {
		return fromnum;
	}

	public void setFromnum(short fromnum) {
		this.fromnum = fromnum;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}