package cn.nova.bus.base.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface InsuretypeService {

	public Insuretype save(Insuretype insurertype) throws ServiceException;

	public boolean delete(Insuretype insurertype);

	public boolean delete(Long id) throws ServiceException;

	public List<Insuretype> query();

	public Insuretype getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> qryInsuretypeByDistance(Long distance);

	public List<Map<String, Object>> qryInsuretype(long orgid);
	
	public List<Map<String, Object>> qryInsuretypeByPrice(long fullprice);

}
