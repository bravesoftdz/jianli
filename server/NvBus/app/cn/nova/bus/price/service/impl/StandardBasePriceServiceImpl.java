package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.price.dao.StandardBasePriceDao;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.StandardBasePrice;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.service.StandardBasePriceService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class StandardBasePriceServiceImpl implements StandardBasePriceService {
	private StandardBasePriceDao standardBasePriceDao = new StandardBasePriceDao();

	@Override
	public List<Map<String, Object>> query(long routeid) {
		return ListUtil
				.listToMap(new Object[] { "id", "routeid", "fromstationid",
						"reachstationid", "orgid", "baseprice", "routename",
						"fromstation", "reachstation", "orgname", "isselect" },
						standardBasePriceDao.query(routeid), new Object[] {
								long.class, long.class, long.class, long.class,
								long.class, BigDecimal.class, String.class,
								String.class, String.class, String.class,
								boolean.class });
	}

	@Override
	public boolean delRouteBaseprice(String ids) {
		String[] split = ids.split(",");
		if (split.length != 0) {
			standardBasePriceDao.delRouteBaseprice(ids);
		}
		return true;

	}

	@Override
	public boolean saveRouteBaseprice(String ids) {
		String[] split = ids.split(",");
		if (split.length != 0) {
			List<Routeprice> routeprices = standardBasePriceDao
					.getBaseRoutePrice(ids);
			if (routeprices.size() > 0) {
				for (Routeprice r : routeprices) {
					StandardBasePrice sb = standardBasePriceDao
							.getStandardBasePrice(r);
					if (sb == null) {
						sb = new StandardBasePrice();
						sb.setBaseprice(r.getPrice());
						sb.setOrgid(r.getOrgid());
						sb.setFromstationid(r.getFromstationid());
						sb.setReachstationid(r.getReachstationid());
						sb.setRouteid(r.getRouteid());
						standardBasePriceDao.save(sb);
					} else {
						sb.setBaseprice(r.getPrice());
						standardBasePriceDao.merge(sb);
					}
				}
			}
		}

		return true;
	}

	@Override
	public List<Map<String, Object>> update(List<StandardBasePrice> baseprices) {
		if (baseprices.size() > 0) {
			for (StandardBasePrice sb : baseprices) {
				standardBasePriceDao.merge(sb);
			}
			return query(baseprices.get(0).getRouteid());
		}
		return null;
	}

}
