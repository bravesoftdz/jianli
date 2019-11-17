package cn.nova.bus.base.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Station;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class StationDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
				/*"select s,d.name as districtname,u.name as createname,dic.value as dicgrade,d.id as districtid,");
		sql.append(" us.name as updatename,s.isroundtrip,ss.stationname,ss.stationaddress,ss.code as standardCode,ss.name as standradName,ss.province,ss.city,ss.area,ss.id as standradid " );
		sql.append(" from Station s left join fetch s.stationstandard ss, Userinfo us,");
		sql.append(" District d ,Userinfo u,Digitaldictionarydetail dic,Digitaldictionary dig");
		sql.append(" where s.districtid=d.id and u.id=s.createby and dig.columnname='level' and s.isactive=1");
		sql.append(" and dig.tablename='station' and dic.digitaldictionary.id=dig.id and dic.code=s.grade and s.updateby=us.id");*/
		
		sql.append(" select s.id,s.code,s.name,s.jianpin,s.helpcode,s.description, ")
		.append(" s.isdepart,s.grade,s.orgid,s.isactive,s.islocaldelete,s.createtime,s.createby, ")
		.append(" s.updatetime,s.updateby,to_char(s.secondname),s.synccode,s.isroundtrip,s.distance,d.name as districtname ")
		.append(" ,u.name as createname,dic.value as dicgrade,d.id as districtid, ")
		.append(" us.name as updatename,ss.stationname,ss.stationaddress, ")
		.append(" ss.code as standardCode,ss.name as standradName,ss.province,ss.city,ss.area,ss.id as standradid ")
		.append("  from station s left join  stationstandard ss on s.standradid=ss.id, Userinfo us, ")
		.append("  District d ,Userinfo u,Digitaldictionarydetail dic,Digitaldictionary dig ")
		.append("  where s.districtid=d.id and dic.digitaldictionaryid=dig.id and ")
		.append("    u.id=s.createby and dig.columnname='level' and s.isactive=1 ")
		.append("  and dig.tablename='station'  and dic.code=s.grade and s.updateby=us.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list=query.getResultList();
		return list;
	}

	public boolean isUnique(String name, String code) {
		StringBuilder sql = new StringBuilder("select t from Station t where ");
		if (name != null || "".equals(name)) {
			sql.append(" t.name='");
			sql.append(name);
			sql.append("'");
		}
		if (code != null || "".equals(code)) {
			sql.append(" t.helpcode='");
			sql.append(code);
			sql.append("'");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public boolean hasApplyRoutestop(long id) {
		StringBuffer sql = new StringBuffer(
				"select t from Station t, Routestop r,Route rt ");
		sql.append(" where r.stationid=t.id and t.id=:id and r.isactive=1  and rt.isactive=1 and r.route.id=rt.id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public boolean hasApplyOrganization(long id) {
		StringBuffer sql = new StringBuffer(
				"select t from Station t, Organization o ");
		sql.append(" where o.station.id=t.id and t.id=:id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public Long getByName(String name) {
		StringBuffer sql = new StringBuffer("select t.id from Station t ");
		sql.append(" where t.name=:name and t.isactive=0 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", name);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public String isExistCode(String district_code) {
		StringBuffer sql = new StringBuffer("select max(t.code) from Station t ");
		sql.append(" where t.code like '"+ district_code +"%' ");
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (String) query.getSingleResult();
	}

	/**
	 * 
	 * @param code 站点编码
	 * @param isactive 为空代表查询所有状态的站点
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Station getByCode(String code,Boolean isactive) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", code));
		if(isactive!=null){
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", isactive));
		}
		Station station = (Station) super.uniqueResult(Station.class, propertyFilters);
		return station;
	}

}
