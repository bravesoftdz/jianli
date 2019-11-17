package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Vehicleturnover;
import cn.nova.utils.orm.PropertyFilter;

public interface VehicleturnoverService {

	public Vehicleturnover save(Vehicleturnover turnover);

	public boolean delete(Vehicleturnover turnover);

	public boolean delete(Long id);

	public List<Vehicleturnover> query();

	public Vehicleturnover getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean vehicleidUnique(Long vehicleid);

}
