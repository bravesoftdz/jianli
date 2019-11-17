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
import javax.persistence.Transient;


/**
 * The persistent class for the MENUPERMISSION database table.
 * 
 */
@Entity
@Table(name="MENUPERMISSION")
public class Menupermission implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="MENUPERMISSION_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="MENUPERMISSION_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Transient
    private String opertype;  //2删除  4插入 8修改

	@Transient
	private boolean isselect;
	
	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(precision=10)
	private Long functionpermissionregid;

	@Column(nullable=false, precision=10)
	private long menuid;

	@Column(nullable=false, precision=10)
	private long roleid;

	@Column(nullable=false, precision=2)
	private byte type;

    public Menupermission() {
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

	public Long getFunctionpermissionregid() {
		return this.functionpermissionregid;
	}

	public void setFunctionpermissionregid(Long functionpermissionregid) {
		this.functionpermissionregid = functionpermissionregid;
	}

	public long getMenuid() {
		return this.menuid;
	}

	public void setMenuid(long menuid) {
		this.menuid = menuid;
	}

	public long getRoleid() {
		return this.roleid;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}

	public byte getType() {
		return this.type;
	}

	public void setType(byte type) {
		this.type = type;
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

}