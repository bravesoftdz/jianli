package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Insurers;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface InsurerService {

	public Insurers save(Insurers insurer, String ip) throws ServiceException;

	public boolean delete(Insurers insurer);

	public boolean delete(Long id, String ip) throws ServiceException;

	public List<Insurers> query();

	public Insurers getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

}
