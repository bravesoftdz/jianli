package cn.nova.bus.balance.model;

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

@Entity
public class Deductitem {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEEUCTITEM_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEEUCTITEM_ID_GENERATOR")
	private long id;

	private String code;

	private String name;

	private String printname;

	private short orderno;

	private String deducttype;

	private boolean ispriceitem;

	private boolean isexpress;

	private boolean issum;

	@Transient
	private boolean isprintitem;

	private BigDecimal deductmoney;

	private String description;

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;

	private boolean isactive;
	
	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPrintname() {
		return printname;
	}

	public void setPrintname(String printname) {
		this.printname = printname;
	}

	public short getOrderno() {
		return orderno;
	}

	public void setOrderno(short orderno) {
		this.orderno = orderno;
	}

	public String getDeducttype() {
		return deducttype;
	}

	public void setDeducttype(String deducttype) {
		this.deducttype = deducttype;
	}

	public boolean isIspriceitem() {
		return ispriceitem;
	}

	public void setIspriceitem(boolean ispriceitem) {
		this.ispriceitem = ispriceitem;
	}

	public boolean isIsexpress() {
		return isexpress;
	}

	public void setIsexpress(boolean isexpress) {
		this.isexpress = isexpress;
	}

	public boolean isIssum() {
		return issum;
	}

	public void setIssum(boolean issum) {
		this.issum = issum;
	}

	public BigDecimal getDeductmoney() {
		return deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
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
	
	public boolean isIsprintitem() {
		return isprintitem;
	}

	public void setIsprintitem(boolean isprintitem) {
		this.isprintitem = isprintitem;
	}


}
