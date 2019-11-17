package cn.nova.bus.archive.model;

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
 * 
 * <p>
 * Title: 驾驶员家庭信息
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author huanghz
 * @version 0.1
 */
@Entity
@Table(name="DRIVERFAMILYMEMBER")
public class Driverfamilymember implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name="DRIVERFAMILYMEMBER_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="DRIVERFAMILYMEMBER_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	@Temporal( TemporalType.DATE)
	private Date birthday;
	private Long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date createtime;
	private boolean isactive;
	private boolean islocaldelete;
	private String name;
	private String politicsstatus;
	private String position;
	private String relation;
	private String sex;
	private Long updateby;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
	private String workunit;
	private Long driverid;

    public Driverfamilymember() {
    }


	
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}


   
	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
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


	@Column(nullable=false, precision=1)
	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}


	@Column(nullable=false, precision=1)
	public boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}


	@Column(nullable=false, length=20)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}


	@Column(length=10)
	public String getPoliticsstatus() {
		return this.politicsstatus;
	}

	public void setPoliticsstatus(String politicsstatus) {
		this.politicsstatus = politicsstatus;
	}


	@Column(length=20)
	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}


	@Column(nullable=false, length=10)
	public String getRelation() {
		return this.relation;
	}

	public void setRelation(String relation) {
		this.relation = relation;
	}


	@Column(nullable=false, length=2)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
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


	@Column(length=100)
	public String getWorkunit() {
		return this.workunit;
	}

	public void setWorkunit(String workunit) {
		this.workunit = workunit;
	}


	public Long getDriverid() {
		return driverid;
	}


	public void setDriverid(Long driverid) {
		this.driverid = driverid;
	}

	/**
	//bi-directional many-to-one association to Driver
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="DRIVERID", nullable=false)
	public Driver getDriver() {
		return this.driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}
	**/
}