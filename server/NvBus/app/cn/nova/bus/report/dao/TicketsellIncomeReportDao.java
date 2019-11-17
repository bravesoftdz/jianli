package cn.nova.bus.report.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：售票报表</b><br/>
 * <b>类名称：</b>IncomeReportDao.java<br/>
 * <b>功能模块：</b>1，售票营收统计表<br/>
 * </b>2，售票点班线售票情况表<br/>
 * <b>创建人：</b><a href="mailto:liaojunchang@nova.net.cn">廖俊昌</a><br/>
 * <b>创建时间：</b>2012-09-05<br/>
 * <b>关键修改：1添加报表</b><br/>
 * <b>关键修改：1售票营收统计表添加了关联查询异站票表</b><br/>
 * <b>修改时间：2014-01-23</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz<br/>
 */
@SuppressWarnings("rawtypes")
public class TicketsellIncomeReportDao extends EntityManagerDaoSurport {

	/**
	 * 售票营收统计表 数据取自表ticketsell ,ticketreturn ,ticketchange
	 * @param sellendtim 
	 * @param sellstarttime 
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryIncomeReport(String sellorgid,
			Long sellerid, String ticketstatus, boolean ischangeticket,
			String returnticketno, Date sellstartdatetime,
			Date sellenddatetime, Date departstartdate, Date departenddate,
			Long reportnum, String sellstarttime2, String sellendtime2, String ticketoutletsid) {
		String sellstarttime;
		String sellendtime;
		if (sellstartdatetime != null) {
			sellstarttime = DateUtils.formatDate(sellstartdatetime)
					+ " " + sellstarttime2;
			sellendtime = DateUtils.formatDate(sellenddatetime) + " "
					+ sellendtime2;
		}else{
			sellstarttime = null;
			sellendtime = null;
		}
		String departstarttime;
		String departendtime;
		if (departstartdate != null) {
			departstarttime = DateUtils.formatDate(departstartdate);
			departendtime = DateUtils.formatDatetime(departenddate);
		}else{
			departstarttime = null;
			departendtime = null;
		}
		StringBuffer sql = new StringBuffer();
		if (reportnum == 1) {
			// 按售票员营收统计
			sql.append("select al.sellercode,")
					.append(" al.seller,")
					.append(" al.sellorgname,")
					.append(" sum(al.totalnum),")
					.append(" sum(al.nomalnum),")
					.append(" sum(al.fullpricenum),")
					.append(" sum(al.halfpricenum),")
					.append(" sum(al.studentpricenum),")
					.append(" sum(al.armypricenum),")
					.append(" sum(al.salepricenum),")
					.append(" sum(al.freepricenum),")
					.append(" sum(al.changetnum),")
					.append(" sum(al.totalamount),")
					//.append(" sum(al.nomalamount),")
					.append(" sum(al.totalamount-al.returnamount-al.cancelamount+al.servicefee),")
					.append(" sum(al.returnfee),")
					.append(" sum(al.cancelnum),")
					.append(" sum(al.cancelamount),")
					.append(" sum(al.returnnum),")
					.append(" sum(al.privilegereturnnum),")
					.append(" sum(al.returnamount),")
					.append(" sum(al.stationservicefee),")
					.append(" sum(al.nostationfeeamount),sum(al.extramoney)")
					.append(" from (")
					.append(" select u.code sellercode,u.name seller,o.name sellorgname,")
					.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) totalnum, ")
					.append(" sum(decode(t.ticketstatus,0,1,0)) nomalnum,")
					.append(" sum(decode(t.tickettype,'Q',1,0)) fullpricenum,")
					.append(" sum(decode(t.tickettype,'B',1,0)) halfpricenum,")
					.append(" sum(decode(t.tickettype,'X',1,0)) studentpricenum,")
					.append(" sum(decode(t.tickettype,'J',1,0)) armypricenum,")
					.append(" sum(decode(t.tickettype,'Z',1,0)) salepricenum,")
					.append(" sum(decode(t.price,0,1,0)) freepricenum,")
					.append(" sum(nvl2(tc.oldticketsellid,1,0)) changetnum,")
					//.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0)) totalamount,")
					.append(" sum(t.price) totalamount,")
					.append(" sum(decode(t.ticketstatus,0,t.price,0)) nomalamount,")
					// .append(" sum(decode(t.ticketstatus,1,tr.charges,0)) - sum(nvl2(tc.oldticketsellid, tr.charges,0)) returnfee,")
					// .append(" sum(decode(t.ticketstatus,2,1,0)) cancelnum,")
					// .append(" sum(decode(t.ticketstatus,2,t.price,0)) cancelamount,");
					.append(" 0 returnfee,").append(" 0 cancelnum,")
					.append(" 0 cancelamount,");
			// if (ischangeticket) {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0)) returnnum,");
			// } else {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0))-sum(nvl2(tc.oldticketsellid,1,0)) returnnum,");
			// }
			sql.append(" 0 returnnum,");
			sql.append(" sum(decode(tr.returnway, 2, 1, 0)) privilegereturnnum,");
			// sql.append(" sum(decode(t.ticketstatus,1,tr.returnamount,0)) - sum(nvl2(tc.oldticketsellid, tr.returnamount,0)) returnamount,");
			sql.append(" 0 returnamount,");
			// sql.append(" sum(decode(t.ticketstatus,0,stationservicefee,0)) stationservicefee,");
			sql.append(" sum(stationservicefee) stationservicefee,");

			// sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(decode(t.ticketstatus,0,stationservicefee,0)) nostationfeeamount");
			sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(stationservicefee) nostationfeeamount,sum(t.servicefee) servicefee ");
			sql.append(" ,sum(case when t.ticketstatus='0' and t.isdepartinvoices=0 then t.price else 0 end) as extramoney ");
			sql.append(" from Ticketsell t,userinfo u,organization o,ticketreturn tr,ticketchange tc");
			sql.append(" ,ticketcancel tcl");
			sql.append(" where t.sellby=u.id and t.orgid=o.id and t.id=tc.oldticketsellid(+) ");
			sql.append(" and t.id=tr.sellid(+)");
			sql.append(" and t.id = tcl.sellid(+)");
			sql.append(" and tr.returnby(+)=t.sellby");
			sql.append(" and tc.changeby(+)=t.sellby");
			sql.append(" and tcl.cancelby(+)=t.sellby");
			sql.append(" and tr.isselfschedule(+)=1");
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {
				sql.append(" and t.orgid in " + sellorgid);
			}
			if(ticketoutletsid != null && ticketoutletsid != ""){
				sql.append(" and t.ticketoutletsid in "+ticketoutletsid);
			}
			if (sellerid != null && sellerid > 0) {
				sql.append(" and t.sellby=" + sellerid);
			}
			if (ticketstatus != null && ticketstatus.length() > 0) {
				sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
			}
			if (returnticketno != null && returnticketno.length() > 0) {
				sql.append(" and t.ticketno='" + returnticketno + "'");
			}
			if(sellstarttime!=null){
			sql.append(" and t.selltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(sellstarttime!=null){
			sql.append(" and tr.returntime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tc.changetime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tcl.canceltime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by u.code,u.name,o.name ");

			sql.append("  union all select u.code sellercode,u.name seller,o.name sellorgname,")
			.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) totalnum, ");
			sql.append(" sum(decode(t.ticketstatus,0,1,0)) nomalnum,");
			sql.append(" sum(decode(t.tickettype,'Q',1,0)) fullpricenum,");
			sql.append(" sum(decode(t.tickettype,'B',1,0)) halfpricenum,");
			sql.append(" sum(decode(t.tickettype,'X',1,0)) studentpricenum,");
			sql.append(" sum(decode(t.tickettype,'J',1,0)) armypricenum,");
			sql.append(" sum(decode(t.tickettype,'Z',1,0)) salepricenum,");
			sql.append(" sum(decode(t.price,0,1,0)) freepricenum,");
			sql.append(" sum(nvl2(tc.oldticketsellid,1,0)) changetnum,");
			//sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0)) totalamount,");
			sql.append(" sum(t.price) totalamount,");
			sql.append(" sum(decode(t.ticketstatus,0,t.price,0)) nomalamount,");
			// sql.append(" sum(decode(t.ticketstatus,1,tr.charges,0)) - sum(nvl2(tc.oldticketsellid, tr.charges,0)) returnfee,");
			sql.append(" 0 returnfee,");
			// sql.append(" sum(decode(t.ticketstatus,2,1,0)) cancelnum,");
			// sql.append(" sum(decode(t.ticketstatus,2,t.price,0)) cancelamount,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			// if (ischangeticket) {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0)) returnnum,");
			// } else {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0))-sum(nvl2(tc.oldticketsellid,1,0)) returnnum,");
			// }
			sql.append(" 0 returnnum,");
			sql.append(" sum(decode(tr.returnway,2,1,0)) privilegereturnnum,");
			// sql.append(" sum(decode(t.ticketstatus,1,tr.returnamount,0)) - sum(nvl2(tc.oldticketsellid, tr.returnamount,0)) returnamount,");
			sql.append(" 0 returnamount,");
			// sql.append(" sum(decode(t.ticketstatus,0,stationservicefee,0)) stationservicefee,");
			sql.append(" sum(stationservicefee) stationservicefee,");
			// sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(decode(t.ticketstatus,0,stationservicefee,0)) nostationfeeamount");
			sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(stationservicefee) nostationfeeamount, sum(t.servicefee) servicefee,0 as extramoney ");
			sql.append(" from ticketsellagent t,userinfo u,organization o,ticketreturn tr,ticketchange tc");
			sql.append(" ,ticketcancel tcl");
			sql.append(" where t.sellby=u.id and u.orgid=o.id and t.id=tc.oldticketsellid(+) ");
			sql.append(" and t.id=tr.sellid(+)");
			sql.append(" and t.id = tcl.sellid(+)");
			sql.append(" and tr.returnby(+)=t.sellby");
			sql.append(" and tc.changeby(+)=t.sellby");
			sql.append(" and tcl.cancelby(+)=t.sellby");
			sql.append(" and tr.isselfschedule(+)=0");
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(ticketoutletsid != null && ticketoutletsid != ""){
				sql.append(" and t.ticketoutletsid in "+ticketoutletsid);
			}
			if (sellerid != null && sellerid > 0) {
				sql.append(" and t.sellby=" + sellerid);
			}
			if (ticketstatus != null && ticketstatus.length() > 0) {
				sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
			}
			if (returnticketno != null && returnticketno.length() > 0) {
				sql.append(" and t.ticketno='" + returnticketno + "'");
			}
			if(sellstarttime!=null){
			sql.append(" and t.selltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(sellstarttime!=null){
			sql.append(" and tr.returntime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tc.changetime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tcl.canceltime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by u.code,u.name,o.name ");
			// ******
			// sql.append(" --退本站票数据");
			sql.append("  union all");
			sql.append(" select u.code sellercode,");
			sql.append(" u.name seller,");
			sql.append(" o.name sellorgname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" sum(tr.charges+nvl(tr.chargesweb,0)) returnfee,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			sql.append(" count(tr.id) returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" sum(tr.returnamount+nvl(tr.returnamountweb,0)) returnamount,");
			/*
			 * 这是算出退票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-退票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上退票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,0 servicefee,0 as extramoney ");
			/****/
			sql.append(" from ticketsell   t,");
			sql.append(" userinfo     u,");
			sql.append(" organization o,");
			sql.append(" ticketreturn tr");
			sql.append(" where  u.id=tr.returnby");
			sql.append("  and u.orgid = o.id");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			sql.append(" and t.id = tr.sellid");
			sql.append(" and tr.isselfschedule = 1");
			if(sellstarttime!=null){
			sql.append(" and tr.returntime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			//李电志  2015年7月16日 09:45:49
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by u.code, u.name,o.name");

			// sql.append(" --退异站票数据 ");
			sql.append(" union all ");
			sql.append(" select u.code sellercode,");
			sql.append(" u.name seller,");
			sql.append(" o.name sellorgname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" sum(tr.charges+nvl(tr.chargesweb,0)) returnfee,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			sql.append(" count(tr.id) returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" sum(tr.returnamount+nvl(tr.returnamountweb,0)) returnamount,");
			/*
			 * 这是算出退票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-退票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上退票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,0 servicefee,0 as extramoney ");
			/****/
			sql.append(" from ticketsellagent   t,");
			sql.append(" userinfo     u,");
			sql.append(" organization o,");
			sql.append(" ticketreturn tr");
			sql.append(" where  u.id=tr.returnby");
			sql.append("  and u.orgid = o.id");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			sql.append(" and t.id = tr.sellid");
			sql.append(" and tr.isselfschedule = 0");
			if(sellstarttime!=null){
			sql.append(" and tr.returntime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			//李电志  2015年7月16日 09:45:49
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by u.code, u.name,o.name");
			// sql.append(" --废票本站票数据");
			sql.append(" union all");
			sql.append(" select u.code sellercode,");
			sql.append(" u.name seller,");
			sql.append(" o.name sellorgname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" 0 returnfee,");
			sql.append(" count(tcl.id) cancelnum,");
			sql.append(" sum(tcl.ticketprice) cancelamount,");
			sql.append(" 0 returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" 0 returnamount,");
			/*
			 * 这是算出废票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-废票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上废票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,-sum(t.servicefee) servicefee,0 as extramoney ");
			/****/
			sql.append(" from ticketsell   t,");
			/**
			 * 废票不取废票人，取售票员身上
			 */
			sql.append(" userinfo     u,");
			sql.append(" organization o,");
			sql.append(" ticketcancel tcl");
			sql.append(" where  u.id=tcl.sellby and t.id = tcl.sellid"); //过滤掉 废票人和售票人不一样的记录
			sql.append(" and t.id = tcl.sellid");
			sql.append(" and o.id = u.orgid");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			sql.append(" and tcl.isselfschedule = 1");
			if(sellstarttime!=null){
			sql.append(" and tcl.canceltime between");
			sql.append(" to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			//李电志  2015年7月16日 09:45:49
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by u.code, u.name,o.name");

			// sql.append(" --废票异站票数据");
			sql.append(" union all");
			sql.append(" select u.code sellercode,");
			sql.append(" u.name seller,");
			sql.append(" o.name sellorgname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" 0 returnfee,");
			sql.append(" count(tcl.id) cancelnum,");
			sql.append(" sum(tcl.ticketprice) cancelamount,");
			sql.append(" 0 returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" 0 returnamount,");
			/*
			 * 这是算出废票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-废票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上废票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,-sum(t.servicefee) servicefee,0 as extramoney");
			/****/
			sql.append(" from ticketsell   t,");
			sql.append(" userinfo     u,");
			sql.append(" organization o,");
			sql.append(" ticketcancel tcl");
			sql.append(" where  u.id=tcl.sellby  and t.id = tcl.sellid ");
			sql.append(" and t.id = tcl.sellid");
			sql.append(" and o.id = u.orgid");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			sql.append(" and tcl.isselfschedule = 0");
			if(sellstarttime!=null){
			sql.append(" and tcl.canceltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			//李电志  2015年7月16日 09:45:49
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by u.code, u.name,o.name");
			sql.append(" ) al  where al.sellercode<>'other' group by sellercode,seller,sellorgname");

		} else if (reportnum == 2) {
			// 按售票站统计
			sql.append("select al.sellorgname,")
					.append(" al.stationname,")
					.append(" 'null' column3,")
					.append(" sum(al.totalnum),")
					.append(" sum(al.nomalnum),")
					.append(" sum(al.fullpricenum),")
					.append(" sum(al.halfpricenum),")
					.append(" sum(al.studentpricenum),")
					.append(" sum(al.armypricenum),")
					.append(" sum(al.salepricenum),")
					.append(" sum(al.freepricenum),")
					.append(" sum(al.changetnum),")
					.append(" sum(al.totalamount),")
					//.append(" sum(al.nomalamount),")
					.append(" sum(al.totalamount-al.returnamount-al.cancelamount+al.servicefee),")
					.append(" sum(al.returnfee),")
					.append(" sum(al.cancelnum),")
					.append(" sum(al.cancelamount),")
					.append(" sum(al.returnnum),")
					.append(" sum(al.privilegereturnnum),")
					.append(" sum(al.returnamount),")
					.append(" sum(al.stationservicefee),")
					.append(" sum(al.nostationfeeamount),sum(al.extramoney)")
					.append(" from (")
					.append(" select o.name sellorgname,s.name stationname,"
							+" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) totalnum, "
							+ " sum(decode(t.ticketstatus,0,1,0)) nomalnum,"
							+ " sum(decode(t.tickettype,'Q',1,0)) fullpricenum,"
							+ " sum(decode(t.tickettype,'B',1,0)) halfpricenum,"
							+ " sum(decode(t.tickettype,'X',1,0)) studentpricenum,"
							+ " sum(decode(t.tickettype,'J',1,0)) armypricenum,"
							+ " sum(decode(t.tickettype,'Z',1,0)) salepricenum,"
							+ " sum(decode(t.price,0,1,0)) freepricenum,"
							+ " sum(nvl2(tc.oldticketsellid,1,0)) changetnum,"
							//+ " sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0)) totalamount,"
							+" sum(t.price) totalamount,"
							+ " sum(decode(t.ticketstatus,0,t.price,0)) nomalamount,"
//							+ " sum(decode(t.ticketstatus,1,tr.charges,0)) - sum(nvl2(tc.oldticketsellid, tr.charges,0)) returnfee,"
							// + " sum(decode(t.ticketstatus,2,1,0)) cancelnum,"
							// +
							// " sum(decode(t.ticketstatus,2,t.price,0)) cancelamount,");
							+ " 0 returnfee,"
							+ " 0 cancelnum,"
							+ " 0 cancelamount,");
			// if (ischangeticket) {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0)) returnnum,");
			// } else {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0))-sum(nvl2(tc.oldticketsellid,1,0)) returnnum,");
			// }
			sql.append(" 0 returnnum,");
			sql.append(" sum(decode(tr.returnway,2,1,0)) privilegereturnnum,"
			// +
			// " sum(decode(t.ticketstatus,1,tr.returnamount,0)) - sum(nvl2(tc.oldticketsellid, tr.returnamount,0)) returnamount, ");
					+ " 0 returnamount, ");
			// sql.append(" , wm_concat(case when t.ticketstatus='2' or t.ticketstatus='1' then t.ticketno end) return_cancel ");
			// sql.append(" sum(decode(t.ticketstatus,0,stationservicefee,0)) stationservicefee,");
			// sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(decode(t.ticketstatus,0,stationservicefee,0)) nostationfeeamount");
			sql.append(" sum(stationservicefee) stationservicefee,");
			sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(stationservicefee) nostationfeeamount, sum(t.servicefee) servicefee ");
			sql.append(" ,sum(case when t.ticketstatus='0' and t.isdepartinvoices=0 then t.price else 0 end) as extramoney ");
			sql.append("  from Ticketsell t,station s,organization o,ticketreturn tr,ticketchange tc, ticketcancel tcl"
					+ " where t.orgid=o.id and t.departstationid=s.id and t.id=tc.oldticketsellid(+) ");
			sql.append(" and t.id=tr.sellid(+)");
			sql.append(" and t.id = tcl.sellid(+)");
			sql.append(" and tr.returnby(+)=t.sellby");
			sql.append(" and tc.changeby(+)=t.sellby");
			sql.append(" and tcl.cancelby(+)=t.sellby");
			sql.append(" and tr.isselfschedule(+)=1");
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {
				sql.append(" and t.orgid in " + sellorgid);
			}
			if(ticketoutletsid != null && ticketoutletsid != ""){
				sql.append(" and t.ticketoutletsid in "+ticketoutletsid);
			}
			if (sellerid != null && sellerid > 0) {
				sql.append(" and t.sellby=" + sellerid);
			}
			if (ticketstatus != null && ticketstatus.length() > 0) {
				sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
			}

			if (returnticketno != null && returnticketno.length() > 0) {
				sql.append(" and t.ticketno='" + returnticketno + "'");
			}
			if(sellstarttime!=null){
			sql.append(" and t.selltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tr.returntime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tc.changetime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tcl.canceltime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss')" + " group by o.name,s.name");
			}else{
				sql.append("  group by s.name, o.name ");
			}
			sql.append(" union all select o.name sellorgname,s.name stationname,"
					+ " count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) totalnum, "
					+ " sum(decode(t.ticketstatus,0,1,0)) nomalnum,"
					+ " sum(decode(t.tickettype,'Q',1,0)) fullpricenum,"
					+ " sum(decode(t.tickettype,'B',1,0)) halfpricenum,"
					+ " sum(decode(t.tickettype,'X',1,0)) studentpricenum,"
					+ " sum(decode(t.tickettype,'J',1,0)) armypricenum,"
					+ " sum(decode(t.tickettype,'Z',1,0)) salepricenum,"
					+ " sum(decode(t.price,0,1,0)) freepricenum,"
					+ " sum(nvl2(tc.oldticketsellid,1,0)) changetnum,"
					//+ " sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0)) totalamount,"
					+" sum(t.price) totalamount,"
					+ " sum(decode(t.ticketstatus,0,t.price,0)) nomalamount,"
//					+ " sum(decode(t.ticketstatus,1,tr.charges,0)) - sum(nvl2(tc.oldticketsellid, tr.charges,0)) returnfee,"
					// + " sum(decode(t.ticketstatus,2,1,0)) cancelnum,"
					// +
					// " sum(decode(t.ticketstatus,2,t.price,0)) cancelamount,");
					+ " 0 returnfee,"
					+ " 0 cancelnum,"
					+ " 0 cancelamount,");
			// if (ischangeticket) {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0)) returnnum,");
			// } else {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0))-sum(nvl2(tc.oldticketsellid,1,0)) returnnum,");
			// }
			sql.append(" 0 returnnum,");
			sql.append(" sum(decode(tr.returnway,2,1,0)) privilegereturnnum,"
			// +
			// " sum(decode(t.ticketstatus,1,tr.returnamount,0)) - sum(nvl2(tc.oldticketsellid, tr.returnamount,0)) returnamount, ")
					+ " 0 returnamount, ")
					// sql.append(" , wm_concat(case when t.ticketstatus='2' or t.ticketstatus='1' then t.ticketno end) return_cancel ")
					// .append(" sum(decode(t.ticketstatus,0,stationservicefee,0)) stationservicefee,")
					// .append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(decode(t.ticketstatus,0,stationservicefee,0)) nostationfeeamount")
					.append(" sum(stationservicefee) stationservicefee,")
					.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(stationservicefee) nostationfeeamount, sum(t.servicefee) servicefee,0 as extramoney ")
					.append("  from ticketsellagent t,station s,organization o,")
					.append("ticketreturn tr,ticketchange tc, userinfo u ")
					.append(" ,ticketcancel tcl ")
					.append(" where u.orgid=o.id and t.departstationid=s.id and t.id=tc.oldticketsellid(+) ")
					.append(" and t.sellby=u.id and t.id=tr.sellid(+)");
			sql.append(" and t.id = tcl.sellid(+)");
			sql.append(" and tr.returnby(+)=t.sellby");
			sql.append(" and tc.changeby(+)=t.sellby");
			sql.append(" and tcl.cancelby(+)=t.sellby");
			sql.append(" and tr.isselfschedule(+)=0");
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(ticketoutletsid != null && ticketoutletsid != ""){
				sql.append(" and t.ticketoutletsid in "+ticketoutletsid);
			}
			if (sellerid != null && sellerid > 0) {
				sql.append(" and t.sellby=" + sellerid);
			}
			if (ticketstatus != null && ticketstatus.length() > 0) {
				sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
			}

			if (returnticketno != null && returnticketno.length() > 0) {
				sql.append(" and t.ticketno='" + returnticketno + "'");
			}
			if(sellstarttime!=null){
			sql.append(" and t.selltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tr.returntime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tc.changetime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tcl.canceltime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss')" + " group by o.name,s.name");
			}else{
				sql.append("  group by s.name, o.name ");
			}

			//sql.append(" --退本站票数据");
			sql.append(" union all");
			sql.append(" select o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" sum(tr.charges+nvl(tr.chargesweb,0)) returnfee,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			sql.append(" count(tr.id) returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" sum(tr.returnamount+nvl(tr.returnamountweb,0)) returnamount,");
			/*
			 * 这是算出退票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-退票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上退票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount, 0 servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsell t,");
			sql.append(" station s,");
			sql.append(" ticketreturn tr,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append(" where  ");
			sql.append(" t.id=tr.sellid");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and u.id=tr.returnby");
			sql.append(" and u.orgid = o.id");
			sql.append(" and tr.isselfschedule = 1");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tr.returntime between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by s.name,o.name");
		
			//sql.append(" --退异站票数据 ");
			sql.append(" union all");
			sql.append(" select o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" sum(tr.charges+nvl(tr.chargesweb,0)) returnfee,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			sql.append(" count(tr.id) returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" sum(tr.returnamount+nvl(tr.returnamountweb,0)) returnamount,");
			/*
			 * 这是算出退票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-退票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上退票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,0 servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsell t,");
			sql.append(" station s,");
			sql.append(" ticketreturn tr,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append(" where  ");
			sql.append(" t.id=tr.sellid");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and u.id=tr.returnby");
			sql.append(" and u.orgid = o.id");
			sql.append(" and tr.isselfschedule = 0");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tr.returntime between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by s.name,o.name");
			//sql.append(" --废票本站票数据");
			sql.append(" union all");
			sql.append(" select o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" 0 returnfee,");
			sql.append(" count(tcl.id) cancelnum,");
			sql.append(" sum(tcl.ticketprice) cancelamount,");
			sql.append(" 0 returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" 0 returnamount,");
			/*
			 * 这是算出废票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-废票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上废票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,-sum(t.servicefee) servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsell t,");
			sql.append(" station s,");
			sql.append(" ticketcancel tcl,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append(" where  t.id=tcl.sellid and u.id=tcl.cancelby  and t.id = tcl.sellid");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and o.id = u.orgid");
			sql.append(" and tcl.isselfschedule = 1");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tcl.canceltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by s.name,o.name");

			//sql.append(" --废票异站票数据");
			sql.append(" union all");
			sql.append(" select o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" 0 returnfee,");
			sql.append(" count(tcl.id) cancelnum,");
			sql.append(" sum(tcl.ticketprice) cancelamount,");
			sql.append(" 0 returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" 0 returnamount,");
			/*
			 * 这是算出废票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-废票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上废票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,-sum(t.servicefee) servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsell t,");
			sql.append(" station s,");
			sql.append(" ticketcancel tcl,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append("  ");
			sql.append(" where  t.id=tcl.sellid and u.id=tcl.cancelby  and t.id = tcl.sellid");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and o.id = u.orgid");
			sql.append(" and tcl.isselfschedule = 0");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tcl.canceltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by s.name,o.name");
			sql.append(" ) al  group by al.sellorgname, al.stationname ");


		} else {
			sql.append("select al.selldate,")
					.append(" al.sellorgname,")
					.append(" al.stationname,")
					.append(" sum(al.totalnum),")
					.append(" sum(al.nomalnum),")
					.append(" sum(al.fullpricenum),")
					.append(" sum(al.halfpricenum),")
					.append(" sum(al.studentpricenum),")
					.append(" sum(al.armypricenum),")
					.append(" sum(al.salepricenum),")
					.append(" sum(al.freepricenum),")
					.append(" sum(al.changetnum),")
					.append(" sum(al.totalamount),")
					//.append(" sum(al.nomalamount),")
					.append(" sum(al.totalamount-al.returnamount-al.cancelamount+al.servicefee),")
					.append(" sum(al.returnfee),")
					.append(" sum(al.cancelnum),")
					.append(" sum(al.cancelamount),")
					.append(" sum(al.returnnum),")
					.append(" sum(al.privilegereturnnum),")
					.append(" sum(al.returnamount),")
					.append(" sum(al.stationservicefee),")
					.append(" sum(al.nostationfeeamount),sum(al.extramoney)")
					.append(" from (")
					.append(" select trunc(t.selltime) selldate,"
							+ " o.name sellorgname,"
							+ " s.name stationname,"
							+ " count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) totalnum, "
							+ " sum(decode(t.ticketstatus,0,1,0)) nomalnum,"
							+ " sum(decode(t.tickettype,'Q',1,0)) fullpricenum,"
							+ " sum(decode(t.tickettype,'B',1,0)) halfpricenum,"
							+ " sum(decode(t.tickettype,'X',1,0)) studentpricenum,"
							+ " sum(decode(t.tickettype,'J',1,0)) armypricenum,"
							+ " sum(decode(t.tickettype,'Z',1,0)) salepricenum,"
							+ " sum(decode(t.price,0,1,0)) freepricenum,"
							+ " sum(nvl2(tc.oldticketsellid,1,0)) changetnum,"
							//+ " sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0)) totalamount,"
							+" sum(t.price) totalamount,"
							+ " sum(decode(t.ticketstatus,0,t.price,0)) nomalamount,"
//							+ " sum(decode(t.ticketstatus,1,tr.charges,0)) - sum(nvl2(tc.oldticketsellid, tr.charges,0)) returnfee,"
							// + " sum(decode(t.ticketstatus,2,1,0)) cancelnum,"
							// +
							// " sum(decode(t.ticketstatus,2,t.price,0)) cancelamount,");
							+ " 0 returnfee,"
							+ " 0 cancelnum,"
							+ " 0 cancelamount,");
			// if (ischangeticket) {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0)) returnnum,");
			// } else {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0))-sum(nvl2(tc.oldticketsellid,1,0)) returnnum,");
			// }
			sql.append("  0 returnnum,");
			sql.append(" sum(decode(tr.returnway,2,1,0)) privilegereturnnum,"
			// +
			// " sum(decode(t.ticketstatus,1,tr.returnamount,0)) - sum(nvl2(tc.oldticketsellid, tr.returnamount,0)) returnamount, ");
					+ " 0 returnamount, ");
			// sql.append(" sum(decode(t.ticketstatus,0,stationservicefee,0)) stationservicefee,");
			// sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(decode(t.ticketstatus,0,stationservicefee,0)) nostationfeeamount");
			sql.append(" sum(stationservicefee) stationservicefee,");
			sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(stationservicefee) nostationfeeamount,sum(t.servicefee) servicefee");
			sql.append(" ,sum(case when t.ticketstatus='0' and t.isdepartinvoices=0 then t.price else 0 end) as extramoney ");
			// sql.append(" ,wm_concat(case when t.ticketstatus='2' or t.ticketstatus='1' then t.ticketno end) return_cancel ");
			sql.append(" from Ticketsell t,station s,organization o,ticketreturn tr,ticketchange tc,ticketcancel tcl"
					+ " where t.orgid=o.id and t.departstationid=s.id and t.id=tc.oldticketsellid(+) ");
			sql.append(" and t.id=tr.sellid(+)");
			sql.append(" and t.id = tcl.sellid(+)");
			sql.append(" and tr.returnby(+)=t.sellby");
			sql.append(" and tc.changeby(+)=t.sellby");
			sql.append(" and tcl.cancelby(+)=t.sellby");
			sql.append(" and tr.isselfschedule(+)=1");
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {
				sql.append(" and t.orgid in " + sellorgid);
			}
			if(ticketoutletsid != null && ticketoutletsid != ""){
				sql.append(" and t.ticketoutletsid in "+ticketoutletsid);
			}
			if (sellerid != null && sellerid > 0) {
				sql.append(" and t.sellby=" + sellerid);
			}
			if (ticketstatus != null && ticketstatus.length() > 0) {
				sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
			}

			if (returnticketno != null && returnticketno.length() > 0) {
				sql.append(" and t.ticketno='" + returnticketno + "'");
			}
			if(sellstarttime!=null){
			sql.append(" and t.selltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tr.returntime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tc.changetime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tcl.canceltime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss')");
			}
			sql.append(" group by trunc(t.selltime),o.name,s.name ");

			sql.append(" union all select trunc(t.selltime) selldate,"
					+ " o.name sellorgname,"
					+ " s.name stationname,"
					+ " count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) totalnum, "
					+ " sum(decode(t.ticketstatus,0,1,0)) nomalnum,"
					+ " sum(decode(t.tickettype,'Q',1,0)) fullpricenum,"
					+ " sum(decode(t.tickettype,'B',1,0)) halfpricenum,"
					+ " sum(decode(t.tickettype,'X',1,0)) studentpricenum,"
					+ " sum(decode(t.tickettype,'J',1,0)) armypricenum,"
					+ " sum(decode(t.tickettype,'Z',1,0)) salepricenum,"
					+ " sum(decode(t.price,0,1,0)) freepricenum,"
					+ " sum(nvl2(tc.oldticketsellid,1,0)) changetnum,"
					//+ " sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0)) totalamount,"
					+" sum(t.price) totalamount,"
					+ " sum(decode(t.ticketstatus,0,t.price,0)) nomalamount,"
//					+ " sum(decode(t.ticketstatus,1,tr.charges,0)) - sum(nvl2(tc.oldticketsellid, tr.charges,0)) returnfee,"
					// + " sum(decode(t.ticketstatus,2,1,0)) cancelnum,"
					// +
					// " sum(decode(t.ticketstatus,2,t.price,0)) cancelamount,");
					+ " 0 returnfee,"
					+ " 0 cancelnum,"
					+ " 0 cancelamount,");
			// if (ischangeticket) {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0)) returnnum,");
			// } else {
			// sql.append(" sum(decode(t.ticketstatus,1,1,0))-sum(nvl2(tc.oldticketsellid,1,0)) returnnum,");
			// }
			sql.append(" 0 returnnum,");
			sql.append(" sum(decode(tr.returnway,2,1,0)) privilegereturnnum,"
			// +
			// " sum(decode(t.ticketstatus,1,tr.returnamount,0)) - sum(nvl2(tc.oldticketsellid, tr.returnamount,0)) returnamount, ");
					+ " 0 returnamount, ");
			// sql.append(" sum(decode(t.ticketstatus,0,stationservicefee,0)) stationservicefee,");
			// sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(decode(t.ticketstatus,0,stationservicefee,0)) nostationfeeamount");
			sql.append(" sum(stationservicefee) stationservicefee,");
			sql.append(" sum(t.price)- sum(nvl2(tc.oldticketsellid, t.price,0))-sum(stationservicefee) nostationfeeamount,sum(t.servicefee) servicefee,0 as extramoney ");
			// sql.append(" ,wm_concat(case when t.ticketstatus='2' or t.ticketstatus='1' then t.ticketno end) return_cancel ");
			sql.append(" from ticketsellagent t,station s,organization o,")
					.append(" ticketreturn tr,ticketchange tc,userinfo u,ticketcancel tcl"
							+ " where u.orgid=o.id and t.departstationid=s.id and t.id=tc.oldticketsellid(+) ");
			sql.append(" and t.sellby=u.id and t.id=tr.sellid(+)");
			sql.append(" and t.id=tr.sellid(+)");
			sql.append(" and t.id = tcl.sellid(+)");
			sql.append(" and tr.returnby(+)=t.sellby");
			sql.append(" and tc.changeby(+)=t.sellby");
			sql.append(" and tcl.cancelby(+)=t.sellby");
			sql.append(" and tr.isselfschedule(+)=0");
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(ticketoutletsid != null && ticketoutletsid != ""){
				sql.append(" and t.ticketoutletsid in "+ticketoutletsid);
			}
			if (sellerid != null && sellerid > 0) {
				sql.append(" and t.sellby=" + sellerid);
			}
			if (ticketstatus != null && ticketstatus.length() > 0) {
				sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
			}

			if (returnticketno != null && returnticketno.length() > 0) {
				sql.append(" and t.ticketno='" + returnticketno + "'");
			}
			if(sellstarttime!=null){
			sql.append(" and t.selltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tr.returntime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tc.changetime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			sql.append(" and tcl.canceltime(+) between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			if(departstarttime!=null){
			sql.append(" and t.departdate between to_date('" + departstarttime
					+ "','yyyy-MM-dd') and to_date('" + departendtime
					+ "','yyyy-MM-dd HH24:mi:ss')");
			}
			 sql.append(" group by trunc(t.selltime),o.name,s.name  ");

			// ------------
			//sql.append(" --退本站票数据");
			sql.append(" union all");
			sql.append(" select trunc(tr.returntime) selldate ,o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" sum(tr.charges+nvl(tr.chargesweb,0)) returnfee,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			sql.append(" count(tr.id) returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" sum(tr.returnamount+nvl(tr.returnamountweb,0)) returnamount,");
			/*
			 * 这是算出退票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-退票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上退票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,0 servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsell t,");
			sql.append(" station s,");
			sql.append(" ticketreturn tr,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append(" where  ");
			sql.append(" t.id=tr.sellid");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and u.id=tr.returnby");
			sql.append(" and u.orgid = o.id");
			sql.append(" and tr.isselfschedule = 1");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tr.returntime between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by trunc(tr.returntime),s.name,o.name");
		
			//sql.append(" --退异站票数据 ");
			sql.append(" union all");
			
			sql.append(" select trunc(tr.returntime) selldate,o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" sum(tr.charges+nvl(tr.chargesweb,0)) returnfee,");
			sql.append(" 0 cancelnum,");
			sql.append(" 0 cancelamount,");
			sql.append(" count(tr.id) returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" sum(tr.returnamount+nvl(tr.returnamountweb,0)) returnamount,");
			/*
			 * 这是算出退票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-退票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上退票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,0 servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsellagent t, station s,ticketreturn tr,organization o,userinfo u");
			sql.append(" where  ");
			sql.append(" t.id=tr.sellid");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and u.id=tr.returnby");
			sql.append(" and u.orgid = o.id");
			sql.append(" and tr.isselfschedule = 0");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tr.returntime between to_date('"
					+ sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by trunc(tr.returntime),s.name,o.name");
			//sql.append(" --废票本站票数据");
			sql.append(" union all");
			sql.append(" select trunc(tcl.canceltime) selldate,o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" 0 returnfee,");
			sql.append(" count(tcl.id) cancelnum,");
			sql.append(" sum(tcl.ticketprice) cancelamount,");
			sql.append(" 0 returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" 0 returnamount,");
			/*
			 * 这是算出废票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-废票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上废票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,-sum(t.servicefee) servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsell t,");
			sql.append(" station s,");
			sql.append(" ticketcancel tcl,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append(" where  t.id=tcl.sellid and u.id=tcl.cancelby  and t.id = tcl.sellid ");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and o.id = u.orgid");
			sql.append(" and tcl.isselfschedule = 1");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tcl.canceltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by trunc(tcl.canceltime) ,s.name,o.name");

			//sql.append(" --废票异站票数据");
			sql.append(" union all");
			sql.append(" select trunc(tcl.canceltime) selldate,o.name sellorgname,");
			sql.append(" s.name stationname,");
			sql.append(" 0 totalnum,");
			sql.append(" 0 nomalnum,");
			sql.append(" 0 fullpricenum,");
			sql.append(" 0 halfpricenum,");
			sql.append(" 0 studentpricenum,");
			sql.append(" 0 armypricenum,");
			sql.append(" 0 salepricenum,");
			sql.append(" 0 freepricenum,");
			sql.append(" 0 changetnum,");
			sql.append(" 0 totalamount,");
			sql.append(" 0 nomalamount,");
			sql.append(" 0 returnfee,");
			sql.append(" count(tcl.id) cancelnum,");
			sql.append(" sum(tcl.ticketprice) cancelamount,");
			sql.append(" 0 returnnum,");
			sql.append(" 0 privilegereturnnum,");
			sql.append(" 0 returnamount,");
			/*
			 * 这是算出废票要扣的站务费，用0减其为负数，则sum(stationservicefee)时， 总售票的站务费-废票所扣站务费
			 */
			sql.append(" 0-sum(t.stationservicefee) stationservicefee,");
			/*
			 * 这是算出不含站务费营收，上面减去的是站务费是售票的站务费，是要减去实际站务费(售票站务费-退废站务费)的，所以要加上废票站务费
			 */
			sql.append(" sum(t.stationservicefee) nostationfeeamount,-sum(t.servicefee) servicefee,0 as extramoney ");
			sql.append(" from ");
			sql.append(" ticketsellagent t,");
			sql.append(" station s,");
			sql.append(" ticketcancel tcl,");
			sql.append(" organization o,");
			sql.append(" userinfo u");
			sql.append("  ");
			sql.append(" where  t.id=tcl.sellid and u.id=tcl.cancelby");
			sql.append(" and s.id=t.departstationid");
			sql.append(" and o.id = u.orgid");
			sql.append(" and tcl.isselfschedule = 0");
			if (sellerid != null && sellerid > 0) {
				sql.append(" and u.id=" + sellerid);
			}
			if (ischangeticket) {
				sql.append(" and t.sellway='4'");
			}
			if (sellorgid != null && sellorgid != "") {             //增加售票机构查询限制条件 2018年2月27日16:03:19  zhangxibao
				sql.append(" and u.orgid in " + sellorgid);
			}
			if(sellstarttime!=null){
			sql.append(" and tcl.canceltime between to_date('" + sellstarttime
					+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
					+ "','yyyy-MM-dd HH24:mi:ss') ");
			}
			sql.append(" group by s.name,o.name,trunc(tcl.canceltime)");
			sql.append(" ) al  group by al.selldate,al.sellorgname, al.stationname order by al.selldate");

		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	public List<Object> queryticket1(String ticketoutletsid, Long sellerid,
			String ticketstatus, boolean ischangeticket, String returnticketno,
			Date sellstartdatetime, Date sellenddatetime, Date departstartdate,
			Date departenddate, String userno, String sellorgname) {
		String sellstarttime = DateUtils.formatDatetime(sellstartdatetime);
		String sellendtime = DateUtils.formatDatetime(sellenddatetime);
		String departstarttime = DateUtils.formatDate(departstartdate);
		String departendtime = DateUtils.formatDate(departenddate);
		StringBuffer sql = new StringBuffer(
				"select t.selltime as selldatetime,decode(t.ticketstatus,2,'废票',1,'退票') as type,t.ticketno ");
		sql.append(" from ticketsell t,userinfo u,organization o,ticketchange tc");
		sql.append(" where t.sellby=u.id and t.orgid=o.id and t.id=tc.oldticketsellid(+) ");
		if (ischangeticket) {
			sql.append(" and t.sellway='4'");
		}
		if (ticketoutletsid != null && !ticketoutletsid.equals("")) {
			sql.append(" and t.orgid in " + ticketoutletsid);
		}
		if (sellerid != null && sellerid > 0) {
			sql.append(" and t.sellby=" + sellerid);
		}
		if (ticketstatus != null && ticketstatus.length() > 0) {
			sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
		}
		if (userno != null && !userno.equals("")) {
			sql.append(" and u.code='" + userno + "'");
		}
		if (sellorgname != null && !sellorgname.equals("")) {
			sql.append(" and o.name='" + sellorgname + "'");
		}

		sql.append(" and t.ticketstatus in ('2','1') and tc.oldticketsellid is null	");

		if (returnticketno != null && returnticketno.length() > 0) {
			sql.append(" and t.ticketno='" + returnticketno + "'");
		}
		sql.append(" and t.selltime between to_date('" + sellstarttime
				+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
				+ "','yyyy-MM-dd HH24:mi:ss') ");
		sql.append(" and t.departdate between to_date('" + departstarttime
				+ "','yyyy-MM-dd') and to_date('" + departendtime
				+ "','yyyy-MM-dd') ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	public List<Object> queryticket2(String ticketoutletsid, Long sellerid,
			String ticketstatus, boolean ischangeticket, String returnticketno,
			Date sellstartdatetime, Date sellenddatetime, Date departstartdate,
			Date departenddate, String sellorgname, String departorgname) {
		String sellstarttime = DateUtils.formatDatetime(sellstartdatetime);
		String sellendtime = DateUtils.formatDatetime(sellenddatetime);
		String departstarttime = DateUtils.formatDate(departstartdate);
		String departendtime = DateUtils.formatDate(departenddate);
		StringBuffer sql = new StringBuffer(
				"select t.selltime as selldatetime,decode(t.ticketstatus,2,'废票',1,'退票') as type,t.ticketno ");
		sql.append(" from ticketsell t,station s,organization o,ticketchange tc"
				+ " where t.orgid=o.id and t.departstationid=s.id and t.id=tc.oldticketsellid(+) ");
		sql.append(" and t.ticketstatus in ('2','1') and tc.oldticketsellid is null	");
		if (ischangeticket) {
			sql.append(" and t.sellway='4'");
		}
		if (ticketoutletsid != null && ticketoutletsid != "") {
			sql.append(" and t.orgid in " + ticketoutletsid);
		}
		if (sellerid != null && sellerid > 0) {
			sql.append(" and t.sellby=" + sellerid);
		}
		if (ticketstatus != null && ticketstatus.length() > 0) {
			sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
		}
		if (departorgname != null && !departorgname.equals("")) {
			sql.append(" and s.name='" + departorgname + "'");
		}
		if (sellorgname != null && !sellorgname.equals("")) {
			sql.append(" and o.name='" + sellorgname + "'");
		}

		if (returnticketno != null && returnticketno.length() > 0) {
			sql.append(" and t.ticketno='" + returnticketno + "'");
		}
		sql.append(" and t.selltime between to_date('" + sellstarttime
				+ "','yyyy-MM-dd HH24:mi:ss') and to_date('" + sellendtime
				+ "','yyyy-MM-dd HH24:mi:ss') ");
		sql.append(" and t.departdate between to_date('" + departstarttime
				+ "','yyyy-MM-dd') and to_date('" + departendtime
				+ "','yyyy-MM-dd') ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryticket3(String ticketoutletsid, Long sellerid,
			String ticketstatus, boolean ischangeticket, String returnticketno,
			Date sellstartdatetime, Date sellenddatetime, Date departstartdate,
			Date departenddate, String selldate, String sellorgname,
			String departorgname) {
		String sellstarttime = DateUtils.formatDatetime(sellstartdatetime);
		String sellendtime = DateUtils.formatDatetime(sellenddatetime);
		String departstarttime = DateUtils.formatDate(departstartdate);
		String departendtime = DateUtils.formatDate(departenddate);
		StringBuffer sql = new StringBuffer(
				"select t.selltime as selldatetime,decode(t.ticketstatus,2,'废票',1,'退票') as type,t.ticketno ");
		sql.append(" from ticketsell t,station s,organization o,ticketchange tc"
				+ " where t.orgid=o.id and t.departstationid=s.id and t.id=tc.oldticketsellid(+) ");
		sql.append(" and t.ticketstatus in ('2','1') and tc.oldticketsellid is null	");
		if (ischangeticket) {
			sql.append(" and t.sellway='4'");
		}
		if (ticketoutletsid != null && ticketoutletsid != "") {
			sql.append(" and t.orgid in " + ticketoutletsid);
		}
		if (sellerid != null && sellerid > 0) {
			sql.append(" and t.sellby=" + sellerid);
		}
		if (ticketstatus != null && ticketstatus.length() > 0) {
			sql.append(" and t.ticketstatus='" + ticketstatus + "' ");
		}
		if (selldate != null && !selldate.equals("")) {
			if (selldate.equals(sellstarttime.substring(0, 10))) {
				sql.append(" and t.selltime between to_date('" + sellstarttime
						+ "','yyyy-MM-dd HH24:mi:ss')");
			} else {
				sql.append(" and t.selltime between to_date('"
						+ selldate.substring(0, 10)
						+ " 00:00:00','yyyy-MM-dd HH24:mi:ss')");
			}
			if (selldate.equals(sellendtime.substring(0, 10))) {
				sql.append(" and to_date('" + sellendtime
						+ "','yyyy-MM-dd HH24:mi:ss')");
			} else {
				sql.append(" and to_date('" + selldate.substring(0, 10)
						+ " 23:59:59','yyyy-MM-dd HH24:mi:ss')");
			}
		}
		sql.append(" and t.departdate between to_date('" + departstarttime
				+ "','yyyy-MM-dd') and to_date('" + departendtime
				+ "','yyyy-MM-dd') ");
		if (sellorgname != null && !sellorgname.equals("")) {
			sql.append(" and o.name='" + sellorgname + "'");
		}
		if (departorgname != null && !departorgname.equals("")) {
			sql.append(" and s.name='" + departorgname + "'");
		}
		if (returnticketno != null && returnticketno.length() > 0) {
			sql.append(" and t.ticketno='" + returnticketno + "'");
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	/**
	 * 售票点班线售票情况表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryTicketoutletsSellroute(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select printorg.name printorgname,sellorg.name as sellorgname,")
				.append(" nvl(ts.ticketoutletsname,'异站售票点'),")
				.append(" r.name routename,")
				.append(" u.name unitname,")
				.append(" v.vehicleno,")
				.append(" count(ts.id) sellnum,")
				.append(" sum(ts.price) sellprice,")
				.append(" sum(ts.price-(ts.computefee + ts.coolairfee + ts.additionfee")
				.append(" + ts.moreprice +  ts.waterfee + ts.insurefee + ts.otherfee")
				.append(" + ts.fueladditionfee + ts.stationservicefee))-dv.agentfee balanceprice,")
				.append(" sum(ts.computefee + ts.coolairfee + ts.additionfee + ts.moreprice +")
				.append(" ts.waterfee + ts.insurefee + ts.otherfee + ts.fueladditionfee +")
				.append(" ts.stationservicefee)+dv.agentfee subtotal,")
				.append(" sum(ts.fueladditionfee) fueladditionfee,")
				.append(" sum(ts.stationservicefee) stationservicefee,")
				.append(" sum(ts.computefee) computefee,")
				.append(" sum(ts.coolairfee) coolairfee,")
				.append(" sum(ts.additionfee) additionfee,")
				.append(" sum(ts.moreprice) moreprice,")
				.append(" sum(ts.waterfee) waterfee,")
				.append(" sum(ts.insurefee) insurefee,")
				.append(" sum(ts.otherfee) otherfee,")
				.append(" dv.agentfee ")
				.append(" from Ticketsell     ts,")
				.append(" departinvoices dv,")
				.append(" organization   printorg,")
				.append(" organization   sellorg,")
				.append(" schedule       s,").append(" route          r,")
				.append(" vehicle        v,").append(" unit           u")
				.append(" where ts.isdepartinvoices = 1")
				.append(" and ts.ticketstatus = 0")
				.append(" and dv.status <> 1")
				.append(" and ts.departinvoicesid = dv.id")
				.append(" and dv.printorgid = printorg.id")
				.append(" and ts.scheduleid = s.id")
				.append(" and dv.scheduleid = s.id")
				.append(" and s.routeid = r.id")
				.append(" and dv.vehicleid = v.id")
				.append(" and v.balanceunitid = u.id ")
				.append(" and ts.orgid = sellorg.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by printorg.id,")
				.append("    printorg.name,sellorg.name,")
				.append("    ts.ticketoutletsname,").append("    r.name,")
				.append("    u.name,").append("    v.vehicleno ,dv.agentfee ")
				.append(" order by ts.ticketoutletsname,r.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> CustomerBuyTicketSituation(List<PropertyFilter> propertyFilterList, boolean isgroupbyroute,
			int groupby, int groupbywhat) {
		StringBuffer sql = new StringBuffer();
		// 如果按照线路分组
		if (isgroupbyroute) {
			sql.append("select routename,customername,certificateno,ticketnum,totalprice from (")
					.append("select routename,customerid,customername,certificateno,ticketnum,totalprice from ( ")
					.append(" select distinct t.customerid,t.routename,c.name as customername,c.certificateno, ");
		} else {
			sql.append("select '',customername,certificateno,ticketnum,totalprice from (")
					.append("select customerid,customername,certificateno,ticketnum,totalprice from ( ")
					.append(" select distinct t.customerid,c.name as customername,c.certificateno, ");
		}
		sql.append(" count(t.ticketno) as ticketnum,sum(t.price) as totalprice from ")
		.append(" (select r.name as routename, ts.customerid, ts.ticketno, ts.price ")
		.append(" from ticketsell ts ")
		.append(" left join schedule s on s.id = ts.scheduleid ")
		.append(" left join route r on r.id = s.routeid ")
		.append(" left join station st on st.id = ts.departstationid ")
		.append(" where ts.ticketstatus = '0' ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" union all ")
		.append(" select r.name as routename, ts.customerid, ts.ticketno, ts.price ")
		.append(" from ticketsellagent ts ")
		.append(" left join schedule s on s.code = ts.schedulecode and s.isdelete  = 0 ")
		.append(" left join route r on r.id = s.routeid ")
		.append(" left join station st on st.id = ts.departstationid ")
		.append(" where ts.ticketstatus = '0' ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" ) t left join customer c on c.id = t.customerid ")
		.append(" where t.customerid is not null ")
		.append(" group by "+ (isgroupbyroute==true? "t.routename," : "") +"(c.name,c.certificateno,t.customerid)) ")
		.append(groupby == 0? " order by ticketnum desc) " : " order by totalprice desc) ");
		// 取前多少名数据
		String top = "";
		switch (groupbywhat){
			case 0: top="10"; break;
			case 1: top="20"; break;
			case 2: top="50"; break;
			case 3: top="100"; break;
		}
		sql.append("".equals(top) ? "" : " where rownum <= "+top);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
