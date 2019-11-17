package cn.nova.bus.job.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.joda.time.DateTime;

import play.db.jpa.GenericModel;
import util.DateUtils;

/**
 * <b>类描述：</b>系统中所有自动运行的可管理的定时任务配置类。任务的执行依赖于Quartz框架<br/>
 * <b>类名称：</b>Jobconfig<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b>增加了type字段，便于有选择的过滤启动某些类型的job<br/>
 * <b>修改时间：</b>2012-02-28<br/>
 * <b>修改人：</b>兰浩<br/>
 */
@Entity
@Table(name="JOBCONFIG")
public class Jobconfig  extends GenericModel{
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private long createby;

   @Temporal(TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, length=5)
	private String endtime;

	@Column(nullable=false, length=100)
	private String fullclassname;

	@Column(nullable=false, precision=10)
	private long intervals;

	@Column(nullable=false, precision=2)
	private byte intervaltype;

	@Column(nullable=false, precision=1)
	private boolean isactive;
	
	@Column(nullable=true, precision=1)
	private int type;

	@Column(nullable=false, length=40)
	private String jobname;

	
	/**
	 * lastruntime:最近一次任务运行的时间
	 */
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastruntime;

	@Column(nullable=true, precision=10)
	private long orgid;

	@Column(nullable=true, length=1000)
	private String parameters;

	@Column(length=100)
	private String remarks;

	@Column(nullable=false, length=5)
	private String starttime;

	@Column(nullable=false, precision=10)
	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;
	
	public Jobconfig() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getEndtime() {
		return this.endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getFullclassname() {
		return this.fullclassname;
	}

	public void setFullclassname(String fullclassname) {
		this.fullclassname = fullclassname;
	}

	public long getIntervals() {
		return this.intervals;
	}

	public void setIntervals(long intervals) {
		this.intervals = intervals;
	}

	public byte getIntervaltype() {
		return this.intervaltype;
	}

	public void setIntervaltype(byte intervaltype) {
		this.intervaltype = intervaltype;
	}

	public int getType() {
    return type;
  }

  public void setType(int type) {
    this.type = type;
  }

  public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public String getJobname() {
		return this.jobname;
	}

	public void setJobname(String jobname) {
		this.jobname = jobname;
	}

	public Date getLastruntime() {
		return this.lastruntime;
	}

	public void setLastruntime(Date lastruntime) {
		this.lastruntime = lastruntime;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getParameters() {
		return this.parameters;
	}

	public void setParameters(String parameters) {
		this.parameters = parameters;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getStarttime() {
		return this.starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	/*
	 * 以下为相关业务方法封装
	 * */
  /**
   * getIntervalSeconds方法：获取任务执行的间隔时间，以秒为单位<br/>
   * @return 以秒为单位的任务间隔时间
   * @exception 
   */
  public int getIntervalSeconds(){
    switch(getIntervaltype()){
      case (INTERVAL_UNIT_SECOND):return (int) getIntervals();
      case (INTERVAL_UNIT_MINUTE):return (int) (getIntervals()*60);
      case (INTERVAL_UNIT_HOUR):return (int) (getIntervals()*3600);
      case (INTERVAL_UNIT_DAY):return (int) (getIntervals()*3600*24);
      default:return getIntervaltype();
    }
  }
  
  /**
   * 定义任务间隔时间单位的静态变量，可参考JOBCONFIG表INTERVALS字段的注释
   */
  public final static byte INTERVAL_UNIT_MILLISECOND = 0;
  public final static byte INTERVAL_UNIT_SECOND = 1;
  public final static byte INTERVAL_UNIT_MINUTE = 2;
  public final static byte INTERVAL_UNIT_HOUR = 3;
  public final static byte INTERVAL_UNIT_DAY = 4;
  public final static byte INTERVAL_UNIT_WEEK = 5;
  public final static byte INTERVAL_UNIT_MONTH = 6;
  public final static byte INTERVAL_UNIT_YEAR = 7;
  
  /**
   * getCronExpression方法：根据任务配自获取相应的cron表达式<br/>  
   * @return cron表达式字符串，如果Lastruntime早于当前时间，返回null
   */
  public String getCronExpression(){
    switch(getIntervaltype()){
      case (INTERVAL_UNIT_SECOND):{
        return "0/"+getIntervals() + " "+getStarttime().substring(3, 5)+"-"+getEndtime().substring(3, 5)+" "+getStarttime().substring(0, 2)+"-"+getEndtime().substring(0, 2)+" ? * * *";
      }
      case (INTERVAL_UNIT_MINUTE):{
        return "0 0/"+getIntervals() + " "+getStarttime().substring(0, 2)+"-"+getEndtime().substring(0, 2)+" ? * * *";
      }
      case (INTERVAL_UNIT_HOUR):{
        return "0 0 "+getStarttime().substring(0, 2)+"-"+getEndtime().substring(0, 2)+"/"+getIntervals() + " ? * * *";
      }
      case (INTERVAL_UNIT_DAY):{
        //如果单位是天，那么endtime不起作用
        //NOTICE:这里使用的是每天都执行，并未使用getIntervals字段值，因为目前的设计中未有配置起始日期处
        return "0 "+getStarttime().substring(3, 5)+" "+getStarttime().substring(0, 2)+" ? * * *";
      }
      default:{
        return null;
      }
    }
  }
  
  public boolean isTriggerTime(){
	  DateTime lastTime = new DateTime(lastruntime);
	  DateTime nowTime = new DateTime();
	  Date now=new Date();
	  if(DateUtils.compare(lastruntime,now)>0){
		 return true;
	  }
	  switch(intervaltype){
	    case(INTERVAL_UNIT_SECOND):
	    	lastTime=lastTime.plusSeconds((int) intervals);
	     break;
	    case(INTERVAL_UNIT_MINUTE):
	    	lastTime=lastTime.plusMinutes((int) intervals);
	    break;
	    case(INTERVAL_UNIT_HOUR):
	    	lastTime=lastTime.plusHours((int) intervals);
        break;
	    case(INTERVAL_UNIT_DAY):
	    	lastTime=lastTime.plusDays((int) intervals);
	    break;
        default:
        	return false;
	  }
	  return lastTime.isBefore(nowTime);
  }
}