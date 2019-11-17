package cn.nova.bus.price.dao;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Ticketoutletstypeprice;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class RoutePriceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> qryRoutePrices(long routeid) {
		StringBuilder sql = new StringBuilder(
				"select rp.id, rp.price, rp.balanceprice, rp.fromdate, rp.todate, rp.createtime, rp.createby, rp.updatetime, rp.updateby,")
				.append(" rp.routeid, rp.fromstationid, rp.reachstationid, rp.orgid, rp.isbaseprice, s1.name as fromstationname, ")
				.append(" s2.name as reachstationname,0 isselect from Routeprice rp,")
				.append(" Station s1, Station s2, Organization o where rp.fromstationid = s1.id and rp.reachstationid")
				.append(" =s2.id and s1.orgid = o.id and routeid = :routeid")
				.append(" order by rp.isbaseprice desc , fromdate,s2.distance");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	
	public List<Object> qryAndMakeRoutePrices(long routeid) {
		StringBuilder sql = new StringBuilder("select 0 as id, 0 as price, 0 as balanceprice, sysdate as fromdate, ")
			.append(" to_Date('9999-12-12','yyyy-MM-dd') as todate,")
			.append(" sysdate as createtime, 0 as createby , sysdate as updatetime,")
			.append(" 0 as updateby, rs1.routeid, s1.id as fromstationid, s2.id as reachstationid, r.orgid, 1 as isbaseprice, ")
			.append(" s1.name as fromstationname, s2.name as reachstationname")
			.append(" from Routestop rs1, Routestop rs2, Station s1, Station s2, Route r where ")
			.append(" rs1.stationid = s1.id and rs2.stationid = s2.id and rs1.routeid = rs2.routeid")
			.append(" and rs1.isdepart = 1 and rs2.isdepart = 0 and rs1.isactive = 1")
			.append(" and rs1.routeid = r.id and rs2.routeid = r.id and rs2.isactive=1 and rs1.routeid = :routeid")
			.append(" order by rs1.orderno,rs2.orderno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();		
	}
	
	public int delRouteprice(String ids){
		StringBuilder sql = new StringBuilder(
				"delete from Routeprice rs where rs.id in (").append(ids).append(")");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.executeUpdate();		
	}
	
	public List<Routeprice> getBaseRoutePrice(long routeid,long stationid){ 
		String sql = "select r from Routeprice r where r.routeid = :routeid and r.isbaseprice = 1 and r.reachstationid=:stationid";
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		query.setParameter("routeid", routeid);
		query.setParameter("stationid", stationid);
		return query.getResultList();	
	}
	
	public List<Routeprice> getBaseRoutePrice(long routeid){ 
		String sql = "select r from Routeprice r where r.routeid = :routeid and r.isbaseprice = 1";
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		query.setParameter("routeid", routeid);
		return query.getResultList();	
	}
	
	public List<Object> qryRoutestop(long routeid,boolean isdepart){ 
		StringBuilder sql = new StringBuilder("select s.id,s.name,s.helpcode from Routestop r,Station s ")
		 .append(" where r.routeid = :routeid and r.isdepart=:isdepart and r.stationid=s.id and r.isactive=1");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("isdepart", isdepart);
		return query.getResultList();	
	}
	
	public boolean isExistRoutePrice(Long routeid,Long fromstationid,Long reachstationid,
			Date fromdate,Date todate,boolean isbaseprice){
		StringBuilder sql = new StringBuilder("select r from Routeprice r where r.fromstationid = :fromstationid and r.reachstationid = :reachstationid and r.routeid = :routeid and r.isbaseprice = 0 ")
		.append(" and r.isbaseprice =:isbaseprice and ((r.fromdate>=:fromdate and r.fromdate<=:todate) ")
		.append(" or (r.fromdate<=:fromdate and r.todate>=:todate)")
		.append(" or (r.fromdate<=:fromdate and r.todate>=:fromdate)")
		.append(" or (r.fromdate>=:fromdate and r.todate<=:todate))");
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		query.setParameter("routeid", routeid);
		query.setParameter("fromstationid", fromstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("isbaseprice", isbaseprice);		
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		List list = query.getResultList();
		return list != null && list.size() > 0;
	}
	public boolean isExistRoutePrice(Long routeid,Long fromstationid,Long reachstationid,boolean isbaseprice){
		StringBuilder sql = new StringBuilder("select r from Routeprice r where r.fromstationid = :fromstationid ")
		.append(" and r.reachstationid = :reachstationid and r.routeid = :routeid and r.isbaseprice =:isbaseprice");
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		query.setParameter("routeid", routeid);
		query.setParameter("fromstationid", fromstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("isbaseprice", isbaseprice);		
		List list = query.getResultList();
		return list != null && list.size() > 0;
	}
	public Routeprice getBaseRoutePrice(String routeid,Long fromstationid,Long reachstationid,Date fromdate){
		String sql = "select r from Routeprice r where r.fromstationid = :fromstationid and r.reachstationid = :reachstationid and r.routeid = :routeid and r.todate > :todate and r.isbaseprice = 1";
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		query.setParameter("routeid", routeid);
		query.setParameter("fromstationid", fromstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("todate", fromdate);
		List<Routeprice> list = query.getResultList();
		return list.size() == 0 ? null : list.get(0);		
	}
	
	@SuppressWarnings("unchecked")
	public List<Routeprice> qryRoutePricesForDepartinvoices(long routeid) {
		StringBuilder sql = new StringBuilder(
				"select rp.id, rp.price, rp.balanceprice, rp.fromdate, rp.todate, rp.createtime, rp.createby, rp.updatetime, rp.updateby,")
				.append(" rp.routeid, rp.fromstationid, rp.reachstationid, rp.orgid, rp.isbaseprice, s1.name as fromstationname, ")
				.append(" s2.name as reachstationname,0 isselect from Routeprice rp,")
				.append(" Station s1, Station s2, Organization o where rp.fromstationid = s1.id and rp.reachstationid")
				.append(" =s2.id and s1.orgid = o.id and routeid = :routeid")
				.append(" order by rp.isbaseprice desc , fromdate,s2.distance");
		Query query = getEntityManager().createNativeQuery(sql.toString(),Routeprice.class);
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	
	public List<Ticketprice> qryTicketprice(long routeid,Date departdate){
		StringBuilder sql = new StringBuilder(
		"select t from Ticketprice t,Schedule s")
		.append(" where t.scheduleid=s.id and t.departdate=:departdate")
		.append(" and s.route.id=:routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}
	
	public Date qryMaxTicketpricedepart(long routeid ,Date departdate){
		StringBuilder sql = new StringBuilder(
		"select max(t.departdate) from Ticketprice t,Schedule s")
		.append(" where t.scheduleid=s.id and t.departdate>=:departdate")
		.append(" and s.route.id=:routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("departdate", departdate);
		List<Object> list= query.getResultList();
		return (Date) (list!=null&&list.size()>0?list.get(0):departdate);
	}

	public long isexitprice(long routeid) {
		StringBuilder sql = new StringBuilder();
		if (routeid != 0) {
			sql.append("SELECT sum(rp.price) FROM routeprice rp where rp.routeid = "
					+ routeid);
			Query query = getEntityManager().createNativeQuery(sql.toString());
			List list = query.getResultList();
			if (list == null) {
				return (Long) (list.size() == 0 ? null : list.get(0));
			} else {
				return 0;
			}
		} else {
			return 0;
		}
	}

	public List<Object> queryRouteprice(long routeid) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				"select s1.name fromstationname, s2.name reachstationname, rp.price, rp.balanceprice ,rp.fromstationid, rp.reachstationid,0 as stationfee,trunc(rp.price/2)")
				.append(" from Routeprice rp, Station s1, Station s2 where rp.fromstationid = s1.id   and rp.reachstationid = s2.id")
				.append(" and rp.routeid = " + routeid)
				.append(" order by rp.isbaseprice desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();

	}

	public List<Object> queryHardprice(long scheduleid,String departdate) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				" SELECT  s1.name fromstationname, s2.name reachstationname, hp.fullprice price, 0 balanceprice,hp.departstationid fromstationid , hp.reachstationid ,0 as stationfee,hp.halfprice ")
				.append(" FROM handprice hp, station s1, station s2  where hp.departstationid = s1.id    and hp.reachstationid = s2.id ")
				.append("  and hp.scheduleid = " + scheduleid)
				.append(" order by hp.vehicletypeid  desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();

	}
	public List<Object> queryTicketprice(long scheduleid,String departdate) {
		StringBuilder sql = new StringBuilder();
		departdate = departdate.split(" ")[0];
		sql.append(" select s1.name fromstationname, s2.name reachstationname, ")
		.append("  tp.fullprice price, 0 balanceprice,tp.departstationid fromstationid ")
		.append(" , tp.reachstationid reachstationid,tpi.price as stationfee,tp.halfprice ")
		.append(" from ticketprice tp left join ticketpriceitem tpi on tp.id=tpi.ticketpriceid ")
		.append(" left join ticketpriceformulaitem tpf  on tpi.ticketpriceformulaitemid = tpf.id  ")
		.append(",station s1, station s2  where tp.departstationid=s1.id and tp.reachstationid=s2.id ")
		.append(" and tpi.tickettype = 'Q' and tpf.code='C' and tpf.isactive='1' ")
		.append("  and tp.scheduleid =" + scheduleid)
		.append(" and tp.departdate = date'"+departdate+"'")
		.append(" order by tp.fullprice ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();

	}
//	@SuppressWarnings("unchecked")
//	public List<Routeprice> qryRoutePricesForDepartinvoices(long routeid,Date departdate) {
//		StringBuilder sql1 = new StringBuilder(
//				"select rp.id, rp.price, rp.balanceprice, rp.fromdate, rp.todate, rp.createtime, rp.createby, rp.updatetime, rp.updateby,")
//				.append(" rp.routeid, rp.fromstationid, rp.reachstationid, rp.orgid, rp.isbaseprice, s1.name as fromstationname, ")
//				.append(" s2.name as reachstationname,0 isselect from Routeprice rp,")
//				.append(" Station s1, Station s2, Organization o where rp.fromstationid = s1.id and rp.reachstationid")
//				.append(" =s2.id and s1.orgid = o.id and routeid = :routeid")
//				.append(" and :departdate between rp.fromdate and rp.todate  and rp.isbaseprice=0 ")
//				.append(" and rp.fromdate=(select min(t.fromdate) from  Routeprice t where t.routeid=rp.routeid and t.isbaseprice=0)")
//				.append(" order by rp.price, fromdate,s2.distance");
//		Query query1 = getEntityManager().createNativeQuery(sql1.toString(),Routeprice.class);
//		query1.setParameter("routeid", routeid);
//		query1.setParameter("departdate", departdate);
//		if(query1.getResultList()==null){
//			StringBuilder sql = new StringBuilder(
//					"select rp.id, rp.price, rp.balanceprice, rp.fromdate, rp.todate, rp.createtime, rp.createby, rp.updatetime, rp.updateby,")
//					.append(" rp.routeid, rp.fromstationid, rp.reachstationid, rp.orgid, rp.isbaseprice, s1.name as fromstationname, ")
//					.append(" s2.name as reachstationname,0 isselect from Routeprice rp,")
//					.append(" Station s1, Station s2, Organization o where rp.fromstationid = s1.id and rp.reachstationid")
//					.append(" =s2.id and s1.orgid = o.id and routeid = :routeid")
//					.append(" and :departdate between rp.fromdate and rp.todate  and rp.isbaseprice=1")
//					.append(" order by rp.price, fromdate,s2.distance");
//			Query query = getEntityManager().createNativeQuery(sql.toString(),Routeprice.class);
//			query.setParameter("routeid", routeid);
//			query.setParameter("departdate", departdate);
//			return query.getResultList();
//		}else{
//			return query1.getResultList();
//		}
//	}
	/**
	 * 查询分段票价
	 * @param routeid
	 * @param todate 
	 * @param fromdate 
	 * @return
	 */
	public List<Routeprice> qryOtherRoutePrices(long routeid, Date fromdate, Date todate,long reachstationid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select r from Routeprice r where r.routeid = :routeid and r.isbaseprice = 0 ")
				.append("and ((r.fromdate >= :fromdate and r.fromdate <= :todate) ")
				.append("or (r.todate >= :fromdate and r.todate <= :todate) ")
				.append("or (r.fromdate <= :fromdate and r.todate >= :todate) ")
				.append("or (r.fromdate >= :fromdate and r.todate <= :todate)) ")
				.append(" and r.reachstationid= :reachstationid");
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		query.setParameter("routeid", routeid);
		query.setParameter("fromdate", fromdate);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("todate", todate);
		List list = query.getResultList();
		return query.getResultList();	
	}

	public List<Object> qryTicketoutletstypeprice(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.id,o.name as orgname,tol.name as ticketoutletname, r.name as routename, s.code as schedulecode, ")
		.append(" t.fullpriceformula,t.halfpriceformula,t.studentpriceformula,t.startdate as startdate,t.enddate as enddate, ")
		.append(" u1.name as createby,  to_char(t.createtime,'yyyy-mm-dd HH12:MI:SS'), u2.name as updateby, to_char(t.updatetime,'yyyy-mm-dd HH12:MI:SS') from ticketoutletstypeprice t ")
		.append(" left join ticketoutlets tol on tol.id = t.ticketoutletsid ")
		.append(" left join organization o on o.id = tol.orgid ")
		.append(" left join route r on r.id =t.routeid ")
		.append(" left join schedule s on s.id = t.scheduleid ")
		.append(" left join userinfo u1 on u1.id = t.createby ")
		.append(" left join userinfo u2 on u2.id = t.updateby  where 1=1 ")
		.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List list = query.getResultList();
		return list;	
	}
	
	public boolean checkisexists(Ticketoutletstypeprice t) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(t.id) from ticketoutletstypeprice t where  1=1 ")
		.append(" and (t.startdate between :startdate and :enddate or t.enddate between :startdate and :enddate)  ")
		.append(" and t.ticketoutletsid = :ticketoutletsid and t.routeid = :routeid and t.scheduleid = :scheduleid and t.id <> :id  ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketoutletsid", t.getTicketoutletsid());
		query.setParameter("routeid", t.getRouteid());
		query.setParameter("scheduleid", t.getScheduleid());
		query.setParameter("startdate", t.getStartdate());
		query.setParameter("enddate", t.getEnddate());
		query.setParameter("id", t.getId());
		List list = query.getResultList();
		BigDecimal result = (BigDecimal) list.get(0);
		return result.compareTo(BigDecimal.ZERO)>0 ? true:false;
	}
}

