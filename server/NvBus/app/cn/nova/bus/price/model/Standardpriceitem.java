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


/**
 * The persistent class for the STANDARDPRICEITEM database table.
 * 
 */
@Entity
public class Standardpriceitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="STANDARDPRICEITEM_ID_GENERATOR", sequenceName="SEQ_TICKETPRICEITEM",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="STANDARDPRICEITEM_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isautoadjust;

	private BigDecimal price;

	public Standardprice getStandardprice() {
		return standardprice;
	}

	public void setStandardprice(Standardprice standardprice) {
		this.standardprice = standardprice;
	}

	@JoinColumn(name = "STANDARDPRICEID", nullable = false)
	@ManyToOne(cascade = { CascadeType.ALL })
	private Standardprice standardprice;
	
	private long ticketpriceformulaitemid;

	private long updateby;

	private String tickettype;
	
	
    public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Standardpriceitem() {
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

	public void setTicketpriceformulaitemid(Long ticketpriceformulaitemid) {
		this.ticketpriceformulaitemid = ticketpriceformulaitemid;
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

}