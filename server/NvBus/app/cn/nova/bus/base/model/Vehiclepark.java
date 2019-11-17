package cn.nova.bus.base.model;

import java.io.Serializable;
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
 * The persistent class for the VEHICLEPARK database table.
 * 上车卡位设置管理
 * haugnhaoze
 */
@Entity
@Table(name="VEHICLEPARK")
public class Vehiclepark implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name="VEHICLEPARK_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VEHICLEPARK_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	private Long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date createtime;
	private Boolean isactive;
	private String name;
	private Long orgid;
	private String printname;
	private String remarks;
	private Long updateby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Vehiclepark() {
    }


	
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


    
	@Column(nullable=false)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	@Column(nullable=false, precision=1)
	public Boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}


	@Column(nullable=false, length=60)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}


	@Column(nullable=false, precision=10)
	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}


	@Column(nullable=false, length=30)
	public String getPrintname() {
		return this.printname;
	}

	public void setPrintname(String printname) {
		this.printname = printname;
	}


	@Column(length=100)
	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	@Column(precision=10)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}