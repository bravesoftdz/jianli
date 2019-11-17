package cn.nova.bus.archive.model;

import java.math.BigDecimal;
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
 * The persistent class for the VIPGIFT database table.
 * 
 */
@Entity
@Table(name="VIPGIFT")
public class Vipgift {

	private static final long serialVersionUID = 1L;
	private long id;
	private Long createby;
	private Date createtime;
	private Date enddate;
	private String name;
	private BigDecimal valuation;
	private Long quantity;
	private String remarks;
	private Date startdate;
	private Long updateby;
	private Date updatetime;

    public Vipgift() {
    }


    @Id
	@SequenceGenerator(name="VIPGIFT_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPGIFT_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(nullable=false, precision=10)
	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}


	@Temporal(TemporalType.TIMESTAMP)
    @Column(nullable=false)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


    @Temporal( TemporalType.DATE)
    @Column(nullable=false)
	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}



	@Column(length=100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}


    @Column(nullable=false)
	public BigDecimal getValuation() {
		return this.valuation;
	}

	public void setValuation(BigDecimal valuation) {
		this.valuation = valuation;
	}


    @Column(nullable=false)
	public Long getQuantity() {
		return this.quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}


	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


    @Temporal( TemporalType.DATE)
    @Column(nullable=false)
	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
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
}
