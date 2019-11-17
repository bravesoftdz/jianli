package cn.nova.bus.system.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Menuhotkey;
import cn.nova.utils.orm.jpa.ListUtil;


public class MenuhotkeyDao extends EntityManagerDaoSurport<Menuhotkey> {
	public List<Map<String, Object>> query(long roleid) {
		StringBuilder sql = new StringBuilder();
		sql.append("select m.id, m.name, m.functionregid, m.grade, m.orderno, m.parentid, m.parameter ")
			.append("      ,").append(roleid).append(" as roleid")
			.append("      ,mh.hotkey,mh.createtime, mh.createby, mh.updatetime, mh.updateby")
 		    .append("      ,f.name as functionname,f.functiondescribe,f.parameterdescribe")
 		    .append("      ,uc.name as createbyname,uu.name as updatebyname")
 		    .append("  from Menu m")
			.append("   left join Functionreg f")
			.append("   		on m.functionregid=f.id")
			.append(" 	inner join Menupermission mp")
			.append(" 		   on mp.menuid=m.id")
			.append(" 		  and mp.type=0")
			.append("      	  and mp.roleid=").append(roleid)
			.append("   left join Menuhotkey mh")
			.append("   	   on mh.menuid=m.id")
			.append("      	  and mh.roleid=").append(roleid)
			.append("   left join Userinfo uc")
			.append("          on mh.createby=uc.id")
			.append("   left join Userinfo uu")
			.append("          on mh.updateby=uu.id")
		    .append(" order by m.grade,m.orderno");
		List<Object> result = super.getEntityManager().createNativeQuery(sql.toString()).getResultList(); 
		return ListUtil.listToMap(new Object[]{"id", "name", "functionregid", "grade", "orderno", "parentid", "parameter",
												"roleid","hotkey","createtime", "createby", "updatetime", "updateby",
												"functionname","functiondescribe","parameterdescribe"
												,"createbyname","updatebyname"}, 
								result,
								new Object[]{Long.class,String.class,Long.class,Byte.class,BigDecimal.class,Long.class,String.class
											,Long.class,String.class,Timestamp.class,Long.class,Timestamp.class,Long.class,
											String.class,String.class,String.class,String.class,String.class});
	}

}
