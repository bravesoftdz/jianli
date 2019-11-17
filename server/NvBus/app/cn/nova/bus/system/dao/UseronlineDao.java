package cn.nova.bus.system.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Useronline;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class UseronlineDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as username, u.code as usercode,u.islock as islock, u.ismultipoint ");
		sql.append(" as ismultipoint, o.name as orgname, d.name as depname ");
		sql.append(" from Useronline t, Userinfo u, Organization o, Department d ");
		sql.append(" where t.userid = u.id and  u.orgid=o.id and u.departmentid=d.id and u.isactive=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Date getlastlogintime(Long userid) {
		StringBuffer sql = new StringBuffer(
				"select t.logintime from Useronline t where t.userid =:userid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("userid", userid);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return new Date();
		}
		return (Date) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public Useronline getByUserid(Long userid) {
		StringBuffer sql = new StringBuffer(
				"select t from Useronline t where t.userid =:userid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("userid", userid);
		List<Object> list=query.getResultList();
		return (Useronline) (list!=null&& list.size()>0?list.get(0):null);
	}
	
	public List<Useronline> queryOnlineUser() {
		StringBuffer sql = new StringBuffer(
				"select t from Useronline t, Userinfo u  where u.id = t.userid and t.isonline = 1 and u.ismultipoint = 0");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
}
