package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Printtemplateitemset;
import cn.nova.utils.orm.PropertyFilter;

public interface PrinttemplateitemsetService {
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Printtemplateitemset save(Printtemplateitemset printtemplateitemset)
			throws ServiceException;

	public boolean delete(long id);
	///结算单打印时查询
	public List<Map<String, Object>> query(long orgid, long vehicleid,String templatename);
}
