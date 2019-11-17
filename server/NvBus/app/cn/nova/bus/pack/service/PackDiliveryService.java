package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.model.PackDilivery;
import cn.nova.utils.orm.PropertyFilter;

public interface PackDiliveryService {

	List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);
	
	List<Map<String, Object>> getPackDiliveryByPackId(PackDilivery pd);
	
	PackDilivery savePackDilivery(PackDilivery pd);
	
	int updatePackDilivery(PackDilivery pd);
	
	void delPackDilivery(PackDilivery pd);

	PackDilivery existDiliveno(String diliveno);
}
