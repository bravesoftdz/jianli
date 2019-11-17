package cn.nova.bus.checkticket.model;

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
@Entity
@Table(name = "ENTRYTICKET")
public class Entryticket implements Serializable {
	@Id
	@SequenceGenerator(name = "ENTRYTICKET_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ENTRYTICKET_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;
	
	
	@Column(nullable = false, length = 20)
	private String ticketno;


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


	public String getTicketno() {
		return ticketno;
	}


	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}
}
