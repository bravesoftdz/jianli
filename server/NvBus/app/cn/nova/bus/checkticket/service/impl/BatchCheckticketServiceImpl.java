package cn.nova.bus.checkticket.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import util.UserTransaction;

import cn.nova.bus.checkticket.dao.CheckticketDao;
import cn.nova.bus.checkticket.service.BatchCheckticketService;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;


//@TransactionManagement(TransactionManagementType.BEAN)
public class BatchCheckticketServiceImpl implements BatchCheckticketService {

	
	private CheckticketDao checkticketDao = new CheckticketDao();
	
	private TicketService ticketService = new TicketServiceImpl();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private CheckticketService checkticketService = new CheckticketServiceImpl();

	//@Resource
	//private UserTransaction userTransaction = new UserTransaction();

	// 通检、实现按票号s检票过程,islazycheck是否补检
	@Override
	public String checkByticketnos(long checkstationid, long scheduleplanid,
			long vehiclereportid, String ticketnos,Global global, 
			boolean islazycheck, String ip, String ticketentrance)
			throws ServiceException {
		Organization org = checkticketDao.getOrganization(checkstationid);
		// 重打/补开/注销 结算单天数
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		int total = 0;
		int success = 0;
		int fail = 0;
		StringBuffer bf = new StringBuffer("");

		String tickets[] = ticketnos.split(",");
		total = tickets.length;
		for (String ticketno : tickets) {
			try {
				//userTransaction.begin();
				try {
					Ticketsell ts = ticketService.getTicket(ticketno,
							departdate);
					if (ts.getScheduleplanid() == scheduleplanid) {
						checkticketService.checkticket(checkstationid,
								vehiclereportid, ts,  global, islazycheck,
								ip, ticketentrance, false,"0");

					} else {
						checkticketService.mixCheckticket(checkstationid,
								scheduleplanid, vehiclereportid, ts.getId(),
								global, (short) 0,"",true);
					}
				} catch (ServiceException se) {
					// Map<String, String> map = new HashMap<String, String>();
					String s = ticketno + "检票失败，原因是："
							+ se.getExceptionMessage() + "#";
					bf.append(s);
					fail = fail + 1;
					//userTransaction.rollback();
					continue;
				} 
				//userTransaction.commit();
				success = success + 1;
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
			}
		}
		// ticketService.getTicket(ticket.getTicketno(), departdate);
		// 获取车票并锁住
		// 如果取不到车票，提示“该车票不存在，或过了补开天数”
		bf.append("一共检票" + total + "张,成功检票" + success + "张,失败检票" + fail + "张#");
		return bf.toString();
	}

}
