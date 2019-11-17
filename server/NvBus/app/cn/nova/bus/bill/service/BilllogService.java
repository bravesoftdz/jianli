package cn.nova.bus.bill.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billlog;
import cn.nova.utils.orm.PropertyFilter;

public interface BilllogService {
	public Billlog save(Billlog billlog);

	public Billlog findById(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

}
