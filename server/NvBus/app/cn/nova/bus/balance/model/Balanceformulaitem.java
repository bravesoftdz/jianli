package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the BALANCEFORMULAITEM database table.
 * 
 */
@Entity
public class Balanceformulaitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="BALANCEFORMULAITEM_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BALANCEFORMULAITEM_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private String description;

	private String formulaitemname;

	private boolean isactive;

	private String shortname;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    @Transient
    private BigDecimal calValue;
    
	private boolean isticketpriceitem;
    
    public BigDecimal getCalValue() {
		return calValue;
	}

	public void setCalValue(BigDecimal calValue) {
		this.calValue = calValue;
	}

	public Balanceformulaitem() {
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

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getFormulaitemname() {
		return this.formulaitemname;
	}

	public void setFormulaitemname(String formulaitemname) {
		this.formulaitemname = formulaitemname;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public String getShortname() {
		return this.shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
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
	
	public boolean isIsticketpriceitem() {
		return isticketpriceitem;
	}

	public void setIsticketpriceitem(boolean isticketpriceitem) {
		this.isticketpriceitem = isticketpriceitem;
	}

}