package controllers.QueryWindowPayment.service.impl;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.AppConstant;

import com.sun.jmx.snmp.Timestamp;

import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import controllers.QueryWindowPayment.dao.QueryWindowPaymentDao;
import controllers.QueryWindowPayment.service.QueryWindowPaymentService;
import util.CommonUtil;

/**
 * 
 * @author Administrator
 *
 */

public class QueryWindowPaymentServiceImpl implements QueryWindowPaymentService {

	private QueryWindowPaymentDao dao = new QueryWindowPaymentDao();

	/**
	 * 窗口电子支付汇总表
	 * 
	 * @param propertyFilterList
	 * @param summaryway
	 *            [ 0 支付方式分组 || 1 交易日期分组 || 2 交易日期和支付方式分组]
	 * @param datetype
	 *            [0 售票日期 || 1 发车日期]
	 * @return
	 */
	public List<Map<String, Object>> queryPaymentSummary(List<PropertyFilter> propertyFilterList, String summaryway,Date beginDate,Date endDate){
		String paymethods = "";
		PropertyFilter pf = null;
		//处理支付方式传值问题，转成符合查询变量
		for(PropertyFilter propertyFilter : propertyFilterList){
			if("paymethod".equalsIgnoreCase(propertyFilter.getPropertyName())){
				paymethods = (String)propertyFilter.getMatchValue();//(0,1) --> ('0','1')
				paymethods = paymethods.replaceAll(",","','");
				paymethods = "('" + paymethods.substring(1, paymethods.length()) ;
				paymethods = paymethods.substring(0,paymethods.length() - 1) + "')";
				play.Logger.debug("paymethods is:" + paymethods);
				propertyFilterList.remove(propertyFilter);
				pf = new PropertyFilter("INS_p!paymethod",paymethods) ;
				propertyFilterList.add(pf);
				break;
			}
		}
		return ListUtil.listToMap(
				new Object[] {"code","name", "sellorgname", "selldate", "paymethod", "paymerchant"
						//, "username", "usercode"
						,"sellordernum","sellticketnum","sellticketmoney","sellinsurenum","sellinsuremoney","selltotalmoney"
						,"returnordernum","returnticketnum","returnticketmoney","returninsurenum","returninsuremoney","returntotalmoney"
						//, "orderno", "price", "returnprice"
						,"amount" },
				dao.queryPaymentSummary(propertyFilterList, summaryway,beginDate,endDate),
				new Object[] { String.class, String.class,String.class, String.class,String.class, String.class
						//, String.class, String.class
						, BigDecimal.class,BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class
						, BigDecimal.class,BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class
						, BigDecimal.class });
	}

	/**
	 * 查询订单支付明细
	 */
	@Override
	public List<Map<String, Object>> queryPayment(List<PropertyFilter> propertyFilterList,Date beginDate,Date endDate) {
		return ListUtil.listToMap(
				new Object[] {"paytype", "orderno", "payorderno", "payno", "totalprice", "paymessage", "createtime",
						"paytradenameval", "sellorgname", "returnmoneytotal", "cardcode", "ip", "paystatusname",
						"orderstatusname", "paymethod", "name", "code","tickets" ,"ticketprice",
						"insures","insurefee"},
				dao.queryPayment(propertyFilterList,beginDate,endDate),
				new Object[] { String.class,String.class, String.class, String.class, BigDecimal.class, String.class,
						Timestamp.class, String.class, String.class, BigDecimal.class, String.class, String.class,
						String.class, String.class, String.class, String.class, String.class,
						long.class,BigDecimal.class,long.class,BigDecimal.class});
	}

	@Override
	public List<Map<String, Object>> find(String helpType, String param, List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select  t.id as id,t.id as code,t.paytradenameval as name from Gateway t  ");
		Object[] fileds = { "id", "code", "name" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, dao.query(sql.toString()), filedtypes);
	}

	/**
	 * 查询窗口电子支付明细
	 */
	@Override
	public List<Map<String, Object>> ticketEpayDetail(Global g,Date beginDate, Date endDate, List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(
				//add by tianhb 2018年12月13日 增加一列：服务费 servicefee
				new Object[] { "operatetype", "operatetime", "departdate", "ticketno", "name",
						"code", "stationname", "price", "returnamount", "charge", "seatno",
						"premium", "orderno", "ticketstatus", "paymethod", "username", "cardno" ,"servicefee"},
				dao.ticketEpayDetail( g,beginDate, endDate, propertyFilterList),
				new Object[] { String.class, Timestamp.class, Date.class, String.class, String.class,
						String.class, String.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, String.class,
						BigDecimal.class, String.class, String.class, String.class, String.class, String.class,BigDecimal.class });
	}

	/**
	 * 窗口电子支付汇总表
	 * 
	 * @param propertyFilterList
	 * @param summaryway
	 *            [ 0 支付方式分组 || 1 交易日期分组 || 2 交易日期和支付方式分组]
	 * @param datetype
	 *            [0 售票日期 || 1 发车日期]
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryEpaymentTicketsSum(List<PropertyFilter> propertyFilterList, String summaryway,
			String datetype, Date starttime, Date endtime,Global g) {
		return ListUtil.listToMap(
				//add by tianhb 2018年12月13日 增加一列：服务费 servicefee
				new Object[] {"selltime", "username", "usercode", "paymethod", "tsellnum", "tsellprice", "treturnnum",
						"treturnprice", "dfcharges", "ylcharges", "inssellnum", "inssellprice", "insretrnnum", "insreturnprice", "total","servicefee" },
				dao.queryEpaymentTicketsSum(propertyFilterList, summaryway, datetype, starttime, endtime, g),
				new Object[] {String.class, String.class, String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class });
	}

}
