package cn.nova.bus.pack.vo;

import java.io.Serializable;
import java.util.Date;

public class PackStockVO implements Serializable{
	
	private String code;
	private String departdate;
	private String departtime;
	private String vehicleno;
	private String drivername;
	private String unitname;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getDepartdate() {
		return departdate;
	}
	public void setDepartdate(String departdate) {
		this.departdate = departdate;
	}
	public String getDeparttime() {
		return departtime;
	}
	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}
	public String getVehicleno() {
		return vehicleno;
	}
	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}
	public String getDrivername() {
		return drivername;
	}
	public void setDrivername(String drivername) {
		this.drivername = drivername;
	}
	public String getUnitname() {
		return unitname;
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
				

}
