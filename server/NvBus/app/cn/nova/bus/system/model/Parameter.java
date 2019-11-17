package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the PARAMETER database table.
 * 
 */
@Entity
@Table(name="PARAMETER")
public class Parameter implements Serializable {
	private static final long serialVersionUID = 1L;
	private long id;
	private String code;
	private boolean iseditable;
	private boolean isvisible;
	private String remark;
	private String type;
	private String unit;
	private Long updateby;
	private Date updatetime;
	private String value;

    public Parameter() {
    }


	@Id
	@SequenceGenerator(name="PARAMETER_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PARAMETER_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}


	@Column(nullable=false, length=3)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}


	@Column(nullable=false, precision=1)
	public boolean getIseditable() {
		return this.iseditable;
	}

	public void setIseditable(boolean iseditable) {
		this.iseditable = iseditable;
	}


	@Column(nullable=false, precision=1)
	public boolean getIsvisible() {
		return this.isvisible;
	}

	public void setIsvisible(boolean isvisible) {
		this.isvisible = isvisible;
	}


	@Column(nullable=false, length=200)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


	@Column(nullable=false, length=10)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}


	@Column(length=20)
	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}


	@Column(nullable=false, precision=10)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable=false)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}


	@Column(nullable=false, length=100)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}