package cn.nova.bus.balance.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancescheduleminimum;
import cn.nova.utils.orm.PropertyFilter;

public interface BalancescheduleminimumService {

	public boolean save(Balancescheduleminimum balanceschedule);

	public boolean delete(Balancescheduleminimum balanceschedule);

	public boolean delete(Long id);

	public List<Balancescheduleminimum> query();

	public Balancescheduleminimum getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	//通过班次ID得到它对应的发车时间
	public Date getdepartdate(Long scheduleid);
	
}
