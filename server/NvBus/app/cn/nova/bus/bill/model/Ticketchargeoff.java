package cn.nova.bus.bill.model;

import java.io.Serializable;
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


/**
 * The persistent class for the SCHEDULEPERSELLDAYS database table.
 * 
 */
@Entity
@Table(name="TICKETCHARGEOFF")
public class Ticketchargeoff implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETCHARGEOFF_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETCHARGEOFF_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=50)
	private String ticketno;


	@Column(nullable=false, length=100)
	private String tickettype;

	@Column(nullable=false, precision=10)
	private Long sellerid;
	
	@Column(nullable=false, precision=10)
	private Long chargerby;

  @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date retrievetime;
  
  @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date chargetime;

    public Ticketchargeoff() { }


	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public Long getSellerid() {
		return sellerid;
	}

	public void setSellerid(Long sellerid) {
		this.sellerid = sellerid;
	}

	public Long getChargerby() {
		return chargerby;
	}

	public void setChargerby(Long chargerby) {
		this.chargerby = chargerby;
	}

	public Date getRetrievetime() {
		return retrievetime;
	}

	public void setRetrievetime(Date retrievetime) {
		this.retrievetime = retrievetime;
	}

	public Date getChargetime() {
		return chargetime;
	}

	public void setChargetime(Date chargetime) {
		this.chargetime = chargetime;
	}
    
    
    
}
