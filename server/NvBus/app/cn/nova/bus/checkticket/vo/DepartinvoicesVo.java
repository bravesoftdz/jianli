package cn.nova.bus.checkticket.vo;

import java.io.Serializable;
import java.math.BigDecimal;

import cn.nova.utils.orm.jpa.DelphiDS;
@DelphiDS

public class DepartinvoicesVo implements Serializable {
	private static final long serialVersionUID = 5226866231800975064L;

	private long id;
	private String invoicesno;
	private String unit;
	private long ticketnum;
	private String stationfee;
	private String fueladditionfee;
	private String agentfee;
	private String otherfee;
	private String totalamount;
	private String balanceamount;
	private String driver1;
	private String driver2;
	private String driver3;
	private String driver4;
	private String steward;
	private long seatnum;
	private long distance;
	private String vehicletype;
	private String brandname;
	private String balanceunit;
	private String balanceunitfullname;
	private boolean isovertime;
	private String checkedname;
	private String vehicleno;
	private int freetickets;//免票儿童数
	private int armtickets;//残军票 J
	private String remarks;
	private String ticketoutname;
	private String ticketoutshort;
	private String fullname;
	private long otherticketnum;
	private String unitcode;
	private String balanceunitcode;
	private String lostfee;
	private BigDecimal debit;  //违规罚金
//	private String vehicleseattype;
	
	public String getUnitcode() {
		return unitcode;
	}

	public void setUnitcode(String unitcode) {
		this.unitcode = unitcode;
	}

	//新增呼市打印行包结算金额
	private long  packes ;
	private BigDecimal packbalanceprice; 
	
	private String vehiclecolor;//车牌颜色
	private Integer bupiaonum;//补票人数
	
	private int eticketnumtotal;//电子票总票数，包含：电子票取票、未取票总张数
	private int handticketnumtotal;//手持机总票数，包含：手持机售票的总张数
	private int nopaperticketnumtotal;//非纸质票总票数：结算单中包含网售未取票、窗口售电子票且未换纸质票和自助机售电子票未换纸质票
	private int paperticketnumtotal;//纸质票总票数：结算单中包含窗口售非电子票、窗口售电子票且已换纸质票、网售已取票、自助机售非电子票和自助机售电子票已换纸质票
	
	public long getPackes() {
		return packes;
	}

	public void setPackes(long packes) {
		this.packes = packes;
	}

	public BigDecimal getPackbalanceprice() {
		return packbalanceprice;
	}

	public void setPackbalanceprice(BigDecimal packbalanceprice) {
		this.packbalanceprice = packbalanceprice;
	}

	public String getTicketoutname() {
		return ticketoutname;
	}

	public void setTicketoutname(String ticketoutname) {
		this.ticketoutname = ticketoutname;
	}

	public String getTicketoutshort() {
		return ticketoutshort;
	}

	public void setTicketoutshort(String ticketoutshort) {
		this.ticketoutshort = ticketoutshort;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public int getArmtickets() {
		return armtickets;
	}

	public void setArmtickets(int armtickets) {
		this.armtickets = armtickets;
	}

	public int getFreetickets() {
		return freetickets;
	}

	public void setFreetickets(int freetickets) {
		this.freetickets = freetickets;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public boolean isIsovertime() {
		return isovertime;
	}

	public void setIsovertime(boolean isovertime) {
		this.isovertime = isovertime;
	}

	public String getBalanceunit() {
		return balanceunit;
	}

	public void setBalanceunit(String balanceunit) {
		this.balanceunit = balanceunit;
	}

	public String getBalanceunitfullname() {
		return balanceunitfullname;
	}

	public void setBalanceunitfullname(String balanceunitfullname) {
		this.balanceunitfullname = balanceunitfullname;
	}

	public String getVehicletype() {
		return vehicletype;
	}

	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
	}

	public String getBrandname() {
		return brandname;
	}

	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	
	
	public long getDistance() {
		return distance;
	}

	public void setDistance(long distance) {
		this.distance = distance;
	}

	public long getSeatnum() {
		return seatnum;
	}

	public void setSeatnum(long seatnum) {
		this.seatnum = seatnum;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getInvoicesno() {
		return invoicesno;
	}

	public void setInvoicesno(String invoicesno) {
		this.invoicesno = invoicesno;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public String getStationfee() {
		return stationfee;
	}

	public void setStationfee(String stationfee) {
		this.stationfee = stationfee;
	}

	public String getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(String fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public String getAgentfee() {
		return agentfee;
	}

	public void setAgentfee(String agentfee) {
		this.agentfee = agentfee;
	}

	public String getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(String otherfee) {
		this.otherfee = otherfee;
	}

	public String getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(String totalamount) {
		this.totalamount = totalamount;
	}

	public String getBalanceamount() {
		return balanceamount;
	}

	public void setBalanceamount(String balanceamount) {
		this.balanceamount = balanceamount;
	}

	public String getDriver1() {
		return driver1;
	}

	public void setDriver1(String driver1) {
		this.driver1 = driver1;
	}

	public String getDriver2() {
		return driver2;
	}

	public void setDriver2(String driver2) {
		this.driver2 = driver2;
	}

	public String getDriver3() {
		return driver3;
	}

	public void setDriver3(String driver3) {
		this.driver3 = driver3;
	}

	public String getDriver4() {
		return driver4;
	}

	public void setDriver4(String driver4) {
		this.driver4 = driver4;
	}

	public String getSteward() {
		return steward;
	}

	public void setSteward(String steward) {
		this.steward = steward;
	}

	public String getCheckedname() {
		return checkedname;
	}

	public void setCheckedname(String checkedname) {
		this.checkedname = checkedname;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getVehiclecolor() {
		return vehiclecolor;
	}

	public void setVehiclecolor(String vehiclecolor) {
		this.vehiclecolor = vehiclecolor;
	}

	public Integer getBupiaonum() {
		return bupiaonum;
	}

	public void setBupiaonum(Integer bupiaonum) {
		this.bupiaonum = bupiaonum;
	}
	
//	public String getVehicleseattype() {
//		return vehicleseattype;
//	}
//
//	public void setVehicleseattype(String vehicleseattype) {
//		this.vehicleseattype = vehicleseattype;
//	}

	public long getOtherticketnum() {
		return otherticketnum;
	}

	public void setOtherticketnum(long otherticketnum) {
		this.otherticketnum = otherticketnum;
	}

	public String getBalanceunitcode() {
		return balanceunitcode;
	}

	public void setBalanceunitcode(String balanceunitcode) {
		this.balanceunitcode = balanceunitcode;
	}

	public String getLostfee() {
		return lostfee;
	}

	public void setLostfee(String lostfee) {
		this.lostfee = lostfee;
	}

	public BigDecimal getDebit() {
		return debit;
	}

	public void setDebit(BigDecimal debit) {
		this.debit = debit;
	}

	public int getEticketnumtotal() {
		return eticketnumtotal;
	}

	public void setEticketnumtotal(int eticketnumtotal) {
		this.eticketnumtotal = eticketnumtotal;
	}

	public int getHandticketnumtotal() {
		return handticketnumtotal;
	}

	public void setHandticketnumtotal(int handticketnumtotal) {
		this.handticketnumtotal = handticketnumtotal;
	}

	public int getNopaperticketnumtotal() {
		return nopaperticketnumtotal;
	}

	public void setNopaperticketnumtotal(int nopaperticketnumtotal) {
		this.nopaperticketnumtotal = nopaperticketnumtotal;
	}

	public int getPaperticketnumtotal() {
		return paperticketnumtotal;
	}

	public void setPaperticketnumtotal(int paperticketnumtotal) {
		this.paperticketnumtotal = paperticketnumtotal;
	}


}
