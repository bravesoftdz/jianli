package cn.nova.bus.base.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedulestationcontrol;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * 班次站点售票控制
 * 班线售票,可控制时间、站点售票数，对每条线路的每个站点是否开放售票或限制售票进行批量处理
 * @author hhz 20131008
 *
 */
@SuppressWarnings("rawtypes")
public class SchedulestationcontrolDao  extends EntityManagerDaoSurport {

	/*
	 * 查询已控制的线路站点信息
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findSchedulestationcontrolList(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				 "select o.name as departorgname,r.name as routename,s.name as stationname,")
		.append(" sst.cansellnum,sst.canselltime,cr.name as createtname , ur.name as updtename,")
		.append(" sst.createtime,sst.updatetime,sst.id,sst.routeid,sst.updateby,sst.createby,sst.stationid,o.id as departorgid ")
		.append(" from Schedulestationcontrol sst ,Route r ,Station s,Organization o,Userinfo cr,Userinfo ur,Routestop rs")
		.append(" where sst.routeid = r.id and sst.stationid=s.id and sst.departorgid = o.id")
		.append(" and rs.route.id=r.id and rs.stationid=sst.stationid and rs.orderno>0 ")
		.append(" and sst.createby = cr.id and sst.updateby= ur.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by r.name,rs.orderno,sst.updatetime desc,o.name " );
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
 		return query.getResultList();
	}
	
	/*
	 * 查询线路停靠点
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findControlroutestation(List<PropertyFilter> propertyFilterList){
		StringBuilder sql = new StringBuilder(
				"select sst.id, r.id routeid,rs.stationid,r.name routename,st.name stationname,sst.cansellnum,sst.canselltime,")
		.append(" (case when sst.stationid is not null then 1 else 0 end ) isselect")
		.append(" from organization o ,route r,station st,")
		.append(" routestop rs left join Schedulestationcontrol sst on sst.stationid=rs.stationid and sst.routeid = rs.routeid")
		.append(" where o.id = r.orgid and r.id=rs.routeid and rs.stationid=st.id and rs.orderno>0 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by rs.orderno");		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
 		return query.getResultList();
	}
	
	/*
	 * 删除线路站点控制，直接删除指定记录
	 */
	public Boolean delSchedulestationcontrol(long departorgid,long routeid,long stationid){
		String sql="delete from Schedulestationcontrol sc "+
		 	"where sc.departorgid = "+departorgid+" and sc.routeid = "+routeid;
		if(stationid!=0 ){
			sql=sql+" and sc.stationid = "+stationid;
		}
		int result = super.execute(sql);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}		
	
	/*
	 * 查询线路停靠点
	 */
	public long findControlId(long departorgid,long routeid,long stationid){
		String sql = "select t.id from Schedulestationcontrol t where 1 = 1 ";
		if(departorgid>0){
			sql =sql+" and t.departorgid = "+departorgid;
		}
		if (routeid >0) {
			sql = sql + " and t.routeid = " + routeid ;
		} 
		if (stationid>0 ) {
			sql = sql + " and t.stationid = " + stationid;
		} 
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return  0;
		}
		return (Long) query.getSingleResult();
	}
	
	public Schedulestationcontrol getSchedulestationcontrol(long routeid,
			long stationid) {
		Map<String, Object> conditionmap = new HashMap<String, Object>();
		conditionmap.put("routeid", routeid);
		conditionmap.put("stationid", stationid);
		return (Schedulestationcontrol) super.uniqueResult(Schedulestationcontrol.class, conditionmap);
	}
	
}
