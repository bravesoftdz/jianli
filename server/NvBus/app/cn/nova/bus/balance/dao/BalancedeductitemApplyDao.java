package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BalancedeductitemApplyDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> queryBalancedeductitemApply(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = null;
		sql = new StringBuilder(
				"select b.id,b.balancedeductitemid,b.balancededucttargetid,")
				.append(" b.startdate,b.enddate,b.isaudited,b.isauditpass,")
				.append(" b.remarks,b.isactive,b.createtime,")
				.append(" b.createby,b.updatetime,b.updateby,u1.name as createname,u2.name as updatename,")
				.append(" s.code as schedulecode,r.name as routename,")
				.append(" u.name as unitname,v.vehicleno,bd.name as targetname,")
				.append(" bi.name as itemname,ad.name as auditorname,")
				.append(" s.id as scheduleid,r.id as routeid,")
				.append(" u.id as unitid,v.id as vehicleid,")
				.append(" o.id as orgid,o.name as orgname,")
				.append(" bi.deducttype,bi.deductmoney,bi.isdeductbeforebalance")
				.append(" from Balancedeductapply b left join schedule s on b.scheduleid = s.id")
				.append(" left join unit u on b.unitid = u.id left join vehicle v on b.vehcileid = v.id left join route r on b.routeid = r.id")
				.append(" left join userinfo ad on b.auditor = ad.id left join organization o on b.orgid = o.id,")
				.append(" Balancededucttarget bd,Userinfo u1,Userinfo u2,Balancedeductitem  bi")
				.append(" where b.createby=u1.id and b.updateby=u2.id")
				.append(" and b.isactive = 1 and b.balancedeductitemid=bi.id")
				.append(" and b.balancededucttargetid=bd.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by b.balancedeductitemid,b.startdate");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public boolean isExistApply(Balancedeductapply balancedeductapply) {
		StringBuilder sql = null;
		Query query = null;
		if (balancedeductapply.getId() == 0) {
			if (balancedeductapply.getBalancededucttargetid() == 1) {
				// 车牌+班次
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.vehicle.id=:vehicleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("scheduleid", balancedeductapply
						.getSchedule().getId());
				query.setParameter("vehicleid", balancedeductapply.getVehicle()
						.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 2) {
				// 营运单位+班次
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.unit.id=:unitid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("scheduleid", balancedeductapply
						.getSchedule().getId());
				query.setParameter("unitid", balancedeductapply.getUnit()
						.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 3) {
				// 车牌
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.vehicle.id=:vehicleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("vehicleid", balancedeductapply.getVehicle()
						.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 4) {
				// 班次
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("scheduleid", balancedeductapply
						.getSchedule().getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 5) {
				// 营运单位+线路
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid and s.route.id=:routeid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("unitid", balancedeductapply.getUnit()
						.getId());
				query.setParameter("routeid", balancedeductapply.getRoute()
						.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 6) {
				// 营运单位
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid ");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("unitid", balancedeductapply.getUnit()
						.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 7) {
				// 线路
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.route.id=:routeid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("routeid", balancedeductapply.getRoute()
						.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 8) {
				// 机构
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.org.id=:orgid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("orgid", balancedeductapply.getOrg().getId());
			}
			if ("".equals(sql)) {
				return false;
			} else {
				List<Object> objlist = query.getResultList();
				return objlist != null && objlist.size() > 0 ? true : false;
			}
		} else {
			if (balancedeductapply.getBalancededucttargetid() == 1) {
				// 车牌+班次
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.vehicle.id=:vehicleid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("scheduleid", balancedeductapply
						.getSchedule().getId());
				query.setParameter("vehicleid", balancedeductapply.getVehicle()
						.getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 2) {
				// 营运单位+班次
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.unit.id=:unitid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("scheduleid", balancedeductapply
						.getSchedule().getId());
				query.setParameter("unitid", balancedeductapply.getUnit()
						.getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 3) {
				// 车牌
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.vehicle.id=:vehicleid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("vehicleid", balancedeductapply.getVehicle()
						.getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 4) {
				// 班次
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("scheduleid", balancedeductapply
						.getSchedule().getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 5) {
				// 营运单位+线路
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid and s.route.id=:routeid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("unitid", balancedeductapply.getUnit()
						.getId());
				query.setParameter("routeid", balancedeductapply.getRoute()
						.getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 6) {
				// 营运单位
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid ")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("unitid", balancedeductapply.getUnit()
						.getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 7) {
				// 线路
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.route.id=:routeid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("routeid", balancedeductapply.getRoute()
						.getId());
				query.setParameter("id", balancedeductapply.getId());
			} else if (balancedeductapply.getBalancededucttargetid() == 8) {
				// 机构
				sql = new StringBuilder("select s from Balancedeductapply s ")
						.append(" where s.balancedeductitemid=:balancedeductitemid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.org.id=:orgid and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balancedeductitemid",
						balancedeductapply.getBalancedeductitemid());
				query.setParameter("balancededucttargetid",
						balancedeductapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balancedeductapply.getStartdate());
				query.setParameter("enddate", balancedeductapply.getEnddate());
				query.setParameter("orgid", balancedeductapply.getOrg().getId());
				query.setParameter("id", balancedeductapply.getId());
			}

			if ("".equals(sql)) {
				return false;
			} else {
				List<Object> objlist = query.getResultList();
				return objlist != null && objlist.size() > 0 ? true : false;
			}
		}
	}
	
	
	public boolean delBalancedeductapplysell(long applyid) {
		StringBuilder sql = null;
		sql = new StringBuilder(
				"delete Balancedeductapplysell s where s.balancedeductapplyid=:applyid");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("applyid", applyid);
		query.executeUpdate();
		return true;

	}
	public  List<Object>  qyrBalancedeductapplysell(long applyid) {
		StringBuilder sql = null;
		sql = new StringBuilder(" select 1 isselect, t.dataid, org.name,t.type,'售票点' as typename")
		.append(" from balancedeductapplysell t, ticketoutlets org")
		.append(" where t.dataid = org.id  and t.type='1' and t.balancedeductapplyid=:applyid")
		.append(" union all")
		.append(" select 0 isselect,org.id as dataid, org.name,'1' type,'售票点' as typename")
		.append(" from ticketoutlets org")
		.append(" where org.type='1' and org.isactive=1 and  org.id not in (")
		.append(" select dataid from balancedeductapplysell t where t.type='1' and  t.balancedeductapplyid=:applyid)");
		
		
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("applyid", applyid);
		
		return query.getResultList();

	}
}
