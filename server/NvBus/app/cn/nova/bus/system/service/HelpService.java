package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface HelpService {
	public List<Map<String, Object>> find(String helpType, String param,
			List<PropertyFilter> propertyFilterList,Global global);
	
	public List<Map<String, Object>> find(String helpType, String param,
			List<PropertyFilter> propertyFilterList);
}
