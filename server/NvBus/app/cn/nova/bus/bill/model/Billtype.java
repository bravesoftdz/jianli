package cn.nova.bus.bill.model;

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


@Entity
public class Billtype implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BILLTYPE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BILLTYPE_ID_GENERATOR")
	
	private long id;

	private String code;

	private long createby;

  @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private String description;

	private boolean isactive;

	private String medium;

	private String name;

	private long numperbox;

	private BigDecimal parvalue;

	private String printname;

	private long ticketnolength;

	private long updateby;

  @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

  public Billtype() {
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


	public String getMedium() {
		return this.medium;
	}

	public void setMedium(String medium) {
		this.medium = medium;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public BigDecimal getParvalue() {
		return this.parvalue;
	}

	public void setParvalue(BigDecimal parvalue) {
		this.parvalue = parvalue;
	}

	public String getPrintname() {
		return this.printname;
	}

	public void setPrintname(String printname) {
		this.printname = printname;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public long getNumperbox() {
		return numperbox;
	}

	public void setNumperbox(long numperbox) {
		this.numperbox = numperbox;
	}

	public long getTicketnolength() {
		return ticketnolength;
	}

	public void setTicketnolength(long ticketnolength) {
		this.ticketnolength = ticketnolength;
	}

	public long getUpdateby() {
		return updateby;
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

}