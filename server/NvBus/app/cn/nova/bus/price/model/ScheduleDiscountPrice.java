package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Vehiclebrandmodel;

/**
 * The persistent class for the SCHEDULEDISCOUNTPRICE database table.
 * 
 */
@Entity
public class ScheduleDiscountPrice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULEDISCOUNTPRICE_ID_GENERATOR", sequenceName = "SEQ_TICKETPRICE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEDISCOUNTPRICE_ID_GENERATOR")
	private long id;
	private long scheduleid;

	@Temporal(TemporalType.DATE)
	private Date startdate;

	@Temporal(TemporalType.DATE)
	private Date enddate;
	private long departstationid;
	private long reachstationid;
	private BigDecimal price;
	private int salenum;
	private long orgid;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long updateby;
	private BigDecimal referenceprice;

	// 该字段作为记录的操作类型字段，不对数据库表进行映射
	// @Transient
	// private String opertype;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public int getSalenum() {
		return salenum;
	}

	public void setSalenum(int salenum) {
		this.salenum = salenum;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
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
	

	// public String getOpertype() {
	// return opertype;
	// }
	//
	// public void setOpertype(String opertype) {
	// this.opertype = opertype;
	// }

	public BigDecimal getReferenceprice() {
		return referenceprice;
	}

	public void setReferenceprice(BigDecimal referenceprice) {
		this.referenceprice = referenceprice;
	}

	@Override
	public String toString() {
		return "ScheduleDiscountPrice [id=" + id + ", scheduleid=" + scheduleid
				+ ", startdate=" + startdate + ", enddate=" + enddate
				+ ", departstationid=" + departstationid + ", reachstationid="
				+ reachstationid + ", price=" + price + ", salenum=" + salenum
				+ ", orgid=" + orgid + ", createtime=" + createtime
				+ ", createby=" + createby + ", updatetime=" + updatetime
				+ ", updateby=" + updateby + ", referenceprice=" + referenceprice + "]";
	}

	public ScheduleDiscountPrice(long id, long scheduleid, Date startdate,
			Date enddate, long departstationid, long reachstationid,
			BigDecimal price, int salenum, long orgid, Date createtime,
			long createby, Date updatetime, long updateby,BigDecimal referenceprice) {
		super();
		this.id = id;
		this.scheduleid = scheduleid;
		this.startdate = startdate;
		this.enddate = enddate;
		this.departstationid = departstationid;
		this.reachstationid = reachstationid;
		this.price = price;
		this.salenum = salenum;
		this.orgid = orgid;
		this.createtime = createtime;
		this.createby = createby;
		this.updatetime = updatetime;
		this.updateby = updateby;
		this.referenceprice = referenceprice;
	}

	public ScheduleDiscountPrice() {
		super();
		// TODO Auto-generated constructor stub
	}
	

}