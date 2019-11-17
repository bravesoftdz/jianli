package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
@Entity
public class StandardBasePrice  implements Serializable  {
	@Id
	@SequenceGenerator(name="STANDARDPRICE_ID_GENERATOR", sequenceName="SEQ_TICKETPRICE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="STANDARDPRICE_ID_GENERATOR")
	@Column(nullable = false)
	private long id;
	@Column(nullable = false)
	private long routeid;
	@Column(nullable = false)
	private long fromstationid;
	@Column(nullable = false)
	private long reachstationid;
	@Column(nullable = false)
	private long orgid;
	@Column(nullable = false)
	private BigDecimal baseprice;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getRouteid() {
		return routeid;
	}
	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}
	public long getFromstationid() {
		return fromstationid;
	}
	public void setFromstationid(long fromstationid) {
		this.fromstationid = fromstationid;
	}
	public long getReachstationid() {
		return reachstationid;
	}
	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}
	public long getOrgid() {
		return orgid;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	public BigDecimal getBaseprice() {
		return baseprice;
	}
	public void setBaseprice(BigDecimal baseprice) {
		this.baseprice = baseprice;
	}
	
	
}
