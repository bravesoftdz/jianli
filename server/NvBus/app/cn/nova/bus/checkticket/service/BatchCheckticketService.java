package cn.nova.bus.checkticket.service;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;

public interface BatchCheckticketService {
	// 通检、实现按票号s检票过程,islazycheck是否补检
	public String checkByticketnos(long checkstationid, long scheduleplanid,
			long vehiclereportid, String ticketnos, Global global, 
			boolean islazycheck, String ip, String ticketentrance)
			throws ServiceException;
}
