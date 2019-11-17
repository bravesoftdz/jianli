package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.IncomeDepartivoiceDao;
import cn.nova.bus.report.service.IncomeDepartivoiceSerivce;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：营收运量统计表</b><br/>
 * <b>类名称：</b>IncomeDepartivoiceSerivceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-05-03  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class IncomeDepartivoiceSerivceImpl implements IncomeDepartivoiceSerivce {
	private IncomeDepartivoiceDao dao = new IncomeDepartivoiceDao();
	@Override
	public List<Map<String, Object>> queryIncomeDepartivoice(String orgid,Date month,
			String checkstationid, Long routeid, Long unitid) {
		dao = new IncomeDepartivoiceDao();
		return ListUtil.listToMap(new Object[] { 
				"routename","sellnum","sellmoney","moreprice",
				"returncencelthismonth","returncencelthismonthprice","returncencelthismonthMprice",
				"returncencellastmonth","returncencellastmonthprice","returncencellastmonthMprice",
				"returncencelnextmonth","returncencelnextmonthprice","returncencelnextmonthMprice",
				"departinvoisthismonth","departinvoisthismonthprice","departinvoisthismonthMprice",
				"departinvoislastmonth","departinvoislastmonthprice","departinvoislastmonthMprice",
				"nextmonthdepart","nextmonthdepartprice","nextmonthdepartMprice",
				"missdepart","missdepartprice","missdepartMprice"},
			dao.queryIncomeDepartivoice(orgid,month,checkstationid,routeid,unitid),
			new Object[] {
				String.class, Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class,
				Long.class, BigDecimal.class,BigDecimal.class
			});	
	}
	
	public List<Map<String, Object>> qryStationUnitBalance(String orgid, Date startdate, Date enddate, long vehicleid,
			Long unitid,String sign) {
		dao = new IncomeDepartivoiceDao();
		return ListUtil.listToMap(new Object[] { 
				"unitname","vehicleno","departinvoicesnum","ticketnum","balanceamount","stationfee" ,
				"agentfee","cleanfee","advfee","otherfee1","otherfee2","truebalanceamount"},
			dao.qryStationUnitBalance(orgid,startdate,enddate,vehicleid,unitid,sign),
			new Object[] {
				String.class,String.class,long.class,long.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class
			});	
	}
}
