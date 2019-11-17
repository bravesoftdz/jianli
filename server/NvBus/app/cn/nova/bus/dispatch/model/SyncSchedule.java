package cn.nova.bus.dispatch.model;

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
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * <b>类名称：</b>Schedule <br/>
 * <b>类描述：</b>班次信息<br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2016年1月6日 下午8:39:20<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class})
@Table(name = "SCHEDULE")
public class SyncSchedule implements Serializable {
	
	public static final long serialVersionUID = 1L;

	@Id
//	@SequenceGenerator(name = "SCHEDULE_ID_GENERATOR", sequenceName = "SEQ_SCHEDULE", allocationSize = 1)
	@SequenceGenerator(name = "SCHEDULE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULE_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	public Long id;
	/*所属线路 ID*/
	public Long routeid;
	@Transient
	public String routesynccode;
	@Transient
	public String routecode;
	@Transient
	public String routeorgcode;
	/*所属机构 ID*/
	public Long orgid;
	/*班次号(班次操作码)*/
	public String code;
	/*营运类别(1单营、2共营)*/
	public String worktype;
	/*营运方式(直达、普通、城乡公交、的士)*/
	public String workways;
	/*区域类型(1县内、2县际、3市际、4省际、5国际)*/
	public String districttype;
	/*班次类型(1私定、2普通)*/
	public String type;
	/*始发时间*/
	public String starttime;
	/*运行时间*/
	public BigDecimal runtime;
	/*是否本站专有班次*/
	public boolean isproprietary;
	/*加班班次*/
	public boolean isovertime;
	/*是否售回程票(终点站)*/
	public boolean issellreturnticket;
	/*是否流水班次*/
	public boolean islinework;
	/*结束时间*/
	public String endtime;
	/*发车时间间隔*/
	public Short spacinginterval;
	/*是否始发班次(非过路班次)*/
	public boolean isoriginator;
	/*是否报到后售票*/
	public boolean issaleafterreport;
	/*是否允许混检*/
	public boolean iscanmixcheck;
	/*计划座位数*/
	public Short planseatnum;
	/*途经站点*/
	public String viastation;
	/*打印信息*/
	public String printinfo;
	/*备注*/
	public String remarks;
	/*是否已审核*/
	public boolean isaudited;
	/*是否审核通过*/
	public boolean isauditpass;
	/*是否注销*/
	public boolean isactive;
	
	@Temporal(TemporalType.TIMESTAMP)
	public Date createtime;
	public Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	public Date updatetime;
	public Long updateby;
	
	public String synccode;
	/*是否是固定座位班次，若为固定座位，报到时不随车辆座位数而变化*/
	public boolean isfixseat;
	/*是否需要指纹才能报班*/
	public boolean isneedfinger;
	/*驾驶员报班人数*/
	public Short driverfingernum;
	/*终到车站*/
	public String endstation;
	/*始发站票价*/
	public BigDecimal startstationprice;
	
	@Transient
	public Integer flag;
//	@Transient
//	public SyncRoute route;
	@Transient
	public String orgcode;

	@Override
	public String toString() {
		return "SyncSchedule [id=" + id + ", routeid=" + routeid + ", routesynccode=" + routesynccode + ", routecode="
				+ routecode + ", routeorgcode=" + routeorgcode + ", orgid=" + orgid + ", code=" + code + ", worktype="
				+ worktype + ", workways=" + workways + ", districttype=" + districttype + ", type=" + type
				+ ", starttime=" + starttime + ", runtime=" + runtime + ", isproprietary=" + isproprietary
				+ ", isovertime=" + isovertime + ", issellreturnticket=" + issellreturnticket + ", islinework="
				+ islinework + ", endtime=" + endtime + ", spacinginterval=" + spacinginterval + ", isoriginator="
				+ isoriginator + ", issaleafterreport=" + issaleafterreport + ", iscanmixcheck=" + iscanmixcheck
				+ ", planseatnum=" + planseatnum + ", viastation=" + viastation + ", printinfo=" + printinfo
				+ ", remarks=" + remarks + ", isaudited=" + isaudited + ", isauditpass=" + isauditpass + ", isactive="
				+ isactive + ", createtime=" + createtime + ", createby=" + createby + ", updatetime=" + updatetime
				+ ", updateby=" + updateby + ", synccode=" + synccode + ", isfixseat=" + isfixseat + ", isneedfinger="
				+ isneedfinger + ", driverfingernum=" + driverfingernum + ", endstation=" + endstation
				+ ", startstationprice=" + startstationprice + ", flag=" + flag + ", orgcode=" + orgcode + "]";
	}
	
	
	
}