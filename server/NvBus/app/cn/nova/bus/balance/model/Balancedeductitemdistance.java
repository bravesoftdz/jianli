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
 * The persistent class for the BALANCEDEDUCTITEMDISTANCE database table.
 * 
 */
@Entity
public class Balancedeductitemdistance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="BALANCEDEDUCTITEMDISTANCE_ID_GENERATOR", sequenceName="SEQ_BALANCE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BALANCEDEDUCTITEMDISTANCE_ID_GENERATOR")
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

	private long enddistance;

	private long fromdistance;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private BigDecimal value;

    public Balancedeductitemdistance() {
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

	public long getEnddistance() {
		return this.enddistance;
	}

	public void setEnddistance(long enddistance) {
		this.enddistance = enddistance;
	}

	public long getFromdistance() {
		return this.fromdistance;
	}

	public void setFromdistance(long fromdistance) {
		this.fromdistance = fromdistance;
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