package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "CARRYCHILD")
public class CarryChild implements Serializable {
	@Id
	@SequenceGenerator(name = "CARRYCHILD_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CARRYCHILD_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private Long id;
	
	private Long qticketid;//全票(主票)id
	
	private Long childticketid;//携童票id
	
	private Date createtime;
	
	private Long createby;
	
	private Date updatetime;
	
	private Long updateby;
	
	private String remark;//备注

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getQticketid() {
		return qticketid;
	}

	public void setQticketid(Long qticketid) {
		this.qticketid = qticketid;
	}

	public Long getChildticketid() {
		return childticketid;
	}

	public void setChildticketid(Long childticketid) {
		this.childticketid = childticketid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
