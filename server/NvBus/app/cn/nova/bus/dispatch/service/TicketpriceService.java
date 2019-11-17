package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketpriceService {

	public boolean save(Ticketprice ticketprice);

	public boolean delete(Ticketprice ticketprice);

	public boolean delete(Long id);

	public List<Ticketprice> query();

	public Ticketprice getById(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public List<Ticketprice> getByScheduleplanid(Long scheduleplanid);

	public List<Ticketprice> getByScheduleplanid(LockModeType lockModeType,Long scheduleplanid);

	public List<Ticketprice> getByScheduleplanSeattype(Long scheduleplanid, String seattype);
	
	public List<Ticketprice> getByScheduleplanSeattype(LockModeType lockModeType,Long scheduleplanid, String seattype);

	public List<Map<String, Object>> findSchedulestops(
			List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> queryRouteschedule(
			List<PropertyFilter> propertyFilterList);

	public boolean savePlanprice(List<Ticketprice> dispatchticketprice,
			String routescheduleid, Long day, Date departdate, long updateby,
			String string, Long scheduleid) throws ServiceException;

	public List<Map<String, Object>> queryStopstation(long scheduleplanid);

	public boolean stopstation(String reachstationid, String routescheduleid,
			Long day, Date departdate, long id, String ipAddress,
			Long scheduleid) throws ServiceException;

}
