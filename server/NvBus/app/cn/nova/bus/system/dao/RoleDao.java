package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Role;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")

public class RoleDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public boolean isExistRole(Role role) {
		if (role.getId() == 0) {
			StringBuffer sql = new StringBuffer(
					"select r from Role r where r.orgid=:orgid and r.name=:name");
			Query query = em.createQuery(sql.toString());
			query.setParameter("orgid", role.getOrgid());
			query.setParameter("name", role.getName());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuffer sql = new StringBuffer(
					"select r from Role r where r.orgid=:orgid and r.name=:name")
					.append(" and r.id!=:id");
			Query query = em.createQuery(sql.toString());
			query.setParameter("orgid", role.getOrgid());
			query.setParameter("name", role.getName());
			query.setParameter("id", role.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryRole(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select r,org.name as orgname,u.name as createname, us.name as updatename ")
				.append(" from Role r,Organization org,Userinfo u,Userrole a, Userinfo us ")
				.append(" where r.orgid=org.id and r.createby=u.id and r.updateby=us.id ")
				.append(" and r.id=a.id.roleid");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isUseRole(Role role) {
		StringBuffer sql = new StringBuffer(
				"select u from Userrole u where u.id.roleid=:id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", role.getId());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public List<Role> qryRole(long userid) {
		StringBuffer sql = new StringBuffer(
				"select r from Role r,Userrole ur where ")
				.append(" ur.id.userid=:userid and ur.id.roleid=r.id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("userid", userid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Role> qryRolebyid(long id) {
		StringBuffer sql = new StringBuffer(
				"select r from Role r where ")
				.append(" r.id=:id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", id);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select r,org.name as orgname,u.name as createname, us.name as updatename ")
				.append(" from Role r,Organization org,Userinfo u, Userinfo us ")
				.append(" where r.orgid=org.id and r.createby=u.id and r.updateby=us.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean isApplyMenupermission(Long roleid) {
		StringBuffer sql = new StringBuffer(
				"select t from Menupermission t where t.roleid=:roleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("roleid", roleid);
		if (query.getResultList().size() < 1) {
			return false;
		}
		return true;
	}
	
	public boolean isApplOrgpermission(Long roleid) {
		StringBuffer sql = new StringBuffer(
				"select t from Orgpermission t where t.roleid=:roleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("roleid", roleid);
		if (query.getResultList().size() < 1) {
			return false;
		}
		return true;
	}

	public boolean qryUser(long roleid) {
		StringBuffer sql=new StringBuffer(
				"select u from Role r ,Userrole ur,Userinfo u  ")
		.append(" where r.id=ur.id.roleid and ur.id.userid = u.id and ur.id.roleid=:roleid");
		Query query=getEntityManager().createQuery(sql.toString());
		query.setParameter("roleid", roleid);
		if(query.getResultList().size()>0){
			return true;
		}
		return false;
	}
	
}
