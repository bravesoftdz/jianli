package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Scheduleminimum;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface ScheduleminimumService {

	public Scheduleminimum save(Scheduleminimum scheduleminimum) throws ServiceException;

	public boolean delete(Scheduleminimum scheduleminimum);

	public boolean delete(Long id);

	public List<Scheduleminimum> query();

	public Scheduleminimum getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);


	//根据班次ID，车辆ID取得班次车辆保底数
	public Scheduleminimum getScheduleminimum(long scheduleid, long vehicleid);

}
