package cn.nova.bus.job;

import java.util.Date;

import cn.nova.bus.dispatch.service.SchedulestatusStopService;
import cn.nova.bus.dispatch.service.impl.SchedulestatusStopServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import play.jobs.OnApplicationStart;
import util.BusJobUtil;
import util.TransactionUtil;

//@OnApplicationStart
@On("0 0 23 * * ?")
public class AutoStopScheduleplanJob extends Job {
	//private SchedulestatusStopService stopService = new SchedulestatusStopServiceImpl();
	
	@Override
	public void doJob() {
		Jobconfig job = BusJobUtil.getJobConfig("AutoStopScheduleplanJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			play.Logger.info("AutoStopScheduleplanJob自动停班Job被执行………………");
			SchedulestatusStopService stopService = new SchedulestatusStopServiceImpl();
			stopService.autoStopScheduleplan();
			
			job.setLastruntime(new Date());
			TransactionUtil.begin();
			job = job.merge();
			job.save();
			TransactionUtil.commit();
			
			play.Logger.info("AutoStopScheduleplanJob自动停班Job执行完成………………");
		}
	}


}
