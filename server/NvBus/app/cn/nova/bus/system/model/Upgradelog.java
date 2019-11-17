package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the UPGRADELOG database table.
 * 
 */
@Entity
@Table(name="UPGRADELOG")
public class Upgradelog implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "UPGRADELOG_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "UPGRADELOG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date upgradetime;
	
	private String version;
	
	@Lob
	private String upgradecontext;
	
	private boolean needpopup;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getUpgradetime() {
		return upgradetime;
	}

	public void setUpgradetime(Date upgradetime) {
		this.upgradetime = upgradetime;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getUpgradecontext() {
		return upgradecontext;
	}

	public void setUpgradecontext(String upgradecontext) {
		this.upgradecontext = upgradecontext;
	}

	public boolean isNeedpopup() {
		return needpopup;
	}

	public void setNeedpopup(boolean needpopup) {
		this.needpopup = needpopup;
	}	
}
