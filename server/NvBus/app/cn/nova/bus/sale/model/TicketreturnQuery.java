package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.utils.orm.jpa.DelphiDS;

@DelphiDS
public class TicketreturnQuery implements Serializable {
	private long id;
	private long scheduleplanid;
	private Date departdate;
	private String departtime;
	private BigDecimal fullprice;
	private boolean ischecked;
	private boolean isdepartinvoices;
	private boolean islinework;
	private long orgid;
	private String paymethod;
	private BigDecimal price;
	private BigDecimal servicefee;
	private short seatno;
	private long sellby;
	private String sellip;
	private Date selltime;
	private String ticketno;

	private String sellway;
	private String ticketstatus;
	private String tickettype;
	private String seattype;

	
	private long ticketoutletsid;
	private long turnoverdetailid;
	private Vehiclereport vehiclereport;
	private String customername;
	private long departstationid;
	private long reachstationid;
	private long scheduleid;


	
	private long ticketreturnid;
	private Billtype billtype;
	private BigDecimal returncharges;
	private String remarks;
	private BigDecimal returnamount;
	private String returnip;
	private Date returntime;
	private String returnvoucherno;
	private BigDecimal returnby;

	private long ticketsignid;
	private BigDecimal signcharges;
	private String signreason;
	private Date signtime;

	private long signby;

	
	private BigDecimal isselfschedule;
}
