package cn.nova.bus.job;

import java.util.Date;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.dispatch.service.impl.ScheduleplanServiceImpl;
import cn.nova.bus.dispatch.service.impl.SchedulestatusServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.CurrentUserID;
/**
 * 增加参数3109控制自动加座，支持手持机售票
 * @author feng
 *
 */
//@Every("1min")
public class AutoAddSeatAfterReport extends Job {
	
	@Override
	public void doJob() throws Exception {
		long orgid = CurrentUserID.getOrgid();
		String addReport = "";
		 ParameterService parameterService = new ParameterServiceImpl();
		if(orgid>0){
			addReport = parameterService.findParamValue("3109", orgid);
		}else{
			addReport = "0";
		}

		if(!"0".equals(addReport)){//是否自动加座，0:不加，N:发班N分钟后开始加座
		Jobconfig job = BusJobUtil.getJobConfig("AutoAddSeatAfterReportJob2");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){  
			ScheduleplanServiceImpl seatreserveService = new ScheduleplanServiceImpl();
			seatreserveService.autoAddSeatAfterReport(addReport);
			job.setLastruntime(new Date());
			job = job.merge();
			job.save();
		}
	  }
	}
}
