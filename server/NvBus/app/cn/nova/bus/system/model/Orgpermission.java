package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the ORGPERMISSION database table.
 * 
 */
@Entity
public class Orgpermission implements Serializable {
	private static final long serialVersionUID = 1L;
	@Transient
    private String opertype;  //2删除  4插入 8修改
	@Transient
	private boolean isselect;
	
	@Id
	@SequenceGenerator(name="ORGPERMISSION_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ORGPERMISSION_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	private long roleid;

	private long orgid;
	
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;



    public Orgpermission() {
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

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}


	public long getRoleid() {
		return roleid;
	}


	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}


	public long getOrgid() {
		return orgid;
	}


	public void setIsselect(boolean isselect) {
		this.isselect = isselect;
	}


	public boolean getIsselect() {
		return isselect;
	}


	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}


	public String getOpertype() {
		return opertype;
	}


	public void setId(long id) {
		this.id = id;
	}


	public long getId() {
		return id;
	}


}