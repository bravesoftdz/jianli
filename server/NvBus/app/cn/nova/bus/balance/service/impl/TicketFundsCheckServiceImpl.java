package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.TicketFundsCheckDao;
import cn.nova.bus.balance.service.TicketFundsCheckService;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketFundsCheckServiceImpl implements TicketFundsCheckService {

	private TicketFundsCheckDao ticketFundsCheckDao = new TicketFundsCheckDao();
	
	@Override
	public List<Map<String, Object>> query(String vehicleno,Date balanceStartdate,Date balanceEnddate) {
		// TODO Auto-generated method stub
		Object[] fileds = {"contactperson","vehicleno","ditotalnum","ditotalmoney","diagentfee",
				"balancemoney","parkfee","healthfee","otherfee","packagefee", "signature"};		
	Object[] filedtypes = { 
			String.class, String.class,BigDecimal.class,BigDecimal.class,BigDecimal.class, 
			BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class, String.class};
	return ListUtil.listToMap(fileds,
			ticketFundsCheckDao.find(vehicleno,balanceStartdate,balanceEnddate),filedtypes);
	}

}
