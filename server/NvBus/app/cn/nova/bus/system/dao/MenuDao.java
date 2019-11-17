package cn.nova.bus.system.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Menu;
import cn.nova.utils.orm.jpa.ListUtil;


public class MenuDao extends EntityManagerDaoSurport<Menu> {
	public List<Map<String,Object>> query(){
		StringBuilder sql = new StringBuilder();
		sql.append("select m.id, m.name, m.functionregid, m.grade, m.orderno, m.parentid, m.parameter, m.createtime, m.createby, m.updatetime, m.updateby,")
		   .append("       f.name as functionname,f.functiondescribe,f.parameterdescribe")
		   .append("  from Menu m left join Functionreg f")
		   .append("       on m.functionregid=f.id")
		   .append(" order by m.grade,m.orderno");
		List<Object> result = super.getEntityManager().createNativeQuery(sql.toString()).getResultList(); //super.find(sql.toString());
		return ListUtil.listToMap(new Object[]{"id", "name", "functionregid", "grade", "orderno", "parentid", "parameter", "createtime", "createby", "updatetime", "updateby",
												"functionname","functiondescribe","parameterdescribe"}, 
								result,
								new Object[]{Long.class,String.class,Long.class,Byte.class,BigDecimal.class,Long.class,String.class,Timestamp.class,Long.class,Timestamp.class,Long.class,
											String.class,String.class,String.class});
	}
	public List<Menu> getAll(){
		StringBuffer sql = new StringBuffer();
		sql.append("select m.id, m.name, m.functionregid, m.grade, m.orderno, m.parentid, m.parameter, m.createtime, m.createby, m.updatetime, m.updateby ")
		   .append(" from Menu m");
		List<Menu> result = super.getEntityManager().createNamedQuery(sql.toString()).getResultList();
		
		return result;
	}

}
