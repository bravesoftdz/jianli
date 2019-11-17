package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class TicketLoss implements Serializable{

	@Id
	@SequenceGenerator(name = "TICKETLOSS_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETLOSS_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private Long id;
	
	private Long ticketsellid;
	
	private Long scheduleid;
	
	private Long lossby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date losstime;
	
	private Long status;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(Long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getLossby() {
		return lossby;
	}

	public void setLossby(Long lossby) {
		this.lossby = lossby;
	}

	public Date getLosstime() {
		return losstime;
	}

	public void setLosstime(Date losstime) {
		this.losstime = losstime;
	}

	public Long getStatus() {
		return status;
	}

	public void setStatus(Long status) {
		this.status = status;
	}
}
