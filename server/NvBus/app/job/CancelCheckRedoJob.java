package job;

import java.util.List;

import models.RedoObject;

import org.apache.commons.lang.StringUtils;

import play.Play;
import play.jobs.Every;
import play.jobs.Job;
import play.jobs.On;
import util.AppConstant;
import util.RedisUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.RedisUtil.RedisDBApp;
import util.TransactionUtil;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;

//@Every("2min")
public class CancelCheckRedoJob extends Job{
	@Override
	public void doJob() throws Exception {
		super.doJob();
		List<String> list = RedisUtil.getList(RedisDBApp.cancelCheck, AppConstant.getValue("app.maccode"));
		for (String json : list) {
			if(StringUtils.isEmpty(json)){
				continue;
			}

			RedoObject redo = RedoObject.parseFromString(json);
			redo.incrementCursorTimes();
			MethodResult remoteMethodCall = null;
			if(redo.isTouched()){
				String remoteUrl = redo.isRemote ? RemoteApi.CANCEL_REMOTE_CHECK : RemoteApi.CANEL_CHECK_TICKET;
				try{
					remoteMethodCall = RpcUtil.remoteMethodCall(redo.ip, remoteUrl, redo.requestMap);
					if(remoteMethodCall.getResult() != MethodResult.SUCCESS){
						redo.nextTrigger();
						RedisUtil.rPush(RedisDBApp.cancelCheck, AppConstant.getValue("app.maccode"), redo.toJson());
					}
				} catch (ServiceException se) {
					//业务异常，认为成功。
				}catch(Exception e){
					//其他异常，认为失败。
					play.Logger.error(e.getMessage(), e);
					redo.nextTrigger();
					RedisUtil.rPush(RedisDBApp.cancelCheck, AppConstant.getValue("app.maccode"), redo.toJson());
				}
			}
		}
		RedisUtil.delOldList(RedisDBApp.cancelCheck,  AppConstant.getValue("app.maccode"), list.size());
	}
}
