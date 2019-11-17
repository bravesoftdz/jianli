package cn.nova.bus.pack.service;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.PackIntegraterPay;

public interface PackIntegraterPayService {
	public PackIntegraterPay savePackIntegraterPay(
			PackIntegraterPay packIntegraterPay) throws ServiceException;
}
