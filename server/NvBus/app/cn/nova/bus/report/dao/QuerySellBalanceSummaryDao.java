package cn.nova.bus.report.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

public class QuerySellBalanceSummaryDao extends EntityManagerDaoSurport{
	/*
	 * 售票点结算汇总表DAO
	 */
	public List<Object> query(String printorgids,String sellorgids,
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
		
		//处理条件语句
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String startdatestr = sf.format(startdate);
		String enddatestr = sf.format(enddate);
		
		StringBuffer consql1 = new StringBuffer(" ");  //所有的开运量单的车票
		StringBuffer consql2 = new StringBuffer(" ");  //所有的漏乘的车票
		StringBuffer consql3 = new StringBuffer(" ");  //所有的退票的车票
		StringBuffer consql4 = new StringBuffer(" ");  //所有的废票的车票
		StringBuffer consql5 = new StringBuffer(" ");  //所有未注销的结算单 
		if(printorgids!=null && !printorgids.equals("")){
			consql1.append(" and d.printorgid in "+printorgids); 
			consql2.append(" and vr.reportorgid in "+printorgids);
			consql3.append(" and vr.reportorgid in "+printorgids);
			consql4.append(" and vr.reportorgid in "+printorgids);
			consql5.append(" and d.printorgid in "+printorgids);
		}
		if(sellorgids!=null && !sellorgids.equals("")){
			consql1.append(" and ts.ticketoutletsid in "+sellorgids); 
			consql2.append(" and ts.ticketoutletsid in "+sellorgids);
			consql3.append(" and ts.ticketoutletsid in "+sellorgids);
			consql4.append(" and ts.ticketoutletsid in "+sellorgids);
			consql5.append(" and tsinc.ticketoutletsid in "+sellorgids);
		}
		if(startdate!=null && enddate!=null){
			consql1.append(" and ts.departdate between date'"+startdatestr+"' and date'"+enddatestr+"' ");
			consql2.append(" and ts.departdate between date'"+startdatestr+"' and date'"+enddatestr+"' ");
			consql3.append(" and ts.departdate between date'"+startdatestr+"' and date'"+enddatestr+"' ");
			consql4.append(" and ts.departdate between date'"+startdatestr+"' and date'"+enddatestr+"' ");
			consql5.append(" and d.departdate between date'"+startdatestr+"' and date'"+enddatestr+"' ");
		}
		if(routeid!=null && routeid>0){
			consql1.append(" and r.id="+routeid); 
			consql2.append(" and r.id="+routeid);
			consql3.append(" and r.id="+routeid);
			consql4.append(" and r.id="+routeid);
			consql5.append(" and r.id="+routeid);
		}
		if(scheduleid!=null && scheduleid>0){
			consql1.append(" and s.id="+scheduleid); 
			consql2.append(" and s.id="+scheduleid);
			consql3.append(" and s.id="+scheduleid);
			consql4.append(" and s.id="+scheduleid);
			consql5.append(" and s.id="+scheduleid);
		}
		if(vehicleid!=null && vehicleid>0){
			consql1.append(" and v.id="+vehicleid); 
			consql2.append(" and v.id="+vehicleid);
			consql3.append(" and v.id="+vehicleid);
			consql4.append(" and v.id="+vehicleid);
			consql5.append(" and v.id="+vehicleid);
		}
		
		/*sql*/
		StringBuffer sql = new StringBuffer();
		sql.append(" select porg.name printorgname, ")
	       .append(" tl.name sellorgname, ")
	       .append(" sum(invoicenum) invoicenum, ")
	       .append(" sum(printpeople)+sum(nonfactnum)+sum(returnnum)+sum(cancelnum) ticketnum, ")
	       .append(" sum(schnum) schnum, ")
	       .append(" sum(seatnum) seatnum, ")
	       .append(" sum(printpeople) printpeople, ")
	       .append(" sum(nonfactnum) nonfactnum, ")
	       .append(" sum(returnnum) returnnum, ")
	       .append(" sum(cancelnum) cancelnum, ")
	       .append(" sum(totalamount)+sum(nonfactamount)+sum(returnamount)+sum(cancelamount) sellamount, ")
	       .append(" sum(totalamount) totalamount, ")
	       .append(" sum(invoiceamount) invoiceamount, ")
	       .append(" sum(nonfactamount) nonfactamount, ")
	       .append(" sum(returnamount) returnamount, ")
	       .append(" sum(cancelamount) cancelamount, ")
	       .append(" sum(balanceamount)-sum(agentfee) balanceamount, ")
	       .append(" sum(charges)+sum(servicefee) shouxufee, ")
	       .append(" sum(totalamount) - sum(balanceamount)+sum(nonfactamount) + sum(charges) + sum(servicefee) revenueamount, ")
	       .append(" sum(stationservicefee) stationservicefee, ")
	       .append(" sum(fueladditionfee) fueladditionfee, ")
	       .append(" sum(computefee) computefee, ")
	       .append(" sum(coolairfee) coolairfee, ")
	       .append(" sum(additionfee) additionfee, ")
	       .append(" sum(waterfee) waterfee, ")
	       .append(" sum(insurefee) insurefee, ")
	       .append(" sum(otherfee) otherfee, ")
	       .append(" sum(totalfee) totalfee, ")
	       .append(" sum(agentfee) agentfee, ")
	       .append(" sum(agentfee+charges+servicefee+totalfee) ticketoutsmoney, ")
	       .append(" sum(printpeople) + sum(nonfactnum) ticketvalidatenum, ")
	       .append(" sum(totalamount) + sum(nonfactamount) sellvalidateamount ")
	  .append(" from ( ")
	  //所有的开运量单的上车车票
	  	.append(" select d.printorgid printorgid, ")
               .append(" ts.ticketoutletsid as selloutletsid, ")
               .append(" 0 invoicenum, ")
               .append(" count(ts.id) ticketnum, ")
               .append(" 0 schnum, ")
               .append(" sum(case sp.islinework ")
                     .append(" when 0 then ")
                      .append(" (sp.seatnum - sp.fixedreserveseatnum) ")
                     .append(" else ")
                      .append(" v.seatnum ")
                   .append(" end) seatnum, ")
               .append(" count(ts.id) printpeople, ")
               .append(" sum(ts.price) totalamount, ")
               .append(" 0 nonfactnum, ")
               .append(" 0 nonfactamount, ")
               .append(" 0 returnnum, ")
               .append(" 0 returnamount, ")
               .append(" 0 charges, ")
               .append(" 0 cancelnum, ")
               .append(" 0 cancelamount, ")
               .append(" sum(ts.servicefee) servicefee, ")
               .append(" sum(ts.moreprice) moreprice, ")
               .append(" sum(ts.price - ts.moreprice) invoiceamount, ")
               .append(" sum(ts.price-ts.moreprice)-sum(ts.stationservicefee + ts.fueladditionfee + ts.computefee + ")
                   .append(" ts.coolairfee + ts.additionfee + ts.waterfee + ")
                   .append(" ts.insurefee + ts.otherfee) balanceamount, ")
               .append(" 0 revenueamount, ")
               .append(" sum(ts.stationservicefee) stationservicefee, ")
               .append(" sum(ts.fueladditionfee) fueladditionfee, ")
               .append(" sum(ts.computefee) computefee, ")
               .append(" sum(ts.coolairfee) coolairfee, ")
               .append(" sum(ts.additionfee) additionfee, ")
               .append(" sum(ts.waterfee) waterfee, ")
               .append(" sum(ts.insurefee) insurefee, ")
               .append(" sum(ts.otherfee) otherfee, ")
               .append(" sum(ts.stationservicefee + ts.fueladditionfee + ts.computefee + ")
                   .append(" ts.coolairfee + ts.additionfee + ts.waterfee + ")
                   .append(" ts.insurefee + ts.otherfee) totalfee, ")
               .append(" 0 agentfee ")
	          .append(" from departinvoices d, ")
	               .append(" ticketsell     ts, ")
	               .append(" schedule       s, ")
	               .append(" scheduleplan sp, ")
	               .append(" vehicle v, ")
	               .append(" route r ")
	         .append(" where ts.departinvoicesid = d.id ")
	           .append(" and ts.scheduleid = s.id ")
	           .append(" and s.routeid = r.id ")
	           .append(" and ts.scheduleplanid = sp.id ")
	           .append(" and d.vehicleid = v.id ")
	           .append(" and ts.isdepartinvoices = '1' ") //已开运量单
	   .append(consql1.toString())     
	         .append(" group by d.printorgid, ts.ticketoutletsid ")
	        //漏乘
	        .append(" union all ")
	        .append(" select vr.reportorgid printorgid, ")
	               .append(" ts.ticketoutletsid as selloutletsid, ")
	               .append(" 0 invoicenum, ")
	               .append(" 0 ticketnum, ")
	               .append(" 0 schnum, ")
	               .append(" 0 seatnum, ")
	               .append(" 0 printpeople, ")
	               .append(" 0 totalamount, ")
	               .append(" count(ts.id) nonfactnum, ")
	               .append(" sum(ts.price) nonfactamount, ")
	               .append(" 0 returnnum, ")
	               .append(" 0 returnamount, ")
	               .append(" 0 charges, ")
	               .append(" 0 cancelnum, ")
	               .append(" 0 cancelamount, ")
	               .append(" sum(ts.servicefee) servicefee, ")
	               .append(" 0 moreprice, ")
	               .append(" 0 invoiceamount, ")
	               .append(" 0 balanceamount, ")
	               .append(" 0 revenueamount, ")        
	               .append(" 0 stationservicefee, ")
	               .append(" 0 fueladditionfee, ")
	               .append(" 0 computefee, ")
	               .append(" 0 coolairfee, ")
	               .append(" 0 additionfee, ")
	               .append(" 0 waterfee, ")
	               .append(" 0 insurefee, ")
	               .append(" 0 otherfee, ")
	               .append(" 0 totalfee, ")
	               .append(" 0 agentfee ")
	         .append(" from  ticketsell     ts, ")
	               .append(" schedule       s, ")
	               .append(" scheduleplan sp, ")
	               .append(" (select t. scheduleid,t.reportorgid,t.vehicleid from ")
	                 .append(" (select scheduleid,reportorgid,vehicleid, ")
	                 .append(" row_number()over(partition by scheduleid order by reportorgid) as no_1 ")
	                 .append(" from vehiclereport) t where t.no_1=1 ")
	               .append(" ) vr, ") 
	               .append(" vehicle v, ")
	               .append(" route r ")
	         .append(" where ts.scheduleid = s.id ")
	           .append(" and ts.scheduleplanid = sp.id ")
	           .append(" and s.id=vr.scheduleid ")
	           .append(" and s.routeid = r.id ")
	           .append(" and vr.vehicleid = v.id ")
	           .append(" and ts.isdepartinvoices = '0' ") //未开运量单
	           .append(" and ts.ticketstatus='0' ") //漏乘
	  .append(consql2.toString())         
	         .append(" group by vr.reportorgid, ts.ticketoutletsid ")
	        //退票
	         .append(" union all ")
	        .append(" select vr.reportorgid printorgid, ")
	               .append(" ts.ticketoutletsid as selloutletsid, ")
	               .append(" 0 invoicenum, ")
	               .append(" 0 ticketnum, ")
	               .append(" 0 schnum, ")
	               .append(" 0 seatnum, ")
	               .append(" 0 printpeople, ")
	               .append(" 0 totalamount, ")
	               .append(" 0 nonfactnum, ")
	               .append(" 0 nonfactamount, ")
	               .append(" count(ts.id) returnnum, ")
	               .append(" sum(ts.price) returnamount, ")
	               .append(" sum(tr.charges) charges, ")
	               .append(" 0 cancelnum, ")
	               .append(" 0 cancelamount, ")
	               .append(" sum(ts.servicefee) servicefee, ")
	               .append(" 0 moreprice, ")
	               .append(" 0 invoiceamount, ")
	               .append(" 0 balanceamount, ")
	               .append(" 0 revenueamount, ")        
	               .append(" 0 stationservicefee, ")
	               .append(" 0 fueladditionfee, ")
	               .append(" 0 computefee, ")
	               .append(" 0 coolairfee, ")
	               .append(" 0 additionfee, ")
	               .append(" 0 waterfee, ")
	               .append(" 0 insurefee, ")
	               .append(" 0 otherfee, ")
	               .append(" 0 totalfee, ")
	               .append(" 0 agentfee ")
	         .append(" from  ticketsell     ts, ")
	               .append(" schedule       s, ")
	               .append(" scheduleplan sp, ")
	               .append(" (select t. scheduleid,t.reportorgid,t.vehicleid from ")
	                 .append(" (select scheduleid,reportorgid,vehicleid, ")
	                 .append(" row_number()over(partition by scheduleid order by reportorgid) as no_1 ")
	                 .append(" from vehiclereport) t where t.no_1=1 ")
	               .append(" ) vr, ") 
	               .append(" vehicle v, ")
	               .append(" route r, ")
	               .append(" ticketreturn tr ")
	         .append(" where ts.scheduleid = s.id ")
	           .append(" and ts.scheduleplanid = sp.id ")
	           .append(" and s.id=vr.scheduleid ")
	           .append(" and s.routeid = r.id ")
	           .append(" and vr.vehicleid = v.id ")
	           .append(" and ts.isdepartinvoices = '0' ") //未开运量单
	           .append(" and ts.ticketstatus='1' ") //退票
	           .append(" and tr.sellid=ts.id ")
	  .append(consql3.toString())         
	         .append(" group by vr.reportorgid, ts.ticketoutletsid ")
	       //废票
	        .append(" union all ")
	        .append(" select vr.reportorgid printorgid, ")
	               .append(" ts.ticketoutletsid as selloutletsid, ")
	               .append(" 0 invoicenum, ")
	               .append(" 0 ticketnum, ")
	               .append(" 0 schnum, ")
	               .append(" 0 seatnum, ")
	               .append(" 0 printpeople, ")
	               .append(" 0 totalamount, ")
	               .append(" 0 nonfactnum, ")
	               .append(" 0 nonfactamount, ")
	               .append(" 0 returnnum, ")
	               .append(" 0 returnamount, ")
	               .append(" 0 charges, ")
	               .append(" count(ts.id) cancelnum, ")
	               .append(" sum(ts.price) cancelamount, ")
	               .append(" sum(ts.servicefee) servicefee, ")
	               .append(" 0 moreprice, ")
	               .append(" 0 invoiceamount, ")
	               .append(" 0 balanceamount, ")
	               .append(" 0 revenueamount, ")        
	               .append(" 0 stationservicefee, ")
	               .append(" 0 fueladditionfee, ")
	               .append(" 0 computefee, ")
	               .append(" 0 coolairfee, ")
	               .append(" 0 additionfee, ")
	               .append(" 0 waterfee, ")
	               .append(" 0 insurefee, ")
	               .append(" 0 otherfee, ")
	               .append(" 0 totalfee, ")
	               .append(" 0 agentfee ")
	         .append(" from  ticketsell     ts, ")
	               .append(" schedule       s, ")
	               .append(" scheduleplan sp, ")
	               .append(" (select t. scheduleid,t.reportorgid,t.vehicleid from ")
	                 .append(" (select scheduleid,reportorgid,vehicleid, ")
	                 .append(" row_number()over(partition by scheduleid order by reportorgid) as no_1 ")
	                 .append(" from vehiclereport) t where t.no_1=1 ")
	               .append(" ) vr, ") 
	               .append(" vehicle v, ")
	               .append(" route r ")
	         .append(" where ts.scheduleid = s.id ")
	           .append(" and ts.scheduleplanid = sp.id ")
	           .append(" and s.id=vr.scheduleid ")
	           .append(" and s.routeid = r.id ")
	           .append(" and vr.vehicleid = v.id ")
	           .append(" and ts.isdepartinvoices = '0' ") //未开运量单
	           .append(" and ts.ticketstatus='2' ") //废票
	  .append(consql4.toString())         
	         .append(" group by vr.reportorgid, ts.ticketoutletsid ") 
	       //所有未注销的结算单 
	        .append(" union all ")
	        .append(" select d.printorgid printorgid, ")
	              .append(" tsinc.ticketoutletsid as selloutletsid, ")
	               .append(" count(d.id) invoicenum, ")
	               .append(" 0 ticketnum, ")
	               .append(" count(distinct d.reportid) schnum, ")
	               .append(" 0 seatnum, ")
	               .append(" 0 printpeople, ")
	               .append(" 0 totalamount, ")
	               .append(" 0 nonfactnum, ")
	               .append(" 0 nonfactamount, ")
	               .append(" 0 returnnum, ")
	               .append(" 0 returnamount, ")
	               .append(" 0 charges, ")
	               .append(" 0 cancelnum, ")
	               .append(" 0 cancelamount, ")
	               .append(" 0 servicefee, ")
	               .append(" 0 moreprice, ")
	               .append(" 0 invoiceamount, ")
	               .append(" 0 balanceamount, ")
	               .append(" 0 revenueamount, ")        
	               .append(" 0 stationservicefee, ")
	               .append(" 0 fueladditionfee, ")
	               .append(" 0 computefee, ")
	               .append(" 0 coolairfee, ")
	               .append(" 0 additionfee, ")
	               .append(" 0 waterfee, ")
	               .append(" 0 insurefee, ")
	               .append(" 0 otherfee, ")
	               .append(" 0 totalfee, ")
	               .append(" sum(d.agentfee) agentfee ")
	          .append(" from departinvoices d, ")
	               .append(" schedule       s, ")
	               .append(" vehicle        v, ")
	              .append(" route r, ")
	               .append(" (select ts.ticketoutletsid,ts.departinvoicesid from ticketsell ts ") 
	               .append(" group by ts.ticketoutletsid,ts.departinvoicesid) tsinc ")
	         .append(" where d.id=tsinc.departinvoicesid ")
	           .append(" and d.scheduleid = s.id ")
	           .append(" and s.routeid = r.id ")
	           .append(" and d.vehicleid = v.id ")
	           .append(" and d.status <> '1' ") //运量单没有注销
	 .append(consql5.toString())          
		.append(" group by d.printorgid, tsinc.ticketoutletsid ")
	        
	        .append(" ) temp, organization porg, ticketoutlets tl ")
	 .append(" where temp.printorgid=porg.id and temp.selloutletsid = tl.id  ")      
	 .append(" group by porg.name,tl.name ");
		//输出
		//System.out.println("售票结算汇总表 sql--> "+sql.toString());
		//查询
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

}
