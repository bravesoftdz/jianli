package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.price.model.StandardBasePrice;
import cn.nova.utils.orm.PropertyFilter;

public interface StandardBasePriceService {
	public List<Map<String, Object>> query(long routeid);

	public boolean delRouteBaseprice(String ids);
	
	public boolean saveRouteBaseprice(String ids);

	public List<Map<String, Object>> update(List<StandardBasePrice> baseprices);
}
