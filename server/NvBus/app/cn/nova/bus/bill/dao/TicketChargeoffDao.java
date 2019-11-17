package cn.nova.bus.bill.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：票据核销</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:huagnhaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-8-19 下午	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")

public class TicketChargeoffDao extends EntityManagerDaoSurport{

	/**
	 * 退票，废票，改签票 的票证核销情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryReturnCancleticket(String orgid,Long userid,Date begindate,Date enddate) {
		StringBuilder sql = new StringBuilder(
				"select o.name orgname,u.name username,u.id userid,o.id orgid,ts.ticketno,")
		.append("case when t.returnway = 3 then trim('改签') else trim('退票') end tickettype,")
		.append("t.returntime actiontime,case when tco.ticketno is null then trim('未核销') else trim('已核销') end as chargestatus,")
		.append("uc.name chargername,tco.chargetime,ts.fullprice,s.name stationname ")
		.append(" from userinfo u, organization o, ")
		.append("ticketreturn t,station s,ticketsell ts left join ticketchargeoff tco left join userinfo uc")
		.append(" on tco.chargerby = uc.id on tco.ticketno = ts.ticketno")
		.append(" where t.sellid = ts.id and t.returnby = u.id and u.orgid = o.id and ts.reachstationid=s.id")
		.append(" and o.id in "+orgid+" and t.returntime between :begindate and :enddate+0.99999 ");
		if(userid!=null){
			sql.append(" and u.id = "+userid); 
		}
		//sql.append(" order by o.name ,ts.ticketno  " )
		sql.append(" union all ")
		.append(" select o.name orgname,u.name username,u.id userid,o.id orgid,ts.ticketno,trim('废票') tickettype,")
		.append("t.canceltime actiontime,case when tco.ticketno is null then trim('未核销') else trim('已核销') end as chargestatus,")
		.append("uc.name chargername,tco.chargetime,ts.fullprice,s.name stationname ")
		.append(" from userinfo u, organization o, ticketcancel t,station s, ticketsell ts")
		.append(" left join ticketchargeoff tco left join userinfo uc on tco.chargerby = uc.id on")
		.append(" tco.ticketno = ts.ticketno where t.sellid = ts.id and t.cancelby = u.id and u.orgid = o.id ")
		.append(" and o.id in "+orgid+" and t.createtime between :begindate and :enddate+0.99999  and ts.reachstationid=s.id ");
		if(userid!=null){
			sql.append(" and u.id = "+userid); 
		}
		//sql.append(" order by o.name ,ts.ticketno ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("begindate", begindate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
		
	}
	
	/**
	 * 坏票登记 的 票证查询,查出开始票号和结束票号，遍历出每张票，再关联查询核销表
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querybilldamaged(String orgid,Long userid,Date begindate,Date enddate) {
		StringBuilder sql = new StringBuilder(
				"select u.id userid,o.id orgid,t.startno,")
		.append("t.endno ,t.recordtime  actiontime")
		.append(" from userinfo u, organization o, billdamaged t, billtype b")
		.append(" where t.recordby  = u.id and u.orgid = o.id and t.billtypeid = b.id and b.name like '车票' ")
		.append(" and o.id in "+orgid+" and t.recordtime between :begindate and :enddate ");
		if(userid!=null){
			sql.append(" and u.id = "+userid); 
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("begindate", begindate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	

	/**
	 * 根据用户ID，票号，查询票据核销表
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketChargeoff(String orgid,String userid,long ticketno,Date actiondate) {
		StringBuilder sql = new StringBuilder(				
				"select o.name orgname,u.name username,u.id userid,o.id orgid,"+ticketno+" ticketno,")
		.append("trim('坏票') tickettype, trim('"+actiondate+"') actiontime,")
		.append("case when tco.ticketno is null then trim('未核销') else trim('已核销') end as chargestatus,")
		.append("uc.name chargername,tco.chargetime,0 fullprice,'' stationname")
		.append(" from organization o,")
		.append(" userinfo u left join ticketchargeoff tco")
		.append(" left join userinfo uc on tco.chargerby = uc.id")
		.append(" on u.id =  tco.sellerid and tco.ticketno = "+ticketno)
		.append(" where  o.id = u.orgid and  u.id= "+userid+" and o.id = "+orgid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
}
