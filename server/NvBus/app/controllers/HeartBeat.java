package controllers;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.UseronlineDao;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Useronline;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.UseronlineService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.system.service.impl.UseronlineServiceImpl;
import models.HeartBeatTime;
import util.CurrentUtil;
import util.JsonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

public class HeartBeat extends BaseController {

	public static boolean addOneSecond(Global global) {
		try {
			String key=global.getUserinfo().getId() + ":" + global.getIpAddress();
			play.Logger.info("---------------HeartBeat.addOneSecond().key="+key);
			String heartBeatjson=RedisUtil.get(RedisDBApp.Lessee,key);
			if(heartBeatjson!=null){
				HeartBeatTime hbt=JsonUtil.parseObject(heartBeatjson,HeartBeatTime.class);
				//刷新心跳包
				hbt.endtime = new Date();
				String hbtjson=JsonUtil.toSimpleString(hbt);
				RedisUtil.set(RedisDBApp.Lessee,key, hbtjson);
				play.Logger.info("----------------HeartBeat.addOneSecond(RedisDBApp.Lessee,"+key+") ---------success------------");					
			}		
			else{
				// 空心跳则创建数据
				HeartBeatTime hbt=new HeartBeatTime(new Date());
				String hbtjson=JsonUtil.toSimpleString(hbt);
				RedisUtil.set(RedisDBApp.Lessee,key, hbtjson);
				reupline(global);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	public static boolean checkHeartBeat(Useronline useronline, Userinfo userinfo) {
		// 获取在线用户的global
		try {
			Global global=CurrentUtil.getGlobal(useronline.getSessionid());
			if(global==null){
				UseronlineDao dao = new UseronlineDao();
				UseronlineService useronlineService = new UseronlineServiceImpl();
				Userinfo user=(Userinfo) dao.get(Userinfo.class,useronline.getUserid());
				useronlineService.logout(userinfo.getId(), null);
			    play.Logger.info("-------用户："+user.getName()+"已不在线，系统自动修改在线状态---success------------");					
				return true;
			}
			// 获取参数0040
			ParameterService parameterService = new ParameterServiceImpl();
			Integer p0040 = 5;
			try {
				p0040 = Integer.parseInt(
						parameterService.findParamValue(ParamterConst.Param_0040, global.getOrganization().getId()));
			} catch (Exception e) {
				p0040 = 5;
				e.printStackTrace();
				play.Logger.info("参数0040值设置有误.请检查!");
				play.Logger.error("参数0040值设置有误.请检查!");
			}
			if(p0040==0){
				return true;
			}
			// 获取心跳
			String key=global.getUserinfo().getId() + ":" + global.getIpAddress();
			String heartBeatjson=RedisUtil.get(RedisDBApp.Lessee,key);
			if(heartBeatjson==null){
				// 如果心跳数据为空,则直接下线操作.
				downline(global, userinfo);
			    play.Logger.info("---HeartBeat.checkHeartBeat(RedisDBApp.Lessee,"+key+")--用户已不在线----downline-----success------------");	
				return true;
			}
			HeartBeatTime hbt=JsonUtil.parseObject(heartBeatjson,HeartBeatTime.class);
			// 如果心跳数据不为空并且 时间超过15s 则下线
			Date now = new Date();
			long diff = now.getTime() - hbt.endtime.getTime();
			long sec = diff / 1000;
			if (sec > p0040 + 10) {
				// 如果超时
				downline(global, userinfo);
				play.Logger.info("----------------HeartBeat.checkHeartBeat(RedisDBApp.Lessee,"+key+")--用户在线超时--downline-----success------------");
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return true;
	}

	private static void downline(Global global, Userinfo userinfo) {
		play.Logger.info("用户ID: " + userinfo.getId() + " ; 姓名:" + userinfo.getName() + " ; 因客户端超时未响应被强制下线.");
		UseronlineService useronlineService = new UseronlineServiceImpl();
		useronlineService.logout(userinfo.getId(), global);
		//只修改在线状态不删除回话
		/*if (global != null) {
			RedisUtil.delete(RedisDBApp.global, global.getSessionID());
		}*/
	}

	private static void reupline(Global global) {
		Userinfo userinfo=global.getUserinfo();
		play.Logger.info("用户ID: " + userinfo.getId() + " ; 姓名:" + userinfo.getName() + " ; 又重新上线了.");
		UseronlineService useronlineService = new UseronlineServiceImpl();
		useronlineService.relogin(userinfo.getId(),global);
	}
}
