package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balancedivide;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BalancedivideDao extends EntityManagerDaoSurport {
	// 查询该结算对象协议是否已经存在
	@SuppressWarnings("unchecked")
	public boolean isExistBalancedivide(Balancedivide balancedivide) {
		if (balancedivide.getId() > 0) {
			StringBuilder sql = new StringBuilder("select b")
					.append(" from Balancedivide b")
					.append(" where b.routeid =:routeid and b.vehicleid=:vehicleid")
					.append(" and b.id!=:id");
			Query query = em.createQuery(sql.toString());
			query.setParameter("routeid", balancedivide.getRouteid());
			query.setParameter("vehicleid", balancedivide.getVehicleid());
			query.setParameter("id", balancedivide.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder("select b").append(
					" from Balancedivide b").append(
					" where b.routeid =:routeid and b.vehicleid=:vehicleid");
			Query query = em.createQuery(sql.toString());
			query.setParameter("routeid", balancedivide.getRouteid());
			query.setParameter("vehicleid", balancedivide.getVehicleid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;

		}
	}

	// 查询分层协议信息
	@SuppressWarnings("unchecked")
	public List<Object> qryBalancedivide(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = null;
		sql = new StringBuilder("select t.id,t.orgid,")
				.append("  o.name orgname,t.routeid,r.name routename,")
				.append("  t.vehicleid,v.vehicleno,v.balanceunitid,u1.name balanceunit,")
				.append("  t.dividevehicleid,v2.vehicleno dividevehicleno,t.divide,")
				.append("  uf1.name createdname,uf2.name updatedname,")
				.append("  t.createby,t.updateby,t.createtime,t.updatetime")
				.append(" from Balancedivide t,Organization  o,")
				.append("   Route         r,   Vehicle       v,")
				.append("   Unit          u1,  Vehicle       v2,")
				.append("   Userinfo      uf1, Userinfo      uf2")
				.append(" where t.routeid = r.id and t.vehicleid = v.id")
				.append("   and v.balanceunitid = u1.id and t.dividevehicleid = v2.id")
				.append("   and t.createby = uf1.id and t.updateby = uf2.id")
				.append("   and t.orgid=o.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.orgid,t.updatetime desc");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}
	

}
