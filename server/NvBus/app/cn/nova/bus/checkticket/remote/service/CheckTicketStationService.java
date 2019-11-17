package cn.nova.bus.checkticket.remote.service;

import java.util.Date;

import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.ParamCheckTicketIn;
import cn.nova.utils.commons.ParamCheckTicketOut;



public interface CheckTicketStationService {

	public ParamCheckTicketOut findTicketsell(ParamCheckTicketIn inparam);
	
	public ParamCheckTicketOut checkTicketsell(ParamCheckTicketIn inparam);
	
	public MethodResult cancelRemoteTicketCheck(String ticketno, String departorgcode,Date departdate);
	
}
