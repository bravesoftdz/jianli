package cn.nova.bus.report.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import models.ActionNode;
import util.Appvar;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * 
 * <b>类描述：财务报表DAO</b><br/>
 * <b>类名称：</b>FinancialReportService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>主要模块：班线结算统计表:scheduleRouteBalanceRpt。
 * 				各站互售互退营收汇总表:eachTickeIncomeSumRpt 
 * 				财务收支平衡表:FinancialBalanceRpt
 * 				财物收支月平衡表:FinancialBalanceMonthRpt
 * 				运量单运量台账:DepartInvoincesRpt
 * 				客运收入、支出平衡表-赣州FinancialBalanceGZ</b><br/>
 * <b>1修改内容： 添加财物收支月平衡表：手续费小计</b><br/> 
 * <b>修改时间： 2013-03-21</b><br/>
 * <b>2修改内容： 添加运量单运量台账</b><br/> 
 * <b>修改时间： 2013-05-20</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class FinancialReportDao extends EntityManagerDaoSurport {		
	
	private ParameterService parameterService = new ParameterServiceImpl();
	/**
	 * 根据发班id查询发班code
	 * @param Scheduleid
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	public String queryScheduleCode(Long Scheduleid) {
		StringBuilder sql = new StringBuilder(
				" select t.code from Schedule t  where t.id= :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", Scheduleid);
		return (String) query.getSingleResult();
	}
	
	/**
	 * 班线结算统计表
	 * 
	 * @param
	 * @return
	 */
	public List<Object> scheduleRouteBalanceRpt(String orgids, Date startdate,
		Date enddate, Long vehicleid,Long stationid) {
		String startmm;
		String endmm ;
		int startday,endday;
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	    //起始日期的月份
	    startmm = sdf.format(startdate).substring(4,6);
	    //结束日期的月份
	    endmm = sdf.format(enddate).substring(4,6);
	    //查询条件选择的开始那天
	    startday = Integer.parseInt(sdf.format(startdate).substring(6));
	    //结束日期
	    endday = Integer.parseInt(sdf.format(enddate).substring(6));
	    //获得开始日期的月份最后一天
	    Calendar   cDay1   =   Calendar.getInstance();   
        cDay1.setTime(startdate);   
        final int lastDay = cDay1.getActualMaximum(Calendar.DAY_OF_MONTH);   
        Date lastDate = cDay1.getTime();   
        lastDate.setDate(lastDay);
        //当月最后一天
        int lastday = Integer.parseInt(sdf.format(lastDate).substring(6));
        //动态生成列 SQL：dateSql
        StringBuilder dateSql = new StringBuilder();
        for(int i=1; i<startday;i++){
        	dateSql.append(" ,'' as date"+i);
        }
        //从开始日期遍历到当月最后一天
        for(int i=startday;i<=lastday;i++){
        	String temp0 = "";
        	if(i<10) temp0="0";			
        	dateSql.append(" ,sum(case when to_char(d.departdate,'mmdd') = '"+startmm+temp0+i+"' then dt.ticketnum  end) as date"+i);
        	//如果日期在同一月份，则结束日期就是选择的日期
        	if(startmm.equals(endmm) && i==endday){
        		if(endday<31){
        			for(int J=endday; J<=31;J++){
        				dateSql.append(" ,'' as date"+J);
        			}
        		}
        		break;
        	}			
        }		
        //如果不在同一月份，先遍历到当月最后一天
        if(!startmm.equals(endmm)){
        	if(lastday<31){
        		for(int J=lastday+1; J<=31;J++){
        			dateSql.append(" ,'' as date"+J);
        		}
        	}
        	//再从第一天开始遍历到选择的那天结束
        	for(int i=1;i<=endday;i++){
        		String temp0="";
        		if(i<10) temp0="0";
        		dateSql.append(" ,sum(case when to_char(d.departdate,'mmdd') = '"+endmm+temp0+i+"' then dt.ticketnum  end) as Bdate"+i);
        	}
        	if(endday<31){
        		for(int i=endday+1; i<=31;i++){
        			dateSql.append(" ,'' as Bdate"+i);
        		}
        	}
        }
		StringBuilder sql = new StringBuilder(
				" select es.name endname,tt.name ticketypename,dt.price,case when tt.code in ('B','X') then dt.distance/2 else dt.distance end distance,")
		.append(" sum(case when tt.code in ('B','X') then dt.distance/2 else dt.distance end * dt.ticketnum) peopledistance,")
		.append(" sum(dt.ticketnum) ticketnum,(sum(dt.ticketnum) *dt.price) allprice");	
		//动态生成列 SQL
		sql.append(dateSql.toString());
		sql.append(" from departinvoices d,")
		.append(" departinvoicesdetail dt,")
		.append(" route r,")
		.append(" station es,")
		.append(" vehicle v,")
		.append(" schedule s,tickettype tt")
		.append(" where d.scheduleid = s.id")
		.append(" and s.routeid = r.id")
		.append(" and dt.reachstationid = es.id")
		.append(" and d.id = dt.departinvoicesid")
		.append(" and d.departdate between :startdate and :enddate")
		.append(" and d.status <> '1' and s.orgid in "+orgids)
		.append(" and d.vehicleid = v.id  ")
		.append(" and tt.code = dt.tickettype");
		if(vehicleid!=null){
			sql.append(" and v.id = "+vehicleid);
		}
		if(stationid!=null){
			sql.append(" and es.id = "+stationid);
		}
		sql.append(" group by es.name,tt.name,dt.price,case when tt.code in ('B','X') then dt.distance/2 else dt.distance end ");
		//updateby tianhb 20170328--begin 查询结果增加手工单的数据统计。来源为货物的手工单数据，统计时人数为 0 
		sql.append(" UNION ALL");
		sql.append(" SELECT es.name endname,tt.name ticketypename,dt.price,dt.distance distance,")
		.append(" SUM(dt.distance * dt.ticketnum) peopledistance,")
		.append(" SUM(decode(d.datafrom,8,0,dt.ticketnum)) ticketnum,SUM(d.totalmoney) allprice");	
		//动态生成列 SQL
		sql.append(dateSql.toString());
		sql.append(" FROM departinvoicesother d,")
		.append(" departinvoicesotherdetail dt,")
		.append(" ROUTE r,")
		.append(" STATION es,")
		.append(" VEHICLE v,")
		.append(" SCHEDULE s,tickettype tt")
		.append(" WHERE d.scheduleid = s.id")
		.append(" AND s.routeid = r.id")
		.append(" AND dt.reachstationid = es.id")
		.append(" AND d.id = dt.departinvoicesotherid")
		.append(" AND d.departdate between :startdate and :enddate")
		.append(" AND d.status <> '1' and s.orgid in "+orgids)
		.append(" AND d.vehicleid = v.id  ")
		.append(" AND tt.id = dt.tickettypeid")
		//DATAFROM(0:茅坪,1:广场,2:西城,3:白浪,4:保卫,5:郧西,6:火车站,7:稽查,8:货物,9:包车,10:手工,11:现金)
		.append("  ");//AND d.datafrom in (8,10)
		if(vehicleid!=null){
			sql.append(" and v.id = " + vehicleid);
		}
		if(stationid!=null){
			sql.append(" and es.id = " + stationid);
		}
		sql.append(" GROUP BY es.name,tt.name,dt.price,dt.distance");
		//updateby tianhb 20170328--end 查询结果增加手工单的数据统计。来源为货物的手工单数据，统计时人数为 0
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();			
	}	
	
	
	/**
	 * 各站互售互退营收汇总表
	 * 
	 * @param
	 * @return
	 */
	public List<Object> eachTickeIncomeSumRpt(List<PropertyFilter> propertyFilterList){
		//按班次所属机构统计异站票(20140310黄山版本，用以下sql 查询没有问题)
		StringBuilder sql = new StringBuilder(
				"select decode(grouping(sellorg.name ) + grouping(scheduleorg.name),1,'小计',")
		.append("2,'合计',sellorg.name) sellorg,")
		.append("decode(grouping(sellorg.name) + grouping(scheduleorg.name),1,'',")
		.append("2,'',scheduleorg.name) scheduleorg,sum(ts.sellnum) as sellnum,")
		.append("sum(ts.totalprice) sellprice,sum(ts.returnnum) returnnum,")
		.append("sum(ts.returnprice) returnprice,sum(ts.returnfee) returnfee,")
		.append("sum(ts.cancelnum),sum(ts.cancelmoeny),sum(ts.sellnum-ts.returnnum-ts.cancelnum) allnum,")
		.append("sum(ts.totalprice -ts.returnprice + ts.returnfee -ts.cancelmoeny) allprice")
		.append(" from Ticketsellbysalerday ts, Organization sellorg,Organization scheduleorg")
		.append(" where ts.orgid = sellorg.id and ts.scheduleorgid = scheduleorg.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" group by Rollup(sellorg.name,scheduleorg.name) ");
		
		
		//按不同发车点统计异站票（2011-07至20140309用以下脚本，南昌地区7个站核对没有问题）
//		StringBuilder sql= new StringBuilder(
//				"select decode(grouping(sellorg) + grouping(scheduleorg),1,'小计', 2,'合计',sellorg) sellorg,")
//		.append("decode(grouping(sellorg) + grouping(scheduleorg),1,'', 2,'',scheduleorg) scheduleorg,")
//		.append("sum(sellnum),sum(sellprice),sum(returnnum),sum(returnprice),sum(charges) returnfee,")
//		.append("sum(canclenum),sum(cancleprice),sum(sellnum-returnnum-canclenum) allnum,")
//		.append("sum(sellprice-returnprice-cancleprice+charges) allprice")
//		.append(" from(")
//		.append(" select sellorg.name sellorg,scheduleorg.name scheduleorg,")
//		.append("count(ts.id) sellnum,sum(ts.price) sellprice,")
//		.append("0 returnnum,0 returnprice,0 charges,")
//		.append("sum( case when  ts.ticketstatus='2' then 1 else 0 end) canclenum,")
//		.append("sum( case when  ts.ticketstatus='2' then ts.price else 0 end) cancleprice")
//		.append(" from ticketsell ts ,station dpt,organization sellorg,organization scheduleorg")
//		.append(" where ts.departstationid= dpt.id and dpt.id = scheduleorg.stationid and dpt.isdepart=1")
//		.append(" and ts.orgid=sellorg.id ")
//		.append(PropertyFilter.toJpql(propertyFilterList, true))
//		.append(" group by sellorg.name,scheduleorg.name")
//		.append(" union all")
//		.append(" select sellorg.name sellorg,scheduleorg.name scheduleorg,")
//		.append("0 sellnum,0 sellprice,")
//		.append("count(tr.id) returnnum,sum(tr.ticketprice) returnprice,")
//		.append("sum(tr.charges) charges,0 canclenum,0 cancleprice")
//		.append(" from ticketsell ts ,ticketreturn tr, station dpt,organization sellorg,organization scheduleorg")
//		.append(" where ts.departstationid= dpt.id and dpt.id = scheduleorg.stationid and dpt.isdepart=1")
//		.append(" and ts.orgid=sellorg.id  and ts.id=tr.sellid ")
//		.append(PropertyFilter.toJpql(propertyFilterList, true))
//		.append(" group by sellorg.name,scheduleorg.name) a")
//		.append(" group by Rollup(a.sellorg,a.scheduleorg) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();			
	}
	
	/**
	 * 财务收支平衡表
	 * 
	 * @param
	 * @return
	 */
	public List<Object> FinancialBalanceRpt (String orgid,Date startdate,Date enddate){
		StringBuilder sql = new StringBuilder(
				"select tb.opdate,scheduleorg.name orgname,sum(tb.daysellpassnum),sum(tb.daysellpassprice),")
		.append("sum(tb.dayselldaynum),sum(tb.dayselldayprice),sum(tb.daysellprenum),sum(tb.daysellpreprice),")
		.append("sum(tb.daysellpassdayreturnnum),sum(tb.daysellpassdayreturnprice),sum(tb.dayselldayreturnnum),")
		.append("sum(tb.dayselldayreturnprice),sum(tb.daysellpredayreturnnum),sum(tb.daysellpredayreturnprice),")
		.append("sum(tb.daysellprereturnnum),sum(tb.daysellprereturnprice),sum(tb.daysellpassdaycancelnum),")
		.append("sum(tb.daysellpassdaycanceprice),sum(tb.dayselldaycancelnum),sum(tb.dayselldaycanceprice),")
		.append("sum(tb.daysellpredaycancelnum),sum(tb.daysellpredaycanceprice),sum(tb.daysellprecancelnum),")
		.append("sum(tb.daysellprecancelprice),sum(tb.daysellnum),sum(tb.daysellprice),sum(tb.passselldaynum),")
		.append("sum(tb.passselldayprice),sum(tb.perselldaynum),sum(tb.perselldayprice),sum(tb.passreturndaynum),")
		.append("sum(tb.dayreturnnum),sum(tb.dayreturnprice),sum(tb.passreturndayprice),sum(tb.passsellpredayreturnnum),")
		.append("sum(tb.passsellpredayreturnprice),sum(tb.passselldaycancelnum),sum(tb.passselldaycancelprice),") 
		.append("sum(tb.passsellpredaycancelnum),sum(tb.passsellpredaycancelprice),") 
		.append("sum(tb.daycancelnum),sum(tb.daycancelprice),sum(tb.departnum),sum(tb.departprice),sum(tb.missnum),")
		.append("sum(tb.missprice),sum(tb.incomenum),sum(tb.incomeprice),sum(dayselldayprereturnnum),")
		.append(" sum(dayselldayprereturnprice),sum(dayselldayprecancenum),sum(dayselldayprecanceprice)")
		.append(" from ticketsellbalance tb, organization scheduleorg")
		.append(" where tb.scheduleorgid = scheduleorg.id ")
		.append(" and scheduleorg.id in "+orgid)
		.append(" and tb.opdate between :startdate and :enddate group by tb.opdate,scheduleorg.name order by tb.opdate");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
	/**
	 * 财务收支月平衡表
	 * 
	 * @param
	 * @return
	 */
	public List<Object> FinancialBalanceMonthRpt (String orgid,Date startdate,Date enddate){
		StringBuilder sql = new StringBuilder(
				"select TO_CHAR(tb.opdate,'YYYY-MM'),sellorg.name orgname,sum(tb.daysellpassnum),sum(tb.daysellpassprice),")
		.append("sum(tb.dayselldaynum),sum(tb.dayselldayprice),sum(tb.daysellprenum),sum(tb.daysellpreprice),")
		.append("sum(tb.daysellpassdayreturnnum),sum(tb.daysellpassdayreturnprice),sum(tb.dayselldayreturnnum),")
		.append("sum(tb.dayselldayreturnprice),sum(tb.daysellpredayreturnnum),sum(tb.daysellpredayreturnprice),")
		.append("sum(tb.daysellprereturnnum),sum(tb.daysellprereturnprice),sum(tb.daysellpassdaycancelnum),")
		.append("sum(tb.daysellpassdaycanceprice),sum(tb.dayselldaycancelnum),sum(tb.dayselldaycanceprice),")
		.append("sum(tb.daysellpredaycancelnum),sum(tb.daysellpredaycanceprice),sum(tb.daysellprecancelnum),")
		.append("sum(tb.daysellprecancelprice),sum(tb.daysellnum),sum(tb.daysellprice),sum(tb.passselldaynum),")
		.append("sum(tb.passselldayprice),sum(tb.perselldaynum),sum(tb.perselldayprice),sum(tb.passreturndaynum),")
		.append("sum(tb.dayreturnnum),sum(tb.dayreturnprice),sum(tb.passreturndayprice),sum(tb.passsellpredayreturnnum),")
		.append("sum(tb.passsellpredayreturnprice),sum(tb.passselldaycancelnum),sum(tb.passselldaycancelprice),") 
		.append("sum(tb.passsellpredaycancelnum),sum(tb.passsellpredaycancelprice),") 
		.append("sum(tb.daycancelnum),sum(tb.daycancelprice),sum(tb.departnum),sum(tb.departprice),sum(tb.missnum),")
		.append("sum(tb.missprice),sum(tb.incomenum),sum(tb.incomeprice),sum(dayselldayprereturnnum),")
		.append(" sum(dayselldayprereturnprice),sum(dayselldayprecancenum),sum(dayselldayprecanceprice),")
		.append("sum(passsellpassdaycencelnum), sum(passsellpassdaycencelprice),")
		.append(" sum(passsellpassdayreturnnum),sum(passsellpassdayreturnprice),")
		.append(" sum(tb.moneypayable),sum(tb.returnhandcharge),sum(tb.servicefee),")
		.append("sum(tb.bookservicefee),sum(tb.changeservicefee),sum(sellpeople),")
		.append("sum(sellothernum),sum(sellotherprice),sum(sellotherreturnnum),")
        .append("sum(sellotherreturnprice),sum(selllocalnum),sum(selllocalprice),")
        .append("sum(selllocalreturnnum),sum(selllocalreturnprice),")
        .append("sum(tb.returnhandcharge+tb.servicefee+tb.bookservicefee+tb.changeservicefee) totalfee,")
        .append("sum(tb.moneypayable)-sum(tb.returnhandcharge+tb.servicefee+tb.bookservicefee+tb.changeservicefee) a1,")
        .append("sum(sellotherprice)-sum(sellotherreturnprice) a2,")//新添加的这些a``,用于报表工具的显示
        .append("sum(selllocalprice)+sum(selllocalreturnprice) a3,")
        .append("sum(tb.passselldayprice)+sum(tb.passselldaycancelprice)+sum(tb.passreturndayprice) a6,")
        .append("sum(tb.daysellpreprice)+sum(tb.daysellprereturnprice)+sum(tb.daysellprecancelprice) b7,")
        .append("sum(tb.moneypayable)-sum(tb.returnhandcharge+tb.servicefee+tb.bookservicefee+tb.changeservicefee)-")
        .append("(sum(sellotherprice)-sum(sellotherreturnprice))+sum(selllocalprice)+sum(selllocalreturnprice)+")
        .append("sum(tb.passselldayprice)+sum(tb.passselldaycancelprice)+sum(tb.passreturndayprice) a9,")
        .append("sum(tb.departprice)+sum(tb.missprice)+")
        .append("sum(tb.daysellpreprice)+sum(tb.daysellprereturnprice)+sum(tb.daysellprecancelprice) b9")
		.append(" from ticketsellbalancemonth tb, organization sellorg")
		.append(" where tb.sellorgid = sellorg.id ")
		.append(" and sellorg.id in "+orgid)
		.append(" and tb.opdate >= To_DATE(TRUNC(:startdate, 'MONTH'))")
		.append(" and tb.opdate <= To_DATE(TRUNC(:enddate, 'MONTH')) ")
		.append(" group by TO_CHAR(tb.opdate,'YYYY-MM'),sellorg.name order by TO_CHAR(tb.opdate,'YYYY-MM') asc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
	/**
	 * 运量单运量台账
	 * * @param propertyFilterList,
	 *  add by lck 2011-09-29
	 *  update by hhz 2013-05-20
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> DepartInvoincesRpt( Date startdate,Date enddate, int departinvoicestype,String printorgid, List<PropertyFilter> propertyFilterList) {
		if (departinvoicestype == 1) {// 微机运量
		StringBuilder sql = new StringBuilder(
		"select departinvoicesno,rname,schedulecode,districttypename,isovertime,")
		.append(" printtime,departdate,departtime,vehicleno,")
		.append(" printbyname,totalamount,stationservicefee,")
		.append(" computefee,coolairfee,additionfee,waterfee,")
		.append(" insurefee,otherfee,fueladditionfee,jbffee,agentfee,")
		.append(" balanceamount,peopledistance,ticketnum,")
		.append(" fullnum, halfnum, shortnum,")
		.append(" middlenum,longnum, totalnum,")
		.append(" (agentfee + stationservicefee + computefee + coolairfee + additionfee + waterfee + insurefee + otherfee + fueladditionfee+jbffee) as allcountfee")
		.append("  ,trim('微机单') as dptype")
		.append(" from (")
		.append(" select ds.departinvoicesno,")
		.append(" r.name rname,")
		.append(" s.code schedulecode,")
		.append(" ddc.value as districttypename,")
		.append(" s.isovertime,")
		.append(" ds.printtime,")
		.append(" ds.departdate,")
		.append(" trim(ds.departtime) as departtime,")
		.append(" v.vehicleno,")
		.append(" pt.name printbyname,")
		.append(" sum(nvl(ds.totalamount,0)) as totalamount,")
		.append(" sum(nvl(ds.stationservicefee,0)) as stationservicefee,")
		.append(" sum(nvl((select sum(dd.deductmoney)")
		.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
		.append(" where dd.departinvoicesid = ds.id")
		.append(" and dd.balanceitemid = a.id")
		.append(" and dd.status <> '1'")
		.append(" and a.name like '%微机费%'),")
		.append(" 0)) computefee,")
		.append(" sum(nvl((select sum(dd.deductmoney)")
		.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
		.append(" where dd.departinvoicesid = ds.id")
		.append(" and dd.balanceitemid = a.id")
		.append(" and dd.status <> '1'")
		.append(" and a.name like '%空调费%'),")
		.append(" 0)) coolairfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%附加费%'),")
			.append(" 0)) additionfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%水费%'),")
			.append(" 0)) waterfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%保险费%'),")
			.append(" 0)) insurefee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and (a.name like '%其他%' or a.name like '%其它%')),")
			.append(" 0)) otherfee,")			
			.append(" sum(nvl(ds.fueladditionfee,0)) as fueladditionfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and (a.name like '%加班%')),")
			.append(" 0)) jbffee,")				
			.append(" sum(nvl(ds.agentfee,0)) as agentfee,")
			.append(" sum(nvl(ds.balanceamount,0)) balanceamount,")
			.append(" sum(nvl(de.peopledistance,0)) peopledistance,")
			.append(" sum(nvl(de.fullnum+de.halfnum,0)) as ticketnum,")
			.append(" sum(nvl(de.fullnum, 0)) fullnum,")
			.append(" sum(nvl(de.halfnum, 0)) halfnum,")
			.append(" sum(nvl(de.shortnum, 0)) shortnum,")
			.append(" sum(nvl(de.middlenum, 0)) middlenum,")
			.append(" sum(nvl(de.longnum, 0)) longnum,")
			.append(" sum(nvl(de.shortnum, 0)+nvl(de.middlenum, 0)+nvl(de.longnum, 0)) totalnum ")
		    .append(" from departinvoices ds,")
			.append(" userinfo pt,")
			.append(" route r,")
			.append(" schedule s,")
			.append(" digitaldictionary dc,")
            .append(" digitaldictionarydetail ddc,")
			.append(" scheduleplan sp,")
			.append(" (select dds.departinvoicesid,")
			.append(" sum(dds.distance * dds.ticketnum) peopledistance,")
			.append(" sum(decode(dds.tickettype, 'Q', dds.ticketnum, 0)) fullnum,")
			.append(" sum(decode(dds.tickettype, 'Q', 0, dds.ticketnum)) halfnum,")
			.append(" sum(case")
			.append(" when dds.distance < 100 then")
			.append(" dds.ticketnum")
			.append(" end) shortnum,")
			.append(" sum(case")
			.append(" when dds.distance between 100 and 200 then")
			.append(" dds.ticketnum")
			.append(" end) middlenum,")
			.append(" sum(case")
			.append(" when dds.distance > 200 then")
			.append(" dds.ticketnum")
			.append(" end) longnum")
			.append(" from departinvoicesdetail dds")
			.append(" where dds.departdate between :startdate and :enddate group by dds.departinvoicesid) de,")
			.append(" vehicle v,")
			.append(" organization sco")
			.append(" where ds.scheduleid = s.id")
			.append(" and ds.printby = pt.id")
			.append(" and s.orgid = sco.id")
			.append(" and s.routeid = r.id")
			.append(" and ds.printorgid in "+printorgid);
		 sql.append(" and s.districttype = ddc.code")
			.append(" and dc.id = ddc.digitaldictionaryid")
			.append(" and dc.tablename ='route'")
			.append(" and dc.columnname='districttype'")
			.append(" and ds.id = de.departinvoicesid(+)")
			.append(" and ds.scheduleplanid = sp.id")
			.append(" and ds.departdate between :startdate and :enddate")
			.append(" and ds.status <> '1'")
			.append(" and ds.vehicleid = v.id")
			.append(" and sp.departdate = ds.departdate ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by ds.departinvoicesno,")
		.append(" ds.departdate,")
		.append(" ds.printtime,")
		.append(" ds.departtime,")
		.append(" r.name,")
		.append(" r.id,")
		.append(" v.vehicleno,")
		.append(" s.id,ddc.value,")
		.append(" s.code,s.isovertime,")
		.append(" pt.name")
		.append(" order by r.name, ds.departtime ) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		System.out.println(sql);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
		} else if (departinvoicestype == 2) {// 手工运量
			StringBuilder sql = new StringBuilder(
					" select departinvoicesno,rname,schedulecode,districttypename,isovertime, ")
				    .append(" printtime,departdate,departtime,vehicleno,printbyname,totalamount,      ")
					.append(" stationservicefee,computefee,coolairfee,additionfee,waterfee,insurefee, ")
					.append(" otherfee,fueladditionfee,jbffee,agentfee,balanceamount,peopledistance,  ")
					.append(" ticketnum,fullnum,halfnum,shortnum,middlenum,longnum,totalnum,(agentfee ")
					.append(" + stationservicefee + computefee + coolairfee +additionfee + waterfee + ")
					.append(" insurefee + otherfee + fueladditionfee +jbffee) as allcountfee,trim('手工单') as dptype    ")
					.append(" from (select ds.departinvoicesno,r.name rname,s.code schedulecode,      ")
					.append(" ddc.value as districttypename,s.isovertime,ds.createtime as printtime,  ")
					.append(" ds.departdate,trim(ds.departtime) as departtime,v.vehicleno,            ")
					.append(" pt.name printbyname,sum(nvl(ds.totalmoney, 0)) as totalamount,          ")
					.append(" sum(nvl(ds.stationfee, 0)) as stationservicefee, ")
					.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, ")
					.append(" balancedeductitem a where dd.departinvoicesid = ds.id  ")
					.append(" and dd.balanceitemid = a.id and dd.status <> '1' and a.name like '%微机费%'), ")
					.append(" 0)) computefee,  sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, ")
					.append(" balancedeductitem  a where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id ")
					.append(" and dd.status <> '1' and a.name like '%空调费%'),  0)) coolairfee, ")
					.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, ")
					.append(" balancedeductitem  a where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id ")
					.append(" and dd.status <> '1' and a.name like '%附加费%'), 0)) additionfee, ")
					.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,balancedeductitem a ")
					.append(" where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id and dd.status <> '1' ")
					.append(" and a.name like '%水费%'),0)) waterfee, sum(nvl((select sum(dd.deductmoney) ")
					.append(" from departinvoicesdeductdetail dd,balancedeductitem  a  where dd.departinvoicesid = ds.id ")
					.append(" and dd.balanceitemid = a.id and dd.status <> '1' and a.name like '%保险费%'),0)) insurefee, ")
					.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,balancedeductitem  a ")
					.append(" where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id and dd.status <> '1' ")
					.append(" and (a.name like '%其他%' or a.name like '%其它%')),0)) otherfee, 0 as fueladditionfee, ")
					.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, balancedeductitem  a ")
					.append(" where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id and dd.status <> '1' ")
					.append(" and (a.name like '%加班%')),0)) jbffee, sum(nvl(ds.agentfee, 0)) as agentfee, ")
					.append(" sum(nvl(ds.balancemoney, 0)) balanceamount, sum(nvl(de.peopledistance, 0)) peopledistance, ")
					.append(" sum(nvl(de.fullnum + de.halfnum, 0)) as ticketnum,sum(nvl(de.fullnum, 0)) fullnum, ")
					.append(" sum(nvl(de.halfnum, 0)) halfnum,sum(nvl(de.shortnum, 0)) shortnum, ")
					.append(" sum(nvl(de.middlenum, 0)) middlenum,sum(nvl(de.longnum, 0)) longnum, ")
					.append(" sum(nvl(de.shortnum, 0) + nvl(de.middlenum, 0) +nvl(de.longnum, 0)) totalnum ")
					.append(" from departinvoicesother ds,userinfo pt,route r,schedule s,digitaldictionary dc, ")
					.append(" digitaldictionarydetail ddc,(select dds.departinvoicesotherid as departinvoicesid, ")
					.append(" sum(dds.distance * dds.ticketnum) peopledistance, ")
					.append(" sum(decode(ty.code, 'Q', dds.ticketnum, 0)) fullnum, ")
					.append(" sum(decode(ty.code, 'Q', 0, dds.ticketnum)) halfnum, ")
					.append(" sum(case")
					.append(" when dds.distance < 100 then")
					.append(" dds.ticketnum")
					.append(" end) shortnum,")
					.append(" sum(case")
					.append(" when dds.distance between 100 and 200 then")
					.append(" dds.ticketnum")
					.append(" end) middlenum,")
					.append(" sum(case")
					.append(" when dds.distance > 200 then")
					.append(" dds.ticketnum")
					.append(" end) longnum")
					.append(" from departinvoicesotherdetail dds,tickettype ty")
					.append(" where dds.departdate between :startdate and :enddate and dds.tickettypeid = ty.id group by dds.departinvoicesotherid) de,")
					.append(" vehicle v,")
					.append(" organization sco")
					.append(" where ds.scheduleid = s.id")
					.append(" and ds.datafrom <> 8 ")
					.append(" and s.orgid = sco.id")
					.append(" and s.routeid = r.id")
					.append(" and s.districttype = ddc.code")
					.append(" and dc.id = ddc.digitaldictionaryid")
					.append(" and dc.tablename ='route'")
					.append(" and dc.columnname='districttype'")
					.append(" and ds.id = de.departinvoicesid(+)")
					.append(" and ds.departdate between :startdate and :enddate")
					.append(" and ds.status <> '1'")
					.append(" and ds.vehicleid = v.id")
					.append(" and ds.createby=pt.id ");
					//.append(" and sp.departdate = ds.departdate ");
				sql.append(PropertyFilter.toJpql(propertyFilterList, true));
				sql.append(" group by ds.departinvoicesno,")
				.append(" ds.departdate,")
				.append(" ds.createtime,")
				.append(" ds.departtime,")
				.append(" r.name,")
				.append(" r.id,")
				.append(" v.vehicleno,")
				.append(" s.id,ddc.value,")
				.append(" s.code,s.isovertime,")
				.append(" pt.name")
				.append(" order by r.name, ds.departtime ) ")
				.append(" union all ")
				.append(" select departinvoicesno,rname,schedulecode,districttypename,isovertime, ")
				.append(" printtime,departdate,departtime,vehicleno,printbyname,totalamount,      ")
				.append(" stationservicefee,computefee,coolairfee,additionfee,waterfee,insurefee, ")
				.append(" otherfee,fueladditionfee,jbffee,agentfee,balanceamount,peopledistance,  ")
				.append(" ticketnum,fullnum,halfnum,shortnum,middlenum,longnum,totalnum,(agentfee ")
				.append(" + stationservicefee + computefee + coolairfee +additionfee + waterfee + ")
				.append(" insurefee + otherfee + fueladditionfee +jbffee) as allcountfee,trim('手工单') as dptype          ")
				.append(" from (select ds.departinvoicesno,r.name rname,s.code schedulecode,      ")
				.append(" ddc.value as districttypename,s.isovertime,ds.createtime as printtime,  ")
				.append(" ds.departdate,")
				.append(" trim(ds.departtime) as departtime,")
				.append(" v.vehicleno,")
				.append(" pt.name printbyname,")
				.append(" sum(nvl(ds.totalmoney, 0)) as totalamount,0 as stationservicefee, ")
				.append(" 0 as computefee,0 as coolairfee,0 as additionfee,0 as waterfee, ")
				.append(" 0 as insurefee,0 as otherfee,0 as fueladditionfee,0 as jbffee, ")
				.append(" 0 as agentfee,sum(nvl(ds.balancemoney, 0)) balanceamount, ")
				.append(" 0 as peopledistance,0 as ticketnum,0 as fullnum,0 as halfnum, ")
				.append(" 0 as shortnum,0 as middlenum,0 as longnum,0 as totalnum ")
					.append(" from departinvoicesother ds,userinfo pt,route r,schedule s,digitaldictionary dc, ")
					.append(" digitaldictionarydetail ddc,(select dds.departinvoicesotherid as departinvoicesid, ")
					.append(" sum(dds.distance * dds.ticketnum) peopledistance, ")
					.append(" sum(decode(ty.code, 'Q', dds.ticketnum, 0)) fullnum, ")
					.append(" sum(decode(ty.code, 'Q', 0, dds.ticketnum)) halfnum, ")
					.append(" sum(case")
					.append(" when dds.distance < 100 then")
					.append(" dds.ticketnum")
					.append(" end) shortnum,")
					.append(" sum(case")
					.append(" when dds.distance between 100 and 200 then")
					.append(" dds.ticketnum")
					.append(" end) middlenum,")
					.append(" sum(case")
					.append(" when dds.distance > 200 then")
					.append(" dds.ticketnum")
					.append(" end) longnum")
					.append(" from departinvoicesotherdetail dds,tickettype ty")
					.append(" where dds.departdate between :startdate and :enddate and dds.tickettypeid = ty.id group by dds.departinvoicesotherid) de,")
					.append(" vehicle v,")
					.append(" organization sco")
					.append(" where ds.scheduleid = s.id")
					.append(" and ds.datafrom = 8 ")
					.append(" and s.orgid = sco.id")
					.append(" and s.routeid = r.id")
					.append(" and s.districttype = ddc.code")
					.append(" and dc.id = ddc.digitaldictionaryid")
					.append(" and dc.tablename ='route'")
					.append(" and dc.columnname='districttype'")
					.append(" and ds.id = de.departinvoicesid(+)")
					.append(" and ds.departdate between :startdate and :enddate")
					.append(" and ds.status <> '1'")
					.append(" and ds.vehicleid = v.id")
					.append(" and ds.createby=pt.id ");
					//.append(" and sp.departdate = ds.departdate ");
				sql.append(PropertyFilter.toJpql(propertyFilterList, true));
				sql.append(" group by ds.departinvoicesno,")
				.append(" ds.departdate,")
				.append(" ds.createtime, ")
				.append(" ds.departtime,")
				.append(" r.name,")
				.append(" r.id,")
				.append(" v.vehicleno,")
				.append(" s.id,ddc.value,")
				.append(" s.code,s.isovertime,")
				.append(" pt.name")
				.append(" order by r.name, ds.departtime ) ");
				Query query = getEntityManager().createNativeQuery(sql.toString());
				System.out.println(sql);
				query.setParameter("startdate", startdate);
				query.setParameter("enddate", enddate);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();	
		}else {// 全部
			StringBuilder sql = new StringBuilder(
			"select departinvoicesno,rname,schedulecode,districttypename,isovertime,")
			.append(" printtime,departdate,departtime,vehicleno,")
			.append(" printbyname,totalamount,stationservicefee,")
			.append(" computefee,coolairfee,additionfee,waterfee,")
			.append(" insurefee,otherfee,fueladditionfee,jbffee,agentfee,")
			.append(" balanceamount,peopledistance,ticketnum,")
			.append(" fullnum, halfnum, shortnum,")
			.append(" middlenum,longnum, totalnum,")
			.append(" (agentfee + stationservicefee + computefee + coolairfee + additionfee + waterfee + insurefee + otherfee + fueladditionfee+jbffee) as allcountfee")
			.append(" ,trim('微机单') as dptype ")
			.append(" from (")
			.append(" select ds.departinvoicesno,")
			.append(" r.name rname,")
			.append(" s.code schedulecode,")
			.append(" ddc.value as districttypename,")
			.append(" s.isovertime,")
			.append(" ds.printtime,")
			.append(" ds.departdate,")
			.append(" trim(ds.departtime) as departtime,")
			.append(" v.vehicleno,")
			.append(" pt.name printbyname,")
			.append(" sum(nvl(ds.totalamount,0)) as totalamount,")
			.append(" sum(nvl(ds.stationservicefee,0)) as stationservicefee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%微机费%'),")
			.append(" 0)) computefee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%空调费%'),")
			.append(" 0)) coolairfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%附加费%'),")
			.append(" 0)) additionfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%水费%'),")
			.append(" 0)) waterfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and a.name like '%保险费%'),")
			.append(" 0)) insurefee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and (a.name like '%其他%' or a.name like '%其它%')),")
			.append(" 0)) otherfee,")			
			.append(" sum(nvl(ds.fueladditionfee,0)) as fueladditionfee,")
			.append(" sum(nvl((select sum(dd.deductmoney)")
			.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
			.append(" where dd.departinvoicesid = ds.id")
			.append(" and dd.balanceitemid = a.id")
			.append(" and dd.status <> '1'")
			.append(" and (a.name like '%加班%')),")
			.append(" 0)) jbffee,")				
			.append(" sum(nvl(ds.agentfee,0)) as agentfee,")
			.append(" sum(nvl(ds.balanceamount,0)) balanceamount,")
			.append(" sum(nvl(de.peopledistance,0)) peopledistance,")
			.append(" sum(nvl(de.fullnum+de.halfnum,0)) as ticketnum,")
			.append(" sum(nvl(de.fullnum, 0)) fullnum,")
			.append(" sum(nvl(de.halfnum, 0)) halfnum,")
			.append(" sum(nvl(de.shortnum, 0)) shortnum,")
			.append(" sum(nvl(de.middlenum, 0)) middlenum,")
			.append(" sum(nvl(de.longnum, 0)) longnum,")
			.append(" sum(nvl(de.shortnum, 0)+nvl(de.middlenum, 0)+nvl(de.longnum, 0)) totalnum ")
			.append(" from departinvoices ds,")
			.append(" userinfo pt,")
			.append(" route r,")
			.append(" schedule s,")
			.append(" digitaldictionary dc,")
	        .append(" digitaldictionarydetail ddc,")
			.append(" scheduleplan sp,")
			.append(" (select dds.departinvoicesid,")
			.append(" sum(dds.distance * dds.ticketnum) peopledistance,")
			.append(" sum(decode(dds.tickettype, 'Q', dds.ticketnum, 0)) fullnum,")
			.append(" sum(decode(dds.tickettype, 'Q', 0, dds.ticketnum)) halfnum,")
			.append(" sum(case")
			.append(" when dds.distance < 100 then")
			.append(" dds.ticketnum")
			.append(" end) shortnum,")
			.append(" sum(case")
			.append(" when dds.distance between 100 and 200 then")
			.append(" dds.ticketnum")
			.append(" end) middlenum,")
			.append(" sum(case")
			.append(" when dds.distance > 200 then")
			.append(" dds.ticketnum")
			.append(" end) longnum")
			.append(" from departinvoicesdetail dds")
			.append(" where dds.departdate between :startdate and :enddate group by dds.departinvoicesid) de,")
			.append(" vehicle v,")
			.append(" organization sco")
			.append(" where ds.scheduleid = s.id")
			.append(" and ds.printby = pt.id")
			.append(" and s.orgid = sco.id")
			.append(" and s.routeid = r.id")
			.append(" and ds.printorgid in "+printorgid);
		 sql.append(" and s.districttype = ddc.code")
			.append(" and dc.id = ddc.digitaldictionaryid")
			.append(" and dc.tablename ='route'")
			.append(" and dc.columnname='districttype'")
			.append(" and ds.id = de.departinvoicesid(+)")
			.append(" and ds.scheduleplanid = sp.id")
			.append(" and ds.departdate between :startdate and :enddate")
			.append(" and ds.status <> '1'")
			.append(" and ds.vehicleid = v.id")
			.append(" and sp.departdate = ds.departdate ");
		 sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		 sql.append(" group by ds.departinvoicesno,")
			.append(" ds.departdate,")
			.append(" ds.printtime,")
			.append(" ds.departtime,")
			.append(" r.name,")
			.append(" r.id,")
			.append(" v.vehicleno,")
			.append(" s.id,ddc.value,")
			.append(" s.code,s.isovertime,")
			.append(" pt.name")
			.append(" order by r.name, ds.departtime ) ")
			.append(" union all ")
			.append(" select departinvoicesno,rname,schedulecode,districttypename,isovertime, ")
		    .append(" printtime,departdate,departtime,vehicleno,printbyname,totalamount,      ")
			.append(" stationservicefee,computefee,coolairfee,additionfee,waterfee,insurefee, ")
			.append(" otherfee,fueladditionfee,jbffee,agentfee,balanceamount,peopledistance,  ")
			.append(" ticketnum,fullnum,halfnum,shortnum,middlenum,longnum,totalnum,(agentfee ")
			.append(" + stationservicefee + computefee + coolairfee +additionfee + waterfee + ")
			.append(" insurefee + otherfee + fueladditionfee +jbffee) as allcountfee          ")
			.append("  ,trim('手工单') as dptype")
			.append(" from (select ds.departinvoicesno,r.name rname,s.code schedulecode,      ")
			.append(" ddc.value as districttypename,s.isovertime,ds.createtime as printtime,  ")
			.append(" ds.departdate,trim(ds.departtime) as departtime,v.vehicleno,            ")
			.append(" pt.name printbyname,sum(nvl(ds.totalmoney, 0)) as totalamount,          ")
			.append(" sum(nvl(ds.stationfee, 0)) as stationservicefee, ")
			.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, ")
			.append(" balancedeductitem a where dd.departinvoicesid = ds.id  ")
			.append(" and dd.balanceitemid = a.id and dd.status <> '1' and a.name like '%微机费%'), ")
			.append(" 0)) computefee,  sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, ")
			.append(" balancedeductitem  a where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id ")
			.append(" and dd.status <> '1' and a.name like '%空调费%'),  0)) coolairfee, ")
			.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, ")
			.append(" balancedeductitem  a where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id ")
			.append(" and dd.status <> '1' and a.name like '%附加费%'), 0)) additionfee, ")
			.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,balancedeductitem a ")
			.append(" where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id and dd.status <> '1' ")
			.append(" and a.name like '%水费%'),0)) waterfee, sum(nvl((select sum(dd.deductmoney) ")
			.append(" from departinvoicesdeductdetail dd,balancedeductitem  a  where dd.departinvoicesid = ds.id ")
			.append(" and dd.balanceitemid = a.id and dd.status <> '1' and a.name like '%保险费%'),0)) insurefee, ")
			.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,balancedeductitem  a ")
			.append(" where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id and dd.status <> '1' ")
			.append(" and (a.name like '%其他%' or a.name like '%其它%')),0)) otherfee, 0 as fueladditionfee, ")
			.append(" sum(nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd, balancedeductitem  a ")
			.append(" where dd.departinvoicesid = ds.id and dd.balanceitemid = a.id and dd.status <> '1' ")
			.append(" and (a.name like '%加班%')),0)) jbffee, sum(nvl(ds.agentfee, 0)) as agentfee, ")
			.append(" sum(nvl(ds.balancemoney, 0)) balanceamount, sum(nvl(de.peopledistance, 0)) peopledistance, ")
			.append(" sum(nvl(de.fullnum + de.halfnum, 0)) as ticketnum,sum(nvl(de.fullnum, 0)) fullnum, ")
			.append(" sum(nvl(de.halfnum, 0)) halfnum,sum(nvl(de.shortnum, 0)) shortnum, ")
			.append(" sum(nvl(de.middlenum, 0)) middlenum,sum(nvl(de.longnum, 0)) longnum, ")
			.append(" sum(nvl(de.shortnum, 0) + nvl(de.middlenum, 0) +nvl(de.longnum, 0)) totalnum ")
			.append(" from departinvoicesother ds,userinfo pt,route r,schedule s,digitaldictionary dc, ")
			.append(" digitaldictionarydetail ddc,(select dds.departinvoicesotherid as departinvoicesid, ")
			.append(" sum(dds.distance * dds.ticketnum) peopledistance, ")
			.append(" sum(decode(ty.code, 'Q', dds.ticketnum, 0)) fullnum, ")
			.append(" sum(decode(ty.code, 'Q', 0, dds.ticketnum)) halfnum, ")
			.append(" sum(case")
			.append(" when dds.distance < 100 then")
			.append(" dds.ticketnum")
			.append(" end) shortnum,")
			.append(" sum(case")
			.append(" when dds.distance between 100 and 200 then")
			.append(" dds.ticketnum")
			.append(" end) middlenum,")
			.append(" sum(case")
			.append(" when dds.distance > 200 then")
			.append(" dds.ticketnum")
			.append(" end) longnum")
			.append(" from departinvoicesotherdetail dds,tickettype ty ")
			.append(" where dds.departdate between :startdate and :enddate and dds.tickettypeid = ty.id group by dds.departinvoicesotherid) de,")
			.append(" vehicle v,")
			.append(" organization sco")
			.append(" where ds.scheduleid = s.id")
			.append(" and ds.datafrom <> 8 ")
			.append(" and s.orgid = sco.id")
			.append(" and s.routeid = r.id")
			.append(" and s.districttype = ddc.code")
			.append(" and dc.id = ddc.digitaldictionaryid")
			.append(" and dc.tablename ='route'")
			.append(" and dc.columnname='districttype'")
			.append(" and ds.id = de.departinvoicesid(+)")
			.append(" and ds.departdate between :startdate and :enddate")
			.append(" and ds.status <> '1'")
			.append(" and ds.vehicleid = v.id")
			.append(" and ds.createby=pt.id ");
			//.append(" and sp.departdate = ds.departdate ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by ds.departinvoicesno,")
		.append(" ds.departdate,")
		.append(" ds.createtime,")
		.append(" ds.departtime,")
		.append(" r.name,")
		.append(" r.id,")
		.append(" v.vehicleno,")
		.append(" s.id,ddc.value,")
		.append(" s.code,s.isovertime,")
		.append(" pt.name")
		.append(" order by r.name, ds.departtime ) ")
		.append(" union all ")
		.append(" select departinvoicesno,rname,schedulecode,districttypename,isovertime, ")
		.append(" printtime,departdate,departtime,vehicleno,printbyname,totalamount,      ")
		.append(" stationservicefee,computefee,coolairfee,additionfee,waterfee,insurefee, ")
		.append(" otherfee,fueladditionfee,jbffee,agentfee,balanceamount,peopledistance,  ")
		.append(" ticketnum,fullnum,halfnum,shortnum,middlenum,longnum,totalnum,(agentfee ")
		.append(" + stationservicefee + computefee + coolairfee +additionfee + waterfee + ")
		.append(" insurefee + otherfee + fueladditionfee +jbffee) as allcountfee          ")
		.append("  ,trim('手工单') as dptype")
		.append(" from (select ds.departinvoicesno,r.name rname,s.code schedulecode,      ")
		.append(" ddc.value as districttypename,s.isovertime,ds.createtime as printtime,  ")
		.append(" ds.departdate,")
		.append(" trim(ds.departtime) as departtime,")
		.append(" v.vehicleno,")
		.append(" pt.name printbyname,")
		.append(" sum(nvl(ds.totalmoney, 0)) as totalamount,0 as stationservicefee, ")
		.append(" 0 as computefee,0 as coolairfee,0 as additionfee,0 as waterfee, ")
		.append(" 0 as insurefee,0 as otherfee,0 as fueladditionfee,0 as jbffee, ")
		.append(" 0 as agentfee,sum(nvl(ds.balancemoney, 0)) balanceamount, ")
		.append(" 0 as peopledistance,0 as ticketnum,0 as fullnum,0 as halfnum, ")
		.append(" 0 as shortnum,0 as middlenum,0 as longnum,0 as totalnum ")
			.append(" from departinvoicesother ds,userinfo pt,route r,schedule s,digitaldictionary dc, ")
			.append(" digitaldictionarydetail ddc,(select dds.departinvoicesotherid as departinvoicesid, ")
			.append(" sum(dds.distance * dds.ticketnum) peopledistance, ")
			.append(" sum(decode(ty.code, 'Q', dds.ticketnum, 0)) fullnum, ")
			.append(" sum(decode(ty.code, 'Q', 0, dds.ticketnum)) halfnum, ")
			.append(" sum(case")
			.append(" when dds.distance < 100 then")
			.append(" dds.ticketnum")
			.append(" end) shortnum,")
			.append(" sum(case")
			.append(" when dds.distance between 100 and 200 then")
			.append(" dds.ticketnum")
			.append(" end) middlenum,")
			.append(" sum(case")
			.append(" when dds.distance > 200 then")
			.append(" dds.ticketnum")
			.append(" end) longnum")
			.append(" from departinvoicesotherdetail dds,tickettype ty")
			.append(" where dds.departdate between :startdate and :enddate and dds.tickettypeid = ty.id group by dds.departinvoicesotherid) de,")
			.append(" vehicle v,")
			.append(" organization sco")
			.append(" where ds.scheduleid = s.id")
			.append(" and ds.datafrom = 8 ")
			.append(" and s.orgid = sco.id")
			.append(" and s.routeid = r.id")
			.append(" and s.districttype = ddc.code")
			.append(" and dc.id = ddc.digitaldictionaryid")
			.append(" and dc.tablename ='route'")
			.append(" and dc.columnname='districttype'")
			.append(" and ds.id = de.departinvoicesid(+)")
			.append(" and ds.departdate between :startdate and :enddate")
			.append(" and ds.status <> '1'")
			.append(" and ds.vehicleid = v.id")
			.append(" and ds.createby=pt.id ");
			//.append(" and sp.departdate = ds.departdate ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by ds.departinvoicesno,")
		.append(" ds.departdate,")
		.append(" ds.createtime, ")
		.append(" ds.departtime,")
		.append(" r.name,")
		.append(" r.id,")
		.append(" v.vehicleno,")
		.append(" s.id,ddc.value,")
		.append(" s.code,s.isovertime,")
		.append(" pt.name")
		.append(" order by r.name, ds.departtime ) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		System.out.println(sql);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
		}

	}
	
	
	/**
	 * 客运收入、支出平衡表-赣州
	 * 
	 * @param
	 * @return
	 */
	public List<Object> FinancialBalanceGZ (String orgid,Date startdate,Date enddate){
		StringBuilder sql = new StringBuilder(
				"select opdate,")
		.append(" o.name,")
		.append(" sum(passselldayprice + allmoney) as a,")
		.append(" sum(balanceamount + agentfee + subtotal + missprice +missdepartprice_return+")
		.append(" daysellpreprice + daysellprereturnprice + daysellprecancelprice +")
		.append(" totalfee) as b,")
		.append(" sum(passselldayprice),")
		.append(" sum(allmoney),")
		.append(" sum(balanceamount),")
		.append(" sum(agentfee),")
		.append(" sum(subtotal),")
		.append(" sum(missprice+missdepartprice_return),")
		.append(" sum(daysellpreprice),")
		.append(" sum(daysellprereturnprice),")
		.append(" sum(daysellprecancelprice),")
		.append(" sum(daysellpreprice+daysellprereturnprice+daysellprecancelprice) as persellprice,")
		.append(" sum(servicefee),sum(returnhandcharge),sum(bookservicefee),sum(changeservicefee),")
		.append(" sum(waterfee),sum(insurefee),sum(otherfee),sum(fueladditionfee),")
        .append(" sum(stationservicefee),sum(additionfee),sum(computefee),sum(coolairfee),")
		.append(" sum(totalfee)")
		.append(" from (")
        //--当月售票营收 和各服务费
	        .append(" select TO_CHAR(ttd.moneydate, 'YYYY-MM') opdate,")
				    .append(" o.id as orgid,")
				    .append(" sum(ttd.servicefee) servicefee,")
				    .append(" sum(ttd.returnhandcharge) returnhandcharge,")
				    .append(" sum(ttd.bookservicefee) bookservicefee,")
				    .append(" sum(ttd.changeservicefee) changeservicefee,")
				    .append(" sum(ttd.moneypayable) allmoney,")
				    .append(" sum(ttd.bookservicefee + ttd.changeservicefee + ttd.servicefee +")
				    .append(" ttd.returnhandcharge) totalfee,")
				    .append(" 0 passselldaynum,")
				    .append(" 0 passselldayprice,")
				    .append(" 0 daysellprenum,")
				    .append(" 0 daysellpreprice,")
				    .append(" 0 daysellprereturnnum,")
				    .append(" 0 daysellprereturnprice,")
				    .append(" 0 daysellprecancelnum,")
				    .append(" 0 daysellprecancelprice,")
				    .append(" 0 totalamount,")
				    .append(" 0 stationservicefee,")
				    .append(" 0 computefee,")
				    .append(" 0 coolairfee,")
				    .append(" 0 additionfee,")
				    .append(" 0 basefee,")
				    .append(" 0 agentfee,")
				    .append(" 0 balanceamount,")
				    .append(" 0 waterfee,")
				    .append(" 0 insurefee,")
				    .append(" 0 otherfee,")
				    .append(" 0 fueladditionfee,")
				    .append(" 0 subtotal,")
				    .append(" 0 moreprice,")
				    .append(" 0 missnum,")
				    .append(" 0 missprice,")
				    .append(" 0 missdepart_return,")
				    .append(" 0 missdepartprice_return,")
				    .append(" 0 missdepartMprice_return")
			   .append(" from ticketturnoverdetail ttd, userinfo u, organization o")
			   .append(" where ttd.seller = u.id")
			   .append(" and u.orgid = o.id")
			   .append(" and ttd.moneydate between :startdate and")
			   .append(" LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400")
			    //.append(" --and o.id in (318973)")
			   .append(" group by o.id, TO_CHAR(ttd.moneydate, 'YYYY-MM')")
		.append(" union all ")
        //--过去售当月票(正常票)
		       .append(" select TO_CHAR(ts.departdate, 'YYYY-MM') opdate,")
		               .append(" s.orgid,")
		               .append(" 0 servicefee,")
		               .append(" 0 returnhandcharge,")
		               .append(" 0 bookservicefee,")
		               .append(" 0 changeservicefee,")
		               .append(" 0 allmoney,")
		               .append(" 0 totalfee,")
		               .append(" count(ts.id) passselldaynum,")
		               .append(" sum(ts.price) passselldayprice,")
		               .append(" 0 daysellprenum,")
		               .append(" 0 daysellpreprice,")
		               .append(" 0 daysellprereturnnum,")
		               .append(" 0 daysellprereturnprice,")
		               .append(" 0 daysellprecancelnum,")
		               .append(" 0 daysellprecancelprice,")
		               .append(" 0 totalamount,")
		               .append(" 0 stationservicefee,")
		               .append(" 0 computefee,")
		               .append(" 0 coolairfee,")
		               .append(" 0 additionfee,")
		               .append(" 0 basefee,")
		               .append(" 0 agentfee,")
		               .append(" 0 balanceamount,")
		               .append(" 0 waterfee,")
		               .append(" 0 insurefee,")
		               .append(" 0 otherfee,")
		               .append(" 0 fueladditionfee,")
		               .append(" 0 subtotal,")
		               .append(" 0 moreprice,")
		               .append(" 0 missnum,")
		               .append(" 0 missprice,")
		               .append(" 0 missdepart_return,")
		               .append(" 0 missdepartprice_return,")
		               .append(" 0 missdepartMprice_return")
		           .append(" from ticketsell ts, schedule s")
		           .append(" where ts.scheduleid = s.id")
		           .append(" and ts.orgid = s.orgid")
		           .append(" and ts.ticketstatus = '0'")
		           .append(" and TO_DATE(TO_CHAR(ts.selltime,'yyyy-mm-dd'),'yyyy-mm-dd') < :startdate") //--"本月第一天",")
		           .append(" and ts.departdate between :startdate and LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400") //--"本月最后一天",")
		           .append(" group by TO_CHAR(ts.departdate, 'YYYY-MM'), s.orgid")
		            //--过去售票,当月退
		       .append(" union all")
			       .append(" select TO_CHAR(tr.returntime, 'YYYY-MM') opdate,")
	               .append(" s.orgid,")
	               .append(" 0 servicefee,")
	               .append(" 0 returnhandcharge,")
	               .append(" 0 bookservicefee,")
	               .append(" 0 changeservicefee,")
	               .append(" 0 allmoney,")
	               .append(" 0 totalfee,")
	               .append(" count(ts.id) passselldaynum,")
	               .append(" sum(ts.price) passselldayprice,")
	               .append(" 0 daysellprenum,")
	               .append(" 0 daysellpreprice,")
	               .append(" 0 daysellprereturnnum,")
	               .append(" 0 daysellprereturnprice,")
	               .append(" 0 daysellprecancelnum,")
	               .append(" 0 daysellprecancelprice,")
	               .append(" 0 totalamount,")
	               .append(" 0 stationservicefee,")
	               .append(" 0 computefee,")
	               .append(" 0 coolairfee,")
	               .append(" 0 additionfee,")
	               .append(" 0 basefee,")
	               .append(" 0 agentfee,")
	               .append(" 0 balanceamount,")
	               .append(" 0 waterfee,")
	               .append(" 0 insurefee,")
	               .append(" 0 otherfee,")
	               .append(" 0 fueladditionfee,")
	               .append(" 0 subtotal,")
	               .append(" 0 moreprice,")
	               .append(" 0 missnum,")
	               .append(" 0 missprice,")
	               .append(" 0 missdepart_return,")
	               .append(" 0 missdepartprice_return,")
	               .append(" 0 missdepartMprice_return")
	    	       .append(" from ticketsell ts,ticketreturn tr, schedule s")
	               .append(" where ts.scheduleid = s.id")
	               .append(" and ts.orgid = s.orgid")
	               .append(" and ts.id=tr.sellid")
	               .append(" and ts.ticketstatus = '1'")
	               .append(" and TO_DATE(TO_CHAR(ts.selltime, 'yyyy-mm-dd'), 'yyyy-mm-dd') <")
	               .append(" :startdate")
	               .append(" and TO_DATE(TO_CHAR(tr.returntime, 'yyyy-mm-dd'), 'yyyy-mm-dd') >=")
	               .append(" :startdate")
	               .append(" group by TO_CHAR(tr.returntime, 'YYYY-MM'), s.orgid")
       // --当月将来的票(正常票)     
        .append(" union all")
                .append(" select TO_CHAR(ts.selltime, 'YYYY-MM') opdate,")
                .append(" s.orgid,")
                .append(" 0 servicefee,")
                .append(" 0 returnhandcharge,")
                .append(" 0 bookservicefee,")
                .append(" 0 changeservicefee,")
                .append(" 0 allmoney,")
                .append(" 0 totalfee,")
                .append(" 0 passselldaynum,")
                .append(" 0 passselldayprice,")
                .append(" count(ts.id) daysellprenum,")
                .append(" sum(ts.price) daysellpreprice,")
                .append(" 0 daysellprereturnnum,")
                .append(" 0 daysellprereturnprice,")
                .append(" 0 daysellprecancelnum,")
                .append(" 0 daysellprecancelprice,")
                .append(" 0 totalamount,")
                .append(" 0 stationservicefee,")
                .append(" 0 computefee,")
                .append(" 0 coolairfee,")
                .append(" 0 additionfee,")
                .append(" 0 basefee,")
                .append(" 0 agentfee,")
                .append(" 0 balanceamount,")
                .append(" 0 waterfee,")
                .append(" 0 insurefee,")
                .append(" 0 otherfee,")
                .append(" 0 fueladditionfee,")
                .append(" 0 subtotal,")
                .append(" 0 moreprice,")
                .append(" 0 missnum,")
                .append(" 0 missprice,")
                .append(" 0 missdepart_return,")
                .append(" 0 missdepartprice_return,")
                .append(" 0 missdepartMprice_return ")
                .append(" from ticketsell ts, schedule s")
                .append(" where ts.scheduleid = s.id")
                .append(" and ts.ticketstatus = '0'")
                .append(" and ts.orgid = s.orgid")
                .append(" and ts.departdate > LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")//--LAST_DAY(Trunc(tempmonth, 'MONTH')) + 1 - 1 / 86400 ")//--"本月最后一天",")
                .append(" and TO_DATE(TO_CHAR(ts.selltime,'yyyy-mm-dd'),'yyyy-mm-dd') between :startdate ")//--TRUNC(tempmonth, 'MONTH')")// --"本月第一天",")
                .append(" and LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")//--LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")//--"本月最后一天",")
                .append(" group by TO_CHAR(ts.selltime, 'YYYY-MM'), s.orgid")
           .append(" union all")        
        //--当月售,将来退票
           		.append(" select TO_CHAR(ts.selltime, 'YYYY-MM') opdate,")
                .append(" s.orgid,")
                .append(" 0 servicefee,")
                .append(" 0 returnhandcharge,")
                .append(" 0 bookservicefee,")
                .append(" 0 changeservicefee,")
                .append(" 0 allmoney,")
                .append(" 0 totalfee,")
                .append(" 0 passselldaynum,")
                .append(" 0 passselldayprice,")
                .append(" 0 daysellprenum,")
                .append(" 0 daysellpreprice,")
                .append(" count(ts.id) daysellprereturnnum,")
                .append(" sum(ts.price) daysellprereturnprice,")
               .append(" 0 daysellprecancelnum,")
               .append(" 0 daysellprecancelprice,")
               .append(" 0 totalamount,")
               .append(" 0 stationservicefee,")
               .append(" 0 computefee,")
               .append(" 0 coolairfee,")
               .append(" 0 additionfee,")
               .append(" 0 basefee,")
               .append(" 0 agentfee,")
               .append(" 0 balanceamount,")
               .append(" 0 waterfee,")
               .append(" 0 insurefee,")
               .append(" 0 otherfee,")
               .append(" 0 fueladditionfee,")
               .append(" 0 subtotal,")
               .append(" 0 moreprice,")
               .append(" 0 missnum,")
               .append(" 0 missprice,")
               .append(" 0 missdepart_return,")
               .append(" 0 missdepartprice_return,")
               .append(" 0 missdepartMprice_return ")
               .append(" from ticketsell ts, schedule s, ticketreturn tr")
               .append(" where ts.scheduleid = s.id")
               .append(" and ts.ticketstatus = '1'")
               .append(" and ts.id = tr.sellid")
               .append(" and ts.orgid = s.orgid")
               .append(" and TO_DATE(TO_CHAR(tr.returntime,'yyyy-mm-dd'),'yyyy-mm-dd') > LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400")
               .append(" and ts.departdate  >= :startdate ")//--TRUNC(tempmonth, 'MONTH')")// --"本月第一天",")
               //.append(" and LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")
               .append(" and TO_DATE(TO_CHAR(ts.selltime,'yyyy-mm-dd'),'yyyy-mm-dd') <= LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")
               .append(" group by TO_CHAR(ts.selltime, 'YYYY-MM'), s.orgid")
           .append(" union all")
        
        //--当月售,将来废")
               .append(" select TO_CHAR(ts.selltime, 'YYYY-MM') opdate,")
               .append(" s.orgid,")
               .append(" 0 servicefee,")
               .append(" 0 returnhandcharge,")
               .append(" 0 bookservicefee,")
               .append(" 0 changeservicefee,")
               .append(" 0 allmoney,")
               .append(" 0 totalfee,")
               .append(" 0 passselldaynum,")
               .append(" 0 passselldayprice,")
               .append(" 0 daysellprenum,")
               .append(" 0 daysellpreprice,")
               .append(" 0 daysellprereturnnum,")
               .append(" 0 daysellprereturnprice,")
               .append(" count(ts.id) daysellprecancelnum,")
               .append(" sum(ts.price) daysellprecancelprice,")
               .append(" 0 totalamount,")
               .append(" 0 stationservicefee,")
               .append(" 0 computefee,")
               .append(" 0 coolairfee,")
               .append(" 0 additionfee,")
               .append(" 0 basefee,")
               .append(" 0 agentfee,")
               .append(" 0 balanceamount,")
               .append(" 0 waterfee,")
               .append(" 0 insurefee,")
               .append(" 0 otherfee,")
               .append(" 0 fueladditionfee,")
               .append(" 0 subtotal,")
               .append(" 0 moreprice,")
               .append(" 0 missnum,")
               .append(" 0 missprice,")
               .append(" 0 missdepart_return,")
               .append(" 0 missdepartprice_return,")
               .append(" 0 missdepartMprice_return ")
               .append(" from ticketsell ts, schedule s, ticketcancel tc")
               .append(" where ts.scheduleid = s.id")
               .append(" and ts.ticketstatus = '2'")
               .append(" and ts.id = tc.sellid")
               .append(" and ts.orgid = s.orgid")
               .append(" and TO_DATE(TO_CHAR(tc.canceltime,'yyyy-mm-dd'),'yyyy-mm-dd') > LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")// --"本月最后一天",")
               .append(" and ts.departdate >= :startdate ")//"本月最后一天",")
               .append(" and TO_DATE(TO_CHAR(ts.selltime,'yyyy-mm-dd'),'yyyy-mm-dd') <= LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400 ")//--"本月最后一天",")
               .append(" group by TO_CHAR(ts.selltime, 'YYYY-MM'), s.orgid")
       .append(" union all ")
        
        //--运量")
               .append(" select TO_CHAR(departdate, 'YYYY-MM') opdate,")
               .append(" orgid,")
               .append(" 0 servicefee,")
               .append(" 0 returnhandcharge,")
               .append(" 0 bookservicefee,")
               .append(" 0 changeservicefee,")
               .append(" 0 allmoney,")
               .append(" 0 totalfee,")
               .append(" 0 passselldaynum,")
               .append(" 0 passselldayprice,")
               .append(" 0 daysellprenum,")
               .append(" 0 daysellpreprice,")
               .append(" 0 daysellprereturnnum,")
               .append(" 0 daysellprereturnprice,")
               .append(" 0 daysellprecancelnum,")
               .append(" 0 daysellprecancelprice,")
               .append(" sum(totalamount),")
               .append(" sum(stationservicefee),")
               .append(" sum(computefee),")
               .append(" sum(coolairfee),")
               .append(" sum(additionfee),")
               .append(" sum(basefee),")
               .append(" sum(agentfee),")
               .append(" sum(balanceamount),")
               .append(" sum(waterfee),")
               .append(" sum(insurefee),")
               .append(" sum(otherfee),")
               .append(" sum(fueladditionfee),")
               .append(" sum((waterfee + insurefee + otherfee + fueladditionfee +")
               .append(" stationservicefee + additionfee + computefee + coolairfee)) subtotal,")
               .append(" sum(moreprice),")
               .append(" 0 missnum,")
               .append(" 0 missprice,")
               .append(" 0 missdepart_return,")
               .append(" 0 missdepartprice_return,")
               .append(" 0 missdepartMprice_return ")
               .append(" from (select dv.departdate,")
		       			.append(" s.orgid,")
		       			.append(" dv.totalamount,")
		       			.append(" dv.stationservicefee,")
		                .append(" nvl((select sum(dd.deductmoney)")
				                .append(" from departinvoicesdeductdetail dd,")
				                .append(" balancedeductitem          a")
				                .append(" where dd.departinvoicesid = dv.id")
				                .append(" and dd.balanceitemid = a.id")
				                .append(" and dd.status <> '1'")
				                .append(" and a.name like '%微机费%'),")
				                .append(" 0) computefee,")
		                .append(" nvl((select sum(dd.deductmoney)")
		                .append(" from departinvoicesdeductdetail dd,")
		                .append(" balancedeductitem          a")
		                .append(" where dd.departinvoicesid = dv.id")
		                .append(" and dd.balanceitemid = a.id")
		                .append(" and dd.status <> '1'")
		                .append(" and a.name like '%空调费%'),")
		                .append(" 0) coolairfee,")
		                .append(" nvl((select sum(dd.deductmoney)")
		                .append(" from departinvoicesdeductdetail dd,")
		                .append(" balancedeductitem          a")
		                .append(" where dd.departinvoicesid = dv.id")
		                .append(" and dd.balanceitemid = a.id")
		                .append(" and dd.status <> '1'")
		                .append(" and a.name like '%附加费%'),")
		                .append(" 0) additionfee,")
		                .append(" (dv.totalamount - dv.stationservicefee - dv.othterfee) basefee,")
		                .append(" dv.agentfee,")
		                .append(" dv.balanceamount,")
		                .append(" nvl((select sum(dd.deductmoney)")
		                .append(" from departinvoicesdeductdetail dd,")
		                .append(" balancedeductitem          a")
		                .append(" where dd.departinvoicesid = dv.id")
		                .append(" and dd.balanceitemid = a.id")
		                .append(" and dd.status <> '1'")
		                .append(" and a.name like '%水费%'),")
		                .append(" 0) waterfee,")
		                .append(" nvl((select sum(dd.deductmoney)")
		                .append(" from departinvoicesdeductdetail dd,")
		                .append(" balancedeductitem          a")
		                .append(" where dd.departinvoicesid = dv.id")
		                .append(" and dd.balanceitemid = a.id")
		                .append(" and dd.status <> '1'")
		                .append(" and a.name like '%保险费%'),")
		                .append(" 0) insurefee,")
		                .append(" nvl((select sum(dd.deductmoney)")
		                .append(" from departinvoicesdeductdetail dd,")
		                .append(" balancedeductitem          a")
		                .append(" where dd.departinvoicesid = dv.id")
		                .append(" and dd.balanceitemid = a.id")
		                .append(" and dd.status <> '1'")
		                .append(" and (a.name like '%其他%' or a.name like '%其它%')),")
		                .append(" 0) otherfee,")
		                .append(" dv.fueladditionfee,")
		                .append(" dv.moreprice")
		                .append(" from departinvoices dv, schedule s")
		                .append(" where dv.status <> '1'")
		                .append(" and dv.scheduleid = s.id")
		                //.append(" --and dv.printorgid in (318973)")
		                .append(" and dv.departdate between :startdate and LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400) ")//--LAST_DAY(Trunc(tempmonth, 'MONTH')) + 1 - 1 / 86400 --"本月最后一天",")
		                .append(" group by TO_CHAR(departdate, 'YYYY-MM'), orgid")
		.append(" union all")
        //--漏乘(售票者所属机构的票漏乘)")
		        .append(" select TO_CHAR(ts.departdate, 'YYYY-MM') opdate,")
		       .append(" s.orgid,")
               .append(" 0 servicefee,")
               .append(" 0 returnhandcharge,")
               .append(" 0 bookservicefee,")
               .append(" 0 changeservicefee,")
               .append(" 0 allmoney,")
               .append(" 0 totalfee,")
               .append(" 0 passselldaynum,")
               .append(" 0 passselldayprice,")
               .append(" 0 daysellprenum,")
               .append(" 0 daysellpreprice,")
               .append(" 0 daysellprereturnnum,")
               .append(" 0 daysellprereturnprice,")
               .append(" 0 daysellprecancelnum,")
               .append(" 0 daysellprecancelprice,")
               .append(" 0 totalamount,")
               .append(" 0 stationservicefee,")
               .append(" 0 computefee,")
               .append(" 0 coolairfee,")
               .append(" 0 additionfee,")
               .append(" 0 basefee,")
               .append(" 0 agentfee,")
               .append(" 0 balanceamount,")
               .append(" 0 waterfee,")
               .append(" 0 insurefee,")
               .append(" 0 otherfee,")
               .append(" 0 fueladditionfee,")
               .append(" 0 subtotal,")
               .append(" 0 moreprice,")
               .append(" count(ts.id) missnum,")
               .append(" sum(ts.price) missprice,")
               .append(" 0 missdepart_return,")
               .append(" 0 missdepartprice_return,")
               .append(" 0 missdepartMprice_return")
               .append(" from ticketsell ts, schedule s")
               .append(" where ts.scheduleid = s.id ")
               .append(" and ts.departdate between :startdate and LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400")
               .append(" and ts.isdepartinvoices = 0")
               .append(" and ts.ticketstatus = 0")
               .append(" group by TO_CHAR(ts.departdate, 'YYYY-MM'), s.orgid")
       .append(" union all")
        //--本月漏乘下月退票，计入漏乘数量")
               .append(" select TO_CHAR(ts.departdate, 'YYYY-MM') opdate,")
               .append(" s.orgid,")
               .append(" 0 servicefee,")
               .append(" 0 returnhandcharge,")
               .append(" 0 bookservicefee,")
               .append(" 0 changeservicefee,")
               .append(" 0 allmoney,")
               .append(" 0 totalfee,")
               .append(" 0 passselldaynum,")
               .append(" 0 passselldayprice,")
               .append(" 0 daysellprenum,")
               .append(" 0 daysellpreprice,")
               .append(" 0 daysellprereturnnum,")
               .append(" 0 daysellprereturnprice,")
               .append(" 0 daysellprecancelnum,")
               .append(" 0 daysellprecancelprice,")
               .append(" 0 totalamount,")
               .append(" 0 stationservicefee,")
               .append(" 0 computefee,")
               .append(" 0 coolairfee,")
               .append(" 0 additionfee,")
               .append(" 0 basefee,")
               .append(" 0 agentfee,")
               .append(" 0 balanceamount,")
               .append(" 0 waterfee,")
               .append(" 0 insurefee,")
               .append(" 0 otherfee,")
               .append(" 0 fueladditionfee,")
               .append(" 0 subtotal,")
               .append(" 0 moreprice,")
               .append(" 0 missnum,")
               .append(" 0 missprice,")
               .append(" count(ts.id) missdepart_return,")
               .append(" nvl(sum(ts.price), 0) missdepartprice_return,")
               .append(" nvl(sum(ts.moreprice), 0) missdepartMprice_return")
        .append(" from schedule s, route r, ticketsell ts, ticketreturn tr")
        .append(" where tr.sellid = ts.id")
        .append(" and TO_DATE(TO_CHAR(tr.returntime,'yyyy-mm-dd'),'yyyy-mm-dd') > LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400")
        .append(" and ts.departdate between :startdate and LAST_DAY(Trunc(:startdate, 'MONTH')) + 1 - 1 / 86400")
        .append(" and ts.scheduleid = s.id")
        .append(" and s.routeid = r.id")
        .append(" and r.isactive = 1")
        .append(" group by TO_CHAR(ts.departdate, 'YYYY-MM'), s.orgid) al,")
        .append(" organization o Where al.orgid = o.id ");
		if(orgid!=null){
			sql.append(" and o.id in "+orgid);
		}
        sql.append(" group by o.name, al.opdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
//		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
	/**
	 * 单位营收统计表-赣州
	 * @param orgid
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public List<Object> IncomeReportGZ (String orgid,Long routeid,Date startdate,Date enddate){
		StringBuilder sql = new StringBuilder(
				"select orgname,");
//		if (routeid ==null){
			sql.append(" '' as routename,");
//		}else{
//			sql.append(" routename,");
//		}
		sql.append(" sum(countsellnum),")
		.append(" sum(countsellprice),")
		.append(" sum(countreturnnum),")
		.append(" sum(countreturnprice),")
		.append(" sum(countcancelnum),")
		.append(" sum(countcancleprice),")
		.append(" sum(returncharges),")
		.append(" sum(countsellnum-countreturnnum-countcancelnum) sellnum,")
		.append(" sum(countprice) sellprice,")
		.append(" sum(missnum),")
		.append(" sum(misprice),")
		.append(" sum(countpage),")
		.append(" sum(totalamount),")
		.append(" sum(stationservicefee),")
		.append(" sum(computefee),")
		.append(" sum(coolairfee),")
		.append(" sum(additionfee),")
		.append(" sum(basefee),")
		.append(" sum(agentfee),")
		.append(" sum(balanceamount),")
		.append(" sum(waterfee),")
		.append(" sum(insurefee),")
		.append(" sum(otherfee),")
		.append(" sum(fueladditionfee),")
		.append(" sum(moreprice),")
		.append(" sum(waterfee + insurefee + otherfee + fueladditionfee +")
		.append("   stationservicefee + additionfee + computefee + coolairfee) subtotal")
		.append(" from (")
		.append(" select o.name orgname,")
			 //.append(" --r.name routename,")
			 .append("  count(ts.id) countsellnum,")
			 .append(" sum(ts.price) countsellprice,")
		     .append(" sum(case when ts.ticketstatus = '0' then")
		     .append("           ts.price else 0 end) countprice,")
			 .append(" sum(case when ts.ticketstatus = '1' then")
			 .append(" 		1 else 0 end) countreturnnum,")
			 .append(" sum(case when ts.ticketstatus = '1' then")
			 .append(" 		ts.price else 0 end) countreturnprice,")
			 .append(" sum(case when ts.ticketstatus = '2' then")
			 .append(" 		1 else 0 end) countcancelnum,")
			 .append(" sum(case when ts.ticketstatus = '2' then")
			 .append(" 		ts.price else 0 end) countcancleprice,")
			 .append(" sum(case when ts.ticketstatus = '1' then")
			 .append(" 		nvl(t.charges, 0) else 0 end) returncharges,")
			 .append(" sum(case when ts.isdepartinvoices = 0 and ts.departdate <sysdate then")
			 .append(" 		1 else 0 end) missnum,")
			 .append(" sum(case when ts.isdepartinvoices = 0 and ts.departdate <sysdate then")
			 .append(" 		ts.price else 0 end) misprice,")
			 .append(" 0 countpage,")
			 .append(" 0 totalamount,")
			 .append(" 0 ticketnum,")
			 .append(" 0 stationservicefee,")
			 .append(" 0 computefee,")
			 .append(" 0 coolairfee,")
			 .append(" 0 additionfee,")
			 .append(" 0 basefee,")
			 .append(" 0 agentfee,")
			 .append(" 0 balanceamount,")
			 .append(" 0 waterfee,")
			 .append(" 0 insurefee,")
			 .append(" 0 otherfee,")
			 .append(" 0 fueladditionfee,")
			 .append(" 0 moreprice,")
			 .append(" 0 ticketnum")
			 .append(" from ticketsell ts")
			 .append(" left join ticketreturn t on ts.id=t.sellid, ")
			 .append(" userinfo u, organization o,schedule s,route r ")
			 .append(" where ts.scheduleid = s.id")
			 .append(" and s.routeid = r.id")
			 .append(" and ts.sellby = u.id")
			 .append(" and ts.orgid=o.id")
			 .append(" and ts.departdate between :startdate-10 and :enddate+20 " )
			 .append(" and ts.selltime between :startdate and :enddate ");
		if (routeid != null){
			sql.append(" and r.id = "+routeid);
		}
		sql.append(" group by o.name")
		.append(" union all")
			 .append(" select o.name as orgname,")
			 		 .append(" 0 countsellnum,")
					 .append(" 0 countsellprice,")
					 .append(" 0 countprice,")
					 .append(" 0 countreturnnum,")
					 .append(" 0 countreturnprice,")
					 .append(" 0 countcancelnum,")
					 .append(" 0 countcancleprice,")
					 .append(" 0 returncharges,")
					 .append(" 0 missnum,")
					 .append(" 0 misprice,")
					 .append(" sum(case when dv.status <> '1' then 1 else 0 end ) countpage,")
					 .append(" sum(dv.totalamount) totalamount,")
					 .append(" sum(dv.ticketnum) ticketnum,")
					 .append(" sum(dv.stationservicefee) stationservicefee,")
					 .append(" sum(nvl((select sum(dd.deductmoney)")
					 .append(" from departinvoicesdeductdetail dd, balancedeductitem a")
					 .append(" where dd.departinvoicesid = dv.id")
					 .append(" and dd.balanceitemid = a.id")
					 .append(" and dd.status <> '1'")
					 .append(" and a.name like '%微机费%'),")
					 .append(" 0)) computefee,")
					 .append(" sum(nvl((select sum(dd.deductmoney)")
					 .append(" from departinvoicesdeductdetail dd, balancedeductitem a")
					 .append(" where dd.departinvoicesid = dv.id")
					 .append(" and dd.balanceitemid = a.id")
					 .append(" and dd.status <> '1'")
					 .append(" and a.name like '%空调费%'),")
					 .append(" 0)) coolairfee,")
					 .append(" sum(nvl((select sum(dd.deductmoney)")
					 .append(" from departinvoicesdeductdetail dd, balancedeductitem a")
					 .append(" where dd.departinvoicesid = dv.id")
					 .append(" and dd.balanceitemid = a.id")
					 .append("  and dd.status <> '1'")
					 .append(" and a.name like '%附加费%'),")
					 .append(" 0)) additionfee,")
					 .append(" sum(dv.totalamount - dv.stationservicefee - dv.othterfee) basefee,")
					 .append(" sum(dv.agentfee) agentfee,")
					 .append(" sum(dv.balanceamount) balanceamount,")
					 .append(" sum(nvl((select sum(dd.deductmoney)")
					 .append(" from departinvoicesdeductdetail dd, balancedeductitem a")
					 .append(" where dd.departinvoicesid = dv.id")
					 .append(" and dd.balanceitemid = a.id")
					 .append(" and dd.status <> '1'")
					 .append(" and a.name like '%水费%'),")
					 .append(" 0)) waterfee,")
					 .append(" sum(nvl((select sum(dd.deductmoney)")
					 .append(" from departinvoicesdeductdetail dd, balancedeductitem a")
					 .append(" where dd.departinvoicesid = dv.id")
					 .append(" and dd.balanceitemid = a.id")
					 .append(" and dd.status <> '1'")
					 .append(" and a.name like '%保险费%'),")
					 .append(" 0)) insurefee,")
					 .append(" sum(nvl((select sum(dd.deductmoney)")
					 .append(" from departinvoicesdeductdetail dd, balancedeductitem a")
					 .append(" where dd.departinvoicesid = dv.id")
					 .append(" and dd.balanceitemid = a.id")
					 .append(" and dd.status <> '1'")
					 .append(" and (a.name like '%其他%' or a.name like '%其它%')),")
					 .append(" 0)) otherfee,")
					 .append(" sum(dv.fueladditionfee) fueladditionfee,")
					 .append(" sum(dv.moreprice) moreprice,")
					 .append(" sum(dv.ticketnum) ticketnum")
					 .append(" from departinvoices dv, schedule s, route r,organization o")
					 .append(" where dv.status <> '1'")
					 .append(" and dv.scheduleid = s.id")
					 .append(" and s.routeid = r.id")
					 .append(" and dv.printorgid=o.id")
					 .append(" and dv.departdate  between :startdate and :enddate ");
		if (routeid != null){
			sql.append(" and r.id = "+routeid);
		}
		sql.append(" group by o.name ")//--, r.name")
			 .append(" ) group by orgname	")	;
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}	
	
	//班次日结算表
	public List<Object> qryScheduleBalancePrice(String sellorgids,long routeid,Date startdate,Date enddate,
			String workways,int isovertime) {
		
		String qryother = parameterService.findParamValue(ParamterConst.Param_0022,null);
		//单独处理十堰--开始
		ActionNode actionNode = Appvar.routes.get("VEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
		StringBuilder sql = new StringBuilder();
		if(actionNode != null) {
			//十堰的特殊情况
			sql = new StringBuilder(
					"sELECT code,trim(max(departtime)) departtime,reachname,max(VEHICLENO),")
					.append(" sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,sum(departnum) departnum,")
					.append(" sum(balanceprice) balanceprice,sum(totalprice) totalprice,")
					.append(" (sum(ticketnum)-sum(departnum) - sum(handdep)) lostnum,sum(lostprice) lostprice, ")
					.append(" sum(zwticketnum)zwticketnum,sum(zwprice)zwprice,")
					.append(" sum(ticketnum+zwticketnum) hjsellticketnum,")
					.append(" sum(ticketprice+zwprice) hjsellticketprice,")
					.append(" sum(departnum+zwticketnum) hjdepartnum,")
					.append(" sum(balanceprice+zwprice) hjdepartprice,")
					.append("  '' as remark,max(unitname) unitname ")
					.append(" from (SELECT sc.code, max(t.departtime) departtime,")
					.append(" s.name as reachname,max(Vp.VEHICLENO) VEHICLENO,count(t.id) ticketnum,")
					.append(" sum(t.price) ticketprice,sum(case t.ischecked when 0 then t.price else 0 end) lostprice,0 departnum,0 balanceprice,0 totalprice,")
					.append(" 0 zwticketnum,0 zwprice,'' as remark,max(vp.unitname) unitname, 0 handdep")
					.append("   from ticketsell t,(select vp.id, v.vehicleno,u.name unitname from vehiclereport vp, vehicle v,unit u")
					.append("  where vp.vehicleid = v.id and v.unitid=u.id and vp.departdate between :startdate and :enddate")
					.append("       and vp.isactive = 1) vp,station s,schedule sc, route r,")
					.append("  (select tk.ticketsellid, tk.oldscheduleid, tk.olddepartdate from ticketmixcheck tk where tk.isactive = 1) tk")
					.append("  where t.vehiclereportid = vp.id(+) and nvl(tk.oldscheduleid, t.scheduleid) = sc.id")
					.append("       and t.id = tk.ticketsellid(+) and t.orgid in "+sellorgids)
					.append("       and t.sellby<>39097 and t.sellby<>68997 and sc.routeid = r.id  and t.ticketstatus = '0' and sc.workways in "+workways);
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and sc.isovertime=" + isovertime);
			}
			sql.append(
					"      and s.id = r.endstationid  and nvl(tk.olddepartdate,t.departdate) between :startdate and :enddate")
					.append("    group by t.DEPARTDATE, sc.code, s.name")
					//站内发班
					.append(" union all  SELECT sc.code,")
					.append("     max(ts.departtime) departtime,s.name as reachname,")
					.append("    max(v.VEHICLENO) VEHICLENO, 0 ticketnum,0 ticketprice, 0 lostprice,count(*) departnum,")
					.append("    round(sum(t.balanceamount / t.ticketnum),2) balanceprice,")
					.append("    round(sum(t.totalamount / t.ticketnum),2) totalprice, ")
					.append("    0 zwticketnum,0 zwprice,'' as remark,max(u.name) unitname, 0 handdep")
					.append("    from ticketsell ts,departinvoices t, vehicle v, station s, schedule sc, route r,unit u")		
					.append("  where t.vehicleid = v.id  and  ts.scheduleid = sc.id and v.unitid=u.id and sc.workways in "+workways)
					.append("    and sc.routeid = r.id  and t.status <> '1'  and s.id = r.endstationid")
					.append("    and ts.sellby<>39097 and ts.sellby<>68997 and ts.orgid in "+sellorgids)
					.append("    and ts.departinvoicesid = t.id and ts.isdepartinvoices = 1");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and sc.isovertime=" + isovertime);
			}
			sql.append(
					"      and s.id = r.endstationid  and t.departdate between :startdate and :enddate")
					.append("    group by t.DEPARTDATE, sc.code, s.name")
					//站内发班火车
					.append(" union all  SELECT sc.code,")
					.append("     max(ts.departtime) departtime,s.name as reachname,")
					.append("    max(v.VEHICLENO) VEHICLENO, 0 ticketnum,0 ticketprice, 0 lostprice,0 departnum,")
					.append("    0 balanceprice,0 totalprice,")
					.append("    0 zwticketnum,0 zwprice,'' as remark,max(u.name) unitname, 0 handdep")
					.append("    from ticketsell ts,departinvoices t, vehicle v, station s, schedule sc, route r,unit u")		
					.append("  where t.vehicleid = v.id  and v.unitid=u.id and ts.scheduleid = sc.id  and sc.workways in "+workways)
					.append("    and sc.routeid = r.id  and t.status <> '1'  and s.id = r.endstationid")
					.append("    and (ts.sellby=39097 or ts.sellby=68997) and ts.orgid in "+sellorgids)
					.append("    and ts.departinvoicesid = t.id and ts.isdepartinvoices = 1");		
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and sc.isovertime=" + isovertime);
			}
			//站内手工
			sql.append(
					"   and t.departdate between :startdate and :enddate group by t.DEPARTDATE, sc.code, s.name");
//					.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
//					.append(" max(v.vehicleno) VEHICLENO,sum(d.ticketnum) ticketnum,sum(decode(d.balancemoney, 0, d.totalmoney, d.balancemoney)) ticketprice, 0 lostprice,")
//					.append(" sum(d.ticketnum) departnum,sum(decode(d.balancemoney,0,d.totalmoney,d.balancemoney)) balanceprice,0 totalprice,")
//					.append(" 0 zwticketnum,0 zwprice,'' as remark,max(u.name) unitname")
//					.append(" from departinvoicesother d,vehicle v,schedule  s,")
//					.append("  station  st,route   r,unit u")
//					.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
//					.append("  and d.datafrom  <> '8' and s.workways in "+workways)
//					.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
//			if (routeid > 0) {
//				sql.append(" and r.id=" + routeid);
//			}	
//			if(isovertime>=0){
//				sql.append(" and s.isovertime=" + isovertime);
//			}
			//火车手工
			sql.append("")
//					"    group by d.DEPARTDATE, s.code, st.name")
					.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
					.append(" max(v.vehicleno) VEHICLENO,0 ticketnum,0 ticketprice, 0 lostprice,")
					.append(" 0 departnum,0 balanceprice,0 totalprice,")
					.append(" 0 zwticketnum,0 zwprice,'' as remark,max(u.name) unitname, 0 handdep")
					.append(" from departinvoicesother d,vehicle v,schedule  s,")
					.append("  station  st,route   r,unit u")
					.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
					.append("  and d.datafrom='6' and s.workways in "+workways)
					.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and s.isovertime=" + isovertime);
			}
			//站外
			sql.append("  and d.status <> '1' group by d.departdate, s.code, st.name")
			.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
					.append(" max(v.vehicleno) VEHICLENO,0 ticketnum,0 ticketprice, 0 lostprice,")
					.append(" 0 departnum,0 balanceprice,0 totalprice,")
					.append(" sum(d.ticketnum) zwticketnum,sum(d.totalmoney) zwprice,'' as remark,max(u.name) unitname, 0 handdep")
					.append(" from departinvoicesother d,vehicle v,schedule  s,")
					.append("  station  st,route   r,unit u")
					.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
					.append("  and d.datafrom not in ('8','10') and s.workways in "+workways)
					.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and s.isovertime=" + isovertime);
			}
			sql.append("  and d.status <> '1' group by d.departdate, s.code, st.name ");
			//外站打印结算单
			if(qryother.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
				sql.append(" union all select s.code,max(d.departtime) departtime,")
				.append("  d.reachname,max(d.VEHICLENO) VEHICLENO,sum(ticketnum) ticketnum,")
				.append(" sum(ticketprice) ticketprice, sum(case t.ischecked when 0 then t.price else 0 end) lostprice,sum(d.departnum) departnum,")
				.append(" sum(d.balanceprice) balanceprice,0 totalprice,")
				.append(" 0 zwticketnum,0 zwprice,'' as remark,d.unitname, 0 handdep")
				.append("  from invoicesotherprint d, schedule s, route r")
				.append(" where d.scheduleid = s.id and s.routeid = r.id")
				.append(" and d.departdate between :startdate and :enddate")
				.append(" and s.workways in "+workways);
				if (routeid > 0) {
					sql.append(" and r.id=" + routeid);
				}
				if(isovertime>=0){
					sql.append(" and s.isovertime=" + isovertime);
				}
				sql.append(" group by s.code, d.reachname, d.unitname");
			}
			// 补录票号
			sql.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
			.append(" max(v.vehicleno) VEHICLENO,0 ticketnum,0 ticketprice, 0 lostprice,")
			.append(" 0 departnum,0 balanceprice,0 totalprice,")
			.append(" 0 zwticketnum,0 zwprice,'' as remark,max(u.name) unitname, count(d.id) handdep")
			.append(" from departinvoicesother d,ticketsell ts,vehicle v,schedule  s,")
			.append("  station  st,route   r,unit u")
			.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
			.append("  and ts.departinvoicesid = d.id and s.workways in "+workways)
			.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if (isovertime >= 0) {
				sql.append(" and s.isovertime=" + isovertime);
			}
			sql.append(" group by d.departdate, s.code, st.name");
			sql.append(" ) group by code, reachname order by code");
			
		}//十堰特殊情况--结束
		else{
			//不是十堰时	--开始
			sql = new StringBuilder(
					"sELECT code,trim(max(departtime)) departtime,reachname,max(VEHICLENO),")
					.append(" sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,sum(departnum) departnum,")
					.append(" sum(balanceprice) balanceprice, sum(totalprice) totalprice, ")
					.append(" (sum(ticketnum)-sum(departnum)) lostnum,sum(lostprice) lostprice, ")
					.append(" sum(zwticketnum)zwticketnum,sum(zwprice)zwprice,")
					.append(" sum(ticketnum+zwticketnum) hjsellticketnum,")
					.append(" sum(ticketprice+zwprice) hjsellticketprice,")
					.append(" sum(departnum+zwticketnum) hjdepartnum,")
					.append(" sum(balanceprice+zwprice) hjdepartprice,")
					.append("  '' as remark,max(unitname) unitname ")
					.append(" from (SELECT sc.code, max(t.departtime) departtime,")
					.append(" s.name as reachname,max(Vp.VEHICLENO) VEHICLENO,count(t.id) ticketnum,")
					.append(" sum(t.price) ticketprice,sum(case t.ischecked when 0 then t.price else 0 end) lostprice,0 departnum,0 balanceprice,0 totalprice,")
					.append(" 0 zwticketnum,0 zwprice,max(vp.unitname) unitname")
					.append("   from ticketsell t,(select vp.id, v.vehicleno,u.name unitname from vehiclereport vp, vehicle v,unit u")
					.append("  where vp.vehicleid = v.id and v.unitid=u.id and vp.departdate between :startdate and :enddate")
					.append("       and vp.isactive = 1) vp,station s,schedule sc, route r,")
					.append("  (select tk.ticketsellid, tk.oldscheduleid, tk.olddepartdate from ticketmixcheck tk where tk.isactive = 1) tk")
					.append("  where t.vehiclereportid = vp.id(+) and nvl(tk.oldscheduleid, t.scheduleid) = sc.id")
					.append("       and t.id = tk.ticketsellid(+) and t.orgid in "+sellorgids)
					.append("       and t.sellby<>39097 and t.sellby<>68997 and sc.routeid = r.id  and t.ticketstatus = '0' and sc.workways in "+workways);
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and sc.isovertime=" + isovertime);
			}
			sql.append(
					"      and s.id = r.endstationid  and nvl(tk.olddepartdate,t.departdate) between :startdate and :enddate")
					.append("    group by t.DEPARTDATE, sc.code, s.name")
					//站内发班
					.append(" union all  SELECT sc.code,")
					.append("     max(ts.departtime) departtime,s.name as reachname,")
					.append("    max(v.VEHICLENO) VEHICLENO, 0 ticketnum,0 ticketprice, 0 lostprice,count(*) departnum,")
					.append("    round(sum(t.balanceamount / t.ticketnum),2) balanceprice,")
					.append("    round(sum(t.totalamount / t.ticketnum),2) totalprice,")
					.append("    0 zwticketnum,0 zwprice,max(u.name) unitname")
					.append("    from ticketsell ts,departinvoices t, vehicle v, station s, schedule sc, route r,unit u")		
					.append("  where t.vehicleid = v.id  and  ts.scheduleid = sc.id and v.unitid=u.id and sc.workways in "+workways)
					.append("    and sc.routeid = r.id  and t.status <> '1'  and s.id = r.endstationid")
					.append("    and ts.sellby<>39097 and ts.sellby<>68997 and ts.orgid in "+sellorgids)
					.append("    and ts.departinvoicesid = t.id and ts.isdepartinvoices = 1");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and sc.isovertime=" + isovertime);
			}
			sql.append(
					"      and s.id = r.endstationid  and t.departdate between :startdate and :enddate")
					.append("    group by t.DEPARTDATE, sc.code, s.name")
					//站内发班火车
					.append(" union all  SELECT sc.code,")
					.append("     max(ts.departtime) departtime,s.name as reachname,")
					.append("    max(v.VEHICLENO) VEHICLENO, 0 ticketnum,0 ticketprice, 0 lostprice,0 departnum,")
					.append("    0 balanceprice,0 totalprice,")
					.append("    0 zwticketnum,0 zwprice,max(u.name) unitname")
					.append("    from ticketsell ts,departinvoices t, vehicle v, station s, schedule sc, route r,unit u")		
					.append("  where t.vehicleid = v.id  and v.unitid=u.id and ts.scheduleid = sc.id  and sc.workways in "+workways)
					.append("    and sc.routeid = r.id  and t.status <> '1'  and s.id = r.endstationid")
					.append("    and (ts.sellby=39097 or ts.sellby=68997) and ts.orgid in "+sellorgids)
					.append("    and ts.departinvoicesid = t.id and ts.isdepartinvoices = 1");		
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and sc.isovertime=" + isovertime);
			}
			//站内手工
			sql.append(
					"   and t.departdate between :startdate and :enddate group by t.DEPARTDATE, sc.code, s.name")
					.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
					.append(" max(v.vehicleno) VEHICLENO,sum(d.ticketnum) ticketnum,sum(decode(d.balancemoney, 0, d.totalmoney, d.balancemoney)) ticketprice, 0 lostprice,")
					.append(" sum(d.ticketnum) departnum,sum(decode(d.balancemoney,0,d.totalmoney,d.balancemoney)) balanceprice,")
					.append(" sum(d.totalmoney) totalprice,")
					.append(" 0 zwticketnum,0 zwprice,max(u.name) unitname")
					.append(" from departinvoicesother d,vehicle v,schedule  s,")
					.append("  station  st,route   r,unit u")
					.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
					.append("  and d.datafrom='0' and s.workways in "+workways)
					.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
					sql.append(" and d.status <> '1'");////
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}	
			if(isovertime>=0){
				sql.append(" and s.isovertime=" + isovertime);
			}
			//火车手工
			sql.append(
					"    group by d.DEPARTDATE, s.code, st.name")
					.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
					.append(" max(v.vehicleno) VEHICLENO,0 ticketnum,0 ticketprice, 0 lostprice,")
					.append(" 0 departnum,0 balanceprice,0 totalprice,")
	//				.append(" sum(d.ticketnum) hcdepartnum,sum(decode(d.balancemoney,0,d.totalmoney,d.balancemoney)) hcbalanceprice,")
					.append(" 0 zwticketnum,0 zwprice,max(u.name) unitname")
					.append(" from departinvoicesother d,vehicle v,schedule  s,")
					.append("  station  st,route   r,unit u")
					.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
					.append("  and d.datafrom='2' and s.workways in "+workways)
					.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and s.isovertime=" + isovertime);
			}
			//路配手工
			sql.append("  and d.status <> '1' group by d.departdate, s.code, st.name")
			.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
					.append(" max(v.vehicleno) VEHICLENO,0 ticketnum,0 ticketprice, 0 lostprice,")
					.append(" 0 departnum,0 balanceprice,0 totalprice,")
					.append(" sum(d.ticketnum) zwticketnum,sum(d.totalmoney) zwprice,max(u.name) unitname")
					.append(" from departinvoicesother d,vehicle v,schedule  s,")
					.append("  station  st,route   r,unit u")
					.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
					.append("  and d.datafrom='1' and s.workways in "+workways)
					.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and s.isovertime=" + isovertime);
			}
			sql.append("  and d.status <> '1' group by d.departdate, s.code, st.name ");
			//外站打印结算单
			if(qryother.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
				sql.append(" union all select s.code,max(d.departtime) departtime,")
				.append("  d.reachname,max(d.VEHICLENO) VEHICLENO,sum(ticketnum) ticketnum,")
				.append(" sum(ticketprice) ticketprice, sum(case t.ischecked when 0 then t.price else 0 end) lostprice,sum(d.departnum) departnum,")
				.append(" sum(d.balanceprice) balanceprice,")
				.append(" sum(d.balanceprice) totalprice,") 
				.append(" 0 zwticketnum,0 zwprice,d.unitname")
				.append("  from invoicesotherprint d, schedule s, route r")
				.append(" where d.scheduleid = s.id and s.routeid = r.id")
				.append(" and d.departdate between :startdate and :enddate")
				.append(" and s.workways in "+workways);
				if (routeid > 0) {
					sql.append(" and r.id=" + routeid);
				}
				if(isovertime>=0){
					sql.append(" and s.isovertime=" + isovertime);
				}
				sql.append(" group by s.code, d.reachname, d.unitname");
			}
			
			//结算单补录补录单据
			sql.append(" union all select s.code,max(d.departtime) departtime,st.name as reachname,")
			.append(" max(v.vehicleno) VEHICLENO,SUM (D .ticketnum) ticketnum,sum (decode (d .balancemoney,0,d .totalmoney,d .balancemoney)) ticketprice, 0 lostprice,")
			.append(" sum (d .ticketnum) departnum,sum (decode (d .balancemoney,0,d .totalmoney,d .balancemoney)) balanceprice,sum (d .totalmoney) totalprice,")
			.append(" sum (d .ticketnum) zwticketnum,sum (d .totalmoney) zwprice,max(u.name) unitname")
			.append(" from departinvoicesother d,vehicle v,schedule  s,")
			.append("  station  st,route   r,unit u")
			.append("  where d.scheduleid = s.id and v.unitid=u.id and d.vehicleid = v.id  and s.routeid = r.id")
			.append("  and  d.datafrom is null and s.workways in "+workways)
			.append("  and r.endstationid = st.id and d.departdate between :startdate and :enddate");
			sql.append(" and d.status <> '1' ");
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			if(isovertime>=0){
				sql.append(" and s.isovertime=" + isovertime);
			}
			sql.append("   group by d.departdate, s.code, st.name");
			
			
			sql.append(" ) group by code, reachname order by code");
		}//不是十堰的情况--结束
		Query query = getEntityManager().createNativeQuery(sql.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		
		List<Object> list= query.getResultList();
		
		return list;
	}
	/**
	 * @Title qryRouteBalancePrice
	 * @Description 线路日结算表
	 * @param sellorgids
	 * @param routeid
	 * @param startdate
	 * @param enddate
	 * @param workways
	 * @return List<Object> 
	 * @author ……
	 * -updateby tianhb
	 * @date 2017年3月28日-下午20:45:20
	 * @update 
	 * @throws
	 */
	public List<Object> qryRouteBalancePrice(String sellorgids,long routeid,Date startdate,Date enddate,
			String workways) {
		//字段对应(reachname:终到站,sellnum:售票-人数,totalprice:售票-金额,localsch:本司-班次,
		StringBuilder sql = new StringBuilder( "SELECT reachname,sum(sellnum) sellnum,sum(totalprice),sum(localsch) localsch,")
		//字段对应 localdepartnum:本司-人数,localbalanceprice:本司-金额,),syncsch:外司-班次,
		.append(" sum(localdepartnum) localdepartnum,sum(localbalanceprice) localbalanceprice,sum(syncsch) syncsch,")
		//字段对应 syncdepartnum:外司-人数,syncbalanceprice:外司-金额,
		.append(" sum(syncdepartnum) syncdepartnum,sum(syncbalanceprice) syncbalanceprice,")
		//字段对应 totalsch:小计-班次,totaldepartnum:小计-人数,totalbalanceprice:小计-金额
		.append(" sum(localsch+syncsch) totalsch , sum(localdepartnum+syncdepartnum) totaldepartnum,sum(localbalanceprice+syncbalanceprice) totalbalanceprice,")
		//字段对应 lostnum:未走-人数,lostprice:未走-金额
		.append(" sum(sellnum-localdepartnum-syncdepartnum) lostnum,SUM(totalprice-localbalanceprice-syncbalanceprice - fcstationservicefee) lostprice,")
		//字段对应 zwbsticketnum:路配-本司-人数,zwbstotalmoney:路配-本司-金额
		.append(" sum(zwbsticketnum)zwbsticketnum,sum(zwbstotalmoney)zwbstotalmoney,")
		//字段对应 zwwsticketnum:路配-外司-人数,zwwstotalmoney:路配-外司-金额
		.append(" sum(zwwsticketnum)zwwsticketnum,sum(zwwstotalmoney)zwwstotalmoney,")
		//字段对应 fcticketnum:发车-人数,fcbalanceprice:发车-金额,fcstationservicefee:站务费
		.append(" sum(zwbsticketnum+zwwsticketnum+localdepartnum+syncdepartnum) fcticketnum,sum(zwbstotalmoney+zwwstotalmoney+localbalanceprice+syncbalanceprice) fcbalanceprice,SUM(fcstationservicefee) AS fcstationservicefee, ")
		//字段对应 hjsellnum:售票合计-人数,hjtotalmoney:售票合计-金额
		.append(" sum(sellnum+zwbsticketnum+zwwsticketnum) hjsellnum,sum(totalprice+zwbstotalmoney+zwwstotalmoney) hjtotalmoney")
		.append("  from (")
		//总售票(查询 终到站，售票-人数，售票-金额)
		.append(" SELECT r.id as routeid,s.name as reachname,COUNT(t.id) sellnum,SUM(t.price) totalprice,")
		.append(" 0 localsch,0 localdepartnum, 0 localbalanceprice,0 syncsch,")
		.append(" 0 syncdepartnum,0 syncbalanceprice,")
		.append(" 0 zwbsticketnum,0 zwbstotalmoney,0 zwwsticketnum,0 zwwstotalmoney,0 fcstationservicefee")
		.append(" FROM ticketsell t,station s,schedule sc,route r,")
		.append(" (SELECT tk.ticketsellid, tk.oldscheduleid, tk.olddepartdate FROM ticketmixcheck tk where tk.isactive = 1) tk")
		.append(" WHERE nvl(tk.oldscheduleid, t.scheduleid) = sc.id")
		.append(" AND t.id = tk.ticketsellid(+) AND t.orgid  in " + sellorgids)
		.append(" AND sc.routeid = r.id and t.ticketstatus = '0'")
		.append(" AND sc.workways in " + workways);
		if (routeid > 0) {
			sql.append(" AND r.id=" + routeid);
		 }		
		sql.append(" AND s.id = r.endstationid and nvl(tk.olddepartdate,t.departdate) between :startdate and :enddate")
		.append(" GROUP BY t.departdate,r.id , s.name")
		.append(" UNION ALL")			
		//本司和外司要含微机单和来源为手工的补录单数据：微机单  来源-datafrom(0:茅坪,1:广场,10:手工,11:现金,2:西城,3:白浪,4:保卫,5:郧西,6:火车站,7:稽查,8:货物,9:包车)
		.append("    SELECT r.id as routeid,s.name as reachname,0 sellnum,0 totalprice,count(distinct decode(u.type, '0', t.reportid, null)) localsch,")
		.append("        sum(decode(u.type,'0',1,0)) localdepartnum, round(sum(decode(u.type,'0',t.balanceamount / t.ticketnum,0)), 2) localbalanceprice,")
		.append("        count(distinct decode(u.type, '0', null, t.reportid)) syncsch,sum(decode(u.type,'0',0,1)) syncdepartnum,round(sum(decode(u.type,'0',0,t.balanceamount / t.ticketnum)), 2) syncbalanceprice,")
		.append("       0 zwbsticketnum,0 zwbstotalmoney,0 zwwsticketnum,0 zwwstotalmoney,SUM(t.stationservicefee / t.ticketnum) fcstationservicefee")
		.append("        from ticketsell     ts,departinvoices t,vehicle        v,station        s,")
		.append("        schedule       sc,route          r,unit u")
		.append("       where t.vehicleid = v.id  and t.scheduleid = sc.id and ts.departinvoicesid = t.id")
		.append("        and ts.isdepartinvoices = 1 and sc.workways in "+workways)
		.append("	     and ts.orgid in "+sellorgids);
		if (routeid > 0) {
			sql.append(" and r.id=" + routeid);
		}		
		sql.append("        and sc.routeid = r.id and v.unitid=u.id and t.status <> '1'")
		.append("        and s.id = r.endstationid and t.departdate between :startdate and :enddate")
		.append("     group by t.DEPARTDATE,r.id,  s.name")
		.append("     union all")		
		//本司和外司要含微机单和来源为手工的补录单数据：来源为手工的补录单 SUM(d.stationfee):来源为手工 站务费
		.append("   select r.id as routeid,st.name as reachname,0 sellnum,0 totalprice,0 localsch,")
		.append("   sum(decode(u.type,'0',d.ticketnum,0))  localdepartnum,")
		.append("   sum(decode(u.type,'0',d.balancemoney,0)) localbalanceprice,0 syncsch,")
		.append("   sum(decode(u.type,'0',0,d.ticketnum))  syncdepartnum,")
		.append("   sum(decode(u.type,'0',0,d.balancemoney)) syncbalanceprice,0 zwbsticketnum,0 zwbstotalmoney,0 zwwsticketnum,0 zwwstotalmoney")
		.append(" ,SUM(d.stationfee) as fcstationservicefee")
		.append("   from departinvoicesother d,vehicle             v,schedule            s,")
		.append("     station             st,route               r,unit                u")
		.append("  where d.scheduleid = s.id and d.vehicleid = v.id and s.routeid = r.id")
		.append("     and r.endstationid = st.id and d.orgid in"+sellorgids)
		.append("     and v.unitid = u.id and d.departdate between :startdate and :enddate")
		.append("     and d.datafrom='10' and d.status <> '1' and s.workways in "+workways);
		if (routeid > 0) {
			sql.append(" and r.id=" + routeid);
		 }
		sql.append("   group by d.DEPARTDATE,r.id, st.name  union all")
		//路配即验证点补票的现金数据，取来源为非手工、非货物的手工补录的数据，金额取结算金额。本司和外司通过车辆的车属单位类型进行区分  SUM(CASE d.datafrom WHEN '11' THEN d.stationfee ELSE 0 END)：来源为现金 站务费
		//来源-datafrom(0:茅坪,1:广场,10:手工,11:现金,2:西城,3:白浪,4:保卫,5:郧西,6:火车站,7:稽查,8:货物,9:包车)
		.append(" SELECT r.id as routeid,st.name as reachname,0 sellnum,0 totalprice,0 localsch,")
		.append(" 0 localdepartnum,0 localbalanceprice,0 syncsch,")
		.append(" 0 syncdepartnum,0 syncbalanceprice,")
		.append(" SUM(decode(u.type,'0',d.ticketnum,0)) zwbsticketnum,SUM(decode(u.type,'0',d.balancemoney,0)) zwbstotalmoney,")
		.append(" SUM(decode(u.type,'0',0,d.ticketnum)) zwwsticketnum,SUM(decode(u.type,'0',0,d.balancemoney)) zwwstotalmoney")
		.append(" ,SUM(CASE d.datafrom WHEN '11' THEN d.stationfee ELSE 0 END) AS fcstationservicefee")
		.append(" FROM departinvoicesother d,vehicle             v,schedule            s,")
		.append("     station             st,route               r,unit                u")
		.append(" WHERE d.scheduleid = s.id AND d.vehicleid = v.id and s.routeid = r.id")
		.append(" AND r.endstationid = st.id AND d.orgid in"+sellorgids)
		.append(" AND v.unitid = u.id AND d.departdate BETWEEN :startdate AND :enddate")
		.append(" AND d.status <> '1' AND s.workways in "+workways)
//		.append(" AND d.datafrom NOT IN ('10','8')");
		.append(" AND NOT EXISTS(SELECT 1 FROM DUAL WHERE d.datafrom IN ('8','10') )");
		/*.append(" AND NOT EXISTS (SELECT 1 FROM Digitaldictionary t LEFT JOIN  Digitaldictionarydetail a ON t.id = a.digitaldictionaryid WHERE") 
        .append(" t.tablename = 'departinvoicesother' and  t.columnname='datafrom' and a.code = d.datafrom and d.datafrom in('8','10') ) ");*/
		if (routeid > 0) {
			sql.append(" AND r.id=" + routeid);
		 }		
		sql.append(" GROUP BY d.DEPARTDATE,r.id, st.name");
		/* 2017年3月30日 注释
		//P-0022:集中式环境中是否查询其他站结算单,0否，1是，默认为0
		String qryother = parameterService.findParamValue(ParamterConst.Param_0022,null);
		//外站打印结算单
		if(qryother.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
			sql.append(" union all select r.id as routeid,d.reachname,sum(ticketnum) sellnum,")
			.append(" sum(ticketprice) totalprice,count(distinct decode(u.type, '0', d.scheduleid, null)) localsch,")
			.append(" sum(decode(u.type, '0', d.departnum, 0)) localdepartnum,")
			.append(" sum(decode(u.type, '0', d.balanceprice, 0)) localbalanceprice,")
			.append(" count(distinct decode(u.type, '0', null, d.scheduleid)) syncsch,")
			.append(" sum(decode(u.type, '0', 0, d.departnum)) syncdepartnum,")
			.append(" sum(decode(u.type, '0', 0, d.balanceprice)) syncbalanceprice,")
			.append(" 0 zwbsticketnum,0 zwbstotalmoney,0 zwwsticketnum,0 zwwstotalmoney,SUM(d.stationservicefee) fcstationservicefee")
			.append("  from invoicesotherprint d, schedule s, route r, vehicle v, unit u")
			.append(" where d.scheduleid = s.id and s.routeid = r.id and d.vehicleno = v.vehicleno  and v.unitid = u.id")
			.append(" and d.departdate between :startdate and :enddate")
			.append(" and s.workways in "+workways);
			if (routeid > 0) {
				sql.append(" and r.id=" + routeid);
			}
			sql.append(" group by d.DEPARTDATE,r.id, d.reachname");
		}*/
		sql.append(" ) group by  routeid,reachname order by reachname");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> list= query.getResultList();
		return list;
	}
	
	public List<Object> qryRouteBalanceIncome(Date startdate,Date enddate,String schedulecode,Long routeid,Long stationid,Boolean isroutegroup,Boolean isstationgroup,Boolean isschedulegroup){
		
		StringBuilder sql = new StringBuilder("select ");
		if(isroutegroup){
			sql.append(" name, ");
		}else{
			sql.append(" '' name, ");
		}
		if(isschedulegroup){
			sql.append(" schedulename, ");
		}else{
			sql.append(" '' schedulename, ");
		}
		if(isstationgroup){
			sql.append(" reachname, ");
		}else{
			sql.append(" '' reachname, ");
		}
				
		sql.append(" sum(schedulenum) schedulenum,sum(zxzdepartnum),sum(zxzbalanceprice),sum(ctzdepartnum),")
		.append("  sum(ctzbalanceprice),sum(hcdepartnum),sum(hcbalanceprice),")
		.append(" sum(zxzdepartnum + ctzdepartnum + hcdepartnum) totaldepartnum,sum(zxzbalanceprice + ctzbalanceprice + hcbalanceprice) totalbalanceprice,")
		.append(" sum(zwticketnum) zwticketnum,sum(zwtotalmoney) zwtotalmoney,sum(hjdepartnum) hjdepartnum,sum(hjbalanceprice) hjbalanceprice,sum(lostnum) nonhjdepartnum,")
		.append("  sum(lostprice)nonhjbalanceprice ") //sum(zxzdepartnum + ctzdepartnum + hcdepartnum) - sum(hjdepartnum) 
		
		.append(" from (select ");
		if(isroutegroup){
			sql.append(" r.name, ");
		}
		if(isschedulegroup){
			sql.append(" sc.code as schedulename, ");
		}
		if(isstationgroup){
			sql.append(" s.name as reachname, ");
		}
		
		sql.append(" 0 schedulenum,sum(case when ts.sellway in (0,1,2,3,4,5,6,8,9) then 1 else 0 end) zxzdepartnum,")
		.append(" sum(case when ts.sellway in (0,1,2,3,4,5,6,8,9) then ts.price else 0 end) zxzbalanceprice,")
		.append(" sum(case when ts.sellway in (10,13) then 1 else 0 end) ctzdepartnum,")
		.append(" sum(case when ts.sellway in (10,13) then ts.price else 0 end) ctzbalanceprice,")
		.append(" sum(case when ts.sellway in (7) then 1 else 0 end) hcdepartnum,")
		.append(" sum(case when ts.sellway in (7) then ts.price else 0 end) hcbalanceprice,")
		.append(" sum(case ts.isdepartinvoices when 0 then ts.price else 0 end) lostprice, ") //24259 湖北+松滋客运站+发班营收统计表数据对不上
		.append(" sum(case ts.isdepartinvoices when 0 then 1 else 0 end) lostnum, ")
		.append(" 0 zwticketnum,0 zwtotalmoney,0 hjdepartnum,0 hjbalanceprice")
		.append(" from ticketsell ts,station s,schedule sc,route r")
		.append(" where ts.scheduleid = sc.id and sc.routeid = r.id and s.id = ts.reachstationid and ts.ticketstatus = '0'")
		.append("  and ts.departdate between :startdate and :enddate");
		
		if(routeid>0){
			sql.append(" and r.id = :routeid ");
		}
//		if(scheduleid>0){
//			sql.append(" and sc.id = :scheduleid ");
//		}
		if(schedulecode!="" && schedulecode!=null){
			sql.append(" and sc.code like '%"+schedulecode+"%'");
		}
		if(stationid>0){
			sql.append(" and s.id = :stationid ");
		}
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" r.name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" sc.code ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" s.name ");
		}
										
		sql.append(" union all  select ");
		
		if(isroutegroup){
			sql.append(" r.name, ");
		}
		if(isschedulegroup){
			sql.append(" s.code as schedulename, ");
		}
		if(isstationgroup){
			sql.append(" st.name as reachname, ");
		}
							
		sql.append(" 0 schedulenum, 0 zxzdepartnum,0 zxzbalanceprice,0 ctzdepartnum,0 ctzbalanceprice,0 hcdepartnum,0 hcbalanceprice,0 lostprice,0 lostnum,sum(d.ticketnum) zwticketnum,")
		.append("  sum(d.totalmoney) zwtotalmoney,0 hjdepartnum,0 hjbalanceprice  from departinvoicesother d,")
		.append("  schedule  s,station st,route r")
		.append("  where d.scheduleid = s.id   and s.routeid = r.id and r.endstationid = st.id")
		.append("   and d.departdate between :startdate and :enddate and d.datafrom not in (8,10) ")
		.append("  and d.status <> '1' ");
		if(routeid>0){
			sql.append(" and r.id = :routeid ");
		}
		//		if(scheduleid>0){
		//		sql.append(" and s.id = :scheduleid ");
		//	}
		if(schedulecode!="" && schedulecode!=null){
			sql.append(" and s.code like '%"+schedulecode+"%'");
		}
		if(stationid>0){
			sql.append(" and st.id = :stationid ");
		}
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" r.name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" s.code ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" st.name ");
		}
		sql.append(" union all  select ");
		
		if(isroutegroup){
			sql.append(" r.name, ");
		}
		if(isschedulegroup){
			sql.append(" s.code as schedulename, ");
		}
		if(isstationgroup){
			sql.append(" st.name as reachname, ");
		}
	    sql.append("            0 schedulenum,                                          ")
	    .append("            0 zxzdepartnum,                                         ")
	    .append("            0 zxzbalanceprice,                                      ")
	    .append("            0 ctzdepartnum,                                         ")
	    .append("            0 ctzbalanceprice,                                      ")
	    .append("            0 hcdepartnum,                                          ")
	    .append("            0 hcbalanceprice,                                       ")
	    .append("            0 lostprice,0 lostnum,                                  ")
	    .append("            0 zwticketnum,                                          ")
	    .append("            0 zwtotalmoney,                                         ")
	    .append("            sum(case when d.datafrom<>8 then d.ticketnum else 0 end) hjdepartnum,                                ")
	    .append("            sum(case when d.datafrom<>8 then d.totalmoney-d.stationfee else 0 end) hjbalanceprice                                        ")
	    .append("       from departinvoicesother d, schedule s, station st, route r  ")
	    .append("      where d.scheduleid = s.id                                     ")
	    .append("        and s.routeid = r.id                                        ")
	    .append("        and r.endstationid = st.id                                  ")
	    .append("        and d.departdate between :startdate and :enddate            ")
	    .append("        and d.status <> '1'                                         ");
	    if(routeid>0){
			sql.append(" and r.id = :routeid ");
		}
		if(schedulecode!="" && schedulecode!=null){
			sql.append(" and s.code like '%"+schedulecode+"%'");
		}
		if(stationid>0){
			sql.append(" and st.id = :stationid ");
		}
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" r.name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" s.code ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" st.name ");
		}
        sql.append(" union all  select ");
		
		if(isroutegroup){
			sql.append(" r.name, ");
		}
		if(isschedulegroup){
			sql.append(" s.code as schedulename, ");
		}
		if(isstationgroup){
			sql.append(" st.name as reachname, ");
		}
							
		sql.append(" count(d.id) schedulenum, 0 zxzdepartnum,0 zxzbalanceprice,0 ctzdepartnum,0 ctzbalanceprice,0 hcdepartnum,0 hcbalanceprice,0 lostprice,0 lostnum,0 zwticketnum,")
		.append("  0 zwtotalmoney,0 hjdepartnum,0 hjbalanceprice  from departinvoices d, schedule s, station st, route r ")
		.append("  where  d.scheduleid = s.id and s.routeid = r.id and r.endstationid = st.id  ")
		.append("   and d.departdate between :startdate and :enddate ");		
		if(routeid>0){
			sql.append(" and r.id = :routeid ");
		}
//		if(scheduleid>0){
//		sql.append(" and s.id = :scheduleid ");
//	    }
		if(schedulecode!="" && schedulecode!=null){
			sql.append(" and s.code like '%"+schedulecode+"%'");
		}
		if(stationid>0){
			sql.append(" and st.id = :stationid ");
		}
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" r.name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" s.code ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" st.name ");
		}
									
		sql.append(" union all select ");
		
		if(isroutegroup){
			sql.append(" name, ");
		}
		if(isschedulegroup){
			sql.append(" schedulename, ");
		}
		if(isstationgroup){
			sql.append(" reachname, ");
		}
				
		sql.append(" sum(schedulenum) schedulenum,0 zxzdepartnum,0 zxzbalanceprice, 0 ctzdepartnum,0 ctzbalanceprice,0 hcdepartnum,0 hcbalanceprice,0 lostprice,0 lostnum,0 zwticketnum,0 zwtotalmoney, ")
		.append(" sum(deinzxzdepartnum+deinctzdepartnum+deinhcdepartnum) hjdepartnum,sum(deinzxzbalanceprice+deinctzbalanceprice+deinhcbalanceprice) hjbalanceprice ")
		.append(" from (select ");
		
		if(isroutegroup){
			sql.append(" r.name, ");
		}
		if(isschedulegroup){
			sql.append(" sc.code as schedulename, ");
		}
		if(isstationgroup){
			sql.append(" s.name as reachname, ");
		}
		
		sql.append(" 0 schedulenum,sum(decode(ts.sellby,39097,0,68997,0,decode(ts.orgid, 3, 0, 1))) deinzxzdepartnum, ")
		.append(" round(sum(decode(ts.sellby,39097,0,68997,0,decode(ts.orgid,3,0,t.balanceamount / t.ticketnum))),2) deinzxzbalanceprice, ")
		.append(" sum(decode(ts.sellby,39097,0,68997,0,decode(ts.orgid, 3, 1, 0))) deinctzdepartnum, ")
		.append(" round(sum(decode(ts.sellby,39097,0,68997,0,decode(ts.orgid,3,t.balanceamount / t.ticketnum,0))),2) deinctzbalanceprice, ")
		.append(" sum(decode(ts.sellby, 39097, 1, 68997, 1, 0)) deinhcdepartnum,round(sum(decode(ts.sellby,39097,t.balanceamount / t.ticketnum,68997,t.balanceamount / t.ticketnum,0)), 2) deinhcbalanceprice, ")
		.append(" 0 zwticketnum, 0 zwtotalmoney  from ticketsell ts,departinvoices t,station s, schedule sc, route r  ")
		.append(" where t.scheduleid = sc.id and ts.departinvoicesid = t.id  and ts.isdepartinvoices = 1 and sc.routeid = r.id ")
		.append(" and t.status <> '1' and s.id = ts.reachstationid ")		
		.append("  and t.departdate between :startdate and :enddate ");
		if(routeid>0){
			sql.append(" and r.id = :routeid ");
		}
//		if(scheduleid>0){
//		sql.append(" and sc.id = :scheduleid ");
//	    }
		if(schedulecode!="" && schedulecode!=null){
			sql.append(" and sc.code like '%"+schedulecode+"%'");
		}
		if(stationid>0){
			sql.append(" and s.id = :stationid ");
		}
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" r.name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" sc.code ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" s.name ");
		}
		
		sql.append(" ) ");
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" schedulename ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" reachname ");
		}
		
		sql.append(" ) ");
		
		if(isroutegroup||isschedulegroup||isstationgroup){
			sql.append(" group by ");
		}
		if (isroutegroup ) {
			sql.append(" name ");
		}
		if(isschedulegroup){
			if(isroutegroup){sql.append(" , ");}
			sql.append(" schedulename ");
		}
		if (isstationgroup) {
			if(isroutegroup || isschedulegroup){sql.append(" , ");}
			sql.append(" reachname ");
		}										
		
		Query query = getEntityManager().createNativeQuery(sql.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		if(routeid>0){
			query.setParameter("routeid", routeid);
		}
//		if(scheduleid>0){
//			query.setParameter("scheduleid", scheduleid);
//		}
		if(stationid>0){
			query.setParameter("stationid", stationid);
		}
		List<Object> list= query.getResultList();
		return list;
		
		
		
	}
}
