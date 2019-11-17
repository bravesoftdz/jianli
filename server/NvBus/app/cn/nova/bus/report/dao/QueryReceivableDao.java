/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>QueryReceivableDao.java<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.query.param.Qryparam;

/**
 * <b>接口描述：</b>网购对账报表<br/>
 * <b>接口名称：</b>QueryReceivableDao.java<br/>
 */
@SuppressWarnings("rawtypes")
public class QueryReceivableDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> queryReceivable(String orgid, Date startdate,
			Date enddate,String orgordate,String sellway,Qryparam qp) {
		
		StringBuffer sql = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String Date_b = format.format(startdate)+" 00:00:00";
		String Date_e = format.format(enddate)+" 23:59:59";
		
		//通过不同的选择条件来判断当前应该按机构汇总还是应该按对账时间汇总
		if ("0".equals(orgordate))                                                                               
		{                                                                                                                                                                                                             
			sql = new StringBuffer("  select name as sellorgname,'',")                                              
			       .append(" sum(sellnum) sellcount, ")                                                             
			       .append(" sum(sellprice) sellprice,")                                                         
			       .append(" sum(stationreturnnum) returncount,")                                                            
			       .append(" sum(stationreturnamount) returnamount,")
			       .append(" sum(stationcharges) returncharge,    ")
			       .append("  sum(sitereturnnum)  returncount1, ")
			       .append("  sum(sitereturnamount) returnamount1,")
			       .append(" sum(sitecharges) charges1  ,  ")
			       .append(" sum(sellprice)- sum(sitereturnamount)-sum(returnwebamount) as dycount")
			       .append(" ,sum(stationservicefee) stationservicefee  ")
			       //20170906增加统计原路返还方式退网售票的退票数、退票金额、退票手续费3个字段
			       .append(" , sum(returnwebnum) as returnwebnum, sum(returnwebamount) as returnwebamount, sum(returnwebcharges) as returnwebcharges ")
			       .append(" from (select org.name, ")
			       .append("     count(ts.id) sellnum,")
			       .append("      sum(ts.price) sellprice,") 
			       .append("0 stationreturnnum,    ")
			       .append(" 0 stationreturnamount,")
			       .append("  0 stationcharges,    ")
			       .append("    0 sitereturnnum,   ")
			       .append("       0 sitereturnamount,")
			       .append("       0 sitecharges   ")
			       .append("  , sum(ts.stationservicefee) stationservicefee ")
			       .append(" , 0 as returnwebnum, 0 as returnwebamount, 0 as returnwebcharges ")
			       .append("   from ticketsell ts, organization org ")
//			       .append("  where ts.sellway in "+sellway+"                ")
			       .append("  , digitaldictionarydetail dd, ticketsellother tso left  join userinfo uf on tso.printby = uf.id ")
			       .append("  left join userticketoutlets utt on uf.id = utt.userinfoid ")
			       .append("  left join ticketoutlets tls on utt.ticketoutletsid = tls.id ")//增加关联售票点
			       .append("where ts.sellway = dd.code and ts.id=tso.ticketsellid and dd.id in ").append(sellway)
			       .append("   and ts.orgid = org.id                ")
			       .append(" and ts.selltime >= to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') ")
			       .append(" and ts.selltime <= to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') ");
			       sql.append(" and ts.orgid in"+orgid);
				    if (qp.getTaketimeSdate() != null) {
						sql.append(" and tso.taketime between :taketimeSdate and :taketimeEdate+0.99999");      //取票日期
					}
				    if (qp.getDepartSdate() != null) {
						sql.append(" and ts.departdate between :departSdate and :departEdate ");               //发车日期
					}
					if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
						sql.append(" and ts.departstationid=" + qp.getDepartstationid());                       //发车站
					}
					if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
						sql.append(" and ts.reachstationid=" + qp.getReachstationid());                        //到达站 
					}
					if (qp.getPrintorgids() != null && !"".equals(qp.getPrintorgids())) {                      //取票点
						sql.append(" and uf.orgid in" + qp.getPrintorgids());
					}
			   	   sql.append(" group by org.name  ")
			       .append("  union all    ")
			       .append("  select org.name,  ")
			       .append("        0 sellnum,  ")
				   .append("       0 sellprice, ")
				   //车站退票情况--车站垫付
				   .append("      sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (nvl(tr.returnfeemode, '0') = '0') and (tr.ticketoutletsid<>ts.ticketoutletsid)) then 1 else 0 end) as stationreturnnum, ")
				   .append("      sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (nvl(tr.returnfeemode, '0') = '0') and (tr.ticketoutletsid<>ts.ticketoutletsid)) then nvl(tr.returnamount, 0) else 0 end) as stationreturnamount,  ")
				   .append("      sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (nvl(tr.returnfeemode, '0') = '0') and (tr.ticketoutletsid<>ts.ticketoutletsid)) then nvl(tr.charges, 0) else 0 end) stationcharges,   ") 
//				   .append("        sum(decode(u.orgid, ts.orgid, 0, 1)) stationreturnnum,  ")
//				   .append("        sum(decode(u.orgid, ts.orgid, 0, tr.returnamount)) stationreturnamount,  ")
//				   .append("         sum(decode(u.orgid, ts.orgid, 0, tr.charges)) stationcharges,   ")
				  /* .append("         sum(decode(u.orgid, ts.orgid, 1, 0)) sitereturnnum,  ")
				   .append("         sum(decode(u.orgid, ts.orgid, tr.returnamount+tr.returnamountweb, 0)) sitereturnamount, ")
				   .append("         sum(decode(u.orgid, ts.orgid, tr.charges+tr.chargesweb, 0)) sitecharges , 0 stationservicefee ")*/
				  .append("  sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.createby = tr.returnby and u.orgid = ts.orgid)) then  1 else  0 end) as sitereturnnum,")
				  .append(" sum(case  when ((ts.sellway = '7' or ts.sellway = '10') and  (tr.createby = tr.returnby and u.orgid = ts.orgid)) then nvl(tr.returnamountweb, 0)+tr.returnamount")
				  .append(" else 0  end) as sitereturnamount,")
				  .append(" sum(case  when ((ts.sellway = '7' or ts.sellway = '10') and (tr.createby = tr.returnby and u.orgid = ts.orgid)) then")
				  .append(" nvl(tr.chargesweb, 0)+tr.charges  else 0 end) as  sitecharges,0 stationservicefee ")
				   
				   //车站退票情况--原路返还
				   .append("         , sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.returnfeemode = '1')) then 1 else 0 end) as returnwebnum, ")
				   .append("         sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.returnfeemode = '1')) then nvl(tr.returnamountweb, 0) else 0 end) as returnwebamount, ")
				   .append("         sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.returnfeemode = '1')) then nvl(tr.chargesweb, 0) else 0 end) as returnwebcharges ")
				   .append("   from ticketsell ts, ticketreturn tr, organization org, userinfo u   ")
//				   .append("  where ts.sellway in "+sellway+" ")
				   .append("  , digitaldictionarydetail dd ,ticketsellother tso left  join userinfo uf on tso.printby = uf.id ")
				   .append("  left join userticketoutlets utt on uf.id = utt.userinfoid ")
			       .append("  left join ticketoutlets tls on utt.ticketoutletsid = tls.id ")//增加关联售票点
				   .append("where ts.sellway = dd.code and ts.id=tso.ticketsellid and dd.id in ").append(sellway)
				   .append("  and ts.id = tr.sellid  ")
				   .append("   and ts.orgid = org.id   ")
				   .append("     and tr.returnby = u.id  ") //and u.orgid = ts.orgid 
				   .append(" and tr.returntime >= to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') ")
			       .append(" and tr.returntime <= to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') ");
//			   	   sql.append(" and sp.departdate between :departSdate and :departEdate ");
			       sql.append(" and ts.orgid in"+orgid);

				    if (qp.getTaketimeSdate() != null) {
						sql.append(" and tso.taketime between :taketimeSdate and :taketimeEdate+0.99999");      //取票日期
					}
				    if (qp.getDepartSdate() != null) {
						sql.append(" and ts.departdate between :departSdate and :departEdate ");                //发车日期
					}
					if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
						sql.append(" and ts.departstationid=" + qp.getDepartstationid());                       //发车站
					}
					if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
						sql.append(" and ts.reachstationid=" + qp.getReachstationid());                        //到达站
					}
					if (qp.getPrintorgids() != null && !"".equals(qp.getPrintorgids())) {                      //取票点
						sql.append(" and uf.orgid in" + qp.getPrintorgids());
					}
					sql.append("  group by org.name  ")				     
				    .append("     union all")
					.append("      select  org.name,")
					.append("            0 as sellnum,")
					.append("            0 as sellprice,")
					.append("            0 as stationreturnnum,")
					.append("            0 as stationreturnamount,")
					.append("            0 as stationcharges,")
					.append("            count(spo.id) as sitereturnnum,")
					.append("            sum(spo.returnfee) as sitereturnamount,")
					.append("            0 as sitecharges,")
					.append("            0 as stationservicefee,")
					.append("            0 as returnwebnum,")
					.append("            0 as returnwebamount,")
					.append("            0 as returnwebcharges ")
					.append("       from  specialorderinfo spo,organization org where org.code=spo.sellorgcode "
							+ " and spo.sellorgcode not in ('BUS365_SEL','BUS365_WEB') ")
					.append(" and spo.returntime >= to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') ")
					.append(" and spo.returntime <= to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') ");
				    if (qp.getDepartSdate() != null) {
						sql.append(" and spo.departdate between :departSdate and :departEdate ");               //发车日期
					}
					sql.append(" group by org.name) ")
					.append("  group by name");
				   
			
			
			/*sql = new StringBuffer(" select t.sellorgname,'',t.sellcount,t.sellprice,t.returncount,t.returnamount,t.returncharge,t.returncount1,t.returnamount1,");
			sql.append("t.charges1,(t.sellprice-t.returnamount1+t.charges1) from ")
			.append(" (SELECT o.name as sellorgname,")
//			.append(" trunc(ts.selltime) as balanceaccountdate,")
			.append(" sum(1) as sellcount,  ")
			.append(" sum(nvl(ts.price,0)) as sellprice,")
			.append(" sum(nvl(case o.type when '2' then (select count(1)  from ticketreturn t1, ticketsell t2, organization t3 where t1.sellid = t2.id  and t2.orgid = t3.id and t3.type = '2' and ts.orgid in "+orgid+") else 0 end,0)) as returncount,")
			.append(" sum(nvl(case o.type when '2' then tr.returnamount  else 0 end,0)) as returnamount,")
			.append(" sum(nvl(case o.type when '2' then tr.charges  else 0 end,0)) as returncharge,")
			.append(" sum(nvl(case  when o.type in( '0','8') then (select count(1)  from ticketreturn t1, ticketsell t2, organization t3 where t1.sellid = t2.id  and t2.orgid = t3.id and t3.type = '2' and ts.orgid not in "+orgid+") else 0 end,0)) as returncount1,")
			.append(" sum(nvl(case o.type when '0' then tr.returnamount when '8' then tr.returnamount else 0 end,0)) as returnamount1,")
			.append(" sum(nvl(case o.type when '0' then tr.charges when '8' then tr.charges else 0 end,0)) as charges1")
			.append(" from ticketsell ts")
			.append(" left join organization o on ts.orgid=o.id")
			.append(" left join ticketreturn tr on tr.sellid = ts.id")
			.append(" where 1=1 and ")
			.append(" ts.orgid in"+orgid)
			.append(" group by o.name)t");*/
		}else
		{
			
			
			sql = new StringBuffer("  select '', trunc(t.selltime) balanceaccountdate,")                                              
		       .append(" sum(sellnum) sellcount, ")                                                             
		       .append(" sum(sellprice) sellprice,")                                                         
		       .append(" sum(stationreturnnum) returncount,")                                                            
		       .append(" sum(stationreturnamount) returnamount,")
		       .append(" sum(stationcharges) returncharge,    ")
		       .append("  sum(sitereturnnum) returncount1,   ")
		       .append("  sum(sitereturnamount) returnamount1,")
		       .append("  sum(sitecharges) charges1,      ")
		       .append(" sum(sellprice)- sum(sitereturnamount)-sum(returnwebamount) as daycount ")
		       .append(" ,sum(stationservicefee) stationservicefee  ")
		       //20170906增加统计原路返还方式退网售票的退票数、退票金额、退票手续费3个字段
			   .append(" , sum(returnwebnum) as returnwebnum, sum(returnwebamount) as returnwebamount, sum(returnwebcharges) as returnwebcharges ")
		       .append("from (select ts.selltime, ")
		       .append("     count(ts.id) sellnum,")
		       .append("      sum(ts.price) sellprice,") 
		       .append("0 stationreturnnum,    ")
		       .append(" 0 stationreturnamount,")
		       .append("  0 stationcharges,    ")
		       .append("    0 sitereturnnum,   ")
		       .append("       0 sitereturnamount,")
		       .append("       0 sitecharges   ")
		       .append("  , sum(ts.stationservicefee) stationservicefee ")
		       .append(" , 0 as returnwebnum, 0 as returnwebamount, 0 as returnwebcharges ")
		       .append("   from ticketsell ts, organization org ")
//		       .append("  where ts.sellway in "+sellway+"                ")
		       .append("  , digitaldictionarydetail dd, ticketsellother tso left  join userinfo uf on tso.printby = uf.id")
		       .append("  left join userticketoutlets utt on uf.id = utt.userinfoid ")
			   .append("  left join ticketoutlets tls on utt.ticketoutletsid = tls.id ")//增加关联售票点
		       .append(" where ts.sellway = dd.code and ts.id=tso.ticketsellid and dd.id in ").append(sellway)
		       .append("   and ts.orgid = org.id                ")
		       .append(" and ts.selltime >= to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') ")
			   .append(" and ts.selltime <= to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') ");
		    sql.append(" and ts.orgid in"+orgid);
				    if (qp.getTaketimeSdate() != null) {
						sql.append(" and tso.taketime between :taketimeSdate and :taketimeEdate+0.99999");      //取票日期
					}
				    if (qp.getDepartSdate() != null) {
						sql.append(" and ts.departdate between :departSdate and :departEdate ");                //发车日期
					}
					if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
						sql.append(" and ts.departstationid=" + qp.getDepartstationid());                       //发车站
					}
					if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
						sql.append(" and ts.reachstationid=" + qp.getReachstationid());                        //到达站 
					}
					if (qp.getPrintorgids() != null && !"".equals(qp.getPrintorgids())) {                      //取票点
						sql.append(" and uf.orgid in" + qp.getPrintorgids());
					}
		   	   sql.append(" group by ts.selltime  ")
		       .append("  union all    ")
		       .append("  select ts.selltime,  ")
		       .append("        0 sellnum,  ")
			   .append("       0 sellprice, ")
			   //车站退票情况--车站垫付
			   .append("      sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (nvl(tr.returnfeemode, '0') = '0') and (tr.ticketoutletsid<>ts.ticketoutletsid)) then 1 else 0 end) as stationreturnnum, ")
			   .append("      sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (nvl(tr.returnfeemode, '0') = '0') and (tr.ticketoutletsid<>ts.ticketoutletsid)) then nvl(tr.returnamount, 0) else 0 end) as stationreturnamount,  ")
			   .append("      sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (nvl(tr.returnfeemode, '0') = '0') and (tr.ticketoutletsid<>ts.ticketoutletsid)) then nvl(tr.returnamount, 0) else 0 end) stationcharges,   ")
//			   .append("        sum(decode(u.orgid, ts.orgid, 0, 1)) stationreturnnum,  ")
//			   .append("        sum(decode(u.orgid, ts.orgid, 0, tr.returnamount)) stationreturnamount,  ")
//			   .append("         sum(decode(u.orgid, ts.orgid, 0, tr.charges)) stationcharges,   ")
			   /*.append("         sum(decode(u.orgid, ts.orgid, 1, 0)) sitereturnnum,  ")
			   .append("         sum(decode(u.orgid, ts.orgid, tr.returnamount+tr.returnamountweb, 0)) sitereturnamount, ")
			   .append("         sum(decode(u.orgid, ts.orgid, tr.charges+tr.chargesweb, 0)) sitecharges , 0 stationservicefee ")
			   */
			   .append("  sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.createby = tr.returnby and u.orgid = ts.orgid)) then  1 else  0 end) as sitereturnnum,")
				  .append(" sum(case  when ((ts.sellway = '7' or ts.sellway = '10') and  (tr.createby = tr.returnby and u.orgid = ts.orgid)) then nvl(tr.returnamountweb, 0)+tr.returnamount")
				  .append(" else 0  end) as sitereturnamount,")
				  .append(" sum(case  when ((ts.sellway = '7' or ts.sellway = '10') and (tr.createby = tr.returnby and u.orgid = ts.orgid)) then")
				  .append(" nvl(tr.chargesweb, 0)+tr.charges  else 0 end) as  sitecharges,0 stationservicefee ")
				   
			   //车站退票情况--原路返还
			   .append("         , sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.returnfeemode = '1')) then 1 else 0 end) as returnwebnum, ")
			   .append("         sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.returnfeemode = '1')) then nvl(tr.returnamountweb, 0) else 0 end) as returnwebamount, ")
			   .append("         sum(case when ((ts.sellway = '7' or ts.sellway = '10') and (tr.returnfeemode = '1')) then nvl(tr.chargesweb, 0) else 0 end) as returnwebcharges ")
			   .append("   from ticketsell ts, ticketreturn tr, organization org, userinfo u   ")
//			   .append("  where ts.sellway in "+sellway+" ")
			   .append("  , digitaldictionarydetail dd, ticketsellother tso left  join userinfo uf on tso.printby = uf.id ")
			   .append("  left join userticketoutlets utt on uf.id = utt.userinfoid ")
			   .append("  left join ticketoutlets tls on utt.ticketoutletsid = tls.id ")//增加关联售票点
			   .append(" where ts.sellway = dd.code and ts.id=tso.ticketsellid and dd.id in ").append(sellway)
			   .append("  and ts.id = tr.sellid  ")
			   .append("   and ts.orgid = org.id   ")
			   .append("     and tr.returnby = u.id    ")//and u.orgid = ts.orgid
			   .append(" and tr.returntime >= to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') ")
			   .append(" and tr.returntime <= to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') ");
			       sql.append(" and ts.orgid in"+orgid);
			  // 	   sql.append(" and sp.departdate between :departSdate and :departEdate ");

			    if (qp.getTaketimeSdate() != null) {
					sql.append(" and tso.taketime between :taketimeSdate and :taketimeEdate+0.99999");      //取票日期
				}
			    if (qp.getDepartSdate() != null) {
					sql.append(" and ts.departdate between :departSdate and :departEdate ");               //发车日期
				}
				if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
					sql.append(" and ts.departstationid=" + qp.getDepartstationid());                       //发车站
				}
				if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
					sql.append(" and ts.reachstationid=" + qp.getReachstationid());                         //到达站 
				}
				if (qp.getPrintorgids() != null && !"".equals(qp.getPrintorgids())) {                       //取票点
					sql.append(" and uf.orgid in" + qp.getPrintorgids());
				}
			    sql.append("  group by ts.selltime ")
			    .append("     union all")
				.append("      select trunc(spo.returntime) as selltime,")
				.append("             0 as sellnum,")
				.append("            0 as sellprice,")
				.append("            0 as stationreturnnum,")
				.append("            0 as stationreturnamount,")
				.append("            0 as stationcharges,")
				.append("            count(spo.id) as sitereturnnum,")
				.append("            sum(spo.returnfee) as sitereturnamount,")
				.append("            0 as sitecharges,")
				.append("            0 as stationservicefee,")
				.append("            0 as returnwebnum,")
				.append("            0 as returnwebamount,")
				.append("            0 as returnwebcharges ")
				.append("       from  specialorderinfo spo where spo.sellorgcode not in ('BUS365_SEL','BUS365_WEB') ")
				.append(" and spo.returntime >= to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') ")
				.append(" and spo.returntime <= to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') ");
			    if (qp.getDepartSdate() != null) {
					sql.append(" and spo.departdate between :departSdate and :departEdate ");               //发车日期
				}
				sql.append(" group by  trunc(spo.returntime) ) t")
			    .append("  group by trunc(t.selltime)");
			/*sql = new StringBuffer(" select '',t.balanceaccountdate,t.sellcount,t.sellprice,t.returncount,t.returnamount,t.returncharge,t.returncount1,t.returnamount1,");
			sql.append("t.charges1,(t.sellprice-t.returnamount1+t.charges1) from ")
			
//			.append(" (SELECT o.name as sellorgname,")
			.append("(select trunc(ts.selltime) as balanceaccountdate,")
			.append(" sum(1) as sellcount,  ")
			.append(" sum(nvl(ts.price,0)) as sellprice,")
			.append(" sum(nvl(case o.type when '2' then 1 else 0 end,0)) as returncount,")
			.append(" sum(nvl(case o.type when '2' then tr.returnamount  else 0 end,0)) as returnamount,")
			.append(" sum(nvl(case o.type when '2' then tr.charges  else 0 end,0)) as returncharge,")
			.append(" sum(nvl(case o.type when '0' then 1 when '8' then 1 else 0 end,0)) as returncount1,")
			.append(" sum(nvl(case o.type when '0' then tr.returnamount when '8' then tr.returnamount else 0 end,0)) as returnamount1,")
			.append(" sum(nvl(case o.type when '0' then tr.charges when '8' then tr.charges else 0 end,0)) as charges1")
			.append(" from ticketsell ts")
			.append(" left join organization o on ts.orgid=o.id")
			.append(" left join ticketreturn tr on tr.sellid = ts.id")
			.append(" where 1=1 and ")
			.append("  ts.selltime between to_date('" + Date_b+ "', 'yyyy-mm-dd hh24:mi:ss') and")
			.append(" to_date('" + Date_e+ "', 'yyyy-mm-dd hh24:mi:ss') ")
			.append(" group by trunc(ts.selltime))t")
			.append(" order by t.balanceaccountdate asc");*/
					
		}
		
		
		/*StringBuffer sql = new StringBuffer(
				"select nvl(tss.selldate,trr.returndate) as balanceaccountdate,");
		
		   	 sql.append(" nvl(tss.sellcount0,0)as sellcount ,")
				.append(" nvl(tss.sellprice0,0)as sellprice,")
				.append(" nvl(trr.returncount0,0)as returncount,")
				.append(" nvl(trr.returnamount0,0)as returnamount,")
				.append(" nvl(trr.returncharge0, 0) as returncharge,")
				.append(" nvl(tss.sellprice0,0)-nvl(trr.returnamount0,0) as daycount")
		        .append(" from (select trunc(ts.selltime) as selldate,")
				.append(" count(*) as sellcount0,")
				.append(" sum(ts.price) as sellprice0")
				.append(" from TICKETSELL ts")
				.append(" where ts.selltime between to_date('" + Date_b
						+ "', 'yyyy-mm-dd hh24:mi:ss') and")
				.append(" to_date('" + Date_e
						+ "', 'yyyy-mm-dd hh24:mi:ss') and ts.orgid in" + orgid)
				.append(" group by trunc(ts.selltime)) tss")
				.append(" full join (select trunc(tr.RETURNTIME) as returndate,")
				.append(" count(*) as returncount0,")
				.append(" sum(tr.returnamount) as returnamount0,")
				.append(" sum(tr.charges) as returncharge0 ")
				.append(" from TICKETRETURN tr,userinfo u")
				.append(" where tr.RETURNTIME between to_date('" + Date_b
						+ "', 'yyyy-mm-dd hh24:mi:ss') and")
				.append(" to_date('" + Date_e + "', 'yyyy-mm-dd hh24:mi:ss')")
				.append(" and tr.returnby=u.id")
				.append(" and u.orgid in"+orgid)
				.append(" group by trunc(tr.RETURNTIME)) trr")
				.append(" on tss.selldate = trr.returndate");
		sql.append(" order by tss.selldate");*/
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if (qp.getDepartSdate() != null) {
		    query.setParameter("departSdate", qp.getDepartSdate());
		    query.setParameter("departEdate", qp.getDepartEdate());
		}
		if (qp.getTaketimeSdate() != null) {
			query.setParameter("taketimeSdate", qp.getTaketimeSdate());
			query.setParameter("taketimeEdate", qp.getTaketimeEdate());
		}
		 
		return query.getResultList();
	}
}
