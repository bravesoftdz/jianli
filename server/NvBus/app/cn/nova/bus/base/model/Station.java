package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CascadeType;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Station<br/>
 * <b>创建人：</b><br/>
 * <b>关键修改：</b>增加了@SyncEntity注解<br/>
 * <b>修改时间：</b>2011-05-07<br/>
 * <b>修改人：</b>leeo<br/>
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Station implements Serializable {
	private static final long serialVersionUID = 8333228377036143836L;

	@Id
	@SequenceGenerator(name = "STATION_ID_GENERAT", sequenceName = "SEQ_STATION", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "STATION_ID_GENERAT")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(nullable = false)
	private String code;

	@Column(nullable = false)
	private Long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String description;

	@Column(nullable = false)
	private Long districtid;

	@Column(nullable = false)
	private String grade;

	private String helpcode;

	@Column(nullable = false)
	private boolean isactive;

	@Column(nullable = false)
	private boolean isdepart;

	@Column(nullable = false)
	private boolean islocaldelete;

	private String jianpin;

	private int distance;
	
	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	@Column(nullable = false)
	private String name;

	//@Column(columnDefinition = "nvarchar2")
	private String secondname;

	@Column(nullable = false)
	private Long orgid;

	@Column(nullable = false)
	private Long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, length = 30)
	private String synccode;

	@Column(nullable = false)
	private boolean isroundtrip;
	
	/*@JoinColumn(name = "STANDRADID", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Stationstandard stationstandard;*/
	
	private Long standradid;
	
	public Long getStandradid() {
		return standradid;
	}

	public void setStandradid(Long standradid) {
		this.standradid = standradid;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public Station() {
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

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getDistrictid() {
		return this.districtid;
	}

	public void setDistrictid(Long districtid) {
		this.districtid = districtid;
	}

	public String getGrade() {
		return this.grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getHelpcode() {
		return this.helpcode;
	}

	public void setHelpcode(String helpcode) {
		this.helpcode = helpcode;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIsdepart() {
		return this.isdepart;
	}

	public void setIsdepart(boolean isdepart) {
		this.isdepart = isdepart;
	}

	public boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public String getJianpin() {
		return this.jianpin;
	}

	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
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

	public void setSecondname(String secondname) {
		this.secondname = secondname;
	}


	public String getSecondname() {
		return secondname;
	}

	public boolean getIsroundtrip() {
		return isroundtrip;
	}

	public boolean isIsroundtrip() {
		return isroundtrip;
	}

	public void setIsroundtrip(boolean isroundtrip) {
		this.isroundtrip = isroundtrip;
	}


	
}