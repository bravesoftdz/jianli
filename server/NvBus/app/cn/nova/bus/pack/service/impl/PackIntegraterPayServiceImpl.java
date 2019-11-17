package cn.nova.bus.pack.service.impl;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PackIntegraterPayDao;
import cn.nova.bus.pack.model.PackIntegraterPay;
import cn.nova.bus.pack.service.PackIntegraterPayService;

public class PackIntegraterPayServiceImpl implements PackIntegraterPayService {
	private PackIntegraterPayDao packIntegrateRuleDao = new PackIntegraterPayDao();
	@Override
	public PackIntegraterPay savePackIntegraterPay(PackIntegraterPay packIntegraterPay)
			throws ServiceException {
		if (packIntegraterPay.getId() == 0) {
			packIntegrateRuleDao.save(packIntegraterPay);
		} else {
			packIntegrateRuleDao.merge(packIntegraterPay);
		}
		return packIntegraterPay;
	}

}
