package cn.nova.bus.balance.model;

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
 * The persistent class for the BALANCEDEDUCTITEMPRICE database table.
 * 
 */
@Entity
public class Balancedeductitemprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="BALANCEDEDUCTITEMPRICE_ID_GENERATOR", sequenceName="SEQ_BALANCE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BALANCEDEDUCTITEMPRICE_ID_GENERATOR")
	private long id;

	@JoinColumn(name = "BALANCEDEDUCTITEMID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH,CascadeType.PERSIST})
	private Balancedeductitem balancedeductitem;  

	public Balancedeductitem getBalancedeductitem() {
		return balancedeductitem;
	}

	public void setBalancedeductitem(Balancedeductitem balancedeductitem) {
		this.balancedeductitem = balancedeductitem;
	}

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal endprice;

	private BigDecimal fromprice;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private BigDecimal value;

    public Balancedeductitemprice() {
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

	public BigDecimal getEndprice() {
		return this.endprice;
	}

	public void setEndprice(BigDecimal endprice) {
		this.endprice = endprice;
	}

	public BigDecimal getFromprice() {
		return this.fromprice;
	}

	public void setFromprice(BigDecimal fromprice) {
		this.fromprice = fromprice;
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

	public BigDecimal getValue() {
		return this.value;
	}

	public void setValue(BigDecimal value) {
		this.value = value;
	}

}