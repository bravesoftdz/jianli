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


@Entity
public class Fuelfeegrade implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -235886216655775492L;

	@Id
	@SequenceGenerator(name = "FUELFEEGRADE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FUELFEEGRADE_ID_GENERATOR")
	private long id;

	private int grade;

	private BigDecimal fromprice;

	private BigDecimal toprice;

	private long orgid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public BigDecimal getFromprice() {
		return fromprice;
	}

	public void setFromprice(BigDecimal fromprice) {
		this.fromprice = fromprice;
	}

	public BigDecimal getToprice() {
		return toprice;
	}

	public void setToprice(BigDecimal toprice) {
		this.toprice = toprice;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}
