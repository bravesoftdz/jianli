package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.pack.dao.CollectBalanceDao;
import cn.nova.bus.pack.dao.PackBalanceDao;
import cn.nova.bus.pack.model.CollectBalance;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.service.CollectBalanceService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class CollectBalanceServiceImpl implements CollectBalanceService {
	private CollectBalanceDao collectBalanceDao = new CollectBalanceDao();
	private PackBalanceDao packBalanceDao = new PackBalanceDao();

	@Override
	public List<Map<String, Object>> getList(List<PropertyFilter> propertyFilter) {
		return ListUtil.listToMap(new Object[] {"id", "sendstationname",
				"departdate", "packno", "status", "schedulecode", "weight",
				"shipprice", "packfee", "handfee", "unloadfee", "insurance",
				"transitfee", "insurancefee", "deliveryfee", "otherfee",
				"totalfee", "packprice", "balanceorgname", "vehicleno",
				"unitname", "vehicleid", "paymethod" }, collectBalanceDao.getList(propertyFilter),
				new Object[] {Long.class, String.class, Date.class, String.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class,
						String.class, String.class, Long.class, String.class });
	}

	@Override
	public Long balance(CollectBalance collectBalance, String packids) {
		Global global = CurrentUtil.getGlobal();
		collectBalance.setBalancby(global.getUserinfo().getId());
		collectBalance.setBalanceip(global.getIpAddress());
		collectBalance.setBalancetime(new Date());
		collectBalance.setStatus("0");// 正常
		collectBalance = collectBalanceDao.getEntityManager().merge(collectBalance);
		
		Long id = collectBalance.getId();
		List<Pack> packList = packBalanceDao.getList(packids);
		//更新行包的结算信息
		for (Pack pack : packList) {
			pack.setCollectstatus("1");
			pack.setCollectbalanceid(id);
			pack.setCollectby(collectBalance.getBalancby());
			pack.setCollectdate(collectBalance.getBalancetime());
			
			//代收金额/回收金额
			String paymethod = pack.getPaymethod();//0-现付,1-提付,2-月结,3-积分
			BigDecimal collectmoney = BigDecimal.valueOf(0); 
			if("1".equals(paymethod)){
				collectmoney = collectmoney.add(pack.getTotalfee()).add(pack.getPackprice());
			}else{
				collectmoney = collectmoney.add(pack.getPackprice());
			}
			pack.setCollectmoney(collectmoney);
			
			collectBalanceDao.getEntityManager().merge(pack);
		}
		
		return id;
	}

}
