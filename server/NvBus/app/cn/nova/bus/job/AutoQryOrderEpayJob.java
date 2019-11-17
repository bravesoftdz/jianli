package cn.nova.bus.job;

import java.util.Date;

import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.sale.service.EPayService;
import cn.nova.bus.sale.service.impl.EPayServiceImpl;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;

//@Every("5min")
public class AutoQryOrderEpayJob extends Job{
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	@Override
	public void doJob() throws Exception {
		Jobconfig job = BusJobUtil.getJobConfig("AutoQryOrderEpayJob");
		String epay=parameterService.findParamValue("1073",null);
		if(epay.equals("1") && job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			EPayService ePayService = new EPayServiceImpl();
			try {
				ePayService.syncOrderEpay();
				job.setLastruntime(new Date());
				job = job.merge();
				job.save();
			} catch (Exception e) {
				play.Logger.error("AutoQryOrderEpayJob异常！"+e.getMessage(),e);
			}
		}
	}
}
