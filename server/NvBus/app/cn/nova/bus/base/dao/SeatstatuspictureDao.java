package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Seatstatuspicture;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SeatstatuspictureDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, o.name as orgname,us.name as updatename, dic.value as statusname ");
		sql.append(" from Seatstatuspicture t, Userinfo u, Organization o, Userinfo us ,Digitaldictionarydetail dic,");
		sql.append(" Digitaldictionary dig where t.createby = u.id and t.orgid = o.id and t.updateby=us.id and t.isactive=1 ");
		sql.append(" and dig.columnname='status' and dig.tablename='scheduleseats' and dic.digitaldictionary.id=dig.id and dic.code=t.seatstatus ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List getResult(String seatstatus) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatstatuspicture t where t.seatstatus='");
		sql.append(seatstatus);
		sql.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Seatstatuspicture getSeatstatuspicture(String status) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatstatuspicture t where t.seatstatus='");
		sql.append(status);
		sql.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Seatstatuspicture) query.getSingleResult();
	}

}
