package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Tickettypepermission;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TickettypepermissionDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.id, dt.value as type, t.typeid, t.tickettypeid,t.createby,t.createtime, ")
				.append(" t.updateby,t.updatetime,us.name as createname,ui.name as updatename, ")
				.append(" coalesce(ti.name, r.name, o.name, u.name) as name,")
				.append(" tt.name as tickettypename, org.name as orgname from tickettypepermission t")
				.append(" left join userinfo u on t.type='0' and t.typeid=u.id ")
				.append(" left join role r on t.type='1' and t.typeid=r.id")
				.append(" left join ticketoutlets ti on t.type='2' and t.typeid=ti.id")
				.append(" left join organization o on t.type='3' and t.typeid=o.id, ")
				.append(" userinfo us, userinfo ui, tickettype tt,digitaldictionary d, digitaldictionarydetail dt, organization org ")
				.append(" where t.createby=us.id and t.updateby=ui.id and (t.typeid=u.id or t.typeid=r.id or ")
				.append(" t.typeid=ti.id or t.typeid=o.id) and t.tickettypeid=tt.id and dt.digitaldictionaryid=d.id and ")
				.append(" d.columnname='type' and d.tablename='tickettypepermission' and dt.code=t.type ");
		sql.append(" and us.orgid=org.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List isExist(String type, long typeid, long tickettypeid) {
		StringBuilder sql = new StringBuilder(
				"select t from Tickettypepermission t where t.type='");
		sql.append(type).append("' and t.typeid=").append(typeid)
				.append(" and t.tickettypeid=").append(tickettypeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	
/*	
 //取交集实现
	public List<Tickettypepermission> findTickettypePermission(long userid,long ticketoutletsid) {
		
		StringBuilder sql = new StringBuilder();
		sql.setLength(0);
		sql.append("select tp.* from tickettypepermission tp")
			.append(" where tp.type=0")
			.append(" and tp.typeid=").append(userid);
		List<Tickettypepermission> userpermission=super.getEntityManager().createNativeQuery(sql.toString(), Tickettypepermission.class).getResultList();
		sql.setLength(0);
		sql.append(" select tp.* from tickettypepermission tp,Userrole ur")
			.append(" where tp.type=1")
			.append(" and tp.typeid=ur.roleid")
			.append(" and ur.userid=").append(userid);
		List<Tickettypepermission> rolepermission=super.getEntityManager().createNativeQuery(sql.toString(), Tickettypepermission.class).getResultList();
		sql.setLength(0);
		sql.append(" select tp.* from tickettypepermission tp")
			.append(" where tp.type=2")
			.append(" and tp.typeid=").append(ticketoutletsid);
		List<Tickettypepermission> ticketoutletspermission=super.getEntityManager().createNativeQuery(sql.toString(), Tickettypepermission.class).getResultList();
		sql.setLength(0);
		sql.append(" select tp.* from tickettypepermission tp,userinfo u")
			.append(" where tp.type=3")
			.append(" and tp.typeid=u.orgid")
			.append(" and u.id=").append(userid);
		List<Tickettypepermission> orgpermission=super.getEntityManager().createNativeQuery(sql.toString(), Tickettypepermission.class).getResultList();
		List<List<Tickettypepermission>> tmpcollection = new ArrayList<List<Tickettypepermission>>();
		if(orgpermission!=null&&orgpermission.size()>0){
			tmpcollection.add(orgpermission);
			if(ticketoutletspermission!=null&&ticketoutletspermission.size()>0){
				tmpcollection.add(ticketoutletspermission);
				if(rolepermission!=null&&rolepermission.size()>0){
					tmpcollection.add(rolepermission);
					if(userpermission!=null&&userpermission.size()>0){
						tmpcollection.add(userpermission);
					}
				}
			}
		}
		List<Tickettypepermission> result = null;
		if(tmpcollection.size()>0){
			result=tmpcollection.get(0);
			for (int i = 1; i < tmpcollection.size(); i++) {
				List<Tickettypepermission> tmpTickettypepermissions = tmpcollection.get(i);
				Iterator<Tickettypepermission> tickettypepermissionIterator = result.iterator();
				while (tickettypepermissionIterator.hasNext()) {
					Tickettypepermission tickettypepermission = (Tickettypepermission) tickettypepermissionIterator.next();
					boolean haspermission = false;
					for (Tickettypepermission tickettypepermission2 : tmpTickettypepermissions) {
						if(tickettypepermission.getTickettypeid()==tickettypepermission2.getTickettypeid()){
							haspermission = true;
							break;
						}
					}
					if(!haspermission){
						tickettypepermissionIterator.remove();
					}
				}
			}
		}
		return result;
	}
*/

	//取并集实现
	public List<Tickettypepermission> findTickettypePermission(long userid,long ticketoutletsid) {
		
		StringBuilder sql = new StringBuilder();
		sql.append("select tp.* from tickettypepermission tp")
			.append(" where tp.type=0")
			.append(" and tp.typeid=").append(userid);
		sql.append(" union select tp.* from tickettypepermission tp,Userrole ur")
			.append(" where tp.type=1")
			.append(" and tp.typeid=ur.roleid")
			.append(" and ur.userid=").append(userid);
		sql.append(" union select tp.* from tickettypepermission tp")
			.append(" where tp.type=2")
			.append(" and tp.typeid=").append(ticketoutletsid);
		sql.append(" union select tp.* from tickettypepermission tp,userinfo u")
			.append(" where tp.type=3")
			.append(" and tp.typeid=u.orgid")
			.append(" and u.id=").append(userid);
		List<Tickettypepermission> orgpermission=super.getEntityManager().createNativeQuery(sql.toString(), Tickettypepermission.class).getResultList();
		return orgpermission;
	}

	
	
}
