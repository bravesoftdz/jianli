package cn.nova.bus.archive.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Contractor;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class ContractorDao extends EntityManagerDaoSurport{
	@SuppressWarnings("unchecked")
	public List<Object> queryContractor(List<PropertyFilter> propertyFilterList) {		
		StringBuilder sql = new StringBuilder("select c,o.name as orgname,v.vehicleno as vehiclename,uc.name as createname,up.name as updatename ")
					.append( " from Contractor c ,Vehicle v,Organization o,Userinfo uc ,Userinfo up  ")
					.append(" where c.vehicleid = v.id and c.orgid =o.id and uc.id = c.createby and up.id = c.updateby and c.isactive = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Contractor> getContractor(String contractno) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("contractno", contractno);
		List<Contractor> contractor = find(Contractor.class, map);
		return contractor;
	}
	
	@SuppressWarnings("unchecked")	
	public boolean updateByid(long delid){
		String sql = "update Contractor c set c.isactive = 0 where c.id = "+delid;
		int result  = execute(sql);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")	
	public List<Object> isExistContractor(Contractor c){
		StringBuilder sql = new StringBuilder(
				"select c from Contractor c " +
				"where c.vehicleid = :vehicleid and c.orgid = :orgid and c.isactive = 1"+
				" and (c.startdate between :startdate and :enddate "+
				"or c.enddate between :startdate and :enddate )");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", c.getVehicleid());
		query.setParameter("orgid", c.getOrgid());
		query.setParameter("startdate", c.getStartdate());
		query.setParameter("enddate", c.getEnddate());
		return query.getResultList();
	}
}
