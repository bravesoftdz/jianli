/**
 * 
 */
package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author ice
 * 
 */
@SuppressWarnings("rawtypes")
public class VehiclebrandmodelDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> find(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select vb,uc.name as createbyname,uu.name as updatebyname,vt.name as vehicletypename")
		.append(" from Vehiclebrandmodel vb,Userinfo uc,Userinfo uu,Vehicletype vt ")
		.append(" where vb.createby = uc.id and vb.updateby = uu.id and vb.vehicletypeid=vt.id and vt.isactive=1 ");
		propertyFilterList.add(new PropertyFilter("EQB_vb!isactive", "true"));
		propertyFilterList.add(new PropertyFilter("EQB_vb!islocaldelete",
				"false"));
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Long getId(Long vehicletypeid){
		StringBuffer sql = new StringBuffer("select v.id from ");
		sql.append(" Vehiclebrandmodel v where v.vehicletypeid=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicletypeid", vehicletypeid);
		List list = query.getResultList();
		return list != null && list.size() > 0 ? (Long) query.getSingleResult() : null;
	}
	
}
