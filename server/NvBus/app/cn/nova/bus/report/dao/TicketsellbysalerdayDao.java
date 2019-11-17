package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import play.Logger;

import cn.nova.bus.dao.EntityManagerDaoSurport;
/**
 * 
 * <b>类描述：重构了售票员售票日报表</b><br/>
 * <b>类名称：</b>TicketsellbysalerdayDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@bus365.com">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b>2017-11-23<br/>
 * <b>修改人：</b><br/>
 *
 */
public class TicketsellbysalerdayDao extends EntityManagerDaoSurport {

	/**
	 * 
	 *   querySalerdayRevenue方法：售票员售票日报表,
	 *   该报表数据取自于GENTICKETSELLBYSALERDAY过程生成的表ticketsellbysalerday中的数据<br/>
	 * <br/>
	 * @param orgids
	 * @param startdate
	 * @param enddate
	 * @param isbyseller
	 * @param isbyselldate
	 * @param sellerids
	 * @param ticketoutletid
	 * @param paymethod
	 * @return 
	 * @exception
	 */
	public List<Object> querySalerdayRevenue(String orgids, Date startdate,	Date enddate, boolean isbyseller, boolean isbyselldate,
			String sellerids, String ticketoutletid, String paymethod) {
		StringBuilder sql = new StringBuilder("");
		StringBuilder sqlSel = new StringBuilder("");
		//按机构、售票日期、用户统计
		String selectUserDateSQL="select u.code,u.name,o.name orgname,selldate,";
		//按机构、用户统计
		String selectUserSQL="select u.code,u.name,o.name orgname,null selldate,";
		//按机构、售票日期统计
		String selectDateSQL="select null code,null name,o.name orgname,selldate,"; 
		//按机构统计
		String selectOrgSQL="select null code,null name,o.name orgname,null selldate,";	
		
		sql.append("    nvl(sum(td.datescheduleincome), 0) datescheduleincome,sum(td.sellnum) sellnum,")
		.append("    sum(td.sellnum) - sum(td.cancelnum) - sum(td.returnnum) as normalnum,")
		.append("    sum(td.totalprice) totalprice, sum(td.cancelnum) cancelnum,sum(td.cancelmoeny) cancelmoeny,")
		.append("    sum(td.returnnum) returnnum,sum(td.returnprice) returnprice,sum(td.returnprice-td.returnfee) returncustomerprice,sum(td.returnfee) returnfee,")
		.append("    sum(td.fueladditionfee) fueladditionfee,sum(td.servicefee) servicefee,")
		.append("    sum(td.sellnum - td.cancelnum) nomalsellnum,")
		.append("    sum(td.totalprice - td.returnprice - td.cancelmoeny) nomaltotalprice,")
		.append("    sum(td.stationservicefee) stationservicefee,sum(td.computefee) computefee,")
		.append("    sum(td.coolairfee) coolairfee,sum(td.additionfee) additionfee,sum(td.totalfee) totalfee,")
		.append("    sum(td.badnum) badnum,sum(td.totalprice - td.returnprice + td.returnfee - td.cancelmoeny+ td.servicefee) upmoney,")
		.append("    sum(moreprice) moreprice,sum(td.waterfee) waterfee,sum(td.insurefee) insurefee,sum(td.otherfee) otherfee,")
		.append("    sum(td.totalprice - td.returnprice + td.returnfee - td.cancelmoeny + td.servicefee - td.totalfee) stationincome,")
		.append("    sum(td.takeeticketnum) takeeticketnum,sum(nvl(td.changenum, 0)) as changenum,")
		.append("    sum(nvl(td.adjustnum, 0)) as adjustnum,sum(nvl(td.BADNUM, 0)) as damagednum,")
		.append("    sum(nvl(td.returnbillnum, 0)) as ticketreturnnum,")
		.append("    sum(td.sellbillnum) + sum(td.changenum) + sum(td.adjustnum) + sum(td.BADNUM)  + sum(td.returnbillnum)+sum(td.takeeticketnum)")
		.append("  from ticketsellbysalerday td  left join userinfo u ")
		.append("       on td.sellby = u.id  left join organization o")
		.append("       on td.orgid = o.id   left join ticketoutlets tl")
		.append("       on tl.id = td.ticketoutletsid  left join digitaldictionarydetail d")
		.append("       on d.code = td.paymethod  and d.digitaldictionaryid = 50 ")
		.append("  where 1 = 1")
		.append(" and o.id in " + orgids)
		.append(" and td.selldate between :startdate and :enddate+0.99999");
		//售票点条件
		String ticketoutletCodition="";//售票点查询条件
		String selTicketoutlet=" null as  ticketoutlet, ";//售票点查询字段
		String groupbyTicketoutlet="";//售票点分组字段
		if (ticketoutletid != null && ticketoutletid.length() > 0) {
			ticketoutletCodition=" and td.ticketoutletsid in " + ticketoutletid;
			selTicketoutlet=" tl.name ticketoutlet, ";
			groupbyTicketoutlet=" ,tl.name";
		}
		//支付方式
		String paymethodCodition="";
		String selPaymethod=" null as paymethod, ";
		String groupbyPaymethod="";
		if (paymethod.length() == 3 && paymethod.indexOf("1")==1 ) {//paymethod = (1)  按照电子支付统计
			selPaymethod=" d.value as paymethod, ";
			paymethodCodition=" and d.code <> '0' ";
			groupbyPaymethod=" ,d.value";
		}
		if (paymethod.length() == 3 && paymethod.indexOf("2")==1 ) {//paymethod = (2)  按照现金支付统计
			selPaymethod=" d.value as paymethod, ";
			paymethodCodition=" and d.code = '0' ";
			groupbyPaymethod=" ,d.value";
		}
		//按机构、售票日期、用户分组
		StringBuilder groupUserDateSQL = new StringBuilder("")
		     .append(" group by o.name,td.selldate,u.code,u.name ");
			// .append("   order by o.name,td.selldate,u.name");
		//按机构、用户分组
		StringBuilder groupUserSQL=new StringBuilder("")
	     	.append(" group by o.name,u.name,u.code ");
			//.append("   order by o.name,u.name");
		//按机构、售票日期分组
		StringBuilder groupDateSQL=new StringBuilder("")
	     	.append(" group by o.name,td.selldate ");
	     //	.append("   order by o.name,td.selldate ");
		//按机构分组
		StringBuilder groupOrgSQL=new StringBuilder("")
	     .append(" group by o.name ");
		// .append("   order by o.name");	
		if (isbyselldate) {
			if (isbyseller) {
				sqlSel.append(selectUserDateSQL).append(selTicketoutlet).append(selPaymethod)
				 .append(sql.toString())
				.append("  and td.sellby>0 and u.id in " + sellerids)
				.append(paymethodCodition).append(ticketoutletCodition)
				.append(groupUserDateSQL).append(groupbyTicketoutlet)
				.append(groupbyPaymethod);		
			}else{
				sqlSel.append(selectDateSQL).append(selTicketoutlet).append(selPaymethod).append(sql.toString())	
			    .append(paymethodCodition).append(ticketoutletCodition)
				.append(groupDateSQL).append(groupbyTicketoutlet)
				.append(groupbyPaymethod);	
			}
		}
		else{
			if (isbyseller) {
				sqlSel.append(selectUserSQL).append(selTicketoutlet).append(selPaymethod).append(sql.toString())			
				.append("  and td.sellby>0 and u.id in " + sellerids)
				.append(paymethodCodition).append(ticketoutletCodition)
				.append(groupUserSQL).append(groupbyTicketoutlet)
				.append(groupbyPaymethod);		
			}else{
				sqlSel.append(selectOrgSQL).append(selTicketoutlet).append(selPaymethod).append(sql.toString())	
				.append(paymethodCodition).append(ticketoutletCodition)
				.append(groupOrgSQL).append(groupbyTicketoutlet)
				.append(groupbyPaymethod);	
			}
		}
		String orderby=" order by o.name";
		sqlSel.append(orderby);
		Query query = getEntityManager().createNativeQuery(sqlSel.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		Logger.info("querySalerdayRevenue.sql:---------->"+sqlSel.toString());		
		List list = query.getResultList();
		Logger.info("size:--------->" + list.size());
		return list;
	}	
}
