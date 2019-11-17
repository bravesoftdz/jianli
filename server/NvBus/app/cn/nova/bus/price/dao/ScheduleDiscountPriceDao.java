package cn.nova.bus.price.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.ScheduleDiscountPrice;

@SuppressWarnings("rawtypes")
public class ScheduleDiscountPriceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select id,scheduleid,startdate,enddate,departstationid,reachstationid,price,salenum,orgid,createtime,createby,updatetime,updateby,referenceprice from ScheduleDiscountPrice where scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<ScheduleDiscountPrice> query(long scheduleid,long departstationid, long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select id,scheduleid,startdate,enddate,departstationid,reachstationid,price,salenum,orgid,createtime,createby,updatetime,updateby,referenceprice from ScheduleDiscountPrice where scheduleid=:scheduleid and departstationid=:departstationid and reachstationid=:reachstationid");
		Query query = getEntityManager().createNativeQuery(sql.toString(),ScheduleDiscountPrice.class);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public boolean delSchDiscountPrice(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"delete from ScheduleDiscountPrice where scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.executeUpdate()>0;
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(long routeid, long scheduleid) {
//		StringBuilder sql = new StringBuilder(
//				"SELECT s.id id, s.scheduleid scheduleid, s.startdate startdate, s.enddate enddate, rt.startstationid departstationid, r.stationid reachstationid, s.price price, s.salenum salenum,s.orgid orgid,s.createtime createtime,s.createby createby,s.updatetime updatetime,s.updateby updateby FROM route rt LEFT JOIN routestop r ON rt.id = r.routeid LEFT JOIN schedulediscountprice s ON r.stationid = s.reachstationid LEFT JOIN SCHEDULE sch ON r.routeid = sch.routeid WHERE r.orderno != 0 AND sch.id =:scheduleid");
		StringBuilder sql = new StringBuilder(
				"SELECT s.id id, s.scheduleid scheduleid, s.startdate startdate, s.enddate enddate, ( SELECT stationid FROM routestop WHERE routeid IN ( SELECT routeid FROM SCHEDULE WHERE id = :scheduleid ) AND orderno = 0 ) departstationid, r.stationid reachstationid, s.price price, s.salenum salenum, s.orgid orgid, s.createtime createtime, s.createby createby, s.updatetime updatetime, s.updateby updateby,s.referenceprice referenceprice FROM ( SELECT stationid, orderno FROM routestop WHERE routeid IN ( SELECT routeid FROM SCHEDULE WHERE id = :scheduleid ) AND orderno != 0 ) r LEFT JOIN ( SELECT * FROM schedulediscountprice WHERE scheduleid = :scheduleid OR scheduleid IS NULL ) s ON r.stationid = s.reachstationid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> queryStation(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select id,name from station where id in(select r.stationid from routestop r,schedule s  where s.id=:scheduleid and s.routeid=r.routeid)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> querySchedule(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select id from schedule where routeid in (select routeid from  schedule where id=:scheduleid ) and isactive=1");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> findScheduleDiscountPrice(long scheduleid,
			long departstationid, long reachstationid) {
		
		StringBuilder sql = new StringBuilder("select id,scheduleid,startdate,enddate,departstationid,reachstationid,price,salenum,orgid,createtime,createby,updatetime,updateby,referenceprice from schedulediscountprice   ")
		.append(" where scheduleid=:scheduleid and departstationid=:departstationid and reachstationid=:reachstationid ");						
		Query query = getEntityManager().createNativeQuery(sql.toString(),ScheduleDiscountPrice.class);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);						
		return query.getResultList();
	}
	
	public boolean isExistRoutePrice(Long scheduleid,Long departstationid,Long reachstationid){
		StringBuilder sql = new StringBuilder("select id,scheduleid,startdate,enddate,departstationid,reachstationid,price,salenum,orgid,createtime,createby,updatetime,updateby,referenceprice from schedulediscountprice where departstationid = :departstationid ")
		.append(" and reachstationid = :reachstationid and scheduleid = :scheduleid ");
		Query query = getEntityManager().createNativeQuery(sql.toString(), ScheduleDiscountPrice.class);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("scheduleid", scheduleid);
		List list = query.getResultList();
		return list != null && list.size() > 0;
	}
	
	
}
