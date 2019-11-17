package cn.nova.bus.job;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import play.Play;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.OnApplicationStart;
import util.BusJobUtil;
import cn.nova.bus.job.model.Jobconfig;

//@Every("1min")
//@OnApplicationStart(async=true)
public class JobConfigBuilderJob extends Job{

	@Override
	public void doJob() throws Exception {
		super.doJob();
	    String sql ="from Jobconfig where isactive=1 " + (StringUtils.isEmpty(Play.configuration.getProperty("job.typeFilter")) ? "":" and type in (" + Play.configuration.getProperty("job.typeFilter") + ") ");
		List<Jobconfig> jobs = Jobconfig.find(sql).fetch();
		for (Jobconfig job : jobs) {
			BusJobUtil.JOB_CONFIGS.put(job.getJobname(), job);
		}
	}
}








