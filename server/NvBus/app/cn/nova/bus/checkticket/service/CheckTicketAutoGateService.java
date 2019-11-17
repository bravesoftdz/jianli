package cn.nova.bus.checkticket.service;

import cn.nova.bus.checkticket.socket.Message;
import cn.nova.bus.exception.BusinessException;

/**
 * 闸机检票
 * 
 * @author zhaohuaihu
 * @date 2017年9月12日
 * @describe 将闸机检票相关代码，从CheckticketService中独立出来
 */
public interface CheckTicketAutoGateService {
	
	/**
	 * 闸机检票方法：
	 * 			旧报文：	0主机IP|1主机端口|2闸机设备号|3验票设备|4车票号码|END	
	 * 			新报文：	0主机IP|1主机端口|2闸机设备号|3验票设备|4检票条件1|5检票条件2|6检票条件3|7校验值|END
	 * 			返回报文：SU|班次|票种|座位号|闸机设备号|通过人数|备用|END
	 * @param msg
	 * @return
	 * @throws BusinessException
	 */
	Message checkByticketno(Message msg) throws BusinessException;
}
