package cn.nova.bus.balance.vo;

import java.math.BigDecimal;
import java.util.Date;

public class CalculateItem {
	private int peoples;
	private BigDecimal totalprice;// 总票款
	private BigDecimal stationfee;
	private BigDecimal computefee;
	private BigDecimal coolairfee;
	private BigDecimal additionfee;
	private BigDecimal fueladditionfee;
	private BigDecimal waterfee;
	private BigDecimal insurefee;
	private BigDecimal otherfee;
	private int intervalsday;
	private Date departdate;// 发车日期
	private Date balancedate;// 结算日期
	private int intervalmonths;//相隔月份

	public void init(){
		peoples = 0;
		totalprice = new BigDecimal(0);// 总票款
		stationfee = new BigDecimal(0);
		computefee = new BigDecimal(0);
		coolairfee = new BigDecimal(0);
		additionfee = new BigDecimal(0);
		fueladditionfee = new BigDecimal(0);
		waterfee = new BigDecimal(0);
		insurefee = new BigDecimal(0);
		otherfee = new BigDecimal(0);
		departdate=new Date();
		balancedate=new Date();
	}
	
	public BigDecimal getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(BigDecimal totalprice) {
		this.totalprice = totalprice;
	}

	public int getPeoples() {
		return peoples;
	}

	public void setPeoples(int peoples) {
		this.peoples = peoples;
	}

	public BigDecimal getStationfee() {
		return stationfee;
	}

	public void setStationfee(BigDecimal stationfee) {
		this.stationfee = stationfee;
	}

	public BigDecimal getComputefee() {
		return computefee;
	}

	public void setComputefee(BigDecimal computefee) {
		this.computefee = computefee;
	}

	public BigDecimal getCoolairfee() {
		return coolairfee;
	}

	public void setCoolairfee(BigDecimal coolairfee) {
		this.coolairfee = coolairfee;
	}

	public BigDecimal getAdditionfee() {
		return additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getWaterfee() {
		return waterfee;
	}

	public void setWaterfee(BigDecimal waterfee) {
		this.waterfee = waterfee;
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

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Date getBalancedate() {
		return balancedate;
	}

	public void setBalancedate(Date balancedate) {
		this.balancedate = balancedate;
	}
	
	public int getIntervalsday() {
		return intervalsday;
	}

	public void setIntervalsday(int intervalsday) {
		this.intervalsday = intervalsday;
	}
	public int getIntervalmonths() {
		return intervalmonths;
	}

	public void setIntervalmonths(int intervalmonths) {
		this.intervalmonths = intervalmonths;
	}
}
