package job;

import java.util.HashMap;
import java.util.List;

import models.RedoObject;
import models.UndoTransaction;

import org.apache.commons.lang.StringUtils;

import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import play.Play;
import play.jobs.Every;
import play.jobs.Job;
import util.AppConstant;
import util.RedisUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.TransactionUtil;
import util.RedisUtil.RedisDBApp;

//@Every("2min")
public class ReturnTicketRedoJob extends Job {
	@Override
	public void doJob() throws Exception {
		List<String> list = RedisUtil.getList(RedisDBApp.returnTicket, AppConstant.getValue("app.maccode"));
		for (String json : list) {
			if(StringUtils.isEmpty(json)){
				continue;
			}

			RedoObject redo = RedoObject.parseFromString(json);
			redo.incrementCursorTimes();
			MethodResult remoteMethodCall = null;
			if(redo.isTouched()){
				String remoteUrl = redo.isRemote ? RemoteApi.RETURN_TICKETS : RemoteApi.SCHEDULE_RETURN_TICKET;
				try{
					remoteMethodCall = RpcUtil.remoteMethodCall(redo.ip, remoteUrl, redo.requestMap);
					if(remoteMethodCall.getResult() != MethodResult.SUCCESS){
						redo.nextTrigger();
						RedisUtil.rPush(RedisDBApp.returnTicket, AppConstant.getValue("app.maccode"), redo.toJson());
					}
				} catch (ServiceException se) {
					//业务异常，认为成功。
				}catch(Exception e){
					//其他异常，认为失败。
					play.Logger.error(e.getMessage(), e);
					redo.nextTrigger();
					RedisUtil.rPush(RedisDBApp.returnTicket, AppConstant.getValue("app.maccode"), redo.toJson());
				}
			}
		}
		RedisUtil.delOldList(RedisDBApp.returnTicket, AppConstant.getValue("app.maccode"), list.size());
	}
}
