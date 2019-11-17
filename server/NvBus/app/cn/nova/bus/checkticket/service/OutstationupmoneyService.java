package cn.nova.bus.checkticket.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Outstationcheck;
import cn.nova.bus.checkticket.model.Outstationupmoney;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;


public interface OutstationupmoneyService {
	
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);
	
	public Outstationupmoney saveOutstationupmoney(Outstationupmoney outstationupmoney) throws ServiceException;
	
	public boolean deleteOutstationupmoney(Outstationupmoney outstationupmoney) throws ServiceException; 
	
	//查询稽查信息
	public List<Map<String, Object>> queryOutstationcheck(List<PropertyFilter> propertyFilters);
	//查询结算单信息
	public List<Map<String, Object>> queryDepartinvoices(Date departdate,long vehicleid,String cardno,Global global);
	//保存稽查信息
	public Outstationcheck saveOutstationcheck(Outstationcheck ost) throws ServiceException;
    //删除稽查信息
	public boolean delOutstationcheck(long id) throws ServiceException;

	public List<Map<String, Object>> qryVehicledriverreport(Date departdate,
			long vehiclereportid);
	
	public List<Map<String, Object>> qryArriveStationCheck(Date departdate,long vehicleid);
}
