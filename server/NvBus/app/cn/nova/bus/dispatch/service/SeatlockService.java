package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.utils.orm.PropertyFilter;

public interface SeatlockService {

	public boolean save(Seatlock seatlock) throws ServiceException;

	public boolean delete(Seatlock seatlock);

	public boolean delete(Long id);

	public List<Seatlock> query();

	public Seatlock getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

}
