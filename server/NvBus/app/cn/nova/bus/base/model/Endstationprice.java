package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the TICKETOUTLETS database table.
 * 
 */
@Entity
@Table(name = "ENDSTATIONPRICE")
public class Endstationprice implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "ENDSTATIONPRICE_ID_GENERATOR", sequenceName = "SEQ_ENDSTATIONPRICE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ENDSTATIONPRICE_ID_GENERATOR")
	private long id;

	@Temporal(TemporalType.DATE)
	private Date departdate;// date n

	private long scheduleid;// number(10) n

	private BigDecimal price;// number(10,2) n 终点站全票票价

	private BigDecimal balanceprice;// number(10,2) n 终点站结算票价=全票票价-票价分项

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n

	private long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n

	private long updateby;// number(10) n

	public Endstationprice() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getBalanceprice() {
		return balanceprice;
	}

	public void setBalanceprice(BigDecimal balanceprice) {
		this.balanceprice = balanceprice;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

}