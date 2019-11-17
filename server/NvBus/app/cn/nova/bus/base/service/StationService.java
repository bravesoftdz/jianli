package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Station;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface StationService {

	public Station save(Station station) throws ServiceException;

	public Station findById(Long id);

	public boolean delete(Long id);

	public List<Station> findList(Map<String, Object> where);

	public List<Station> query(String sql);

	public List<Map<String, Object>> query(Object[] fileds, String sql);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public boolean isUnique(String name, String code);

	public boolean hasApplyOrganization(long id) throws ServiceException;

	public boolean hasApplyRoutestop(long id) throws ServiceException;

	public Long getId(String name);

	public MethodResult dispose(List<List<String>> sheeplist) throws Exception;

}
