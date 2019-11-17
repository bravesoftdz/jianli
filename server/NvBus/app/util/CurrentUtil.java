package util;

import java.util.Date;
import java.util.Map;

import models.HeartBeatTime;
import play.mvc.Http;
import play.mvc.Http.Request;
import play.mvc.Scope.Flash;
import play.mvc.Scope.Session;
import util.RedisUtil.RedisDBApp;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;

public class CurrentUtil {
	
	public static final String PREFIX="F_";
	
	public static void delGlobal(Global global){
		play.Logger.info("delGlobal session="+global.getSessionID());
		String key=PREFIX+global.getSessionID();
		play.cache.Cache.delete(key);
		RedisUtil.delete(RedisDBApp.global,key);
	}
	public static Global getGlobal(String sessionId){
//		play.Logger.info("----------------getGlobal----begin---------------------------");	
		String key= PREFIX+ sessionId;		
//		play.Logger.info("----------------key="+key);
		Object obj=play.cache.Cache.get(key);
		if (obj!=null)
			return (Global)obj;
		else{
			Object ob=RedisUtil.get(RedisDBApp.global,key);
			Global g=null;
			if(ob!=null){
				g=JsonUtil.parseObject(ob,Global.class);
//				play.Logger.info("---------------JsonUtil.parseObject---------success------------");				
			}
			return g;
		}		
	}	
	
	public static Global getGlobal(){
		//play.Logger.info("----------------getGlobal-nokey---begin---------------------------");	
		String sessionId =Session.current().get(ConstDefiniens.ZW_SEEESIONKEY);
		//String sessionId = Session.current().getId();
		if(sessionId==null){
			return null;
		}
		String key=PREFIX+ sessionId;
		System.out.println("----------------getGlobal.key="+key);
		Object obj1=play.cache.Cache.get(key);
		if (obj1!=null) {
			String ip=getIpAddr();
			Global g=(Global)obj1;
			if(g.getIpAddress().endsWith(ip)) {
				return g;	
			}else {
				play.Logger.info("play.cache.Cache.get("+key+").getIpAddress()="+g.getIpAddress());
				play.Logger.info("CurrentUtil.getIpAddr()="+ip);
				return null;
			}			
		}
		else{
			Object ob=RedisUtil.get(RedisDBApp.global,key);
			Global g=null;
			if(ob!=null){
				g=JsonUtil.parseObject(ob,Global.class);
				String ip=getIpAddr();
				if(g.getIpAddress().endsWith(ip)) {
					return g;	
				}else {
					play.Logger.info("RedisUtil.get(RedisDBApp.global,"+key+")="+g.getIpAddress());
					play.Logger.info("CurrentUtil.getIpAddr()="+ip);
					return null;
				}					
//				play.Logger.info("----------------RedisUtil.get(RedisDBApp.global,key) ---------success------------");
			}
			return g;			
		}
	}
	
	public static void setGlobal(Global global){
		innersetGlobal(global,0);
	}
	
	private static void innersetGlobal(Global global,int expiretime){
		if(global==null){
//			play.Logger.info("----------setGlobal  global is null");
			return;
		}
		System.out.println("-------global.getSessionID()="+global.getSessionID());
		String key=PREFIX + global.getSessionID();
//		String expt=24*60+"mn";
		//play的cache为24小时
		play.cache.Cache.set(key, global);	
		String globaljson=JsonUtil.toSimpleString(global);
		//经讨论得出 expiretime>0 则给默认过期时间为24小时  小于等于0 过期时间为永久
//		if (expiretime>=0)
//			RedisUtil.set(RedisDBApp.global, key, globaljson,24*60);
//		else
			RedisUtil.set(RedisDBApp.global, key, globaljson);
		String key2=global.getUserinfo().getId() + ":" + global.getIpAddress();
		HeartBeatTime ht= new HeartBeatTime(new Date());
		play.cache.Cache.set(key2,ht);
		String heartjson=JsonUtil.toSimpleString(ht);
		RedisUtil.set(RedisDBApp.Lessee, key2,heartjson);
		
	}
	public static void setGlobal(Global global , int expiretime){
		innersetGlobal(global,expiretime);
	}

	/**
	 * flash scope is just for one request
	 * @param key
	 * @param value
	 */
	public static void setFlash(String key, String value){
		Flash current = Flash.current();
		current.put(key, value);
	}
	/**
	 * flash scope is just for one request
	 * @param key
	 * @param value
	 */
	public static String getFlash(String key){
		Flash current = Flash.current();
		return current.get(key);
	}
	
	public static boolean isOpenApiable(){
		ParameterService psi = new ParameterServiceImpl();
		String isOpenApiable = psi.findParamValue("1998", getGlobal().getUserinfo().getOrgid());
		return "1".equals(isOpenApiable);
	}
	
	public static String getIpAddr() {
		Request request = Request.current();
		Map<String, Http.Header> headerMap = request.headers;
		Http.Header ip = headerMap.get("x-forwarded-for");
		if (ip == null || ip.value().length() == 0 || "unknown".equalsIgnoreCase(ip.name)) {
			ip = headerMap.get("Proxy-Client-IP");
		}
		if (ip == null || ip.value().length() == 0  || "unknown".equalsIgnoreCase(ip.name)) {
			ip = headerMap.get("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.value().length() == 0  || "unknown".equalsIgnoreCase(ip.name)) {
			return request.remoteAddress;
		}
		return ip.name;
	}
}
