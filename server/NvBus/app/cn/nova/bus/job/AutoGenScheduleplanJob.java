package cn.nova.bus.job;

import java.util.Date;

import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.TransactionUtil;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.price.service.GenScheduleplanService;
import cn.nova.bus.price.service.impl.GenScheduleplanServiceImpl;
import cn.nova.utils.orm.jpa.IDAO;

//@Every("1min")
public class AutoGenScheduleplanJob extends Job {
	

	@Override
	public void doJob() {
		Jobconfig job = BusJobUtil.getJobConfig("AutoGenScheduleplanJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			System.out.println("AutoGenScheduleplanJob被执行………………");
			GenScheduleplanService genScheduleplanService = new GenScheduleplanServiceImpl();
			genScheduleplanService.autoGenerateScheduleplanold();
			job.setLastruntime(new Date());
			TransactionUtil.begin();
			job = job.merge();
			job.save();
			TransactionUtil.commit();
		}
	}
	

}
