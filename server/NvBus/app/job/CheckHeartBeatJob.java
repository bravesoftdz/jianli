package job;

import java.util.List;

import models.RedoObject;

import org.apache.commons.lang.StringUtils;

import play.Play;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import play.jobs.OnApplicationStart;
import util.AppConstant;
import util.RedisUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.RedisUtil.RedisDBApp;
import util.TransactionUtil;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.UseronlineDao;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Useronline;
import cn.nova.utils.commons.MethodResult;
import controllers.HeartBeat;

//@Every("5s")
//@OnApplicationStart
public class CheckHeartBeatJob extends Job{
	@Override
	public void doJob() throws Exception {
		super.doJob();
		UseronlineDao dao = new UseronlineDao();
		List<Useronline> onlineUserList = dao.queryOnlineUser();
		Userinfo userinfo = null;
		for (Useronline useronline : onlineUserList) {
			userinfo = (Userinfo) dao.get(Userinfo.class, useronline.getUserid()); 
			HeartBeat.checkHeartBeat(useronline,userinfo);
		}
		
	}
}
