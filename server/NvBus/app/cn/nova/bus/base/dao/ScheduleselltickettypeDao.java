package cn.nova.bus.base.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Scheduleselltickettype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：班线可售票种设置</b><br/>
 * <b>类名称：</b>ScheduleselltickettypeDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ScheduleselltickettypeDao extends EntityManagerDaoSurport {

	
	public IDAO<Scheduleselltickettype> dao = new EntityManagerDaoSurport<Scheduleselltickettype>();
	
	public IDAO<Scheduleselltickettype> perselldaysdao;	
	
	/**
	 * 查询所有已经添加的可售票种
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findselltickettype(List<PropertyFilter> propertyFilterList) {		
		StringBuilder sql = new StringBuilder(
				 "select spd.id,o.id orgid,o.name orgname,case when spd.type=1 then '线路'")
		.append(" when spd.type=2 then '班次' when spd.type=0 then '全部班次' end typename,spd.type typecode ,")
		.append("case when spd.type =1 then r.name when spd.type = 2 then s.code else '全部' end typeidname,")
		.append("ty.name tickettypename,cu.name createname,up.name updatename,spd.createtime,")
		.append(" spd.updatetime,spd.type types,spd.typeid,cu.id createby,")
		.append(" spd.remarks,spd.tickettypeid,spd.synccode ")
		.append(",spd.canselltype,spd.cansellvalue")
		.append(",(case spd.canselltype when '-1' then '' when '0' then '张数' when '1' then '比率' else '' end) canselltypevalue ")
		.append(" from  Scheduleselltickettype spd left join route r on spd.type = 1 and spd.typeid = r.id")
		.append(" left join schedule s on spd.type = 2 and spd.typeid = s.id, tickettype ty,")
		.append(" organization o,userinfo cu,userinfo up")
		.append(" where spd.orgid = o.id and spd.createby= cu.id ")
		.append(" and spd.updateby= up.id and spd.tickettypeid = ty.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by spd.updatetime desc,spd.type ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
 		return query.getResultList(); 		
	}			

	@SuppressWarnings("unchecked")
	public List<Scheduleselltickettype> qryScheduleselltickettype(long orgid, String type,long typeid,long tickettypeid) {
		String sql = "select s from Scheduleselltickettype s " +
				" where s.orgid = "+ orgid +" and s.type = "+ type+" and s.typeid = "+typeid;
		if(tickettypeid!=0){
			sql = sql+" and s.tickettypeid = "+tickettypeid;
		}					
		return dao.find(sql);
	}	
	 
	public boolean updateScheduleselltickettype(long id, long typeid,long updateby,String remarks,String canselltype ,BigDecimal cansellvalue){
		String sql = "update Scheduleselltickettype sd  set sd.tickettypeid = "+typeid
				+",sd.canselltype='"+canselltype+"',sd.cansellvalue="+cansellvalue
				+" ,sd.updatetime= sysdate, sd.updateby= "+updateby;
		if(remarks!=null){
			sql = sql + " ,sd.remarks = '"+remarks+"'";
		}
		sql = sql +" where sd.id ="+id ;
		int result = dao.execute(sql);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * isupdate = false --> 查询本机构所有班线，待  添加
	 * isupdate = true --> 查询已经添加的所有班线 的可售票，待  修改
	 * @param orgid
	 * @param type
	 * @param isupdate
	 * @param id
	 * @param routeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findscheduleOrRoute(Long orgid,String type,boolean isupdate,long id,long routeid){
		String sql="";
		if(type.equals("1")){			
			sql = "select r.id,r.name,'' as code,'' as starttime,";
			if(isupdate){
				sql=sql+" max(a.checked) from (select r.id,( case when spd.id = "+id+" then 1 else 0 end ) as checked "
				+ "   from Route r, Scheduleselltickettype spd where spd.typeid = r.id and r.isactive = 1 and r.orgid  = "+orgid
				+ "   group by r.id, r.name, spd.id) a, route r where a.id = r.id group by r.id,r.name ";
			}else{
				sql=sql+" 0 as checked from Route r where r.isactive=1 and r.orgid = " +orgid;
			}
		}
		else if(type.equals("2")){
			sql = "select s.id,r.name,s.code,trim(s.starttime), " ;
			if(isupdate){
				sql=sql+" max(a.checked) from route r,schedule s,(select s.id,s.code,trim(s.starttime),"
				+ "	 ( case when spd.id = "+id+" then 1 else 0 end ) as checked from Schedule s,Scheduleselltickettype spd "
				+"	where spd.typeid = s.id and s.isactive=1 and s.orgid = "+orgid+" ) a where a.id = s.id and r.id = s.routeid "
				+"  group by r.name,s.code,s.starttime,s.id " ;
			}else{
				sql=sql+" 0 as checked from Schedule s,Route r where s.routeid=r.id and s.isactive=1 and s.orgid ="+orgid;
			}			
		}	
		if(routeid!=0){
			sql = sql+" and r.id = "+routeid;
		}
		sql = sql +" order by r.name ";
		Query query = getEntityManager().createNativeQuery(sql);
 		return query.getResultList();  		
	}	
	
	public boolean deleteScheduleselltickettype(long id ){
		return dao.delete(Scheduleselltickettype.class, id);
	}
	
	public Scheduleselltickettype saveScheduleselltickettype(Scheduleselltickettype type){
		return dao.merge(type);
	}

	/**
	 * 查询班次的可售票种
	 * @param scheduleid
	 * @return
	 */
	public List<Object> findCanSaleTicketType(long scheduleid){
		StringBuilder sb=  new StringBuilder();
		sb.append("select tt.code as tickettypecode")
		.append("   from Scheduleselltickettype spd, Schedule sc, Tickettype tt")
		.append("  where spd.tickettypeid = tt.id")
 		.append("    and sc.id =").append(scheduleid)
 		.append("    and spd.orgid = sc.orgid")
 		.append("    and (spd.type = '0' or (spd.type = '1' and spd.typeid = sc.routeid) or")
 		.append("        (spd.type = '2' and spd.typeid = sc.id))")
 		.append("    and spd.type=(select max(spd.type)")
 		.append("   from Scheduleselltickettype spd, Schedule sc")
 		.append("  where sc.id =").append(scheduleid)
 		.append("    and spd.orgid = sc.orgid")
 		.append("    and (spd.type = '0' or (spd.type = '1' and spd.typeid = sc.routeid) or")
 		.append("        (spd.type = '2' and spd.typeid = sc.id))")
 		.append("    having max(spd.type) is not null)");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		return query.getResultList();  		
	}
	
}
