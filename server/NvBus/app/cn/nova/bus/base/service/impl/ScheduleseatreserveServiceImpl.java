/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service.impl<br/>
 * <b>文件名：</b>ScheduleseatreserveServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-8-9-下午05:50:24<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.ScheduleseatreserveDao;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Scheduleseatreserve;
import cn.nova.bus.base.service.ScheduleseatreserveService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleseatreserveServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class ScheduleseatreserveServiceImpl implements
		ScheduleseatreserveService {
	
	private ScheduleseatreserveDao scheduleseatreserveDao = new ScheduleseatreserveDao();

	/*
	 * qryScheduleseatreserve方法：<br/> <br/>
	 * 
	 * @param schedule
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see
	 * cn.nova.bus.base.service.ScheduleseatreserveService#qryScheduleseatreserve
	 * (cn.nova.bus.base.model.Schedule)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryScheduleseatreserve(long scheduleid)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { Scheduleseatreserve.class,
				"vehicletypename", "createname", "updatename","brandname" },
				scheduleseatreserveDao.qryScheduleseatreserve(scheduleid),
				new Object[] { Scheduleseatreserve.class, String.class,
						String.class,String.class, String.class});
	}

	/*
	 * saveScheduleseatreserve方法：<br/> <br/>
	 * 
	 * @param scheduleseatreserve
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see
	 * cn.nova.bus.base.service.ScheduleseatreserveService#saveScheduleseatreserve
	 * (cn.nova.bus.base.model.Scheduleseatreserve)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Scheduleseatreserve saveScheduleseatreserve(
			Scheduleseatreserve scheduleseatreserve, boolean issameroute)
			throws ServiceException {
		if (scheduleseatreserveDao.isExistOtherByDate(scheduleseatreserve)) {
			// 同一班次同一车型的日期段不能交叉！
			throw new ServiceException("0284");
		}

		if (issameroute) {
			Schedule schedule = (Schedule) scheduleseatreserveDao.get(
					Schedule.class, scheduleseatreserve.getScheduleid());
			if (scheduleseatreserveDao.isExistSameRoute(scheduleseatreserve,
					schedule.getRoute().getId())) {
				// 同线路的其他班次该车型的日期段已经存在固定留位信息！
				throw new ServiceException("0285");
			}
			List<Schedule> slist = scheduleseatreserveDao.qrySchedule(schedule
					.getRoute().getId());
			for (Schedule s : slist) {
				Scheduleseatreserve sr = new Scheduleseatreserve();
				sr.setCreateby(scheduleseatreserve.getCreateby());
				sr.setCreatetime(new Date());
				sr.setEnddate(scheduleseatreserve.getEnddate());
				sr.setIsactive(true);
				sr.setScheduleid(s.getId());
				sr.setSeatnos(scheduleseatreserve.getSeatnos());
				sr.setSeatnum(scheduleseatreserve.getSeatnum());
				sr.setStartdate(scheduleseatreserve.getStartdate());
				sr.setUpdateby(scheduleseatreserve.getUpdateby());
				sr.setUpdatetime(new Date());
				sr.setVehiclebrandmodelid(scheduleseatreserve.getVehiclebrandmodelid());
				sr.setVehicletypeid(scheduleseatreserve.getVehicletypeid());
				if (sr.getScheduleid() == scheduleseatreserve.getScheduleid()) {
					scheduleseatreserve = scheduleseatreserveDao
							.getEntityManager().merge(sr);
				} else {
					scheduleseatreserveDao.getEntityManager().merge(sr);
				}
			}
			return scheduleseatreserve;
		} else {
			if (scheduleseatreserve.getId() == 0) {
				scheduleseatreserve.setIsactive(true);
				scheduleseatreserve.setCreatetime(new Date());
				scheduleseatreserve.setUpdatetime(new Date());
				scheduleseatreserve.setUpdateby(scheduleseatreserve
						.getCreateby());
			} else {
				scheduleseatreserve.setIsactive(true);
				scheduleseatreserve.setUpdatetime(new Date());
				scheduleseatreserve.setUpdateby(scheduleseatreserve
						.getCreateby());
			}
			return scheduleseatreserveDao.getEntityManager().merge(
					scheduleseatreserve);
		}
	}

	/*
	 * delScheduleseatreserve方法：<br/> <br/>
	 * 
	 * @param scheduleseatreserve
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see
	 * cn.nova.bus.base.service.ScheduleseatreserveService#delScheduleseatreserve
	 * (cn.nova.bus.base.model.Scheduleseatreserve)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean delScheduleseatreserve(
			Scheduleseatreserve scheduleseatreserve) throws ServiceException {
		Scheduleseatreserve ss = (Scheduleseatreserve) scheduleseatreserveDao
				.get(Scheduleseatreserve.class, scheduleseatreserve.getId());
		ss.setIsactive(false);
		ss.setUpdateby(scheduleseatreserve.getUpdateby());
		ss.setUpdatetime(new Date());
		return true;
	}

	@Override
	public List<Map<String, Object>> qryScheduleVehiclebrandmodel(
			long scheduleid) {
		return ListUtil
				.listToMap(new Object[] { "id", "name", "modelcode",
						"rationseatnum", "vehicletypeid" },
						scheduleseatreserveDao
								.qryScheduleVehiclebrandmodel(scheduleid),
						new Object[] { Long.class, String.class, String.class,
								short.class, Long.class });
	}

}
