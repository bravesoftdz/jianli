package job;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.insure.service.InsuranceSellService;
import cn.nova.bus.insure.service.impl.InsuranceSellServiceImpl;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import play.jobs.Job;
import play.jobs.OnApplicationStart;

//@OnApplicationStart(async=true)
public class SyncPlatformInsuranceType extends Job{
	
	//private InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
	@Override
	public void doJob() throws Exception {
		//是否使用bus365保险服务器售保险
		InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
		String param2626 = insuranceSellService.findParamValue(ParamterConst.Param_2626);
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
			insuranceSellService.syncPlatformInsureType();
		}
	}
}
