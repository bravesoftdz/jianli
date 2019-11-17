package cn.nova.bus.balance.model;

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

import cn.nova.bus.system.model.Userinfo;

@Entity
public class Balancedeductapplysell {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALA_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALA_ID_GENERATOR")
	private long id;

	private long dataid;

	private String type;

	private long balancedeductapplyid;

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

	public long getDataid() {
		return dataid;
	}

	public void setDataid(long dataid) {
		this.dataid = dataid;
	}

	public long getBalancedeductapplyid() {
		return balancedeductapplyid;
	}

	public void setBalancedeductapplyid(long balancedeductapplyid) {
		this.balancedeductapplyid = balancedeductapplyid;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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
