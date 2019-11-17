package cn.nova.bus.job;

import java.util.Date;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.insure.service.InsuranceSellService;
import cn.nova.bus.insure.service.impl.InsuranceSellServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.CurrentUserID;
//@Every("1min")
public class AutoPlatformInsuranceJob extends Job { 
	//private InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
	@Override
	public void doJob() throws Exception {
		long orgid = CurrentUserID.getOrgid();
		//是否使用bus365保险服务器售保险
		InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
		String param2626 = insuranceSellService.findParamValue(ParamterConst.Param_2626);
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
			Jobconfig job = BusJobUtil.getJobConfig("AutoPlatformInsuranceJob");
			if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
				//售保险
				insuranceSellService.autoPlatformSellInsurance();
				//退保险
				insuranceSellService.autoPlatformReturnInsurance();
				job.setLastruntime(new Date());
				job = job.merge();
				job.save();
			}
		}
	}

	
}
