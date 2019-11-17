package cn.nova.bus.system.dao;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Functionreg;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class FunctionregDao extends EntityManagerDaoSurport<Functionreg> {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters){
		StringBuilder sql = new StringBuilder();
		sql.append("select f,uc.name as createbyname,uu.name as updatebyname")
			.append(" from Functionreg f,Userinfo uc,Userinfo uu")
			.append(" where f.createby=uc.id")
			.append("   and f.updateby=uu.id");
		List<Object> result = super.find(sql.toString(), propertyFilters);
		return ListUtil.listToMap(new Object[]{Functionreg.class,"createbyname","updatebyname"}
									, result
									,new Object[]{Functionreg.class,String.class,String.class});
	}
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> qryInstruction(String key){
		StringBuilder sql = new StringBuilder();
		sql.append("select f.instruction")
			.append(" from Functionreg f")
			.append(" where f.functionkey=:key");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("key", key);
		List<Object> result = query.getResultList();
		return ListUtil.listToMap(new Object[]{"instruction"}, result,new Object[]{String.class});
	}
}
