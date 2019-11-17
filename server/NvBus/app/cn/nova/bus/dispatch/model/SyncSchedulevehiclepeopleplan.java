package cn.nova.bus.dispatch.model;

import java.io.Serializable;
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
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.SyncCodeGenerate;
/**
 * <b>类名称：</b>SyncSchedulevehiclepeopleplan <br/>
 * <b>类描述：</b>班次车辆驾乘人员运行计划表<br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2016年1月28日 下午12:03:41<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
 */
@Entity
@EntityListeners(value = { SyncCodeGenerate.class })
@Table(name = "SCHEDULEVEHICLEPEOPLEPLAN")
public class SyncSchedulevehiclepeopleplan implements Serializable {
	
	private static final Long serialVersionUID = 21256956346563L;

	@Id
//	@SequenceGenerator(name = "SCHEDULEVEHICLEPEOPLEPLAN_ID_GENERATOR", sequenceName = "SEQ_SCHEDULEVEHICLEPEOPLEPLAN", allocationSize = 1)
	@SequenceGenerator(name = "SCHEDULEVEHICLEPEOPLEPLAN_ID_GENERATOR", sequenceName = "SEQ_SCHEDULEVEHPLAN", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEVEHICLEPEOPLEPLAN_ID_GENERATOR")
	@Column(nullable = false, unique = false)
	private Long id;
	/*计划报到车牌id--(可为空)*/
	private Long planvehicleid;
	/*计划报到车型id*/
	private Long planvehicletypeid;
	/*班次id*/
	private Long scheduleid;
	@Transient
	public String schedulesynccode;
	/*班次运行计划ID*/
	private Long scheduleplanid;
	/*发车日期*/
	@Temporal(TemporalType.DATE)
	private Date departdate;
	/*报到序号，流水班次适用 注销的序号不重复利用*/
	private short orderno;
	/**/
	private Long orgid;
	/*计划报到车辆品牌型号ID*/
	private Long planvehiclebrandmodelid;	
	/*计划报到车属单位ID--(可为空)*/
	private Long planunitid;
	/*计划报到驾驭员id--(可为空)*/
	private Long plandriver1id;

	private Long plandriver2id;

	private Long plandriver3id;

	private Long plandriver4id;
	/*计划报到乘务员id--(可为空)*/
	private Long plansteward1id;

	private Long plansteward2id;
	
	private Long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	
	private Long updateby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	/*全局同步编码*/
	private String synccode;
	
	@Transient
	private Integer flag;
	@Transient
	private String plandriver1idcard;
	@Transient
	private String plandriver2idcard;
	@Transient
	private String plandriver3idcard;
	@Transient
	private String plandriver4idcard;
	@Transient
	private String plansteward1idcard;
	@Transient
	private String plansteward2idcard;
	@Transient
	private String planunitname;
	@Transient
	private String planvehiclebrandmodelname;
	@Transient
	private String planvehiclebrandmodelcode;
	@Transient
	private String planvehiclenno;
	@Transient 
	private String planvehicletypename;
	@Transient
	private String schedulecode;
	@Transient
	private String orgname;
	@Transient
	public String orgcode;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getPlanvehicleid() {
		return planvehicleid;
	}
	public void setPlanvehicleid(Long planvehicleid) {
		this.planvehicleid = planvehicleid;
	}
	public Long getPlanvehicletypeid() {
		return planvehicletypeid;
	}
	public void setPlanvehicletypeid(Long planvehicletypeid) {
		this.planvehicletypeid = planvehicletypeid;
	}
	public Long getScheduleid() {
		return scheduleid;
	}
	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}
	public Long getScheduleplanid() {
		return scheduleplanid;
	}
	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}
	public Date getDepartdate() {
		return departdate;
	}
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	public short getOrderno() {
		return orderno;
	}
	public void setOrderno(short orderno) {
		this.orderno = orderno;
	}
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	public Long getPlanvehiclebrandmodelid() {
		return planvehiclebrandmodelid;
	}
	public void setPlanvehiclebrandmodelid(Long planvehiclebrandmodelid) {
		this.planvehiclebrandmodelid = planvehiclebrandmodelid;
	}
	public Long getPlanunitid() {
		return planunitid;
	}
	public void setPlanunitid(Long planunitid) {
		this.planunitid = planunitid;
	}
	public Long getPlandriver1id() {
		return plandriver1id;
	}
	public void setPlandriver1id(Long plandriver1id) {
		this.plandriver1id = plandriver1id;
	}
	public Long getPlandriver2id() {
		return plandriver2id;
	}
	public void setPlandriver2id(Long plandriver2id) {
		this.plandriver2id = plandriver2id;
	}
	public Long getPlandriver3id() {
		return plandriver3id;
	}
	public void setPlandriver3id(Long plandriver3id) {
		this.plandriver3id = plandriver3id;
	}
	public Long getPlandriver4id() {
		return plandriver4id;
	}
	public void setPlandriver4id(Long plandriver4id) {
		this.plandriver4id = plandriver4id;
	}
	public Long getPlansteward1id() {
		return plansteward1id;
	}
	public void setPlansteward1id(Long plansteward1id) {
		this.plansteward1id = plansteward1id;
	}
	public Long getPlansteward2id() {
		return plansteward2id;
	}
	public void setPlansteward2id(Long plansteward2id) {
		this.plansteward2id = plansteward2id;
	}
	public Long getCreateby() {
		return createby;
	}
	public void setCreateby(Long createby) {
		this.createby = createby;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public Long getUpdateby() {
		return updateby;
	}
	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public String getSynccode() {
		return synccode;
	}
	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public String getPlandriver1idcard() {
		return plandriver1idcard;
	}
	public void setPlandriver1idcard(String plandriver1idcard) {
		this.plandriver1idcard = plandriver1idcard;
	}
	public String getPlandriver2idcard() {
		return plandriver2idcard;
	}
	public void setPlandriver2idcard(String plandriver2idcard) {
		this.plandriver2idcard = plandriver2idcard;
	}
	public String getPlandriver3idcard() {
		return plandriver3idcard;
	}
	public void setPlandriver3idcard(String plandriver3idcard) {
		this.plandriver3idcard = plandriver3idcard;
	}
	public String getPlandriver4idcard() {
		return plandriver4idcard;
	}
	public void setPlandriver4idcard(String plandriver4idcard) {
		this.plandriver4idcard = plandriver4idcard;
	}
	public String getPlansteward1idcard() {
		return plansteward1idcard;
	}
	public void setPlansteward1idcard(String plansteward1idcard) {
		this.plansteward1idcard = plansteward1idcard;
	}
	public String getPlansteward2idcard() {
		return plansteward2idcard;
	}
	public void setPlansteward2idcard(String plansteward2idcard) {
		this.plansteward2idcard = plansteward2idcard;
	}
	public String getPlanunitname() {
		return planunitname;
	}
	public void setPlanunitname(String planunitname) {
		this.planunitname = planunitname;
	}
	public String getPlanvehiclebrandmodelname() {
		return planvehiclebrandmodelname;
	}
	public void setPlanvehiclebrandmodelname(String planvehiclebrandmodelname) {
		this.planvehiclebrandmodelname = planvehiclebrandmodelname;
	}
	public String getPlanvehiclebrandmodelcode() {
		return planvehiclebrandmodelcode;
	}
	public void setPlanvehiclebrandmodelcode(String planvehiclebrandmodelcode) {
		this.planvehiclebrandmodelcode = planvehiclebrandmodelcode;
	}
	public String getPlanvehiclenno() {
		return planvehiclenno;
	}
	public void setPlanvehiclenno(String planvehiclenno) {
		this.planvehiclenno = planvehiclenno;
	}
	public String getPlanvehicletypename() {
		return planvehicletypename;
	}
	public void setPlanvehicletypename(String planvehicletypename) {
		this.planvehicletypename = planvehicletypename;
	}
	public String getSchedulecode() {
		return schedulecode;
	}
	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	@Override
	public String toString() {
		return "SyncSchedulevehiclepeopleplan [id=" + id + ", planvehicleid=" + planvehicleid + ", planvehicletypeid="
				+ planvehicletypeid + ", scheduleid=" + scheduleid + ", schedulesynccode=" + schedulesynccode
				+ ", scheduleplanid=" + scheduleplanid + ", departdate=" + departdate + ", orderno=" + orderno
				+ ", orgid=" + orgid + ", planvehiclebrandmodelid=" + planvehiclebrandmodelid + ", planunitid="
				+ planunitid + ", plandriver1id=" + plandriver1id + ", plandriver2id=" + plandriver2id
				+ ", plandriver3id=" + plandriver3id + ", plandriver4id=" + plandriver4id + ", plansteward1id="
				+ plansteward1id + ", plansteward2id=" + plansteward2id + ", createby=" + createby + ", createtime="
				+ createtime + ", updateby=" + updateby + ", updatetime=" + updatetime + ", synccode=" + synccode
				+ ", flag=" + flag + ", plandriver1idcard=" + plandriver1idcard + ", plandriver2idcard="
				+ plandriver2idcard + ", plandriver3idcard=" + plandriver3idcard + ", plandriver4idcard="
				+ plandriver4idcard + ", plansteward1idcard=" + plansteward1idcard + ", plansteward2idcard="
				+ plansteward2idcard + ", planunitname=" + planunitname + ", planvehiclebrandmodelname="
				+ planvehiclebrandmodelname + ", planvehiclebrandmodelcode=" + planvehiclebrandmodelcode
				+ ", planvehiclenno=" + planvehiclenno + ", planvehicletypename=" + planvehicletypename
				+ ", schedulecode=" + schedulecode + ", orgname=" + orgname + ", orgcode=" + orgcode + "]";
	}
	
	
}
