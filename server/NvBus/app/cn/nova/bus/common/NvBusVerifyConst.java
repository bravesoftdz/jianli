package cn.nova.bus.common;

import java.util.ResourceBundle;

/**
 * 站务工程验证版常量类
 */
public class NvBusVerifyConst {
	static{
		final long defaultVerifyOrgid = 0L;//测试版服务对应的机构id，用于查询0091参数
		final String defaultVerifyAppName = "NvBusVerify";//验证版默认工程名
		final String defaultVerifyAppIp = "127.0.0.1";//验证版默认IP
		final String defaultVerifyAppPort = "19000";//验证版默认端口
		
		ResourceBundle rb = ResourceBundle.getBundle("verify");
		if(rb != null){
			//测试版服务对应的机构id，用于查询0091参数
			String virifyOrgid = rb.getString("nvbus_verify_orgid");
			if(virifyOrgid != null){
				NVBUS_VERIFY_ORGID = Long.parseLong(virifyOrgid.trim());
			}else{
				NVBUS_VERIFY_ORGID = defaultVerifyOrgid;
			}
			//验证版工程名
			String verifyAppName = rb.getString("nvbus_verify_app_name");
			if(verifyAppName != null){
			 NVBUS_VERIFY_APP_NAME = verifyAppName.trim();
			}else{
			 NVBUS_VERIFY_APP_NAME = defaultVerifyAppName;
			}
			//验证版IP
			String verifyAppIp = rb.getString("nvbus_verify_app_ip");
			if(verifyAppIp != null){
			 NVBUS_VERIFY_APP_IP = verifyAppIp.trim();
			}else{
			 NVBUS_VERIFY_APP_IP = defaultVerifyAppIp.trim();
			}
			//验证版端口
			String verifyAppPort = rb.getString("nvbus_verify_app_port");
			if(verifyAppPort != null){
			 NVBUS_VERIFY_APP_PORT = verifyAppPort.trim();
			}else{
			 NVBUS_VERIFY_APP_PORT = defaultVerifyAppPort.trim();
			}
		}else{
			NVBUS_VERIFY_ORGID = defaultVerifyOrgid;
			NVBUS_VERIFY_APP_NAME = defaultVerifyAppName;
			NVBUS_VERIFY_APP_IP = defaultVerifyAppIp;
			NVBUS_VERIFY_APP_PORT = defaultVerifyAppPort;
		}
	}
	
	
	/**************************↓↓↓↓ 以下是测试版工程名称、URL、端口等配置信息  ↓↓↓↓**************************/
	
	/**
	 * 该NvBus测试版服务对应的机构id，用于获取参数0091对应的参数明细表的值
	 */
	public static final long NVBUS_VERIFY_ORGID;
	
	/**
	 * 站务工程验证版工程名: NvBusVerify
	 */
	public static final String NVBUS_VERIFY_APP_NAME;
	
	/**
	 * 站务工程验证版IP: 默认测试版与正式版在同一台服务器 
	 */
	public static final String NVBUS_VERIFY_APP_IP;
	
	/**
	 * 站务工程验证版端口: port
	 */
	public static final String NVBUS_VERIFY_APP_PORT;
	
	
	/**
	 * 站务工程验证版默认URL: port，测试版与正式版在同一台服务器
	 */
	public static final String NVBUS_VERIFY_APP_URL = NVBUS_VERIFY_APP_IP + ":" + NVBUS_VERIFY_APP_PORT;
	
	/**
	 * 站务工程正式版默认端口: port
	 */
	public static final String NVBUS_BETA_APP_PORT = "9000";
	
	/**************************↑↑↑↑ 以上是测试版工程名称、URL、端口等配置信息  ↑↑↑↑**************************/
	
	
	
	/**********************************↓↓↓↓ 以下是一些字符串标识常量  ↓↓↓↓**********************************/
	
	/**
	 * 标识符: 站务工程验证版IP
	 */
	public static final String STR_NVBUS_VERIFY_IP = "NvBusVerifyIp";
	
	/**
	 * 标识符: 站务工程验证版Port
	 */
	public static final String STR_NVBUS_VERIFY_PORT = "NvBusVerifyPort";
	
	/**
	 * 标识符: 站务工程验证版URL
	 */
	public static final String STR_NVBUS_VERIFY_URL = "NvBusVerifyUrl";
	
	/**
	 * 默认值: 是否强制使用测试版默认值
	 */
	public static final String DEFAULT_MUST_USE_VERIFY = "1";
	
	/**
	 * 标识符: 是否启用测试版
	 */
	public static final String STR_USE_VERIFY = "useVerify";
	
	/**
	 * 默认值: 是否启用测试版默认值
	 */
	public static final String DEFAULT_USE_VERIFY = "1";
	
	/**
	 * 标识符: 测试版服务是否已启动
	 */
	public static final String STR_NVBUS_VERITY_STARTED = "nvbusVerifyStarted";
	
	/**
	 * 默认值: 测试版服务是否已启动默认值
	 */
	public static final String DEFAULT__NVBUS_VERITY_STARTED = "0";
	
	/**********************************↑↑↑↑ 以上是一些字符串标识常量  ↑↑↑↑**********************************/
	
}
