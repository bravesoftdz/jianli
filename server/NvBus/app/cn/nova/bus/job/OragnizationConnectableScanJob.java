/**
 * <b>项目名：</b>NvCentreEJB<br/>
 * <b>包名：</b>cn.nova.centre.datasync.task.job<br/>
 * <b>文件名：</b>OragnizationConnectableScanJob.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2012-1-7-下午10:20:07<br/>
 * <b>Copyright (c)</b> 2012深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.job;

import java.util.Date;
import java.util.List;

import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.impl.OrganizationConnectableServiceImpl;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.services.OrganizationConnectableService;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>OragnizationConnectableScanJob<br/>
 * <b>创建人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@Every("1min")
public class OragnizationConnectableScanJob extends Job {
	// public IDAO dao = new EntityManagerDaoSurport();  
	
	final private String ORGANIZATION_QUERY_SQL = "from Organization where isactive=1 and islocal=0 and type in ('4','5','6','7')";

	//private OrganizationConnectableService organizationConnectableService = new OrganizationConnectableServiceImpl();

	@SuppressWarnings("unchecked")
	@Override
	public void doJob() {
		Jobconfig job = BusJobUtil.getJobConfig("OragnizationConnectableScanJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			IDAO dao = new EntityManagerDaoSurport();  
			List<Organization> orgs = dao.find(ORGANIZATION_QUERY_SQL);
			if (orgs == null || orgs.size() == 0)
				return;
			OrganizationConnectableService organizationConnectableService = new OrganizationConnectableServiceImpl();
			for (Organization org : orgs) {
				organizationConnectableService.check(org);
			}
			job.setLastruntime(new Date());
			job = job.merge();
			job.save();
		}
	}



}