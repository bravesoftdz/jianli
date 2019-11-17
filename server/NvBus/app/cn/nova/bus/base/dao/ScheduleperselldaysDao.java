package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Scheduleperselldays;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b>班次预售天数控制<br/>
 * <b>类名称：</b>ScheduleperselldaysDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2012-9-12 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ScheduleperselldaysDao extends EntityManagerDaoSurport {
	
	
	public IDAO<Scheduleperselldays> dao = new EntityManagerDaoSurport<Scheduleperselldays>();
	
	public IDAO<Scheduleperselldays> perselldaysdao = new EntityManagerDaoSurport<Scheduleperselldays>();		
	
	public IDAO<Route> rdao = new EntityManagerDaoSurport<Route>();
	
	public IDAO<Schedule> sdao = new EntityManagerDaoSurport<Schedule>();
	
	@SuppressWarnings("unchecked")
	public List<Object> findscheduleperselldays(List<PropertyFilter> propertyFilterList) {		
		StringBuilder sql = new StringBuilder(
				 "select spd.id,o.id orgid,o.name orgname,case when spd.type=1 then '线路'")
		.append(" when spd.type=2 then '班次' when spd.type=0 then '全部班次' end typename,spd.type typecode ,")
		.append("case when spd.type =1 then r.name when spd.type = 2 then s.code else '全部' end typeidname,")
		.append("spd.perserlldays,cu.name createname,up.name updatename,spd.createtime,")
		.append(" spd.updatetime,spd.typeid,cu.id createby,spd.remarks,spd.synccode ")
		.append(" from  scheduleperselldays spd left join route r on spd.type = 1 and spd.typeid = r.id")
		.append(" left join schedule s on spd.type = 2 and spd.typeid = s.id,")
		.append(" organization o,userinfo cu,userinfo up")
		.append(" where spd.orgid = o.id and spd.createby= cu.id ")
		.append(" and spd.updateby= up.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by spd.updatetime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
 		return query.getResultList(); 		
	}		

	@SuppressWarnings("unchecked")
	public Scheduleperselldays qryScheduleperselldays(long orgid, String type,long typeid) {
		String  sql = 
				"select s from Scheduleperselldays s "
				+ " where s.orgid = "+ orgid +" and s.type = "+ type+" and s.typeid ="+typeid;
		List<Scheduleperselldays> re = dao.find(sql);
		if (re!=null && re.size()>0){
			return re.get(0);
		}else{
			return null;
		}
	}		
	
	/**
	 * 添加/修改班次预售天数
	 * @param scheduleperselldays
	 * @param typeids
	 * @return
	 * @throws ServiceException
	 */
	public Scheduleperselldays saveScheduleperselldays(Scheduleperselldays entity){
		return dao.merge(entity);
	}		
	
	
	/**
	 * 查找指定机构的线路或者班次
	 * @param orgid
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findscheduleOrRoute(Long orgid,String type,boolean isupdate,long id,long routeid){
		String sql="";
		if(type.equals("1")){			
			sql = "select r.id,r.name,'' as code,'' as starttime,";
			if(isupdate){
				sql=sql+" ( case when spd.id = "+id+" then 1 else 0 end ) as checked from Route r, Scheduleperselldays spd " +
						" where spd.typeid = r.id and r.isactive=1 and r.orgid = " +orgid;
			}else{
				sql=sql+" 0 as checked from Route r where r.isactive=1 and r.orgid = " +orgid;
			}
			if(routeid != 0){
				sql = sql+" and r.id = "+routeid;
			}
		}
		else if(type.equals("2")){
			sql = "select s.id,r.name,s.code,trim(s.starttime), " ;
			if(isupdate){
				sql=sql+" ( case when spd.id = "+id+" then 1 else 0 end ) as checked from Schedule s,Route r, Scheduleperselldays spd " +
						" where spd.typeid = s.id and s.routeid=r.id and s.isactive=1 and s.orgid ="+orgid;
			}else{
				sql=sql+" 0 as checked from Schedule s,Route r where s.routeid=r.id and s.isactive=1 and s.orgid ="+orgid;
			}			
			if(routeid != 0){
				sql= sql +" and r.id = "+routeid;
			}
		}			 
		sql=sql+" order by r.name ";
		Query query = getEntityManager().createNativeQuery(sql);
 		return query.getResultList(); 
	}		
}
