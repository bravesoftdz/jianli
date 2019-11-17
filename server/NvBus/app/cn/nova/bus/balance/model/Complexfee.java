package cn.nova.bus.balance.model;

import java.io.Serializable;
import javax.persistence.*;

import java.math.BigDecimal;
import java.util.Date;


/**
 * 综合收费信息
 * The persistent class for the COMPLEXFEE database table.
 * 
 */
@Entity
@Table(name="COMPLEXFEE")
public class Complexfee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="COMPLEXFEE_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="COMPLEXFEE_ID_GENERATOR")
	private long id;

	@Column(nullable=false, precision=10)
	private long createby;

	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=30)
	private String customer;

	@Column(nullable=false, precision=8, scale=2)
	private BigDecimal fee;

	@Column(nullable=false, precision=20)
	private String feetype;

	@Column(nullable=false, precision=10)
	private long operator;

	@Column(nullable=false, precision=10)
	private long orgid;

	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date printtime;

    @Column(precision=100)
	private String remarks;

	@Column(nullable=false, precision=10)
	private long updateby;

	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    public Complexfee() {
    }

	public long getId() {
		return this.id;
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

	public String getCustomer() {
		return this.customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public BigDecimal getFee() {
		return this.fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	public String getFeetype() {
		return this.feetype;
	}

	public void setFeetype(String feetype) {
		this.feetype = feetype;
	}

	public long getOperator() {
		return this.operator;
	}

	public void setOperator(long operator) {
		this.operator = operator;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getPrinttime() {
		return this.printtime;
	}

	public void setPrinttime(Date printtime) {
		this.printtime = printtime;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

}