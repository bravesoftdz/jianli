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
 * Title: 乘务员工作经历信息
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
@Table(name="STEWARDWORKEXPERIENCE")
public class Stewardworkexperience implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name="STEWARDWORKEXPERIENCE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="STEWARDWORKEXPERIENCE_ID_GENERATOR")
	private long id;
	private Long createby;
    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;
    @Temporal( TemporalType.DATE)
	private Date enddate;
	private boolean isactive;
	private boolean islocaldelete;
	private String position;
	private String resume;
    @Temporal( TemporalType.DATE)
	private Date startdate;
	private Long updateby;
    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
	private String workunit;
	private Long stewardid;
	//private Steward steward;
	
    public Stewardworkexperience() {
    }



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



	@Column(nullable=false)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}



	@Column(nullable=false)
	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
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


	@Column(nullable=false, length=50)
	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}


	@Column(length=1000)
	public String getResume() {
		return this.resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}


	@Column(nullable=false)
	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}


	@Column(nullable=false, precision=10)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}


	@Column(nullable=false)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}


	@Column(nullable=false, length=100)
	public String getWorkunit() {
		return this.workunit;
	}

	public void setWorkunit(String workunit) {
		this.workunit = workunit;
	}


	@Column(nullable=false, length=10)
	public Long getStewardid() {
		return stewardid;
	}


	public void setStewardid(Long stewardid) {
		this.stewardid = stewardid;
	}

	/**
	//bi-directional many-to-one association to Steward
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="STEWARDID", nullable=false)
	public Steward getSteward() {
		return this.steward;
	}

	public void setSteward(Steward steward) {
		this.steward = steward;
	}
	**/
}