package cn.nova.bus.price.model;

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
 * The persistent class for the TICKETPRICEFORMULAITEM database table.
 * 
 */
@Entity
public class Ticketpriceformulaitem implements Serializable,Cloneable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETPRICEFORMULAITEM_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETPRICEFORMULAITEM_ID_GENERATOR")
	private long id;

	private String code;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isactive;

	private boolean isautoadjust;
	
	private boolean isfreight;
	
	public boolean getIsfreight() {
		return isfreight;
	}

	public void setIsfreight(boolean isfreight) {
		this.isfreight = isfreight;
	}

	private boolean isdefault;

	private boolean isticketpriceitem;

	private String name;

	private Long orgid;

	private String relatetype;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Transient
	private BigDecimal Value;

	@Transient
	private String itemformula;

	public String getItemformula() {
		return itemformula;
	}

	public void setItemformula(String itemformula) {
		this.itemformula = itemformula;
	}

	public BigDecimal getValue() {
		return Value;
	}

	public void setValue(BigDecimal value) {
		Value = value;
	}

	public Ticketpriceformulaitem() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIsautoadjust() {
		return this.isautoadjust;
	}

	public void setIsautoadjust(boolean isautoadjust) {
		this.isautoadjust = isautoadjust;
	}

	public boolean getIsdefault() {
		return this.isdefault;
	}

	public void setIsdefault(boolean isdefault) {
		this.isdefault = isdefault;
	}

	public boolean getIsticketpriceitem() {
		return this.isticketpriceitem;
	}

	public void setIsticketpriceitem(boolean isticketpriceitem) {
		this.isticketpriceitem = isticketpriceitem;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getRelatetype() {
		return this.relatetype;
	}

	public void setRelatetype(String relatetype) {
		this.relatetype = relatetype;
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
	//增加深度克隆方法
	public Ticketpriceformulaitem clone() throws CloneNotSupportedException 
	{ 
		return (Ticketpriceformulaitem)super.clone();  //12行 
	} 
}