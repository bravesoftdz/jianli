package cn.nova.bus.archive.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Employee;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class EmployeeDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> queryEmployee(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select e,o.name as orgname,uc.name as createname,up.name as updatename")
				.append(" from Employee e,Userinfo uc ,Userinfo up ,Organization o ")
				.append(" where o.id = e.orgid and uc.id = e.createby and up.id = e.updateby and e.isactive = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public long isExistEmployee(String idcard, String code, long orgid) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (idcard != null) {
			map.put("idcard", idcard);
		}
		if (code != null) {
			map.put("code", code);
		}
		if (orgid != 0) {
			map.put("orgid", orgid);
		}
		map.put("isactive", true);
		List<Employee> employee = find(Employee.class, map);
		return employee != null && employee.size() > 0 ? employee.get(0)
				.getId() : 0;
	}

	@SuppressWarnings("unchecked")
	public boolean updateByid(long delid) {
		String sql = "update Employee t set t.isactive = 0 where t.id = "
				+ delid;
		int result = execute(sql);
		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object> findPicturebyId(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select e.id,e.picture from Employee e").append(" where 1=1");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
