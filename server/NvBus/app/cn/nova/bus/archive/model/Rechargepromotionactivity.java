package cn.nova.bus.archive.model;

import java.io.Serializable;
import javax.persistence.*;

import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the RECHARGEPROMOTIONACTIVITY database table.
 * 
 */
@Entity
@Table(name="RECHARGEPROMOTIONACTIVITY")
public class Rechargepromotionactivity implements Serializable {
	private static final long serialVersionUID = 1L;
	private long id;
	private Long createby;
	private Date createtime;
	private Date enddate;
	private boolean isactive;
	private String name;
	private boolean presentoncepercard;
	private BigDecimal presentvoucher;
	private BigDecimal rechargeamount;
	private String remarks;
	private Date startdate;
	private Long updateby;
	private Date updatetime;

    public Rechargepromotionactivity() {
    }


    @Id
	@SequenceGenerator(name="RECHARGEPROMOTIONACTIVITY_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="RECHARGEPROMOTIONACTIVITY_ID_GENERATOR")
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


	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	@Column(length=100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}


    @Column(nullable=false)
	public boolean getPresentoncepercard() {
		return this.presentoncepercard;
	}

	public void setPresentoncepercard(boolean presentoncepercard) {
		this.presentoncepercard = presentoncepercard;
	}


    @Column(nullable=false)
	public BigDecimal getPresentvoucher() {
		return this.presentvoucher;
	}

	public void setPresentvoucher(BigDecimal presentvoucher) {
		this.presentvoucher = presentvoucher;
	}


    @Column(nullable=false)
	public BigDecimal getRechargeamount() {
		return this.rechargeamount;
	}

	public void setRechargeamount(BigDecimal rechargeamount) {
		this.rechargeamount = rechargeamount;
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