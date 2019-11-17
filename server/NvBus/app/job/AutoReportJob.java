package job;

import java.util.Date;

import cn.nova.bus.dispatch.service.AutoReportService;
import cn.nova.bus.dispatch.service.impl.AutoReportServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import util.BusJobUtil;
import util.SystemException;
import util.UserTransaction;
/**
 * 功能：将自动报到的且有计划车辆的班次自动报班
 * 
 * @author 张彪
 * @version 0.1
 * @date 2016-03-05
 * 每天晚上10点执行    
 */
//@Every("1min")
public class AutoReportJob extends Job {
//	private AutoReportService autoReportService = new AutoReportServiceImpl();
//	 private UserTransaction userTransaction = new UserTransaction();
	@Override
	public void doJob() throws Exception {
		Jobconfig job = BusJobUtil.getJobConfig("AutoReportJob");
		if(null != job   ){
			play.Logger.info("job.getIsactive()    "+job.getIsactive());
			play.Logger.info("isTimeBetween4now  "+BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()));
			play.Logger.info("job.isTriggerTime()   "+job.isTriggerTime());
		}		
		if(job != null && job.getIsactive() && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){  
			play.Logger.info("执行AutoReportJob 开始");
			AutoReportService autoReportService = new AutoReportServiceImpl();
			 UserTransaction userTransaction = new UserTransaction();
				if (autoReportService.start()){
					play.Logger.info("autoReportService.start() true");
					try{
						userTransaction.begin();
						job.setLastruntime(new Date());
						job = job.merge();
						job.save();	
						userTransaction.commit();
				        play.Logger.info("自助报班执行完成！");
				        } catch (SystemException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
							play.Logger.info("自助报班执行异常！");
							try {
								userTransaction.rollback();
							} catch (SystemException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
						}
				
				}
		}else{
			play.Logger.info("AutoReportJob 未查询到 JOB 或者 JOB 不在运行时间范围内,跳过执行 JOB !");
		}
	}	
}
