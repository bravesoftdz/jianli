package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.QuerySellBalanceSummaryDao;
import cn.nova.bus.report.service.QuerySellBalanceSummaryService;
import cn.nova.utils.orm.jpa.ListUtil;

public class QuerySellBalanceSummaryServiceImpl implements QuerySellBalanceSummaryService{
	QuerySellBalanceSummaryDao dao;
	/*
	 * 售票点结算汇总表ServiceImpl
	 */
	@Override
	public List<Map<String, Object>> query(String printorgids,String sellorgids,
			Date startdate,Date enddate,Long routeid,Long scheduleid,Long vehicleid) {
		/*得到的条目：
		printorgname,打单机构
	    sellorgname,售票点
	    invoicenum,结算单数
	    ticketnum,上车票+漏乘+退票+废票张数  
	    schnum,班次数
	    seatnum,座位数
	    printpeople,打单人
	    nonfactnum,漏乘人数
	    returnnum,退票张数
	    cancelnum,废票张数
	    sellamount,售票+漏乘+退票+废票金额
	    totalamount,上车票金额
	    invoiceamount,运量金额
	    nonfactamount,漏乘金额
	    returnamount,退票金额
	    cancelamount,废票金额
	    balanceamount,结算金额
	    shouxufee,手续费（退票手续费+改签手续费+补票服务费）
	    revenueamount,营收金额
	    stationservicefee,站务费
	    fueladditionfee,燃油费
	    computefee,微机费
	    coolairfee,空调费
	    additionfee,附加费
	    waterfee,配水费
	    insurefee,保险费
	    otherfee,其他
	    totalfee,票价组成项小计
	    agentfee,客运代理费 */
		dao = new QuerySellBalanceSummaryDao();
		List list = dao.query(printorgids,sellorgids,
				 startdate, enddate, routeid, scheduleid, vehicleid);
		
		return ListUtil.listToMap(new Object[]{"printorgname", "sellorgname",
			    "invoicenum", "ticketnum", "schnum", "seatnum",
			    "printpeople", "nonfactnum", "returnnum", "cancelnum",
			    "sellamount", "totalamount", "invoiceamount",
			    "nonfactamount", "returnamount", "cancelamount",
			    "balanceamount", "shouxufee", "revenueamount",
			    "stationservicefee", "fueladditionfee", "computefee", "coolairfee",
			    "additionfee", "waterfee", "insurefee", "otherfee",
			    "totalfee", "agentfee","ticketoutsmoney","ticketvalidatenum","sellvalidateamount"},
			    list,
			    new Object[]{String.class, String.class,
				Long.class, Long.class, Long.class, Long.class,
				Long.class, Long.class, Long.class, Long.class, 
				BigDecimal.class, BigDecimal.class, BigDecimal.class, 
				BigDecimal.class, BigDecimal.class, BigDecimal.class, 
				BigDecimal.class, BigDecimal.class, BigDecimal.class, 
				BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class});
	}
}
