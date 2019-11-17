/**
 * 
 */
package cn.nova.bus.base.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routeroad;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author ice
 *
 */
@SuppressWarnings("rawtypes")
public class RouteDao extends EntityManagerDaoSurport{
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select r,st.name as startstationname,ste.name as endstationname,o.name as orgname,uc.name as createbyname,uu.name as updatebyname")
		.append(" from Route r,Station st,Station ste,Organization o,Userinfo uc,Userinfo uu ")
		.append(" where r.startstationid = st.id")
		.append(" and r.endstationid = ste.id")
		.append(" and r.orgid = o.id")
		.append(" and r.createby = uc.id")
		.append(" and r.updateby = uu.id");
		propertyFilterList.add(new PropertyFilter("EQB_r!isactive", "true"));
		propertyFilterList.add(new PropertyFilter("EQB_o!isactive", "true"));
		propertyFilterList.add(new PropertyFilter("EQB_st!isactive", "true"));
		propertyFilterList.add(new PropertyFilter("EQB_ste!isactive", "true"));
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Route> queryIgnoreActive(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select r from Route r ")
		.append(" where ")
		.append(PropertyFilter.toJpql(propertyFilterList,false))
		.append(" order by r.code");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	public List<Object> getRoutestop(Route route) {
		StringBuilder sql = new StringBuilder("select rs,st.name as stationname from Routestop rs,Station st ")
		.append(" where rs.stationid=st.id ")
		.append(" and rs.isactive=:isactive ")
		.append(" and rs.route=:route ")
		.append(" order by rs.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("isactive", true);
		query.setParameter("route", route);
		return query.getResultList();
	}
	
	public Routestop getRoutestop(Route route,Long stationid) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("route", route);
		map.put("stationid", stationid);
		List<Routestop> routestops = find(Routestop.class, map);
		return routestops!=null&&routestops.size()>0?routestops.get(0):null;
	}
	
	public List<Routeroad> getRouteroad(Route route) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("route", route);
		return find(Routeroad.class, map,new String[]{"orderno"});
	}

	public byte getMaxRouteroadOrderno(Route route) {
		StringBuilder sql = new StringBuilder("select max(rr.orderno) from Routeroad rr ")
							.append(" where rr.route=:route");
		Query query = this.em.createQuery(sql.toString());
		query.setParameter("route", route);
		Byte maxOrderno = (Byte) query.getSingleResult();
		return (byte) (maxOrderno!=null?maxOrderno+1:0);
	}
	
	public int delRouteprice(long routeid,long stationid){
		StringBuilder sql = new StringBuilder(
				"delete from Routeprice rs where rs.reachstationid=:stationid and rs.routeid=:routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("stationid",stationid);
		query.setParameter("routeid",routeid);
		return query.executeUpdate();		
	}
	public int delSchprice(long routeid,long stationid){
		StringBuilder sql = new StringBuilder(
				"delete Schedulestop rs where rs.stationid=:stationid")
		.append(" and rs.scheduleid in ( select  id from  schedule s where s.routeid=:routeid")
		.append(" )");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("stationid",stationid);
		query.setParameter("routeid",routeid);
		return query.executeUpdate();		
	}
	public List<Routestop> qryRoutestop(long routeid) {
		StringBuilder sql = new StringBuilder("select rs from Routestop rs ")
		.append(" where rs.route.id=:routeid ")
		.append(" order by rs.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	/**
	 * 基础接口-线路信息
	 * @return
	 */
	public List<Object> qryRouteInfo() {
		StringBuilder sql = new StringBuilder("");
		sql.append(" select r.code,r.startstationid,r.endstationid,r.distance,r.highdistance,r.type,r.orgid from     route r");
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Object> qryDepartTemplate(String templatetypename) {
		StringBuilder sql = new StringBuilder("");
		sql.append("select t.id as templateid,t.name as templatename ")
				.append(" from printtemplate t,printtemplatetype pt where t.printtemplatetypeid=pt.id ")
				.append(" and pt.name = :templatetypename ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("templatetypename", templatetypename);
		return query.getResultList();
	}

	public String qryrouteprinttemplatebyid(long scheduleid) {
		StringBuilder sql = new StringBuilder("");
		sql.append("select distinct p.name from route r ")
			.append(" left join schedule s on s.routeid = r.id ")
			.append(" left join printtemplate p on r.printtemplateid = p.id ")
			.append(" where r.printtemplateid <> 0 and s.id = :id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", scheduleid);
		List list = query.getResultList();
		return (String) (list!=null&&list.size()>0&&!"".equals(list.get(0))?list.get(0):"");
	}
}
