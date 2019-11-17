package cn.nova.bus.pack.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class PackDeparVO implements Serializable{
	
	private long packdepartinvoicesid;
	private String departinvoicesno;
	private Date departdate;
	private long tostationid;
	private long vehicleid;
	private BigDecimal shipprice;
	private BigDecimal balancemount;

	public long getPackdepartinvoicesid() {
		return packdepartinvoicesid;
	}
	public void setPackdepartinvoicesid(long packdepartinvoicesid) {
		this.packdepartinvoicesid = packdepartinvoicesid;
	}
	public String getDepartinvoicesno() {
		return departinvoicesno;
	}
	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}
	public Date getDepartdate() {
		return departdate;
	}
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	public long getTostationid() {
		return tostationid;
	}
	public void setTostationid(long tostationid) {
		this.tostationid = tostationid;
	}
	public long getVehicleid() {
		return vehicleid;
	}
	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public BigDecimal getShipprice() {
		return shipprice;
	}
	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}
	public BigDecimal getBalancemount() {
		return balancemount;
	}
	public void setBalancemount(BigDecimal balancemount) {
		this.balancemount = balancemount;
	}
	
	

}
