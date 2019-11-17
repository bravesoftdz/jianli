package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.nova.bus.query.dao.BusinessDataSummaryQryDao;
import cn.nova.bus.query.dao.DayBookingsQryDao;
import cn.nova.bus.query.dao.DrawVehSummaryQryDao;
import cn.nova.bus.query.dao.NetworkTicketSummaryQryDao;
import cn.nova.bus.query.dao.OrgDataSummaryQryDao;
import cn.nova.bus.query.dao.RouteDataSummaryQryDao;
import cn.nova.bus.query.dao.SchTicketPriceQryDao;
import cn.nova.bus.query.dao.TicketSummaryQryDao;
import cn.nova.bus.query.service.DataContrastSummaryService;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class DataContrastSummaryServiceImpl implements
		DataContrastSummaryService {
	@Override
	public List<Map<String, Object>> queryRouteDataSummary(
			List<PropertyFilter> propertyFilterList, boolean isbynormal,
			boolean isbylatter) {
		RouteDataSummaryQryDao dataSummaryQryDao = new RouteDataSummaryQryDao();
		return ListUtil.listToMap(new Object[] { "orgname", "rporgname","routename",
				"departdate", "schnum", "schnum1", "schnumComp",
				"schnumPercent", "ticketnum", "ticketnum1", "ticketnumComp",
				"ticketnumPercent", "totalamount", "totalamount1",
				"totalamountComp", "totalamountPercent", "peopledistance",
				"peopledistance1", "peopledistanceComp",
				"peopledistancePercent", "rate", "rate1", "rateComp",
				"ratePercent" }, dataSummaryQryDao.queryRouteDataSummary(
				propertyFilterList, isbynormal, isbylatter), new Object[] {
				String.class,String.class, String.class, String.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, String.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, String.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, String.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, String.class, String.class, String.class,
				String.class, String.class });
	}

	/**
	 * 站务分公司网点售票情况汇总表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryTicketSummary(
			List<PropertyFilter> propertyFilterList) {
		TicketSummaryQryDao ticketSummaryQryDao = new TicketSummaryQryDao();
		return ListUtil.listToMap(new Object[] { "orgname", "sellbyname",
				"departdate", "sellnum", "sellmoney", "returnnum",
				"returnmoney", "cancelnum", "cancelmoney", "sellnum1",
				"sellmoney1", "returnnum1", "returnmoney1", "cancelnum1",
				"cancelmoney1", "returntcknum", "returntcamount",
				"returntcknum1", "returntcamount1",

				"sellnumComp", "sellnumPercent", "sellmoneyComp",
				"sellmoneyPercent", "returnnumComp", "returnnumPercent",
				"returnmoneyComp", "returnmoneyPercent", "cancelnumComp",
				"cancelnumPercent", "cancelmoneyComp", "cancelmoneyPercent",
				"returntcknumComp", "returntcknumPercent",
				"returntcamountComp", "returntcamountPercent" },
				ticketSummaryQryDao.queryTicketSummary(propertyFilterList),
				new Object[] { String.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class,

						BigDecimal.class, String.class, BigDecimal.class,
						String.class, BigDecimal.class, String.class,
						BigDecimal.class, String.class, BigDecimal.class,
						String.class, BigDecimal.class, String.class,
						BigDecimal.class, String.class, BigDecimal.class,
						String.class, });
	}

	/**
	 * 站务分公司站场业务数据情况汇总表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryBusinessSummary(
			List<PropertyFilter> propertyFilterList) {
		BusinessDataSummaryQryDao businessDataSummaryQryDao = new BusinessDataSummaryQryDao();
		return ListUtil.listToMap(new Object[] { "orgname", "departdate",
				"schnum", "schnum1", "schnumComp", "schnumPercent",
				"ticketnum", "ticketnum1", "ticketnumComp", "ticketnumPercent",
				"totalamount", "totalamount1", "totalamountComp",
				"totalamountPercent", "peopledistance", "peopledistance1",
				"peopledistanceComp", "peopledistancePercent", "rate", "rate1",
				"rateComp", "ratePercent", "sellincome", "sellincome1",
				"sellincomeComp", "sellincomePercent" },
				businessDataSummaryQryDao
						.queryBusinessSummary(propertyFilterList),
				new Object[] { String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, String.class,
						String.class, String.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class });
	}

	/**
	 * 联网售票统计报表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public MethodResult queryNetworkTicket(
			List<PropertyFilter> propertyFilterList) {
		NetworkTicketSummaryQryDao networkTicketSummaryQryDao = new NetworkTicketSummaryQryDao();
		DecimalFormat df = new DecimalFormat(".00");
		MethodResult res=new MethodResult();
		res.setResult(0);
		String orgids = null;
		String titlenames="";
		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;
		Long routeid = 0L; 
		String ticketoutletids = "";
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!id")) {
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!startdate")) {
					startdate = (Date) propertyFilterList.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!enddate")) {
					enddate = (Date) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("c!compSdate")) {
					if(propertyFilterList.get(t).getMatchValue()!=null){
						compStartdate = (Date) propertyFilterList.get(t)
							.getMatchValue();
						continue;
					}
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("c!compEdate")) {
					if((Date) propertyFilterList.get(t).getMatchValue()!=null){
						compEnddate = (Date) propertyFilterList.get(t)
								.getMatchValue();
						continue;
					}
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!routeid")) {
					routeid = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("t!ticketoutletsid")) {
					ticketoutletids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}
			}
		}
		Set<String> rows = new HashSet<String>();// 行(售往机构)
		Set<String> cols = new HashSet<String>();// 列(售票机构)
		List<Object> list = new ArrayList<Object>();
		//omap2 = new HashMap<String, Object>();
		// 查询售票的机构
		 List<Object> orgs=networkTicketSummaryQryDao.queryOrgs(startdate,
		   enddate,compStartdate,compEnddate,orgids,routeid, ticketoutletids);
		if (compStartdate == null) {
			String sellorg="";
			String schorg="";
			int col_num=0;
			int row_num=0;
			for (Object org : orgs) {
				   Object[] obj=(Object[]) org;
                   String _sellorg=obj[0].toString();
				   if(!sellorg.equals(_sellorg)){
					   sellorg=_sellorg;
					   col_num=col_num+1;
					   cols.add(sellorg);
				   }				
			}
			col_num=(col_num+1)*2+1;//总列数

			String[] titlename =new String[col_num];
			Object[] fieldtypes =new Object[col_num];
			Object[] fieldnames =new Object[col_num];
			for(int i=0;i<col_num;i++){
				fieldnames[i]="a"+i;
			}
			Iterator<String> colit = cols.iterator();
			titlename[0] = "售往方向";
			fieldtypes[0]=String.class;
			int i=1;
			while (colit.hasNext()) {
				sellorg = colit.next();
				titlename[i] = sellorg + "|人数";
				titlename[i + 1] = sellorg + "|金额";
				fieldtypes[i] = Integer.class;
				fieldtypes[i + 1] = BigDecimal.class;
			
				i=i+2;
			}
			titlename[i] = "合计|人数";
			titlename[i + 1] = "合计|金额";
			for(String s:titlename){
				titlenames=titlenames+s+",";
			}
			fieldtypes[i] = Integer.class;
			fieldtypes[i + 1] = BigDecimal.class;
			for (Object org : orgs) {
				Object[] obj = (Object[]) org;
				String _schorg = obj[1].toString();
				if (!schorg.equals(_schorg)) {
					schorg = _schorg;
					row_num = row_num + 1;
					rows.add(schorg);
				}
			}
			Object[] objs=new Object[col_num];
			//for(i=0;i<objs.length;i++){
			//	objs[i]=i+"";
			//}
			//list.add(objs);
			Iterator<String> rowit=rows.iterator();
			while(rowit.hasNext()){
			    schorg=rowit.next();
				Object[] newObject=new Object[col_num];
				i=0;
				newObject[i]=schorg;
				colit = cols.iterator();
				int total_num=0;
				BigDecimal total_price=new BigDecimal(0);
				while(colit.hasNext()){
				    sellorg=colit.next();				    
				    for (Object org : orgs) {
						Object[] obj=(Object[]) org;
						String _sellorg=obj[0].toString();
						String _schorg=obj[1].toString();
						String _sellnum=obj[2].toString();
						String _totalprice=obj[3].toString();						
		    	    	if(schorg.equals(_schorg)&&sellorg.equals(_sellorg)){
							newObject[i+1]=_sellnum;
							newObject[i+2]=_totalprice;
							total_num=total_num+new Integer(_sellnum);
							total_price=total_price.add(new BigDecimal(_totalprice));
						}				    	
				    }
				    i=i+2;
				}
				newObject[col_num-2]=total_num;
				newObject[col_num-1]=total_price;
				list.add(newObject);
			}
			res.setObject(ListUtil.listToMap(fieldnames,list,fieldtypes));
			res.setResultMsg(titlenames);
			//List<Map<String, Object>>
			return  res;
		} else {
			String sellorg="";
			String schorg="";
			int col_num=0;
			int row_num=0;
			for (Object org : orgs) {
				   Object[] obj=(Object[]) org;
                   String _sellorg=obj[0].toString();
				   if(!sellorg.equals(_sellorg)){
					   sellorg=_sellorg;
					   col_num=col_num+1;
					   cols.add(sellorg);
				   }				
			}
			col_num=(col_num+1)*6+1;//总列数
			String[] titlename =new String[col_num];
			Object[] fieldtypes =new Object[col_num];
			Object[] fieldnames =new Object[col_num];
			for(int i=0;i<col_num;i++){
				fieldnames[i]="a"+i;
			}			
			Iterator<String> colit = cols.iterator();
			titlename[0] = "售往方向";
			fieldtypes[0]=String.class;
			int i=1;
			while (colit.hasNext()) {
				sellorg = colit.next();
				titlename[i] = sellorg + "|本期|人数";
				titlename[i + 1] = sellorg + "|同期|人数";
				titlename[i + 2] = sellorg + "|人数|增长";
				titlename[i + 3] = sellorg + "|本期|金额";
				titlename[i + 4] = sellorg + "|同期|金额";
				titlename[i + 5] = sellorg + "|金额|增长";	
				
				fieldtypes[i] = Integer.class;
				fieldtypes[i + 1] = Integer.class;
				fieldtypes[i + 2] = String.class;
				fieldtypes[i + 3] = BigDecimal.class;
				fieldtypes[i + 4] = BigDecimal.class;
				fieldtypes[i + 5] = String.class;	
				
				i=i+6;
			}
			titlename[i] = "合计|本期|人数";
			titlename[i + 1] = "合计|同期|人数";
			titlename[i + 2] = "合计|人数|增长";
			titlename[i + 3] = "合计|本期|金额";
			titlename[i + 4] = "合计|同期|金额";
			titlename[i + 5] = "合计|金额|增长";		
			for(String s:titlename){
				titlenames=titlenames+s+",";
			}
			fieldtypes[i] = Integer.class;
			fieldtypes[i + 1] = Integer.class;
			fieldtypes[i + 2] = String.class;
			fieldtypes[i + 3] = BigDecimal.class;
			fieldtypes[i + 4] = BigDecimal.class;
			fieldtypes[i + 5] = String.class;				
			
			for (Object org : orgs) {
				Object[] obj = (Object[]) org;
				String _schorg = obj[1].toString();
				if (!schorg.equals(_schorg)) {
					schorg = _schorg;
					row_num = row_num + 1;
					rows.add(schorg);
				}
			}
			Object[] objs=new Object[col_num];
			Iterator<String> rowit=rows.iterator();
			while(rowit.hasNext()){
			    schorg=rowit.next();
				Object[] newObject=new Object[col_num];
				i=0;
				newObject[i]=schorg;
				colit = cols.iterator();
				int total_num=0;
				BigDecimal total_price=new BigDecimal(0);
				int ctotal_num=0;
				BigDecimal ctotal_price=new BigDecimal(0);				
				while(colit.hasNext()){
				    sellorg=colit.next();				    
				    for (Object org : orgs) {
						Object[] obj=(Object[]) org;
						String _sellorg=obj[0].toString();
						String _schorg=obj[1].toString();
						String _sellnum=obj[2].toString();
						String _totalprice=obj[3].toString();
						String _csellnum=obj[4].toString();
						String _ctotalprice=obj[5].toString();
						String _csellnumrate=obj[6].toString().trim();
						String _ctotalpricerate=obj[7].toString().trim();							
		    	    	if(schorg.equals(_schorg)&&sellorg.equals(_sellorg)){
							newObject[i+1]=_sellnum;
							newObject[i+2]=_csellnum;
							newObject[i+3]=_csellnumrate;							
							newObject[i+4]=_totalprice;
							newObject[i+5]=_ctotalprice;
							newObject[i+6]=_ctotalpricerate;							
							total_num=total_num+new Integer(_sellnum);
							total_price=total_price.add(new BigDecimal(_totalprice));
							ctotal_num=ctotal_num+new Integer(_csellnum);
							ctotal_price=ctotal_price.add(new BigDecimal(_ctotalprice));							
						}				    	
				    }
				    i=i+6;
				}
				newObject[col_num-6]=total_num;
				newObject[col_num-5]=ctotal_num;
				if(ctotal_num==0){
					newObject[col_num-4]="100%";
					newObject[col_num-1]="100%";					
				}else{
					newObject[col_num-4]=df.format(((total_num-ctotal_num)*100/ctotal_num))+"%";
					newObject[col_num-1]=((total_price.subtract(ctotal_price)).multiply(new BigDecimal(100)).
							divide(ctotal_price,2,BigDecimal.ROUND_HALF_DOWN))+"%";		
				}
				newObject[col_num-3]=total_price;
				newObject[col_num-2]=ctotal_price;
				
				list.add(newObject);
			}
			res.setObject(ListUtil.listToMap(fieldnames,list,fieldtypes));
			res.setResultMsg(titlenames);
			return  res;
		}
	}

	/**
	 * 预售票日报表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryDayBookings(
			List<PropertyFilter> propertyFilterList) {
		DayBookingsQryDao bookingsQryDao = new DayBookingsQryDao();
		return ListUtil.listToMap(new Object[] { "orgname", "selltime",
				"routename","ticketoutletsname","ticketoutletstype",
				"samedaynum", "samedayprice", "backtennum", "backtenprice",
				"numPercent", "pricePercent", "samedaynum1", "samedaynum2",
				"samedaynum3", "samedaynum4", "samedaynum5", "samedaynum6",
				"samedaynum7", "samedaynum8", "samedaynum9", "samedaynum10" },
				bookingsQryDao.queryDayBookings(propertyFilterList),
				new Object[] { String.class, String.class,String.class, String.class,String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class });
	}

	/**
	 * 站务作业统计报表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryOrgDataSummary(
			List<PropertyFilter> propertyFilterList) {

		OrgDataSummaryQryDao orgDataSummaryQryDao = new OrgDataSummaryQryDao();

		String orgids = null;

		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;

		Date accstartdate = null;
		Date accenddate = null;
		Date acccompStartdate = null;
		Date acccompEnddate = null;

		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}

				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!startdate")) {
					startdate = (Date) propertyFilterList.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!enddate")) {
					enddate = (Date) propertyFilterList.get(t).getMatchValue();
					continue;
				}
			}
		}

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatyear = new SimpleDateFormat("yyyy年");

		// 本期同比日期
		long beforeTime = (startdate.getTime() / 1000) - 60 * 60 * 24 * 365;
		compStartdate = new Date(beforeTime * 1000);

		beforeTime = (enddate.getTime() / 1000) - 60 * 60 * 24 * 365;
		compEnddate = new Date(beforeTime * 1000);

		// 累积同比日期
		accstartdate = getCurrentYearStartTime(startdate, format);
		accenddate = enddate;
		acccompStartdate = getCurrentYearStartTime(compStartdate, format);
		acccompEnddate = compEnddate;
		//查询截转表
		 List<Object> list = orgDataSummaryQryDao.query(orgids, startdate,
		 enddate, compStartdate, compEnddate, accstartdate, accenddate,
		 acccompStartdate, acccompEnddate);
		 //查询结算单表
//		List<Object> list = orgDataSummaryQryDao.querydepices(orgids,
//				startdate, enddate, compStartdate, compEnddate, accstartdate,
//				accenddate, acccompStartdate, acccompEnddate);

		// 查询时日期加了1天，显示需减去
//		enddate = new Date(enddate.getTime() - (long) 1 * 24 * 60 * 60 * 1000);
//		compEnddate = new Date(compEnddate.getTime() - (long) 1 * 24 * 60 * 60
//				* 1000);
//		accenddate = new Date(accenddate.getTime() - (long) 1 * 24 * 60 * 60
//				* 1000);
//		acccompEnddate = new Date(acccompEnddate.getTime() - (long) 1 * 24 * 60
//				* 60 * 1000);

		if (list != null && list.size() > 0) {
			Object[] field = new Object[12];
			Object[] fieldType = new Object[] { String.class, String.class,
					String.class, String.class, BigDecimal.class,
					BigDecimal.class, BigDecimal.class, String.class,
					BigDecimal.class, BigDecimal.class, BigDecimal.class,
					String.class };
			field[0] = "1";
			field[1] = "2";
			field[2] = "指标";
			field[3] = "机构";
			// field[4] = format.format(startdate) + "至" +
			// format.format(enddate)
			// + "|本期";
			// field[5] = format.format(compStartdate) + "至"
			// + format.format(compEnddate) + "|本期";
			field[4] = formatyear.format(startdate) + "|本期";
			field[5] = formatyear.format(compStartdate) + "|本期";

			field[6] = "与" + formatyear.format(compEnddate) + "相比|增长数";
			field[7] = "与" + formatyear.format(compEnddate) + "相比|增长率%";

			// field[8] = format.format(accstartdate) + "至"
			// + format.format(accenddate) + "|累计";
			// field[9] = format.format(acccompStartdate) + "至"
			// + format.format(acccompEnddate) + "|累积";
			field[8] = formatyear.format(accstartdate) + "|累计";
			field[9] = formatyear.format(acccompStartdate)  + "|累积";

			field[10] = "与" + formatyear.format(acccompEnddate) + "相比|累计增长数";
			field[11] = "与" + formatyear.format(acccompEnddate) + "相比|累计增长率%";

			if (list.size() > 0) {
				int len = 12;
				Object[] newObject = new Object[len];
				newObject[0] = "0";
				for (int i = 1; i < len - 1; i++) {
					newObject[i] = i;
				}
				newObject[len - 1] = "" + (len - 1);
				list.add(0, newObject);
				newObject = null;
			}

			return ListUtil.listToMap(field, list, fieldType);
		}

		return ListUtil.listToMap(new Object[] { "0" }, null,
				new Object[] { String.class });

	}

	/**
	 *站务分公司各班线票价情况汇总表  
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querySchTicketprice(List<PropertyFilter> propertyFilterList){
		SchTicketPriceQryDao schTicketPriceQryDao = new SchTicketPriceQryDao();
		return ListUtil.listToMap(new Object[] { "orgname","departdate", "startstname","endstname",
				"distance", "balancedistance","type","grade",
				"typevalue", "gradevalue", "toplimitprice", "toplimitfuelfee",
				"toptoprice", "fullprice","fullfuelfee", "fulltoprice"},
				schTicketPriceQryDao.queryTicketSummary(propertyFilterList),
				new Object[] { String.class,Timestamp.class,String.class,String.class,
						BigDecimal.class, BigDecimal.class,String.class, String.class,
						String.class, String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class});
	}
	
	/**
	 *站务分公司进站车辆汇总表  
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryDrawVehSummary(List<PropertyFilter> propertyFilterList){
		DrawVehSummaryQryDao drawVehSummaryQryDao = new DrawVehSummaryQryDao();
		return ListUtil.listToMap(new Object[] { "orgname", "unitname",
				"grade5","grade4", "grade3","grade2","grade1","grade678", "amountnum", 
				"routes0", "routes1","routes2", "routes3","routes4", "routesamount",
				"distance0","distance1","distance2","distance3","distance4","distanceamount",
				"schnums0","schnums1","schnums2","schnums3","schnums4","schnumsamount",
				"ticknums0","ticknums1","ticknums2","ticknums3","ticknums4","ticknumsamount",
				"balancedistance0","balancedistance1","balancedistance2","balancedistance3","balancedistance4","balancedistancesamount"
				},
				drawVehSummaryQryDao.querydrawVehSummary(propertyFilterList),
				new Object[] { String.class, String.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,
						});
	}
	
	
	
	
	
	
	/**
	 * 当前年的开始时间，即2012-01-01 00:00:00
	 * 
	 * @return
	 */
	public Date getCurrentYearStartTime(Date date, SimpleDateFormat format) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		Date now = null;
		try {
			c.set(Calendar.MONTH, 0);
			c.set(Calendar.DATE, 1);
			now = format.parse(format.format(c.getTime()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return now;
	}
}
