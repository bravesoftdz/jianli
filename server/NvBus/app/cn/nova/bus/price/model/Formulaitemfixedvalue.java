package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the FORMULAITEMFIXEDVALUE database table.
 * 
 */
@Entity
public class Formulaitemfixedvalue implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@JoinColumn(name = "ticketpriceformulaitemid", nullable = false)
	@OneToOne(cascade = { CascadeType.ALL })	
	@Id
	@SequenceGenerator(name="FORMULAITEMFIXEDVALUE_TICKETPRICEFORMULAITEMID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="FORMULAITEMFIXEDVALUE_TICKETPRICEFORMULAITEMID_GENERATOR")
//	private long ticketpriceformulaitemid;
   private Ticketpriceformulaitem  ticketpriceformulaitem;
    
	public Ticketpriceformulaitem getTicketpriceformulaitem() {
		return ticketpriceformulaitem;
	}

	public void setTicketpriceformulaitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		this.ticketpriceformulaitem = ticketpriceformulaitem;
	}

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private BigDecimal value;

    public Formulaitemfixedvalue() {
    }

	/*public long getTicketpriceformulaitemid() {
		return this.ticketpriceformulaitemid;
	}

	public void setTicketpriceformulaitemid(long ticketpriceformulaitemid) {
		this.ticketpriceformulaitemid = ticketpriceformulaitemid;
	}*/

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
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