package cn.nova.bus.checkticket.socket;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.checkticket.dao.CheckticketDao;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import util.DESUtil;
import util.NewDESUtil;


public class MessageProcessor  {

	// 指令拆分符
	private String splitCmdstr;
	// 头标识
	private String heardstr;

	private String cmdstr;

	private List<String> dataList = new ArrayList<String>();
	
//	private static final String encrykey = "bus36501";

	private ParameterService parameterService = new ParameterServiceImpl();
	private CheckticketDao checkticketDao = new CheckticketDao();

	public MessageProcessor() {

	}

	public MessageProcessor(String splitCmdstr) {
		if (splitCmdstr == null || "".equals(splitCmdstr)) {
			this.splitCmdstr = ";";
		} else {
			this.splitCmdstr = splitCmdstr;
		}
	}


	public String getCmdIdx(int idx) {
		return dataList.size() >= idx ? dataList.get(idx) : "";
	}


	public String getCmd() {
		return dataList.size() > 0 ? getCmdIdx(1) : "";
	}


	public boolean checkHeard() {
		return getCmdIdx(0).equals(heardstr);
	}


	public String DeCrypt(String pwd) {
		char ff[] = pwd.toCharArray();
		byte by = '0';
		for (int i = 0; i < pwd.length(); i++) {
			by = (byte) ff[i];
			ff[i] = (char) ((by ^ 12));
			if (ff[i] == 0) {
				ff[i] = '9';
			}
		}
		return String.copyValueOf(ff);
	}


	public String StrtoFF(String pwd) {
		try {
			char ff[] = pwd.toCharArray();
			byte by = '0';
			String result = "";
			for (int i = 0; i < (pwd.length()); i++) {
				by = (byte) ff[i];
				result = result + Integer.toHexString(by).toUpperCase();
			}
			return result;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return pwd;
		}
	}

	private byte uniteBytes(byte src0, byte src1) {
		byte _b0 = Byte.decode("0x" + new String(new byte[] { src0 }))
				.byteValue();
		_b0 = (byte) (_b0 << 4);
		byte _b1 = Byte.decode("0x" + new String(new byte[] { src1 }))
				.byteValue();
		byte ret = (byte) (_b0 ^ _b1);
		return ret;
	}


	public String FFtoStr(String pwd) {
		try {
			// char charpwd[] = pwd.toCharArray();
			byte ps;
			String result = "";
			// String ch = "";
			for (int i = 0; i < (pwd.length() / 2); i++) {
				ps = uniteBytes(pwd.substring(i * 2, i * 2 + 1).getBytes()[0],
						pwd.substring(i * 2 + 1, i * 2 + 2).getBytes()[0]);
				result = result + (char) ps;
			}
			return result;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return pwd;
		}
	}

	//主机IP|主机端口|闸机设备号|验票设备|车票号码|END	
	//新的修改为:主机IP|主机端口|闸机设备号|验票设备|检票条件1|检票条件2|检票条件3|校验值|END
	public Message analyzeMsg(String msgstr) {
		Message msg = new Message();
		msg.setErrcode("0");
		msg.setErrmsg("检票成功");
		if (msgstr == null || msgstr.length() == 0) {
			msg.setErrcode("7");
			msg.setErrmsg("传入格式错误");
			return msg;
		}
		if (msgstr.indexOf(splitCmdstr) == 0) {
			msg.setErrcode("7");
			msg.setErrmsg("传入格式错误");
			return msg;
		}
		//msgstr.replaceAll(splitCmdstr, ";");
		//主机IP|主机端口|闸机设备号|验票设备|车票号码|END	
		//新的修改为:主机IP|主机端口|闸机设备号|验票设备|检票条件1|检票条件2|检票条件3|校验值|END
		String[] ss = msgstr.split("\\|");
		// 至少有14个;
		if (ss.length < 6) {
			msg.setErrcode("7");
			msg.setErrmsg("传入格式错误");
			return msg;
		}
		if (!ss[5].equals("END") && !ss[8].equals("END")) {
			msg.setErrcode("7");
			msg.setErrmsg("传入格式错误");
			return msg;
		}

		Organization org = checkticketDao.getOrganization(MsgHelper.CheckStationid);//供查参数等使用
		//闸机报文格式 ,0新老格式都支持,1只支持新格式,2只支持老格式
		String flag = parameterService.findParamValue(ParamterConst.Param_3070, org.getId());

		// 主机IP|主机端口|闸机设备号|验票设备|车票号码|END		
		// SU|班次|票种|座位号|闸机设备号|通过人数|备用|END
		if("END".equals(ss[5])){
			if("1".equals(flag)){
				msg.setErrcode("7");
				msg.setErrmsg("格式错误");
				play.Logger.error("传入格式错误，3070参数为："+flag);
				return msg;	
			}
			msg.setIp(ss[0]);
			//TODO JJKYZ将Gatesno当作检票口判断，升级时要检查
			//TODO YCDZ将Equipment当作检票口判断，升级时要检查
			//msg.setGatesno(ss[3]);
			//msg.setEquipment(ss[2]);
			msg.setTicketno(ss[4]);
			msg.setEquipment("0");//旧报文只支持车票检票

			if(org.getCode().equals("JJKYZ")){//九江客运的
				msg.setGatesno(ss[3]);
			}else if(org.getCode().equals("YCDZ")){
				msg.setGatesno(ss[2]);
			}else{
				msg.setGatesno(ss[3]);
			}

		}else if("END".equals(ss[8])){
			if("2".equals(flag)){
				msg.setErrcode("7");
				msg.setErrmsg("格式错误");
				play.Logger.error("传入格式错误，3070参数为："+flag);
				return msg;
			}
			
			//新的修改为:主机IP|主机端口|闸机设备号|验票设备|检票条件1|检票条件2|检票条件3|校验值|END
			msg.setIp(ss[0]);
			msg.setGatesno(ss[2]);
			if("0".equals(ss[3])){
				//条码
				msg.setEquipment("0");
				msg.setTicketno(ss[4]);
			}else if("1".equals(ss[3])){
				msg.setEquipment("1");
				msg.setCertificateno(ss[4]);
			}else if("2".equals(ss[3])){
				msg.setEquipment("2");
				msg.setTicketno(ss[4]);
			}
			//HEXSTR(DES(主机IP+主机端口+闸机设备号+验票设备+检票条件1+检票条件2+检票条件3)) 即先用DES加密然后转成16进制字符串
			String datasourcestr = ss[0].toString()+ss[1].toString()+ss[2].toString()+ss[3].toString()+ss[4].toString()+ss[5].toString()+ss[6].toString();

			if((!"bus365".equals(ss[7]))){
				String transencrypstr = null;
				try {
					transencrypstr = DESUtil.generateEncrypt(datasourcestr, MsgHelper.Key);
				} catch (Exception e) {
					e.printStackTrace();
					play.Logger.error("加密错误"+e.getMessage());
				}
				if(!transencrypstr.equals(ss[7])){
					String new_transencrypstr = null;
					try {
						new_transencrypstr = NewDESUtil.generateEncrypt(datasourcestr, MsgHelper.Key);
					}catch(Exception e){
						e.printStackTrace();
						play.Logger.error("加密错误"+e.getMessage());
					}
					if(!new_transencrypstr.equals(ss[7])){
						msg.setErrcode("7");
						msg.setErrmsg("传入格式错误");
						play.Logger.error("传入格式错误"+msgstr);
						play.Logger.error("闸机校验值应为"+transencrypstr);
						return msg;
					}
				}
			}
		}
		msg.setCheckby(MsgHelper.Checkby);
		msg.setCheckstationid(MsgHelper.CheckStationid);
		return msg;
	}


	public String getCmdstr() {
		return cmdstr;
	}

	public void setCmdstr(String cmdstr) {
		this.cmdstr = cmdstr;
	}
}
