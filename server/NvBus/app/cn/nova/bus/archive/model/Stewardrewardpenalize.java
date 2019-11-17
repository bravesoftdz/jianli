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
 * Title: 乘务员奖惩记录信息
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
@Table(name="STEWARDREWARDPENALIZE")
public class Stewardrewardpenalize implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name="STEWARDREWARDPENALIZE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="STEWARDREWARDPENALIZE_ID_GENERATOR")
	private long id;
	private String content;
	private Long createby;
    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;
	private boolean isactive;
	private boolean islocaldelete;
	private String reason;
    @Temporal( TemporalType.DATE)
	private Date rewarddate;
	private String type;
	
	private Long updateby;
    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
	private Long stewardid;

    public Stewardrewardpenalize() {
    }



	@Column(unique=true, nullable=false, precision=10)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}


	@Column(nullable=false, length=2000)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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
	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}



	@Column(nullable=false)
	public Date getRewarddate() {
		return this.rewarddate;
	}

	public void setRewarddate(Date rewarddate) {
		this.rewarddate = rewarddate;
	}


	@Column(nullable=false, length=10)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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