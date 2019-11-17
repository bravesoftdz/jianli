package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.BalancedivideDao;
import cn.nova.bus.balance.model.Balancedivide;
import cn.nova.bus.balance.service.BalancedivideService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalancedivideServiceImpl implements BalancedivideService {

	private BalancedivideDao balancedivideDao = new BalancedivideDao();

	@Override
	public Balancedivide saveBalancedivide(Balancedivide balancedivide)
			throws ServiceException {
		if (balancedivideDao.isExistBalancedivide(balancedivide)) {
			// 该线路结算对象协议已经设置
			throw new ServiceException("0381");
		}
		return balancedivideDao.getEntityManager().merge(balancedivide);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean deleteBalancedivide(Balancedivide balancedivide)
			throws ServiceException {
		Balancedivide bb = (Balancedivide) balancedivideDao.get(
				Balancedivide.class, balancedivide.getId());
		if (bb != null) {
			balancedivideDao.del(bb);
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> qryBalancedivide(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "orgid", "orgname",
				"routeid", "routename", "vehicleid", "vehicleno",
				"balanceunitid", "balanceunit", "dividevehicleid", "dividevehicleno",
				"divide", "createdname", "updatedname", "createby", "updateby",
				"createtime", "updatetime" },
				balancedivideDao.qryBalancedivide(propertyFilterList),
				new Object[] { Long.class, Long.class, String.class,
						Long.class, String.class, Long.class, String.class,
						Long.class, String.class, Long.class, String.class,
						BigDecimal.class, String.class, String.class,
						Long.class, Long.class, Timestamp.class,
						Timestamp.class });
	}

}
