package job;

import java.util.HashMap;
import java.util.List;

import models.UndoTransaction;

import org.apache.commons.lang.StringUtils;

import play.Play;
import play.jobs.Every;
import play.jobs.Job;
import util.AppConstant;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import util.RpcUtil;
import cn.nova.utils.commons.MethodResult;

//@Every("2min")
public class UndoJob extends Job {
	private boolean running=false;
	@Override
	public void doJob(){
		if (running==true){
			play.Logger.info("UndoJob  is running=true" );
			return;
		}
		running=true;
		try{
			runjob();
		}
		catch(Exception e)
		{
			running=false;
		}
		finally
		{
			play.Logger.info("UndoJob  is running finally" );
			running=false;
		}
		
	}
	
	private void runjob(){
		List<String> list = RedisUtil.getList(RedisDBApp.undo, AppConstant.getValue("app.maccode"));
		play.Logger.info("start  undo record" );
		play.Logger.info("list="+list.size());
		for (String json : list) {
			if(StringUtils.isEmpty(json)){
				continue;
			}
			UndoTransaction undo = UndoTransaction.parseFromString(json);
			undo.incrementCursorTimes();
			try{
				//if(undo.isTouched()){
				play.Logger.info("undo="+undo.ip, "/remote/undo/" + undo.id);
				MethodResult remoteMethodCall = RpcUtil.remoteMethodCall(undo.ip, "/remote/undo/" + undo.id, new HashMap<String, String>());
				if(remoteMethodCall.getResult() != MethodResult.SUCCESS){
					play.Logger.info("undo record=" + undo.id +" MethodResult.fail");
					undo.nextTrigger();
					RedisUtil.rPush(RedisDBApp.undo, AppConstant.getValue("app.maccode"), undo.toJson());
				}else{
					play.Logger.info("undo record=" + undo.id +" MethodResult.SUCCESS");
				}
				//}
			}catch(Exception e){
				play.Logger.info("undo  Exception");
				play.Logger.error(e.toString());
				undo.nextTrigger();
				RedisUtil.rPush(RedisDBApp.undo, AppConstant.getValue("app.maccode"), undo.toJson());
			}
			//一个JOB只处理第一个记录
			play.Logger.info("delect undo record=" + undo.id );
			RedisUtil.delOldList(RedisDBApp.undo,  AppConstant.getValue("app.maccode"), 1);
			//return;
		}
	}
}
