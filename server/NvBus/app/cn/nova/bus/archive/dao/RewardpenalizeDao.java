package cn.nova.bus.archive.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Driverrewardpenalize;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class RewardpenalizeDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> queryDriverrewardpenalize(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select e ,d.name as drivername,uc.name as createname,up.name as updatename")
				.append(" from Driverrewardpenalize e,Userinfo uc ,Userinfo up ,Driver d ")
				.append(" where d.id = e.driverid and uc.id = e.createby and up.id = e.updateby and e.isactive = 1 and e.islocaldelete = 0 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryStewardrewardpenalize(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select e ,d.name as stewardname,uc.name as createname,up.name as updatename")
				.append(" from Stewardrewardpenalize e,Userinfo uc ,Userinfo up ,Steward d ")
				.append(" where d.id = e.stewardid and uc.id = e.createby and up.id = e.updateby and e.isactive = 1 and e.islocaldelete = 0 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean updateByid(long delid) {
		String sql = "update Driverrewardpenalize d set d.isactive = 0,d.islocaldelete = 1 where d.id = "
				+ delid;
		int result = execute(sql);
		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean uptStweardByid(long delid) {
		String sql = "update Stewardrewardpenalize d set d.isactive = 0,d.islocaldelete = 1 where d.id = "
				+ delid;
		int result = execute(sql);
		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}
}
