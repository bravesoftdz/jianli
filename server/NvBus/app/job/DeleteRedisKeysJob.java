package job;

import java.util.List;
import java.util.Set;

import cn.nova.bus.system.dao.UseronlineDao;
import cn.nova.bus.system.model.Useronline;
import play.jobs.Job;
import play.jobs.OnApplicationStart;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

//@OnApplicationStart
public class DeleteRedisKeysJob extends Job {
	@Override
	public void doJob() throws Exception {
		super.doJob();
		// 获取global区key数量
		long keysCount = RedisUtil.getKeysCount(RedisDBApp.global);
		if (keysCount > 100000) {
			RedisUtil.flushAll();
			play.Logger.info("当前global区中含有" + keysCount + "个key, 清空redis...");
		}
	}
}
