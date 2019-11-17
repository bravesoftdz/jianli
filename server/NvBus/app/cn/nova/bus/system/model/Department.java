package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the DEPARTMENT database table.
 * @author lijh
 */
@Entity
public class Department implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="DEPARTMENT_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="DEPARTMENT_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private String code;

	private String contactperson;

	private String contactphone;

	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private String describe;

	private String name;

	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	@JoinColumn(name="PARENTID")
	private Long parentid;

	@OneToOne
	@JoinColumn(name = "supervisorid", nullable = true)
	private Userinfo supervisor;

	private boolean isactive;
	
    public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Userinfo getSupervisor() {
		return supervisor;
	}

	public void setSupervisor(Userinfo supervisor) {
		this.supervisor = supervisor;
	}

	public Department() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContactperson() {
		return this.contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getDescribe() {
		return this.describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

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

	public Long getParentid() {
		return parentid;
	}

	public void setParentid(Long parentid) {
		this.parentid = parentid;
	}


	public String getContactphone() {
		return contactphone;
	}

	public void setContactphone(String contactphone) {
		this.contactphone = contactphone;
	}

	@Override
	public String toString() {
		return "Department [id=" + id + ", code=" + code + ", contactperson="
				+ contactperson + ", contactphone=" + contactphone
				+ ", createby=" + createby + ", createtime=" + createtime
				+ ", describe=" + describe + ", name=" + name + ", updateby="
				+ updateby + ", updatetime=" + updatetime + ", parentid="
				+ parentid + "]";
	}
	
}