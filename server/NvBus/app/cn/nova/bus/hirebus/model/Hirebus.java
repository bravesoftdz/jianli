package cn.nova.bus.hirebus.model;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "HIREBUS")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Hirebus implements Serializable, Cloneable {

	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "HIREBUS_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "HIREBUS_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id;// ;//number(10) n

	private String hireunit;// varchar2(100) n 包车单位

	private String hirebusno;// 包车单号

	@Temporal(TemporalType.TIMESTAMP)
	private Date hiredate;// date n 用车日期

	private long unitid;// number(10) n 车属单位
	
	//private Long vehicleid;// number(10) y 车辆
	
	@JoinColumn(name = "VEHICLEID", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Vehicle vehicle;
	
	private String startstation;// varchar2(50) n 包车起点
	private String endstation;// varchar2(50) n 包车到站
	private int distance;// number(5) n 计费里程
	private BigDecimal basefee;// number(8,2) n 包车运费

	@Temporal(TemporalType.TIMESTAMP)
	private Date startdate;// date n 包车开始日期

	@Temporal(TemporalType.TIMESTAMP)
	private Date enddate;// date n 包车结束日期

	private Integer usehour;// number(5) y 计费时间：单位小时

	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal insurefee;// number(8,2) n 保险费

	private int actpeople;// number(5) n 实载人数

	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal otherfee;// number(8,2) n 其他费用

	private String feetype;// varchar2(10) n 计费方式

	@Column(nullable = true, precision = 3, scale = 2)
	private BigDecimal feerate;// number(3,2) y 费率

	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal totalfee;// number(8,2) y 总费用

	private String remark;// varchar2(200) y 备注

	private long operater;// number(10) n 经办人

	private long orgid;// number(10) n 添加机构

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n sysdate

	private long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n sysdate

	private long updateby;// number(10) n
	@Column(nullable = false, length = 40)
	private String synccode;// varchar2(40) n

	private long districtid;

	private String status;

	private String type;

	private long ticketoutletsid;

	private String districttype;

	public Hirebus() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getHireunit() {
		return hireunit;
	}

	public void setHireunit(String hireunit) {
		this.hireunit = hireunit;
	}

	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public long getUnitid() {
		return unitid;
	}

	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}

//	public Long getVehicleid() {
//		return vehicleid;
//	}
//
//	public void setVehicleid(Long vehicleid) {
//		this.vehicleid = vehicleid;
//	}

	public String getStartstation() {
		return startstation;
	}

	public void setStartstation(String startstation) {
		this.startstation = startstation;
	}

	public String getEndstation() {
		return endstation;
	}

	public void setEndstation(String endstation) {
		this.endstation = endstation;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Integer getUsehour() {
		return usehour;
	}

	public void setUsehour(Integer usehour) {
		this.usehour = usehour;
	}

	

	public int getActpeople() {
		return actpeople;
	}

	public void setActpeople(int actpeople) {
		this.actpeople = actpeople;
	}

	

	public String getFeetype() {
		return feetype;
	}

	public void setFeetype(String feetype) {
		this.feetype = feetype;
	}


	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public long getOperater() {
		return operater;
	}

	public void setOperater(long operater) {
		this.operater = operater;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
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

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHirebusno() {
		return hirebusno;
	}

	public void setHirebusno(String hirebusno) {
		this.hirebusno = hirebusno;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public String getDistricttype() {
		return districttype;
	}

	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}

	public long getDistrictid() {
		return districtid;
	}

	public void setDistrictid(long districtid) {
		this.districtid = districtid;
	}

	public BigDecimal getBasefee() {
		return basefee;
	}

	public void setBasefee(BigDecimal basefee) {
		this.basefee = basefee;
	}

	public BigDecimal getInsurefee() {
		return insurefee;
	}

	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}

	public BigDecimal getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}

	public BigDecimal getFeerate() {
		return feerate;
	}

	public void setFeerate(BigDecimal feerate) {
		this.feerate = feerate;
	}

	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}

	@Override
	public Object clone() {
		Object o = null;
		try {
			o = super.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return o;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

//	public void setVehicleid(long vehicleid) {
//		this.vehicleid = vehicleid;
//	}
	
	
}
