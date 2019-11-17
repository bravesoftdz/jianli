package cn.nova.bus.job;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.insure.service.InsuranceSellService;
import cn.nova.bus.insure.service.impl.InsuranceSellServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
@Every("60min")
public class AutoSyncInsureJob extends Job { 
	//private InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
	@Override
	public void doJob() throws Exception {
		Jobconfig job = BusJobUtil.getJobConfig("AutoSyncInsureJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
			String param2626 = insuranceSellService.findParamValue(ParamterConst.Param_2626);
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
				insuranceSellService.syncPlatformInsureType();
			}
		}
	}
}
