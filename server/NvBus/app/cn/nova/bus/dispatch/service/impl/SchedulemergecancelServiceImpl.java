package cn.nova.bus.dispatch.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.dao.SchedulemergecancelDao;
import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.dispatch.model.Schedulemergecancel;
import cn.nova.bus.dispatch.model.Schedulemergecanceldetail;
import cn.nova.bus.dispatch.model.Schedulemergedetail;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.dispatch.service.SchedulemergeService;
import cn.nova.bus.dispatch.service.SchedulemergecancelService;
import cn.nova.bus.dispatch.service.SchedulemergedetailService;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.dispatch.service.SchedulestatuslogService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SchedulemergecancelServiceImpl implements
		SchedulemergecancelService {

	
	private SchedulemergecancelDao dao = new SchedulemergecancelDao();

	
	private SchedulemergeService schedulemergeService = new SchedulemergeServiceImpl();

	
	private SchedulemergedetailService detailService = new SchedulemergedetailServiceImpl();

	
	private SchedulestatusService schedulestatusService = new SchedulestatusServiceImpl();

	
	private SchedulestatuslogService schedulestatuslogService = new SchedulestatuslogServiceImpl();

	
	private ScheduleplanService scheduleplanService = new ScheduleplanServiceImpl();

	@Override
	public boolean save(Schedulemergecancel schedulemergecancel,
			Long oldscheduleplanid) throws ServiceException {
		if (isExist(schedulemergecancel.getSchedulemergeid())) {

			if (isBegincheck(schedulemergecancel.getSchedulemergeid())) {//判断新班次是否已经检票
				throw new ServiceException("0101");
			}
			if (isDeparted(schedulemergecancel.getSchedulemergeid())) {//判断新班次是否已经发班
				throw new ServiceException("0102");
			}
			schedulemergecancel = (Schedulemergecancel) dao.merge(schedulemergecancel);// 取消并班

			Schedulemerge schedulemerge = schedulemergeService
					.getById(schedulemergecancel.getSchedulemergeid());
			schedulemerge.setIscancel(true);
			try {
				schedulemergeService.save(schedulemerge, null,"","");// 对并班表进行修改
			} catch (ServiceException e) {
				play.Logger.error(e.getMessage(), e);
			}

			List<Schedulemergedetail> mergedetailList = detailService
					.getBySchedulemergeid(schedulemergecancel
							.getSchedulemergeid());
			Schedulemergedetail mergedetail = null;
			for (int i = 0; i < mergedetailList.size(); i++) {
				mergedetail = detailService.getById(mergedetailList.get(i)
						.getId());
				Schedulemergecanceldetail canceldetail = new Schedulemergecanceldetail();
				canceldetail.setCreateby(schedulemergecancel.getCreateby());
				canceldetail.setCreatetime(schedulemergecancel.getCreatetime());
				canceldetail.setNewseatno(mergedetail.getOldseatno());
				canceldetail.setOldseatno(mergedetail.getNewseatno());
				canceldetail.setTicketsellid(mergedetail.getTicketsellid());
				canceldetail
						.setSchedulemergecancelid(schedulemergecancel.getSchedulemergeid());
				dao.merge(canceldetail);// 取消并班车票明细，并班前、并班后的座位号
			}

			List<Schedulestatus> schedulestatusList = schedulestatusService
					.getSchedulestatus(oldscheduleplanid);
			Schedulestatus schedulestatus = null;
			for (int i = 0; i < schedulestatusList.size(); i++) {
				schedulestatus = schedulestatusService
						.getById(schedulestatusList.get(i).getId());
				schedulestatus.setStatus("0");
				schedulestatus.setUpdateby(schedulemergecancel.getCreateby());
				schedulestatus.setUpdatetime(schedulemergecancel.getCreatetime());
				dao.merge(schedulestatus);// 取消并班后，改变班次状态
			}

			Scheduleplan scheduleplan = scheduleplanService
					.getById(oldscheduleplanid);
			Schedulestatuslog schedulestatuslog = schedulestatuslogService
					.getSchedulestatuslog(scheduleplan.getScheduleid(),
							scheduleplan.getDepartdate());
			schedulestatuslog.setOperationtype("6");
			schedulestatuslog.setAfterstatus(schedulestatuslog
					.getBeforestatus());
			schedulestatuslog.setBeforestatus("6");
			return schedulestatuslogService.save(schedulestatuslog);// 记录班次状态
		} else {
			return dao.update(schedulemergecancel);
		}
	}

	private boolean isDeparted(long schedulemergeid) {
		Schedulemerge merge = schedulemergeService.getById(schedulemergeid);
		return schedulemergeService.isdeparted(merge.getScheduleplanid());
	}

	private boolean isBegincheck(long schedulemergeid) {
		Schedulemerge merge = schedulemergeService.getById(schedulemergeid);
		return schedulemergeService.isbegincheck(merge.getScheduleplanid());
	}

	@Override
	public Long findSchedulemergecancelid() {
		return dao.getSchedulemergecancelid();
	}

	@Override
	public boolean delete(Schedulemergecancel schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulemerge.class, id);
	}

	@Override
	public List<Schedulemergecancel> query() {
		return dao.query(Schedulemergecancel.class, null);
	}

	@Override
	public Schedulemergecancel getById(Long id) {
		return (Schedulemergecancel) dao.get(Schedulemergecancel.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Schedulemergecancel.class,
				"schedulename", "cancelname", "createname" },
				dao.query(propertyFilterList), new Object[] {
						Schedulemergecancel.class, String.class, String.class,
						String.class });
	}

	@Override
	public Schedulemergecancel getBymergeid(Long scheduleplanid) {
		return dao.getBymergeid(scheduleplanid);
	}

	@Override
	public boolean isExist(Long schedulemergeid) {
		@SuppressWarnings("rawtypes")
		List list = dao.getSchedulemergecancel(schedulemergeid);
		if (list.isEmpty()) {
			return true;
		}
		return false;
	}

}
