package cn.nova.bus.job;

import java.util.Date;

import javax.persistence.Query;

import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.job.model.Jobconfig;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.TransactionUtil;
/**
 * 执行删除班次循环超时班次任务，执行期间为一天一次，时间段00:00--01:00
 * @author feng
 *
 */
@Every("5min")
public class DelOvertimescheduleJob extends Job {
//	SchedulestatusDao dao = new SchedulestatusDao();
	@Override
	public void doJob() {
		try {
			Jobconfig job = BusJobUtil.getJobConfig("DelOvertimescheduleJob");
			if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
				SchedulestatusDao dao = new SchedulestatusDao();
				play.Logger.info("删除班次循环超时班次开始"+new Date());
				Query query = dao.getEntityManager().createNativeQuery("{call DELOVERTIMESCHEDULE()}");
				query.executeUpdate();
				play.Logger.info("删除班次循环超时班次开始！"+new Date());
				job.setLastruntime(new Date());
				TransactionUtil.begin();
				job = job.merge();
				job.save();
				TransactionUtil.commit();
			}
		} catch (Exception e) {
			play.Logger.info("生成日报表数据错误："+e.getMessage());
		}
	}
}
