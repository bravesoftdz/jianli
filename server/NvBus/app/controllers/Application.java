package controllers;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.Query;

import com.alibaba.fastjson.JSON;

import models.ActionNode;
import models.MenuTree;
import models.Result;
import play.data.binding.Binder;
import play.db.jpa.JPA;
import play.modules.redis.RedisConnectionManager;
import play.mvc.Before;
import play.mvc.Controller;
import play.mvc.Scope;
import play.mvc.Scope.Session;
import util.Appvar;
import util.CurrentUserID;
import util.CurrentUtil;
import util.JsonUtil;
import util.RedisUtil;
import util.TransactionUtil;
import util.RedisUtil.RedisDBApp;
import bp.MenuBP;
import bpinterface.MenuBPInterface;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Functionreg;
import cn.nova.bus.system.model.Menu;
import cn.nova.openapi.NetCentreOa;


public class Application extends BaseController {
	//public static Map<String, ActionNode> routes;
	//public static Date beginDate = new Date();
	
	@Before
	public static void param(){
		//System.out.println("allSimple:"+params.allSimple());
		//System.out.println("param:"+params.allSimple().get("driver.familyaddress"));
	}
	
	/**
	 * 转发play的请求到原sturts2的action层
	 * @param controllername action的类名
	 * @param actionname action的方法名
	  @throws Exception
	 */
	public static void switcher(String controllername, String actionname)
			throws Exception {
		
		String actionUrl = "/" + controllername.toUpperCase() + "/" + actionname.toUpperCase();
		if (heartIntercept(actionUrl)){		
			renderText(""); 
		}
		//登陆拦截
		loginIntercept(actionUrl);

		Long starttime = System.currentTimeMillis(); // 记录开始时间
		ActionNode actionNode = Appvar.routes.get(actionUrl);
		if(actionNode!=null){
			Class controllerClass = Class.forName(actionNode.controller);
			play.Logger.info("actionUrl="+actionUrl);
			System.out.println(new Date()+"actionUrl="+actionUrl);
			play.Logger.info("rebuildParams begin..");
			HashMap<String, String[]> requstMap = rebuildParams();
			play.Logger.info("rebuildParams end..");
			//初始化flag与msg为1
			requstMap.put("action.flag", new String[]{"1"});
			requstMap.put("action.msg", new String[]{"操作成功！"});
			play.Logger.info("Binder.bindInternal begin..");
			//调用play包，反序列化requstMap成对象
	        Object result = Binder.bindInternal("action", controllerClass, controllerClass, new Annotation[]{} , requstMap, "", null);
	        
			play.Logger.info("Binder.bindInternal end..");
	        //反射调用 action类的方法
	        Method methodName = controllerClass.getMethod(actionNode.action,new Class[] {});
//	        try{
	        	methodName.invoke(result, new Object[] {});
//	        }catch(Exception e){
//	        	play.Logger.info(new Date() + " result === " + result);
//	        	play.Logger.info(new Date() + e.getMessage());
//	        }
			play.Logger.info("toString4Action begin..");
			String rdjson = JsonUtil.toString4Action(result);
			play.Logger.info("toString4Action end..");
			Long endtime = System.currentTimeMillis(); // 记录结束时间
			// 请求超过10秒输出日志
			if(((endtime - starttime) / 1000) > 10 ){
				StringBuilder sb = new StringBuilder("[Request overtime");
				sb.append(",ip=").append(request.remoteAddress);
				sb.append(",method=").append(request.url);
				sb.append(",params=").append(JsonUtil.toSimpleString(Scope.Params.current().all())).append("]");
				String logs = sb.toString();
				play.Logger.info(logs);
			}
			renderText(rdjson);
		}else{
			HashMap<String, String[]> requstMap = rebuildParams();
			System.out.println("actionUrl = " + actionUrl);
			play.Logger.info("actionUrl = " + actionUrl);
			//初始化flag与msg为1
			requstMap.put("action.flag", new String[]{"-1"});
			requstMap.put("action.msg", new String[]{"操作成功！"});
			String rdjson = JsonUtil.toString4Action(requstMap);
			play.Logger.info("URL找不到路径为 " + actionUrl);
			renderText(rdjson);
		}
	}
	
	/**
	 * 重构请求参数，在key中加入action.前缀，用来反序列化requstMap成对象
	 * @return
	 */
	/*private static HashMap<String, String[]> rebuildParams() {
		Map<String, String[]> all = Scope.Params.current().all();
		HashMap<String, String[]> requstMap = new HashMap<String, String[]>();
		Iterator<Entry<String, String[]>> it = all.entrySet().iterator();
		while(it.hasNext()){
			Entry<String, String[]> next = it.next();
			requstMap.put("action." + next.getKey(), next.getValue());
		}
		return requstMap;
	}*/
	
	private static HashMap<String, String[]> rebuildParams() {
		//body中可获取到包含=号的Value值,处理包含=号的值
		String paramStr = params.allSimple().get("body");
		Map<String,String> temp = new HashMap<String,String>();
		if(null != paramStr){
			String[] paramArray = paramStr.split("&");
			for(String s : paramArray){
				if(s.contains("=")){
					String key = s.substring(0, s.indexOf("="));
					String value = s.substring(s.indexOf("=")+1, s.length());
					//把前端转移的%还原
					value=value.replaceAll("%25", "%");
					temp.put(key, value);
					//System.out.println(key+"="+value);
				}
			}
		}
		//scope中无法获取包括=号的value值
		Map<String, String[]> all = Scope.Params.current().all();
		HashMap<String, String[]> requstMap = new HashMap<String, String[]>();
		Iterator<Entry<String, String[]>> it = all.entrySet().iterator();
		while (it.hasNext()) {
			Entry<String, String[]> next = it.next();		
			if(null !=next.getValue() && next.getValue().length <=1){
				requstMap.put("action." + next.getKey(),new String[]{temp.get(next.getKey())});
			}
			else{
				requstMap.put("action." + next.getKey(),next.getValue());
			}
		}		
		//System.out.println("temp:"+temp.get("driver.familyaddress"));
		//System.out.println("array:"+Arrays.toString(requstMap.get("action.driver.familyaddress")));
		return requstMap;
	}
	
	public static void index(boolean ismock){    	 
		render("/Application/index.html");
    }

	public static void menu(boolean ismock,long userid){
    	//Logger.info("登录sessionID:"+Session.current().getId());
		MenuBPInterface menubp = new MenuBP();
		MenuTree menutree = null;
		List<Menu> applist = null;
		if(userid>0){
			menutree = menubp.makeTreeByUserid(userid);
			for(int i=0;i<menutree.nodes.size();i++){
				int count = menutree.nodes.get(i).nodes.size();
				for(int j=0;j<menutree.nodes.get(i).nodes.size();j++){
					count = count + menutree.nodes.get(i).nodes.get(j).nodes.size();
				}
				menutree.nodes.get(i).count = count;
			}
			applist = menubp.load(userid);
		}else{
			menutree = menubp.makeTreeByUserid(618619);
			for(int i=0;i<menutree.nodes.size();i++){
				int count = menutree.nodes.get(i).nodes.size();
				for(int j=0;j<menutree.nodes.get(i).nodes.size();j++){
					count = count + menutree.nodes.get(i).nodes.get(j).nodes.size();
				}
				menutree.nodes.get(i).count = count;
			}
			applist = menubp.load(618619);
		}												
		//List<Menu> applist = new ArrayList<Menu>();
		render("/Application/menuTree.html",menutree,applist);    
		//render("/Application/index.html");
    }
	private static void loginIntercept(String actionUrl){
		Global global =null;
		try{
			if("/INSURANCESELL/GETINSURANCEINFO".equals(actionUrl) //呼市保险--》如果在不登录客户端的情况下，保证调用接口成功
					|| "/insurancesell/getinsuranceinfo".equals(actionUrl)){
				return ;
			}
			if(global == null && !"/system/login".equalsIgnoreCase(actionUrl) 
					&& !"/system/testConn".equalsIgnoreCase(actionUrl) 
					&& !"/system/updatefile".equalsIgnoreCase(actionUrl) 
					&& !"/system/checkversion".equalsIgnoreCase(actionUrl)
					&& !"/system/useverifyflag".equalsIgnoreCase(actionUrl)
					&& !"/system/testEJB".equalsIgnoreCase(actionUrl)){
				if(!"/system/login".equalsIgnoreCase(actionUrl) 
						&& !"/system/testConn".equalsIgnoreCase(actionUrl) 
						&& !"/system/updatefile".equalsIgnoreCase(actionUrl) 
						&& !"/system/checkversion".equalsIgnoreCase(actionUrl)
						&& !"/system/useverifyflag".equalsIgnoreCase(actionUrl)
						&& !"/system/testEJB".equalsIgnoreCase(actionUrl)){
						try{
							String sessionId = Session.current().getId();
							play.Logger.info("sessionId="+CurrentUtil.PREFIX+sessionId);
							global=(Global)play.cache.Cache.get(CurrentUtil.PREFIX+sessionId);
							if(global==null){
								play.Logger.info("global==null getGlobal Exception play.cache.Cache.get("+CurrentUtil.PREFIX+sessionId+")");	
							}
							CurrentUtil.setGlobal(global);		
							return ;
						}catch(Exception e){
							response.status = 300;
							play.Logger.info("服务器异常:"+e.getMessage());
							System.out.println("服务器异常:"+e.getMessage());
							renderText("{flag:-300}");
						}
				}
				response.status = 300;
				play.Logger.info("服务器异常:Global对象为空或非法登录!");
				System.out.println("服务器异常:Global对象为空或非法登录!");
				renderText("{flag:-300}");
			}
		}catch(Exception e){
			String sessionId = Session.current().getId();
			play.Logger.info("getGlobal Exception play.cache.Cache.get("+CurrentUtil.PREFIX+sessionId+")");
			play.Logger.info("sessionId="+CurrentUtil.PREFIX+sessionId);
			play.Logger.info("服务器异常:"+e.getMessage());
			System.out.println("服务器异常:"+e.getMessage());
			global=(Global)play.cache.Cache.get(CurrentUtil.PREFIX+sessionId);
			CurrentUtil.setGlobal(global);	
			return ;
		}
		global = CurrentUtil.getGlobal();
		if(global!=null && global.getExpiretime()>0){
			// 刷新超时时间
			RedisUtil.set(RedisDBApp.global, global.getSessionID(),global, global.getExpiretime());
		}
		//非设置超时时间
		if(("/system/heartbeatclient".equalsIgnoreCase(actionUrl)
				&& global!=null && global.getExpiretime()==0)) {
				HeartBeat.addOneSecond(global);
		}
	}

	private static boolean heartIntercept(String actionUrl){
		Global global =null;
		try{
			global = CurrentUtil.getGlobal();			
			//非设置超时时间
			if(global!=null && global.getExpiretime()==0) {
				if("/system/heartbeatclient".equalsIgnoreCase(actionUrl)) {
					HeartBeat.addOneSecond(global);
					return true;
				}
			}		
		}catch(Exception e){
			e.printStackTrace();
			return true;
		}
		return false;
	}
	
	public static void iframeIndex() {
		MenuBPInterface menubp = new MenuBP();
		List<Menu> applist = menubp.load(618619);
		render("/Application/iframeIndex.html",applist);
	}

	public static void getfunctionkey(long id) {
		String sql = "select * from functionreg where id = "+id;
		Query query = JPA.em().createNativeQuery(sql, Functionreg.class);
		List<Functionreg> list = query.getResultList();
		String functionkey = null;
		if(list.size()>0){
			Functionreg fg = list.get(0);
			functionkey = fg.getFunctionkey();
		}
		Result result = new Result();
		result.setSuccess(true);
		result.setMessage(functionkey);
		renderJSON(JSON.toJSONString(result));
	}


	public static void headindex() {
		render("/Application/indexhead.html");
	}

	public static void balanceindex() {
		render("/Application/balance.html");
	}

	public static void ticketsellindex() {
		render("/Application/ticketsell.html");
	}

	public static void ticketindex() {
		render("/Application/ticket.html");
	}

	public static void securityindex() {
		render("/Application/security.html");
	}

	public static void controlindex() {
		render("/Application/control.html");
	}

	public static void ticketcheckindex() {
		render("/Application/ticketcheck.html");
	}
	
	public static void testi(){

	}
}