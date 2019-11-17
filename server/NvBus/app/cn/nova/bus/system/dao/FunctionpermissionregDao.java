package cn.nova.bus.system.dao;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Functionpermissionreg;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class FunctionpermissionregDao extends EntityManagerDaoSurport<Functionpermissionreg> {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters){
		StringBuilder sql = new StringBuilder();
		sql.append("select fm,uc.name as createbyname,uu.name as updatebyname")
			.append(" from Functionpermissionreg fm,Userinfo uc, Userinfo uu")
			.append(" where fm.createby=uc.id")
			.append("   and fm.updateby=uu.id");
		List<Object> result = super.find(sql.toString(), propertyFilters);
		return ListUtil.listToMap(new Object[]{Functionpermissionreg.class,"createbyname","updatebyname"}
									, result
									,new Object[]{Functionpermissionreg.class,String.class,String.class});
	}

}
