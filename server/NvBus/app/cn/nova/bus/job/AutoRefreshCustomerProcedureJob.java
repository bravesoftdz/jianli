package cn.nova.bus.job;

import java.util.Date;

import javax.persistence.Query;

import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.TransactionUtil;
import cn.nova.bus.archive.dao.CustomerDao;
import cn.nova.bus.job.model.Jobconfig;

/**
 * 更新客户档案管理信息，customer表，调存储过程refreshcustomer
 * @author Administrator
 *
 */
@Every("1h")
public class AutoRefreshCustomerProcedureJob extends Job {

	@Override
	public void doJob() throws Exception {
		try {
			Jobconfig job = BusJobUtil.getJobConfig("AutoRefreshCustomerProcedureJob");
			if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) 
					&& job.isTriggerTime() && job.getIsactive()){
				CustomerDao customerdao = new CustomerDao();
				Query query = null;
				Date date = new Date();
				TransactionUtil.begin();
				play.Logger.info("{call REFRESHCUSTOMER()}开始！"+new Date());
				query = customerdao.getEntityManager().createNativeQuery("{call REFRESHCUSTOMER()}");
				int i = query.executeUpdate();
				job.setLastruntime(date);
				job.setIsactive(false);  //调用一次
				job.merge();
				TransactionUtil.commitAndBegin();
				play.Logger.info("{call REFRESHCUSTOMER()}结束！"+new Date());
			}
		} catch (Exception e) {
			play.Logger.info("{call REFRESHCUSTOMER()}错误："+e.getMessage());
			System.out.println(e.getMessage());
		}
	}
}
