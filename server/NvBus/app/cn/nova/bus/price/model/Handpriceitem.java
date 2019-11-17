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
 * The persistent class for the HANDPRICEITEM database table.
 * 
 */
@Entity
public class Handpriceitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="HANDPRICEITEM_ID_GENERATOR", sequenceName="SEQ_HANDPRICEITEM")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="HANDPRICEITEM_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	@JoinColumn(name = "HANDPRICEID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH,CascadeType.PERSIST})
	private Handprice handprice;
	
	private boolean isautoadjust;

	private BigDecimal price;

	private long ticketpriceformulaitemid;

	private String tickettype;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    @Transient
    private String opertype;
    @Transient
    private String code;

    @Transient
	private String name;
    @Transient
    private long handpriceid;
    
    
    public Handpriceitem() {
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
	
	public Handprice getHandprice() {
		return handprice;
	}

	public void setHandprice(Handprice handprice) {
		this.handprice = handprice;
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

	public long getHandpriceid() {
		return handpriceid;
	}

	public void setHandpriceid(long handpriceid) {
		this.handpriceid = handpriceid;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}