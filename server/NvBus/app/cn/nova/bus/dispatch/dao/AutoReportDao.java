package cn.nova.bus.dispatch.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

public class AutoReportDao extends EntityManagerDaoSurport {
  public List<Object> qryScheduleVehiclePeoplan(){
	  StringBuilder sql = new StringBuilder("select svp.scheduleplanid,svp.orgid,svp.departdate,svp.scheduleid,svp.orderno,svp.planvehicleid, ");
	  sql.append(" svp.plandriver1id,svp.plandriver2id,svp.plandriver3id,svp.plandriver4id,svp.plansteward1id,svp.plansteward2id")
	  .append(" from schedulevehiclepeopleplan svp left join schedule s on svp.scheduleid = s.id")
	  .append(" left join scheduleplan sp on svp.scheduleplanid = sp.id")
	  .append(" where 1 = 1 and sp.scheduleid = s.id and s.isactive = 1 and s.isautoreport = 1")
	  .append(" and svp.planvehicleid is not null")
	  .append(" and sp.departdate = trunc(sysdate)") //查询明天的班次
	  .append(" order by svp.orderno");
	  Query query = getEntityManager().createNativeQuery(sql.toString());
	  return query.getResultList();
  }
  public Long qryUserId(){
	  StringBuilder sql = new StringBuilder("select u.id from userinfo u where u.code = 'ADMIN'");
	  Query query = getEntityManager().createNativeQuery(sql.toString());
	  List<Object> list = query.getResultList();
	  if(list!=null && list.size()>0){
		  return Long.parseLong(list.get(0).toString()); 
	  }else{
		  return Long.parseLong("0");  
	  }
	  
  }
  public boolean isExistVehicleReport(Long scheduleplanid,Date departdate,Short orderno,Long scheduleid){
	  StringBuilder sql = new StringBuilder("select count(vr.id) from vehiclereport vr");
	  sql.append(" where 1=1 and vr.isactive=1")
	  .append(" and vr.scheduleplanid =:scheduleplanid and vr.departdate =:departdate")
	  .append(" and vr.orderno = :orderno and vr.scheduleid =:scheduleid");
	  Query query = getEntityManager().createNativeQuery(sql.toString());	  
	  query.setParameter("scheduleplanid",scheduleplanid);
	  query.setParameter("departdate",departdate);
	  query.setParameter("orderno",orderno);
	  query.setParameter("scheduleid",scheduleid);
	  List<Object> list = query.getResultList();
	  if(list!=null || list.size()>0){
		  Object object = (Object)list.get(0);
		  if (Integer.parseInt(object.toString())>0){
			  return true;  
		  }
		  else{
			  return false; 
		  }
		  
	  }else{
		  return false;  
	  }
  }
  
  public boolean updateScheduestaus(Long scheduleplanid,Date departdate,Long scheduleid,Long userid){
	 StringBuilder sql = new StringBuilder("update schedulestatus ss set ss.isreported  = 1,ss.isbegincheck = 1,ss.updateby =:userinfoid,ss.updatetime = sysdate"); 
	 sql.append(" where ss.scheduleplanid = :scheduleplanid and ss.departdate = :departdate and ss.scheduleid = :scheduleid"); 
	 Query query = getEntityManager().createNativeQuery(sql.toString());
	 query.setParameter("userinfoid",userid);
	 query.setParameter("scheduleplanid",scheduleplanid);
	 query.setParameter("departdate",departdate);
	 query.setParameter("scheduleid",scheduleid);
	 return query.executeUpdate()>0?true:false; 
  }
  
}
