package cn.nova.bus.bill.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface BillinventoryService {
	
	public Billinventory save(Billinventory billinventory);

	public Billinventory save(Billinventory billinventory, Long start, Long end) throws ServiceException;

	public boolean save(Billinventory billinventory,
			Billinventory newbillinventory);

	public Billinventory findById(Long id);

	public boolean delete(Long id) throws ServiceException;

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);
	
	//直接取入库的票据进行打印
	public Billinventory qryBillinventory(long orgid,String billtype)throws ServiceException;

}
