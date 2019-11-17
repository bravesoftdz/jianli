package cn.nova.bus.report.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import play.Logger;
import util.CurrentUtil;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * 
 * <p>
 * <b>类描述营收报表服</b><br/>
 * <b>类名称：</b>SalerRevenueDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>主要模块：售票员售票情况日报表querySalerdayRevenue </b><br/>
 * <b>          本站售异站汇总表queryDayIncome</b><br/>
 * <b>   		客运每日班次营收汇总 ueryDayScheduleIncome</b><br/>
 * <b>          客运站划拨明细表  queryInvoincesDetail</b><br/>
 * <b>长途站预售票查询情况表（跨月汇总） queryPresellMonthRevenue</b><br/>
 * <b>售票员售票情况日报表 querySalerdayRevenue</b><br/>
 * <b>本站售异站汇总表 querySalerSyncOrgRevenue</b><br/>
 * <b>客运站结算汇总表 queryStationBalanceInvoinces</b><br/>
 * <b>异站售本站汇总表 querySyncSaleLocal</b><br/>
 * <b>车辆划拨汇总表 queryVehicleIncome</b><br/>
 * <b>1修改内容： </b><br/> 
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class SalerRevenueDao extends EntityManagerDaoSurport {

	private ParameterService parameterService;
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

	@SuppressWarnings("unchecked")
	public List<Object> queryLocalOrg(String orgids) {
		StringBuilder sql = new StringBuilder(
				" select org.id,org.name,org.code from Organization org"
						+ " where org.type in ('0','1','2') and org.islocal=1")
				.append(" and org.id in " + orgids);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	/**
	 * 售票员售票情况日报表
	 * @param ticketoutletid 
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @param boolean isbyseller,boolean isbyselldate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySalerdayRevenue(String orgids, Date startdate,
			Date enddate, boolean isbyseller, boolean isbyselldate,String sellerids, String ticketoutletid,String paymethod) {
		StringBuilder sql = new StringBuilder("");
		if (isbyselldate) {
			if (isbyseller) {
				sql.append("select a.code,a.name,")
				.append("a.orgname,a.selldate,nvl(sum(s.datescheduleincome),0) datescheduleincome,sum(a.sellnum),")
				.append(" sum(a.sellnum-a.cancelnum-a.returnnum) normalnum,")
				.append("sum(a.totalprice),sum(a.cancelnum),sum(a.cancelmoeny),sum(a.returnnum),")
				.append("sum(a.returnprice),sum(a.returnfee),sum(a.fueladditionfee),sum(a.servicefee),sum(a.nomalsellnum),")
				.append("sum(a.nomaltotalprice),sum(a.stationservicefee),sum(a.computefee),")
				.append("sum(a.coolairfee),sum(a.additionfee),sum(a.totalfee),sum(a.badnum),sum(a.upmoney),")
				.append("sum(a.moreprice),sum(a.waterfee),sum(a.insurefee),sum(a.otherfee),sum(a.stationincome),a.ticketoutlet ")
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票凭证数】【 总张数】  李电志2016年4月27日 15:57:07 
				.append(",sum(a.changenum) changenum,sum(a.adjustnum) adjustnum,sum(a.damagednum) damagednum,sum(a.ticketreturnnum) ticketreturnnum, ")
				.append(" sum(a.sellnum) + sum(a.changenum) + sum(a.adjprintnum) + sum(a.damagednum) + sum(a.ticketreturnnum) + sum(a.takeeticketnum) totalusenum ,a.value")
				
				.append(" from ( select o.name orgname,u.name,u.code,td.selldate, ")
				.append(" sum(td.sellnum) sellnum,")
				.append(" sum(td.totalprice) totalprice,sum(td.cancelnum) cancelnum,sum(td.cancelmoeny) cancelmoeny,")
				.append(" (case when td.sellby=0 then sum(td.synreturnlocnum)+sum(td.returnnum) else sum(td.returnnum) end )returnnum,")
				.append(" (case when td.sellby=0 then sum(td.synreturnlocprice)+sum(td.returnprice) else sum(td.returnprice) end) returnprice,")
				.append(" (case when td.sellby=0 then sum(td.synreturnlocfee)+sum(td.returnfee) else sum(td.returnfee) end ) returnfee, ");
			} else {
				sql.append("select '' code,'' name,")
				.append("a.orgname,a.selldate,nvl(sum(s.datescheduleincome),0) datescheduleincome,sum(a.sellnum),")
				.append(" sum(a.sellnum-a.cancelnum-a.returnnum) as normalnum,")
				.append("sum(a.totalprice),sum(a.cancelnum),sum(a.cancelmoeny),sum(a.returnnum),")
				.append("sum(a.returnprice),sum(a.returnfee),sum(a.fueladditionfee),sum(a.servicefee),sum(a.nomalsellnum),")
				.append("sum(a.nomaltotalprice),sum(a.stationservicefee),sum(a.computefee),")
				.append("sum(a.coolairfee),sum(a.additionfee),sum(a.totalfee),sum(a.badnum),sum(a.upmoney),")
				.append("sum(a.moreprice),sum(a.waterfee),sum(a.insurefee),sum(a.otherfee),sum(a.stationincome),a.ticketoutlet")
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票凭证数】【 总张数】  李电志2016年4月27日 15:57:07 
				.append(",sum(a.changenum) changenum,sum(a.adjustnum) adjustnum,sum(a.damagednum) damagednum,sum(a.ticketreturnnum) ticketreturnnum, ")
				.append(" sum(a.sellnum) + sum(a.changenum) + sum(a.adjprintnum) + sum(a.damagednum) + sum(a.ticketreturnnum) + sum(a.takeeticketnum) totalusenum,a.value ")
				
				.append(" from ( select o.name orgname,td.selldate,")
				.append(" sum(td.sellnum) sellnum,")
				.append(" sum(td.totalprice) totalprice,sum(td.cancelnum) cancelnum,sum(td.cancelmoeny) cancelmoeny,")
				.append(" sum(td.returnnum+ td.synreturnlocnum) returnnum, sum(td.returnprice + td.synreturnlocprice) returnprice,sum(td.returnfee+ td.synreturnlocfee) returnfee,");
			}
		} else {
			if (isbyseller) {
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票凭证数】【 总张数】  李电志2016年4月27日 15:57:07 
				sql.append(" select ve.code code ,ve.name name ,ve.orgname orgname,0 selldate,ve.datescheduleincome datescheduleincome,ve.sellnum sellnum,ve.normalnum normalnum, ")
				.append(" ve.totalprice totalprice,ve.cancelnum cancelnum,ve.cancelmoeny cancelmoeny,ve.returnnum returnnum,ve.returnprice returnprice, ")
				.append(" ve.returnfee returnfee,ve.fueladditionfee fueladditionfee,ve.servicefee servicefee,ve.nomalsellnum nomalsellnum,ve.nomaltotalprice, ")
				.append(" ve.stationservicefee stationservicefee,ve.computefee computefee,ve.coolairfee coolairfee,ve.additionfee additionfee,ve.totalfee totalfee, ")
				.append(" ve.badnum badnum,ve.upmoney upmoney,ve.moreprice moreprice,ve.waterfee waterfee,ve.insurefee insurefee,ve.otherfee otherfee, ")
				.append(" ve.stationincome stationincome,ve.ticketoutlet ticketoutlet ")
				.append(" ,ve.changenum changenum ")//改签凭证数
				.append(" ,ve.adjustnum adjustnum ")//补票凭证数
				.append(" ,ve.damagednum damagednum ")//坏票数
				.append(" ,ve.ticketreturnnum ticketreturnnum ")//退票凭证数
				.append(" ,ve.sellnum + ve.changenum + ve.adjprintnum + ve.damagednum + ve.ticketreturnnum + ve.takeeticketnum totalusenum,ve.value ")//
				.append(" from ( ")
				;//ldz
				sql.append("select u.code,u.name,o.name orgname,0 selldate,nvl(sum(td.datescheduleincome),0) datescheduleincome, sum(td.sellnum) sellnum,")
					.append(" (sum(td.sellnum)-sum(td.cancelnum)-(case when td.sellby=0 then sum(td.synreturnlocnum)+sum(td.returnnum) else sum(td.returnnum) end )) as normalnum,")
					.append(" sum(td.totalprice) totalprice,sum(td.cancelnum) cancelnum,sum(td.cancelmoeny) cancelmoeny,")
					.append("(case when td.sellby=0 then sum(td.synreturnlocnum)+sum(td.returnnum) else sum(td.returnnum) end ) returnnum,")
					.append("(case when td.sellby=0 then sum(td.synreturnlocprice)+sum(td.returnprice) else sum(td.returnprice) end) returnprice,")
					.append("(case when td.sellby=0 then sum(td.synreturnlocfee)+sum(td.returnfee) else sum(td.returnfee) end ) returnfee, ");
			} else {
				//ldz 
				sql.append("select ve.code code ,ve.name name ,ve.orgname orgname,0 selldate,ve.datescheduleincome datescheduleincome,ve.sellnum sellnum,ve.normalnum normalnum,")
				.append(" ve.totalprice totalprice,ve.cancelnum cancelnum,ve.cancelmoeny cancelmoeny,ve.returnnum returnnum,ve.returnprice returnprice, ")
				.append(" ve.returnfee returnfee,ve.fueladditionfee fueladditionfee,ve.servicefee servicefee,ve.nomalsellnum nomalsellnum,ve.nomaltotalprice, ")
				.append(" ve.stationservicefee stationservicefee,ve.computefee computefee,ve.coolairfee coolairfee,ve.additionfee additionfee,ve.totalfee totalfee, ")
				.append(" ve.badnum badnum,ve.upmoney upmoney,ve.moreprice moreprice,ve.waterfee waterfee,ve.insurefee insurefee,ve.otherfee otherfee, ")
				.append(" ve.stationincome stationincome,ve.ticketoutlet ticketoutlet ")
				.append(" ,ve.changenum changenum ")//改签凭证数 
				.append(" ,ve.adjustnum adjustnum ")//补票凭证数
				.append(" ,ve.damagednum damagednum ")//坏票数
				.append(" ,ve.ticketreturnnum ticketreturnnum ")//退票凭证数
				.append(" ,ve.sellnum + ve.changenum + ve.adjprintnum + ve.damagednum + ve.ticketreturnnum + ve.takeeticketnum totalusenum,ve.value ")//使用总张数=总张数+退票凭证数+改签凭证数+补票凭证数+坏票数
				.append(" from ( ")
				;//李电志
				sql.append("select '' code, '' name,o.name orgname,0 selldate,sum(td.datescheduleincome) datescheduleincome,")
				.append(" sum(td.sellnum) sellnum,")
				.append("sum(td.sellnum-td.cancelnum-td.returnnum-td.synreturnlocnum) normalnum,")
				.append(" sum(td.totalprice) totalprice,sum(td.cancelnum) cancelnum,sum(td.cancelmoeny) cancelmoeny,")
				.append(" sum(td.returnnum+td.synreturnlocnum) returnnum, sum(td.returnprice+td.synreturnlocprice)  returnprice, sum(td.returnfee+td.synreturnlocfee)  returnfee,");
			}
		}
		sql.append(" sum(td.fueladditionfee) fueladditionfee, sum(td.servicefee) servicefee,sum(td.sellnum-td.cancelnum) nomalsellnum,")
		.append(" sum(td.totalprice-td.returnprice-td.synreturnlocprice-td.cancelmoeny) nomaltotalprice,")
		.append(" sum(td.stationservicefee) stationservicefee,sum(td.computefee) computefee,")
		.append(" sum(td.coolairfee) coolairfee,sum(td.additionfee) additionfee,")
		.append(" sum(td.totalfee) totalfee,sum(td.badnum) badnum,")
		.append(" sum(td.totalprice - td.returnprice - td.synreturnlocprice + td.returnfee +td.synreturnlocfee - td.cancelmoeny+td.servicefee) upmoney,")
		.append(" sum(moreprice) moreprice,sum(td.waterfee) waterfee,sum(td.insurefee) insurefee,sum(td.otherfee) otherfee, ")
		.append(" sum(td.totalprice - td.returnprice + td.returnfee - td.cancelmoeny+td.servicefee-td.totalfee) stationincome,tl.name ticketoutlet,sum(td.adjustnum) adjprintnum,sum(td.takeeticketnum) takeeticketnum  ");
		if (isbyselldate) {
			if (isbyseller) {
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票凭证数】【 总张数】  李电志2016年4月27日 15:57:07 
				sql.append(" , sum(case when d.code = t_tc.paymethod then t_tc.id else 0 end) as changenum, ")
				.append("  sum(case when d.code = t_adj.paymethod then t_adj.id else 0 end) as adjustnum, ")
				.append(" nvl(sum(case when d.code = 0 then t_dam.id else 0 end),0) as damagednum, ")
				
				.append(" nvl(sum(case when d.code =tt.returnfeemode then tt.returnnum else 0 end), 0) as ticketreturnnum, d.value")//退票凭证数
				.append(" from userinfo u,organization o,ticketsellbysalerday td")
				.append(" left join USERTICKETOUTLETS ut on ut.userinfoid  = td.sellby  left join ticketoutlets tl on tl.id = ut.ticketoutletsid")
				.append(" left join digitaldictionarydetail d on d.code=td.paymethod and d.digitaldictionaryid=50")
				// 退票凭证
				.append(" left join (select count(ts.id) returnnum ,tr.returnby, tr.returnfeemode from ticketsell ts left join ticketreturn tr on ts.id = tr.sellid where tr.returnway in ('0','1','2') ")
				.append(" and tr.returnvoucherno is not null and tr.returntime between :startdate and :enddate+0.99999 group by tr.returnby,tr.returnfeemode) tt on tt.returnby = td.sellby ")
				// 改签
				.append(" left join (select count(tc.id) id,ts.paymethod,tc.changeby from ticketchange tc,ticketsell ts ")
				.append(" where ts.id = tc.newticketsellid and tc.changetime >= :startdate and tc.changetime <= :enddate+ 0.99999 ")
				.append(" group by ts.paymethod,tc.changeby) t_tc on t_tc.changeby = td.sellby and td.paymethod=t_tc.paymethod ")
				// 补票
				.append(" left join (select count(ts.id) id,ts.paymethod,ts.sellby from ticketsell ts ")
				.append(" where ts.selltime >= :startdate and ts.selltime <= :enddate + 0.99999 ")
				.append(" and ts.sellway in ('1', '2')  group by ts.paymethod,ts.sellby) t_adj on t_adj.sellby = td.sellby and td.paymethod=t_adj.paymethod")
				// 坏票
				.append(" left join (select sum(bi.endno - bi.startno + 1) id ,bi.recordby from billdamaged bi ")
				.append(" where bi.recordtime >= :startdate and bi.recordtime <= :enddate+ 0.99999  group by bi.recordby) t_dam on t_dam.recordby = td.sellby  ")
				// where
		        .append(" where td.sellby = u.id and td.orgid = o.id")
				.append(" and td.selldate between :startdate and :enddate+0.99999  and td.sellby>0 ");
				if (ticketoutletid != null && ticketoutletid.length() > 0) {
					sql.append(" and ut.ticketoutletsid in " + ticketoutletid);
				}
				if (paymethod.length() == 3 && paymethod.indexOf("1")==1 ) {
					sql.append(" and d.code in (4,5)" );
				}
				if (paymethod.length() == 3 && paymethod.indexOf("2")==1 ) {
					sql.append(" and d.code in (0,1,2,3)");
				}
				sql.append(" and o.id in " + orgids)
				.append(" and u.id in " + sellerids)
				.append(" group by o.name,td.selldate,u.name,u.code,td.sellby,tl.name,d.value,d.code order by o.name ) a left join ")
				.append(" (select sum(decode(ts.ticketstatus, '0',ts.price,0)) datescheduleincome,ts.departdate selldate,o.name orgname,u.code,u.name")
				.append(" from ticketsell ts,organization o,userinfo u ")
				.append(" where ts.sellby = u.id and ts.orgid=o.id and ts.departdate = trunc(ts.selltime) ")
				.append(" and ts.selltime  between :startdate and :enddate+0.99999")
				.append(" and ts.departdate between :startdate and :enddate+0.99999")
				.append(" and o.id in " + orgids)
				.append(" and u.id in " + sellerids);
				sql.append(" group by o.name,ts.departdate,u.code,u.name) s ")
				.append(" on a.orgname = s.orgname and a.selldate = s.selldate and a.code= s.code and a.name = s.name ")
				.append(" group by a.orgname,a.selldate,a.code,a.name, a.ticketoutlet,a.value ")
				.append(" order by a.orgname, a.selldate, a.name");
			} else {
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票凭证数】【 总张数】  李电志2016年4月27日 15:57:07 
				sql.append(" ,sum(case when d.code = t_tc.paymethod then t_tc.id else 0 end) as changenum, ")
				.append(" sum(case when d.code = t_adj.paymethod then t_adj.id else 0 end) as adjustnum, ")
				.append(" nvl(sum(case when d.code = 0 then t_dam.id else 0 end),0) as damagednum, ")
				
				.append(" nvl(sum(case when d.code =tt.returnfeemode then tt.returnnum else 0 end), 0) as ticketreturnnum, d.value")//退票凭证数
				.append("  from organization o left join ticketsellbysalerday td on td.orgid = o.id ")
				.append(" left join USERTICKETOUTLETS ut on ut.userinfoid  = td.sellby  left join ticketoutlets tl on tl.id = ut.ticketoutletsid")
				.append(" left join digitaldictionarydetail d on d.code=td.paymethod and d.digitaldictionaryid=50")
				// 退票
				.append(" left join (select count(ts.id) returnnum ,tr.returnby, tr.returnfeemode from ticketsell ts left join ticketreturn tr on ts.id = tr.sellid where tr.returnway in ('0','1','2') ")
				.append(" and tr.returnvoucherno is not null and tr.returntime between :startdate and :enddate+0.99999 group by tr.returnby,tr.returnfeemode) tt on tt.returnby = td.sellby ")
				//改签
				.append(" left join (select count(tc.id) id,ts.paymethod,tc.changeby from ticketchange tc,ticketsell ts ")
				.append(" where ts.id = tc.newticketsellid and tc.changetime >= :startdate and tc.changetime <= :enddate+ 0.99999 ")
				.append(" group by ts.paymethod,tc.changeby) t_tc on t_tc.changeby = td.sellby and td.paymethod=t_tc.paymethod ")
				// 补票
				.append(" left join (select count(ts.id) id,ts.paymethod,ts.sellby from ticketsell ts ")
				.append(" where ts.selltime >= :startdate and ts.selltime <= :enddate + 0.99999 ")
				.append(" and ts.sellway in ('1', '2')  group by ts.paymethod,ts.sellby) t_adj on t_adj.sellby = td.sellby and td.paymethod=t_adj.paymethod ")
				// 坏票
				.append(" left join (select sum(bi.endno - bi.startno + 1) id ,bi.recordby from billdamaged bi ")
				.append(" where bi.recordtime >= :startdate and bi.recordtime <= :enddate+ 0.99999  group by bi.recordby) t_dam on t_dam.recordby = td.sellby  ")
				// where
				.append( " where 1 = 1 and o.id in " +orgids);
				if (ticketoutletid != null && ticketoutletid.length() > 0) {
					sql.append(" and ut.ticketoutletsid in " + ticketoutletid);
				}
				if (paymethod.length() == 3 && paymethod.indexOf("1")==1 ) {
					sql.append(" and d.code in (4,5)" );
				}
				if (paymethod.length() == 3 && paymethod.indexOf("2")==1 ) {
					sql.append(" and d.code in (0,1,2,3)");
				}
//                .append(" and td.sellby>0")
				sql.append(" and ((o.type=2 and o.islocal=1 and td.sellby>0) or (o.islocal=0 and td.sellby=0) or  (o.type=0))")
				.append(" and td.selldate between :startdate and :enddate+0.99999")
				.append(" group by o.name,td.selldate,tl.name,d.value,d.code order by o.name,td.selldate ) a left join  ")//李电志 2016年4月27日 16:50:57
				.append(" (select sum(decode(ts.ticketstatus, '0',ts.price,0)) datescheduleincome,ts.departdate selldate,o.name orgname from ticketsell ts left join organization o on ts.orgid = o.id ")
				.append(" where 1 = 1 and ts.departdate = trunc(ts.selltime) ")
				.append(" and ts.selltime  between :startdate and :enddate+0.99999")
				.append(" and ts.departdate between :startdate and :enddate+0.99999 ")
				.append(" and o.id in " + orgids)
				.append(" group by o.name,ts.departdate) s ")
				.append( " on a.orgname = s.orgname and a.selldate = s.selldate ");
				
				sql.append(" group by a.orgname,a.selldate, a.ticketoutlet ,a.value ")
				.append(" order by a.orgname, a.selldate");
			}
		} else {
			if (isbyseller) {
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票凭证数】【 总张数】  李电志2016年4月27日 15:57:07 
				sql.append(" ,sum(case when d.code = t_tc.paymethod then t_tc.id else 0 end) as changenum ")//改签凭证数 
				.append(" ,sum(case when d.code = t_adj.paymethod then t_adj.id else 0 end) as adjustnum ")//补票凭证数
				.append(" ,nvl(sum(case when d.code = 0 then t_dam.id else 0 end),0) as damagednum ")//坏票数
				
				.append(" , nvl(sum(case when d.code =tt.returnfeemode then tt.returnnum else 0 end), 0) as ticketreturnnum, d.value")//退票凭证数
				.append(" from userinfo u left join ticketsellbysalerday td on td.sellby = u.id left join organization o on td.orgid = o.id ")
				.append(" left join USERTICKETOUTLETS ut on ut.userinfoid  = td.sellby  left join ticketoutlets tl on tl.id = ut.ticketoutletsid")
				.append(" left join digitaldictionarydetail d on d.code=td.paymethod and d.digitaldictionaryid=50")
				// 退票
				.append(" left join (select count(ts.id) returnnum ,tr.returnby, tr.returnfeemode from ticketsell ts left join ticketreturn tr on ts.id = tr.sellid where tr.returnway in ('0','1','2') ")
				.append(" and tr.returnvoucherno is not null and tr.returntime between :startdate and :enddate+0.99999 group by tr.returnby,tr.returnfeemode) tt on tt.returnby = td.sellby ")
				//改签
				.append(" left join (select count(tc.id) id,ts.paymethod,tc.changeby from ticketchange tc,ticketsell ts ")
				.append(" where ts.id = tc.newticketsellid and tc.changetime >= :startdate and tc.changetime <= :enddate+ 0.99999 ")
				.append(" group by ts.paymethod,tc.changeby) t_tc on t_tc.changeby = td.sellby and td.paymethod=t_tc.paymethod ")
				// 补票
				.append(" left join (select count(ts.id) id,ts.paymethod,ts.sellby from ticketsell ts ")
				.append(" where ts.selltime >= :startdate and ts.selltime <= :enddate + 0.99999 ")
				.append(" and ts.sellway in ('1', '2')  group by ts.paymethod,ts.sellby) t_adj on t_adj.sellby = td.sellby and td.paymethod=t_adj.paymethod ")
				// 坏票
				.append(" left join (select sum(bi.endno - bi.startno + 1) id ,bi.recordby from billdamaged bi ")
				.append(" where bi.recordtime >= :startdate and bi.recordtime <= :enddate+ 0.99999  group by bi.recordby) t_dam on t_dam.recordby = td.sellby  ")
				// where
				.append(" where 1 = 1 ")
				.append( " and td.selldate between :startdate and :enddate+ 0.99999 and td.sellby>0")
				.append(" and o.id in " + orgids)
				.append(" and u.id in " + sellerids);
				if (ticketoutletid != null && ticketoutletid.length() > 0) {
					sql.append(" and ut.ticketoutletsid in " + ticketoutletid);
				}
				if (paymethod.length() == 3 && paymethod.indexOf("1")==1 ) {
					sql.append(" and d.code in (4,5)" );
				}
				if (paymethod.length() == 3 && paymethod.indexOf("2")==1 ) {
					sql.append(" and d.code in (0,1,2,3)");
				}
//				sql.append( " group by o.name,u.code,u.name,td.sellby, tl.name order by o.name,u.name ");
				sql.append( " group by o.name,u.code,u.name,td.sellby, tl.name, d.value,d.code ) ve  ")
				.append(" order by ve.orgname, ve.selldate, ve.name");
			} else {
				
				sql.append(",sum(case when d.code = t_tc.paymethod then t_tc.id else 0 end) as changenum  ")//改签凭证数 
				.append(" ,sum(case when d.code = t_adj.paymethod then t_adj.id else 0 end) as adjustnum ")//补票凭证数
				.append(" ,nvl(sum(case when d.code = 0 then t_dam.id else 0 end),0) as damagednum ")//坏票数
				
				.append(" , nvl(sum(case when d.code =tt.returnfeemode then tt.returnnum else 0 end), 0) as ticketreturnnum, d.value")//退票凭证数
				.append(" from organization o left join ticketsellbysalerday td on td.orgid = o.id ")
				.append(" left join USERTICKETOUTLETS ut on ut.userinfoid  = td.sellby  left join ticketoutlets tl on tl.id = ut.ticketoutletsid")
				.append(" left join digitaldictionarydetail d on d.code=td.paymethod and d.digitaldictionaryid=50")
				// 退票
				.append(" left join (select count(ts.id) returnnum ,tr.returnby, tr.returnfeemode from ticketsell ts left join ticketreturn tr on ts.id = tr.sellid where tr.returnway in ('0','1','2') ")
				.append(" and tr.returnvoucherno is not null and tr.returntime between :startdate and :enddate+0.99999 group by tr.returnby,tr.returnfeemode) tt on tt.returnby = td.sellby ")
				//改签
				.append(" left join (select count(tc.id) id,ts.paymethod,tc.changeby from ticketchange tc,ticketsell ts ")
				.append(" where ts.id = tc.newticketsellid and tc.changetime >= :startdate and tc.changetime <= :enddate+ 0.99999 ")
				.append(" group by ts.paymethod,tc.changeby) t_tc on t_tc.changeby = td.sellby and td.paymethod=t_tc.paymethod ")
				// 补票
				.append(" left join (select count(ts.id) id,ts.paymethod,ts.sellby from ticketsell ts ")
				.append(" where ts.selltime >= :startdate and ts.selltime <= :enddate + 0.99999 ")
				.append(" and ts.sellway in ('1', '2')  group by ts.paymethod,ts.sellby) t_adj on t_adj.sellby = td.sellby and td.paymethod=t_adj.paymethod ")
				// 坏票
				.append(" left join (select sum(bi.endno - bi.startno + 1) id ,bi.recordby from billdamaged bi ")
				.append(" where bi.recordtime >= :startdate and bi.recordtime <= :enddate+ 0.99999  group by bi.recordby) t_dam on t_dam.recordby = td.sellby  ")
				// where
				.append(" where 1 = 1 ");
				if (ticketoutletid != null && ticketoutletid.length() > 0) {
					sql.append(" and ut.ticketoutletsid in " + ticketoutletid);
				}
				if (paymethod.length() == 3 && paymethod.indexOf("1")==1 ) {
					sql.append(" and d.code in (4,5)" );
				}
				if (paymethod.length() == 3 && paymethod.indexOf("2")==1 ) {
					sql.append(" and d.code in (0,1,2,3)");
				}
				sql.append(" and td.selldate between :startdate and :enddate+0.99999 ")
				.append(" and ((o.type=2 and o.islocal=1 and td.sellby>0) or (o.islocal=0 and td.sellby=0) or  (o.type=0))")
//				.append(" and td.sellby>0")
				.append(" and o.id in " + orgids + " group by o.name,tl.name, d.value,d.code ");
				sql.append(" ) ve ")//ldz 
				.append(" order by ve.orgname, ve.selldate, ve.name");
			}
		}
		Logger.info("sql:---------->"+sql);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List list = query.getResultList();
		Logger.info("size:--------->"+list.size());
		return list;
	}

	/**
	 * 本站售异站汇总表
	 * @param isgroupbyday 
	 * @param besaleorgids 
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySalerSyncOrgRevenue(String orgids, Date startdate,
			Date enddate, long orgid,String datetype,long currorgid, Boolean isgroupbyday, String besaleorgids) {
		parameterService = new ParameterServiceImpl();
		String rate = parameterService.findParamValue(ParamterConst.Param_4002, null);
		String orgsql = "select org.name from Organization org where org.id="+currorgid;
		Query queryorg = getEntityManager().createNativeQuery(orgsql.toString());
		String orgname = (String) queryorg.getResultList().get(0);
		if("0".endsWith(datetype))//售票日期
		{
			String selectbyday = isgroupbyday!=null && isgroupbyday?",t.selldate,'' as departdate":" ";
			String groupbyday = isgroupbyday!=null && isgroupbyday?",t.selldate":" ";
		StringBuilder sql = new StringBuilder(
				" select trim('"+orgname+"') as sellorgname,org.name"+selectbyday+",sum(t.sellnum),sum(totalprice),"
						+ " sum(t.returnnum)+sum(synreturnsynnum) , sum(t.returnprice- t.returnfee)+sum(synreturnsynprice),sum(t.returnfee), sum(t.cancelnum),"
						+ " sum(t.cancelmoeny), "
						+ " sum(t.totalprice - t.synreturnsynprice -"
						+ " t.cancelmoeny - t.returnprice - t.totalfee) *:rate + sum(t.computefee) as receivemoney,"//应收
						+ "sum(t.divideprice),"//sum(synreturnsynprice)
						//划转金额=分配金额-应收
						+ " sum(divideprice)-(sum(totalprice-returnprice-cancelmoeny-synreturnsynprice-totalfee)*0.08+sum(computefee)) as payprice,"
						+ " sum(t.stationservicefee),sum(t.computefee),"//sum(synreturnsynprice),
						+ " sum(t.coolairfee),sum(t.additionfee),sum(t.insurefee),sum(t.waterfee),sum(t.otherfee),sum(totalfee),sum(baseprice),")
//						
						
				.append(" sum(fueladditionfee)")  //sum(moreprice),
				.append(" from ticketsellbysalerday t, organization org ")
				.append(" where t.scheduleorgid = org.id and t.orgid=:orgid")
				.append(" and t.selldate between :startdate and")
				.append(" :enddate and t.scheduleorgid in " + orgids).append(besaleorgids==null||"".equals(besaleorgids.trim())?"":" and t.orgid in "+besaleorgids)
				.append(" group by org.name"+groupbyday);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("orgid", orgid);
		query.setParameter("rate", rate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
		}
		else//发车日期
		{
			String selectbyday = isgroupbyday!=null && isgroupbyday?",'' as selldate,t.departdate":" "; 
			String groupbyday = isgroupbyday!=null && isgroupbyday?" group by trim('"+orgname+"'),t.orgname,t.departdate ":" group by trim('"+orgname+"'),t.orgname";
			StringBuilder sql = new StringBuilder();
			
			if(isgroupbyday){
//				sql.append("  select trim('"+orgname+"') as sellorgname,t.orgname"+selectbyday+",t.sellnum,t.sellprice as totalprice, " );
//				sql.append(" 	t.returnnum,t.returnamount as returnprice,t.returncharges as returnfee,t.cancelnum,t.cancelprice as cancelmoney, ");
//				sql.append(" 	((t.sellprice-t.returnamount-t.cancelprice)-(computefee+stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee))*:rate+computefee as receivemoney, ");//应收
//				sql.append(" 	(t.sellprice-t.returnamount-t.cancelprice) as divideprice, ");
//				sql.append(" 	(t.sellprice-t.returnamount-t.cancelprice)-((t.sellprice-t.returnamount-t.cancelprice)-(computefee+stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee))*:rate-computefee as payprice,");
//				sql.append(" 	t.stationservicefee,t.computefee,t.coolairfee,t.additionfee,t.insurefee,t.waterfee,t.otherfee,");
//				sql.append(" 	(computefee+stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee) as totalfee, ");
//				sql.append(" 	(t.sellprice-t.returnamount-t.cancelprice)-(computefee+stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee) as baseprice ");
				sql.append("  select trim('"+orgname+"') as sellorgname,t.orgname"+selectbyday+",sum(t.sellnum),sum(t.sellprice) as totalprice, " );
				sql.append(" 	sum(t.returnnum),sum(t.returnamount) as returnprice,sum(t.returncharges) as returnfee,sum(t.cancelnum),sum(t.cancelprice) as cancelmoney, ");
				sql.append(" 	sum(((t.sellprice-t.returnamount-t.cancelprice-returncharges)-(stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee))*:rate+computefee) as receivemoney, ");//应收
				sql.append(" 	sum((t.sellprice-t.returnamount-t.cancelprice-returncharges)) as divideprice, ");
				sql.append(" 	sum((t.sellprice-t.returnamount-t.cancelprice-returncharges)-((t.sellprice-t.returnamount-t.cancelprice-returncharges)-(stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee))*:rate-computefee) as payprice,");
				sql.append(" 	sum(t.stationservicefee),sum(t.computefee),sum(t.coolairfee),sum(t.additionfee),sum(t.insurefee),sum(t.waterfee),sum(t.otherfee),");
				sql.append(" 	sum((stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee)) as totalfee, ");
				sql.append(" 	sum((t.sellprice-t.returnamount-t.cancelprice-t.returncharges)-(stationservicefee+computefee+coolairfee+additionfee+fueladditionfee)) as baseprice ");//+insurefee+waterfee+otherfee
			}else{
				sql.append("  select trim('"+orgname+"') as sellorgname,t.orgname"+selectbyday+",sum(t.sellnum),sum(t.sellprice) as totalprice, " );
				sql.append(" 	sum(t.returnnum),sum(t.returnamount) as returnprice,sum(t.returncharges) as returnfee,sum(t.cancelnum),sum(t.cancelprice) as cancelmoney, ");
				sql.append(" 	sum(((t.sellprice-t.returnamount-t.cancelprice-returncharges)-(stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee))*:rate+computefee) as receivemoney, ");//应收
				sql.append(" 	sum((t.sellprice-t.returnamount-t.cancelprice-returncharges)) as divideprice, ");
				sql.append(" 	sum((t.sellprice-t.returnamount-t.cancelprice-returncharges)-((t.sellprice-t.returnamount-t.cancelprice-returncharges)-(stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee))*:rate-computefee) as payprice,");
				sql.append(" 	sum(t.stationservicefee),sum(t.computefee),sum(t.coolairfee),sum(t.additionfee),sum(t.insurefee),sum(t.waterfee),sum(t.otherfee),");
				sql.append(" 	sum((stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee)) as totalfee, ");
				sql.append(" 	sum((t.sellprice-t.returnamount-t.cancelprice-t.returncharges)-(stationservicefee+computefee+coolairfee+additionfee+fueladditionfee)) as baseprice ");//+insurefee+waterfee+otherfee
			}
			sql.append(" ,sum(fueladditionfee)");
			sql.append(" 	from( ");
			sql.append(" 	select o.name as orgname, ");
			sql.append("     ts.departdate,");
			sql.append("  count(ts.id) as sellnum,");
			sql.append("	sum(ts.price) as sellprice,                                                               ");
			sql.append("     0 as returnnum,                                                                         ");
			sql.append("	 0 as returnamount,                                                                        ");
			sql.append(" 	 0 as returncharges,                                                                      ");
			sql.append("  	 0 as cancelnum,                                                           ");
			sql.append("  	 0 as cancelprice,    ");//废票款 
			sql.append("  	 sum(decode(ts.ticketstatus,  '0', ts.stationservicefee, 0)) stationservicefee,  ");
			sql.append("  	 sum(decode(ts.ticketstatus, '0', ts.computefee, 0)) computefee,");//--微机费
			sql.append("     sum(decode(ts.ticketstatus, '0', ts.coolairfee, 0)) coolairfee,");//--空调费
			sql.append("     sum(decode(ts.ticketstatus, '0', ts.additionfee, 0)) additionfee,");//--附加费
			sql.append("     sum(decode(ts.ticketstatus, '0', ts.insurefee,0)) insurefee,");
			sql.append("  	sum(decode(ts.ticketstatus, '0', ts.waterfee,0)) waterfee,");
			sql.append("    sum(decode(ts.ticketstatus, '0', ts.otherfee,0)) otherfee,");
			sql.append("  	sum(decode(ts.ticketstatus, '0', ts.fueladditionfee,0)) fueladditionfee");
			sql.append(" 	from ticketsellagent ts left join organization o on ts.orgid = o.id ");// --机构是售票机构
			sql.append("    left join userinfo u on u.id =  ts.sellby left join organization ou on  u.orgid =  ou.id");
		    sql.append("    where 1=1 ");// --and ts.orgid in() 
		    sql.append("    and ts.orgid in "+orgids+"                                                      ");
		    sql.append(" 	and ts.departdate between :startdate and :enddate ").append(besaleorgids==null||"".equals(besaleorgids.trim())?"":" and ou.id in "+besaleorgids);
		    sql.append("   group by o.name,ts.departdate                                                         ");
		    sql.append("  union                                                                                  ");
			sql.append("select o.name as orgname,                                                                 ");
			sql.append("       ts.departdate,                                                                         ");
			sql.append("       0 as sellnum,                                                                          ");
			sql.append("       0  as sellprice,                                                                       ");
			sql.append("       count(tr.id) as returnnum,                                                             ");
			sql.append("       sum(tr.returnamount) as returnamount,                                                  ");
			sql.append("       sum(tr.charges) as returncharges,                                                      ");
			sql.append("       0 as cancelnum,                                                                        ");
			sql.append("       0 as cancelprice,                                                                      ");
			sql.append("       0 as stationservicefee,                                                                ");
			sql.append("       0 as computefee,                                                                       ");
			sql.append("       0 as coolairfee,                                                                       ");
			sql.append("       0 as additionfee,                                                                      ");
			sql.append("       0 as insurefee,                                                                        ");
			sql.append("       0 as waterfee,                                                                         ");
			sql.append("       0 as otherfee,                                                                          ");
			sql.append("       0 as fueladditionfee ");
			sql.append("       from ticketreturn tr left join ticketsellagent ts on tr.sellid=ts.id                   ");
			sql.append("	   left join organization o on ts.orgid=o.id 							");
			sql.append("       left join userinfo u on u.id =  tr.returnby left join organization ou on  u.orgid =  ou.id");
			sql.append("                                                                                              ");
			sql.append("       where   1=1                                                              ");
			sql.append("      and ts.orgid in "+orgids+"                                                      ");
			sql.append(" and ts.departdate between :startdate and :enddate ").append(besaleorgids==null||"".equals(besaleorgids.trim())?"":" and ou.id in "+besaleorgids);
			sql.append("        group by o.name,ts.departdate                                                         ");
			sql.append("       union                                                                                  ");
			sql.append("select o.name as orgname,                                                                 ");
			sql.append("       ts.departdate,                                                                         ");
			sql.append("       0 as sellnum,                                                                          ");
			sql.append("       0  as sellprice,                                                                       ");
			sql.append("       0 as returnnum,                                                                        ");
			sql.append("       0 as returnamount,                                                                     ");
			sql.append("       0 as returncharges,                                                                    ");
			sql.append("       count(tc.id) as cancelnum,                                                             ");
			sql.append("       sum(tc.ticketprice) as cancelprice,                                                    ");
			sql.append("       0 as stationservicefee,                                                                ");
			sql.append("       0 as computefee,                                                                       ");
			sql.append("       0 as coolairfee,                                                                       ");
			sql.append("       0 as additionfee,                                                                      ");
			sql.append("       0 as insurefee,                                                                        ");
			sql.append("       0 as waterfee,                                                                         ");
			sql.append("       0 as otherfee,                                                                          ");
			sql.append("       0 as fueladditionfee ");
			sql.append("       from ticketcancel tc left join ticketsellagent ts on tc.sellid=ts.id 				");
			sql.append("		left join organization o on ts.orgid = o.id  ");
			sql.append("       left join userinfo u on u.id =  tc.cancelby left join organization ou on  u.orgid =  ou.id");
			sql.append("       where  1=1                                                                ");
			sql.append("      and ts.orgid in "+orgids+"    ").append(besaleorgids==null||"".equals(besaleorgids.trim())?"":" and ou.id in "+besaleorgids);
			sql.append(" and ts.departdate between :startdate and :enddate ");
			sql.append("        group by o.name,ts.departdate                                                         ");
			sql.append("       )t          "+groupbyday);
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
			query.setParameter("rate", rate);
			return query.getResultList();
		}
	}

	/**
	 * 异站售本站汇总表
	 * @param isgroupbyday 
	 * @param olddepartEdate 
	 * @param olddepartSdate 
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySyncSaleLocal(String orgids, Date startdate,
			Date enddate, String schorgids,String datetype,long currorgid, Boolean isolddate, Boolean isgroupbyday) {
		parameterService = new ParameterServiceImpl();
		String rate = parameterService.findParamValue(ParamterConst.Param_4002, null);
		
		String orgsql = "select org.name from Organization org where org.id="+currorgid;
		Query queryorg = getEntityManager().createNativeQuery(orgsql.toString());
		String orgname = (String) queryorg.getResultList().get(0);
		if("0".endsWith(datetype))//0表示售票日期
		{
			String selectbyday = isgroupbyday!=null && isgroupbyday?",t.selldate":" ";
			String groupbyday = isgroupbyday!=null && isgroupbyday?",t.selldate":" ";
			StringBuilder sql = new StringBuilder(                                                                  
					" select org.name as sellorgname,trim('"+orgname+"') as orgname"+selectbyday+",sum(t.sellnum),sum(t.totalprice),"
							+ " sum(t.synreturnlocnum)+sum(returnnum),sum(t.synreturnlocprice)+sum(returnprice)-sum(t.returnfee),sum(t.returnfee),"
							+ "  sum(t.cancelnum),sum(t.cancelmoeny),"
							+ " sum(t.totalprice -t.returnprice- t.cancelmoeny + t.returnfee) as receivemoney,"//应收
							+ "  sum(t.totalprice - t.returnprice - t.cancelmoeny) divideprice,"
							+ " sum(t.totalprice - t.cancelmoeny - t.returnprice - t.payprice) as localincome,"
							+ " sum(t.payprice) payprice,"
							+ " sum(t.stationservicefee),"//sum(returnnum), sum(returnprice),
							+ "   sum(t.computefee), sum(t.coolairfee), sum(t.additionfee),sum(t.insurefee),sum(t.waterfee),sum(t.otherfee),sum(t.fueladditionfee),"
							+ "   sum(t.totalfee),   sum(t.totalprice - t.returnprice - t.cancelmoeny) - sum(t.totalfee) baseprice,"
			                + " 0  as manualreturnnum,0 as manualreturnmoney ")
//					.append(" sum(moreprice),sum(fueladditionfee)")
					.append(" from Ticketsellbysalerday t, Organization org")
					.append(" where t.orgid = org.id ")
					.append(" and t.scheduleorgid  in  " + schorgids)
					.append(" and t.selldate between :startdate and")
					.append(" :enddate and t.orgid in " + orgids)
					.append(" group by org.name "+groupbyday);
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
//			query.setParameter("rate", rate);
			return query.getResultList();
		}
		else//按发车日期统计
		{
			String selectbyday = isgroupbyday!=null && isgroupbyday?",t.departdate as selldate":" ";
			StringBuilder sql = new StringBuilder(" select t.sellorgname,trim('"+orgname+"') as orgname"+selectbyday+",sum(t.sellnum)sellnum,sum(t.sellprice) as totalprice, ");
			sql.append(" sum(t.returnnum)returnnum,sum(t.returnamount)  as returnprice,sum(t.returncharges) as returnfee,sum(t.cancelnum)cancelnum,sum(t.cancelprice) as cancelmoney, ");
			sql.append(" sum(t.sellprice-t.returnamount-t.cancelprice - t.manualreturnmoney) as receivemoney, ");//应收
//			sql.append(" sum(t.sellprice-t.returnamount-t.cancelprice) as divideprice,sum((t.sellprice-t.returnamount-t.cancelprice)-(t.sellprice-t.returnamount-t.cancelprice)*:rate-computefee) as localincome, ");
//			sql.append(" sum((t.sellprice-t.returnamount-t.cancelprice)*:rate+computefee) as payprice,");
			sql.append(" sum(t.sellprice-t.returnamount-t.cancelprice-t.returncharges) as divideprice,")
			.append("  sum(decode(type,'0',0,")
			.append(" (t.sellprice-t.returnamount-t.cancelprice-t.returncharges)-"
					+ "((t.sellprice-t.returncharges-t.returnamount-t.cancelprice-"
					+ "(computefee+stationservicefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee))*:rate+computefee))) as localincome,")
			.append("  sum(decode(type,'0',(t.sellprice-t.returnamount-t.cancelprice),")
			.append(" (t.sellprice-t.returncharges-t.returnamount-t.cancelprice-(computefee+stationservicefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee))*:rate+computefee)) as payprice,");
//
//			sql.append(" sum(t.stationservicefee)stationservicefee,sum(t.computefee)computefee,sum(t.coolairfee)coolairfee,sum(t.additionfee)additionfee,");
//			sql.append(" sum(t.insurefee)insurefee,sum(t.waterfee)waterfee,sum(t.otherfee)otherfee,sum(t.fueladditionfee)fueladditionfee,");
//			sql.append(" sum(computefee+stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee) as totalfee, ");
//			sql.append(" sum((t.sellprice-t.returnamount-t.cancelprice)-(computefee+stationservicefee+computefee+coolairfee+additionfee+insurefee+waterfee+otherfee)) as baseprice, ");
			sql.append(" sum(t.stationservicefee),sum(t.computefee),sum(t.coolairfee),sum(t.additionfee),")
			.append("  sum(t.insurefee),sum(t.waterfee),sum(t.otherfee),sum(t.fueladditionfee),");
			sql.append(" sum(computefee+stationservicefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee) as totalfee, ");
			sql.append(" sum((t.sellprice-t.returnamount-t.cancelprice-t.returncharges)-(computefee+stationservicefee+coolairfee+additionfee+insurefee+waterfee+otherfee+fueladditionfee)) as baseprice, ");
			sql.append(" sum(t.manualreturnnum)manualreturnnum,sum(t.manualreturnmoney)manualreturnmoney ");  
			sql.append(" from( ");
			sql.append(" select o.name as sellorgname, ");
			sql.append("     ts.departdate,");
			sql.append("  count(ts.id) as sellnum,");
			sql.append("sum(ts.price) as sellprice,                                                               ");
			sql.append("  0 as returnnum,                                                                         ");
			sql.append("0 as returnamount,                                                                        ");
			sql.append(" 0 as returncharges,                                                                      ");
			sql.append("  0 as cancelnum,                                                           ");
			sql.append("  0 as cancelprice,    ");//废票款 
			sql.append("  sum(ts.stationservicefee) stationservicefee,  ");
			sql.append("  sum(ts.computefee) computefee,");//--微机费
			sql.append("  sum(ts.coolairfee) coolairfee,");//--空调费
			sql.append("  sum(ts.additionfee) additionfee,");//--附加费
			sql.append("  sum(ts.insurefee) insurefee,");
			sql.append("  sum(ts.waterfee) waterfee,");
			sql.append("  sum(ts.otherfee) otherfee,");
			sql.append("  sum(ts.fueladditionfee) fueladditionfee,");
			sql.append(" sum(decode(soi.orderno,null,0,1)) as manualreturnnum,sum(decode(soi.orderno,null,0,ts.price)) as manualreturnmoney,o.type ");
			sql.append(" from ticketsell ts left join organization o on ts.orgid = o.id ");// --机构是售票机构
			sql.append(" left join specialorderinfo soi on ts.orderno=soi.orderno ");  //增加手工退票数和手工退还乘客票款两个列信息(20180523，禅道号20437，应城汽车客运站）
			//sql.append(" left join ticketmixcheck tmc on tmc.ticketsellid = ts.id and tmc.isactive = 1  ");
		    sql.append("    where 1=1 ");// --and ts.orgid in() 
			if (isolddate) {
				sql.append(" and nvl(ts.olddepartdate,ts.departdate) between :startdate and :enddate  ");
			}else{
				sql.append(" and ts.departdate between :startdate and :enddate ");
			}
		    sql.append("    and ts.orgid in "+orgids+"                                                      ");
		    sql.append("   group by o.name,ts.departdate ,o.type ");
		    sql.append("  union                                                                                  ");
			sql.append("select o.name as sellorgname,                                                                 ");
			sql.append("       ts.departdate,                                                                         ");
			sql.append("       0 as sellnum,                                                                          ");
			sql.append("       0  as sellprice,                                                                       ");
			sql.append("       count(tr.id) as returnnum,                                                             ");
			sql.append("       sum(tr.returnamount+nvl(tr.returnamountweb,0)) as returnamount,                                                  ");
			sql.append("       sum(tr.charges+nvl(tr.chargesweb,0)) as returncharges,                                                      ");
			sql.append("       0 as cancelnum,                                                                        ");
			sql.append("       0 as cancelprice,                                                                      ");
			  sql.append("  -sum(ts.stationservicefee) stationservicefee,  ");
	            sql.append("  -sum(ts.computefee) computefee,");//--微机费
	            sql.append("  -sum(ts.coolairfee) coolairfee,");//--空调费
	            sql.append("  -sum(ts.additionfee) additionfee,");//--附加费
	            sql.append("  -sum(ts.insurefee) insurefee,");
	            sql.append("  -sum(ts.waterfee) waterfee,");
	            sql.append("  -sum(ts.otherfee) otherfee,");
	            sql.append("  -sum(ts.fueladditionfee) fueladditionfee,");
			sql.append(" 0  as manualreturnnum,0 as manualreturnmoney,o.type ");
			sql.append("       from ticketreturn tr left join ticketsell ts on tr.sellid=ts.id              ");
			sql.append("       left join organization o on   ts.orgid=o.id left join userinfo u on u.id = tr.returnby              ");
			sql.append("       where 1=1                                                                 ");
			sql.append("      and ((ts.orgid in "+orgids+" and ts.orgid=u.orgid) ");
			//21233 青海省黄南州汽车站，4.21-5.20日和5.21-6.20日车站与网站退票张数与退票票款不一致
			sql.append("   or (ts.orgid in "+orgids+" and u.orgid<>ts.orgid and tr.returnfeemode='1'))"); 
			sql.append(" and ts.departdate between :startdate and :enddate ");
			sql.append("        group by o.name,ts.departdate ,o.type                                                         ");
			sql.append("       union                                                                                  ");
			sql.append("select o.name as sellorgname,                                                                 ");
			sql.append("       ts.departdate,                                                                         ");
			sql.append("       0 as sellnum,                                                                          ");
			sql.append("       0  as sellprice,                                                                       ");
			sql.append("       0 as returnnum,                                                                        ");
			sql.append("       0 as returnamount,                                                                     ");
			sql.append("       0 as returncharges,                                                                    ");
			sql.append("       count(tc.id) as cancelnum,                                                             ");
			sql.append("       sum(tc.ticketprice) as cancelprice,                                                    ");
		    sql.append("  -sum(ts.stationservicefee) stationservicefee,  ");
            sql.append("  -sum(ts.computefee) computefee,");//--微机费
            sql.append("  -sum(ts.coolairfee) coolairfee,");//--空调费
            sql.append("  -sum(ts.additionfee) additionfee,");//--附加费
            sql.append("  -sum(ts.insurefee) insurefee,");
            sql.append("  -sum(ts.waterfee) waterfee,");
            sql.append("  -sum(ts.otherfee) otherfee,");
            sql.append("  -sum(ts.fueladditionfee) fueladditionfee,");
			sql.append(" 0  as manualreturnnum,0 as manualreturnmoney ,o.type");
			sql.append("       from ticketcancel tc left join ticketsell ts on  tc.sellid=ts.id                   ");
			sql.append(" 		left join organization o on ts.orgid = o.id 					");
			sql.append("       where    1=1                                                             ");
			sql.append("      and ts.orgid in "+orgids+"                                                     ");
			sql.append(" and ts.departdate between :startdate and :enddate ");
			sql.append("        group by o.name,ts.departdate ,o.type                                                         ");
			sql.append("       )t                                                                                     ");

			sql.append(" group by t.sellorgname ");
			sql.append(isgroupbyday!=null && isgroupbyday?",t.departdate ":" ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
			query.setParameter("rate", rate);
			return query.getResultList();	                                                                                                    
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object> querySyncOrg(long orgid) {
		StringBuilder sql = new StringBuilder(
				" select org.id,org.name,org.code from Organization org"
						+ " where org.type in ('0','1','2') and org.id!=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}

	/**
	 * 客运站划拨明细表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryInvoincesDetail(String orgids,
			List<PropertyFilter> propertyFilterList) {
		String departinvoicestype = null;
		Iterator<PropertyFilter> iterator = propertyFilterList.iterator();
		while (iterator.hasNext()) {
			PropertyFilter propertyFilter = iterator.next();
			if ("v!departinvoicestype".equals(propertyFilter.getPropertyFullName())) {
				departinvoicestype = propertyFilter.getMatchValue().toString();
				iterator.remove();
				break;
			}
		}
		List<Object> list = new ArrayList<Object>();
		if ("1".equals(departinvoicestype)) {    //微机单
			StringBuilder sql = new StringBuilder(
					"select departdate,invoinceno,departtime,routename,code,vehicleno,ticketnum,"
							+ "totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,basefee,agentfee,balanceamount,unitname,"
							+ "balaceunitname,remark,printtime,typename,peopledistance,"
							+ "waterfee,insurefee,otherfee,fueladditionfee,(waterfee+insurefee+"
							+ "otherfee+fueladditionfee+stationservicefee+additionfee+"
							+ "computefee+coolairfee) subtotal,moreprice "
							+ " from ( select dv.departdate,dv.departinvoicesno invoinceno,"
							+ " trim(dv.departtime) departtime,r.name as routename,"
							+ " s.code,v.vehicleno,dv.ticketnum,dv.totalamount,"
							+ " dv.stationservicefee,nvl((select sum(dd.deductmoney)"
							+ " from departinvoicesdeductdetail dd,balancedeductitem a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id and dd.status<>'1'"
							+ " and a.code like '%E%'),0) computefee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.code like '%G%'),0) coolairfee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.code like '%D%'),0) additionfee,"
							+ " (dv.totalamount - dv.fueladditionfee - dv.stationservicefee - dv.othterfee) basefee,"
							+ " dv.agentfee,dv.balanceamount,u1.name unitname,u2.name balaceunitname,"
							+ " case when s.isovertime = 1 then '加班'  else '' end remark,dv.printtime,"
							+ " dd.value as typename,nvl((select sum(dd.distance *dd.ticketnum ) "
							+ " from departinvoicesdetail dd where dd.departinvoicesid=dv.id "
							+ " group by dd.departinvoicesid ),0) peopledistance, "
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.name like '%水费%'),0) waterfee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.name like '%保险费%'),0) insurefee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and (a.name like '%其他%' or a.name like '%其它%')),0) otherfee,"
							+ " dv.fueladditionfee,dv.moreprice"
							+ " from departinvoices dv, route          r,"
							+ " schedule       s,station        st,"
							+ " vehicle        v,unit           u1,"
							+ " unit           u2  ,digitaldictionary d,digitaldictionarydetail dd "
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u1.id"
							+ " and v.balanceunitid = u2.id"
							+ " and d.tablename='vehicle' and d.columnname='type' "
							+ " and dd.digitaldictionaryid=d.id and dd.code= v.type "
							+ " and dv.status <> '1' and s.orgid in " + orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order  by r.id, dv.departtime ) ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		} else if ("2".equals(departinvoicestype)) {  //手工单
			StringBuilder sql = new StringBuilder();
			sql.append(" select departdate,invoinceno,departtime,routename,code,vehicleno,ticketnum, ")
			.append(" totalamount,stationservicefee,computefee,coolairfee, ")
			.append(" additionfee,basefee,agentfee,balanceamount,unitname, ")
			.append(" balaceunitname,remark,printtime,typename,peopledistance, ")
			.append(" waterfee,insurefee,otherfee,fueladditionfee,(waterfee+insurefee+ ")
			.append(" otherfee+fueladditionfee+stationservicefee+additionfee+ ")
			.append(" computefee+coolairfee) subtotal,moreprice ")
			.append(" from (select dv.departdate,dv.departinvoicesno invoinceno,trim(dv.departtime) departtime, ")
			.append(" r.name as routename,s.code,v.vehicleno,dv.ticketnum,dv.totalmoney as totalamount, ")
			.append(" dv.stationfee as stationservicefee,0 as computefee,0 as coolairfee, 0 as additionfee, ")
			.append(" (dv.totalmoney - dv.stationfee - dv.othterfee) basefee,dv.agentfee,dv.balancemoney as balanceamount, ")
			.append(" u1.name unitname,u2.name balaceunitname, ")
			.append(" case when s.isovertime = 1 then '加班' else '' end remark,dv.createtime as printtime,")
			.append(" dd.value as typename, ")
			.append(" nvl((select sum(dd.distance * dd.ticketnum) from departinvoicesdetail dd ")
			.append(" where dd.departinvoicesid = dv.id group by dd.departinvoicesid),0) peopledistance, ")
			.append(" 0 as waterfee,0 as insurefee,dv.othterfee as otherfee,0 as fueladditionfee,0 as moreprice ")
			.append(" from departinvoicesother dv,route r,schedule s,station st,vehicle v,unit u1,unit u2,  ")
			.append(" digitaldictionary d,digitaldictionarydetail dd ")
			.append(" where dv.scheduleid = s.id and s.routeid = r.id and r.endstationid = st.id and dv.vehicleid = v.id ")
			.append(" and v.unitid = u1.id and v.balanceunitid = u2.id and d.tablename = 'vehicle' and d.columnname = 'type' ")
			.append(" and dd.digitaldictionaryid = d.id and dd.code = v.type and dv.status <> '1' and s.orgid in" + orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order  by r.id, dv.departtime ) ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		} else {   //全部
			StringBuilder sql = new StringBuilder(
					"select departdate,invoinceno,departtime,routename,code,vehicleno,ticketnum,"
							+ "totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,basefee,agentfee,balanceamount,unitname,"
							+ "balaceunitname,remark,printtime,typename,peopledistance,"
							+ "waterfee,insurefee,otherfee,fueladditionfee,(waterfee+insurefee+"
							+ "otherfee+fueladditionfee+stationservicefee+additionfee+"
							+ "computefee+coolairfee) subtotal,moreprice "
							+ " from ( select dv.departdate,dv.departinvoicesno invoinceno,"
							+ " trim(dv.departtime) departtime,r.name as routename,"
							+ " s.code,v.vehicleno,dv.ticketnum,dv.totalamount,"
							+ " dv.stationservicefee,nvl((select sum(dd.deductmoney)"
							+ " from departinvoicesdeductdetail dd,balancedeductitem a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id and dd.status<>'1'"
							+ " and a.code like '%E%'),0) computefee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.code like '%G%'),0) coolairfee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.code like '%D%'),0) additionfee,"
							+ " (dv.totalamount - dv.fueladditionfee - dv.stationservicefee - dv.othterfee) basefee,"
							+ " dv.agentfee,dv.balanceamount,u1.name unitname,u2.name balaceunitname,"
							+ " case when s.isovertime = 1 then '加班'  else '' end remark,dv.printtime,"
							+ " dd.value as typename,nvl((select sum(dd.distance *dd.ticketnum ) "
							+ " from departinvoicesdetail dd where dd.departinvoicesid=dv.id "
							+ " group by dd.departinvoicesid ),0) peopledistance, "
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.name like '%水费%'),0) waterfee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and a.name like '%保险费%'),0) insurefee,"
							+ " nvl((select sum(dd.deductmoney) from departinvoicesdeductdetail dd,"
							+ " balancedeductitem          a"
							+ " where dd.departinvoicesid = dv.id"
							+ " and dd.balanceitemid = a.id  and dd.status<>'1' "
							+ " and (a.name like '%其他%' or a.name like '%其它%')),0) otherfee,"
							+ " dv.fueladditionfee,dv.moreprice"
							+ " from departinvoices dv, route          r,"
							+ " schedule       s,station        st,"
							+ " vehicle        v,unit           u1,"
							+ " unit           u2  ,digitaldictionary d,digitaldictionarydetail dd "
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u1.id"
							+ " and v.balanceunitid = u2.id"
							+ " and d.tablename='vehicle' and d.columnname='type' "
							+ " and dd.digitaldictionaryid=d.id and dd.code= v.type "
							+ " and dv.status <> '1' and s.orgid in " + orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order  by r.id, dv.departtime ) ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			
			list = query.getResultList();
			
			sql = new StringBuilder();
			sql.append(" select departdate,invoinceno,departtime,routename,code,vehicleno,ticketnum, ")
			.append(" totalamount,stationservicefee,computefee,coolairfee, ")
			.append(" additionfee,basefee,agentfee,balanceamount,unitname, ")
			.append(" balaceunitname,remark,printtime,typename,peopledistance, ")
			.append(" waterfee,insurefee,otherfee,fueladditionfee,(waterfee+insurefee+ ")
			.append(" otherfee+fueladditionfee+stationservicefee+additionfee+ ")
			.append(" computefee+coolairfee) subtotal,moreprice ")
			.append(" from (select dv.departdate,dv.departinvoicesno invoinceno,trim(dv.departtime) departtime, ")
			.append(" r.name as routename,s.code,v.vehicleno,dv.ticketnum,dv.totalmoney as totalamount, ")
			.append(" dv.stationfee as stationservicefee,0 as computefee,0 as coolairfee, 0 as additionfee, ")
			.append(" (dv.totalmoney - dv.stationfee - dv.othterfee) basefee,dv.agentfee,dv.balancemoney as balanceamount, ")
			.append(" u1.name unitname,u2.name balaceunitname, ")
			.append(" case when s.isovertime = 1 then '加班' else '' end remark,dv.createtime as printtime,")
			.append(" dd.value as typename, ")
			.append(" nvl((select sum(dd.distance * dd.ticketnum) from departinvoicesdetail dd ")
			.append(" where dd.departinvoicesid = dv.id group by dd.departinvoicesid),0) peopledistance, ")
			.append(" 0 as waterfee,0 as insurefee,dv.othterfee as otherfee,0 as fueladditionfee,0 as moreprice ")
			.append(" from departinvoicesother dv,route r,schedule s,station st,vehicle v,unit u1,unit u2,  ")
			.append(" digitaldictionary d,digitaldictionarydetail dd ")
			.append(" where dv.scheduleid = s.id and s.routeid = r.id and r.endstationid = st.id and dv.vehicleid = v.id ")
			.append(" and v.unitid = u1.id and v.balanceunitid = u2.id and d.tablename = 'vehicle' and d.columnname = 'type' ")
			.append(" and dd.digitaldictionaryid = d.id and dd.code = v.type and dv.status <> '1' and s.orgid in" + orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order  by r.id, dv.departtime ) ");
			query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			
			list.addAll(query.getResultList());
			
			return list;
		}
	}

	/**
	 * 车辆划拨汇总表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleIncome(String orgids, Date startdate,
			Date enddate, List<PropertyFilter> propertyFilterList,
			String printorgids) {

		StringBuilder sql = new StringBuilder(
				"select decode(grouping(stationname), 1, '合计', stationname) endstation,"
						+ " decode(grouping(stationname) + grouping(unitname),1, '', unitname) balancename,"
						+ " decode(grouping(vehicleno) + grouping(stationname),1,'小计',vehicleno) vehicleno,"
						+"  (select max(rs.distance) from routestop rs, station st"
						+"    where rs.stationid = st.id and st.name = stationname) distance,"
						+"  sum(totaldistance) totaldistance,"
						+ " sum(invoicesnonum) ,sum(schedulenum),sum(ticketnum),sum(totalamount),"
						+ " sum(stationservicefee),sum(computefee),sum(coolairfee),"
						+ " sum(additionfee),sum(fueladditionfee),sum(waterfee),sum(insurefee),"
						+ " sum(otherfee),sum(basemount),sum(agentfee),sum(income),"
						+ " sum(balanceamount),sum(peopledistance),sum(moreprice),"
						+ " sum(waterfee+insurefee+otherfee+fueladditionfee+stationservicefee+additionfee+"
						+ " computefee+coolairfee) subtotal"
						+ " from ( select st.name stationname,u1.name unitname,v.vehicleno,"
						+ " count(dv.departinvoicesno) as invoicesnonum,"
						+ " count(distinct dv.reportid) as schedulenum,r.distance*count(distinct dv.reportid) totaldistance,"
						+ " sum(dv.ticketnum) as ticketnum,"
						+ " sum(dv.totalamount) as totalamount,"
						+ " sum(dv.stationservicefee) as stationservicefee,"
						+ " sum(nvl((select sum(dd.deductmoney)"
						+ "          from departinvoicesdeductdetail dd,"
						+ "               balancedeductitem          a"
						+ "         where dd.departinvoicesid = dv.id"
						+ "           and dd.balanceitemid = a.id "
						+ "           and dd.status<>'1'"
						+ "           and a.code = 'C' ),"
						+ "        0)) computefee,"
						+ " sum(nvl((select sum(dd.deductmoney)"
						+ "          from departinvoicesdeductdetail dd,"
						+ "               balancedeductitem          a"
						+ "         where dd.departinvoicesid = dv.id"
						+ "           and dd.balanceitemid = a.id "
						+ "           and dd.status<>'1'"
						+ "           and a.code = 'G' ),"
						+ "        0)) coolairfee,"
						+ " sum(nvl((select sum(dd.deductmoney)"
						+ "          from departinvoicesdeductdetail dd,"
						+ "               balancedeductitem          a"
						+ "         where dd.departinvoicesid = dv.id"
						+ "           and dd.balanceitemid = a.id "
						+ "           and dd.status<>'1'"
						+ "           and a.code = 'D' ),"
						+ "        0)) additionfee,"
						+ " sum(dv.fueladditionfee) as fueladditionfee,"
						+ " sum(nvl((select sum(dd.deductmoney)"
						+ "          from departinvoicesdeductdetail dd,"
						+ "               balancedeductitem          a"
						+ "         where dd.departinvoicesid = dv.id"
						+ "           and dd.balanceitemid = a.id "
						+ "           and dd.status<>'1'"
						+ "           and a.code = 'H' ),"
						+ "        0)) waterfee,"
						+ " sum(nvl((select sum(dd.deductmoney)"
						+ "          from departinvoicesdeductdetail dd,"
						+ "               balancedeductitem          a"
						+ "         where dd.departinvoicesid = dv.id"
						+ "           and dd.balanceitemid = a.id "
						+ "           and dd.status<>'1'"
						+ "           and a.code = 'I' ),"
						+ "        0)) insurefee,"
						+ " sum(nvl((select sum(dd.deductmoney)"
						+ "          from departinvoicesdeductdetail dd,"
						+ "               balancedeductitem          a"
						+ "         where dd.departinvoicesid = dv.id"
						+ "           and dd.balanceitemid = a.id "
						+ "           and dd.status<>'1'"
						+ "           and a.code = 'J' ),"
						+ "        0)) otherfee,"
						+ " sum(dv.totalamount-dv.stationservicefee - dv.fueladditionfee- dv.othterfee) as basemount,"
						+ " sum(dv.agentfee) as agentfee,"
						+ " sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,"
						+ " sum(dv.balanceamount) as balanceamount,"
						+ " sum(de.peopledistance) peopledistance,sum(dv.moreprice) moreprice "
						+ " from Departinvoices dv,"
						+ " route          r,    schedule       s,"
						+ " station        st,       vehicle        v,"
						+ " unit           u1,       unit           u2,"
						+ "    (select dt.departinvoicesid,"
						+ "            sum(dt.distance * dt.ticketnum) peopledistance"
						+ "       from departinvoicesdetail dt"
						+ "     where dt.departdate between :startdate and "
						+ "          :enddate"
						+ "   group by dt.departinvoicesid) de"
						+ " where dv.scheduleid = s.id"
						+ " and s.routeid = r.id   and r.endstationid = st.id"
						+ " and dv.id = de.departinvoicesid(+)"
						+ " and dv.vehicleid = v.id and v.unitid = u2.id"
						+ " and dv.balanceunitid = u1.id"
						+ " and dv.departdate between :startdate and :enddate"
						+ "  and dv.status <> '1' and s.orgid in " + orgids)
				.append(" and dv.printorgid in " + printorgids);

		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by st.name,r.distance,u1.name,v.vehicleno )")
				.append(" group by rollup(stationname, unitname, vehicleno)")
				.append(" order by stationname, unitname, vehicleno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 各分公司划拨汇总表
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBalanceUnitInvoinces(String orgids, int type,
			List<PropertyFilter> propertyFilterList) {

		if (type == 0) {
			// 按车属单位
			StringBuilder sql = new StringBuilder(
					"select  name,balanceunit,unitname,invoicesnonum,schedulenum,"
							+ "ticketnum,totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,fuelfee,otherfee,insurefee,waterfee,basemount,agentfee,"
							+ "(stationservicefee+computefee+coolairfee+additionfee+fuelfee"
							+ "+otherfee+insurefee+waterfee) subtotal,income,balanceamount,moreprice"
							+ " from (select  u1.name as name,'' as balanceunit,'' as unitname,"
							+ " count(dv.departinvoicesno) as invoicesnonum,"
							+ " count(distinct dv.reportid) as schedulenum,"
							+ " sum(dv.ticketnum) as ticketnum,"
							+ " sum(dv.totalamount) as totalamount,     "
							+ " sum(dv.stationservicefee) as stationservicefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "          where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%微机费%'),"
							+ "         0)) computefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "                where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%空调费%'),"
							+ "               0)) coolairfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "               balancedeductitem          a"
							+ "         where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%附加费%'),"
							+ "        0)) additionfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%燃油费%'),"
							+ "     0)) fuelfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%配水费%'),"
							+ "     0)) waterfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%保险费%'),"
							+ "     0)) insurefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and (a.name like '%其他%' or a.name like '%其它%')),"
							+ "     0)) otherfee,"
							+ "         sum(dv.totalamount- dv.fueladditionfee - dv.stationservicefee-dv.othterfee) as basemount,"
							+ "        sum(dv.agentfee) as agentfee,"
							+ " sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,"
							+ " sum(dv.balanceamount) as balanceamount,sum(dv.moreprice) moreprice "
							+ " from departinvoices dv," + " route          r,"
							+ "  schedule       s," + " station        st,"
							+ " vehicle        v," + " unit           u1,"
							+ " unit           u2"
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u1.id"
							+ " and dv.balanceunitid = u2.id"
							+ " and dv.status <> '1'" + " and dv.printorgid in "
							+ orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" group by u1.name order by u1.name )");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();

		} else if (type == 1) {
			// 按结算单位
			StringBuilder sql = new StringBuilder(
					"select  name,balanceunit,unitname,invoicesnonum,schedulenum,"
							+ "ticketnum,totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,fuelfee,otherfee,insurefee,waterfee,basemount,agentfee,"
							+ "(stationservicefee+computefee+coolairfee+additionfee+fuelfee"
							+ "+otherfee+insurefee+waterfee) subtotal,income,balanceamount,moreprice"
							+ " from (select  u2.name as name,'' as balanceunit,'' as unitname,"
							+ " count(dv.departinvoicesno) as invoicesnonum,"
							+ " count(distinct dv.reportid) as schedulenum,"
							+ " sum(dv.ticketnum) as ticketnum,"
							+ " sum(dv.totalamount) as totalamount,     "
							+ " sum(dv.stationservicefee) as stationservicefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "          where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%微机费%'),"
							+ "         0)) computefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "                where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id and dd.departdate = dv.departdate"
							+ "          and a.name like '%空调费%'),"
							+ "               0)) coolairfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "               balancedeductitem          a"
							+ "         where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%附加费%'),"
							+ "        0)) additionfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%燃油费%'),"
							+ "     0)) fuelfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%配水费%'),"
							+ "     0)) waterfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%保险费%'),"
							+ "     0)) insurefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and (a.name like '%其他%' or a.name like '%其它%')),"
							+ "     0)) otherfee,"
							+ "         sum(dv.totalamount- dv.fueladditionfee-dv.stationservicefee-dv.othterfee) as basemount,"
							+ "        sum(dv.agentfee) as agentfee,"
							+ " sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,"
							+ " sum(dv.balanceamount) as balanceamount,sum(dv.moreprice) moreprice "
							+ " from departinvoices dv," + " route          r,"
							+ "  schedule       s," + " station        st,"
							+ " vehicle        v," + " unit           u1,"
							+ " unit           u2"
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u1.id"
							+ " and dv.balanceunitid = u2.id"
							+ " and dv.status <> '1'" + " and dv.printorgid in "
							+ orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" group by u2.name order by u2.name )");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		} else if (type == 2) {
			// 按班次分组
			StringBuilder sql = new StringBuilder(
					"select  name,balanceunit,unitname,invoicesnonum,schedulenum,"
							+ "ticketnum,totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,fuelfee,otherfee,insurefee,waterfee,basemount,agentfee,"
							+ "(stationservicefee+computefee+coolairfee+additionfee+fuelfee"
							+ "+otherfee+insurefee+waterfee) subtotal,income,balanceamount,moreprice"
							+ " from (select  st.name||'('||dv.departtime||')' as name,'' as balanceunit,'' as unitname,"
							+ " count(dv.departinvoicesno) as invoicesnonum,"
							+ " count(distinct dv.reportid) as schedulenum,"
							+ " sum(dv.ticketnum) as ticketnum,"
							+ " sum(dv.totalamount) as totalamount,     "
							+ " sum(dv.stationservicefee) as stationservicefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "          where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%微机费%'),"
							+ "         0)) computefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "                where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id "
							+ "           and a.name like '%空调费%'),"
							+ "               0)) coolairfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "               balancedeductitem          a"
							+ "         where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%附加费%'),"
							+ "        0)) additionfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%燃油费%'),"
							+ "     0)) fuelfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%配水费%'),"
							+ "     0)) waterfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%保险费%'),"
							+ "     0)) insurefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and (a.name like '%其他%' or a.name like '%其它%')),"
							+ "     0)) otherfee,"
							+ "         sum(dv.totalamount- dv.fueladditionfee-dv.stationservicefee-dv.othterfee) as basemount,"
							+ "        sum(dv.agentfee) as agentfee,"
							+ " sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,"
							+ " sum(dv.balanceamount) as balanceamount,sum(dv.moreprice) moreprice "
							+ " from departinvoices dv," + " route          r,"
							+ "  schedule       s," + " station        st,"
							+ " vehicle        v," + " unit           u1,"
							+ " unit           u2"
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u2.id"
							+ " and dv.balanceunitid = u1.id"
							+ " and dv.status <> '1'" + " and dv.printorgid in "
							+ orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" group by st.name,dv.departtime order by st.name,dv.departtime )");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		} else if (type == 3) {
			// 按车牌
			StringBuilder sql = new StringBuilder(
					"select  name,balanceunit,unitname,invoicesnonum,schedulenum,"
							+ "ticketnum,totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,fuelfee,otherfee,insurefee,waterfee,basemount,agentfee,"
							+ "(stationservicefee+computefee+coolairfee+additionfee+fuelfee"
							+ "+otherfee+insurefee+waterfee) subtotal,income,balanceamount,moreprice"
							+ " from (select  v.vehicleno as name,u1.name balanceunit,u2.name unitname,"
							+ " count(dv.departinvoicesno) as invoicesnonum,"
							+ " count(distinct dv.reportid) as schedulenum,"
							+ " sum(dv.ticketnum) as ticketnum,"
							+ " sum(dv.totalamount) as totalamount,     "
							+ " sum(dv.stationservicefee) as stationservicefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "          where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%微机费%'),"
							+ "         0)) computefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "                where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "          and a.name like '%空调费%'),"
							+ "               0)) coolairfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "               balancedeductitem          a"
							+ "         where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%附加费%'),"
							+ "        0)) additionfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%燃油费%'),"
							+ "     0)) fuelfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%配水费%'),"
							+ "     0)) waterfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%保险费%'),"
							+ "     0)) insurefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and (a.name like '%其他%' or a.name like '%其它%')),"
							+ "     0)) otherfee,"
							+ "         sum(dv.totalamount- dv.fueladditionfee-dv.stationservicefee-dv.othterfee) as basemount,"
							+ "        sum(dv.agentfee) as agentfee,"
							+ " sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,"
							+ " sum(dv.balanceamount) as balanceamount,sum(dv.moreprice) moreprice "
							+ " from departinvoices dv," + " route          r,"
							+ "  schedule       s," + " station        st,"
							+ " vehicle        v," + " unit           u1,"
							+ " unit           u2"
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u2.id"
							+ " and dv.balanceunitid = u1.id"
							+ " and dv.status <> '1'" + " and dv.printorgid in "
							+ orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" group by v.vehicleno,u1.name,u2.name order by v.vehicleno )");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		} else {
			// 按线路
			StringBuilder sql = new StringBuilder(
					"select  name,balanceunit,unitname,invoicesnonum,schedulenum,"
							+ "ticketnum,totalamount,stationservicefee,computefee,coolairfee,"
							+ "additionfee,fuelfee,otherfee,insurefee,waterfee,basemount,agentfee,"
							+ "(stationservicefee+computefee+coolairfee+additionfee+fuelfee"
							+ "+otherfee+insurefee+waterfee) subtotal,income,balanceamount,moreprice"
							+ " from ( select  st.name,'' as balanceunit,'' as unitname,"
							+ " count(dv.departinvoicesno) as invoicesnonum,"
							+ " count(distinct dv.reportid) as schedulenum,"
							+ " sum(dv.ticketnum) as ticketnum,"
							+ " sum(dv.totalamount) as totalamount,     "
							+ " sum(dv.stationservicefee) as stationservicefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "          where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%微机费%'),"
							+ "         0)) computefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "           from departinvoicesdeductdetail dd,"
							+ "                balancedeductitem          a"
							+ "                where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "          and a.name like '%空调费%'),"
							+ "               0)) coolairfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "               balancedeductitem          a"
							+ "         where dd.departinvoicesid = dv.id and dd.status<>'1'"
							+ "           and dd.balanceitemid = a.id  and dd.departdate = dv.departdate"
							+ "           and a.name like '%附加费%'),"
							+ "        0)) additionfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%燃油费%'),"
							+ "     0)) fuelfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%配水费%'),"
							+ "     0)) waterfee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and a.name like '%保险费%'),"
							+ "     0)) insurefee,"
							+ " sum(nvl((select sum(dd.deductmoney)"
							+ "          from departinvoicesdeductdetail dd,"
							+ "              balancedeductitem          a"
							+ "       where dd.departinvoicesid = dv.id"
							+ "        and dd.balanceitemid = a.id"
							+ "        and dd.status<>'1'"
							+ "        and (a.name like '%其他%' or a.name like '%其它%')),"
							+ "     0)) otherfee,"
							+ "         sum(dv.totalamount- dv.fueladditionfee-dv.stationservicefee-dv.othterfee) as basemount,"
							+ "        sum(dv.agentfee) as agentfee,"
							+ " sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,"
							+ " sum(dv.balanceamount) as balanceamount,sum(dv.moreprice) moreprice "
							+ " from departinvoices dv," + " route          r,"
							+ "  schedule       s," + " station        st,"
							+ " vehicle        v," + " unit           u1,"
							+ " unit           u2"
							+ " where dv.scheduleid = s.id"
							+ " and s.routeid = r.id"
							+ " and r.endstationid = st.id"
							+ " and dv.vehicleid = v.id"
							+ " and v.unitid = u2.id"
							+ " and dv.balanceunitid = u1.id"
							+ " and dv.status <> '1'" + " and dv.printorgid in "
							+ orgids);
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" group by st.name order by st.name )");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		}
	}

	/**
	 * 客运站结算汇总表
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryStationBalanceInvoinces(Reportparam rp) {

		if (rp.getBalancetype() == 0) {
			// 按车属单位
			StringBuilder sql = new StringBuilder(
					"select '' as endstation ,name,'' vehicleno,sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (sum(price)-sum(stationservicefee)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append(" 	sum(ticketsellnum) ticketsellnum,sum(allprice) allprice ")
					.append("  ,trim('微机单') balancetype from (")
					.append("      select u.name,0 invoincenum,0 schnum,count(ts.id) ticketnum,sum(ts.price) price,")
					.append("             sum(ts.moreprice) moreprice,sum(ts.price - ts.moreprice) balanceprice,")
					.append("             0 as  stationservicefee,0 as fueladditionfee,")
					.append("             sum(ts.computefee) computefee,sum(ts.coolairfee) coolairfee,sum(ts.additionfee) additionfee,")
					.append("             sum(ts.waterfee) waterfee,sum(ts.insurefee) insurefee,sum(ts.otherfee) otherfee,")
					.append("             sum((select (dd.balanceamount / dd.ticketnum)")
					.append("                     from departinvoicesdetail dd")
					.append("                   where ts.departinvoicesid = dd.departinvoicesid and dd.fromstationid = ts.departstationid")
					.append("                     and dd.reachstationid = ts.reachstationid and dd.tickettype = ts.tickettype")
					.append("                     and dd.price = (ts.price - ts.moreprice))) balanceamount,")
					.append("             sum(ts.distance) peopledistance,0 seats,0 allpeopledistance ,0 ticketsellnum,0 allprice, ")
					.append("             0 agentfee")
					.append("         from ticketsell ts, schedule s, departinvoices d, vehicle v, unit u,unit u2")
					.append("       where ts.isdepartinvoices = 1 and v.unitid = u.id and ts.scheduleid = s.id")
					.append("         and d.vehicleid = v.id and ts.departinvoicesid = d.id and d.balanceunitid=u2.id")
					.append("         and d.departdate between :startdate and :enddate   ")
					.append("         and ts.orgid in " + rp.getSaleorgids())
					.append("         and s.workways in " + rp.getWorkways())
					.append("         and s.orgid in " + rp.getOrgids())
					.append("         and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//				sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("       group by u.name")
					.append("       union all")
					.append("       select u.name,count(d.id) as invoincenum,count(distinct reportid) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,sum(stationservicefee) stationservicefee,")
					.append("              sum(fueladditionfee) fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,0 ticketsellnum,0 allprice,  ")
					.append("            sum(d.agentfee) agentfee ") 
					.append("          from departinvoices d, schedule s, vehicle v, unit u,unit u2")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids())
					.append("         and s.workways in " + rp.getWorkways())
					.append("          and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//				sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by u.name")
					.append("        union all")
					.append("        select u.name,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				0 seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,0 ticketsellnum,0 allprice, ")
					.append("             0 agentfee")
					.append("            from vehiclereport vr,scheduleplan  sp,")
					.append("                 (select d.reportid, d.balanceunitid from departinvoices d")
					.append("                    where d.status <> '1' group by d.reportid, d.balanceunitid) d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2")
					.append("         where vr.scheduleplanid = sp.id and sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and vr.reportorgid = sp.orgid and vr.vehicleid = v.id")
					.append("           and d.reportid=vr.id and d.balanceunitid=u2.id and vr.isactive = 1 and s.orgid in "
							+ rp.getOrgids())
					.append("         and s.workways in " + rp.getWorkways())
					.append("           and vr.isdeparted = 1 and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
	//			if (rp.getScheduleid() > 0) {
	//			sql.append(" and s.id=" + rp.getScheduleid());
	//		}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by u.name union all ");

			sql.append(
					" select u.name,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,0 balanceprice, ")
					.append(" 0 stationservicefee,0 fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee, ")
					.append(" 0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,sum(case sp.islinework when 0 then ")
					.append(" (sp.seatnum - sp.fixedreserveseatnum) else sp.seatnum end) seats,sum((case sp.islinework ")
					.append(" when 0 then (sp.seatnum - sp.fixedreserveseatnum) else v.seatnum end) * r.distance) allpeopledistance, ")
					.append(" 0 ticketsellnum,0 allprice,")
					.append("             0 agentfee")
					.append(" from vehiclereport vr, scheduleplan sp,(select d.reportid, d.balanceunitid ")
					.append(" from departinvoices d where d.status <> '1'  group by d.reportid, d.balanceunitid) d, vehicle v, ")
					.append(" unit u,schedule s,route r,unit u2 where vr.scheduleplanid = sp.id and sp.scheduleid = s.id ")
					.append(" and v.unitid = u.id and s.routeid = r.id and vr.reportorgid = sp.orgid and vr.vehicleid = v.id ")
					.append(" and d.reportid = vr.id and d.balanceunitid = u2.id and vr.isactive = 1 ")
					.append(" and s.orgid in " + rp.getOrgids()
							+ " and s.workways in " + rp.getWorkways()
							+ " and vr.isdeparted = 1 ")
					.append(" and sp.departdate between :startdate and :enddate  ");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(
					" group by u.name union all  select vp.name, 0 invoincenum, 0 schnum, 0 ticketnum, 0 price, 0 moreprice, ")
					.append(" 0 balanceprice, 0 stationservicefee, 0 fueladditionfee, 0 computefee, 0 coolairfee, 0 additionfee, ")
					.append(" 0 waterfee, 0 insurefee, 0 otherfee, 0 balanceamount, 0 peopledistance, 0 seats, 0 allpeopledistance, ")
					.append(" sum(ticketsellnum) ticketsellnum, sum(ts.allprice) allprice,")
					.append("             0 agentfee")
					.append(" from (select ts.scheduleplanid, count(ts.id) ticketsellnum, ")
					.append(" sum(ts.price) allprice from ticketsell ts, schedule s where ts.scheduleid = s.id ")
					.append(" and ts.departdate between :startdate and :enddate  ")
					.append(" and ts.orgid in " + rp.getSaleorgids()
							+ " and ts.ticketstatus =0 and s.workways in "
							+ rp.getWorkways() + " and s.orgid in "
							+ rp.getOrgids() + "");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			sql.append(
					" group by ts.scheduleplanid) ts , (select vp.scheduleplanid, u.name from vehiclereport  vp, ")
					.append(" unit u,vehicle v,unit u2,route r,schedule s,departinvoices d  where vp.vehicleid = v.id ")
					.append(" and vp.scheduleid = s.id  and s.routeid = r.id and v.unitid = u.id and d.scheduleplanid = vp.scheduleplanid ")
					.append(" and d.balanceunitid = u2.id and u.id = v.unitid and vp.departdate between :startdate and :enddate and u.id = v.unitid  ");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" and s.islinework=0");//先查询非流水班的已售数
			sql.append("  and vp.isactive = 1 group by vp.scheduleplanid, u.name) vp where ts.scheduleplanid = vp.scheduleplanid ");
			sql.append(" group by name  ");
			sql.append(" union all  select ts.name, 0 invoincenum, 0 schnum, 0 ticketnum, 0 price, 0 moreprice, ")
					.append(" 0 balanceprice, 0 stationservicefee, 0 fueladditionfee, 0 computefee, 0 coolairfee, 0 additionfee, ")
					.append(" 0 waterfee, 0 insurefee, 0 otherfee, 0 balanceamount, 0 peopledistance, 0 seats, 0 allpeopledistance, ")
					.append(" sum(ticketsellnum) ticketsellnum, sum(ts.allprice) allprice,")
					.append("             0 agentfee")
					.append(" from (select  count(ts.id) ticketsellnum,sum(ts.price) allprice,u.name")
					.append(" from  ticketsell ts left join  schedule s on ts.scheduleid = s.id left join vehiclereport vp on ts.vehiclereportid=vp.id ")
					.append(" left join  departinvoices d on ts.departinvoicesid=d.id left join  vehicle v on vp.vehicleid=v.id ")
					.append(" left join unit  u on v.unitid = u.id left join unit  u2 on d.balanceunitid = u2.id")
					.append(" left join route r on s.routeid = r.id where s.islinework=1 and vp.isactive = 1 and d.departdate between :startdate and :enddate ")
					.append(" and ts.orgid in " + rp.getSaleorgids()
					+ " and ts.ticketstatus =0 and s.workways in "
					+ rp.getWorkways() + " and s.orgid in "
					+ rp.getOrgids() + "");
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by  u.name) ts ");
			sql.append(" group by name )  group by name");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();

		} else if (rp.getBalancetype() == 1) {
			// 按结算单位
			StringBuilder sql = new StringBuilder(
					"select '' as endstation ,name,'' vehicleno,sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (sum(price)-sum(stationservicefee)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")//sum(TRUNC(balanceamount,2)) balanceamount,
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append(" sum(ticketsellnum) ticketsellnum,sum(allprice) allprice  ")
					.append("  ,trim('微机单') balancetype from (")
					.append("      select u2.name,0 invoincenum,0 schnum,count(ts.id) ticketnum,sum(ts.price) price,")
					.append("             sum(ts.moreprice) moreprice,sum(ts.price - ts.moreprice) balanceprice,")
					.append("             0 as stationservicefee,0 as fueladditionfee,")
					.append("             sum(ts.computefee) computefee,sum(ts.coolairfee) coolairfee,sum(ts.additionfee) additionfee,")
					.append("             sum(ts.waterfee) waterfee,sum(ts.insurefee) insurefee,sum(ts.otherfee) otherfee,")
					.append("             sum((select (dd.balanceamount / dd.ticketnum)")
					.append("                     from departinvoicesdetail dd")
					.append("                   where ts.departinvoicesid = dd.departinvoicesid and dd.fromstationid = ts.departstationid")
					.append("                     and dd.reachstationid = ts.reachstationid and dd.tickettype = ts.tickettype")
					.append("                     and dd.price = (ts.price - ts.moreprice))) balanceamount,")
					.append("             sum(ts.distance) peopledistance,0 seats,0 allpeopledistance,0 ticketsellnum,0 allprice, ")
					.append("             0 agentfee")
					.append("         from ticketsell ts, schedule s, departinvoices d, vehicle v, unit u,unit u2 ")
					.append("       where ts.isdepartinvoices = 1 and v.unitid = u.id and ts.scheduleid = s.id")
					.append("         and d.vehicleid = v.id and ts.departinvoicesid = d.id and d.balanceunitid=u2.id")
					.append("         and d.departdate between :startdate and :enddate   ")
					.append("         and ts.orgid in "+rp.getSaleorgids())
					.append("         and s.orgid in " + rp.getOrgids())
					.append("         and s.workways in "+rp.getWorkways())
					.append("         and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getScheduleid() > 0) {
				sql.append(" and s.id=" + rp.getScheduleid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("       group by u2.name")
					.append("       union all")
					.append("       select u2.name,count(d.id) as invoincenum,count(distinct reportid) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,sum(d.stationservicefee) stationservicefee,")
					.append("              sum(d.fueladditionfee) fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,0 ticketsellnum,0 allprice,  ")
					.append("             sum(d.agentfee) agentfee ")
					.append("          from departinvoices d, schedule s, vehicle v, unit u,unit u2")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("          and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by u2.name")
					.append("        union all")
					.append("        select u2.name,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				sum(case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else  v.seatnum end) seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,0 ticketsellnum,0 allprice , ")
					.append("             0 agentfee")
					.append("            from vehiclereport vr,scheduleplan  sp,")
					.append("                 (select d.reportid, d.balanceunitid from departinvoices d")
					.append("                    where d.status <> '1' group by d.reportid, d.balanceunitid) d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2")
					.append("         where vr.scheduleplanid = sp.id and sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and vr.reportorgid = sp.orgid and vr.vehicleid = v.id")
					.append("           and d.reportid=vr.id and d.balanceunitid=u2.id and vr.isactive = 1 and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("           and vr.isdeparted = 1 and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by u2.name union all  select vp.name, 0 invoincenum, 0 schnum, 0 ticketnum, 0 price, 0 moreprice, ")
					.append(" 0 balanceprice, 0 stationservicefee, 0 fueladditionfee, 0 computefee, 0 coolairfee, 0 additionfee, ")
					.append(" 0 waterfee, 0 insurefee, 0 otherfee, 0 balanceamount, 0 peopledistance, 0 seats, 0 allpeopledistance, ")
					.append(" sum(ticketsellnum) ticketsellnum, sum(ts.allprice) allprice,")
					.append(" 0 agentfee")
					.append(" from (select ts.scheduleplanid, count(ts.id) ticketsellnum, ")
					.append(" sum(ts.price) allprice") 
					.append(" from ticketsell ts, schedule s where ts.scheduleid = s.id ")
					.append(" and ts.departdate between :startdate and :enddate  ")
					.append(" and ts.orgid in " + rp.getSaleorgids()
							+ " and ts.ticketstatus =0 and s.workways in "
							+ rp.getWorkways() + " and s.orgid in "
							+ rp.getOrgids() + "");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			sql.append(
					" group by ts.scheduleplanid) ts , (select vp.scheduleplanid, u2.name from vehiclereport  vp, ")
					.append(" unit u,vehicle v,unit u2,route r,schedule s,departinvoices d  where vp.vehicleid = v.id ")
					.append(" and vp.scheduleid = s.id  and s.routeid = r.id and v.unitid = u.id and d.scheduleplanid = vp.scheduleplanid ")
					.append(" and d.balanceunitid = u2.id and u.id = v.unitid and vp.departdate between :startdate and :enddate and u.id = v.unitid  ");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" and s.islinework=0 ");
			sql.append("  and vp.isactive = 1 group by vp.scheduleplanid, u2.name) vp where ts.scheduleplanid = vp.scheduleplanid ");
			sql.append(" group by name ");
			sql.append(" union all  select ts.name, 0 invoincenum, 0 schnum, 0 ticketnum, 0 price, 0 moreprice, ")
			.append(" 0 balanceprice, 0 stationservicefee, 0 fueladditionfee, 0 computefee, 0 coolairfee, 0 additionfee, ")
			.append(" 0 waterfee, 0 insurefee, 0 otherfee, 0 balanceamount, 0 peopledistance, 0 seats, 0 allpeopledistance, ")
			.append(" sum(ticketsellnum) ticketsellnum, sum(ts.allprice) allprice,")
			.append("             0 agentfee")
			.append(" from (select  count(ts.id) ticketsellnum,sum(ts.price) allprice,u2.name")
			.append(" from  ticketsell ts left join  schedule s on ts.scheduleid = s.id left join vehiclereport vp on ts.vehiclereportid=vp.id ")
			.append(" left join  departinvoices d on ts.departinvoicesid=d.id left join  vehicle v on vp.vehicleid=v.id ")
			.append(" left join unit  u on v.unitid = u.id left join unit  u2 on d.balanceunitid = u2.id")
			.append(" left join route r on s.routeid = r.id where s.islinework=1 and vp.isactive = 1 and d.departdate between :startdate and :enddate ")
			.append(" and ts.orgid in " + rp.getSaleorgids()
					+ " and ts.ticketstatus =0 and s.workways in "
					+ rp.getWorkways() + " and s.orgid in "
					+ rp.getOrgids() + "");
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by  u2.name) ts ");
			sql.append(" group by name )  group by name");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();

		} else if (rp.getBalancetype() == 2) {
			// 按班次分组
			StringBuilder sql = new StringBuilder(
					"select '' as endstation ,name,'' vehicleno,sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (sum(price)-sum(stationservicefee)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")//sum(TRUNC(balanceamount,2)) balanceamount,
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee)) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append("    sum(ticketsellnum),sum(allprice)  ")
					.append("  ,trim('微机单') balancetype from (")
					.append("      select s.code as name,0 invoincenum,0 schnum,count(ts.id) ticketnum,sum(ts.price) price,")
					.append("             sum(ts.moreprice) moreprice,sum(ts.price - ts.moreprice) balanceprice,")
					.append("             0 as stationservicefee,0 as fueladditionfee,")
					.append("             sum(ts.computefee) computefee,sum(ts.coolairfee) coolairfee,sum(ts.additionfee) additionfee,")
					.append("             sum(ts.waterfee) waterfee,sum(ts.insurefee) insurefee,sum(ts.otherfee) otherfee,")
					.append("             sum((select (dd.balanceamount / dd.ticketnum)")
					.append("                     from departinvoicesdetail dd")
					.append("                   where ts.departinvoicesid = dd.departinvoicesid and dd.fromstationid = ts.departstationid")
					.append("                     and dd.reachstationid = ts.reachstationid and dd.tickettype = ts.tickettype")
					.append("                     and dd.price = (ts.price - ts.moreprice))) balanceamount,")
					.append("             sum(ts.distance) peopledistance,0 seats,0 allpeopledistance,0 ticketsellnum,0 allprice,  ")
				    .append("             0 agentfee")
					.append("         from ticketsell ts, schedule s, departinvoices d, vehicle v, unit u,unit u2")
					.append("       where ts.isdepartinvoices = 1 and v.unitid = u.id and ts.scheduleid = s.id")
					.append("         and d.vehicleid = v.id and ts.departinvoicesid = d.id and d.balanceunitid=u2.id")
					.append("         and d.departdate between :startdate and :enddate   ")
					.append("         and ts.orgid in "+rp.getSaleorgids())
					.append("         and s.workways in "+rp.getWorkways())
					.append("         and s.orgid in " + rp.getOrgids())
					.append("         and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}					
			sql.append("       group by s.code")
					.append("       union all")
					.append("       select s.code as name,count(d.id) as invoincenum,count(distinct reportid) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,sum(d.stationservicefee) stationservicefee,")
					.append("              sum(d.fueladditionfee) fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,0 ticketsellnum,0 allprice,  ")
					.append("              sum(agentfee) agentfee")
					.append("          from departinvoices d, schedule s, vehicle v, unit u,unit u2")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("          and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by s.code")
					.append("        union all")
					.append("        select s.code as name,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				sum(case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else  v.seatnum end) seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,0 ticketsellnum,0 allprice,  ")
					.append("             0 agentfee")
					.append("            from vehiclereport vr,scheduleplan  sp,")
					.append("                 (select d.reportid, d.balanceunitid from departinvoices d")
					.append("                    where d.status <> '1' group by d.reportid, d.balanceunitid) d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2")
					.append("         where vr.scheduleplanid = sp.id and sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and vr.reportorgid = sp.orgid and vr.vehicleid = v.id")
					.append("           and d.reportid=vr.id and d.balanceunitid=u2.id and vr.isactive = 1 and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("           and vr.isdeparted = 1 and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by s.code union all  select sd.code as name, 0 invoincenum, 0 schnum, 0 ticketnum, 0 price, 0 moreprice, ")
					.append(" 0 balanceprice, 0 stationservicefee, 0 fueladditionfee, 0 computefee, 0 coolairfee, 0 additionfee, ")
					.append(" 0 waterfee, 0 insurefee, 0 otherfee, 0 balanceamount, 0 peopledistance, 0 seats, 0 allpeopledistance, ")
					.append(" sum(ticketsellnum) ticketsellnum, sum(ts.allprice) allprice,")
					.append("             0 agentfee")
					.append(" from (select ts.scheduleplanid, count(ts.id) ticketsellnum, ")
					.append(" sum(ts.price) allprice")
					.append(" from ticketsell ts, schedule s where ts.scheduleid = s.id ")
					.append(" and ts.departdate between :startdate and :enddate  ")
					.append(" and ts.orgid in " + rp.getSaleorgids()
							+ " and ts.ticketstatus =0 and s.workways in "
							+ rp.getWorkways() + " and s.orgid in "
							+ rp.getOrgids() + "");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			sql.append(
					" group by ts.scheduleplanid) ts , (select vp.scheduleplanid,s.id code from vehiclereport  vp, ")
					.append(" unit u,vehicle v,unit u2,route r,schedule s,departinvoices d  where vp.vehicleid = v.id ")
					.append(" and vp.scheduleid = s.id  and s.routeid = r.id and v.unitid = u.id and d.scheduleplanid = vp.scheduleplanid ")
					.append(" and d.balanceunitid = u2.id and u.id = v.unitid and vp.departdate between :startdate and :enddate and u.id = v.unitid  ");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("  and vp.isactive = 1 group by vp.scheduleplanid,s.id) vp,schedule sd where ts.scheduleplanid = vp.scheduleplanid and vp.code = sd.id ");
			sql.append(" group by sd.code )  group by name");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();
		} else if (rp.getBalancetype() == 3) {
			// 按车牌
			StringBuilder sql = new StringBuilder(
					"select decode(grouping(stationname), 1, '合计', stationname) endstation,decode(grouping(stationname) + grouping(balancename),")
					.append(" 1,'',balancename) balancename,decode(grouping(vehicleno) + grouping(stationname),1,'小计',vehicleno) vehicleno,")
				    .append(" sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (sum(price)-sum(stationservicefee)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")// sum(TRUNC(balanceamount,2)) balanceamount,
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append("     sum(ticketsellnum) ticketsellnum,sum(allprice) allprice  ")
					.append("  ,trim('微机单') balancetype from (")
					.append(" select stationname,max(balancename) balancename,max(vehicleno) vehicleno,sum(invoincenum) invoincenum, ")
		            .append(" sum(schnum)schnum,sum(ticketnum) ticketnum,SUM(price) price,sum(moreprice)moreprice,sum(balanceprice)balanceprice, ")
		            .append(" sum(stationservicefee)stationservicefee,sum(fueladditionfee)fueladditionfee,sum(computefee)computefee, ")
		            .append(" sum(coolairfee)coolairfee,sum(additionfee)additionfee,sum(waterfee)waterfee,sum(insurefee)insurefee, ")
		            .append(" sum(otherfee)otherfee,sum(balanceamount)balanceamount,sum(peopledistance)peopledistance, ")
		            .append(" sum(seats)seats,sum(allpeopledistance)allpeopledistance,sum(ticketsellnum) ticketsellnum,sum(allprice) allprice, ")
		            .append(" sum(agentfee) agentfee")
		            .append(" from ( ")
					.append("      select s2.name as stationname,u2.name as balancename,v.vehicleno, 0 invoincenum,0 schnum,count(ts.id) ticketnum,sum(ts.price) price,")
					.append("             sum(ts.moreprice) moreprice,sum(ts.price - ts.moreprice) balanceprice,")
					.append("             0 as stationservicefee,0 as fueladditionfee,")
					.append("             sum(ts.computefee) computefee,sum(ts.coolairfee) coolairfee,sum(ts.additionfee) additionfee,")
					.append("             sum(ts.waterfee) waterfee,sum(ts.insurefee) insurefee,sum(ts.otherfee) otherfee,")
					.append("             sum((select (dd.balanceamount / dd.ticketnum)")
					.append("                     from departinvoicesdetail dd")
					.append("                   where ts.departinvoicesid = dd.departinvoicesid and dd.fromstationid = ts.departstationid")
					.append("                     and dd.reachstationid = ts.reachstationid and dd.tickettype = ts.tickettype")
					.append("                     and dd.price = (ts.price - ts.moreprice))) balanceamount,")
					.append("             sum(ts.distance) peopledistance,0 seats,0 allpeopledistance,0 ticketsellnum,0 allprice, ")
					.append("             0 agentfee")
					.append("         from ticketsell ts, schedule s, departinvoices d, vehicle v, unit u,unit u2,route r,station s2")
					.append("       where ts.isdepartinvoices = 1 and v.unitid = u.id and ts.scheduleid = s.id and s.routeid=r.id")
					.append("         and d.vehicleid = v.id and ts.departinvoicesid = d.id and d.balanceunitid=u2.id")
					.append("         and d.departdate between :startdate and :enddate and r.endstationid = s2.id  ")
					.append("         and ts.orgid in "+rp.getSaleorgids())
					.append("         and s.workways in "+rp.getWorkways())
					.append("         and s.orgid in " + rp.getOrgids())
					.append("         and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("       group by s2.name, u2.name, v.vehicleno")
					.append("       union all")
					.append("       select s2.name as stationname,u2.name as balancename,v.vehicleno,count(d.id) as invoincenum,count(distinct reportid) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,sum(d.stationservicefee) stationservicefee,")
					.append("              sum(d.fueladditionfee) fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,0 ticketsellnum,0 allprice,")
					.append("            sum(agentfee) agentfee")
					.append("          from departinvoices d, schedule s, vehicle v, unit u,unit u2,route r,station        s2")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id and r.endstationid = s2.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and s.routeid=r.id and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("          and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by s2.name, u2.name, v.vehicleno")
					.append("        union all")
					.append("        select s2.name as stationname,u2.name as balancename,v.vehicleno,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				sum(case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else  v.seatnum end) seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,0 ticketsellnum,0 allprice,")
					.append("             0 agentfee")
					.append("            from vehiclereport vr,scheduleplan  sp,")
					.append("                 (select d.reportid, d.balanceunitid from departinvoices d")
					.append("                    where d.status <> '1' group by d.reportid, d.balanceunitid) d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2 ,station s2")
					.append("         where vr.scheduleplanid = sp.id and sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and vr.reportorgid = sp.orgid and vr.vehicleid = v.id and r.endstationid = s2.id")
					.append("           and d.reportid=vr.id and d.balanceunitid=u2.id and vr.isactive = 1 and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("           and vr.isdeparted = 1 and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by s2.name, u2.name, v.vehicleno ")
			
			.append(" union all select s2.name stationname,balancename as balancename,vp.vehicleno,0 invoincenum, ")
            .append(" 0 schnum,0 ticketnum,0 price,0 moreprice,0 balanceprice, 0 stationservicefee,0 fueladditionfee, ")
            .append(" 0 computefee,0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,0 balanceamount, ")
            .append(" 0 peopledistance,0 seats,0 allpeopledistance,sum(ts.id) ticketsellnum,sum(allprice) allprice, ")
            .append("             0 agentfee")
            .append(" from(select ts.scheduleplanid,count(ts.id) id,sum(ts.price) allprice from ticketsell ts, schedule s ")
            .append(" where ts.scheduleid = s.id and ts.departdate between :startdate and :enddate ")
            .append(" and ts.orgid in "+rp.getSaleorgids()+" and ts.ticketstatus = 0 and s.workways in "+rp.getWorkways()+" and s.orgid in "+rp.getSaleorgids() )
            .append(" group by ts.scheduleplanid) ts,(select vp.scheduleplanid,v.vehicleno,u2.name as balancename, ")
            .append(" r.id routeid from vehiclereport  vp,unit u,vehicle v,unit u2,route r,schedule s,departinvoices d where vp.vehicleid = v.id ")
	        .append(" and vp.scheduleid = s.id and s.routeid = r.id and v.unitid = u.id and d.scheduleplanid = vp.scheduleplanid and d.balanceunitid = u2.id ")
	        .append(" and vp.departdate between :startdate and :enddate  and s.islinework=0  ")
	        .append(" and vp.isactive = 1 group by vp.scheduleplanid, u2.name, v.vehicleno, r.id) vp,route ro,station s2 where ts.scheduleplanid = vp.scheduleplanid ")
			.append(" and vp.routeid = ro.id and ro.endstationid = s2.id "); 
            if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}

			sql.append(" group by s2.name, vp.balancename, vp.vehicleno  ");
			
			sql.append(" union all select  stationname,balancename as balancename,ts.vehicleno,0 invoincenum, ")
            .append(" 0 schnum,0 ticketnum,0 price,0 moreprice,0 balanceprice, 0 stationservicefee,0 fueladditionfee, ")
            .append(" 0 computefee,0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,0 balanceamount, ")
            .append(" 0 peopledistance,0 seats,0 allpeopledistance,sum(ts.id) ticketsellnum,sum(allprice) allprice, ")
            .append("             0 agentfee")
            .append(" from(select ts.scheduleplanid,count(ts.id) id,sum(ts.price) allprice,v.vehicleno,u2.name as balancename,st.name as stationname ")
            .append(" from ticketsell ts left join  schedule s on ts.scheduleid = s.id left join vehiclereport vp on ts.vehiclereportid=vp.id ")
            .append(" left join  departinvoices d on ts.departinvoicesid=d.id left join  vehicle v on vp.vehicleid=v.id ")
            .append(" left join unit  u on v.unitid = u.id left join unit  u2 on d.balanceunitid = u2.id")
            .append(" left join route r on s.routeid = r.id left join station st on r.endstationid =st.id")
            .append(" where  ts.departdate between :startdate and :enddate and s.islinework=1  and vp.isactive = 1")
            .append(" and ts.orgid in "+rp.getSaleorgids()+" and ts.ticketstatus = 0 and s.workways in "+rp.getWorkways()+" and s.orgid in "+rp.getSaleorgids() );
            
            if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by ts.scheduleplanid,st.name,u2.name, v.vehicleno) ts group by stationname, balancename, vehicleno) group by stationname, balancename, vehicleno ");
					sql.append(") where ticketnum>0  group by rollup(stationname, balancename, vehicleno) order by stationname, balancename, vehicleno");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();

		} else {
			
			// 按线路
			StringBuilder sql = new StringBuilder(
					"select '' as endstation ,name,'' vehicleno,sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (sum(price)-sum(stationservicefee)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")//sum(TRUNC(balanceamount,2)) balanceamount,
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append("        sum(ticketsellnum) ticketsellnum,sum(allprice) allprice ")
					.append("  ,trim('微机单') balancetype from (")
					.append("      select r.name, 0 invoincenum,0 schnum,count(ts.id) ticketnum,sum(ts.price) price,")
					.append("             sum(ts.moreprice) moreprice,sum(ts.price - ts.moreprice) balanceprice,")
					.append("             0 as stationservicefee,0 as fueladditionfee,")
					.append("             sum(ts.computefee) computefee,sum(ts.coolairfee) coolairfee,sum(ts.additionfee) additionfee,")
					.append("             sum(ts.waterfee) waterfee,sum(ts.insurefee) insurefee,sum(ts.otherfee) otherfee,")
					.append("             sum((select (dd.balanceamount / dd.ticketnum)")
					.append("                     from departinvoicesdetail dd")
					.append("                   where ts.departinvoicesid = dd.departinvoicesid and dd.fromstationid = ts.departstationid")
					.append("                     and dd.reachstationid = ts.reachstationid and dd.tickettype = ts.tickettype")
					.append("                     and dd.price = (ts.price - ts.moreprice))) balanceamount,")
					.append("             sum(ts.distance) peopledistance,0 seats,0 allpeopledistance,0 ticketsellnum,0 allprice,")
					.append("             0 agentfee")
					.append("         from ticketsell ts, schedule s, departinvoices d, vehicle v, unit u,unit u2,route r")
					.append("       where ts.isdepartinvoices = 1 and v.unitid = u.id and ts.scheduleid = s.id and s.routeid=r.id")
					.append("         and d.vehicleid = v.id and ts.departinvoicesid = d.id and d.balanceunitid=u2.id")
					.append("         and d.departdate between :startdate and :enddate  ")
					.append("         and ts.orgid in "+rp.getSaleorgids())
					.append("         and s.workways in "+rp.getWorkways())
					.append("         and s.orgid in " + rp.getOrgids())
					.append("         and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("       group by r.name")
					.append("       union all")
					.append("       select r.name,count(d.id) as invoincenum,count(distinct reportid) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,sum(d.stationservicefee) stationservicefee,")
					.append("              sum(d.fueladditionfee) fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,0 ticketsellnum,0 allprice,")
					.append("             sum(agentfee) agentfee ")
					.append("          from departinvoices d, schedule s, vehicle v, unit u,unit u2,route r")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and s.routeid=r.id and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("          and d.printorgid in "
							+ rp.getPrintorgids());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by r.name")
					.append("        union all")
					.append("        select r.name,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				sum(case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else  v.seatnum end) seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,0 ticketsellnum,0 allprice,")
					.append("             0 agentfee")
					.append("            from vehiclereport vr,scheduleplan  sp,")
					.append("                 (select d.reportid, d.balanceunitid from departinvoices d")
					.append("                    where d.status <> '1' group by d.reportid, d.balanceunitid) d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2")
					.append("         where vr.scheduleplanid = sp.id and sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and vr.reportorgid = sp.orgid and vr.vehicleid = v.id")
					.append("           and d.reportid=vr.id and d.balanceunitid=u2.id and vr.isactive = 1 and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("           and vr.isdeparted = 1 and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by r.name union all  select ro.name, 0 invoincenum, 0 schnum, 0 ticketnum, 0 price, 0 moreprice, ")
					.append(" 0 balanceprice, 0 stationservicefee, 0 fueladditionfee, 0 computefee, 0 coolairfee, 0 additionfee, ")
					.append(" 0 waterfee, 0 insurefee, 0 otherfee, 0 balanceamount, 0 peopledistance, 0 seats, 0 allpeopledistance, ")
					.append(" sum(ticketsellnum) ticketsellnum, sum(ts.allprice) allprice, ")
					.append("    0 agentfee") 
					.append(" from (select ts.scheduleplanid, count(ts.id) ticketsellnum, ")
					.append(" sum(ts.price) allprice")
					.append(" from ticketsell ts, schedule s where ts.scheduleid = s.id ")
					.append(" and ts.departdate between :startdate and :enddate  ")
					.append(" and ts.orgid in " + rp.getSaleorgids()
							+ " and ts.ticketstatus =0 and s.workways in "
							+ rp.getWorkways() + " and s.orgid in "
							+ rp.getOrgids() + "");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			sql.append(
					" group by ts.scheduleplanid) ts , (select vp.scheduleplanid,r.id routeid from vehiclereport  vp, ")
					.append(" unit u,vehicle v,unit u2,route r,schedule s,departinvoices d  where vp.vehicleid = v.id ")
					.append(" and vp.scheduleid = s.id  and s.routeid = r.id and v.unitid = u.id and d.scheduleplanid = vp.scheduleplanid ")
					.append(" and d.balanceunitid = u2.id and u.id = v.unitid and vp.departdate between :startdate and :enddate and u.id = v.unitid  ");
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids() != null && rp.getUnitids().length() > 0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids() != null
					&& rp.getBalanceunitids().length() > 0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("  and vp.isactive = 1 group by vp.scheduleplanid,r.id) vp,route ro where ts.scheduleplanid = vp.scheduleplanid and vp.routeid = ro.id ");
			sql.append(" group by ro.name )  group by name");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();
		}

	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryHandStationBalanceInvoinces(Reportparam rp) {
	
		if (rp.getBalancetype() != 3) {
			String strname="";
			switch (rp.getBalancetype()) {
			case 0:
				strname="u.name";
				break;
			case 1:
				strname="u2.name";
				break;
			case 2:
				strname="s.code";
				break;
			case 4:
				strname="r.name";
				break;
			default:
				break;
			}
			
			StringBuilder sql = new StringBuilder(
					"select '' as endstation ,name,'' vehicleno,sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (trunc(sum(price) - sum(stationservicefee), 2)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append("  sum(ticketnum) ticketsellnum,sum(price) allprice ,trim('手工单') balancetype from ( ")
					.append("      select "+strname+" name,0 invoincenum,0 schnum,sum(distinct d.ticketnum) ticketnum,sum(dd.totalamount) price,")
					.append("             0 moreprice,0 balanceprice,")
					.append("             sum(dd.stationservicefee) stationservicefee,0 fueladditionfee,")
					.append("             0 computefee,0 coolairfee,0 additionfee,")
					.append("             0 waterfee,0 insurefee,sum(dd.othterfee) otherfee,")
					.append("             sum((select sum(decode(dd.ticketnum,0,'0',dd.balanceamount / dd.ticketnum))")
					.append("                     from departinvoicesotherdetail dd")
					.append("                   where dd.departinvoicesotherid = d.id)) balanceamount,")
					.append("             sum(dd.distance) peopledistance,0 seats,0 allpeopledistance,")
					.append("       sum(dd.agentfee) agentfee")
					.append("         from Departinvoicesother d,Departinvoicesotherdetail dd, schedule s,  vehicle v, unit u,unit u2,route r")
					.append("       where  v.unitid = u.id and d.scheduleid = s.id and s.routeid = r.id")
					.append("         and d.vehicleid = v.id and dd.departinvoicesotherid = d.id and d.balanceunitid=u2.id")
					.append("         and d.departdate between :startdate and :enddate")
					.append("         and d.orgid in "+rp.getSaleorgids())
					.append("         and s.workways in "+rp.getWorkways())
					.append("         and s.orgid in " + rp.getOrgids());
					
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("       group by "+strname)
					.append("       union all")
					.append("       select  "+strname+" name,count(d.id) as invoincenum,count(d.id) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,0 stationservicefee,")
					.append("              0 fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,")
						.append("       0 agentfee")
					.append("          from departinvoicesother d, schedule s, vehicle v, unit u,unit u2,route r")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and d.balanceunitid=u2.id and s.routeid = r.id and s.orgid in "
							+ rp.getOrgids())
					.append("         and s.workways in "+rp.getWorkways());	
					
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by "+strname)
					.append("        union all")
					.append("        select "+strname+" name,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				sum(case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else  v.seatnum end) seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,")
					.append("            0 agentfee")
					.append("            from scheduleplan  sp,departinvoicesother d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2")
					.append("         where  sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and d.departdate=sp.departdate and d.scheduleid=sp.scheduleid ")
					.append("           and d.vehicleid=v.id and d.balanceunitid=u2.id  and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("           and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by "+strname+" )  group by name");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();

		} else {
			// 按车牌
			StringBuilder sql = new StringBuilder(
					"select decode(grouping(stationname), 1, '合计', stationname) endstation,decode(grouping(stationname) + grouping(balancename),")
					.append(" 1,'',balancename) balancename,decode(grouping(vehicleno) + grouping(stationname),1,'小计',vehicleno) vehicleno,")
				    .append(" sum(seats) seats,sum(invoincenum) invoincenum,")
					.append("       sum(schnum) schnum,sum(ticketnum),sum(price) totalamount,")
					.append("       (sum(price)-sum(stationservicefee)) balanceamount,")//结算金额修改为票款金额减去站务费
					.append("       sum(price - moreprice) balanceprice,")//sum(TRUNC(balanceamount,2)) balanceamount,
					.append("       sum(moreprice) moreprice,sum(stationservicefee) stationservicefee,")
					.append("       sum(fueladditionfee) fueladditionfee,sum(computefee) computefee,")
					.append("       sum(coolairfee) coolairfee,sum(additionfee) additionfee,sum(waterfee) waterfee,")
					.append("       sum(insurefee) insurefee,sum(otherfee) otherfee,")
					.append("       sum(stationservicefee + fueladditionfee + computefee + coolairfee +")
					.append("           additionfee + waterfee + insurefee + otherfee) totalfee,")
					.append("       sum(peopledistance) peopledistance,sum(allpeopledistance) allpeopledistance,")
					.append("       decode(sum(allpeopledistance),0,'0',to_char(sum(peopledistance) * 100 / sum(allpeopledistance),'990.99')) || '%' rate,");
					if(rp.getAgentcaltype().equals("0")){
						sql.append(" sum(agentfee) laowufee,sum(price-stationservicefee-agentfee) canamount,");
					}else if(rp.getAgentcaltype().equals("1")){
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.1,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.1,2)) canamount ,");
					}else{
						sql.append("  (TRUNC((sum(price)-sum(stationservicefee))*0.08,2)) laowufee,")
						   .append("  (TRUNC((sum(price)-sum(stationservicefee)) - (sum(price)-sum(stationservicefee))*0.08,2)) canamount ,");
					}
					sql.append("  sum(ticketnum) ticketsellnum,sum(price) allprice,trim('手工单') balancetype from ( ")
					.append("      select s2.name as stationname,u2.name as balancename,v.vehicleno, 0 invoincenum,0 schnum,sum(distinct d.ticketnum) ticketnum,sum(dd.totalamount) price,")
					.append("             0 moreprice,0 balanceprice,sum(dd.stationservicefee) stationservicefee,")
					.append("             0 fueladditionfee,")
					.append("             0 computefee,0 coolairfee,0 additionfee,")
					.append("             0 waterfee,0 insurefee,sum(dd.othterfee) otherfee,")
					.append("             sum((select sum(decode(dd.ticketnum,0,'0',dd.balanceamount / dd.ticketnum))")
					.append("                     from departinvoicesotherdetail dd")
					.append("                   where dd.departinvoicesotherid = d.id)) balanceamount,")
					.append("             sum(dd.distance) peopledistance,0 seats,0 allpeopledistance,")
					.append("           sum(dd.agentfee) agentfee")
					.append("         from departinvoicesother d,departinvoicesotherdetail dd, schedule s,vehicle v, unit u,unit u2,route r,station s2")
					.append("       where v.unitid = u.id and d.scheduleid = s.id and d.vehicleid = v.id and dd.departinvoicesotherid = d.id ")
					.append("           and d.balanceunitid=u2.id and  s.routeid=r.id and r.endstationid = s2.id")
					.append("         and d.departdate between :startdate and :enddate ")
					.append("         and d.orgid in "+rp.getSaleorgids())
					.append("         and s.workways in "+rp.getWorkways())
					.append("         and s.orgid in " + rp.getOrgids());
					
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append("       group by s2.name, u2.name, v.vehicleno")
					.append("       union all")
					.append("       select s2.name as stationname,u2.name as balancename,v.vehicleno,count(d.id) as invoincenum,count(d.id) schnum,")
					.append("              0 ticketnum,0 price,0 moreprice,0 balanceprice,0 stationservicefee,")
					.append("              0 fueladditionfee,0 computefee,0 coolairfee,0 additionfee,0 waterfee,")
					.append("              0 insurefee,0 otherfee,0 balanceamount,0 peopledistance,0 seats,")
					.append("              0 allpeopledistance,")
					.append("            0 agentfee")
					.append("          from departinvoicesother d, schedule s, vehicle v, unit u,unit u2,route r,station        s2")
					.append("        where d.status <> '1' and d.vehicleid = v.id and d.scheduleid = s.id and r.endstationid = s2.id")
					.append("          and v.unitid = u.id and d.departdate between :startdate and :enddate")
					.append("          and s.routeid=r.id and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways());
			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}

			sql.append("        group by s2.name, u2.name, v.vehicleno")
					.append("        union all")
					.append("        select s2.name as stationname,u2.name as balancename,v.vehicleno,0 as invoincenum,0 schnum,0 ticketnum,0 price,0 moreprice,")
					.append("               0 balanceprice,0 stationservicefee,0 fueladditionfee,0 computefee,")
					.append("               0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
					.append("               0 balanceamount,0 peopledistance,")
					.append("				sum(case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else  v.seatnum end) seats,")
					.append("               sum((case sp.islinework when 0 then (sp.seatnum - sp.fixedreserveseatnum)")
					.append("                     else v.seatnum end) * r.distance) allpeopledistance,")
					.append("            0 agentfee")
					.append("            from scheduleplan  sp,")
					.append("                 departinvoicesother d,")
					.append(" 				  vehicle v, unit u,schedule s,route r,unit u2 ,station s2")
					.append("         where  sp.scheduleid = s.id and v.unitid = u.id")
					.append("           and s.routeid = r.id and d.departdate=sp.departdate and d.scheduleid=sp.scheduleid and r.endstationid = s2.id ")
					.append("           and d.vehicleid=v.id and d.balanceunitid=u2.id and s.orgid in "
							+ rp.getOrgids()).append("         and s.workways in "+rp.getWorkways())
					.append("           and sp.departdate between :startdate and :enddate");

			if (rp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + rp.getRouteid());
			}
//			if (rp.getScheduleid() > 0) {
//			sql.append(" and s.id=" + rp.getScheduleid());
//			}
			if(rp.getSchedulecode()!=""  && rp.getSchedulecode()!=null){
				sql.append(" and s.code like '%" + rp.getSchedulecode()+"%'" );
			}
			if (rp.getSchtype() > 0) {
				sql.append(" and s.isovertime=" + (rp.getSchtype() - 1));
			}
			if (rp.getUnitids()!=null && rp.getUnitids().length()>0) {
				sql.append(" and u.id in " + rp.getUnitids());
			}
			if (rp.getBalanceunitids()!=null && rp.getBalanceunitids().length()>0) {
				sql.append(" and u2.id in " + rp.getBalanceunitids());
			}
			if (rp.getVehicleid() > 0) {
				sql.append(" and v.id=" + rp.getVehicleid());
			}
			sql.append(" group by s2.name, u2.name, v.vehicleno )  group by rollup(stationname, balancename, vehicleno) order by stationname, balancename, vehicleno");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", rp.getStartdate());
			query.setParameter("enddate", rp.getEnddate());
			return query.getResultList();

		} 

	}

	/**
	 * 长途站预售票查询情况表（跨月汇总）
	 * 
	 * @param month
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPresellMonthRevenue(String orgids, Date month,
			Boolean isSellLocal) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(month);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		Date selltimebegin = calendar.getTime();
		calendar.add(Calendar.MONTH, 1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		Date selltimeend = calendar.getTime();
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.add(Calendar.MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		Date departdatebegin = calendar.getTime();
		calendar.add(Calendar.MONTH, 1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		Date departdateend = calendar.getTime();
		StringBuilder sql = new StringBuilder();
		sql.append(
				"select departname,departdate,sellorgname,sum(sellnum),sum(sellmoney),sum(invoicesmoney),")
				.append("sum(stationservicefee),sum(computefee),sum(coolairfee),sum(additionfee),")
				.append("sum(fueladditionfee),sum(thismonthreturnnum),sum(thismonthreturnmoney),")
				.append("sum(thismonthreturncharges),sum(nextmonthreturnnum),sum(nextmonthreturnmoney),")
				.append("sum(nextmonthreturncharges),sum(checknum),sum(checkmoney) from (")
				.append("select s.name as departname,ts.departdate,org.name as sellorgname,")
				.append("   sum(case ts.ticketstatus when '0' then 1 else 0 end) as sellnum,")
				.append("   sum(case ts.ticketstatus when '0' then ts.price else 0 end) as sellmoney,")
				.append("   sum(case ts.isdepartinvoices when 1 then ts.price else 0 end) as invoicesmoney,")
				.append("	sum(case ts.ticketstatus when '0' then ts.stationservicefee else 0 end) as stationservicefee,")
				.append("	sum(case ts.ticketstatus when '0' then ts.computefee else 0 end) as computefee,")
				.append("	sum(case ts.ticketstatus when '0' then ts.coolairfee else 0 end) as coolairfee,")
				.append("	sum(case ts.ticketstatus when '0' then ts.additionfee else 0 end) as additionfee,")
				.append("   sum(case ts.ticketstatus when '0' then ts.fueladditionfee else 0 end) as fueladditionfee,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime")
				.append(" 		between :selltimebegin and :selltimeend then 1 else 0 end) as thismonthreturnnum,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime")
				.append(" 		between :selltimebegin and :selltimeend then ts.price else 0 end) as thismonthreturnmoney,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime")
				.append(" 		between :selltimebegin and :selltimeend then tr.charges else 0 end) as thismonthreturncharges,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime")
				.append(" 		between :departdatebegin and :departdateend then 1 else 0 end) as nextmonthreturnnum,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime")
				.append(" 		between :departdatebegin and :departdateend then ts.price else 0 end) as nextmonthreturnmoney,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime")
				.append(" 		between :departdatebegin and :departdateend then tr.charges else 0 end) as nextmonthreturncharges,")
				.append("   sum(case ts.ischecked when 1 then 1 else 0 end) as checknum,")
				.append("   sum(case ts.ischecked when 1 then ts.price else 0 end) as checkmoney")
				.append(" from Ticketsell ts left join ticketreturn tr on ts.id=tr.sellid and tr.isselfschedule=1")
				.append(" ,organization org,Schedule sc,Route r,Station s ")
				.append(" where ts.departdate between :departdatebegin and :departdateend")
				.append(" and ts.selltime between :selltimebegin and :selltimeend ")
				.append(" and ts.orgid=org.id ")
				.append(" and r.id = sc.routeid and r.startstationid = s.id ");
		if (isSellLocal) {
			// sql.append(" and ts.sellby > 0 ");
			sql.append(" and ts.orgid in ");
			sql.append(orgids);
		}
		sql.append(" and ts.ticketstatus<>2")
				.append(" and ts.scheduleid=sc.id").append(" and sc.orgid in ")
				.append(orgids)
				.append(" group by ts.departdate,ts.orgid,org.name,s.name ");

		StringBuilder sql1 = new StringBuilder();
		sql1.append(" union all ")
				.append("select s.name as departname,ts.departdate,org.name as sellorgname,")
				.append("   sum(case ts.ticketstatus when '0' then 1 else 0 end) as sellnum,")
				.append("   sum(case ts.ticketstatus when '0' then ts.price else 0 end) as sellmoney,")
				.append("   0 as invoicesmoney,")
				.append("	sum(case ts.ticketstatus when '0' then ts.stationservicefee else 0 end) as stationservicefee,")
				.append("	sum(case ts.ticketstatus when '0' then ts.computefee else 0 end) as computefee,")
				.append("	sum(case ts.ticketstatus when '0' then ts.coolairfee else 0 end) as coolairfee,")
				.append("	sum(case ts.ticketstatus when '0' then ts.additionfee else 0 end) as additionfee,")
				.append("   sum(case ts.ticketstatus when '0' then ts.fueladditionfee else 0 end) as fueladditionfee,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime between :selltimebegin and :selltimeend then 1 else 0 end) as thismonthreturnnum,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime between :selltimebegin and :selltimeend then ts.price else 0 end) as thismonthreturnmoney,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime between :selltimebegin and :selltimeend then tr.charges else 0 end) as thismonthreturncharges,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime between :departdatebegin and :departdateend then 1 else 0 end) as nextmonthreturnnum,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime between :departdatebegin and :departdateend then ts.price else 0 end) as nextmonthreturnmoney,")
				.append("   sum(case when ts.ticketstatus='1' and tr.returntime between :departdatebegin and :departdateend then tr.charges else 0 end) as nextmonthreturncharges,")
				.append("   0 as checknum,")
				.append("   0 as checkmoney")
				.append(" from Ticketsellagent ts left join ticketreturn tr on ts.id=tr.sellid and tr.isselfschedule=0")
				.append(" ,organization org,Userinfo u,Station s ")
				.append(" where ts.departdate between :departdatebegin and :departdateend")
				.append(" and ts.selltime between :selltimebegin and :selltimeend ")
				.append(" and ts.sellby=u.id")
				.append(" and ts.departstationid = s.id ")
				.append(" and u.orgid=org.id")
				.append(" and ts.ticketstatus<>2").append(" and org.id in ")
				.append(orgids)
				.append(" group by ts.departdate,ts.orgid,org.name,s.name");

		StringBuilder sql2 = new StringBuilder();
		sql2.append(")").append(" group by departdate,sellorgname,departname")
				.append(" order by sellorgname,departdate");

		if (isSellLocal) {
			sql.append(sql2);
		} else {
			sql.append(sql1);
			sql.append(sql2);
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("selltimebegin", selltimebegin);
		query.setParameter("selltimeend", selltimeend);
		query.setParameter("departdatebegin", departdatebegin);
		query.setParameter("departdateend", departdateend);
		return query.getResultList();
	}

	/**
	 * 客运每日班次营收汇总
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDayScheduleIncome(String orgids, Date startdate,
			Date enddate, Boolean isovertime, String schedulestatus) {
		StringBuilder sql = new StringBuilder(
				" select name,departdate,sum(schnum) schnum,")
				.append(" sum(seatnum) seatnum,sum(soldeatnum) soldeatnum,sum(totalprice) totalprice")
				.append(" from (select org.name,sp.departdate,count(sp.id) schnum,sum(sp.seatnum) seatnum,")
				.append(" sum(case when ss.status=3 then 0 else sp.soldeatnum end ) soldeatnum,")
				.append(" sum((select sum(t.price) from ticketsell t")
				.append(" where t.scheduleplanid = sp.id and t.ticketstatus = '0' ")
				.append(" and t.scheduleplanid=ss.scheduleplanid and ss.status<>3 )) totalprice")
				.append(" from scheduleplan sp, schedulestatus ss, organization org")
				.append("  where sp.id = ss.scheduleplanid and sp.departdate=ss.departdate and sp.islinework = 0 and ss.status in "
						+ schedulestatus)
				.append(" and sp.orgid = org.id  and sp.startstationid = ss.departstationid");
		if (isovertime != null) {
			if (isovertime) {
				sql.append(" and sp.isovertime=1 ");
			} else if (isovertime == false) {
				sql.append(" and sp.isovertime=0 ");
			}
		}
		sql.append(" and sp.departdate between :startdate and")
				.append(" :enddate and sp.orgid in " + orgids
						+ " group by org.name, sp.departdate union all")
				.append(" select org.name,sp.departdate,sum(decode((select count(svp.id) from vehiclereport svp")
				.append(" where svp.scheduleplanid = sp.id and svp.isactive = 1 and svp.reportorgid = org.id),0,1,")
				.append(" (select count(svp.id) from vehiclereport svp")
				.append(" where svp.scheduleplanid = sp.id and svp.isactive = 1 and svp.reportorgid = org.id))) schnum,")
				.append(" sum(sp.seatnum),sum(sp.soldeatnum),")
				.append(" sum((select sum(t.price) from ticketsell t where t.scheduleplanid = sp.id")
				.append(" and t.ticketstatus = '0')) totalprice  from scheduleplan sp, organization org,schedulestatus ss")
				.append(" where sp.orgid = org.id and sp.id = ss.scheduleplanid and sp.islinework = 1 and sp.departdate between :startdate and")
				.append(" :enddate and sp.departdate=ss.departdate and ")
				.append(" org.stationid=ss.departstationid and ss.status in "
						+ schedulestatus + " and sp.orgid in " + orgids);
		if (isovertime != null) {
			if (isovertime) {
				sql.append(" and sp.isovertime=1 ");
			} else if (isovertime == false) {
				sql.append(" and sp.isovertime=0 ");
			}
		}
		sql.append(
				" group by org.name, sp.departdate) group by name, departdate")
				.append(" order by departdate");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 售票每日营收统计表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate,seller
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDayIncome(String orgids, Date startdate,
			Date enddate, Long seller) {
		StringBuilder sql = new StringBuilder(
				" select t.selldate,sum(t.cancelnum) cancelnum,")
				.append(" sum(t.cancelmoeny) cancelmoeny,sum(t.sellnum) sellnum,")
				.append(" sum(t.totalprice) totalprice,sum(t.returnnum) returnnum,")
				.append(" sum(t.returnprice) returnprice,sum(t.returnfee) returnfee,")
				.append(" sum(t.sellnum - t.cancelnum) totalnum,")
				.append(" sum(t.totalprice - t.cancelmoeny - t.returnprice + t.returnfee) totalincome")
				.append(" from ticketsellbysalerday t")
				.append(" where t.orgid in " + orgids)
				.append(" and t.selldate between :startdate and :enddate");
		if (seller != null) {
			sql.append(" and t.sellby=" + seller);
		}
		sql.append(" group by t.selldate order by t.selldate");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();

	}
	public List<Object> qrysellerdepartinvoices(long sellerid, String orgids, Date departstartdate,
			Date departenddate) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT tt.seller, tt.departdate, tt.departinvoicesnum, tt.ticketnum, ")
				.append(" tt.totalamount, tt.balanceamount, tt.stationservicefee, tt.agentfee , tt.otherfee, tt.fueladditionfee ")
				.append(" FROM (SELECT u.name as seller, d.departdate, count(d.departinvoicesno ) departinvoicesnum, ")
				.append(" sum(d.ticketnum) ticketnum, sum(d.totalamount) totalamount, sum(d.balanceamount) balanceamount, ")
				.append(" sum(d.stationservicefee ) stationservicefee, sum(d.agentfee ) agentfee , sum(d.othterfee) otherfee, ")
				.append(" sum(d.fueladditionfee ) fueladditionfee FROM departinvoices d left join userinfo u on u.id = d.seller ")
				.append(" where d.seller <>0 and d.printorgid in " + orgids);
		if (sellerid > 0) {
			sql.append(" and d.seller = :sellerid");
		}
		sql.append(" group by u.name ,d.departdate union all  ")
				.append(" SELECT u.name as seller, d.departdate, count(d.departinvoicesno ) departinvoicesnum, sum(d.ticketnum) ticketnum, ")
				.append(" sum(d.totalmoney ) totalamount, sum(d.balancemoney  ) balanceamount, sum(d.stationfee  ) stationservicefee, ")
				.append(" sum(d.agentfee ) agentfee , 0 as otherfee, 0 as fueladditionfee  FROM departinvoicesother d ")
				.append(" left join userinfo u on u.id = d.seller  where d.seller <>0 and d.orgid in " + orgids);
		if (sellerid > 0) {
			sql.append(" and d.seller = :sellerid");
		}
		sql.append(" group by u.name ,d.departdate) tt ")
				.append(" where tt.departdate  between :startdate and :enddate +0.99999  and tt.seller is not null ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", departstartdate);
		query.setParameter("enddate", departenddate);
		if (sellerid > 0) {
			query.setParameter("sellerid", sellerid);
		}
		return query.getResultList();
	}

}
