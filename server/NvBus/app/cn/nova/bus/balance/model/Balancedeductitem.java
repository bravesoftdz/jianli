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
 * The persistent class for the BALANCEDEDUCTITEM database table.
 * 
 */
@Entity
public class Balancedeductitem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCEDEDUCTITEM_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCEDEDUCTITEM_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal deductmoney;

	private String deducttype;

	private String description;

	private boolean isactive;

	private boolean isaudited;

	private boolean isauditpass;

	private boolean isdeductbeforebalance;

	private String name;

	private long orgid;

	private long parentid;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private boolean isticketpriceitem;

	private String code;

	private boolean isexpress;
	
	private String formula;


	@Transient
	private boolean isaddprintitem;

	@Transient
	private long printtemplatetypeitemid;

	public Balancedeductitem() {
	}

	public long getId() {
		return this.id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public BigDecimal getDeductmoney() {
		return this.deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
	}

	public String getDeducttype() {
		return this.deducttype;
	}

	public void setDeducttype(String deducttype) {
		this.deducttype = deducttype;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIsaudited() {
		return this.isaudited;
	}

	public void setIsaudited(boolean isaudited) {
		this.isaudited = isaudited;
	}

	public boolean getIsauditpass() {
		return this.isauditpass;
	}

	public void setIsauditpass(boolean isauditpass) {
		this.isauditpass = isauditpass;
	}

	public boolean getIsdeductbeforebalance() {
		return this.isdeductbeforebalance;
	}

	public void setIsdeductbeforebalance(boolean isdeductbeforebalance) {
		this.isdeductbeforebalance = isdeductbeforebalance;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getParentid() {
		return this.parentid;
	}

	public void setParentid(long parentid) {
		this.parentid = parentid;
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

	public boolean isIsaddprintitem() {
		return isaddprintitem;
	}

	public void setIsaddprintitem(boolean isaddprintitem) {
		this.isaddprintitem = isaddprintitem;
	}

	public long getPrinttemplatetypeitemid() {
		return printtemplatetypeitemid;
	}

	public void setPrinttemplatetypeitemid(long printtemplatetypeitemid) {
		this.printtemplatetypeitemid = printtemplatetypeitemid;
	}

	public boolean isIsexpress() {
		return isexpress;
	}

	public void setIsexpress(boolean isexpress) {
		this.isexpress = isexpress;
	}
	
	
	public String getFormula() {
		return formula;
	}

	public void setFormula(String formula) {
		this.formula = formula;
	}
}