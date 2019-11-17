package cn.nova.bus.checkticket.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Date;

import util.TransactionUtil;

public class CommandReceiver extends Thread {
	private Socket clientRequest; //  用户连接的通信套接字
	private BufferedReader input; // 输入流
	private PrintWriter output; // 输出流
	private InputStreamReader reader;
	private OutputStreamWriter writer;

	public CommandReceiver(Socket client) {
		this.clientRequest = client; // 接收receiveServer传来的套接字
		try {
			reader = new InputStreamReader(clientRequest.getInputStream(),
					"GB18030");
			writer = new OutputStreamWriter(clientRequest.getOutputStream(),
					"GB18030");
			input = new BufferedReader(reader);
			output = new PrintWriter(writer, true);

		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}

	public void run() { // 线程的执行方法
		String str = null;
		boolean done = false;
		StringBuilder sb = new StringBuilder();

		while (!done) {
			try {
				// str = input.readLine(); // 接收客户机指令
				// char a = (char) input.read();
				int b = input.read();
				if (b == -1) {
					break;
				}
				char a = (char) b;
				sb.append(a);
				if (sb.indexOf("END") < 0) {
					continue;
				}
				str = sb.toString();
			} catch (IOException e) {
				System.out.println(e.getMessage());
				break;
			}

			MsgHelper.logger("接收到报文:="+str);
			play.Logger.info("接收到报文:="+str);
			Message msg = MsgHelper.handlerMsg(str);
			if (!msg.getErrcode().equals("0")) {
				MsgHelper.logger(msg.getErrmsg());
				MsgHelper.sendMsg(output, msg.getSendmsg());
				break;
			} else {
				// connectUserInfo.setMsg(msg);
				// runInfo.incConnects();
				// 从这里开始处理用户信息;
				CheckTicket ct = new CheckTicket(output, msg);
				ct.checkticket();
				// runInfo.descendingConnects();
				// 完成操作后回复给客户端
			}
			str = "";
			sb = new StringBuilder();
		}// end of while

		try {
			clientRequest.close(); // 关闭套接字
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}// end of run

}
