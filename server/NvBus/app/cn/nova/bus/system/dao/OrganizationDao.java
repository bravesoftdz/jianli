package cn.nova.bus.system.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Useronline;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class OrganizationDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("select t.id,t.code,t.name,")
				.append(" t.type,t.parentid,t.describe,")
				.append(" t.serversaddress, t.ticketserversaddress,")
				.append(" t.address, t.contactperson,t.contactphone,")
				.append(" t.unitid,t.stationid,t.isactive,")
				.append(" t.createtime, t.createby,t.updatetime,")
				.append(" t.updateby,t.districtid,t.islocal,")
				.append(" u.name as username,org.name as parentname,")
				.append(" un.name as unitname,s.name as stationname,")
				.append(" us.name as updatename,d.name as districtname,t.synccode")
				.append(" from Organization t")
				.append(" left join unit un on t.unitid = un.id")
				.append(" left join District d on t.districtid = d.id")
				.append(" left join station s on t.stationid = s.id")
				.append(" left join Organization org on t.parentid = org.id ")
				.append(" left join userinfo u on t.createby = u.id")
				.append(" left join userinfo us on t.updateby = us.id")
				.append(" where t.isactive = 1 ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by  t.type desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Date getlastlogintime(Long userid) {
		StringBuffer sql = new StringBuffer(
				"select t.logintime from Useronline t where t.userid = ");
		sql.append(userid);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return new Date();
		}
		return (Date) query.getSingleResult();
	}
	public String getCodetranscode(String code) {
		StringBuffer sql = new StringBuffer(
				"select t.orgcode from codetrans t where t.orgcodeinstation = '");
		sql.append(code).append("'");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return "";
		}
		return (String) query.getSingleResult();
	}
	public Useronline getByUserid(Long userid) {
		StringBuffer sql = new StringBuffer(
				"select t from Useronline t where t.userid = ");
		sql.append(userid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Useronline) query.getSingleResult();
	}

	public Long findId(String code) {
		String sql = "select t.id from Organization t where t.isactive=0 and t.code='"
				+ code + "'";
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public String getValue(Long id, String value) {
		String sql = "";
		if (value.equals("name")) {
			sql = sql + "select t.name from Organization t where t.id=" + id;
		} else if (value.equals("code")) {
			sql = sql + "select t.code from Organization t where t.id=" + id;
		}
		Query query = getEntityManager().createQuery(sql);
		return (String) query.getSingleResult();
	}

	public List getOrgan(String code, String name) {
		String sql = "select t from Organization t where ";
		if (code == null || "".equals(code)) {
			sql = sql + " t.name='" + name + "'";
		} else if (name == null || "".equals(name)) {
			sql = sql + " t.code='" + code + "'";
		} else {
			sql = sql + " t.name='" + name + "' or t.code='" + code + "'";
		}
		Query query = getEntityManager().createQuery(sql);
		return query.getResultList();
	}

	public List getOrganizationlist(Long dependenceid, String string) {
		StringBuffer sql = new StringBuffer("select t from Organization t ");
		if ("station".equals(string)) {
			sql.append(" where t.station.id = ");
			sql.append(dependenceid);
		} else if ("unit".equals(string)) {
			sql.append(" where t.unit.id=");
			sql.append(dependenceid);
		}
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isExistByName(Organization org) {
		if (org.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.name =:name and o.isactive=1");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("name", org.getName());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.name =:name and o.id!=:id and o.isactive=1");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("name", org.getName());
			query.setParameter("id", org.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}

	}

	@SuppressWarnings("unchecked")
	public boolean isExistByValue(Organization org) {
		if (org.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.code =:code and o.isactive=1");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("code", org.getCode());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.code =:code and o.id!=:id and o.isactive=1");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("code", org.getCode());
			query.setParameter("id", org.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}

	}

	@SuppressWarnings("unchecked")
	public boolean isExistByStation(Organization org) {
		if (org.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.station =:station and o.isactive=1");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("station", org.getStation());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.station =:station and o.id!=:id and o.isactive=1");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("station", org.getStation());
			query.setParameter("id", org.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public boolean isExistByUnit(Organization org) {
		if (org.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.unit =:unit");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("unit", org.getUnit());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select o from Organization o ")
					.append(" where o.unit =:unit and o.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("unit", org.getUnit());
			query.setParameter("id", org.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryOrgRight(String orgids) {
		StringBuilder sql = new StringBuilder(
				"select o.id,o.name,o.code from Organization o ")
				.append(" where o.isactive=1 and o.id in " + orgids);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	
	/**
	 * 查询所有配客点和车站
	 * @param orgids
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryAllOrg() {
		StringBuilder sql = new StringBuilder(
				"select o.id,o.name,o.code from Organization o ")
				.append(" where o.isactive=1 and o.type in ('1','2','0') " );
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	
	/**
	 * 查询所有配客点和车站
	 * @param orgids
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryOtherOrg() {
		StringBuilder sql = new StringBuilder(
				"select o.id,o.name,o.code from Organization o ")
				.append(" where o.isactive=1 and o.type in ('1','2') and o.islocal=0" );
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Object> qryAllStation() {
		StringBuilder sql = new StringBuilder(
				"select s.id,s.name from organization z left join station s on s.id=z.stationid where z.type in('1','2')  ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	//根据departStationid取orgId
	public Organization getOrgByStationId(long departstationid){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!station.id", departstationid));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)super.uniqueResult(Organization.class, propertyFilters);
		return org;
	}

	//根据departStationcode取orgId
	public Organization getOrgByStationCode(String departstationcode){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!station.code", departstationcode));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)super.uniqueResult(Organization.class, propertyFilters);
		return org;
	}

	//根据departStationcode取orgId
	public Organization getOrgByCode(String departorgcode){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!code", departorgcode));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)super.uniqueResult(Organization.class, propertyFilters);
		return org;
	}
	
	public List<Object> qryOrginfoBy(Organization org){
		
		StringBuilder sql = new StringBuilder("select o from Organization o ")
		.append(" where o.isactive=1 and o.type in ('1','2') and o.organ=:organ");
        Query query = getEntityManager().createQuery(sql.toString());
        query.setParameter("organ", org);
        return query.getResultList();
			
	}

}
