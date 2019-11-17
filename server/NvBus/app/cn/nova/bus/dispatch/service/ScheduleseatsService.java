package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.utils.orm.PropertyFilter;

public interface ScheduleseatsService {

	public boolean save(Scheduleseats scheduleseats);

	public boolean delete(Scheduleseats scheduleseats);

	public boolean delete(Long id);

	public List<Scheduleseats> query();

	public Scheduleseats getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Scheduleseats findBySeatno(Long scheduleplanid, short seatno);

	public Long getScheduleplanid(Long scheduleid, Date departdate)throws ServiceException;

	public List<Scheduleseats> getSchedulelist(Long scheduleplanid, String status) throws ServiceException;

	public List<Scheduleseats> getScheduleList(Long scheduleplanid);

	public short getSeatno(Long scheduleplanid);

	public List<Scheduleseats> getScheduleseats(Long scheduleplanid, String status);

	public Scheduleseats findSeatnoBySeattype(Long scheduleplanid, short seatno,
			String seattype);

	public List<Scheduleseats> getScheduleseatsBySeattype(Long scheduleplanid,
			String string, String seattype);

}
