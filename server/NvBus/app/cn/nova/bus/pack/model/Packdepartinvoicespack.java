package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "PACKDEPARTINVOICESPACK")
public class Packdepartinvoicespack implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACKDEPARTINVOICESPACK_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKDEPARTINVOICESPACK_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	
	private long packid;
	
	private long packdepartinvoicesid;
		

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n sys;//date

	@Column(nullable=false)
	
	private long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n sys;//date

	@Column(nullable=false)
	
	private long updateby;// number(10) n
	
	
	public Packdepartinvoicespack() {
		// TODO Auto-generated constructor stub
	}


	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public long getPackid() {
		return packid;
	}


	public void setPackid(long packid) {
		this.packid = packid;
	}


	public long getPackdepartinvoicesid() {
		return packdepartinvoicesid;
	}


	public void setPackdepartinvoicesid(long packdepartinvoicesid) {
		this.packdepartinvoicesid = packdepartinvoicesid;
	}


	public Date getCreatetime() {
		return createtime;
	}


	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}


	public long getCreateby() {
		return createby;
	}


	public void setCreateby(long createby) {
		this.createby = createby;
	}


	public Date getUpdatetime() {
		return updatetime;
	}


	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}


	public long getUpdateby() {
		return updateby;
	}


	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}
	
	
}
