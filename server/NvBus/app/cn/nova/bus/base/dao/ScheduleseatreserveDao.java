/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.dao<br/>
 * <b>文件名：</b>ScheduleseatreserveDao.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-8-11-下午06:47:22<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Scheduleseatreserve;
import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleseatreserveDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class ScheduleseatreserveDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleseatreserve(long scheduleid) {
		StringBuilder sql = new StringBuilder("select s,")
				.append(" vt.name as vehicletypename,")
				.append(" u1.name as createname,u2.name as updatename,vd.brandname")
				.append(" from Scheduleseatreserve s, Vehicletype vt,Vehiclebrandmodel vd,")
				.append(" Userinfo u1,Userinfo u2")
				.append(" where s.vehicletypeid = vt.id and s.scheduleid=:scheduleid")
				.append(" and s.createby=u1.id and s.updateby=u2.id and s.isactive=1")
				.append(" and s.vehiclebrandmodelid=vd.id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();

	}
	
	@SuppressWarnings("unchecked")
	public List<Schedule> qrySchedule(long routeid) {
		StringBuilder sql = new StringBuilder("select s")
				.append(" from Schedule s")
				.append(" where s.route.id=:routeid")
				.append(" and s.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean isExistSameRoute(Scheduleseatreserve scheduleseatreserve,long routeid) {
		StringBuilder sql = new StringBuilder("select ss")
				.append(" from Scheduleseatreserve ss,Schedule s")
				.append(" where ss.scheduleid=s.id  ")
				.append(" and ss.vehicletypeid =:vehicletypeid and ss.scheduleid=:scheduleid")
				.append(" and ss.isactive=1 and s.route.id=:routeid")
				.append(" and ((ss.startdate>=:startdate and ss.startdate<=:enddate) ")
				.append(" or (ss.startdate<=:startdate and ss.enddate>=:enddate)")
				.append(" or (ss.startdate<=:startdate and ss.enddate>=:startdate)")
				.append(" or (ss.startdate>=:startdate and ss.enddate<=:enddate))");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleseatreserve.getScheduleid());
		query.setParameter("vehicletypeid", scheduleseatreserve.getVehicletypeid());	
		query.setParameter("routeid", routeid);	
		query.setParameter("startdate", scheduleseatreserve.getStartdate());
		query.setParameter("enddate", scheduleseatreserve.getEnddate());		
		List<Scheduleseatreserve> list=query.getResultList();
		return list!=null&&list.size()>0?true:false;
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean isExistOtherByDate(Scheduleseatreserve scheduleseatreserve) {
		if (scheduleseatreserve.getId() == 0) {
			StringBuilder sql = new StringBuilder("select s")
					.append(" from Scheduleseatreserve s where s.scheduleid=:scheduleid")
					.append(" and s.vehicletypeid=:vehicletypeid and s.isactive=1 ")
					.append(" and ((s.startdate>=:startdate and s.startdate<=:enddate) ")
					.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
					.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
					.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
					.append(" and s.vehiclebrandmodelid=:vehiclebrandmodelid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid",
					scheduleseatreserve.getScheduleid());
			query.setParameter("vehicletypeid",
					scheduleseatreserve.getVehicletypeid());
			query.setParameter("startdate", scheduleseatreserve.getStartdate());
			query.setParameter("enddate", scheduleseatreserve.getEnddate());
			query.setParameter("vehiclebrandmodelid", scheduleseatreserve.getVehiclebrandmodelid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder("select s")
					.append(" from Scheduleseatreserve s where s.scheduleid=:scheduleid")
					.append(" and s.vehicletypeid=:vehicletypeid and s.isactive=1 ")
					.append(" and ((s.startdate>=:startdate and s.startdate<=:enddate) ")
					.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
					.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
					.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
					.append(" and s.vehiclebrandmodelid=:vehiclebrandmodelid")
					.append(" and s.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", scheduleseatreserve.getId());
			query.setParameter("scheduleid",
					scheduleseatreserve.getScheduleid());
			query.setParameter("vehicletypeid",
					scheduleseatreserve.getVehicletypeid());
			query.setParameter("startdate", scheduleseatreserve.getStartdate());
			query.setParameter("enddate", scheduleseatreserve.getEnddate());
			query.setParameter("vehiclebrandmodelid", scheduleseatreserve.getVehiclebrandmodelid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleVehiclebrandmodel(Long scheduleid) {
		StringBuilder sql = new StringBuilder("select DISTINCT vt.id,vt.brandname || '(' || vt.rationseatnum ||')' as brandname,vt.modelcode,vt.rationseatnum,")
				.append(" v.vehicletypeid")
				.append(" from Cycleschemes s,Cycleschemesschedule c,Cycleschemesvehicle v,Vehiclebrandmodel vt")
				.append(" where s=c.cyclescheme and c.scheduleid=:scheduleid")
				.append(" and v.cyclescheme=s and v.vehiclebrandmodelid=vt.id")
				.append(" and vt.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		List<Object> list= query.getResultList();
		return list;
	}
}
