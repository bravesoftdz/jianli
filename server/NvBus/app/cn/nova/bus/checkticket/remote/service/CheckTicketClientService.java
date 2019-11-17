package cn.nova.bus.checkticket.remote.service;


import java.util.Date;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.ParamCheckTicketIn;
import cn.nova.utils.commons.ParamCheckTicketOut;

public interface CheckTicketClientService {
	public ParamCheckTicketOut findTicketsell(ParamCheckTicketIn inparam,Global global) throws ServiceException;

	public ParamCheckTicketOut checkTicketsell(ParamCheckTicketIn inparam,Global global) throws ServiceException, Exception;
	
	public String qryOrgSell(Date departdate,long scheduleid,Global global) throws ServiceException;
	
}
