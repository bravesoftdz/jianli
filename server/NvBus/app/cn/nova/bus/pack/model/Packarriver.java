package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the TICKETPRICEFORMULA database table.
 * 
 */
@Entity
public class Packarriver implements Serializable,Cloneable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACKARRIVER_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKARRIVER_ID_GENERATOR")
	private long id;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	@Temporal(TemporalType.TIMESTAMP)
	private Date arriverdate;
	private long createby;
	private long updateby;
	private long driverid;
	private long packbalanceid;
	private long packid;
	private long orgid;
	private long sendstationid;
	private long pieces;
	private long receiver;
	private long transitstationid;
	private String consignee;
	private String packarriverno;
	private String packed;
	private String status;
	private String location;
	private String consigneephone;
	private BigDecimal servicefee;
	private BigDecimal packfee;
	private BigDecimal packprice;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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

	public Date getArriverdate() {
		return arriverdate;
	}

	public void setArriverdate(Date arriverdate) {
		this.arriverdate = arriverdate;
	}

	public long getDriverid() {
		return driverid;
	}

	public void setDriverid(long driverid) {
		this.driverid = driverid;
	}

	public long getPackbalanceid() {
		return packbalanceid;
	}

	public void setPackbalanceid(long packbalanceid) {
		this.packbalanceid = packbalanceid;
	}

	public long getPackid() {
		return packid;
	}

	public void setPackid(long packid) {
		this.packid = packid;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getSendstationid() {
		return sendstationid;
	}

	public void setSendstationid(long sendstationid) {
		this.sendstationid = sendstationid;
	}

	public long getPieces() {
		return pieces;
	}

	public void setPieces(long pieces) {
		this.pieces = pieces;
	}

	public long getReceiver() {
		return receiver;
	}

	public void setReceiver(long receiver) {
		this.receiver = receiver;
	}

	public long getTransitstationid() {
		return transitstationid;
	}

	public void setTransitstationid(long transitstationid) {
		this.transitstationid = transitstationid;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getPackarriverno() {
		return packarriverno;
	}

	public void setPackarriverno(String packarriverno) {
		this.packarriverno = packarriverno;
	}

	public String getPacked() {
		return packed;
	}

	public void setPacked(String packed) {
		this.packed = packed;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getConsigneephone() {
		return consigneephone;
	}

	public void setConsigneephone(String consigneephone) {
		this.consigneephone = consigneephone;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public BigDecimal getPackfee() {
		return packfee;
	}

	public void setPackfee(BigDecimal packfee) {
		this.packfee = packfee;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	public Object clone() {
		Object o = null;
		try {
			o = super.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return o;
	}
}
