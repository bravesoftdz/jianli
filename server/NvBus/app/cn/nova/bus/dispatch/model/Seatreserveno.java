package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class Seatreserveno  implements Serializable {

	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = 8309056904070871642L;

	private short seatno;

	private BigDecimal price;

	private String seattypeCode; // 非空

	private String tickettype; // 非空

	public String getSeattypeCode() {
		return seattypeCode;
	}

	public void setSeattypeCode(String seattypeCode) {
		this.seattypeCode = seattypeCode;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public short getSeatno() {
		return seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

}
