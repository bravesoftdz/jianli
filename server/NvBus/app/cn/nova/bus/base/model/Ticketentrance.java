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
 * The persistent class for the TICKETENTRANCE database table.
 * 检票口设置
 * huanghaoze
 */
@Entity
@Table(name="TICKETENTRANCE")
public class Ticketentrance implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name="TICKETENTRANCE_ID_GENERATOR", sequenceName="SEQ_TICKETENTRANCE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETENTRANCE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	@Column(nullable=false, precision=10)
	private Long createby;
	
    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;
    
	@Column(nullable=false, precision=1)
	private boolean isactive;
	
	@Column(nullable=false, length=60)
	private String name;
	
	@Column(nullable=false, precision=10)
	private Long orgid;
	
	@Column(nullable=false, length=60)
	private String printname;
	
	@Column(length=100)
	private String remarks;
	
	@Column(precision=10)
	private Long updateby;
	
    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Ticketentrance() {
    }
	
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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
	
	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}
	
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}



	public String getPrintname() {
		return this.printname;
	}

	public void setPrintname(String printname) {
		this.printname = printname;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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