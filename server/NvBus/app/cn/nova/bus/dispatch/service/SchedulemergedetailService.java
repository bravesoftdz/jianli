package cn.nova.bus.dispatch.service;

import java.util.List;

import cn.nova.bus.dispatch.model.Schedulemergedetail;

public interface SchedulemergedetailService {

	public boolean save(Schedulemergedetail schedulemergedetail);

	public List<Schedulemergedetail> getBySchedulemergeid(Long schedulemergeid);

	public Schedulemergedetail getById(Long id);
	
}
