package cn.nova.bus.archive.model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class CustomerUpdateVo {

	@Id
	private long id;
	private String departstationname;   //发车站
	private String reachstationname;   //到达站
	private String endstationname;    //目的地
	private String schcode;    //班次
	private String planvehicleno;   //车牌号码
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDepartstationname() {
		return departstationname;
	}
	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}
	public String getReachstationname() {
		return reachstationname;
	}
	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}
	public String getEndstationname() {
		return endstationname;
	}
	public void setEndstationname(String endstationname) {
		this.endstationname = endstationname;
	}
	public String getSchcode() {
		return schcode;
	}
	public void setSchcode(String schcode) {
		this.schcode = schcode;
	}
	public String getPlanvehicleno() {
		return planvehicleno;
	}
	public void setPlanvehicleno(String planvehicleno) {
		this.planvehicleno = planvehicleno;
	}
	
	
}
