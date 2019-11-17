package cn.nova.bus.sale.model;

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
 * The persistent class for the TICKETDELIVER database table.
 * 
 */
@Entity
public class Ticketdeliver implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETDELIVER_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETDELIVER_ID_GENERATOR")
	private long id;

	private String address;

	private String area;

	private String clientname;

	private String clientphone;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String deliverby;

	@Temporal(TemporalType.DATE)
	private Date deliverdate;

	private boolean isturnover;

	private Long orgid;

	private BigDecimal serviceprice;

	private Long turnoverid;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public Ticketdeliver() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getClientname() {
		return this.clientname;
	}

	public void setClientname(String clientname) {
		this.clientname = clientname;
	}

	public String getClientphone() {
		return this.clientphone;
	}

	public void setClientphone(String clientphone) {
		this.clientphone = clientphone;
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

	public String getDeliverby() {
		return deliverby;
	}

	public void setDeliverby(String deliverby) {
		this.deliverby = deliverby;
	}

	public Date getDeliverdate() {
		return deliverdate;
	}

	public void setDeliverdate(Date deliverdate) {
		this.deliverdate = deliverdate;
	}

	public boolean isIsturnover() {
		return isturnover;
	}

	public void setIsturnover(boolean isturnover) {
		this.isturnover = isturnover;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getServiceprice() {
		return serviceprice;
	}

	public void setServiceprice(BigDecimal serviceprice) {
		this.serviceprice = serviceprice;
	}

	public Long getTurnoverid() {
		return turnoverid;
	}

	public void setTurnoverid(Long turnoverid) {
		this.turnoverid = turnoverid;
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