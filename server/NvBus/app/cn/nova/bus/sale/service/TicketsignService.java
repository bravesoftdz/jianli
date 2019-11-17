package cn.nova.bus.sale.service;

import java.util.List;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsign;

public interface TicketsignService {

	public boolean sign(List<Ticketsign> ticketsigns) throws ServiceException;
	public boolean sign(Ticketsign ticketsign) throws ServiceException;
}
