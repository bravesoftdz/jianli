package cn.nova.bus.system.service.impl;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import play.Play;
import util.RpcUtil;
import cn.nova.bus.common.NvBusVerifyConst;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.UseVerifyVersionService;

public class UseVerifyVersionServiceImpl implements UseVerifyVersionService{

	/**
	 * 查询是否启用测试版：返回xml格式
	 */
	@Override
	public String qryVerifyInfos(){
		play.Logger.info("verify app=" + NvBusVerifyConst.NVBUS_VERIFY_APP_NAME + ", port=" + NvBusVerifyConst.NVBUS_VERIFY_APP_PORT);

		//获取0091参数
		ParameterService paramService = new ParameterServiceImpl();
		String useVerify = paramService.findParamValue(ParamterConst.Param_0091, NvBusVerifyConst.NVBUS_VERIFY_ORGID);//是否使用测试版: 0不使用，1使用
		if(useVerify == null){
			useVerify = ParamterConst.COMMON_FLAG.FALG_NO;
		}
		
		//获取测试版工程服务器ip
		String betaIp = getBetaServerIP();//获取NvBus正式版服务器IP
		String verifyIp = NvBusVerifyConst.NVBUS_VERIFY_APP_IP;//NvBus测试版服务器IP
		if("127.0.0.1".equals(verifyIp.trim())){
			verifyIp = betaIp;//若测试版ip为127.0.0.1，则取正式版服务Ip
		}
		
		//查询测试版工程是否已启动
		String nvbusVerifyStarted = ParamterConst.COMMON_FLAG.FALG_NO;
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(useVerify)){
			nvbusVerifyStarted = testConnNvBusVerify(verifyIp, NvBusVerifyConst.NVBUS_VERIFY_APP_PORT);//启用测试版，则先确认NvBusVerify是否正常启动
		}
		
		//返回信息
		String betaPort = Play.configuration.getProperty("http.port", NvBusVerifyConst.NVBUS_BETA_APP_PORT);
		StringBuffer info = new StringBuffer();
		info.append("<filelist>");
		info.append(" <file name='useVerify' ");
		info.append("   useVerify='").append(useVerify).append("'");
		info.append("   betaIp='").append(betaIp).append("'");
		info.append("   betaPort='").append(betaPort).append("'");
		info.append("   verifyIp='").append(verifyIp).append("'");
		info.append("   verifyPort='").append(NvBusVerifyConst.NVBUS_VERIFY_APP_PORT).append("'");
		info.append("   nvbusVerifyStarted='").append(nvbusVerifyStarted).append("'");
		info.append(" #>");
		info.append("<#filelist>");
		play.Logger.info("是否启用测试版本参数值=" + useVerify);
		
		return info.toString();
	}
	
	/**
	 * 查询系统测试版NvBusVerify配置信息，返回Map格式
	 */
	@Override
	public Map<String, String> qryVerifySettingInfos(){
		Map<String, String> verifyMap = new HashMap<String, String>();
		
		//获取0091参数
		ParameterService paramService = new ParameterServiceImpl();
		String useVerify = paramService.findParamValue(ParamterConst.Param_0091, NvBusVerifyConst.NVBUS_VERIFY_ORGID);//是否使用测试版: 0不使用，1使用
		if(useVerify == null){
			useVerify = ParamterConst.COMMON_FLAG.FALG_NO;
		}
		
		//获取测试版工程服务器ip
		String verifyIp = NvBusVerifyConst.NVBUS_VERIFY_APP_IP;//NvBus测试版服务器IP
		if("127.0.0.1".equals(verifyIp.trim())){
			verifyIp = getBetaServerIP();//若测试版ip为127.0.0.1，则取正式版服务Ip
		}
		
		//查询测试版工程是否已启动
		String nvbusVerifyStarted = ParamterConst.COMMON_FLAG.FALG_NO;
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(useVerify)){
			nvbusVerifyStarted = testConnNvBusVerify(verifyIp, NvBusVerifyConst.NVBUS_VERIFY_APP_PORT);//启用测试版，则先确认NvBusVerify是否正常启动
		}
		
		verifyMap.put(NvBusVerifyConst.STR_USE_VERIFY, useVerify);//0091参数，是否启用测试版
		verifyMap.put(NvBusVerifyConst.STR_NVBUS_VERITY_STARTED, nvbusVerifyStarted);//测试版工程是否启动
		verifyMap.put(NvBusVerifyConst.STR_NVBUS_VERIFY_IP, verifyIp);//测试版工程IP
		verifyMap.put(NvBusVerifyConst.STR_NVBUS_VERIFY_PORT, NvBusVerifyConst.NVBUS_VERIFY_APP_PORT);//测试版工程端口
		return verifyMap;
	}
	
	/**
	 * 获取本服务在服务器IP
	 * @return
	 */
	private String getBetaServerIP() {
		String ip = "";
		try {
			InetAddress addr = InetAddress.getLocalHost();
			ip = addr.getHostAddress().toString(); // 获取本机ip
		} catch (UnknownHostException e) {
			play.Logger.error("获取本机IP出错", e);
		}

		return ip;
	}
	
	/**
	 *测试连接 NvBusVerify测试版工程，确认该工程是否已正常启动
	 */
	private String testConnNvBusVerify(String verifyIp, String verifyPort){
		String nvbusVerifyStarted = ParamterConst.COMMON_FLAG.FALG_NO;//测试版工程是否已启动，默认为0未启动
		Map<String, String> requestMap = new HashMap<String, String>();
		try {
			String remote = RpcUtil.remoteCallGet(verifyIp + ":" + verifyPort, requestMap);
			if(remote != null && !"".equals(remote)){
				nvbusVerifyStarted = ParamterConst.COMMON_FLAG.FALG_YES;//测试连接NvBusVerify存在返回信息，认为工程已正常启动
			}
		} catch (Exception e) {
			nvbusVerifyStarted = ParamterConst.COMMON_FLAG.FALG_NO;//测试连接NvBusVerify返回失败，认为工程未正常启动
			play.Logger.error("测试连接NvBusVerify工程失败，该工程未正常启动！", e);
		}
		
		return nvbusVerifyStarted;
	}
	
}
