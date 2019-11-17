package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the TICKETSIGN database table.
 * 
 */
@Entity
@Table(name="TICKETSIGN")
public class Ticketsign implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETSIGN_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETSIGN_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal charges;

	@Column(nullable=false, precision=1)
	private boolean isselfschedule;

	@Column(nullable=false, precision=10)
	private long sellid;

	@Column(nullable=false, precision=10)
	private long signby;

	@Column(length=200)
	private String signreason;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date signtime;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal ticketprice;

	@Transient
	private String opertype;
	
	private Double signrate;
	
	private boolean israte;
	
    public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public Ticketsign() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getCharges() {
		return this.charges;
	}

	public void setCharges(BigDecimal charges) {
		this.charges = charges;
	}

	public boolean getIsselfschedule() {
		return this.isselfschedule;
	}

	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public long getSellid() {
		return this.sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public long getSignby() {
		return this.signby;
	}

	public void setSignby(long signby) {
		this.signby = signby;
	}

	public String getSignreason() {
		return this.signreason;
	}

	public void setSignreason(String signreason) {
		this.signreason = signreason;
	}

	public Date getSigntime() {
		return this.signtime;
	}

	public void setSigntime(Date signtime) {
		this.signtime = signtime;
	}

	public BigDecimal getTicketprice() {
		return this.ticketprice;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public Double getSignrate() {
		return signrate;
	}

	public void setSignrate(Double signrate) {
		this.signrate = signrate;
	}

	public boolean isIsrate() {
		return israte;
	}

	public void setIsrate(boolean israte) {
		this.israte = israte;
	}

}