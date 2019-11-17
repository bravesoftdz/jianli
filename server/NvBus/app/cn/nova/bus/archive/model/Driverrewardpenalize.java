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
 * Title: 驾驶员奖惩记录信息
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
@Table(name="DRIVERREWARDPENALIZE")
public class Driverrewardpenalize implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="DRIVERREWARDPENALIZE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="DRIVERREWARDPENALIZE_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=2000)
	private String content;

	@Column(nullable=false, precision=10)
	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=10)
	private Long deductdistance;

	@Column(nullable=false, precision=10)
	private Long deductscore;

	@Column(nullable=false, precision=10)
	private Long driverid;

	@Column(nullable=false, precision=1)
	private Boolean isactive;

	@Column(nullable=false, precision=1)
	private Boolean islocaldelete;

	@Column(nullable=false, length=50)
	private String reason;

    @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date rewarddate;

	@Column(nullable=false, length=10)
	private String type;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    public Driverrewardpenalize() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Long getDeductdistance() {
		return this.deductdistance;
	}

	public void setDeductdistance(Long deductdistance) {
		this.deductdistance = deductdistance;
	}

	public Long getDeductscore() {
		return this.deductscore;
	}

	public void setDeductscore(Long deductscore) {
		this.deductscore = deductscore;
	}

	public Long getDriverid() {
		return this.driverid;
	}

	public void setDriverid(Long driverid) {
		this.driverid = driverid;
	}

	public Boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}

	public Boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public void setIslocaldelete(Boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getRewarddate() {
		return this.rewarddate;
	}

	public void setRewarddate(Date rewarddate) {
		this.rewarddate = rewarddate;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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