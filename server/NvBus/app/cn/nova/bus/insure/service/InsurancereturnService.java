package cn.nova.bus.insure.service;

import java.util.List;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurancereturn;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.security.Global;

public interface InsurancereturnService {
	public void returnInsuranceAtreturnTicket(List<Ticketreturn> ticketreturns,Global global) throws ServiceException;
	public void returnInsurance(List<Insurancereturn> insurancereturns,Global global) throws ServiceException;
}
