package cn.nova.bus.archive.model;


import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * The persistent class for the VIPGIFTDETAIL database table.
 * 
 */
@Entity
@Table(name="VIPGIFTDETAIL")
public class Vipgiftdetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private long id;
	private long vipgiftid;
	private String vipgrade;
	private BigDecimal needamount;

    public Vipgiftdetail() {
    }

    @Id
	@SequenceGenerator(name="VIPGIFTDETAIL_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPGIFTDETAIL_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
    @Column(nullable=false, precision=10)
	public long getVipgiftid() {
		return this.vipgiftid;
	}

	public void setVipgiftid(long vipgiftid) {
		this.vipgiftid = vipgiftid;
	}

	 @Column(nullable=false, precision=10)
	public String getVipgrade() {
		return this.vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

	public BigDecimal getNeedamount() {
		return needamount;
	}

	public void setNeedamount(BigDecimal needamount) {
		this.needamount = needamount;
	}
}