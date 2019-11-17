package cn.nova.bus.job;

import java.util.Date;

import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import play.jobs.OnApplicationStart;
import util.BusJobUtil;
import cn.nova.bus.archive.service.CustomerService;
import cn.nova.bus.archive.service.impl.CustomerServiceImpl;
import cn.nova.bus.job.model.Jobconfig;


/**
 * 给customer增加了冗余字段，每天晚上对其进行更新
 * @author zhangxibao 2017年12月21日17:10:48
 *
 */
@Every("1h")
public class AutoUpdateCustomerJob extends Job {
	
	

	private CustomerService customerService;
	@Override
	public void doJob() throws Exception {
		Jobconfig job = BusJobUtil.getJobConfig("AutoUpdateCustomerJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			customerService = new CustomerServiceImpl();
			try {
				play.Logger.info("AutoUpdateCustomerJob开始………………");
				customerService.updateCustomer();
				job.setLastruntime(new Date());
				job.merge();
				play.Logger.info("AutoUpdateCustomerJob结束………………");
			} catch (Exception e) {
				play.Logger.error("AutoUpdateCustomerJob :"+e.getMessage());
				System.out.println(e.getMessage());
			}
		}
	}
}
