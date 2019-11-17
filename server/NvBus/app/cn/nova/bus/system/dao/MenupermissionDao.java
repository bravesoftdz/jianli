package cn.nova.bus.system.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Menupermission;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.jpa.ListUtil;


public class MenupermissionDao extends EntityManagerDaoSurport<Menupermission> {
	
	public List<Map<String, Object>> query(long roleid) {
		StringBuilder sql = new StringBuilder();
		sql.append("select 0 as type,m.id as menuid,m.name,m.grade,m.orderno,m.parentid,m.parameter")
			.append("      ,").append(roleid).append(" as roleid")
			.append("      ,0 as functionpermissionregid, case when mp.id is null then 0 else 1 end as haspermission")
			.append("      ,mp.createtime,u.name as createbyname")
			.append(" from Menu m ")
			.append(" left join Functionreg f")
			.append("       on m.functionregid=f.id")
			.append(" left join Menupermission mp")
			.append("       on mp.menuid=m.id")
			.append("      and mp.type=0")
			.append("      and mp.roleid=").append(roleid)
			.append(" left join Userinfo u")
			.append("       on mp.createby=u.id")
//			.append(" order by m.grade,m.orderno")
			.append(" union")
			.append(" select 1 as type,m.id as menuid,fp.permissionname as name,m.grade+1 as grade,1 as orderno,m.id as parentid,'' as parameter")
			.append("       ,").append(roleid).append(" as roleid")
			.append("		,fp.id as functionpermissionregid, case when mp.id is null then 0 else 1 end as haspermission")
			.append("      ,mp.createtime,u.name as createbyname")
			.append("   from Menu m ")
			.append("   inner join Functionreg f")
			.append("   		on m.functionregid=f.id")
			.append(" 	inner join Functionpermissionreg fp")
			.append(" 			on f.id=fp.functionregid")
			.append(" 	left join Menupermission mp")
			.append(" 		   on mp.menuid=m.id")
			.append(" 		  and mp.type=1")
			.append("      	  and mp.roleid=").append(roleid)
			.append(" 		  and mp.functionpermissionregid=fp.id")
			.append(" left join Userinfo u")
			.append("       on mp.createby=u.id")
			.append(" order by grade,orderno");
		List<Object> result = super.getEntityManager().createNativeQuery(sql.toString()).getResultList();
		return ListUtil.listToMap(new Object[] {"type", "menuid", "name", "grade", "orderno", "parentid", "parameter", 
												"roleid","functionpermissionregid","haspermission","createtime","createbyname"}, 
								  result, 
								  new Object[] {Integer.class, Long.class,String.class, Byte.class, BigDecimal.class,	Long.class, String.class, 
												Long.class, Long.class, Boolean.class,Timestamp.class,String.class});
	}

	public List<Map<String, Object>> queryByUserid(long userid) {
		Userinfo userinfo = this.getEntityManager().find(Userinfo.class, userid);
		StringBuilder sql = new StringBuilder();
		sql.append("select 0 as type,m.id as menuid,m.name,m.grade,m.orderno,m.parentid,m.parameter,mh.hotkey")
			.append("      ,f.packagename,f.functionkey,'' as subfunctionkey,'' as subFunctionname, ");
//		if(userinfo.getCode().equalsIgnoreCase("admin")){
//			sql.append("1 as haspermission");
//		}
//		else{
			sql.append("case when mp.permissionmenuid is null then 0 else 1 end as haspermission");
//		}
		sql.append(" from Menu m ")
			.append(" full join Functionreg f")  //无菜单功能也查询出来
			.append("       on m.functionregid=f.id")
			.append(" left join (select distinct mpi.menuid as permissionmenuid,mpi.functionpermissionregid ")
			.append("			   from Menupermission mpi")
			.append("    		  where mpi.type=0")
			.append("      			and exists (select 'N' from userrole ur where ur.roleid=mpi.roleid and ur.userid= ").append(userid).append(")")
			.append(" 			) mp")
			.append("       on mp.permissionmenuid=m.id")
			.append(" left join (select mhi.menuid,max(mhi.hotkey) as hotkey ")
			.append("			   from Menuhotkey mhi")
			.append("    		  where exists (select 'N' from userrole ur where ur.roleid=mhi.roleid and ur.userid= ").append(userid).append(")")
			.append(" 			 group by mhi.menuid")
			.append(" 			) mh")
			.append("  	     on mh.menuid=m.id")
			.append(" union")
			.append(" select 1 as type,m.id as menuid,m.name,m.grade+1 as grade,1 as orderno,m.id as parentid,m.parameter,'' as hotkey")
			.append("		,f.packagename,f.functionkey,fp.permissionkey as subfunctionkey,fp.permissionname as subfunctionname, ");
//		if(userinfo.getCode().equalsIgnoreCase("admin")){
//			sql.append("1 as haspermission");
//		}
//		else{
			sql.append("case when mp.permissionmenuid is null then 0 else 1 end as haspermission");
//		}
		sql.append("   from Menu m ")
			.append("   inner join Functionreg f")
			.append("   		on m.functionregid=f.id")
			.append(" 	inner join Functionpermissionreg fp")
			.append(" 			on f.id=fp.functionregid")
			.append(" left join (select distinct mpi.menuid as permissionmenuid,mpi.functionpermissionregid ")
			.append("			   from Menupermission mpi")
			.append("    		  where mpi.type=1")
			.append("      			and exists (select 'N' from userrole ur where ur.roleid=mpi.roleid and ur.userid= ").append(userid).append(")")
			.append(" 			) mp")
			.append("       on mp.permissionmenuid=m.id")
			.append(" 	   and mp.functionpermissionregid=fp.id")
			.append(" order by grade,orderno");
		List<Object> result = super.getEntityManager().createNativeQuery(sql.toString()).getResultList();
		return ListUtil.listToMap(new Object[] {"type", "menuid", "name", "grade", "orderno", "parentid", "parameter","hotkey", 
												"packagename","functionkey","subfunctionkey","subfunctionname","haspermission"}, 
								  result, 
								  new Object[] {Integer.class, Long.class,String.class, Byte.class, BigDecimal.class,Long.class,String.class,String.class,
												String.class,String.class,String.class,String.class,Boolean.class});
	}
	
	public void deleteAll(long roleid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" delete menupermission t where t.roleid = "+ roleid);
		Query query  = getEntityManager().createNativeQuery(sql.toString());
		query.executeUpdate();
		
	}

}
