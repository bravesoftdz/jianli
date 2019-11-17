package cn.nova.bus.job;

import play.jobs.Every;
import play.jobs.Job;
import cn.nova.bus.insure.service.InsuranceSellService;
import cn.nova.bus.insure.service.impl.InsuranceSellServiceImpl;

public class UploadInsuranceJob extends Job {
	//InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();

	@Override
	public void doJob() {
		InsuranceSellService insuranceSellService = new InsuranceSellServiceImpl();
		System.out.println("UploadInsuranceJob被执行………………");
		insuranceSellService.uploadInsurance();

	}



}
