package cn.nova.bus.dispatch.service.impl;

import java.util.List;

import cn.nova.bus.dispatch.dao.SchedulemergecancelDao;
import cn.nova.bus.dispatch.dao.SchedulemergedetailDao;
import cn.nova.bus.dispatch.model.Schedulemergedetail;
import cn.nova.bus.dispatch.service.SchedulemergedetailService;

@SuppressWarnings("unchecked")
public class SchedulemergedetailServiceImpl implements
		SchedulemergedetailService {

	
	private SchedulemergedetailDao detaildao = new SchedulemergedetailDao();

	
	private SchedulemergecancelDao dao = new SchedulemergecancelDao();

	@Override
	public boolean save(Schedulemergedetail schedulemergedetail) {
		if (schedulemergedetail.getId() == 0) {
			return dao.save(schedulemergedetail);
		} else {
			return dao.update(schedulemergedetail);
		}
	}

	@Override
	public List<Schedulemergedetail> getBySchedulemergeid(Long schedulemergeid) {
		return detaildao.getBySchedulemergeid(schedulemergeid);
	}

	@Override
	public Schedulemergedetail getById(Long id) {
		return (Schedulemergedetail) detaildao.get(Schedulemergedetail.class,
				id);
	}

}
