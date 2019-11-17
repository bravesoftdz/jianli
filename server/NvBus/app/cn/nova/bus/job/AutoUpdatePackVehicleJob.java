package cn.nova.bus.job;

import java.util.Date;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.pack.service.GenUpdatePackVehicleService;
import cn.nova.bus.pack.service.impl.GenUpdatePackVehicleServiceImpl;
import cn.nova.bus.price.service.GenScheduleplanService;
import cn.nova.bus.price.service.impl.GenScheduleplanServiceImpl;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.TransactionUtil;

//@Every("1min")
public class AutoUpdatePackVehicleJob extends Job{
	

	@Override
	public void doJob() {
		Jobconfig job = BusJobUtil.getJobConfig("AutoUpdatePackVehicleJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			GenUpdatePackVehicleService updatePackVehicleService = new GenUpdatePackVehicleServiceImpl();
			System.out.println("AutoUpdatePackVehicleJob被执行………………");
			play.Logger.info("AutoUpdatePackVehicleJob被执行………………");
				updatePackVehicleService.GenUpdatePackVehicle();
			job.setLastruntime(new Date());
			TransactionUtil.begin();
			job = job.merge();
			job.save();
			TransactionUtil.commit();
		}else{
			play.Logger.info("AutoUpdatePackVehicleJob不在执行范围之内………………");	
		}
	}
}
