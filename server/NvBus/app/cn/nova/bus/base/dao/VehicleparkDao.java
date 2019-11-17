package cn.nova.bus.base.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
@SuppressWarnings("rawtypes")
public class VehicleparkDao extends EntityManagerDaoSurport{

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select v, o.name as orgname,u.name as createname,upt.name as updatename " +
			" from Vehiclepark v ,Organization o,Userinfo u,Userinfo upt " +
			" where u.id=v.createby and upt.id = v.updateby and v.orgid = o.id and v.isactive = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	
	}
	
	@SuppressWarnings("unchecked")
	public Schedulestop isExistSchedulePark( Long vehcileparkid,boolean isactive) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vehcileparkid", vehcileparkid);
		map.put("isactive", isactive);
		List<Schedulestop> schedulestops = find(Schedulestop.class, map);
		return schedulestops != null && schedulestops.size() > 0 ? schedulestops
				.get(0) : null;
	}
	
	@SuppressWarnings("unchecked")
	public Vehiclepark isExistPark( long orgid,String name,boolean isactive) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", orgid);
		map.put("name", name);
		map.put("isactive", isactive);
		List<Vehiclepark> vehiclepark = find(Vehiclepark.class, map);
		return vehiclepark != null && vehiclepark.size() > 0 ? vehiclepark
				.get(0) : null;
	}

}