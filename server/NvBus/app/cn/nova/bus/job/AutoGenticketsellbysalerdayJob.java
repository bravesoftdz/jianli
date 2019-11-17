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

//@Every("1min")
public class AutoGenticketsellbysalerdayJob extends Job {
	
	
	
	@Override
	public void doJob() {
		try {
			Jobconfig job = BusJobUtil.getJobConfig("AutoGenticketsellbysalerdayJob");
			if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
				Query query = null;
				SchedulestatusDao dao = new SchedulestatusDao();
				 query = dao.getEntityManager().createNativeQuery("{call DELETEJOBSPROCEDURE('genticketsellbysalerday;')}");
				 query.executeUpdate();
				play.Logger.info("生成日报表数据开始！"+new Date());
				 query = dao.getEntityManager().createNativeQuery("{call GENTICKETSELLBYSALERDAY()}");
				query.executeUpdate();
				play.Logger.info("生成日报表数据结束！"+new Date());
				job.setLastruntime(new Date());
				TransactionUtil.begin();
				job = job.merge();
				job.save();
				TransactionUtil.commit();
			}
		} catch (Exception e) {
			play.Logger.info("生成日报表数据错误："+e.getMessage());
			System.out.println(e.getMessage());
		}
	}
}
