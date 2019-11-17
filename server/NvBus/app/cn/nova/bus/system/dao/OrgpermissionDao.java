package cn.nova.bus.system.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Orgpermission;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.jpa.ListUtil;


public class OrgpermissionDao extends EntityManagerDaoSurport<Orgpermission> {
	public List<Map<String,Object>> query(long roleid){
		StringBuilder sql = new StringBuilder();
		sql.append("select o.id as orgid,o.name as orgname")
			.append("      ,").append(roleid).append(" as roleid")
			.append("      ,case when om.orgid is null then 0 else 1 end as haspermission")
			.append("      ,om.createtime,u.name as createbyname")
		    .append("  from Organization o")
			.append(" left join Orgpermission om")
			.append("       on om.orgid = o.id")
			.append("      and o.islocal=1")
			.append("      and om.roleid=").append(roleid)
			.append(" left join Userinfo u")
			.append("       on om.createby=u.id")
			.append(" where o.islocal=1");
		List<Object> result = super.getEntityManager().createNativeQuery(sql.toString()).getResultList();
		return ListUtil.listToMap(new Object[]{"orgid","orgname","roleid","haspermission","createtime","createbyname"}, 
								result,
								new Object[]{Long.class,String.class,Long.class,Boolean.class,Timestamp.class,String.class});
	}

	public List<Map<String,Object>> query(long roleid,long curuserid){
		Userinfo userinfo = this.getEntityManager().find(Userinfo.class, curuserid);
		StringBuilder sql = new StringBuilder();
		sql.append("select o.id as orgid,o.name as orgname")
			.append("      ,").append(roleid).append(" as roleid")
			.append("      ,case when om.orgid is null then 0 else 1 end as haspermission")
			.append("      ,om.createtime,u.name as createbyname")
		    .append("  from Organization o")
			.append(" left join Orgpermission om")
			.append("       on om.orgid = o.id")
			.append("      and o.islocal=1")
			.append("      and om.roleid=").append(roleid)
			.append(" left join Userinfo u")
			.append("       on om.createby=u.id")
			.append(" where o.islocal=1 and o.isactive=1 ");
		if(!userinfo.getCode().equalsIgnoreCase("admin")){
			sql.append(" and exists (select om.orgid from Orgpermission om ")
			.append("				where om.orgid=o.id ")
			.append("      			and exists (select 'N' from userrole ur where ur.roleid=om.roleid and ur.userid= ").append(curuserid).append(")")
			.append("              )");
		}
		List<Object> result = super.getEntityManager().createNativeQuery(sql.toString()).getResultList();
		return ListUtil.listToMap(new Object[]{"orgid","orgname","roleid","haspermission","createtime","createbyname"}, 
								result,
								new Object[]{Long.class,String.class,Long.class,Boolean.class,Timestamp.class,String.class});
	}

	public List<Organization> queryOrgPermission(long userid){
		StringBuilder sql = new StringBuilder();
		sql.append("select o.*")
		    .append("  from Organization o")
			.append(" where exists (select om.orgid from Orgpermission om ")
			.append("				where om.orgid=o.id ")
			.append("      			and exists (select 'N' from userrole ur where ur.roleid=om.roleid and ur.userid= ").append(userid).append(")")
			.append("              )");
			//.append("      and o.islocal=1");
		return super.getEntityManager().createNativeQuery(sql.toString(),Organization.class).getResultList();
	}

}
