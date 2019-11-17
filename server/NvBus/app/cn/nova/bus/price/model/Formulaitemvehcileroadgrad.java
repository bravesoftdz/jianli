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
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the FORMULAITEMVEHCILEROADGRAD database table.
 * 
 */
@Entity
public class Formulaitemvehcileroadgrad implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="FORMULAITEMVEHCILEROADGRAD_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="FORMULAITEMVEHCILEROADGRAD_ID_GENERATOR")
	private long id;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private String roadgrade;

	@JoinColumn(name = "ticketpriceformulaitemid", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH })
	private Ticketpriceformulaitem ticketpriceformulaitem;

	public Ticketpriceformulaitem getTicketpriceformulaitem() {
		return ticketpriceformulaitem;
	}

	public void setTicketpriceformulaitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		this.ticketpriceformulaitem = ticketpriceformulaitem;
	}

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private BigDecimal value;

	private Long vehciletypeid;

    public Formulaitemvehcileroadgrad() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

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

	public String getRoadgrade() {
		return this.roadgrade;
	}

	public void setRoadgrade(String roadgrade) {
		this.roadgrade = roadgrade;
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

	public Long getVehciletypeid() {
		return this.vehciletypeid;
	}

	public void setVehciletypeid(Long vehciletypeid) {
		this.vehciletypeid = vehciletypeid;
	}

}