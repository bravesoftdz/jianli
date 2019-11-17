package cn.nova.bus.dispatch.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.dao.ScheduleseatsDao;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class ScheduleseatsServiceImpl implements ScheduleseatsService {

	
	private ScheduleseatsDao dao = new ScheduleseatsDao();

	@Override
	public boolean save(Scheduleseats schedulestatus) {
		if (schedulestatus.getId() == 0) {
			return dao.save(schedulestatus);
		} else {
			return dao.update(schedulestatus);
		}
	}

	@Override
	public boolean delete(Scheduleseats schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulestatus.class, id);
	}

	@Override
	public List<Scheduleseats> query() {
		return dao.query(Scheduleseats.class, null);
	}

	@Override
	public Scheduleseats getById(Long id) {
		return (Scheduleseats) dao.get(Scheduleseats.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {

		return ListUtil.listToMap(
				new Object[] { Scheduleseats.class, "orgname" },
				dao.query(propertyFilterList), new Object[] {
						Scheduleseats.class, String.class });
	}

	@Override
	public Scheduleseats findBySeatno(Long scheduleplanid, short seatno) {
		return dao.findByseatno(scheduleplanid, seatno);
	}

	@Override
	public Long getScheduleplanid(Long scheduleid, Date departdate)
			throws ServiceException {
		if (dao.getScheduleplanid(scheduleid, departdate) == 0) {
			throw new ServiceException("0088");
		}
		return dao.getScheduleplanid(scheduleid, departdate);
	}

	@Override
	public List<Scheduleseats> getSchedulelist(Long scheduleplanid, String status)
			throws ServiceException {
		if (dao.getScheduleseats(scheduleplanid, status).isEmpty()) {
			throw new ServiceException("0089");
		}
		return dao.getScheduleseats(scheduleplanid, status);
	}
	
	@Override
	public List<Scheduleseats> getScheduleseats(Long scheduleplanid, String status) {
		if (dao.getScheduleseats(scheduleplanid, status).isEmpty()) {
			return new ArrayList();
		}
		return dao.getScheduleseats(scheduleplanid, status);
	}
	
	@Override
	public List<Scheduleseats> getScheduleList(Long scheduleplanid){
		return dao.getScheduleseatsByplanid(scheduleplanid);
	}
	
	@Override
	public short getSeatno(Long scheduleplanid){
		return dao.getSeatno(scheduleplanid);
	}
	
	@Override
	public Scheduleseats findSeatnoBySeattype(Long scheduleplanid, short seatno,String seattype) {
		return dao.findSeatnoBySeattype(scheduleplanid, seatno, seattype);
	}

	@Override
	public List<Scheduleseats> getScheduleseatsBySeattype(Long scheduleplanid,
			String status, String seattype) {
		if (dao.getScheduleseatsBySeattype(scheduleplanid, status, seattype).isEmpty()) {
			return new ArrayList();
		}
		return dao.getScheduleseatsBySeattype(scheduleplanid, status, seattype);
	}
	
}
