package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.IncomeDepartivoiceDao;
import cn.nova.bus.report.dao.TicketsellIncomeReportDao;
import cn.nova.bus.report.service.IncomeDepartivoiceSerivce;
import cn.nova.bus.report.service.TicketsellIncomeReportSerivce;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：营收报表</b><br/>
 * <b>类名称：</b>TicketsellIncomeReportSerivceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:liaojunchang@nova.net.cn">廖俊昌</a><br/>
 * <b>创建时间：</b>2012-09-05<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketsellIncomeReportSerivceImpl implements TicketsellIncomeReportSerivce {

	private TicketsellIncomeReportDao  dao = new TicketsellIncomeReportDao();

	/**
	 * 售票营收统计表
	 * 数据取自表ticketsell ,ticketreturn ,ticketchange
	 */
	@Override
	public List<Map<String, Object>> queryIncomeReport(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,Long reportnum, String sellstarttime, String sellendtime, String ticketoutletsid) {
//		List<Object> resultList = new ArrayList();
//		System.out.println(new Date()+",1");
//		List<Object> list = dao.queryIncomeReport(sellorgid,sellerid,ticketstatus,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,reportnum);
//		System.out.println(new Date()+",2");
//		for(int i=0;i<list.size();i++){
//			Object[] object = (Object[])list.get(i);
//			StringBuffer return_cancel = new StringBuffer();
//			if(reportnum==1){
//				String userno = (String)object[0];
//				String sellorgname = (String)object[2];
//				List<Object> list1 = queryticket1(sellorgid,sellerid,ticketstatus,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,userno,sellorgname);
//				if(list1.size() > 100){
//					for(int j=0;j < 100;j++){
//						Object[] o = (Object[])list1.get(j);
//						return_cancel.append(o[2].toString());
//						if(j < 99){
//							return_cancel.append(",");
//						}
//					}
//					return_cancel.append(" ... ...");
//				}else{
//					for(int j=0;j < list1.size();j++){
//						Object[] o = (Object[])list1.get(j);
//						return_cancel.append(o[2].toString());
//						if(j < list1.size()-1){
//							return_cancel.append(",");
//						}
//					}
//				}
//					
//			}else if(reportnum==2){
//				String sellorgname = (String)object[0];
//				String departorgname = (String)object[1];
//				List<Object> list2 = queryticket2(sellorgid,sellerid,ticketstatus ,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,sellorgname,departorgname);
//				if(list2.size() > 100){
//					for(int j=0;j < 100;j++){
////						return_cancel.append(list2.get(j).toString());
//						Object[] o = (Object[])list2.get(j);
//						return_cancel.append(o[2].toString());
//						if(j < 99){
//							return_cancel.append(",");
//						}
//					}
//					return_cancel.append(" ... ...");
//				}else{
//					for(int j=0;j < list2.size();j++){
////						return_cancel.append(list2.get(j).toString());
//						Object[] o = (Object[])list2.get(j);
//						return_cancel.append(o[2].toString());
//						if(j < list2.size()-1){
//							return_cancel.append(",");
//						}
//						
//					}
//				}
//				
//			}else{
//				String selldate = (DateUtils.formatDatetime((Date)object[0])).substring(0, 10);
//				String sellorgname = (String)object[1];
//				String departorgname = (String)object[2];
//				List<Object> list3 = queryticket3(sellorgid,sellerid,ticketstatus ,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,selldate,sellorgname,departorgname);
//				if(list3.size() > 100){
//					for(int j=0;j < 100;j++){
////						return_cancel.append(list3.get(j).toString());
//						Object[] o = (Object[])list3.get(j);
//						return_cancel.append(o[2].toString());
//						if(j < 99){
//							return_cancel.append(",");
//						}
//					}
//					return_cancel.append(" ... ...");
//				}else{
//					for(int j=0;j < list3.size();j++){
////						return_cancel.append(list3.get(j).toString());
//						Object[] o = (Object[])list3.get(j);
//						return_cancel.append(o[2].toString());
//						if(j < list3.size()-1){
//							return_cancel.append(",");
//						}
//					}
//				}
//				
//			}
//			System.out.println(new Date()+",3");
//			Object[] newobject = new Object[object.length+1];
//			for(int k = 0;k<object.length;k++){
//				newobject[k] = object[k];
//			}
//			newobject[newobject.length-1] = return_cancel.toString();
//			resultList.add(newobject);
//		} 
//        
		dao = new TicketsellIncomeReportDao();
			return ListUtil.listToMap(new Object[] {"column1","column2","column3","totalnum","nomalnum",
					"fullpricenum","halfpricenum","studentpricenum","armypricenum","salepricenum","freepricenum","changetnum","totalamount",
				       "nomalamount","returnfee","cancelnum","cancelamount","returnnum","privilegereturnnum",
				       "returnamount","stationservicefee","nostationfeeamount","extramoney"},
				       dao.queryIncomeReport(sellorgid,sellerid,ticketstatus,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,reportnum, sellstarttime,  sellendtime, ticketoutletsid),
				       					new Object[] {String.class,String.class,String.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class});			
	}
	
	/**
	 * 售票营收统计表
	 * 查询废退单号
	 */
	@Override
	public List<Map<String, Object>> queryCancel_return(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,Long reportnum,String column1,String column2,String column3){
//			StringBuffer return_cancel = new StringBuffer();
//			if(reportnum==1){
//				
//				List<Object> list1 = queryticket1(sellorgid,sellerid,ticketstatus,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,column1,column3);
//				for(int j=0;j < list1.size();j++){
//					return_cancel.append(list1.get(j).toString());
//					if(j < list1.size()-1){
//						return_cancel.append(",");
//					}
//				}
//				
//			}else if(reportnum==2){
//				List<Object> list2 = queryticket2(sellorgid,sellerid,ticketstatus ,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,column1,column2);
//				for(int j=0;j < list2.size();j++){
//					return_cancel.append(list2.get(j).toString());
//					if(j < list2.size()-1){
//						return_cancel.append(",");
//					}
//					
//				}
//			}else{
//				List<Object> list3 = queryticket3(sellorgid,sellerid,ticketstatus ,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,column1,column2,column3);
//				for(int j=0;j < list3.size();j++){
//					return_cancel.append(list3.get(j).toString());
//					if(j < list3.size()-1){
//						return_cancel.append(",");
//					}
//				}
//			}
//			return return_cancel.toString();
		dao = new TicketsellIncomeReportDao();
		List<Object> resultList = new ArrayList();
		
		if(reportnum==1){
			resultList = queryticket1(sellorgid,sellerid,ticketstatus,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,column1,column3);
		}else if(reportnum==2){
			resultList = queryticket2(sellorgid,sellerid,ticketstatus ,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,column1,column2);
		}else{
			resultList = queryticket3(sellorgid,sellerid,ticketstatus ,ischangeticket,returnticketno,sellstartdatetime, sellenddatetime, departstartdate, departenddate,column1,column2,column3);
		}
		
		return ListUtil.listToMap(new Object[] {"selldatetime","type","ticketno"},resultList,
			       					new Object[] {String.class,String.class,String.class});	
	}
	
	public List<Object> queryticket1(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,String userno,String sellorgname){
		dao = new TicketsellIncomeReportDao();
		return dao.queryticket1( sellorgid, sellerid, ticketstatus ,ischangeticket, returnticketno, sellstartdatetime, sellenddatetime, departstartdate, departenddate, userno, sellorgname);
	}
	
	public List<Object> queryticket2(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,String sellorgname,String departorgname){
		dao = new TicketsellIncomeReportDao();
		return dao.queryticket2( sellorgid, sellerid, ticketstatus ,ischangeticket, returnticketno, sellstartdatetime, sellenddatetime, departstartdate, departenddate, sellorgname, departorgname);
	}
	
	public List<Object> queryticket3(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,String selldate,String sellorgname,String departorgname){
		dao = new TicketsellIncomeReportDao();
		return dao.queryticket3( sellorgid, sellerid, ticketstatus ,ischangeticket, returnticketno, sellstartdatetime, sellenddatetime, departstartdate, departenddate, selldate, sellorgname, departorgname);
	}

	/**
	 *售票点班线售票情况表
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> qryTicketoutletsSellroute(
			List<PropertyFilter> propertyFilterList) {
		dao = new TicketsellIncomeReportDao();
		return ListUtil.listToMap(new Object[] {				
				"printorgname","sellorgname","ticekoutlesname","routename","unitname",
				"vehicleno","sellnum","sellprice","balanceprice","subtotal",
		        "fueladditionfee","stationservicefee",
		        "computefee","coolairfee","additionfee","moreprice",
		        "waterfee","insurefee","otherfee","agentfee"},
				dao.qryTicketoutletsSellroute(propertyFilterList),
					new Object[] {
			    String.class,String.class,String.class,String.class,String.class,
			    String.class,long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			    BigDecimal.class,BigDecimal.class,
			    BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			    BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class});	
	}
	
	@Override
	public List<Map<String, Object>> CustomerBuyTicketSituation(List<PropertyFilter> buildFromHttpRequest,
			boolean isgroupbyroute, int groupby, int groupbywhat) {
		dao = new TicketsellIncomeReportDao();
		return ListUtil.listToMap(new Object[] { "routename","customername","certificateno","ticketnum","totalprice" },
				dao.CustomerBuyTicketSituation(buildFromHttpRequest, isgroupbyroute, groupby, groupbywhat),
				new Object[] { String.class, String.class, String.class, Integer.class, BigDecimal.class });
	}
}
