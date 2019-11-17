package cn.nova.bus.job;

import java.util.Date;

import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.TransactionUtil;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.sale.service.AutoUnlockSeatService;
import cn.nova.bus.sale.service.impl.AutoUnlockSeatServiceImpl;

@Every("1min")
public class AutoUnLockSeat extends Job {
  //private AutoUnlockSeatService autoUnlockSeatService = new AutoUnlockSeatServiceImpl();

  @Override
  public void doJob() {
	Jobconfig job = BusJobUtil.getJobConfig("AutoUnLockSeat");
	if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
		AutoUnlockSeatService autoUnlockSeatService = new AutoUnlockSeatServiceImpl();
		autoUnlockSeatService.start();
		
		job.setLastruntime(new Date());
		job = job.merge();
		job.save();
	}
  }
    

}
