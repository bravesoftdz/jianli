package cn.nova.bus.bill.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billstorage;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface BillstorageService {
	
	public Billstorage save(Billstorage billstorage) throws ServiceException;

	public Billstorage findById(Long id);

	public boolean delete(Long id) throws Exception;

	public List<Map<String, Object>> query(Object[] fileds, String sql);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

}
