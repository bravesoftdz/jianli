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
 * The persistent class for the DIGITALDICTIONARY database table.
 * 
 */
@Entity
@Table(name="DIGITALDICTIONARY")
public class Digitaldictionary implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="DIGITALDICTIONARY_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="DIGITALDICTIONARY_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=30)
	private String columnname;

	@Column(length=200)
	private String describe;

	@Column(nullable=false, precision=1)
	private boolean iscanedit;

	@Column(nullable=false, length=30)
	private String name;

	@Column(nullable=false, length=30)
	private String tablename;

	@Column(precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Digitaldictionary() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getColumnname() {
		return this.columnname;
	}

	public void setColumnname(String columnname) {
		this.columnname = columnname;
	}

	public String getDescribe() {
		return this.describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public boolean getIscanedit() {
		return this.iscanedit;
	}

	public void setIscanedit(boolean iscanedit) {
		this.iscanedit = iscanedit;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTablename() {
		return this.tablename;
	}

	public void setTablename(String tablename) {
		this.tablename = tablename;
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

}