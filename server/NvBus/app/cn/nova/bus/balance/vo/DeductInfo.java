package cn.nova.bus.balance.vo;

import java.math.BigDecimal;

public class DeductInfo {
	private BigDecimal stationfee;
	private BigDecimal computefee;
	private BigDecimal coolairfee;
	private BigDecimal additionfee;
	private BigDecimal fueladditionfee;
	private BigDecimal waterfee;
	private BigDecimal insurefee;
    private BigDecimal otherfee;

	public DeductInfo() {
		stationfee = new BigDecimal(0);
		computefee = new BigDecimal(0);
		coolairfee = new BigDecimal(0);
		additionfee = new BigDecimal(0);
		fueladditionfee = new BigDecimal(0);
		waterfee = new BigDecimal(0);
		insurefee = new BigDecimal(0);
		otherfee = new BigDecimal(0);
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
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
}
