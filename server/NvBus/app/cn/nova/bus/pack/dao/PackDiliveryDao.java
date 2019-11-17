package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import play.db.jpa.JPA;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.PackDilivery;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class PackDiliveryDao extends EntityManagerDaoSurport<PackDilivery> {

	public List<Object> getPackDiliveryByPackId(PackDilivery pd) {
		StringBuffer sb = new StringBuffer("select p.outbound, ui0.name as outboundname, p.diliver, ui1.name as dilivername, p.diliveno, p.createby, p.deliveryfee, p.dilivedate, p.createtime, p.orgid, p.id from PackDilivery p ");
		sb.append(" left join userinfo ui0 on ui0.id = p.outbound ");
		sb.append(" left join userinfo ui1 on ui1.id = p.diliver ");
		sb.append(" where p.packid = "+ pd.getPackid());
		Query query = getEntityManager().createNativeQuery(sb.toString());
		return query.getResultList();
	}
	
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		
		StringBuffer sb = new StringBuffer();
		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		StringBuffer sql = new StringBuffer("select ")
				.append("pd.id, pd.orgid, org.name as orgname, pd.diliveno,")
				.append("u1.name as outboundname, pd.outbound, pd.outdate,")
				.append("u2.name as dilivername, pd.diliver, pd.dilivedate,")
				.append("pd.deliveryfee, u3.name as creator, pd.createtime, u4.name as updater, pd.updatetime")
				.append(" from PackDilivery pd ")
//				.append(sb.toString()).append(") p")
				.append(" left join Userinfo u1 on u1.id=pd.outbound ")
				.append(" left join Userinfo u2 on u2.id=pd.diliver")
				.append(" left join Userinfo u3 on u3.id=pd.createby")
				.append(" left join Userinfo u4 on u4.id=pd.updateby")
				.append(" ,Organization org where org.id=pd.orgid ")
				.append(sb.toString())
				.append(" order by pd.createtime desc");
		
//		sb.append(" order by p.createtime desc");
		System.out.println("sql-->"+sql.toString());
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> list = query.getResultList();
		return list;
	}
	
}
