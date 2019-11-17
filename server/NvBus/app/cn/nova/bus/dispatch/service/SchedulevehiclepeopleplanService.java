package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulevehiclepeopleplanService {

	public boolean save(Schedulevehiclepeopleplan plan);

	public boolean delete(Schedulevehiclepeopleplan plan);

	public boolean delete(Long id);

	public List<Schedulevehiclepeopleplan> query();

	public Schedulevehiclepeopleplan getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean savePlanvehicle(Schedulevehiclepeopleplan peopleplan, String string);

	public boolean savePlandriver(Schedulevehiclepeopleplan peopleplan);

	public boolean savePlansteward(Schedulevehiclepeopleplan peopleplan);

	public boolean savePlanvehicletype(Schedulevehiclepeopleplan schedulestatus, String string)throws ServiceException;

}
