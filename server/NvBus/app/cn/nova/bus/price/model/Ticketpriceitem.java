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
 * The persistent class for the TICKETPRICEITEM database table.
 * 
 */
@Entity
public class Ticketpriceitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETPRICEITEM_ID_GENERATOR", sequenceName="SEQ_TICKETPRICEITEM",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETPRICEITEM_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal price;

	private long ticketpriceformulaitemid;

	private long scheduleid;
	
	private boolean isautoadjust;	

	@Temporal(TemporalType.DATE)
	private Date departdate;
	
	@JoinColumn(name = "TICKETPRICEID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH,CascadeType.PERSIST})
	private Ticketprice ticketprice; 
	
	private String tickettype;
	
    @Transient
    private long ticketpriceid;
	
    public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	@Transient
	private String code;
    
    @Transient
	private String  name;
    
    @Transient
	private String opertype;
    
    public long getTicketpriceid() {
		return ticketpriceid;
	}

	public void setTicketpriceid(long ticketpriceid) {
		this.ticketpriceid = ticketpriceid;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}	
	
	public Ticketprice getTicketprice() {
		return ticketprice;
	}

	public void setTicketprice(Ticketprice ticketprice) {
		this.ticketprice = ticketprice;
	}

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Ticketpriceitem() {
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
	
	public boolean isIsautoadjust() {
		return isautoadjust;
	}

	public void setIsautoadjust(boolean isautoadjust) {
		this.isautoadjust = isautoadjust;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

}