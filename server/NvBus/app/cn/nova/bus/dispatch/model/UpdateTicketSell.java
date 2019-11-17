package cn.nova.bus.dispatch.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class UpdateTicketSell {
	@Id
	public long id;
	public Long turnoverdetailid;
	public Long sellby;
	public String departstationsynccode;
	public String reachstationsynccode;
	public String scheduleplansynccode;
	public String sellbyname;
	public String ticketentrance;
	public Long ticketoutletsid;
	public String ticketoutletsname;
	public String updatebyname;
	public String createbyname;
	public String buspark;
	public BigDecimal discountrate;
	public Long distance;
	public BigDecimal fullprice;
	public Boolean islinework;
	public String paymethod;
	public BigDecimal price;
	public Byte carrychildnum;
	public Short seatno;
	public String sellip;
	public Date selltime;
	public String sellway;
	public String batchno;
	public String ticketno;
	public String orderno;
	public String seattype;
	public String ticketstatus;
	public String tickettype;
	public BigDecimal moreprice;
	public BigDecimal waterfee;
	public BigDecimal insurefee;
	public BigDecimal otherfee;
	public BigDecimal servicefee;
	public BigDecimal toplimitprice;
	public BigDecimal fueladditionfee;
	public BigDecimal stationservicefee;
	public BigDecimal computefee;
	public BigDecimal coolairfee;
	public BigDecimal additionfee;
}
