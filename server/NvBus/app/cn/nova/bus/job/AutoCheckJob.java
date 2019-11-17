package cn.nova.bus.job;

import java.util.Date;
import java.util.List;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.dispatch.service.impl.SchedulestatusServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.CurrentUserID;
import util.CurrentUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>AutoCheckJob.java<br/>
 * <b>创建时间：</b>2014-12-5 上午09:31:46 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

//@Every("2min")
public class AutoCheckJob extends Job {

	//private SchedulestatusService schedulestatusService = new  SchedulestatusServiceImpl();
	//private ParameterService parameterService = new ParameterServiceImpl();
	@Override
	  public void doJob() {
		long orgid = CurrentUserID.getOrgid();
		String isautocheck = "";
		 ParameterService parameterService = new ParameterServiceImpl();
		if(orgid>0){
			isautocheck = parameterService.findParamValue(ParamterConst.Param_9099, orgid);
		}else{
			isautocheck = parameterService.findParamValue(ParamterConst.Param_9099, null);
		}

		if(isautocheck.equals("1")){//是否自动开检，0:否，1:是
		Jobconfig job = BusJobUtil.getJobConfig("AutoCheckJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){  
			JPA.em().getTransaction().begin();
			SchedulestatusService schedulestatusService = new  SchedulestatusServiceImpl();
			schedulestatusService.updateScheduleStatus();
									
			job.setLastruntime(new Date());
			job = job.merge();
			job.save();
			JPA.em().getTransaction().commit();
		}
		}
		
	  }
	
	
}
