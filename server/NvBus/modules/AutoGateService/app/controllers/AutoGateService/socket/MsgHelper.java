package controllers.AutoGateService.socket;

import controllers.AutoGateService.socket.MessageProcessor;

import java.io.PrintWriter;


public class MsgHelper {
	
	public static String SplitCmdstr="|";
	
	public static int ListenPort;
	
    //当前检票站点ID
	public static long CheckStationid;
	 
	public static long Checkby;

	public static String Key;//用于加密
	
	/**
	 * 向客户端回复信息
	 * 
	 * @param streamWriter`
	 *            PrintWriter
	 * @param message
	 *            String
	 * @return boolean
	 */
	public static void sendMsg(final PrintWriter streamWriter,
			final String message) {
		try {
			 streamWriter.println(message);
			// 安徽邮政要求不加回车符
			//streamWriter.print(message);
			streamWriter.flush();
		} catch (Exception ex) {
			logger(ex.toString());
		}
	}
	public static void logger(String msg) {
		System.out.println(msg);
	}
	public static Message handlerMsg(String str) {
		MessageProcessor msgp = new MessageProcessor(SplitCmdstr);
		return msgp.analyzeMsg(str);
	}
}
