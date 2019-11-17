package cn.nova.bus.job;

import java.util.Calendar;
import java.util.Date;

import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.sale.service.impl.UpdateTicketsellServiceImpl;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import play.jobs.OnApplicationStart;
import util.BusJobUtil;
import util.TransactionUtil;

/**
 * 售票数据增加冗余字段：
 * CUSTOMername: '旅客姓名';		CERTIFICATETYPENAME: '证件类型名称';	CERTIFICATENO: '证件号码';
 * VEHICLE: '报到车辆ID';		DEPARTINVOICESNO: '单号';			VEHICLEBRANDMODELID: '计划报到车辆品牌型号ID';
 * @author Administrator
 *
 */
//@On("0 0 21 ? * *")
//@OnApplicationStart
@Every("5min")
public class UpdateTicketsellJob extends Job {
//	UpdateTicketsellServiceImpl service = new UpdateTicketsellServiceImpl();

	public void doJob() {
		play.Logger.info("UpdateTicketsellJob售票数据增加冗余字段Job被执行………………");
		
		Jobconfig job = BusJobUtil.getJobConfig("UpdateTicketsellJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){  
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(job.getLastruntime());//设置为lastruntime，即前一天
			calendar.add(Calendar.DAY_OF_YEAR, 1);
			job.setLastruntime(new Date());
			UpdateTicketsellServiceImpl service = new UpdateTicketsellServiceImpl();
			service.updateTicketsellAndTicketsellagent(calendar.getTime());
									
			TransactionUtil.begin();
			job = job.merge();
			job.save();
			TransactionUtil.commit();
		}else{
			play.Logger.info("UpdateTicketsellJob未在数据库进行配置或者未到执行时间！！");
		}
		
		play.Logger.info("UpdateTicketsellJob售票数据增加冗余字段Job执行完毕………………");
	}
}
