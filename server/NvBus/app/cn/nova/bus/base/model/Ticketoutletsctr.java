package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;


@Entity
public class Ticketoutletsctr implements Serializable{
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETOUTLETSCTR_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETOUTLETSCTR_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;
	private long ticketoutletsid;
	private Double carrychildrate;
	private Double maxsellmoney;
	private long createby;
	private Date createtime;
	private long updateby;
	private Date updatetime;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public long getTicketoutletsid() {
		return ticketoutletsid;
	}
	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}
	public Double getCarrychildrate() {
		return carrychildrate;
	}
	public void setCarrychildrate(Double carrychildrate) {
		this.carrychildrate = carrychildrate;
	}
	public Double getMaxsellmoney() {
		return maxsellmoney;
	}
	public void setMaxsellmoney(Double maxsellmoney) {
		this.maxsellmoney = maxsellmoney;
	}
	public long getCreateby() {
		return createby;
	}
	public void setCreateby(long createby) {
		this.createby = createby;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public long getUpdateby() {
		return updateby;
	}
	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	
	
}
