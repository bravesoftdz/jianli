package cn.nova.bus.archive.model;


import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


/**
 * The persistent class for the RECHARGEACTIVITYDETAIL database table.
 * 
 */
@Entity
@Table(name="RECHARGEACTIVITYDETAIL")
public class Rechargeactivitydetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private long id;
	private long rechargepromotionactivityid;
	private String vipgrade;

    public Rechargeactivitydetail() {
    }

    @Id
	@SequenceGenerator(name="RECHARGEACTIVITYDETAIL_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="RECHARGEACTIVITYDETAIL_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
    @Column(nullable=false, precision=10)
	public long getRechargepromotionactivityid() {
		return this.rechargepromotionactivityid;
	}

	public void setRechargepromotionactivityid(long rechargepromotionactivityid) {
		this.rechargepromotionactivityid = rechargepromotionactivityid;
	}

	 @Column(nullable=false, precision=10)
	public String getVipgrade() {
		return this.vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

}