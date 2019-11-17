package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;

public interface ScheduleplanService {

	public boolean save(Scheduleplan plan);

	public boolean delete(Scheduleplan plan);

	public boolean delete(Long id);

	public List<Scheduleplan> query();

	public Scheduleplan getById(Long id);

	public boolean saveseatnum(Scheduleplan plan, Long day, String string,String seatstatus) throws ServiceException;

	public Scheduleplan getByScheduleid(long scheduleid, Date date);
}
