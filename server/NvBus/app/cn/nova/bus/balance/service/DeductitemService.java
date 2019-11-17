package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Deductitem;
import cn.nova.bus.balance.model.Deductroutestop;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface DeductitemService {
	//新结算扣费表
	public Deductitem saveDeductitem(Deductitem deductitem)throws ServiceException;
	
	
	public List<Map<String, Object>> qryDeductitem(List<PropertyFilter> propertyFilterList);
	
	
	public boolean delDeductitem(Deductitem deductitem)	throws ServiceException;
	
	public List<Map<String, Object>> qryStationDeduct(long routeid);
	
	public boolean saveStationDeduct(List<Deductroutestop> drlist);
	
	public List<Map<String, Object>> qryRouteDeduct(List<PropertyFilter> propertyFilterList);
	
	public boolean delDeductroutestop(Deductroutestop deductroutestop)	throws ServiceException;
}
