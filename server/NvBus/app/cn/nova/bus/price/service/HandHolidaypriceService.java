package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handholidaypriceitem;
import cn.nova.bus.price.model.Holiday;

public interface HandHolidaypriceService {
	public List<Map<String, Object>> qryScheduleVehicletype(Long scheduleid);

	public List<Map<String, Object>> qryHandHolidayPrice(Holiday holiday,
			Long scheduleid, String vehicletypeids);

	public List<Map<String, Object>> save(
			List<Handholidayprice> Handholidayprices, Holiday holiday,
			Long userid,boolean savesameroute) throws ServiceException, Exception;

	public List<Map<String, Object>> qryHandHolidayPrice(
			Handholidayprice handholidayprice);

	public boolean delHandHolidayPrice(Handholidayprice handholidayprice);
	
	
	// 查询票价分项信息
	public List<Map<String, Object>> qryHandholidaypriceitem(long handholidaypriceid,
			String tickettype);
	
	// 保存票价分项信息
	public List<Map<String, Object>> saveHandholidaypriceitem(
			List<Handholidaypriceitem> handholidaypriceitemlist,long userid,boolean iscopyothersch) throws ServiceException;	
}
