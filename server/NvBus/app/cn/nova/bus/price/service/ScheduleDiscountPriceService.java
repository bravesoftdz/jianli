package cn.nova.bus.price.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.ScheduleDiscountPrice;
import cn.nova.bus.security.Global;

public interface ScheduleDiscountPriceService {

	public List<Map<String, Object>> save(
			List<ScheduleDiscountPrice> scheduleDiscountPrices, Long userid,
			Long scheduleid,Date startDate, Date endDate,int salenum,boolean savesameroute) throws ServiceException, Exception;

	public List<Map<String, Object>> qryScheduleDiscountPrice(Long scheduleid);
	public List<Map<String, Object>> qryScheduleDiscountPrice(Long routeid,Long scheduleid);

	public boolean delScheduleDiscountPrice(ScheduleDiscountPrice schedulediscountprice);
	public boolean delScheduleDiscountPrice(Long scheduleid);
	public List<Map<String, Object>> qryStation(Long scheduleid);
	
	public boolean modifyScheduleDiscountPrice(long scheduleid,long departstationid,long reachstationid,long userid,int discountpricenum);
	
	public Long addScheduleDiscountPrice(ScheduleDiscountPrice schedulediscountprice,Global global) throws ServiceException;
}
