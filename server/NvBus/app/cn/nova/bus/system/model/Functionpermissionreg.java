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
 * The persistent class for the FUNCTIONPERMISSIONREG database table.
 * 
 */
@Entity
@Table(name="FUNCTIONPERMISSIONREG")
public class Functionpermissionreg implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="FUNCTIONPERMISSIONREG_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="FUNCTIONPERMISSIONREG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=10)
	private long functionregid;

	@Column(length=100)
	private String permissiondescribe;

	@Column(nullable=false, length=40)
	private String permissionkey;

	@Column(nullable=false, length=30)
	private String permissionname;

	@Column(nullable=false, precision=10)
	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    public Functionpermissionreg() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public long getFunctionregid() {
		return this.functionregid;
	}

	public void setFunctionregid(long functionregid) {
		this.functionregid = functionregid;
	}

	public String getPermissiondescribe() {
		return this.permissiondescribe;
	}

	public void setPermissiondescribe(String permissiondescribe) {
		this.permissiondescribe = permissiondescribe;
	}

	public String getPermissionkey() {
		return this.permissionkey;
	}

	public void setPermissionkey(String permissionkey) {
		this.permissionkey = permissionkey;
	}

	public String getPermissionname() {
		return this.permissionname;
	}

	public void setPermissionname(String permissionname) {
		this.permissionname = permissionname;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}