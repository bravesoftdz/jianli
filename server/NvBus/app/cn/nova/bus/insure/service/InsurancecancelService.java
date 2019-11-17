package cn.nova.bus.insure.service;

import java.util.List;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurancecancel;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.security.Global;

public interface InsurancecancelService {
	public void cancelInsuranceAtcancelTicket(List<Ticketcancel> ticketcancels,Global global) throws ServiceException;
	public void cancelInsurance(List<Insurancecancel> insurancecancels,Global global) throws ServiceException;
}
