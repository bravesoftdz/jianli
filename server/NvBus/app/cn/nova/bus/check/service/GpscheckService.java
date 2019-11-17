package cn.nova.bus.check.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.check.model.Gpscheck;
import cn.nova.utils.orm.PropertyFilter;

public interface GpscheckService {

	public Gpscheck save(Gpscheck entity);

	public boolean delete(Long id);

	public List<Map<String, Object>> query(boolean issummary ,List<PropertyFilter> propertyFilterList);
	

	public String qryCheckno(Long checkby);
}
