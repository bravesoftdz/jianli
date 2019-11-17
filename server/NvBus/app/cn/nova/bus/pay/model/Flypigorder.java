package cn.nova.bus.pay.model;

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

@Entity
@Table(name = "FLYPIGORDER")
public class Flypigorder implements java.io.Serializable {
	@Id
	@SequenceGenerator(name = "FLYPIGORDER_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FLYPIGORDER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private String orderno;
	private String message;
	private String status;//0 新建立 1 出票成功 2 出票失败
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long createby;
	private long updateby;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}