package controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;

import cn.nova.bus.util.FileNameSelector;

import models.AccessLog;
import models.TestParams;
import play.Play;
import play.db.jpa.JPA;
import play.modules.redis.RedisConnectionManager;
import play.mvc.Http.Request;
import util.AppConstant;
import util.Appvar;
import util.CommonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

public class AppStatus extends BaseController {
	public static void status(){
		String appIp="";
		try {
			InetAddress addr = InetAddress.getLocalHost();
			appIp=addr.getHostAddress();
		} catch (UnknownHostException e) {
			play.Logger.error(e.getMessage(), e);
		}
		
		String javaVersion = System.getProperty("java.version");
		String osName = System.getProperty("os.name");
		String appRoute = System.getProperty("user.dir");
		
		boolean jpaEnabled = JPA.isEnabled();
		
		String appName = Play.configuration.getProperty("application.name");
		String macCode = AppConstant.getValue("app.maccode");
		String dbUrl = Play.configuration.getProperty("db.url");
		String redisUrl = Play.configuration.getProperty("redis.url");
		boolean rdEnabled = !RedisConnectionManager.isSharded();
		
		boolean switchIsOk = (Appvar.routes != null);
		String  beginDate= CommonUtil.dateToFullString(Appvar.beginDate);
		render("status.html",javaVersion,osName,appRoute,jpaEnabled,dbUrl,
				redisUrl,rdEnabled,switchIsOk,appIp,beginDate,appName,macCode);
	}
	
	public static void getAppStatus(){
		String appIp="";
		try {
			InetAddress addr = InetAddress.getLocalHost();
			appIp=addr.getHostAddress();
		} catch (UnknownHostException e) {
			play.Logger.error(e.getMessage(), e);
		}
		
		String javaVersion = System.getProperty("java.version");
		String osName = System.getProperty("os.name");
		String appRoute = System.getProperty("user.dir");
		
		boolean jpaEnabled = JPA.isEnabled();
		
		String appName = Play.configuration.getProperty("application.name");
		String macCode = AppConstant.getValue("app.maccode");
		String dbUrl = Play.configuration.getProperty("db.url");
		String redisUrl = Play.configuration.getProperty("redis.url");
		boolean rdEnabled = !RedisConnectionManager.isSharded();
		
		boolean switchIsOk = (Appvar.routes != null);
		String  beginDate= CommonUtil.dateToFullString(Appvar.beginDate);
		
		
		HashMap map = new HashMap();
		map.put("javaVersion", javaVersion);
		map.put("osName", osName);
		map.put("appRoute", appRoute);
		map.put("jpaEnabled", jpaEnabled);
		map.put("dbUrl", dbUrl);
		map.put("redisUrl", redisUrl);
		map.put("rdEnabled", rdEnabled);
		map.put("switchIsOk", switchIsOk);
		map.put("appIp", appIp);
		map.put("beginDate", beginDate);
		map.put("appName", appName);
		map.put("macCode", macCode);
		
		renderJSON(map);
	}
	
	public static void testDB(){
		try{
			AccessLog.findById(1L);
		}catch(Exception e){
			renderText("连接异常：" + e.getMessage());
		}
		renderText("连接正常。");
	}
	
	public static void testRedis(){
		try{
			RedisUtil.ChangeDB(RedisDBApp.global);
		}catch(Exception e){
			renderText("连接异常：" + e.getMessage());
		}
		renderText("连接正常。");
	}
	
	public static void findTestParams(){
		TestParams testparams = TestParams.getNewest();
		String macCode = AppConstant.getValue("app.maccode");
		render("testparams.html", testparams,macCode);
	}
	
	public static void saveTestParams(TestParams testparams,int closeall){
		if (closeall == 1){
			testparams = new TestParams();
		}
		testparams.save();
		String macCode = AppConstant.getValue("app.maccode");
		render("testparams.html", testparams,macCode);
	}
	//更新系统所有BPL文件日期
	public static void bpl() {
		try {
			StringBuilder tempSb = new StringBuilder();
			String remoteIP = Request.current().remoteAddress;
			System.out.println(remoteIP + " startup update file date^^^^^^^^^^^^^");
			File rootFile = new File(Play.applicationPath, "/public/download");
			walk(rootFile, "bpl", tempSb);
			renderText("更新+"+tempSb.toString()+"包文件成功");
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
	}
	//更新系统所有关键包文件日期
	public static void pk() {
		try {
			StringBuilder tempSb = new StringBuilder();
			String remoteIP = Request.current().remoteAddress;
			System.out.println(remoteIP + " startup update file date^^^^^^^^^^^^^");
			File rootFile = new File(Play.applicationPath, "/public/download");
			walkpk(rootFile,tempSb);
			renderText("更新"+tempSb+"文件成功");
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
	}
	//更新系统所有EXE文件日期
	public static void exe() {
		try {
			StringBuilder tempSb = new StringBuilder();
			String remoteIP = Request.current().remoteAddress;
			System.out.println(remoteIP + " startup update file date^^^^^^^^^^^^^");
			File rootFile = new File(Play.applicationPath, "/public/download");
			walk(rootFile, "exe", tempSb);
			renderText("更新"+tempSb+"文件成功");
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
	}
	//更新系统所有ini文件日期
	public static void ini() {
		try {
			StringBuilder tempSb = new StringBuilder();
			String remoteIP = Request.current().remoteAddress;
			System.out.println(remoteIP + " startup update file date^^^^^^^^^^^^^");
			File rootFile = new File(Play.applicationPath, "/public/download");
			walk(rootFile, "ini", tempSb);
			walk(rootFile, "txt", tempSb);
			renderText("更新"+tempSb+"文件成功");
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
	}
	//变量所有文件更新其更新日期
	private static void walk(File rootFile,String prefix,StringBuilder tempSb){
		File[] bplFiles = null;
	    bplFiles = rootFile.listFiles();		
		for (File file : bplFiles) {
			if(file.isDirectory() && prefix.indexOf("svn")<=0  && file.getName().indexOf("svn")<=0 &&tempSb.indexOf("dll")<=0){
				walk(file, prefix + file.getName() + "/", tempSb);
			}else if(file.canRead()){
				// 下载所有文件，包括系统包
				if(tempSb.indexOf("svn")<=0 && file.getName().indexOf("svn")<=0 
						&&file.getName().indexOf("dll")<=0
						&&file.getName().indexOf("rar")<=0
						&&file.getName().indexOf("vcl")<=0
						&&file.getName().indexOf("0")<=0
						&&file.getName().indexOf("1")<=0
						&&!file.getName().equalsIgnoreCase("NovaJsonRpc.bpl")
						&&!file.getName().equalsIgnoreCase("NvBUS.exe")
						&&!file.getName().equalsIgnoreCase("login.bpl")
						&&!file.getName().equalsIgnoreCase("Interfaces.bpl")
						&&!file.getName().equalsIgnoreCase("ConnectCFG.bpl")
						&&!file.getName().equalsIgnoreCase("Updatefile.bpl")
						&&!file.getName().equalsIgnoreCase("Log.bpl")							
						&&file.getName().indexOf(prefix)>0){
					tempSb.append(file.getName()+",");
					System.out.println(prefix+" file.getName()="+ file.getName());
					try {
						file.createNewFile();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					Date filetime = new Date(file.lastModified());
					System.out.println(file.toString());
					System.out.println(file.setLastModified(System
							.currentTimeMillis()));
					filetime = new Date(file.lastModified());
					System.out.println(filetime.toString());
				}
			}
		}
	}
	//只判断是否是关键包文件
	private static void walkpk(File rootFile,StringBuilder tempSb){
		File[] bplFiles = null;
	    bplFiles = rootFile.listFiles();		
		for (File file : bplFiles) {
			 if(file.canRead()){
				if(file.getName().equalsIgnoreCase("NovaJsonRpc.bpl")
				//||file.getName().equalsIgnoreCase("NvBUS.exe")
				||file.getName().equalsIgnoreCase("login.bpl")
				||file.getName().equalsIgnoreCase("Interfaces.bpl")
				||file.getName().equalsIgnoreCase("ConnectCFG.bpl")
				||file.getName().equalsIgnoreCase("Updatefile.bpl")
				||file.getName().equalsIgnoreCase("Log.bpl")){
					tempSb.append(file.getName()+",");
					System.out.println("pk file.getName()="+ file.getName());
					try {
						file.createNewFile();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					Date filetime = new Date(file.lastModified());
					System.out.println(file.toString());
					System.out.println(file.setLastModified(System
							.currentTimeMillis()));
					filetime = new Date(file.lastModified());
					System.out.println(filetime.toString());
				}							
			}
		}
	}
}
