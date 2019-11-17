package cn.nova.bus.job;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.Date;

import javax.persistence.Query;

import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.job.model.Jobconfig;
import play.db.DB;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.OnApplicationStart;
import util.BusJobUtil;
import util.TransactionUtil;

@Every("1h")
public class AutoDelovertimescheduleJob extends Job {
	
	//SchedulestatusDao dao = new SchedulestatusDao();
	
	@Override
	public void doJob() {
		try {
			Jobconfig job = BusJobUtil.getJobConfig("AutoDelovertimescheduleJob");
			if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
				 Query query = null;
				 SchedulestatusDao dao = new SchedulestatusDao();
				 query = dao.getEntityManager().createNativeQuery("{call DELETEJOBSPROCEDURE('delovertimeschedule;')}");
				 query.executeUpdate();
				 play.Logger.info("{call DELOVERTIMESCHEDULE()}开始！"+new Date());
				 query = dao.getEntityManager().createNativeQuery("{call DELOVERTIMESCHEDULE()}");
				query.executeUpdate();
				play.Logger.info("{call DELOVERTIMESCHEDULE()}结束！"+new Date());
				job.setLastruntime(new Date());
				TransactionUtil.begin();
				job = job.merge();
				job.save();
				TransactionUtil.commit();
			}
		} catch (Exception e) {
			play.Logger.info("{call DELOVERTIMESCHEDULE()}错误："+e.getMessage());
			System.out.println(e.getMessage());
		}
	}
}
