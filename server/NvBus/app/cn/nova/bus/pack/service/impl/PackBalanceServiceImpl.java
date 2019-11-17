package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;

import cn.nova.bus.pack.dao.PackBalanceDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.service.PackBalanceService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackBalanceServiceImpl implements PackBalanceService {

	private PackBalanceDao packBalanceDao = new PackBalanceDao();

	@Override
	public List<Map<String, Object>> getList(List<PropertyFilter> propertyFilter) {
		return ListUtil.listToMap(new Object[] { "id", "sendstationname",
				"tostationname", "departdate", "packno", "status",
				"schedulecode", "pieces", "weight", "shipprice", "packfee",
				"handfee", "unloadfee", "insurance", "custodial", "transitfee",
				"insuredamount", "insurancefee", "deliveryfee", "otherfee",
				"totalfee", "packprice", "balanceorgname", "vehicleno",
				"unitname", "signbyname", "signtime", "balancebyname",
				"balancedate", "vehicleid", "unitid" },
				packBalanceDao.getList(propertyFilter), new Object[] {
						Long.class, String.class, String.class, Date.class,
						String.class, String.class, String.class,
						Integer.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, String.class, String.class, String.class,
						Date.class, String.class, Date.class, Long.class,
						Long.class });
	}

//	@Override
//	public Long balance(PackBalance packBalance, String packids) {
//		Global global = CurrentUtil.getGlobal();
//		packBalance.setReturnpackmoney(BigDecimal.valueOf(0));
//		packBalance.setBalancby(global.getUserinfo().getId());
//		packBalance.setBalanceip(global.getIpAddress());
//		packBalance.setBalancetime(new Date());
//		packBalance.setStatus("0");// 正常
//		packBalance.setLastlost(BigDecimal.valueOf(0));
//		packBalance.setLost(BigDecimal.valueOf(0));
//		packBalance = packBalanceDao.getEntityManager().merge(packBalance);
//
//		Long id = packBalance.getId();
//		List<Pack> packList = packBalanceDao.getList(packids);
//		// 更新行包的结算信息
//		for (Pack pack : packList) {
//			pack.setBalanceid(id);
//			pack.setStatus("5"); //已结算
//			pack.setBalanceby(packBalance.getBalancby());
//			pack.setBalancedate(packBalance.getBalancetime());
//			pack.setBalanceorgid(global.getUserinfo().getOrgid());
//			packBalanceDao.getEntityManager().merge(pack);
//		}
//
//		return id;
//	}

}
