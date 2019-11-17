/**
 * 
 */
package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author ice
 *
 */
@SuppressWarnings("unchecked")
public class VehiclespaceDao extends EntityManagerDaoSurport<Vehiclespace> {
	public List<Object> find(List<PropertyFilter> propertyFilters){
		StringBuilder sql = new StringBuilder("select vs,uc.name as createbyname,uu.name as updatebyname ")
							.append(" from Vehiclespace vs,Userinfo uc,Userinfo uu ")
							.append(" where vs.createby=uc.id")
							.append("   and vs.updateby=uu.id");
		propertyFilters.add(new PropertyFilter("EQB_vs!isactive", "true"));
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

}
