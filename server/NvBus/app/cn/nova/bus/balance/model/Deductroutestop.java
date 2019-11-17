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

@Entity
public class Deductroutestop implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEDUCTROUTE_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEDUCTROUTE_ID_GENERATOR")
	private long id;

	private long deductitemid;

	@Transient
	private String deductname;

	@Transient
	private String opertype;	

	private long routeid;

	private long stationid;

	private BigDecimal deductmoney;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getDeductitemid() {
		return deductitemid;
	}

	public void setDeductitemid(long deductitemid) {
		this.deductitemid = deductitemid;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getStationid() {
		return stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
	}

	public BigDecimal getDeductmoney() {
		return deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
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

	public String getDeductname() {
		return deductname;
	}

	public void setDeductname(String deductname) {
		this.deductname = deductname;
	}
	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}
}
