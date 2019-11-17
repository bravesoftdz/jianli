package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.model.PackDiliveryDetail;
import cn.nova.utils.orm.PropertyFilter;

public interface PackDiliveryDetailService {

	List<Map<String, Object>> query(String packids);

	List<PackDiliveryDetail> list(Long packdiliveryid);
	
	PackDiliveryDetail savePackDiliveryDetail(PackDiliveryDetail pdd);
	
	int updatePackDiliveryDetail(PackDiliveryDetail pdd);
	
	int delPackDiliveryDetail(String pddids);

	List<Map<String, Object>> queryByDiliveryid(List<PropertyFilter> propertyFilters);
}
