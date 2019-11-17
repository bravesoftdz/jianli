package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Insurancetypefares;
import cn.nova.bus.base.model.Insuretypedistance;
import cn.nova.bus.base.model.Insuretypeticketprice;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface InsuretypedistanceService {
	public Insuretypedistance save(Insuretypedistance insuretypedistance)
			throws ServiceException;

	public boolean delete(Insuretypedistance insuretypedistance);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> qryinsuretypeprice(
			List<PropertyFilter> buildFromHttpRequest);

	public Insuretypeticketprice saveinsuretypeprice(
			Insuretypeticketprice insuretypeticketprice)throws ServiceException;

	public boolean deleteinsuretypeprice(
			Insuretypeticketprice insuretypeticketprice);

	public List<Map<String, Object>> qryInsuranceTypeFares(
			List<PropertyFilter> buildFromHttpRequest);

	public Insurancetypefares saveinsuretypeFares(Global global,Insurancetypefares insurancetypefares)throws ServiceException;

	public boolean deletefares(Insurancetypefares insurancetypefares);;
}
