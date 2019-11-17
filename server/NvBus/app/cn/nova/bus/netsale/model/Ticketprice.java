package cn.nova.bus.netsale.model;

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

import cn.nova.utils.orm.listener.SyncCodeGenerate;


public class Ticketprice implements Serializable {
	private static final long serialVersionUID = 1L;

	private long id;

	private short autocancelreserveseatnum;

	private long createby;

	private Date createtime;

	private Date departdate;

	private long departstationid;
	
	private short fixedreserveseatnum;

	private BigDecimal fullprice;

	private BigDecimal halfprice;

	private boolean issellable;

	private long orgid;
	
	private long reachstationid;
	
	private BigDecimal stationservicefee;
	
	private BigDecimal fueladditionfee;

	private BigDecimal runtime;

	private long scheduleid;
	
	private long scheduleplanid;
	
	private String seatnos;

	private short seatnum;

	private String seattype;

	private short soldeatnum;

	private BigDecimal studentprice;

	private short unautocancelreserveseatnum;
	
	private int distance;
	
	private int balancedistance;
	
	private BigDecimal toplimitprice;

	private BigDecimal lowerlimitprice;

	private long updateby;

	private Date updatetime;
	
	private String synccode;
	
    private BigDecimal moreprice;
    //优惠票 、 往返票 、 联程票
	private BigDecimal discountprice;

	private BigDecimal roundprice;

	private BigDecimal connectprice;
  
  public BigDecimal getMoreprice() {
    return moreprice;
  }

  public void setMoreprice(BigDecimal moreprice) {
    this.moreprice = moreprice;
  }

  public void setSynccode(String synccode) {
    this.synccode = synccode;
  }

  public String getSynccode() {
    return synccode;
  }
  
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public short getAutocancelreserveseatnum() {
		return this.autocancelreserveseatnum;
	}

	public void setAutocancelreserveseatnum(short autocancelreserveseatnum) {
		this.autocancelreserveseatnum = autocancelreserveseatnum;
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

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getDepartstationid() {
		return this.departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public short getFixedreserveseatnum() {
		return this.fixedreserveseatnum;
	}

	public void setFixedreserveseatnum(short fixedreserveseatnum) {
		this.fixedreserveseatnum = fixedreserveseatnum;
	}

	public BigDecimal getFullprice() {
		return this.fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getHalfprice() {
		return this.halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public boolean getIssellable() {
		return this.issellable;
	}

	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getReachstationid() {
		return this.reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public BigDecimal getRuntime() {
		return this.runtime;
	}

	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getScheduleplanid() {
		return this.scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getSeatnos() {
		return this.seatnos;
	}

	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}

	public short getSeatnum() {
		return this.seatnum;
	}

	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}

	public String getSeattype() {
		return this.seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public short getSoldeatnum() {
		return this.soldeatnum;
	}

	public void setSoldeatnum(short soldeatnum) {
		this.soldeatnum = soldeatnum;
	}

	public BigDecimal getStudentprice() {
		return this.studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}

	public short getUnautocancelreserveseatnum() {
		return this.unautocancelreserveseatnum;
	}

	public void setUnautocancelreserveseatnum(short unautocancelreserveseatnum) {
		this.unautocancelreserveseatnum = unautocancelreserveseatnum;
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

  public int getDistance() {
    return distance;
  }

  public int getBalancedistance() {
    return balancedistance;
  }

  public BigDecimal getToplimitprice() {
    return toplimitprice;
  }

  public BigDecimal getLowerlimitprice() {
    return lowerlimitprice;
  }

  public void setDistance(int distance) {
    this.distance = distance;
  }

  public void setBalancedistance(int balancedistance) {
    this.balancedistance = balancedistance;
  }

  public void setToplimitprice(BigDecimal toplimitprice) {
    this.toplimitprice = toplimitprice;
  }

  public void setLowerlimitprice(BigDecimal lowerlimitprice) {
    this.lowerlimitprice = lowerlimitprice;
  }

  public BigDecimal getStationservicefee() {
    return stationservicefee;
  }

  public BigDecimal getFueladditionfee() {
    return fueladditionfee;
  }

  public void setStationservicefee(BigDecimal stationservicefee) {
    this.stationservicefee = stationservicefee;
  }

  public void setFueladditionfee(BigDecimal fueladditionfee) {
    this.fueladditionfee = fueladditionfee;
  }
  public BigDecimal getDiscountprice() {
	return discountprice;
}

public void setDiscountprice(BigDecimal discountprice) {
	this.discountprice = discountprice;
}

public BigDecimal getRoundprice() {
	return roundprice;
}

public void setRoundprice(BigDecimal roundprice) {
	this.roundprice = roundprice;
}

public BigDecimal getConnectprice() {
	return connectprice;
}

public void setConnectprice(BigDecimal connectprice) {
	this.connectprice = connectprice;
}
}