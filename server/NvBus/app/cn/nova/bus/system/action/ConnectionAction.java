package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.common.NvBusVerifyConst;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.persistence.Transient;

import play.mvc.Http.Request;
import play.mvc.Scope.Session;
import cn.nova.bus.system.service.NovaConnectionService;
import cn.nova.bus.system.service.UseVerifyVersionService;
import cn.nova.bus.system.service.impl.NovaConnectionServiceImpl;
import cn.nova.bus.system.service.impl.UseVerifyVersionServiceImpl;

public class ConnectionAction extends BaseAction{
	private String sresult;	
	private String connmsg;
	private String secretKey;
	//private String key = "NOVAKEY";
	private String hostAddress;
	private String hostName;	
	private Date curDatetime;
	
	private String useVerify;//是否启用测试版
	private String nvbusVerifyStarted;//测试版服务是否已启动
	private String nvbusVerifyIp;//站务工程验证版Ip
	private String nvbusVerifyPort;//站务工程验证版端口: port
	
	public String testConnection() {
		SimpleDateFormat  sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");		
		System.out.println("当前时间："+sf.format(new Date()));		
		if(hostAddress!=null){
			System.out.println("NvBus用户的IP："+hostAddress);
		}else
		{
			System.out.println("Web用户的主机："+ Request.current().host);
			System.out.println("Web用户的IP："+ Request.current().remoteAddress);
		}
		if(hostName!=null){
			System.out.println("NvBus用户的主机："+hostName);
		}		
		System.out.println("当前用户的sessionID="+Session.current().getId());
		sresult = "测试WEB服务器连接成功……";
		connmsg = "1";
		System.out.println(sresult);		
		/*if (Key.equals("") && secretKey.equals(Key)) {
			sresult = "测试WEB服务器连接成功……";
			connmsg = "1";
		}else
		{
			System.out.println("connection fail^^^^^^^^");
			sresult = "测试WEB服务器连接不成功！";
			connmsg = "-1";
		}*/
		setCurDatetime(new Date()); 
		//查询测试版相关系统设置
		qryVerifySettingInfos();
		return "json";
	}
	
	/**
	 * 查询系统测试版NvBusVerify配置信息
	 */
	private void qryVerifySettingInfos(){
		UseVerifyVersionService uvvService = new UseVerifyVersionServiceImpl();
		Map<String, String> verifySetting = null;
		try{
			useVerify = NvBusVerifyConst.DEFAULT_USE_VERIFY;//是否启用测试版，默认值为0：不开启
			nvbusVerifyStarted = NvBusVerifyConst.DEFAULT__NVBUS_VERITY_STARTED;//测试版服务是否已启动，默认值为0：不开启
			nvbusVerifyIp = NvBusVerifyConst.NVBUS_VERIFY_APP_IP;//站务工程验证版默认IP
			nvbusVerifyPort = NvBusVerifyConst.NVBUS_VERIFY_APP_PORT;//站务工程验证版默认端口: port
			
			try {
				//查询测试版相关系统设置
				verifySetting = uvvService.qryVerifySettingInfos();
			} catch (Exception e) {
				play.Logger.error("查询系统测试版NvBusVerify配置信息出错: ", e);
			}
			if(verifySetting != null){
				useVerify = verifySetting.get(NvBusVerifyConst.STR_USE_VERIFY);
				nvbusVerifyStarted = verifySetting.get(NvBusVerifyConst.STR_NVBUS_VERITY_STARTED);
				nvbusVerifyIp = verifySetting.get(NvBusVerifyConst.STR_NVBUS_VERIFY_IP);
				nvbusVerifyPort = verifySetting.get(NvBusVerifyConst.STR_NVBUS_VERIFY_PORT);
			}
		} catch (Exception e) {
			play.Logger.error("读取测试版NvBusVerify配置信息出错: ", e);
		}
	}
	
	public String testEJB() {	
		NovaConnectionService connectionService = new NovaConnectionServiceImpl();
		if (connectionService.connectionstatus()){
			sresult = "测试EJB服务器连接成功！";
			System.out.println(sresult);
			connmsg = "1";
		}else{
			sresult = "测试EJB服务器连接失败^^^^^";
			System.out.println(sresult);
			connmsg = "1";
		}
		return "json";
	}
	public String getSresult() {
		return sresult;
	}

	public void setSresult(String sresult) {
		this.sresult = sresult;
	}

	public String getSecretKey() {
		return secretKey;
	}

	@Transient
	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}
	public String getConnmsg() {
		return connmsg;
	}

	public void setConnmsg(String connmsg) {
		this.connmsg = connmsg;
	}

	@Transient
	public String getHostAddress() {
		return hostAddress;
	}

	public void setHostAddress(String hostAddress) {
		this.hostAddress = hostAddress;
	}
	
	@Transient
	public String getHostName() {
		return hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	public void setCurDatetime(Date curDatetime) {
		this.curDatetime = curDatetime;
	}

	public Date getCurDatetime() {
		return curDatetime;
	}

	public String getUseVerify() {
		return useVerify;
	}

	public void setUseVerify(String useVerify) {
		this.useVerify = useVerify;
	}

	public String getNvbusVerifyStarted() {
		return nvbusVerifyStarted;
	}

	public void setNvbusVerifyStarted(String nvbusVerifyStarted) {
		this.nvbusVerifyStarted = nvbusVerifyStarted;
	}

	public String getNvbusVerifyPort() {
		return nvbusVerifyPort;
	}

	public void setNvbusVerifyPort(String nvbusVerifyPort) {
		this.nvbusVerifyPort = nvbusVerifyPort;
	}

	public String getNvbusVerifyIp() {
		return nvbusVerifyIp;
	}

	public void setNvbusVerifyIp(String nvbusVerifyIp) {
		this.nvbusVerifyIp = nvbusVerifyIp;
	}
	
}
