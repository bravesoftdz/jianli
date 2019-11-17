package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
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
 * The persistent class for the HANDHOLIDAYPRICEITEM database table.
 * 
 */
@Entity
public class Handholidaypriceitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "HANDHOLIDAYPRICEITEM_ID_GENERATOR", sequenceName = "SEQ_HOLIDAYPRICEITEM")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "HANDHOLIDAYPRICEITEM_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@JoinColumn(name = "HANDHOLIDAYPRICEID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH,CascadeType.PERSIST})
	private Handholidayprice handholidayprice;

	private boolean isautoadjust;

	private BigDecimal price;

	private long ticketpriceformulaitemid;

	private String tickettype;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Transient
	private Long handholidaypriceid;

	@Transient
	private String opertype;
	@Transient
	private String name;

	@Transient
	private String code;



	public Handholidaypriceitem() {
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

	public boolean getIsautoadjust() {
		return this.isautoadjust;
	}

	public void setIsautoadjust(boolean isautoadjust) {
		this.isautoadjust = isautoadjust;
	}

	public BigDecimal getPrice() {
		return this.price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public long getTicketpriceformulaitemid() {
		return this.ticketpriceformulaitemid;
	}

	public void setTicketpriceformulaitemid(long ticketpriceformulaitemid) {
		this.ticketpriceformulaitemid = ticketpriceformulaitemid;
	}

	public String getTickettype() {
		return this.tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
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

	public Handholidayprice getHandholidayprice() {
		return handholidayprice;
	}

	public void setHandholidaypriceid(Long handholidaypriceid) {
		this.handholidaypriceid = handholidaypriceid;
	}

	public void setHandholidayprice(Handholidayprice handholidayprice) {
		this.handholidayprice = handholidayprice;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	public long getHandholidaypriceid() {
		return handholidaypriceid;
	}

	public void setHandholidaypriceid(long handholidaypriceid) {
		this.handholidaypriceid = handholidaypriceid;
	}
}