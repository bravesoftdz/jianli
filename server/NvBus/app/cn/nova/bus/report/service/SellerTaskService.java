package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public interface SellerTaskService {
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilter);
}
