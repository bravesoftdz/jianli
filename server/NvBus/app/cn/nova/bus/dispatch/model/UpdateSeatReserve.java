package cn.nova.bus.dispatch.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class UpdateSeatReserve {
	@Id
	public long id;
	public Date autocanceltime;
	public String cancelby;
	public Date canceltime;
	public boolean isautocancel;
	public String remarks;
	public String reserveby;
	public String reserveip;
	public Date reservetime;
	public String reserveway;
	public short seatno;
	public String sellstate;
	public BigDecimal serviceprice;
	public String ticketoutletsname;
	public String tickettype;
	public String departstationsynccode;
	public String reachstationsynccode;
	public String scheduleplansynccode;
}
