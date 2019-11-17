package job;

import java.util.List;

import models.RedoObject;

import org.apache.commons.lang.StringUtils;

import play.Play;
import play.jobs.Every;
import play.jobs.Job;
import util.AppConstant;
import util.RedisUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.TransactionUtil;
import util.RedisUtil.RedisDBApp;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.dispatch.service.impl.SeatreserveServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;

//@Every("2min")
public class CancelSeatRedoJob extends Job {
	@Override
	public void doJob() throws Exception {
		super.doJob();
		List<String> list = RedisUtil.getList(RedisDBApp.cancelSeat, AppConstant.getValue("app.maccode"));
		for (String json : list) {
			if(StringUtils.isEmpty(json)){
				continue;
			}

			RedoObject redo = RedoObject.parseFromString(json);
			redo.incrementCursorTimes();
			MethodResult remoteMethodCall = null;
			if(redo.isTouched()){
				String remoteUrl = RemoteApi.CANCEL_RESERVE;
				try{
					remoteMethodCall = RpcUtil.remoteMethodCall(redo.ip, remoteUrl, redo.requestMap);
					if(remoteMethodCall.getResult() != MethodResult.SUCCESS){
						redo.nextTrigger();
						RedisUtil.rPush(RedisDBApp.cancelSeat, AppConstant.getValue("app.maccode"), redo.toJson());
					}
				} catch (ServiceException se) {
					//业务异常，认为成功。
				}catch(Exception e){
					//其他异常，认为失败。
					play.Logger.error(e.getMessage(), e);
					redo.nextTrigger();
					RedisUtil.rPush(RedisDBApp.cancelSeat, AppConstant.getValue("app.maccode"), redo.toJson());
				}
			}
		}
		RedisUtil.delOldList(RedisDBApp.cancelSeat,  AppConstant.getValue("app.maccode"), list.size());
	}
}
