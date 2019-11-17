package cn.nova.bus.dispatch.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class UpdateScheduleSeats {
	@Id
	public long id;
	public String scheduleplansynccode;
	public String seattype;
	public short seatno;
	public String status;
	public String tickettype;
	public long createby;
	public long updateby;
}
