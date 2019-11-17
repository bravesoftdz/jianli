package cn.nova.bus.sale.model;

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
 * Ticketturnoverdetailepay entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "TICKETTURNOVERDETAILEPAY")
public class Ticketturnoverdetailepay implements java.io.Serializable {

	// Fields

	private Long id;
	private Long ticketturnoverdetailid;
	private String paymethod;
	private Double price;
	private Integer ticketnum;
	private Date createtime;
	private Long createby;
	private Date updatetime;
	private Long updateby;

	// Constructors

	/** default constructor */
	public Ticketturnoverdetailepay() {
	}

	/** minimal constructor */
	public Ticketturnoverdetailepay(Long id, Long ticketturnoverdetailid,
			Date createtime, Long createby, Date updatetime, Long updateby) {
		this.id = id;
		this.ticketturnoverdetailid = ticketturnoverdetailid;
		this.createtime = createtime;
		this.createby = createby;
		this.updatetime = updatetime;
		this.updateby = updateby;
	}

	/** full constructor */
	public Ticketturnoverdetailepay(Long id, Long ticketturnoverdetailid,
			String paymethod, Double price, Integer ticketnum, Date createtime,
			Long createby, Date updatetime, Long updateby) {
		this.id = id;
		this.ticketturnoverdetailid = ticketturnoverdetailid;
		this.paymethod = paymethod;
		this.price = price;
		this.ticketnum = ticketnum;
		this.createtime = createtime;
		this.createby = createby;
		this.updatetime = updatetime;
		this.updateby = updateby;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	@SequenceGenerator(name = "TICKETTURNOVERDETAILEPAY_ID_GENERATOR", sequenceName = "SEQ_TICKETTURNOVERDETAILEPAY", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETTURNOVERDETAILEPAY_ID_GENERATOR")
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "TICKETTURNOVERDETAILID", nullable = false, precision = 10, scale = 0)
	public Long getTicketturnoverdetailid() {
		return this.ticketturnoverdetailid;
	}

	public void setTicketturnoverdetailid(Long ticketturnoverdetailid) {
		this.ticketturnoverdetailid = ticketturnoverdetailid;
	}

	@Column(name = "PAYMETHOD", length = 1)
	public String getPaymethod() {
		return this.paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	@Column(name = "PRICE", precision = 10)
	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@Column(name = "TICKETNUM", precision = 6, scale = 0)
	public Integer getTicketnum() {
		return this.ticketnum;
	}

	public void setTicketnum(Integer ticketnum) {
		this.ticketnum = ticketnum;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CREATETIME", nullable = false, length = 7)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Column(name = "CREATEBY", nullable = false, precision = 10, scale = 0)
	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "UPDATETIME", nullable = false, length = 7)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	@Column(name = "UPDATEBY", nullable = false, precision = 10, scale = 0)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

}