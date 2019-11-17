package cn.nova.bus.price.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Holiday;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;


@SuppressWarnings("rawtypes")
public class HolidayDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> qryHoliday(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select h,u.name as username from Holiday h,Userinfo u where h.createby=u.id ")
		.append(" and h.isactive=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by h.startdate");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public boolean isExistDelHoliday(Holiday holiday) {
		StringBuilder sql = new StringBuilder
				("select h from Holiday h where h.fullname=:fullname and h.orgid=:orgid")
		.append(" and h.isactive=0 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fullname", holiday.getFullname());
		query.setParameter("orgid", holiday.getOrgid());
		List<Object> list = query.getResultList();
		return list!=null && list.size()>0?true:false;
	}
	@SuppressWarnings("unchecked")
	public boolean isExistActiveHoliday(Holiday holiday) {
		if(holiday.getId()==0){
			StringBuilder sql = new StringBuilder
					("select h from Holiday h where h.fullname=:fullname and h.orgid=:orgid")
			.append(" and h.isactive=1 ");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("fullname", holiday.getFullname());
			query.setParameter("orgid", holiday.getOrgid());
			List<Object> list = query.getResultList();
			return list!=null && list.size()>0?true:false;
		}
		else
		{
			StringBuilder sql = new StringBuilder
			("select h from Holiday h where h.fullname=:fullname and h.orgid=:orgid")
			.append(" and h.isactive=1 and h.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("fullname", holiday.getFullname());
			query.setParameter("orgid", holiday.getOrgid());
			query.setParameter("id", holiday.getId());
			List<Object> list = query.getResultList();
			return list!=null && list.size()>0?true:false;
			
		}
	}
	public Holiday getHolidaybyName(Holiday holiday) {
		StringBuilder sql = new StringBuilder
				("select h from Holiday h where h.fullname=:fullname and h.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fullname", holiday.getFullname());
		query.setParameter("orgid", holiday.getOrgid());
		return (Holiday) query.getSingleResult();
	}
	//节日日期不能交叉，即使名称不一样
	@SuppressWarnings("unchecked")
	public boolean isExistHolidayByDate(Holiday holiday) {
		if (holiday.getId() == 0) {
			StringBuilder sql = new StringBuilder("select h from Holiday h ")
						.append(" where h.orgid=:orgid and h.isactive=1")
						.append(" and ((h.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
						.append(" or (h.startdate<=:startdate and h.enddate>=:startdate)")
						.append(" or (h.startdate>=:startdate and h.enddate<=:enddate))");
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("startdate",holiday.getStartdate());
				query.setParameter("enddate", holiday.getEnddate());
				query.setParameter("orgid",holiday.getOrgid());
				List<Object> objlist = query.getResultList();
				return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder("select h from Holiday h ")
			.append(" where h.orgid=:orgid and h.isactive=1 and h.id!=:id")
			.append(" and ((h.startdate>=:startdate and startdate<=:enddate) ")
			.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
			.append(" or (h.startdate<=:startdate and h.enddate>=:startdate)")
			.append(" or (h.startdate>=:startdate and h.enddate<=:enddate))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("startdate",holiday.getStartdate());
			query.setParameter("enddate", holiday.getEnddate());
			query.setParameter("orgid",holiday.getOrgid());
			query.setParameter("id",holiday.getId());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}
	
	public List<Object> getHolidayPrice() {
		StringBuilder sql = new StringBuilder
				("select  h.fullname,to_char(h.startdate,'yyyy')|| '年' ||  to_char(h.startdate,'MM')|| '月' ||to_char(h.startdate,'dd')  || '日' as startdate,");
		sql.append(" to_char(h.enddate,'yyyy')|| '年' ||  to_char(h.enddate,'MM')|| '月' ||to_char(h.enddate,'dd')  || '日' as enddate,")
		.append(" r.name as routename,s.code,trim(s.starttime),v.name as typename,s.planseatnum ,st.name as endstationname,hh.fullprice ,hh.halfprice ,s.viastation  ")
		.append("  from handholidayprice hh,schedule s, vehicletype v,holiday h,route r, station st ")
		.append(" where hh.holidayid = h.id  and hh.vehicletypeid = v.id")
		.append(" and hh.scheduleid = s.id and s.routeid = r.id  and hh.reachstationid = st.id ")
		.append(" order by h.fullname,s.code,v.code  desc,hh.fullprice desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return  query.getResultList();
	}
	public List<Handholidayprice> getHandholidaypriceByHolidayid(long id) {
		StringBuilder sql = new StringBuilder("select t from  Handholidayprice t where t.holidayid = :holidayid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("holidayid", id);
		return query.getResultList();
	}

	public boolean isHolidayAcrossEachother(Holiday holiday) {
		StringBuilder sql = new StringBuilder(
				"select count(t.id) from holiday t where ((t.startdate between :startdate and :enddate) or (t.enddate between :startdate and :enddate)) and t.isactive = 1 ");
		sql.append(holiday.getId()!=0?" and t.id<>"+holiday.getId() : "");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", holiday.getStartdate());
		query.setParameter("enddate", holiday.getEnddate());
		List list = query.getResultList();
		BigDecimal count = (BigDecimal) list.get(0);
		return count.compareTo(BigDecimal.ZERO)>0?true:false;
	}
}
