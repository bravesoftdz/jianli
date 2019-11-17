package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "ROUTEPRICE")
public class Routeprice implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "ROUTEPRICE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ROUTEPRICE_ID_GENERATOR")
	private long id;

	private BigDecimal price;//

	private BigDecimal balanceprice;

	private Date fromdate;

	private Date todate;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n

	private long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n

	private long updateby;// number(10) n

	private long routeid;

	private long fromstationid;
	private long reachstationid;
	private long orgid;
	
	private boolean isbaseprice;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public boolean getIsbaseprice() {
		return isbaseprice;
	}

	public void setIsbaseprice(boolean isbaseprice) {
		this.isbaseprice = isbaseprice;
	}

	public long getFromstationid() {
		return fromstationid;
	}

	public void setFromstationid(long fromstationid) {
		this.fromstationid = fromstationid;
	}

	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getBalanceprice() {
		return balanceprice;
	}

	public void setBalanceprice(BigDecimal balanceprice) {
		this.balanceprice = balanceprice;
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

}
