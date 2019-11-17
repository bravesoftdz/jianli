package cn.nova.bus.checkticket.vo;

import java.io.Serializable;
import java.math.BigDecimal;

public class DepartinvoicesdetailVo implements Serializable {
	private static final long serialVersionUID = 3874523775674261778L;

	private String fromstation;

	private String tostation;

	private long fullpeople;

	private long halfpeople;

	private long studentpeople;

	private long discountpeople;

	private long distance;

	private long psdistance;

	private long peoples;

	private BigDecimal price;
	
	private BigDecimal totalamount;
	

	public BigDecimal getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(BigDecimal totalamount) {
		this.totalamount = totalamount;
	}

	public String getFromstation() {
		return fromstation;
	}

	public void setFromstation(String fromstation) {
		this.fromstation = fromstation;
	}

	public String getTostation() {
		return tostation;
	}

	public void setTostation(String tostation) {
		this.tostation = tostation;
	}

	public long getFullpeople() {
		return fullpeople;
	}

	public void setFullpeople(long fullpeople) {
		this.fullpeople = fullpeople;
	}

	public long getHalfpeople() {
		return halfpeople;
	}

	public void setHalfpeople(long halfpeople) {
		this.halfpeople = halfpeople;
	}

	public long getStudentpeople() {
		return studentpeople;
	}

	public void setStudentpeople(long studentpeople) {
		this.studentpeople = studentpeople;
	}

	public long getDiscountpeople() {
		return discountpeople;
	}

	public void setDiscountpeople(long discountpeople) {
		this.discountpeople = discountpeople;
	}

	public long getPeoples() {
		return peoples;
	}

	public void setPeoples(long peoples) {
		this.peoples = peoples;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public long getDistance() {
		return distance;
	}

	public void setDistance(long distance) {
		this.distance = distance;
	}

	public long getPsdistance() {
		return psdistance;
	}

	public void setPsdistance(long psdistance) {
		this.psdistance = psdistance;
	}
}
