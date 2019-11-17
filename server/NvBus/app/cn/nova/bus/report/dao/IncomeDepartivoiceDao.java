package cn.nova.bus.report.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.commons.DateUtils;

/**
 * <b>类描述：营收运量统计表</b><br/>
 * <b>类名称：</b>VehicleStowageReportDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class IncomeDepartivoiceDao extends EntityManagerDaoSurport {		
	
	
	/**
	 * 营收运量统计表
	 * 
	 * @param month
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryIncomeDepartivoice(String orgid,Date month,String checkstationid, 
			Long routeid ,Long unitid) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(month);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		Date thismonthbegin = calendar.getTime();
		calendar.add(Calendar.MONTH, 1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		Date thismonthend = calendar.getTime();
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.add(Calendar.MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		Date nextmonthbegin = calendar.getTime();
		calendar.add(Calendar.MONTH, 1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		Date nextmonthend = calendar.getTime();		
		Calendar calendar1 = Calendar.getInstance();
		calendar1.setTime(month);
		calendar1.add(Calendar.MONTH, -1);
		calendar1.set(Calendar.DAY_OF_MONTH, 1);
		calendar1.set(Calendar.HOUR_OF_DAY, 0);
		calendar1.set(Calendar.MINUTE, 0);
		calendar1.set(Calendar.SECOND, 0);
		calendar1.set(Calendar.MILLISECOND, 0);
		Date lastmonthbegin = calendar1.getTime();
		calendar1.add(Calendar.MONTH, 1);
		calendar1.set(Calendar.DAY_OF_MONTH, -1);
		calendar1.set(Calendar.HOUR_OF_DAY, 23);
		calendar1.set(Calendar.MINUTE, 59);
		calendar1.set(Calendar.SECOND, 59);
		calendar1.set(Calendar.MILLISECOND, 999);		
		Date lastmonthend = DateUtils.add(calendar1.getTime(),1);		
		
		StringBuffer sql = new StringBuffer("select routename,")
		.append("sum(sellnum-(cencelthismonth+returnthismonth)-(cencellastmonth+returnlastmonth)-(cencelnextmonth+returnnextmonth)) sellnum,")
		.append("sum(sellmoney-(cencelthismonthprice+returnthismonthprice)-(cencellastmonthprice+returnlastmonthprice)-(cencelnextmonthprice+returnnextmonthprice)) sellmoney,")
		.append("sum(moreprice-(cencelthismonthMprice+returnthismonthMprice)-(cencellastmonthMprice+returnlastmonthMprice)-(cencelnextmonthMprice+returnnextmonthMprice)) moreprice,")
		.append("sum(cencelthismonth+returnthismonth) returncencelthismonth,")
		.append("sum(cencelthismonthprice+returnthismonthprice) returncencelthismonthprice,")
		.append("sum(cencelthismonthMprice+returnthismonthMprice) returncencelthismonthMprice,")
		.append("sum(cencellastmonth+returnlastmonth) returncencellastmonth,")
		.append("sum(cencellastmonthprice+returnlastmonthprice) returncencellastmonthprice,")
		.append("sum(cencellastmonthMprice+returnlastmonthMprice) returncencellastmonthMprice,")
		.append("sum(cencelnextmonth+returnnextmonth) returncencelnextmonth,")
		.append("sum(cencelnextmonthprice+returnnextmonthprice) returncencelnextmonthprice,")
		.append("sum(cencelnextmonthMprice+returnnextmonthMprice) returncencelnextmonthMprice,")
		.append("sum(departinvoisthismonth),sum(departinvoisthismonthprice),sum(departinvoisthismonthMprice),")		
		.append("sum(departinvoislastmonth),sum(departinvoislastmonthprice),sum(departinvoislastmonthMprice),")
		.append("sum(nextmonthdepart),sum(nextmonthdepartprice),sum(nextmonthdepartMprice),")		
		.append("sum(missdepart+missdepart_return) missdepart,")
		.append("sum(missdepartprice+missdepartprice_return) missdepartprice,")
		.append("sum(missdepartMprice+missdepartMprice_return) missdepartMprice ")				
		.append(" from ( ")
				.append(" select routename,sellnum,sellmoney,moreprice,")
				.append("nextmonthdepart,nextmonthdepartprice,nextmonthdepartMprice,")
				.append("missdepart,missdepartprice,missdepartMprice,")
				.append("missdepart_return ,missdepartprice_return,missdepartMprice_return,")
				.append("returnthismonth,returnthismonthprice,returnthismonthMprice,")
				.append("returnlastmonth,returnlastmonthprice,returnlastmonthMprice,")
				.append("returnnextmonth,returnnextmonthprice,returnnextmonthMprice,")
				.append("cencelthismonth,cencelthismonthprice,cencelthismonthMprice,")
				.append("cencellastmonth,cencellastmonthprice,cencellastmonthMprice,")
				.append("cencelnextmonth,cencelnextmonthprice,cencelnextmonthMprice,")		
				.append("departinvoisthismonth,departinvoisthismonthprice,departinvoisthismonthMprice,")
				.append("departinvoislastmonth,departinvoislastmonthprice,departinvoislastmonthMprice")
				.append(" from( ")
				//本月所有售票
				.append(" select r.name as routename,count(ts.id) sellnum,sum(ts.price) sellmoney,sum(ts.moreprice) moreprice,")
				.append("0 nextmonthdepart,0 nextmonthdepartprice,0 nextmonthdepartMprice,")
				.append("0 missdepart,0 missdepartprice,0 missdepartMprice,")
				.append("0 missdepart_return ,0 missdepartprice_return ,0 missdepartMprice_return,")
				.append("0 returnthismonth,0 returnthismonthprice,0 returnthismonthMprice,")
				.append("0 returnlastmonth,0 returnlastmonthprice,0 returnlastmonthMprice,")
				.append("0 returnnextmonth,0 returnnextmonthprice,0 returnnextmonthMprice,")
				.append("0 cencelthismonth,0 cencelthismonthprice,0 cencelthismonthMprice,")
				.append("0 cencellastmonth,0 cencellastmonthprice,0 cencellastmonthMprice,")
				.append("0 cencelnextmonth,0 cencelnextmonthprice,0 cencelnextmonthMprice,")
				.append("0 departinvoisthismonth,0 departinvoisthismonthprice,0 departinvoisthismonthMprice,")
				.append("0 departinvoislastmonth,0 departinvoislastmonthprice,0 departinvoislastmonthMprice")
				.append(" from schedule s, route r, ticketsell ts")
				.append(" where  ts.scheduleid = s.id  and s.routeid = r.id")
				.append(" and r.isactive = 1  and ts.selltime between :thismonthbegin and :thismonthend and s.orgid in "+orgid);
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}
				sql.append(" group by r.name union all ")
				//下月预售票
				.append(" select r.name as routename,0 sellnum,0 sellmoney,0 moreprice,")
				.append("count(ts.id) nextmonthdepart,")
				.append("sum(ts.price) nextmonthdepartprice,")
				.append("sum(ts.moreprice) nextmonthdepartMprice,")
				.append("0 missdepart,0 missdepartprice,0 missdepartMprice,")
				.append("0 missdepart_return,0 missdepartprice_return ,0 missdepartMprice_return,")
				.append("0 returnthismonth,0 returnthismonthprice,0 returnthismonthMprice,")
				.append("0 returnlastmonth,0 returnlastmonthprice,0 returnlastmonthMprice,")
				.append("0 returnnextmonth,0 returnnextmonthprice,0 returnnextmonthMprice,")
				.append("0 cencelthismonth,0 cencelthismonthprice,0 cencelthismonthMprice,")
				.append("0 cencellastmonth,0 cencellastmonthprice,0 cencellastmonthMprice,")
				.append("0 cencelnextmonth,0 cencelnextmonthprice,0 cencelnextmonthMprice,")
				.append("0 departinvoisthismonth,0 departinvoisthismonthprice,0 departinvoisthismonthMprice,")
				.append("0 departinvoislastmonth,0 departinvoislastmonthprice,0 departinvoislastmonthMprice")
				.append(" from schedule s, route r, ticketsell ts where ts.ticketstatus = '0' and ts.scheduleid = s.id  and s.routeid = r.id")
				.append(" and ts.departdate between :nextmonthbegin and :nextmonthend")
				.append(" and r.isactive = 1  and ts.selltime between :thismonthbegin and :thismonthend and s.orgid in "+orgid);
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}
				sql.append(" group by r.name union all ")
				//本月漏乘票 
				.append(" select r.name as routename,0 sellnum,0 sellmoney,0 moreprice,")
				.append("0 nextmonthdepart,0 nextmonthdepartprice,0 nextmonthdepartMprice,")
				.append("count(ts.id) missdepart,")
				.append("sum(ts.price) missdepartprice,")
				.append("sum(ts.moreprice) missdepartMprice,")
				.append("0 missdepart_return,0 missdepartprice_return ,0 missdepartMprice_return,")
				.append("0 returnthismonth,0 returnthismonthprice,0 returnthismonthMprice,")
				.append("0 returnlastmonth,0 returnlastmonthprice,0 returnlastmonthMprice,")
				.append("0 returnnextmonth,0 returnnextmonthprice,0 returnnextmonthMprice,")
				.append("0 cencelthismonth,0 cencelthismonthprice,0 cencelthismonthMprice,")
				.append("0 cencellastmonth,0 cencellastmonthprice,0 cencellastmonthMprice,")
				.append("0 cencelnextmonth,0 cencelnextmonthprice,0 cencelnextmonthMprice,")
				.append("0 departinvoisthismonth,0 departinvoisthismonthprice,0 departinvoisthismonthMprice,")
				.append("0 departinvoislastmonth,0 departinvoislastmonthprice,0 departinvoislastmonthMprice")
				.append(" from schedule s, route r, ticketsell ts where ts.ticketstatus = '0' and ts.scheduleid = s.id  and s.routeid = r.id")
				.append(" and ts.departdate between :thismonthbegin and :thismonthend and ts.isdepartinvoices = '0' ")
				.append(" and r.isactive = 1 and s.orgid in "+orgid);
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}
				sql.append(" group by r.name union all ")				
				//本月漏乘下月退票，计入漏乘数量
				.append(" select  r.name as routename,0 sellnum,0 sellmoney,0 morepricecount,")
				.append("0 nextmonthdepart,0 nextmonthdepartprice,0 nextmonthdepartMprice,")
				.append("0 missdepart, 0 missdepartprice,0 missdepartMprice,")
				.append("count(ts.id) missdepart_return,sum(ts.price) missdepartprice_return,sum(ts.moreprice) missdepartMprice_return,")
				.append("0 returnthismonth,0 returnthismonthprice,0 returnthismonthMprice,")
				.append("0 returnlastmonth,0 returnlastmonthprice,0 returnlastmonthMprice,")
				.append("0 returnnextmonth,0 returnnextmonthprice,0 returnnextmonthMprice,")
				.append("0 cencelthismonth,0 cencelthismonthprice,0 cencelthismonthMprice,")
				.append("0 cencellastmonth,0 cencellastmonthprice,0 cencellastmonthMprice,")
				.append("0 cencelnextmonth,0 cencelnextmonthprice,0 cencelnextmonthMprice,")
				.append("0 departinvoisthismonth,0 departinvoisthismonthprice,0 departinvoisthismonthMprice,")
				.append("0 departinvoislastmonth,0 departinvoislastmonthprice,0 departinvoislastmonthMprice")
				.append(" from schedule s, route r,ticketsell ts,ticketreturn tr")
				.append(" where tr.sellid = ts.id and tr.returntime between :nextmonthbegin and :nextmonthend")
				.append(" and ts.departdate between :thismonthbegin and :thismonthend")
				.append(" and ts.scheduleid = s.id  and s.routeid = r.id and r.isactive = 1 and s.orgid in "+orgid);
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}
				sql.append(" group by r.name union all ")	
				//本月废票
				.append(" select r.name as routename,0 sellnum,0 sellmoney,0 moreprice,")
				.append("0 nextmonthdepart,0 nextmonthdepartprice,0 nextmonthdepartMprice, 0 missdepart, 0 missdepartprice,0 missdepartMprice,")
				.append("0 missdepart_return,0 missdepartprice_return ,0 missdepartMprice_return,")
				.append("0 returnthismonth,0 returnthismonthprice,0 returnthismonthMprice,")
				.append("0 returnlastmonth,0 returnlastmonthprice,0 returnlastmonthMprice,")
				.append("0 returnnextmonth,0 returnnextmonthprice,0 returnnextmonthMprice,")	
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then 1 else 0 end) as cencelthismonth,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then ts.price else 0 end) as cencelthismonthprice,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then ts.moreprice else 0 end) as cencelthismonthMprice,")	
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then 1 else 0 end) as cencellastmonth,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then ts.price else 0 end) as cencellastmonthprice,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then ts.moreprice else 0 end) as cencellastmonthMprice,")
				.append("sum(case when ts.selltime between :nextmonthbegin and :nextmonthend then 1 else 0 end) as cencelnextmonth,")
				.append("sum(case when ts.selltime between :nextmonthbegin and :nextmonthend then ts.price else 0 end) as cencelnextmonthprice,")
				.append("sum(case when ts.selltime between :nextmonthbegin and :nextmonthend then ts.moreprice else 0 end) as cencelnextmonthMprice,")
				.append("0 departinvoisthismonth,0 departinvoisthismonthprice,0 departinvoisthismonthMprice,")
				.append("0 departinvoislastmonth,0 departinvoislastmonthprice,0 departinvoislastmonthMprice")
				.append(" from schedule s,route r,ticketsell ts,ticketcancel tc")
				.append(" where ts.id = tc.sellid and ts.ticketstatus='2'")
				.append(" and tc.canceltime between :thismonthbegin and :thismonthend ")
				.append(" and ts.scheduleid= s.id and s.routeid= r.id and r.isactive=1 and s.orgid in "+orgid);
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}
				sql.append(" group by r.name union all ")
				//--本月退票
				.append(" select r.name as routename ,0 sellnum,0 sellmoney,0 moreprice,")
				.append("0 nextmonthdepart,0 nextmonthdepartprice,0 nextmonthdepartMprice, 0 missdepart, 0 missdepartprice,0 missdepartMprice,")
				.append("0 missdepart_return,0 missdepartprice_return ,0 missdepartMprice_return,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then 1 else 0 end) as returnthismonth,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then ts.price else 0 end) as returnthismonthprice,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then ts.moreprice else 0 end) as returnthismonthMprice,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then 1 else 0 end) as returnlastmonth,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then ts.price else 0 end) as returnlastmonthprice,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then ts.moreprice else 0 end) as returnlastmonthMprice,")
				.append("sum(case when ts.selltime between :nextmonthbegin and :nextmonthend then 1 else 0 end) as returnnextmonth,")
				.append("sum(case when ts.selltime between :nextmonthbegin and :nextmonthend then ts.price else 0 end) as returnnextmonthprice,")
				.append("sum(case when ts.selltime between :nextmonthbegin and :nextmonthend then ts.moreprice else 0 end) as returnnextmonthMprice,")
				.append("0 cencelthismonth,0 cencelthismonthprice,0 cencelthismonthMprice,")
				.append("0 cencellastmonth,0 cencellastmonthprice,0 cencellastmonthMprice,")
				.append("0 cencelnextmonth,0 cencelnextmonthprice,0 cencelnextmonthMprice,")
				.append("0 departinvoisthismonth,0 departinvoisthismonthprice,0 departinvoisthismonthMprice,")
				.append("0 departinvoislastmonth,0 departinvoislastmonthprice,0 departinvoislastmonthMprice")
				.append(" from schedule s,route r,ticketsell ts,ticketreturn tr")
				.append(" where ts.id = tr.sellid and ts.ticketstatus='1'") 
				.append(" and tr.returntime between :thismonthbegin and :thismonthend ")
				.append(" and ts.scheduleid= s.id and s.routeid= r.id and r.isactive=1 and s.orgid in "+orgid);
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}
				sql.append(" group by r.name union all ")
				//--开运量
				.append(" select r.name routename,0 sellnum,0 sellmoney,0 moreprice,")
				.append("0 nextmonthdepart,0 nextmonthdepartprice,0 nextmonthdepartMprice, 0 missdepart, 0 missdepartprice,0 missdepartMprice,")
				.append("0 missdepart_return,0 missdepartprice_return ,0 missdepartMprice_return,")		
				.append("0 returnthismonth,0 returnthismonthprice,0 returnthismonthMprice,")
				.append("0 returnlastmonth,0 returnlastmonthprice,0 returnlastmonthMprice,")
				.append("0 returnnextmonth,0 returnnextmonthprice,0 returnnextmonthMprice,")	
				.append("0 cencelthismonth,0 cencelthismonthprice,0 cencelthismonthMprice,")
				.append("0 cencellastmonth,0 cencellastmonthprice,0 cencellastmonthMprice,")
				.append("0 cencelnextmonth,0 cencelnextmonthprice,0 cencelnextmonthMprice,")		
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then 1 else 0 end) as departinvoisthismonth,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then ts.price else 0 end) as departinvoisthismonthprice,")
				.append("sum(case when ts.selltime between :thismonthbegin and :thismonthend then ts.moreprice else 0 end) as departinvoisthismonthMprice,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then 1 else 0 end) as departinvoislastmonth,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then ts.price else 0 end) as departinvoislastmonthprice,")
				.append("sum(case when ts.selltime between :lastmonthbegin and :lastmonthend then ts.moreprice else 0 end) as departinvoislastmonthMprice")
				.append(" from schedule s,route r,ticketsell ts , departinvoices dv ,vehicle v")
				.append(" where ts.departinvoicesid = dv.id and ts.isdepartinvoices = 1 and ts.ticketstatus='0' and dv.vehicleid = v.id")
				.append(" and dv.departdate between :thismonthbegin and :thismonthend  and dv.status<>1 ")
				.append(" and ts.scheduleid= s.id and s.routeid= r.id and r.isactive=1 and s.orgid in "+orgid);
				if( checkstationid!=null ){
					sql.append(" and dv.printorgid in "+ checkstationid);
				}	
				if(routeid!=null && routeid != 0){
					sql.append(" and r.id = "+ routeid);
				}	
				if( unitid!=null && unitid!=0 ){
					sql.append("  and v.unitid = "+ unitid);
				}
				sql.append(" group by r.name ) ) group by routename ");				
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("thismonthbegin", thismonthbegin);
		query.setParameter("thismonthend", thismonthend);
		query.setParameter("lastmonthbegin", lastmonthbegin);
		query.setParameter("lastmonthend", lastmonthend);
		query.setParameter("nextmonthbegin", nextmonthbegin);
		query.setParameter("nextmonthend", nextmonthend);
		return query.getResultList();			
	}

	public List<Object> qryStationUnitBalance(String orgid, Date startdate, Date enddate, long vehicleid, Long unitid,
			String sign) {
		StringBuffer sql = new StringBuffer();
		if ("1".equals(sign)) {
			sql.append("SELECT unitname,'' vehicleno, sum(departinvoicesnum), sum(ticketnum), sum(balanceamount), sum(stationfee), sum(agentfee), sum(cleanfee), sum(advfee), ")
					.append(" sum(otherfee1), sum(otherfee2), sum(truebalanceamount) from ( ")
					.append(" SELECT unitname, vehicleno, sum(departinvoicesnum) departinvoicesnum, sum(ticketnum) ticketnum, sum(balanceamount) balanceamount, ")
					.append(" sum(stationfee) stationfee, sum(agentfee) agentfee, sum(cleanfee) cleanfee, sum(advfee) advfee, sum(otherfee1) otherfee1, sum(otherfee2) otherfee2, ")
					.append(" (sum(balanceamount) - sum(stationfee) - sum(agentfee) - sum(cleanfee) - sum(advfee) - sum(otherfee1) - sum(otherfee2)) as truebalanceamount ")
					.append(" from (SELECT u.name unitname,v.vehicleno, count(d.departinvoicesno) departinvoicesnum, sum(d.ticketnum) ticketnum, sum(d.balanceamount) balanceamount, ")
					.append(" sum(d.ticketnum * case when fst.stationfee is null then 0 else fst.stationfee end) stationfee, sum(d.balanceamount * case when fst.agentfeerate is null then 0 else fst.agentfeerate end) agentfee, ")
					.append(" avg(case when fst.cleanfee is null then 0 else fst.cleanfee end) * count(d.departinvoicesno) cleanfee, 0 as advfee, 0 as otherfee1, 0 as otherfee2 ")
					.append(" FROM departinvoices d left join vehicle v on v.id = d.vehicleid left join unit u on u.id = v.unitid ")
					.append(" left join Feestandardstationagent fst on fst.vehicleid = v.id  ")
					.append(" where d.printorgid in " + orgid +" and d.status <> '1'  and d.departdate between :startdate and :enddate + 0.99999 ");

			if (unitid != 0 && unitid != null) {
				sql.append(" and u.id = " + unitid);
			}
			if (vehicleid != 0) {
				sql.append(" and v.id = " + vehicleid);
			}
			sql.append(" group by u.name,v.vehicleno union all ")
					.append(" SELECT u.name unitname,v.vehicleno, 0 as departinvoicesnum, 0 as ticketnum, 0 as balanceamount, 0 as stationfee, 0 as agentfee, 0 as cleanfee, ")
					.append(" sum(fst.advfee), sum(fst.otherfee) otherfee1, sum(case when af.recefee is null then 0 else af.recefee end) otherfee2 ")
					.append(" FROM vehicle v left join Feestandardstationagent fst on fst.vehicleid = v.id ")
					.append(" left join Actualfee af on af.vehicleid = v.id  ")
					.append(" and (af.feefromdate between :startdate and :enddate + 0.99999 ")
					.append(" or af.feetodate between :startdate and :enddate + 0.99999) ")
					.append("  , unit u where u.id = v.unitid and v.status = '0' and v.isactive = 1 ")
					.append(" and v.orgid in " + orgid);

			if (unitid != 0 && unitid != null) {
				sql.append(" and u.id = " + unitid);
			}
			if (vehicleid != 0) {
				sql.append(" and v.id = " + vehicleid);
			}
			sql.append(" group by u.name,v.vehicleno)   group by unitname,vehicleno) where balanceamount<>0 group by unitname ");

		} else if ("2".equals(sign)) {
			sql.append(
					"SELECT unitname, vehicleno, departinvoicesnum, ticketnum, balanceamount, stationfee, agentfee, cleanfee, advfee, ")
					.append(" otherfee1, otherfee2, truebalanceamount from ( ")
					.append(" SELECT unitname, vehicleno, sum(departinvoicesnum) departinvoicesnum, sum(ticketnum) ticketnum, sum(balanceamount) balanceamount, sum(stationfee) stationfee, ")
					.append(" sum(agentfee) agentfee, sum(cleanfee) cleanfee, sum(advfee) advfee, sum(otherfee1) otherfee1, sum(otherfee2) otherfee2, ")
					.append(" (sum(balanceamount) - sum(stationfee) - sum(agentfee) - sum(cleanfee) - sum(advfee) - sum(otherfee1) - sum(otherfee2)) as truebalanceamount ")
					.append(" from (SELECT u.name unitname, v.vehicleno, count(d.departinvoicesno) departinvoicesnum, sum(d.ticketnum) ticketnum, ")
					.append(" sum(d.balanceamount) balanceamount, sum(d.ticketnum * case when fst.stationfee is null then 0 else fst.stationfee end) stationfee, sum(d.balanceamount * case when fst.agentfeerate is null then 0 else fst.agentfeerate end) agentfee, ")
					.append(" avg(case when fst.cleanfee is null then 0 else fst.cleanfee end) * count(d.departinvoicesno) cleanfee, 0 as advfee, 0 as otherfee1, 0 as otherfee2 ")
					.append(" FROM departinvoices d left join vehicle v on v.id = d.vehicleid left join unit u on u.id = v.unitid ")
					.append(" left join Feestandardstationagent fst on fst.vehicleid = v.id   ")
					.append(" where d.printorgid in " + orgid
							+ " and d.status <> '1' and d.departdate between :startdate and :enddate + 0.99999 ");
			if (unitid != 0 && unitid != null) {
				sql.append(" and u.id = " + unitid);
			}
			if (vehicleid != 0) {
				sql.append(" and v.id = " + vehicleid);
			}
			sql.append(" group by u.name, v.vehicleno  union all ")
					.append(" SELECT u.name unitname, v.vehicleno, 0 as departinvoicesnum, 0 as ticketnum, 0 as balanceamount, 0 as stationfee, ")
					.append(" 0 as agentfee, 0 as cleanfee, sum(fst.advfee), sum(fst.otherfee) otherfee1, ")
					.append(" sum(case when af.recefee is null then 0 else af.recefee end) otherfee2 ")
					.append(" FROM vehicle v left join Feestandardstationagent fst on fst.vehicleid = v.id ")
					.append(" left join Actualfee af on af.vehicleid = v.id ")
					.append(" and (af.feefromdate between :startdate and :enddate + 0.99999 ")
					.append(" or af.feetodate between :startdate and :enddate + 0.99999) ")
					.append(" , unit u where u.id = v.unitid and v.status = '0' and v.isactive = 1 and v.orgid in " + orgid);
			if (unitid != 0 && unitid != null) {
				sql.append(" and u.id = " + unitid);
			}
			if (vehicleid != 0) {
				sql.append(" and v.id = " + vehicleid);
			}
			sql.append(" group by u.name,v.vehicleno) group by unitname,vehicleno) where balanceamount<>0 ");
		} else {
			return null;
		}

		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}		
	
	
}
