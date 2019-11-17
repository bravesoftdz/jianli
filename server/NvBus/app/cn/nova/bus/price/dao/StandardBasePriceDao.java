package cn.nova.bus.price.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.StandardBasePrice;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class StandardBasePriceDao extends EntityManagerDaoSurport {
	public List<Object> query(long routeid) {
		StringBuilder sql = new StringBuilder(
				"select sb.id,sb.routeid routeid,sb.fromstationid fromstationid, ")
				.append(" sb.reachstationid reachstationid, sb.orgid orgid,sb.baseprice,r.name routename,s1.name fromstation, s2.name reachstation,org.name orgname,0 isselect ")
				.append(" from standardBasePrice sb left join route r on sb.routeid=r.id left join  station s1 on sb.fromstationid=s1.id ")
				.append(" left join  station s2 on  sb.reachstationid=s2.id left join organization org on sb.orgid=org.id ")
				.append(" where routeid=:routeid ")
				.append(" order by sb.reachstationid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}

	public int delRouteBaseprice(String ids) {
		StringBuilder sql = new StringBuilder(
				"delete from StandardBasePrice rs where rs.id in (").append(ids).append(")");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.executeUpdate();
		
	}

	public StandardBasePrice getStandardBasePrice(Routeprice r){
		StringBuilder sql=new StringBuilder("select sb from StandardBasePrice sb where sb.routeid=:routeid and sb.fromstationid=:fromstationid  and sb.reachstationid=:reachstationid ");
		Query query = getEntityManager().createQuery(sql.toString(),StandardBasePrice.class);
		query.setParameter("routeid", r.getRouteid());
		query.setParameter("fromstationid", r.getFromstationid());
		query.setParameter("reachstationid", r.getReachstationid());
		//query.setParameter("orgid", r.getOrgid());
		List<StandardBasePrice> sbs =query.getResultList();
		play.Logger.info("select sb from StandardBasePrice sb where sb.routeid="+r.getRouteid()+" and fromstationid="+r.getFromstationid()+"  and reachstationid="+r.getReachstationid()+" and orgid="+r.getOrgid()+" ");
		if(sbs.size()==0){
			return null;
		}
		
		return sbs.get(0);
	}
	
	public List<Routeprice> getBaseRoutePrice(String ids){ 
		String sql = "select r from Routeprice r where r.isbaseprice = 1 and r.id in ("+ids+")";
		Query query = getEntityManager().createQuery(sql.toString(), Routeprice.class);
		return 	query.getResultList();
	}
}
