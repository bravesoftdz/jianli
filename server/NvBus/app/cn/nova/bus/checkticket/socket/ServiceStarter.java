package cn.nova.bus.checkticket.socket;

import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.util.Properties;

import play.jobs.Job;
import play.jobs.OnApplicationStart;
import play.mvc.After;


//@OnApplicationStart
public class ServiceStarter extends Job{
	private static final String SPROPERTY_FILE_NAME = "SocketService.properties";
	private InputStream roperties_file = null;
	private ServerSocket rServer = null; // ServerSocket的实例

	//@PostConstruct
	public void doJob() {

		MsgHelper.logger("ServiceStarter 准备启动。");
		roperties_file = getClass().getClassLoader().getResourceAsStream(
				SPROPERTY_FILE_NAME);
		if (roperties_file == null) {
			MsgHelper.logger("未找到配置文件：" + SPROPERTY_FILE_NAME + "，初始化失败。");
		} else {
			Properties props = new Properties();
			try {
				props.load(roperties_file);
				if (props.getProperty("IsStart").equals("1")) {
					MsgHelper.ListenPort = new Integer(
							props.getProperty("ListenPort"));
					MsgHelper.SplitCmdstr = props.getProperty("SplitCmdstr");
					MsgHelper.CheckStationid = new Long(
							props.getProperty("CheckStationid"));
					MsgHelper.Checkby = new Long(props.getProperty("Checkby"));
					MsgHelper.Key = new String(props.getProperty("Key")==null ? "bus36501" : props.getProperty("Key"));
					createServer(MsgHelper.ListenPort);
					new Receiver(rServer).start();
				}else{
					MsgHelper.logger("自助检票服务未启动");
				}
				roperties_file.close();
				roperties_file = null;
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
			}
		}

	}

	
	public void atShutdown() {
		MsgHelper.logger("ServiceStarter 准备关闭。");
		stopServer();
	}

	// 创建监听
	public void createServer(int port) {
		try {
			rServer = new ServerSocket(port);
			// sockets = new HashMap<ChatClient, Integer>();
			// runinfo.setStarted(true);
			// runinfo.setServersocket(rServer);
			MsgHelper.logger("#服务器启动成功");
		} catch (IllegalArgumentException e) {
			MsgHelper.logger("#服务器启动失败");
		} catch (IOException e) {
			MsgHelper.logger("#服务器启动失败");
			play.Logger.error(e.getMessage(), e);
		}
	}

	// 关闭服务
	public void stopServer() {
		try {
			if (rServer != null) {
				// runinfo.setStarted(false);
				rServer.close();
				System.out.println("#成功关闭服务器");
			}
		} catch (Exception e) {
			System.out.println("#服务器关闭失败");
			play.Logger.error(e.getMessage(), e);
		}
	}
}
