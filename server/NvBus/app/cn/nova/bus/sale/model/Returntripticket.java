package cn.nova.bus.sale.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the RETURNTRIPTICKET database table.
 * 
 */
@Entity
@Table(name="RETURNTRIPTICKET")
public class Returntripticket implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="RETURNTRIPTICKET_ID_GENERATOR", sequenceName="SEQ_TICKETSELL")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="RETURNTRIPTICKET_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=30)
	private String batchno;

	@Column(nullable=false, precision=1)
	private boolean isselfschedule;

	@Column(nullable=false, precision=10)
	private long sellid;

	@Column(nullable=false, length=20)
	private String ticketno;

    public Returntripticket() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getBatchno() {
		return this.batchno;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
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

	public String getTicketno() {
		return this.ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

}