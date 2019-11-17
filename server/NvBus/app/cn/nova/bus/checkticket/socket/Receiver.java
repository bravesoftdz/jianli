package cn.nova.bus.checkticket.socket;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;

public class Receiver extends Thread {

	private boolean isStart=true;
	private ServerSocket rServer = null; //  ServerSocket的实例
	
	public Receiver(ServerSocket server) {
		rServer=server;
	}

	@Override
	public void run() {
		while (isStart) {
			try {
				if(rServer==null){
					break;
				}
				if (rServer.isClosed()) {
					isStart=false;
					break;
				}
				Socket client = rServer.accept();
				if (client != null) {
					String remoteSocketAddress = client
							.getRemoteSocketAddress().toString();
					int start = remoteSocketAddress.indexOf("/") + 1;
					int end = remoteSocketAddress.indexOf(":");
					MsgHelper.logger("#CLIENT端为:"
							+ remoteSocketAddress.substring(start, end)
							+ "连接成功……");
					new CommandReceiver(client).start();
				}
			} catch (SocketException e) {
				// play.Logger.error(e.getMessage(), e);
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}
}
