/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>QueryAdvanceTicketDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-4-11  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>接口描述：</b>预售票情况查询月报表<br/>
 * <b>接口名称：</b>QueryAdvanceTicketDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b> <br/>
 * <b>关键修改：</b>整个查询语句都修改<br/>
 * <b>修改时间：</b>2012-4-11 <br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/> 
 *  <b>关键修改：</b>增加售票点、线路查询条件以及按线路分组<br/>
 * <b>修改时间：</b>2012-12-11 <br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 */
@SuppressWarnings("rawtypes")
public class QueryAdvanceTicketDao extends EntityManagerDaoSurport {	
	@SuppressWarnings("unchecked")
	public List<Object> queryAdvanceTicket(String orgid,Long sellid,
			Date startdate, Date enddate,Long routeid,Long tosid,Boolean isgroupbyroute,Date dptstartdate, Date dptenddate) {	
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String Date_b = format.format(startdate);
		String Date_e= format.format(enddate);
		
		StringBuffer sql = new StringBuffer("select sr.orgname,sr.selldate,");
		if (isgroupbyroute){
			sql.append(" sr.routename ,");
		}else{
			sql.append(" 0 as routename,");
		}
		sql.append("nvl2(sr.sellcount+so.sellagentcount,sr.sellcount+so.sellagentcount,sr.sellcount) sellcount,")
		.append("nvl2(sr.sellprice+so.sellagentprice,sr.sellprice+so.sellagentprice,sr.sellprice) sellprice,")
		.append("nvl2(sr.returncount+so.returnagentcount,sr.returncount+so.returnagentcount,nvl2(sr.returncount,sr.returncount,0)) returncount,")
		.append("nvl2(sr.returnprice+so.returnagentprice,sr.returnprice+so.returnagentprice,nvl2(sr.returnprice,sr.returnprice,0)) returnprice,")
		.append("nvl2(sr.charges+so.agentcharges,sr.charges+so.agentcharges,nvl2(sr.charges,sr.charges,0)) charges,")
		.append(" nvl2(ck.checkcount,ck.checkcount,0) checkcount,")
		.append(" nvl2(ck.ckprice,ck.ckprice,0) ckprice,")
		.append(" nvl2(ck.stationservicefee,ck.stationservicefee,0) stationservicefee,")
		.append(" nvl2(ck.computefee,ck.computefee,0) computefee,")
		.append(" nvl2(ck.coolairfee,ck.coolairfee,0) coolairfee,")
		.append(" nvl2(ck.additionfee,ck.additionfee,0) additionfee")
		.append(" from (select o.name orgname, to_date(ts.selltime) selldate,");
		if (isgroupbyroute){
			sql.append(" r.name routename ,");
		}
		sql.append(" count(ts.id) sellcount,sum(ts.price) sellprice,")
		.append(" count(tr.id) returncount,sum(tr.returnamount) returnprice,")
		.append(" sum(tr.charges) charges")
		.append(" from organization o, ticketsell ts")
        .append(" left join ticketreturn tr on tr.sellid = ts.id")
        .append(" ,schedule s, route r")//退票；在查询的售票日期内，查询 退预售票信息
        .append(" where ts.scheduleid= s.id and s.routeid = r.id and  ts.orgid = o.id and to_date(ts.selltime) < ts.departdate");
		 if(routeid != null && routeid>0){
	        	sql.append(" and r.id = "+routeid);
	        }
        sql.append(" and ts.selltime between to_date('"+Date_b+"','yyyy-mm-dd hh24:mi:ss') ")
        .append(" and to_date('"+Date_e+"','yyyy-mm-dd hh24:mi:ss') and ts.orgid in "+orgid );
        
        if(dptstartdate!=null && dptenddate!=null){
        	String Date_dptb = format.format(dptstartdate);
    		String Date_dpte= format.format(dptenddate);	
        	sql.append(" and ts.departdate between to_date('"+Date_dptb+"','yyyy-mm-dd hh24:mi:ss') ")
            .append(" and to_date('"+Date_dpte+"','yyyy-mm-dd hh24:mi:ss') " );
        }
		if (tosid!=null && tosid >0){
			sql.append(" and ts.ticketoutletsid ="+tosid);
		}
		if(sellid!=null){
			sql.append(" and ts.sellby = "+sellid);
		}
		if (isgroupbyroute){
			sql.append(" group by o.name, to_date(ts.selltime),r.name) sr");
		}else{
			sql.append(" group by o.name, to_date(ts.selltime)) sr");
		}
        
        sql.append(" left join (select o.name orgname,")
        .append(" to_date(ts.selltime) selldate,")
        .append(" count(ts.id) sellagentcount,")
    	.append(" sum(ts.price) sellagentprice,")
    	.append(" count(tr.id) returnagentcount,")
    	.append(" sum(tr.returnamount) returnagentprice,")
    	.append(" sum(tr.charges) agentcharges")
    	.append(" from organization o, userinfo sby, ticketsellagent ts")
    	.append(" left join ticketreturn tr on tr.sellid = ts.id")
        .append(" and tr.isselfschedule = 0")
        .append(" where sby.orgid = o.id and ts.sellby = sby.id")
   		.append(" and to_date(ts.selltime) < ts.departdate")
   		.append(" and ts.selltime between to_date('"+Date_b+"', 'yyyy-mm-dd hh24:mi:ss') and")
   		.append(" to_date('"+Date_e+"', 'yyyy-mm-dd hh24:mi:ss') and sby.orgid in "+orgid);
		if(sellid!=null){
			sql.append(" and ts.sellby = "+sellid);
		}
		if (tosid!=null && tosid >0){
			sql.append(" and ts.ticketoutletsid ="+tosid);
		}
        sql.append(" group by o.name, to_date(ts.selltime)) so on sr.orgname= so.orgname and sr.selldate = so.selldate")
        .append(" left join (select o.name as orgname,to_date(ts.checktime) checkdate,");
        if (isgroupbyroute){
			sql.append("  r.name routename, ");
		}
        sql.append(" count(ts.id) checkcount,sum(ts.price) ckprice,") //查询检票信息；在查询的售票日期内被检的预售票信息
        .append(" sum(ts.stationservicefee) stationservicefee,")
        .append(" sum(ts.computefee) computefee,")
        .append(" sum(ts.coolairfee) coolairfee,")
        .append(" sum(ts.additionfee) additionfee")
        .append(" from ticketsell ts, organization o")
        .append(" ,schedule s, route r")
        .append(" where ts.ischecked = 1 and ts.orgid = o.id")
        .append(" and to_date(ts.selltime) < ts.departdate ")
        .append(" and ts.scheduleid= s.id and s.routeid = r.id");
        if(routeid != null && routeid>0){
        	sql.append(" and r.id = "+routeid);
        }
        if (tosid!=null && tosid >0){
			sql.append(" and ts.ticketoutletsid ="+tosid);
		}
        sql.append(" and ts.selltime between to_date('"+Date_b+"','yyyy-mm-dd hh24:mi:ss')")
        .append(" and to_date('"+Date_e+"','yyyy-mm-dd hh24:mi:ss') and ts.orgid in "+orgid );
        if(dptstartdate!=null && dptenddate!=null){
        	String Date_dptb = format.format(dptstartdate);
    		String Date_dpte= format.format(dptenddate);	
        	sql.append(" and ts.departdate between to_date('"+Date_dptb+"','yyyy-mm-dd hh24:mi:ss') ")
            .append(" and to_date('"+Date_dpte+"','yyyy-mm-dd hh24:mi:ss') " );
        }  
        if (isgroupbyroute){
            sql.append(" group by o.name, to_date(ts.checktime),r.name) ck ")
            .append(" on sr.orgname =ck.orgname  and sr.selldate =ck.checkdate ")
			.append(" and sr.routename =ck.routename ");
		}else{
			   sql.append(" group by o.name, to_date(ts.checktime)) ck ")
	            .append(" on sr.orgname =ck.orgname  and sr.selldate =ck.checkdate");
		}
        sql.append(" order by sr.selldate desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
}
