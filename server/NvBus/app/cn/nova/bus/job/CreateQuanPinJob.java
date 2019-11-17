package cn.nova.bus.job;

import play.jobs.Job;
import play.jobs.OnApplicationStart;
import cn.nova.bus.dispatch.service.CreateQuanPinService;
import cn.nova.bus.dispatch.service.impl.CreateQuanPinServiceImpl;

/**
 * 给driver表的姓名添加了全拼字段，给历史数据全拼为空的赋值
 * @author zhangxibao  2017-11-02
 *
 */
@OnApplicationStart
public class CreateQuanPinJob extends Job {
	private CreateQuanPinService createQuanPinService;
	@Override
	public void doJob() throws Exception {
		super.doJob();
		createQuanPinService = new CreateQuanPinServiceImpl();
		try {
				play.Logger.info("CreateQuanPinJob开始………………");
				createQuanPinService.queryDriver();
				play.Logger.info("CreateQuanPinJob结束………………");
		} catch (Exception e) {
			play.Logger.error("CreateQuanPinJob :"+e.getMessage());
			System.out.println(e.getMessage());
		}
	}
	
}
