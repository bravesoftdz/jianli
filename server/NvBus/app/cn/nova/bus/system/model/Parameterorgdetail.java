package cn.nova.bus.system.model;

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
 * The persistent class for the PARAMETERORGDETAIL database table.
 * 
 */
@Entity
@Table(name="PARAMETERORGDETAIL")
public class Parameterorgdetail implements Serializable {
	private static final long serialVersionUID = 1L;
	private long id;
	private Long createby;
	private Date createtime;
	private Long orgid;
	private Long parameterid;
	private Long updateby;
	private Date updatetime;
	private String value;

    public Parameterorgdetail() {
    }


	@Id
	@SequenceGenerator(name="PARAMETERORGDETAILS_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PARAMETERORGDETAILS_ID_GENERATOR")
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


    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	@Column(nullable=false, precision=10)
	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}


	@Column(nullable=false, precision=10)
	public Long getParameterid() {
		return this.parameterid;
	}

	public void setParameterid(Long parameterid) {
		this.parameterid = parameterid;
	}


	@Column(nullable=false, precision=10)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}


    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}


	@Column(nullable=false, length=100)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}