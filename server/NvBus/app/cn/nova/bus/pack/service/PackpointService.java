package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.model.Packpoint;
import cn.nova.utils.orm.PropertyFilter;

public interface PackpointService {
	public List<Map<String, Object>> query();
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	public boolean delete(Packpoint p, long userid );
    public Packpoint savePackpoint(Packpoint p);

}
