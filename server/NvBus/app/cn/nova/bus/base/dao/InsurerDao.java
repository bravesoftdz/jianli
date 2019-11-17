package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class InsurerDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("select i.Id, i.orgid, i.Name, i.address, i.contactperson, i.contactphone, i.createtime, i.createby, i.updatetime")
		.append("         , i.updateby, i.synccode, i.interfacetype, i.selladdress, i.returnaddress, i.bankcode ")
		.append("         ,u.name as createname, o.name as orgname,us.name as updatename,dd.value as interfacetypename ")
		.append(" from Insurers i left join digitaldictionarydetail dd on dd.digitaldictionaryid=79 and dd.code=i.interfacetype " )
		.append(", Userinfo u, Organization o, Userinfo us where i.createby = u.id ")
		.append(" and i.orgid = o.id and i.updateby=us.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean isExistName(Long orgid, String name) {
		StringBuffer sql = new StringBuffer("select i from Insurers i ");
		sql.append(" where i.orgid=:orgid and i.name=:name ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("name", name);
		if (query.getResultList().isEmpty()) {
			return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	public List<Insuretypedetail> getInsuretype(Long id) {
		StringBuffer sql = new StringBuffer("select t from Insuretype t, Insurers i ");
		sql.append(" where t.insurersid=i.id and i.id=:id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		return query.getResultList();
	}

}
