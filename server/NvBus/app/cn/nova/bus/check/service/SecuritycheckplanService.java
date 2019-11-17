package cn.nova.bus.check.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.check.model.Securitycheckplan;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface SecuritycheckplanService {

	public Securitycheckplan save(Securitycheckplan security) throws ServiceException;

	public boolean delete(Long id);

	public List<Securitycheckplan> query();

	public boolean delete(Securitycheckplan security);

	public Securitycheckplan getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
	public long getByVehicleId(long vehicleid);
	
	// 通过车辆ID得到要安检计划的信息
	public Securitycheckplan getcheckplan(Long vehicleid);

	// 查询安检计划里面有没有要对该车辆进行安检
	public boolean hasCheckplan(Long vehicleid) throws ServiceException;
	
}
