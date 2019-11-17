package cn.nova.bus.job;

import java.util.Date;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.utils.orm.jpa.IDAO;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.DateUtils;
import util.TransactionUtil;

//@Every("1min")
public class AutoGenTicketsellbalanceJob extends Job{
	@Override
	public void doJob() {
		try {
			Date now = new Date();
			Jobconfig job = BusJobUtil.getJobConfig(getClass().getSimpleName());
			if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
				Query query = null;
				IDAO dao = new EntityManagerDaoSurport();
				play.Logger.info("生成财务收支平衡表开始！"+DateUtils.formatDatetime(now));
				 query = dao.getEntityManager().createNativeQuery("{call GENTICKETSELLBALANCE()}");
				query.executeUpdate();
				play.Logger.info("生成财务收支平衡表开始！"+DateUtils.formatDatetime(now));
				job.setLastruntime(now);
				TransactionUtil.begin();
				job = job.merge();
				job.save();
				TransactionUtil.commit();
			}
		} catch (Exception e) {
			play.Logger.info("生成日报表数据错误："+e.getMessage(),e);
		}
	}
}
