package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：售票员售退废日报表;客运班线动态表;客运班线动态同比表</b><br/>
 * <b>类名称：</b>AccountantReportService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28 <br/>
 * <b>关键修改1：1修改售票员售退废报表,添加 是否按售票日期排序，添加 查询结果 改签数</b><br/>
 * <b>关键修改2：2修改售票员售退废报表,添加服务费小计</b> <b>关键修改3：2修改售票员售退废日报表，按售票员和日期 添加小计的功能</b>
 * <b>修改时间：2012-06-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class AccountantReportDao extends EntityManagerDaoSurport {

	/**
	 * 售票员售退废报表
	 * 
	 * @param propertyFilterList
	 * @param groupbydate
	 *            :统计方式，是否按日期排序
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySellerDailyReport(List<PropertyFilter> propertyFilterList, boolean groupbydate,
			String paymethod) {
		StringBuilder sql = new StringBuilder("select ");
		if ("".equals(paymethod) || paymethod.length() > 3) {
			if (groupbydate) {
				sql.append(
						"decode(grouping(o.name)+ grouping(ttd.moneydate)+grouping(u.name||'('||u.code||')') ,1, '', o.name) orgname,")
						.append("decode(grouping(u.name||'('||u.code||')')+ grouping(ttd.moneydate)  ,1, '小计', u.name||'('||u.code||')') username,")
						.append("decode(grouping(u.name||'('||u.code||')')+ grouping(ttd.moneydate)  , 1, '',to_char(ttd.moneydate,'yyyy-mm-dd')) opratedate, ");
			} else {
				sql.append("o.name as orgname,u.name||'('||u.code||')' as username , '' as opratedate,");
			}
			sql.append("sum(ttd.sellnum+sellreturntripnum) sellcount,sum(sellreturntripnum ) sellreturncount,")
					.append("sum(ttd.sellmoney) sellprice,sum(ttd.servicefee) fee,")
					.append("sum(ttd.returnnum) returncount,sum(ttd.returnmoney+ttd.returnhandcharge) returnmoney,")
					.append("sum(ttd.returnhandcharge) chargesmoney,sum(ttd.cancelnum) canclecount,")
					.append("sum(ttd.cancelmoney) cancleprice,sum(ttd.bookservicefee) bookfee,")
					.append("sum(ttd.sellmoney-ttd.returnmoney-ttd.returnhandcharge-ttd.cancelmoney) totalprice,")
					.append("sum(ttd.changeservicefee) changeservicefee,")
					.append("(sum(ttd.sellnum)-sum(ttd.cancelnum)) as allcount,")
					.append("sum(ttd.moneypayable) allmoney,sum(ttd.eticketnum) eticketnum,")
					.append("sum(nvl((select count(tc.id) from ticketchange tc ,ticketsell ts ")
					.append(" 		where tc.changetime Between ttd.moneydate And ttd.moneydate+1 and tc.changeby=u.id")
					.append(" 		  and tc.newticketsellid=ts.id and ts.turnoverdetailid=ttd.id")
					.append(" 	),0)) changenum")
					//.append(",sum(ttd.moneypayable-ttd.nonvouchermoneypayable) cashmoneypayable,")  
					//将其中现金分为现金应缴  和 电子支付营收  两部分
					.append(" ,sum(ttd.moneypayable - ttd.nonvouchermoneypayable - ttd.noncashmoneypayable) as cashmoneypayable, ")//现金应缴
					//.append(" nvl((select sum(ttdp.price) from ticketturnoverdetailepay ttdp where ttdp.ticketturnoverdetailid=ttd.id and ")
					//.append(" ttdp.paymethod not in (0,2,3)),0)) as cashmoneypayable, ")  //现金应缴
					//.append(" sum(nvl((select sum(ttdp.price) from ticketturnoverdetailepay ttdp where ttdp.ticketturnoverdetailid=ttd.id and ")
					//.append("  ttdp.paymethod not in (0,2,3)),0)) as electronicpayment, ")  //电子支付营收
					.append(" sum( ttd.noncashmoneypayable) as electronicpayment,  ")//电子支付营收
					.append("sum(ttd.nonvouchermoneypayable) nonvouchermoneypayable,")
					.append("sum(ttd.bookservicefee+ttd.changeservicefee+ttd.servicefee+ttd.returnhandcharge) totalfee")
					.append(" from ticketturnoverdetail ttd,userinfo u,organization o")
					.append(" where ttd.seller = u.id and u.orgid = o.id ");
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			if (groupbydate) {
				sql.append(" group by rollup( o.name,  u.name||'('||u.code||')',ttd.moneydate) ");
			} else {
				sql.append(" group by o.name,u.name||'('||u.code||')' order by u.name||'('||u.code||')' ");
			}
		} else {
			if (paymethod.length() == 3 && paymethod.indexOf("1") == 1) {
				if (groupbydate) {
					sql.append(
							"decode(grouping(o.name)+ grouping(ttd.moneydate)+grouping(u.name||'('||u.code||')') ,1, '', o.name) orgname,")
							.append("decode(grouping(u.name||'('||u.code||')')+ grouping(ttd.moneydate)  ,1, '小计', u.name||'('||u.code||')') username,")
							.append("decode(grouping(u.name||'('||u.code||')')+ grouping(ttd.moneydate)  , 1, '',to_char(ttd.moneydate,'yyyy-mm-dd')) opratedate, ");
				} else {
					sql.append("o.name as orgname,u.name||'('||u.code||')' as username , '' as opratedate,");
				}
				sql.append("sum(ttd.noncashnum) sellcount,sum(sellreturntripnum ) sellreturncount,")
						.append("sum(ttd.noncashmoney) sellprice,sum(ttd.eservicefee) fee,")
						.append("sum(ttd.eticketreturnnum) returncount,sum(ttd.eticketreturnmoney +ttd.eticketreturncharge) returnmoney,")
						.append("sum(ttd.eticketreturncharge) chargesmoney,0 canclecount,")
						.append("0 cancleprice,sum(ttd.ebookservicefee) bookfee,")
						.append("sum(ttd.noncashmoney+ttd.eticketreturncharge) totalprice,")
						.append("sum(ttd.echangeservicefee) changeservicefee,")
						.append("sum(ttd.noncashnum) as allcount,")
						.append("sum(ttd.noncashmoney) allmoney,0 eticketnum,")
						.append("sum(nvl((select count(tc.id) from ticketchange tc ,ticketsell ts ")
						.append(" 		where tc.changetime Between ttd.moneydate And ttd.moneydate+1 and tc.changeby=u.id")
						.append(" 		  and tc.newticketsellid=ts.id and ts.turnoverdetailid=ttd.id  and ts.paymethod in (5,6)")
						.append(" 	),0)) changenum")
						//.append(",sum(ttd.nonvouchermoneypayable) cashmoneypayable,")  //
						//将其中现金分为现金应缴  和 电子支付营收  两部分
						.append(" ,sum(ttd.moneypayable - ttd.nonvouchermoneypayable - ")
						.append(" nvl((select sum(ttdp.price) from ticketturnoverdetailepay ttdp where ttdp.ticketturnoverdetailid=ttd.id and ")
						.append(" ttdp.paymethod not in (0,2,3)),0)) as cashmoneypayable, ")  //现金营收
						.append(" sum(nvl((select sum(ttdp.price) from ticketturnoverdetailepay ttdp where ttdp.ticketturnoverdetailid=ttd.id and ")
						.append("  ttdp.paymethod not in (0,2,3)),0)) as electronicpayment, ")  //电子支付营收
						.append("0 nonvouchermoneypayable,")
						.append("sum(ttd.ebookservicefee+ttd.echangeservicefee+ttd.eservicefee+ttd.eticketreturncharge) totalfee")
						.append(" from ticketturnoverdetail ttd,userinfo u,organization o")
						.append(" where ttd.seller = u.id and u.orgid = o.id ");
				sql.append(PropertyFilter.toJpql(propertyFilterList, true));
				if (groupbydate) {
					sql.append(" group by rollup( o.name,  u.name||'('||u.code||')',ttd.moneydate) ");
				} else {
					sql.append(" group by o.name,u.name||'('||u.code||')' order by u.name||'('||u.code||')' ");
				}
			} else {
				if (paymethod.length() == 3 && paymethod.indexOf("2") == 1) {
					if (groupbydate) {
						sql.append(
								"decode(grouping(o.name)+ grouping(ttd.moneydate)+grouping(u.name||'('||u.code||')') ,1, '', o.name) orgname,")
								.append("decode(grouping(u.name||'('||u.code||')')+ grouping(ttd.moneydate)  ,1, '小计', u.name||'('||u.code||')') username,")
								.append("decode(grouping(u.name||'('||u.code||')')+ grouping(ttd.moneydate)  , 1, '',to_char(ttd.moneydate,'yyyy-mm-dd')) opratedate, ");
					} else {
						sql.append("o.name as orgname,u.name||'('||u.code||')' as username , '' as opratedate,");
					}
					sql.append(
							"sum(ttd.sellnum+sellreturntripnum-ttd.noncashnum) sellcount,sum(sellreturntripnum ) sellreturncount,")
							.append("sum(ttd.sellmoney-ttd.noncashmoney ) sellprice,sum(ttd.servicefee-ttd.eservicefee ) fee,")
							.append("sum(ttd.returnnum-ttd.eticketreturnnum ) returncount,sum(ttd.returnmoney+ttd.returnhandcharge-ttd.eticketreturnmoney -ttd.eticketreturncharge ) returnmoney,")
							.append("sum(ttd.returnhandcharge-ttd.eticketreturncharge ) chargesmoney,sum(ttd.cancelnum) canclecount,")
							.append("sum(ttd.cancelmoney) cancleprice,sum(ttd.bookservicefee-ttd.ebookservicefee ) bookfee,")
							.append("sum(ttd.sellmoney-ttd.returnmoney-ttd.returnhandcharge-ttd.cancelmoney - ttd.noncashmoney-ttd.eticketreturncharge) totalprice,")
							.append("sum(ttd.changeservicefee-ttd.echangeservicefee) changeservicefee,")
							.append("(sum(ttd.sellnum-ttd.noncashnum)-sum(ttd.cancelnum)) as allcount,")
							.append("sum(ttd.moneypayable-ttd.noncashmoney) allmoney,sum(ttd.eticketnum) eticketnum,")
							.append("sum(nvl((select count(tc.id) from ticketchange tc ,ticketsell ts ")
							.append(" 		where tc.changetime Between ttd.moneydate And ttd.moneydate+1 and tc.changeby=u.id")
							.append(" 		  and tc.newticketsellid=ts.id and ts.turnoverdetailid=ttd.id and ts.paymethod in (0,1,2,3,4)")
							.append(" 	),0)) changenum")
							//.append(",sum(ttd.moneypayable-ttd.nonvouchermoneypayable) cashmoneypayable,")  //
							//将其中现金分为现金应缴  和 电子支付营收  两部分
							.append(" ,sum(ttd.moneypayable - ttd.nonvouchermoneypayable - ")
							.append(" nvl((select sum(ttdp.price) from ticketturnoverdetailepay ttdp where ttdp.ticketturnoverdetailid=ttd.id and ")
							.append(" ttdp.paymethod not in (0,2,3)),0)) as cashmoneypayable, ")  //现金应缴
							.append(" sum(nvl((select sum(ttdp.price) from ticketturnoverdetailepay ttdp where ttdp.ticketturnoverdetailid=ttd.id and ")
							.append("  ttdp.paymethod not in (0,2,3)),0)) as electronicpayment, ")  //电子支付营收
							.append("sum(ttd.nonvouchermoneypayable) nonvouchermoneypayable,")
							.append("sum(ttd.bookservicefee+ttd.changeservicefee+ttd.servicefee+ttd.returnhandcharge-ttd.ebookservicefee-ttd.echangeservicefee-ttd.eservicefee-ttd.eticketreturncharge) totalfee")
							.append(" from ticketturnoverdetail ttd,userinfo u,organization o")
							.append(" where ttd.seller = u.id and u.orgid = o.id ");
					sql.append(PropertyFilter.toJpql(propertyFilterList, true));
					if (groupbydate) {
						sql.append(" group by rollup( o.name,  u.name||'('||u.code||')',ttd.moneydate) ");
					} else {
						sql.append(" group by o.name,u.name||'('||u.code||')' order by u.name||'('||u.code||')' ");
					}
				}
			}

		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 客运班线动态表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryRouteDynamic(String orgids, Date startdate, Date enddate, String departorgs,
			String vehicletype, String districttype, String workways) {
		/*
		 * StringBuilder sql = new StringBuilder("select name,") .append(
		 * " schnum,seats,ticketnum,totalamount,stationservicefee, computefee,")
		 * . append(
		 * " coolairfee,additionfee,firefee,waterfee,insurefee,otherfee," )
		 * .append(
		 * " (coolairfee + additionfee + firefee + waterfee + insurefee +" )
		 * .append(" otherfee + stationservicefee + computefee) xiaoji,")
		 * .append(" agentfee, balanceamount,stationincome, routedistance,")
		 * .append(
		 * " peopledistance,round(peopledistance / routedistance * 100, 2) || '%' as rate,"
		 * ) .append(" round(ticketnum / seats * 100, 2) || '%' as seatrate,")
		 * .append(" to_char(incomerate, '990.99') || '%' as incomerate,")
		 * .append("  moreprice") .append(" from (") .append(
		 * "  select r.name,count(distinct d.reportid) schnum,") .append(
		 * " sum(case sp.islinework  when 0 then sp.seatnum - sp.fixedreserveseatnum"
		 * ) .append("      else ") .append("    (select sum(v.seatnum) seatnum"
		 * ) .append("       from vehiclereport vr, vehicle v") .append(
		 * "         where vr.scheduleplanid = sp.id") .append(
		 * "           and vr.vehicleid = v.id") .append(
		 * "           and vr.isactive = 1") .append(
		 * "           and vr.departdate between :startdate and :enddate" )
		 * .append("           and vr.reportorgid = sp.orgid)") .append(
		 * "     end) seats,") .append(
		 * " sum(d.ticketnum) ticketnum,sum(d.totalamount) totalamount," )
		 * .append(" sum(d.stationservicefee) as stationservicefee,") .append(
		 * " sum(nvl((select sum(dd.deductmoney)") .append(
		 * "        from departinvoicesdeductdetail dd,") .append(
		 * "             balancedeductitem          a") .append(
		 * "       where dd.departinvoicesid = d.id") .append(
		 * "          and dd.balanceitemid = a.id") .append(
		 * "          and dd.status <> '1'") .append(
		 * "          and a.name like '%微机费%'),") .append(
		 * "           0)) computefee,") .append(
		 * "       sum(nvl((select sum(dd.deductmoney)") .append(
		 * "         from departinvoicesdeductdetail dd,") .append(
		 * "                       balancedeductitem          a") .append(
		 * "                  where dd.departinvoicesid = d.id") .append(
		 * "                    and dd.balanceitemid = a.id") .append(
		 * "                    and dd.status <> '1'") .append(
		 * "                    and a.name like '%空调费%'),") .append(
		 * "         0)) coolairfee,") .append(
		 * "      sum(nvl((select sum(dd.deductmoney)") .append(
		 * "                  from departinvoicesdeductdetail dd,") .append(
		 * "                        balancedeductitem          a") .append(
		 * "                 where dd.departinvoicesid = d.id") .append(
		 * "                    and dd.balanceitemid = a.id") .append(
		 * "                     and dd.status <> '1'") .append(
		 * "        and a.name like '%附加费%'),") .append(
		 * "                 0)) additionfee,") .append(
		 * "        sum(d.fueladditionfee) as firefee,") .append(
		 * "       sum(nvl((select sum(dd.deductmoney)") .append(
		 * "               from departinvoicesdeductdetail dd,") .append(
		 * "                 balancedeductitem          a") .append(
		 * "          where dd.departinvoicesid = d.id") .append(
		 * "                   and dd.balanceitemid = a.id") .append(
		 * "                   and dd.status <> '1'") .append(
		 * "                  and a.name like '%配水费%'),") .append(
		 * "             0)) waterfee,") .append(
		 * "    sum(nvl((select sum(dd.deductmoney)") .append(
		 * "   from departinvoicesdeductdetail dd,") .append(
		 * "        balancedeductitem          a") .append(
		 * "   where dd.departinvoicesid = d.id") .append(
		 * "      and dd.balanceitemid = a.id") .append(
		 * "      and dd.status <> '1'") .append(
		 * "      and a.name like '%保险费%'),") .append("    0)) insurefee,")
		 * .append(" sum(nvl((select sum(dd.deductmoney)") .append(
		 * "         from departinvoicesdeductdetail dd,") .append(
		 * "             balancedeductitem          a") .append(
		 * "       where dd.departinvoicesid = d.id") .append(
		 * "          and dd.balanceitemid = a.id") .append(
		 * "           and dd.status <> '1'") .append(
		 * "           and a.name like '%其他%'),") .append(
		 * "        0)) otherfee,") .append("  sum(d.agentfee) agentfee,")
		 * .append("   sum(d.balanceamount) balanceamount,") .append(
		 * "  sum(d.agentfee + d.stationservicefee + d.othterfee) stationincome,"
		 * ) .append("   sum(case sp.islinework") .append("        when 0 then")
		 * .append("        (sp.seatnum - sp.fixedreserveseatnum) * r.distance")
		 * .append("       else") .append(
		 * "        (select sum(v.seatnum) seatnum") .append(
		 * "       from vehiclereport vr, vehicle v") .append(
		 * "     where vr.scheduleplanid = sp.id") .append(
		 * "       and vr.vehicleid = v.id") .append(
		 * "       and vr.isactive = 1") .append(
		 * "       and vr.departdate between  :startdate and :enddate") .append(
		 * "        and vr.reportorgid = sp.orgid) * r.distance") .append(
		 * "  end) routedistance,") .append(
		 * " sum(peopledistance) peopledistance,") .append(
		 * " round(sum(d.totalamount) * 100 /") .append(
		 * "     (select sum(d.totalamount)") .append(
		 * "         from departinvoices d, schedule s, vehicle v") .append(
		 * "        where d.status <> '1'") .append(
		 * "          and d.scheduleid = s.id" + " and s.orgid in " + orgids +
		 * "  and d.printorgid in " + departorgs +
		 * " and d.vehicleid = v.id and v.type in " + vehicletype +
		 * "  and d.departdate between :startdate and :enddate),2) as incomerate,"
		 * ) .append(" sum(d.moreprice) moreprice") .append(
		 * " from departinvoices d,") .append(
		 * "   route r, vehicle v, schedule s, scheduleplan sp,") .append(
		 * "   (select dt.departinvoicesid,") .append(
		 * "    sum(dt.distance * dt.ticketnum) peopledistance") .append(
		 * " from departinvoicesdetail dt") .append(
		 * " where dt.departdate between :startdate and :enddate") .append(
		 * "    group by dt.departinvoicesid) de") .append(
		 * "  where d.scheduleid = s.id") .append("    and s.routeid = r.id")
		 * .append("   and d.id = de.departinvoicesid(+)") .append(
		 * "   and d.scheduleplanid = sp.id") .append(
		 * "   and d.departdate between :startdate and :enddate") .append(
		 * "   and d.status <> '1' and sp.departdate = d.departdate") .append(
		 * " and s.orgid in" + orgids + " and d.printorgid in " + orgids +
		 * " and d.vehicleid = v.id") .append(" and v.type in " + vehicletype +
		 * " group by r.name, r.districttype") .append(
		 * " order by r.districttype desc )");
		 */

		StringBuilder sql = new StringBuilder("select name,")
				.append(" sum(schnum) schnum,sum(seats) seats,sum(ticketnum) ticketnum,")
				.append(" sum(totalamount) totalamount,sum(stationservicefee) stationservicefee,")
				.append(" sum(computefee) computefee,sum(coolairfee) coolairfee,")
				.append(" sum(additionfee) additionfee,sum(fueladditionfee) firefee,sum(waterfee) waterfee,sum(insurefee) insurefee,sum(otherfee) otherfee,")
				.append(" (sum(coolairfee) + sum(additionfee) + sum(fueladditionfee) + sum(waterfee) +sum(insurefee) + sum(otherfee) + sum(stationservicefee) + sum(computefee)) totalfee,")
				.append(" sum(agentfee) agentfee,sum(balanceamount) balanceamount,sum(stationincome) stationincome,")
				.append(" sum(distance * seats) as routedistance,").append(" sum(peopledistance) peopledistance,")
				.append(" (case  sum(distance * seats) when 0 then '0' else(to_char(sum(peopledistance) * 100 / sum(distance * seats), '990.99')) end) || '%' as rate,")
				.append(" (case  sum(seats) when 0 then '0' else( to_char(sum(ticketnum) * 100 / sum(seats), '990.99'))end ) || '%' as seatrate,")
				.append(" to_char(sum(totalamount) * 100 /(select case sum(dt.totalamount) when 0 then 1 else sum(dt.totalamount) end ")
				.append(" from departinvoices dt,schedule s,vehicle v")
				.append("  where dt.status <> '1' and dt.scheduleid=s.id").append(" and dt.vehicleid=v.id")
				.append(" and s.orgid in " + orgids).append(" and dt.printorgid in " + departorgs)
				.append(" and v.type in " + vehicletype).append(" and s.districttype in " + districttype)
				.append(" and s.workways in " + workways)
				.append(" and dt.departdate between :startdate and :enddate),'990.99') || '%' incomerate,")
				.append(" sum(moreprice) moreprice").append(" from (")
				.append(" select r.name,r.distance,count(vr.id) schnum,")
				.append(" sum(case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else")
				.append(" v.seatnum   end) seats,")
				.append("  0 ticketnum,0 totalamount,0 stationservicefee,0 fueladditionfee,0 computefee,")
				.append(" 0 coolairfee,0 additionfee,0 insurefee,0 waterfee,0 otherfee,0 agentfee,0 balanceamount,")
				.append(" 0 stationincome,0 moreprice,0 peopledistance")
				.append(" from vehiclereport vr,route         r,vehicle       v,")
				.append("   schedule      s, scheduleplan  sp,").append("  (select d.reportid")
				.append("      from departinvoices d where d.status <> '1' group by d.reportid) d")
				.append(" where vr.scheduleplanid = sp.id and vr.id = d.reportid")
				.append("    and s.orgid in " + orgids).append("    and v.type in " + vehicletype)
				.append("    and s.districttype in " + districttype).append("    and s.workways in " + workways)
				.append("    and s.routeid = r.id and sp.scheduleid = s.id")
				.append("    and sp.departdate between :startdate and :enddate")
				.append("    and vr.departdate between :startdate and :enddate and vr.isdeparted=1")
				.append("    and sp.departdate = vr.departdate and vr.vehicleid = v.id and vr.isactive = 1")
				.append("    and vr.reportorgid = sp.orgid  group by r.name, r.distance").append(" union all")
				.append(" select r.name,r.distance,0 schnum,0 SEATS,sum(d.ticketnum) ticketnum,")
				.append("    sum(d.totalamount) totalamount,sum(d.stationservicefee) stationservicefee,")
				.append("    sum(d.fueladditionfee) fueladditionfee,")
				.append("    sum(cf.computefee) computefee,sum(cof.coolairfee) coolairfee,")
				.append("    sum(af.additionfee) additionfee,sum(inf.insurefee) insurefee,")
				.append("    sum(wf.waterfee) waterfee,sum(otf.otherfee) otherfee,")
				.append("    sum(d.agentfee) agentfee,sum(d.balanceamount) balanceamount,")
				.append("    sum(d.agentfee + d.fueladditionfee + d.stationservicefee +d.othterfee) stationincome,")
				.append("    sum(d.moreprice) moreprice,").append("    sum(nvl (dd.peopledistance,0)) peopledistance")
				.append("  from departinvoices d,schedule s, route r,vehicle v,")
				.append("      (select dd.departinvoicesid,").append("           sum(dd.deductmoney) computefee")
				.append("         from departinvoicesdeductdetail dd,")
				.append("              balancedeductitem          a").append("          where dd.balanceitemid = a.id")
				.append("            and dd.departdate between :startdate and :enddate")
				.append("            and dd.status <> '1' and a.name like '%微机费%'")
				.append("         group by dd.departinvoicesid) cf,").append("      (select dd.departinvoicesid,")
				.append("           sum(dd.deductmoney) coolairfee")
				.append("         from departinvoicesdeductdetail dd,")
				.append("              balancedeductitem          a").append("          where dd.balanceitemid = a.id")
				.append("            and dd.departdate between :startdate and :enddate")
				.append("            and dd.status <> '1' and a.name like '%空调费%'")
				.append("         group by dd.departinvoicesid) cof,").append("      (select dd.departinvoicesid,")
				.append("           sum(dd.deductmoney) additionfee")
				.append("         from departinvoicesdeductdetail dd,")
				.append("              balancedeductitem          a").append("          where dd.balanceitemid = a.id")
				.append("            and dd.departdate between :startdate and :enddate")
				.append("            and dd.status <> '1' and a.name like '%附加费%'")
				.append("         group by dd.departinvoicesid) af,").append("      (select dd.departinvoicesid,")
				.append("           sum(dd.deductmoney) insurefee")
				.append("         from departinvoicesdeductdetail dd,")
				.append("              balancedeductitem          a").append("          where dd.balanceitemid = a.id")
				.append("            and dd.departdate between :startdate and :enddate")
				.append("            and dd.status <> '1' and a.name like '%保险%'")
				.append("         group by dd.departinvoicesid) inf,").append("      (select dd.departinvoicesid,")
				.append("           sum(dd.deductmoney) waterfee")
				.append("         from departinvoicesdeductdetail dd,")
				.append("              balancedeductitem          a").append("          where dd.balanceitemid = a.id")
				.append("            and dd.departdate between :startdate and :enddate")
				.append("            and dd.status <> '1' and a.name like '%水费%'")
				.append("         group by dd.departinvoicesid) wf,").append("      (select dd.departinvoicesid,")
				.append("           sum(dd.deductmoney) otherfee")
				.append("         from departinvoicesdeductdetail dd,")
				.append("              balancedeductitem          a").append("          where dd.balanceitemid = a.id")
				.append("            and dd.departdate between :startdate and :enddate")
				.append("            and dd.status <> '1' and (a.name like '%其他%' or a.name like '%其它%')")
				.append("         group by dd.departinvoicesid) otf,")
				.append("         (select dd.departinvoicesid,sum(dd.ticketnum * dd.distance) peopledistance")
				.append("                 from departinvoicesdetail dd")
				.append("           where dd.departdate between :startdate and :enddate")
				.append("          group by dd.departinvoicesid) dd")
				.append(" where d.scheduleid = s.id and s.routeid = r.id and d.status <> '1'")
				.append("    and d.vehicleid=v.id and d.id=cf.departinvoicesid(+)")
				.append("    and d.id=cof.departinvoicesid(+) and d.id=af.departinvoicesid(+)")
				.append("    and d.id=inf.departinvoicesid(+) and d.id=wf.departinvoicesid(+)")
				.append("    and d.id=otf.departinvoicesid(+) and d.id=dd.departinvoicesid(+)")
				.append("    and s.orgid in " + orgids).append("    and d.printorgid in " + departorgs)
				.append("    and v.type in " + vehicletype).append("    and s.districttype in " + districttype)
				.append("    and s.workways in " + workways)
				.append("    and d.departdate between :startdate and :enddate").append("   group by r.name, r.distance")
				.append("  ) group by name  order by name");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		long a = System.currentTimeMillis();
		List<Object> list = query.getResultList();
		long b = System.currentTimeMillis();
		System.out.println("used times=" + (b - a));
		return list;
	}

	/**
	 * 客运班线动态同比表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryRouteDynamicCompare(List<PropertyFilter> propertyFilterList, boolean isbyroute,
			boolean isbydate) {
		String orgids = null;
		Long routeid = null;
		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;
		String objectid = null;
		String printorgid = null;
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName().equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("d!printorgid")) {
					printorgid = (String) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("r!id")) {
					routeid = (Long) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("p!startdate")) {
					startdate = (Date) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("p!enddate")) {
					enddate = (Date) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("c!compSdate")) {
					compStartdate = (Date) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("c!compEdate")) {
					compEnddate = (Date) propertyFilterList.get(t).getMatchValue();
				}
				if (propertyFilterList.get(t).getPropertyFullName().equals("c!addObject")) {
					objectid = (String) propertyFilterList.get(t).getMatchValue();
				}
			}
		}
		boolean isCompareSchunum = false;
		boolean isCompareSeats = false;
		boolean isCompareTicketnum = false;
		boolean isCompareTotalamount = false;
		boolean isCompareBalanceamount = false;
		boolean isCompareStationincome = false;
		boolean isCompareStationservicefee = false;
		boolean isCompareComputefee = false;
		boolean isCompareCoolairfee = false;
		boolean isCompareAdditionfee = false;
		boolean isCompareAgentfee = false;
		boolean isCompareRoutedistance = false;
		boolean isComparepPeopledistance = false;
		boolean isCompareRate = false;
		boolean isCompareSeatrate = false;
		boolean isCompareIncomerate = false;
		boolean isComparesellIncome = false;
		if (objectid != null) {
			char[] b = new char[objectid.length() - 2];
			for (int j = 1; j < objectid.length() - 1; j++) {
				b[j - 1] = objectid.charAt(j);
			}
			// 将"（A,B,C）"转换成"A,B,C"-->去掉括号
			String result = new String(b);
			String[] compareObject = result.split(",");
			for (int i = 0; i < compareObject.length; i++) {
				String compare = compareObject[i];
				if (compare.equals("10")) {
					isCompareSchunum = true;
				}
				if (compare.equals("20")) {
					isCompareSeats = true;
				}
				if (compare.equals("30")) {
					isCompareTicketnum = true;
				}
				if (compare.equals("40")) {
					isCompareTotalamount = true;
				}
				if (compare.equals("50")) {
					isCompareBalanceamount = true;
				}
				if (compare.equals("60")) {
					isCompareStationincome = true;
				}
				if (compare.equals("70")) {
					isCompareAgentfee = true;
				}
				if (compare.equals("80")) {
					isCompareStationservicefee = true;
				}
				if (compare.equals("90")) {
					isCompareComputefee = true;
				}
				if (compare.equals("111")) {
					isCompareCoolairfee = true;
				}
				if (compare.equals("121")) {
					isCompareAdditionfee = true;
				}
				if (compare.equals("131")) {
					isCompareRoutedistance = true;
				}
				if (compare.equals("141")) {
					isComparepPeopledistance = true;
				}
				if (compare.equals("151")) {
					isCompareRate = true;
				}
				if (compare.equals("161")) {
					isCompareSeatrate = true;
				}
				if (compare.equals("171")) {
					isCompareIncomerate = true;
				}
				if (compare.equals("181")) {
					isComparesellIncome = true;
				}
			}
		}

		String sql = " select ";
		if (isbydate && !isbyroute) {
			sql = sql + " nvl(a.sellincome, 0) sellincome,nvl(b.sellincome1, 0) sellincome1,"
					+ " (nvl(a.sellincome, 0) - nvl(b.sellincome1, 0)) sellincomeComp,"
					+ " to_char(case when a.sellincome - nvl(b.sellincome1, 0) = 0 then 0"
					+ " when nvl(a.sellincome, 0) - b.sellincome1 = 0 then 0 else"
					+ " nvl(decode(nullif(b.sellincome1, 0),0,100,(nvl(a.sellincome, 0) - nvl(b.sellincome1, 0)) /nullif(b.sellincome1, 0) * 100),100)"
					+ " end,'9990.99') || '%' sellincomePercent,nvl(a.departdate,b.departdate) departdate,";
		} else if (isbydate) {
			sql = sql + " 0,0,'','',nvl(a.departdate,b.departdate) departdate,";
		} else {
			sql = sql + " 0,0,'','','' departdate,";
		}
		if (isbyroute) {
			sql = sql + " nvl(a.routename, b.routename1) routename,";
		} else {
			sql = sql + " '' routename,";
		}
		sql = sql + " nvl(a.schnum, 0) schnum," + " nvl(a.seats, 0) seats," + " nvl(a.ticketnum, 0) ticketnum,"
				+ " nvl(a.totalamount, 0) totalamount," + " nvl(a.stationservicefee, 0) stationservicefee,"
				+ " nvl(a.computefee, 0) computefee," + " nvl(a.coolairfee, 0) coolairfee,"
				+ " nvl(a.additionfee, 0) additionfee," + " nvl(a.agentfee, 0) agentfee,"
				+ " nvl(a.balanceamount, 0) balanceamount," + " nvl(a.stationincome, 0) stationincome,"
				+ " nvl(a.routedistance, 0) routedistance," + " nvl(a.peopledistance, 0) peopledistance,"
				+ " nvl(a.rate, 0) || '%' as rate," + " nvl(a.seatrate, 0) || '%' as seatrate,"
				+ " to_char(nvl(a.incomerate, 0), '990.99') || '%' as  incomerate ";
		if (isCompareSchunum) {
			sql += " ,nvl(b.schnum1, 0) schnum1," + " (nvl(a.schnum, 0) - nvl(b.schnum1, 0)) schnumComp,"
					+ " to_char(case" + " when a.schnum - nvl(b.schnum1, 0) = 0 then" + " 0"
					+ " when nvl(a.schnum, 0) - b.schnum1 = 0 then" + " 0" + " else"
					+ " nvl(decode(nullif(b.schnum1, 0),0,100,(nvl(a.schnum, 0) - nvl(b.schnum1, 0)) / nullif(b.schnum1, 0) * 100),100) "
					+ " end," + " '9990.99') || '%' schnumPercent";
		} else {
			sql += ", 0 schnum1, 0 schnumComp ,0 schnumPercent";
		}
		if (isCompareSeatrate || isCompareSeats) {
			sql += " ,nvl(b.seats1, 0) seats1," + " (nvl(a.seats, 0) - nvl(b.seats1, 0)) seatsComp," + " to_char(case"
					+ " when a.seats - nvl(b.seats1, 0) = 0 then 0" + " when nvl(a.seats, 0) - b.seats1 = 0 then 0"
					+ " else"
					+ " nvl(decode(nullif(b.seats1, 0),0,100,round(((nvl(a.seats, 0) - nvl(b.seats1, 0)) /nullif(b.seats1, 0) * 100),2)),100) "
					+ " end," + " '9990.99') || '%' seatsPercent";
		} else {
			sql += " ,0 seats1,0 seatsComp,0 seatsPercent";
		}
		if (isCompareSeatrate || isCompareTicketnum) {
			sql += " , nvl(b.ticketnum1, 0) ticketnum1,"
					+ "  (nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) ticketnumComp," + " to_char(case"
					+ "        when a.ticketnum - nvl(b.ticketnum1, 0) = 0 then" + "         0"
					+ "        when nvl(a.ticketnum, 0) - b.ticketnum1 = 0 then" + "         0" + "        else"
					+ "  nvl(decode(nullif(b.ticketnum1, 0),0,100,(nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) /nullif(b.ticketnum1, 0) * 100),100) "
					+ "      end," + "      '9990.99') || '%' ticketnumPercent";
		} else {
			sql += ",0 ticketnum1,0 ticketnumComp,0 ticketnumPercent";
		}
		if (isCompareTotalamount) {
			sql += "  ,nvl(b.totalamount1, 0) totalamount1,"
					+ " (nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) totalamountComp," + "  to_char(case"
					+ "        when a.totalamount - nvl(b.totalamount1, 0) = 0 then" + "         0"
					+ "        when nvl(a.totalamount, 0) - b.totalamount1 = 0 then" + "         0" + "        else"
					+ "  nvl(decode(nullif(b.totalamount1, 0),0,100,(nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) /nullif(b.totalamount1, 0) * 100),100)"
					+ "      end," + "      '9990.99') || '%' totalamountPercent";
		} else {
			sql += ",0 totalamount1,0 totalamountComp,0 totalamountPercent";
		}
		if (isCompareStationservicefee) {
			sql += " ,nvl(b.stationservicefee1, 0) stationservicefee1,"
					+ "  (nvl(a.stationservicefee, 0) - nvl(b.stationservicefee1, 0)) stationservicefeeComp,"
					+ "  to_char(case" + "        when a.stationservicefee - nvl(b.stationservicefee1, 0) = 0 then"
					+ "         0" + "        when nvl(a.stationservicefee, 0) - b.stationservicefee1 = 0 then"
					+ "         0" + "        else"
					+ " nvl(decode(nullif(b.stationservicefee1, 0),0,100,(nvl(a.stationservicefee, 0) - nvl(b.stationservicefee1, 0)) /nullif(b.stationservicefee1, 0) * 100),100)  "
					+ "      end," + "      '9990.99') || '%' stationservicefeePercent";
		} else {
			sql += ",0 stationservicefee1,0 stationservicefeeComp,0 stationservicefeePercent";
		}
		if (isCompareComputefee) {
			sql += " ,nvl(b.computefee1, 0) computefee1,"
					+ " (nvl(a.computefee, 0) - nvl(b.computefee1, 0)) computefeeComp," + " to_char(case"
					+ "        when a.computefee - nvl(b.computefee1, 0) = 0 then" + "         0"
					+ "        when nvl(a.computefee, 0) - b.computefee1 = 0 then" + "         0" + "        else"
					+ "   nvl(decode(nullif(b.computefee1, 0),0,100,(nvl(a.computefee, 0) - nvl(b.computefee1, 0)) /nullif(b.computefee1, 0) * 100),100)"
					+ "      end," + "      '9990.99') || '%' computefeePercent";
		} else {
			sql += ",0 computefee1,0 computefeeComp,0 computefeePercent";
		}
		if (isCompareCoolairfee) {
			sql += " ,nvl(b.coolairfee1, 0) coolairfee1,"
					+ " (nvl(a.coolairfee, 0) - nvl(b.coolairfee1, 0)) coolairfeeComp," + "  to_char(case"
					+ "        when a.coolairfee - nvl(b.coolairfee1, 0) = 0 then" + "         0"
					+ "        when nvl(a.coolairfee, 0) - b.coolairfee1 = 0 then" + "         0" + "        else"
					+ "  nvl(decode(nullif(b.coolairfee1, 0),0,100,(nvl(a.coolairfee, 0) - nvl(b.coolairfee1, 0)) /nullif(b.coolairfee1, 0) * 100),100) "
					+ "      end," + "      '9990.99') || '%' coolairfeePercent";
		} else {
			sql += ",0 coolairfee1,0 coolairfeeComp,0 coolairfeePercent";
		}
		if (isCompareAdditionfee) {
			sql += " ,nvl(b.additionfee1, 0) additionfee1,"
					+ " (nvl(a.additionfee, 0) - nvl(b.additionfee1, 0)) additionfeeComp," + " to_char(case"
					+ "        when a.additionfee - nvl(b.additionfee1, 0) = 0 then" + "         0"
					+ "        when nvl(a.additionfee, 0) - b.additionfee1 = 0 then" + "         0" + "        else"
					+ " nvl(decode(nullif(b.additionfee1, 0),0,100,(nvl(a.additionfee, 0) - nvl(b.additionfee1, 0)) /nullif(b.additionfee1, 0) * 100),100)  "
					+ "      end," + "      '9990.99') || '%' additionfeePercent";
		} else {
			sql += ",0 additionfee1,0 additionfeeComp,0 additionfeePercent";
		}
		if (isCompareAgentfee) {
			sql += " ,nvl(b.agentfee1, 0) agentfee1," + " (nvl(a.agentfee, 0) - nvl(b.agentfee1, 0)) agentfeeComp,"
					+ " to_char(case" + "        when a.agentfee - nvl(b.agentfee1, 0) = 0 then" + "         0"
					+ "        when nvl(a.agentfee, 0) - b.agentfee1 = 0 then" + "         0" + "        else"
					+ "    nvl(decode(nullif(b.agentfee1, 0),0,100,(nvl(a.agentfee, 0) - nvl(b.agentfee1, 0)) /nullif(b.agentfee1, 0) * 100),100)    "
					+ "      end," + "      '9990.99') || '%' agentfeePercent";
		} else {
			sql += ",0 agentfee1,0 agentfeeComp,0 agentfeePercent";
		}
		if (isCompareBalanceamount) {
			sql += " ,nvl(b.balanceamount1, 0) balanceamount1,"
					+ " (nvl(a.balanceamount, 0) - nvl(b.balanceamount1, 0)) balanceamountComp," + " to_char(case"
					+ "        when a.balanceamount - nvl(b.balanceamount1, 0) = 0 then" + "         0"
					+ "        when nvl(a.balanceamount, 0) - b.balanceamount1 = 0 then" + "         0" + "        else"
					+ "    nvl(decode(nullif(b.balanceamount1, 0),0,100,(nvl(a.balanceamount, 0) - nvl(b.balanceamount1, 0)) /nullif(b.balanceamount1, 0) * 100),100)    "
					+ "      end," + "      '9990.99') || '%' balanceamountPercent";
		} else {
			sql += ",0 balanceamount1,0 balanceamountComp,0 balanceamountPercent ";
		}
		if (isCompareStationincome) {
			sql += " ,nvl(b.stationincome1, 0) stationincome1,"
					+ " (nvl(a.stationincome, 0) - nvl(b.stationincome1, 0)) stationincomeComp," + " to_char(case"
					+ "        when a.stationincome - nvl(b.stationincome1, 0) = 0 then" + "         0"
					+ "        when nvl(a.stationincome, 0) - b.stationincome1 = 0 then" + "         0" + "        else"
					+ "   nvl(decode(nullif(b.stationincome1, 0),0,100,(nvl(a.stationincome, 0) - nvl(b.stationincome1, 0)) /nullif(b.stationincome1, 0) * 100),100)    "
					+ "      end," + "      '9990.99') || '%' stationincomePercent";
		} else {
			sql += ",0 stationincome1,0 stationincomeComp,0 stationincomePercent";
		}
		if (isCompareRate || isCompareRoutedistance) {
			sql += " ,nvl(b.routedistance1, 0) routedistance1,"
					+ " (nvl(a.routedistance, 0) - nvl(b.routedistance1, 0)) routedistanceComp," + "  to_char(case"
					+ "       when a.routedistance - nvl(b.routedistance1, 0) = 0 then" + "          0"
					+ "        when nvl(a.routedistance, 0) - b.routedistance1 = 0 then" + "         0" + "        else"
					+ "   nvl(decode(nullif(b.routedistance1, 0),0,100,(nvl(a.routedistance, 0) - nvl(b.routedistance1, 0)) /nullif(b.routedistance1, 0) * 100),100)     "
					+ "      end," + "      '9990.99') || '%' routedistancePercent";
		} else {
			sql += ",0 routedistance1,0 routedistanceComp,0 routedistancePercent";
		}
		if (isCompareRate || isComparepPeopledistance) {
			sql += " ,nvl(b.peopledistance1, 0) peopledistance1,"
					+ " (nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) peopledistanceComp," + " to_char(case"
					+ "        when a.peopledistance - nvl(b.peopledistance1, 0) = 0 then" + "         0"
					+ "        when nvl(a.peopledistance, 0) - b.peopledistance1 = 0 then" + "         0"
					+ "        else"
					+ "   nvl(decode(nullif(b.peopledistance1, 0),0,100,(nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) /nullif(b.peopledistance1, 0) * 100),100)     "
					+ "      end," + "      '9990.99') || '%' peopledistancePercent";
		} else {
			sql += ",0 peopledistance1,0 peopledistanceComp,0 peopledistancePercent";
		}
		if (isCompareRate) {
			sql += ",nvl(b.rate1,0) || '%' rate1," + "(nvl(a.rate,0)-nvl(b.rate1,0)) rateComp,"
					+ "to_char(nvl(decode(b.rate1,0,'',(nvl(a.rate,0)-nvl(b.rate1,0))/"
					+ "		b.rate1*100),100), '9990.99') || '%' ratePercent ";
		} else {
			sql += ",0 rate1,0 rateComp,0 ratePercent ";
		}
		if (isCompareSeatrate) {
			sql += " ,nvl(b.seatrate1,0) || '%' seatrate1," + "(nvl(a.seatrate,0)-nvl(b.seatrate1,0)) seatrateComp,"
					+ "  to_char(case when a.seatrate-nvl(b.seatrate1,0) =0 then 0"
					+ "       when nvl(a.seatrate,0)-b.seatrate1 =0 then 0"
					+ "              else nvl(decode(nullif(b.seatrate1, 0),0,100,(nvl(a.seatrate, 0) - nvl(b.seatrate1, 0)) /nullif(b.seatrate1, 0) * 100),100)"
					+ "		 end, '9990.99') || '%' seatratePercent ";
		} else {
			sql += ",0 seatrate1,0 seatrateComp,0 seatratePercent ";
		}
		if (isCompareIncomerate) {
			sql += " ,nvl(b.incomerate1,0) || '%' incomerate1,"
					+ "(nvl(a.incomerate,0)-nvl(b.incomerate1,0)) incomerateComp,"
					+ "  to_char(case when a.incomerate-nvl(b.incomerate1,0) =0 then 0"
					+ "       when nvl(a.incomerate,0)-b.incomerate1 =0 then 0"
					+ "              else nvl(decode( nullif(b.incomerate1, 0),0,100,(nvl(a.incomerate, 0) - nvl(b.incomerate1, 0)) / nullif(b.incomerate1, 0) * 100),100) "
					+ "	 end, '9990.99') || '%' incomeratePercent ";
		} else {
			sql += ",0 incomerate1,0 incomerateComp,0 incomeratePercent ";
		}
		sql += " from ( select ";
		if (isbydate && !isbyroute) {
			sql = sql + " k.orgid,k.departdate,k.schnum,k.seats,k.ticketnum,"
					+ " k.totalamount,k.stationservicefee,k.computefee,k.coolairfee,"
					+ " k.additionfee,k.agentfee,k.balanceamount,k.stationincome,k.routedistance,"
					+ " k.peopledistance,k.rate,k.seatrate, k.incomerate,c.sellincome"
					+ " from ( ( select s.orgid,d.departdate departdate,";
		} else if (isbydate) {
			sql = sql + " d.departdate departdate, ";
		}
		if (isbyroute) {
			sql = sql + " s.orgid,r.name as routename,";
		}
		if (!isbydate && !isbyroute) {
			sql = sql + " s.orgid, ";
		}
		sql = sql + "  count(distinct d.reportid) schnum," + " sum(sp.seatnum - sp.fixedreserveseatnum) seats,"
				+ " sum(d.ticketnum) ticketnum," + " sum(d.totalamount) totalamount,"
				+ " sum(d.stationservicefee) as stationservicefee," + " sum(nvl((select sum(dd.deductmoney)"
				+ " from departinvoicesdeductdetail dd," + " balancedeductitem          a"
				+ " where dd.departinvoicesid = d.id" + " and dd.balanceitemid = a.id" + " and dd.status<>'1'"
				+ " and a.name like '%微机费%')," + " 0)) computefee," + " sum(nvl((select sum(dd.deductmoney)"
				+ " from departinvoicesdeductdetail dd," + " balancedeductitem          a"
				+ " where dd.departinvoicesid = d.id" + " and dd.balanceitemid = a.id" + " and dd.status<>'1'"
				+ " and a.name like '%空调费%')," + " 0)) coolairfee," + " sum(nvl((select sum(dd.deductmoney)"
				+ " from departinvoicesdeductdetail dd," + " balancedeductitem          a"
				+ " where dd.departinvoicesid = d.id" + " and dd.balanceitemid = a.id" + " and dd.status<>'1'"
				+ " and a.name like '%附加费%')," + " 0)) additionfee," + " sum(d.agentfee) agentfee,"
				+ " sum(d.balanceamount) balanceamount,"
				+ " sum(d.agentfee + d.stationservicefee + d.othterfee) stationincome,"
				+ " sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance) routedistance,"
				+ " sum(peopledistance) peopledistance," + " round(decode(sum((sp.seatnum - sp.fixedreserveseatnum) * "
				+ " r.distance),0,100, " + " (sum(peopledistance) * 100 /"
				+ " sum((sp.seatnum - sp.fixedreserveseatnum) *" + " r.distance)))," + " 2) rate," // rate
				+ " round(decode(sum(sp.seatnum - sp.fixedreserveseatnum), " + " 0,100, " + " (sum(d.ticketnum) * 100 /"
				+ " sum(sp.seatnum - sp.fixedreserveseatnum)))," + " 2) as seatrate," // seatrate
				+ " round(decode((select sum(d.totalamount) " + " from departinvoices d, schedule s "
				+ " where d.status <> '1' " + " and d.scheduleid = s.id ";
		if (orgids != null) {
			sql = sql + "  and s.orgid in " + orgids;
		}
		if (printorgid != null) {
			sql = sql + "  and d.printorgid in " + printorgid;
		}
		sql += " and d.departdate between :startdate and :enddate), " + " 0,100, " + " (sum(d.totalamount) * 100 /"
				+ " (select sum(d.totalamount)" + " from departinvoices d, schedule s" + " where d.status <> '1'"
				+ " and d.scheduleid = s.id" + " and s.orgid in " + orgids
				+ " and d.departdate between :startdate and :enddate)))," + " 2) as incomerate"
				+ " from departinvoices d," + " route r," + " schedule s," + " scheduleplan sp,"
				+ " (select dt.departinvoicesid," + " sum(dt.distance * dt.ticketnum) peopledistance"
				+ " from departinvoicesdetail dt" + " where dt.departdate between :startdate and :enddate "
				+ " group by dt.departinvoicesid) de" + " where d.scheduleid = s.id" + " and s.routeid = r.id"
				+ " and d.id = de.departinvoicesid(+)" + " and d.scheduleplanid = sp.id"
				+ " and d.departdate between :startdate and :enddate" + " and d.status <> '1'"
				+ " and sp.departdate = d.departdate";
		if (routeid != null) {
			sql += " and r.id = " + routeid;
		}
		if (orgids != null) {
			sql += " and s.orgid in " + orgids;
		}

		if (printorgid != null) {
			sql += " and d.printorgid in " + printorgid;
		}
		sql += " group by ";
		if (isbydate && isbyroute) {
			sql = sql
					+ " s.orgid,d.departdate,r.name, r.districttype order by s.orgid,d.departdate desc,r.districttype ";
		} else if (isbyroute) {
			sql = sql + " s.orgid,r.name, r.districttype order by r.districttype desc ";
		} else if (isbydate) {
			sql = sql + " s.orgid,d.departdate order by ";
			sql = sql + " d.departdate desc) k left join"
					+ " (select td.selldate, sum(td.totalprice - td.returnprice - td.cancelmoeny) sellincome"
					+ " from ticketsellbysalerday td, organization o" + " where td.orgid = o.id"
					+ " and td.selldate between :startdate and :enddate"
					+ " group by td.selldate) c on k.departdate = c.selldate)";
		} else {
			sql = sql + " s.orgid ";
		}
		sql = sql + " ) a full join ( select ";
		if (isbydate && !isbyroute) {
			sql = sql + " k.orgid ,k.departdate,k.schnum1,k.seats1,k.ticketnum1,"
					+ " k.totalamount1,k.stationservicefee1,k.computefee1,k.coolairfee1,"
					+ " k.additionfee1,k.agentfee1,k.balanceamount1,k.stationincome1,"
					+ " k.routedistance1,k.peopledistance1,k.rate1, k.seatrate1,k.incomerate1,c.sellincome1"
					+ " from ( select orgid,departdate,";
		} else if (isbydate) {
			sql = sql + " departdate,";
		}
		if (isbyroute) {
			sql = sql + " orgid,routename1, ";
		}
		if (!isbydate && !isbyroute) {
			sql = sql + " orgid,";
		}
		sql = sql + " schnum1," + " seats1," + " ticketnum1," + " totalamount1," + " stationservicefee1,"
				+ " computefee1," + " coolairfee1," + " additionfee1," + " agentfee1," + " balanceamount1,"
				+ " stationincome1," + " routedistance1," + " peopledistance1," + " rate1," + " seatrate1,"
				+ " incomerate1" + " from ( select ";
		if (isbydate && isbyroute) {
			if (DateUtils.compare(startdate, compStartdate) >= 0) {
				sql = sql + " s.orgid,d.departdate+" + DateUtils.getIntervalDays(startdate, compStartdate)
						+ " departdate,r.name as routename1 ";
			} else {
				sql = sql + " s.orgid,d.departdate-" + DateUtils.getIntervalDays(startdate, compStartdate)
						+ " departdate,r.name as routename1 ";
			}
		} else if (isbyroute) {
			sql = sql + " s.orgid,r.name as routename1 ";
		} else if (isbydate) {
			if (DateUtils.compare(startdate, compStartdate) >= 0) {
				sql = sql + " s.orgid,d.departdate+" + DateUtils.getIntervalDays(startdate, compStartdate)
						+ " departdate ";
			} else {
				sql = sql + " s.orgid,d.departdate-" + DateUtils.getIntervalDays(startdate, compStartdate)
						+ " departdate ";
			}
		} else {
			sql = sql + " s.orgid ";
		}
		if (isCompareSchunum) {
			sql += ",count(distinct d.reportid) schnum1";
		} else {
			sql += ",0 schnum1";
		}
		if (isCompareSeats || isCompareRate) {
			sql += ",sum(sp.seatnum - sp.fixedreserveseatnum) seats1 ";
		} else {
			sql += ",0 seats1 ";
		}
		if (isCompareTicketnum || isCompareRate) {
			sql += ",sum(d.ticketnum) ticketnum1 ";
		} else {
			sql += ",0 ticketnum1 ";
		}
		if (isCompareTotalamount) {
			sql += ",sum(d.totalamount) totalamount1 ";
		} else {
			sql += ",0 totalamount1 ";
		}
		if (isCompareStationservicefee) {
			sql += ",sum(d.stationservicefee) as stationservicefee1 ";
		} else {
			sql += ",0 stationservicefee1 ";
		}
		if (isCompareComputefee) {
			sql += ",sum(nvl((select sum(dd.deductmoney)" + " from departinvoicesdeductdetail dd,"
					+ " balancedeductitem a" + "  where dd.departinvoicesid = d.id" + "  and dd.balanceitemid = a.id"
					+ "  and dd.status<>'1'" + "  and a.name like '%微机费%')," + " 0)) computefee1 ";
		} else {
			sql += ",0 computefee1 ";
		}
		if (isCompareCoolairfee) {
			sql += ",sum(nvl((select sum(dd.deductmoney)" + " from departinvoicesdeductdetail dd,"
					+ " balancedeductitem a" + " where dd.departinvoicesid = d.id" + " and dd.balanceitemid = a.id"
					+ " and dd.status<>'1'" + " and a.name like '%空调费%')," + " 0)) coolairfee1 ";
		} else {
			sql += ",0 coolairfee1 ";
		}
		if (isCompareAdditionfee) {
			sql += ",sum(nvl((select sum(dd.deductmoney)" + " from departinvoicesdeductdetail dd,"
					+ " balancedeductitem a" + " where dd.departinvoicesid = d.id" + " and dd.balanceitemid = a.id"
					+ " and dd.status<>'1'" + " and a.name like '%附加费%')," + "  0)) additionfee1 ";
		} else {
			sql += ",0 additionfee1 ";
		}
		if (isCompareAgentfee) {
			sql += ",sum(d.agentfee) agentfee1 ";
		} else {
			sql += ",0 agentfee1 ";
		}
		if (isCompareBalanceamount) {
			sql += ",sum(d.balanceamount) balanceamount1 ";
		} else {
			sql += ",0 balanceamount1 ";
		}
		if (isCompareStationincome) {
			sql += ",sum(d.agentfee + d.stationservicefee + d.othterfee) stationincome1 ";
		} else {
			sql += ",0 stationincome1 ";
		}
		if (isCompareRoutedistance || isCompareSeatrate) {
			sql += ",sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance) routedistance1 ";
		} else {
			sql += ",0 routedistance1 ";
		}
		if (isComparepPeopledistance || isCompareSeatrate) {
			sql += ",sum(peopledistance) peopledistance1 ";
		} else {
			sql += ",0 peopledistance1 ";
		}
		if (isCompareRate) {
			sql += ",round(decode(sum((sp.seatnum -" + " sp.fixedreserveseatnum) * " + " r.distance),0,100, "
					+ " (sum(peopledistance) * 100 / " + " sum((sp.seatnum - sp.fixedreserveseatnum) *"
					+ " r.distance)))," + " 2) rate1 ";
		} else {
			sql += ",0 rate1 ";
		}
		if (isCompareSeatrate) {
			sql += " ,round(decode(sum(sp.seatnum - " + " sp.fixedreserveseatnum),0,100, "
					+ " (sum(d.ticketnum) * 100 / " + " sum(sp.seatnum - sp.fixedreserveseatnum))),"
					+ " 2) as seatrate1 ";
		} else {
			sql += ",0 seatrate1 ";
		}
		if (isCompareIncomerate) {
			sql += " , round(decode((select sum(d.totalamount) " + " from departinvoices d, " + " schedule     s "
					+ " where d.status <> '1' " + " and d.scheduleid = s.id " + " and s.orgid in " + orgids
					+ " and d.departdate between :compStartdate and :compEnddate),  " + " 0,100 "
					+ ", sum(d.totalamount) * 100 / " + " (select sum(d.totalamount) "
					+ " from departinvoices d, schedule s" + " where d.status <> '1'" + " and d.scheduleid = s.id";
			if (orgids != null) {
				sql += " and s.orgid in " + orgids;
			}

			if (printorgid != null) {
				sql += "  and d.printorgid in " + printorgid;
			}
			sql += " and d.departdate between :compStartdate and :compEnddate)),2)" + " as incomerate1 ";
		} else {
			sql += ",0 incomerate1 ";
		}
		sql += " from departinvoices d," + " route r," + " schedule s," + " scheduleplan sp,"
				+ " (select dt.departinvoicesid," + " sum(dt.distance * dt.ticketnum) peopledistance"
				+ " from departinvoicesdetail dt" + " where dt.departdate between :compStartdate and :compEnddate"
				+ " group by dt.departinvoicesid) de" + " where d.scheduleid = s.id" + " and s.routeid = r.id"
				+ " and d.id = de.departinvoicesid(+)" + " and d.scheduleplanid = sp.id"
				+ " and d.departdate between :compStartdate and :compEnddate" + " and d.status <> '1'"
				+ " and sp.departdate = d.departdate";
		if (routeid != null) {
			sql += " and r.id = " + routeid;
		}
		if (orgids != null) {
			sql += " and s.orgid in " + orgids;
		}
		if (printorgid != null) {
			sql += " and d.printorgid in " + printorgid;
		}
		sql += " group by ";
		if (isbydate && isbyroute) {
			sql = sql
					+ " s.orgid,d.departdate,r.name, r.districttype order by s.orgid,d.departdate desc,r.districttype )) b  on ";
			sql = sql + " a.routename = b.routename1 and a.departdate= b.departdate order by a.departdate desc ";
		} else if (isbyroute) {
			sql = sql + " s.orgid,r.name, r.districttype order by  r.districttype desc )) b  on ";
			sql = sql + " a.routename = b.routename1 and a.orgid=b.orgid order by a.routename ";
		} else if (isbydate) {
			sql = sql + " s.orgid,d.departdate order by ";
			sql = sql + " d.departdate desc) ) k " + " left join (select td.selldate";
			if (DateUtils.compare(startdate, compStartdate) >= 0) {
				sql = sql + "+" + DateUtils.getIntervalDays(startdate, compStartdate);
			} else {
				sql = sql + "-" + DateUtils.getIntervalDays(startdate, compStartdate);
			}
			sql = sql + " selldate,sum(td.totalprice - td.returnprice - td.cancelmoeny) sellincome1"
					+ " from ticketsellbysalerday td, organization o"
					+ " where td.orgid = o.id and td.selldate between :compStartdate and :compEnddate"
					+ " group by td.selldate) c on k.departdate = c.selldate) b  on ";
			sql = sql + " a.departdate= b.departdate order by a.departdate desc ";
		} else {
			sql = sql + " s.orgid  ) ) b on ";
			sql = sql + " a.orgid = b.orgid ";
		}
		Query query = getEntityManager().createNativeQuery(sql);
		System.out.println(sql);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);
		return query.getResultList();
	}

}
