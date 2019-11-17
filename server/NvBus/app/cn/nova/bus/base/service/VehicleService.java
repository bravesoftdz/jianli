package cn.nova.bus.base.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface VehicleService {
	

	public Vehicle save(Vehicle vehicle,Global global,Date validdate) throws ServiceException;
	
	public Vehicle findById(Long id);

	public boolean delete(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);
	
	public Vehicle qryVehiclebyIdcard(long vehicleid,String gprs,String cardno,boolean isidcardlogin);
	
	//查询车辆的图片信息
	public List<Map<String, Object>> getVehiclePic(long vehicleid);
	
	public List<Map<String, Object>> qryVehicleById(long vehicleid);
	public boolean updatePrintdate(long vehicleid,long userid);
	//获取车牌号信息
	public List<Map<String, Object>> getVehicleInfo();
	
	//车牌审核/取消审核
	public Boolean vehicleAudit(Vehicle vehicle);

	public boolean updateVehicle(Vehicle vehicle);
}
