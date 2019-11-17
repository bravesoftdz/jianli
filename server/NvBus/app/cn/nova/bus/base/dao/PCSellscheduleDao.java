package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Pcsellschedule;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;


@SuppressWarnings("rawtypes")
public class PCSellscheduleDao extends EntityManagerDaoSurport {
	
	
	public IDAO<Pcsellschedule> dao = new EntityManagerDaoSurport<Pcsellschedule>();

	
	public IDAO<Route> rdao;
	
	public IDAO<Schedule> sdao;
	
	@SuppressWarnings("unchecked")
	public List<Object> findschedule(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				 "select s.type, s.ip, s.orgid, o.name as orgname")
		.append(" from Pcsellschedule s, Organization o")
		.append(" where s.orgid = o.id " );
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append("  group by s.type, s.ip, s.orgid, o.name");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
 		return query.getResultList();
	}
	
	public Boolean delschedulewhere(Long orgid,String ip,String type){
		String sql="delete from Pcsellschedule p where p.orgid = "+orgid+" and p.ip = '"+ip+"' and p.type = "+type;
		int result = dao.execute(sql);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> findschedulesname(Long orgid,String type,String ip,long typeid){
		String sql="";
		if(type.equals("1")){			
			sql = sql+"select p.id as pcid,r.id,r.name as sellname,r.code as sellcode,'' as starttime," +
			"p.createtime,p.createby,p.updatetime,p.updateby,u.name as createname," +
			"up.name as updatename from Pcsellschedule p ,Route r,Userinfo u ,Userinfo up " +
			" where u.id = p.createby and up.id = p.updateby and p.typeid = r.id and p.type = 1 ";
		}
		else if(type.equals("2")){
			sql = sql+"select p.id as pcid,s.id,r.name as sellname,s.code as sellcode,s.starttime," +
			"p.createtime,p.createby,p.updatetime,p.updateby,u.name as createname,up.name as updatename " +
			" from Pcsellschedule p , Schedule s,Userinfo u ,Userinfo up,Route r " +
			" where u.id = p.createby and up.id = p.updateby and s.route.id = r.id and p.typeid = s.id and p.type=2 ";
		}else{
			sql = sql+"select p.id as pcid,p.id,'全部' as sellname,'' as sellcode,'' as starttime," +			
			"p.createtime,p.createby,p.updatetime,p.updateby,u.name as createname,up.name as updatename " +
			" from Pcsellschedule p ,Userinfo u ,Userinfo up" +
			" where u.id = p.createby and up.id = p.updateby and p.type=0 ";
		}
		if(ip!=null){
			sql = sql+" and p.ip = '"+ip+"'";
		}
		if(orgid != null && orgid !=0){
			sql= sql+" and p.orgid="+orgid;
		}
		if(typeid !=0){
			sql = sql +" and p.typeid = "+typeid;
		}
		List<Object> list = dao.find(sql);
		return list;
	}
	
	/**
	 * 查找指定机构的线路或者班次
	 * @param orgid
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findscheduleOrRoute(Long orgid,String type,long routeid,Boolean isupdate){
		String sql="";
		List<Object> list =  null;
		if(type.equals("1")){			
			sql = "select r.id,r.name,r.code,'' as starttime from Route r ";
			if(isupdate){
				sql = sql+ " ,(select pcs.type,pcs.typeid from Pcsellschedule pcs group by pcs.type,pcs.typeid) ps" +
						" where ps.typeid = r.id and r.isactive=1 and r.orgid = " +orgid;
			}else{
				sql=  sql +" where r.isactive=1 and r.orgid = " +orgid+" order by r.name";
			}
			Query query = getEntityManager().createNativeQuery(sql);
	 		list = query.getResultList(); 
		}
		else if(type.equals("2")){
			sql = "select s.id,r.name,s.code,trim(s.starttime) from Schedule s,Route r " ;
			if(isupdate){
				sql = sql +" ,(select pcs.type,pcs.typeid from Pcsellschedule pcs group by pcs.type,pcs.typeid) ps" +
						" where ps.typeid = s.id and s.routeid=r.id and s.isactive=1 and s.orgid ="+orgid;
			}else{
				sql = sql +" where s.routeid=r.id and s.isactive=1 and s.orgid ="+orgid;
			}					
			if(routeid!=0){
				sql =sql +" and r.id = "+routeid;
			}
			sql = sql + " order by r.name ,s.id ";
			Query query = getEntityManager().createNativeQuery(sql);
	 		list = query.getResultList(); 
		}			 
		return list;
	}			
	
	/**
	 * 查询已经存在的记录，如果不存在返回null
	 * @param ip
	 * @param orgid
	 * @param type
	 * @param typeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Pcsellschedule> qryPcsellschedule(String ip, long orgid,String type,long typeid) {
		StringBuilder sql = new StringBuilder(
				"select o from Pcsellschedule o ")
				.append(" where o.ip =:ip and o.orgid=:orgid")
				.append(" and o.type = "+type);
		if(typeid!=0){
			sql.append(" and o.typeid = "+typeid);
		}		
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ip", ip);
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}
	
}
