package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
/**
 * @author lck
 * 
 */
@SuppressWarnings("rawtypes")
public class BalanceformulaapplyDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceformula(String orgids) {
		StringBuilder sql = new StringBuilder(
				"select b.id,b.formula,b.formulaname,b.parentid")
				.append(" from Balanceformula b")
				.append(" where b.isactive = 1 and b.orgid in "+orgids);
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceformulaapply(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select b.id,b.balanceformulaid,b.balancededucttargetid,")
				.append(" b.startdate,b.enddate,b.isaudited,b.isauditpass,")
				.append(" b.remarks,b.isactive,b.createtime,")
				.append(" b.createby,b.updatetime,b.updateby,u1.name as createname,u2.name as updatename,")
				.append(" s.code as schedulecode,r.name as routename,")
				.append(" u.name as unitname,v.vehicleno,bd.name as targetname,")
				.append(" ad.name as auditorname,bf.formulaname,")
				.append(" s.id as scheduleid,r.id as routeid,")
				.append(" u.id as unitid,v.id as vehicleid,")
				.append(" o.id as orgid,o.name as orgname,bf.parentid")
				.append(" from Balanceformulaapply b left join schedule s on b.scheduleid = s.id")
				.append(" left join unit u on b.unitid = u.id left join vehicle v on b.vehcileid = v.id left join route r on b.routeid = r.id")
				.append(" left join userinfo ad on b.auditor = ad.id left join organization o on b.orgid = o.id,")
				.append(" Balancededucttarget bd,Userinfo u1,Userinfo u2,Balanceformula bf")
				.append(" where b.createby=u1.id and b.updateby=u2.id")
				.append(" and b.isactive = 1 and b.balanceformulaid=bf.id")
				.append(" and b.balancededucttargetid=bd.id");
	    sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isExistApply(Balanceformulaapply balanceformulaapply) {
		StringBuilder sql = null;
		Query query = null;
		if (balanceformulaapply.getId() == 0) {
			if (balanceformulaapply.getBalancededucttargetid() == 1) {
				// 车牌+班次
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.vehicle.id=:vehicleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("scheduleid", balanceformulaapply
						.getSchedule().getId());
				query.setParameter("vehicleid", balanceformulaapply.getVehicle()
						.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 2) {
				// 营运单位+班次
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.unit.id=:unitid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("scheduleid", balanceformulaapply
						.getSchedule().getId());
				query.setParameter("unitid", balanceformulaapply.getUnit()
						.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 3) {
				// 车牌
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.vehicle.id=:vehicleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("vehicleid", balanceformulaapply.getVehicle()
						.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 4) {
				// 班次
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("scheduleid", balanceformulaapply
						.getSchedule().getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 5) {
				// 营运单位+线路
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid and s.route.id=:routeid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("unitid", balanceformulaapply.getUnit()
						.getId());
				query.setParameter("routeid", balanceformulaapply.getRoute()
						.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 6) {
				// 营运单位
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid ");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("unitid", balanceformulaapply.getUnit()
						.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 7) {
				// 线路
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.route.id=:routeid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("routeid", balanceformulaapply.getRoute()
						.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 8) {
				// 机构
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.org.id=:orgid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("orgid", balanceformulaapply.getOrg().getId());
			}
			if ("".equals(sql)) {
				return false;
			} else {
				List<Object> objlist = query.getResultList();
				return objlist != null && objlist.size() > 0 ? true : false;
			}
		} else {
			if (balanceformulaapply.getBalancededucttargetid() == 1) {
				// 车牌+班次
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.vehicle.id=:vehicleid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("scheduleid", balanceformulaapply
						.getSchedule().getId());
				query.setParameter("vehicleid", balanceformulaapply.getVehicle()
						.getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 2) {
				// 营运单位+班次
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid and s.unit.id=:unitid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("scheduleid", balanceformulaapply
						.getSchedule().getId());
				query.setParameter("unitid", balanceformulaapply.getUnit()
						.getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 3) {
				// 车牌
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.vehicle.id=:vehicleid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("vehicleid", balanceformulaapply.getVehicle()
						.getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 4) {
				// 班次
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.schedule.id=:scheduleid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("scheduleid", balanceformulaapply
						.getSchedule().getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 5) {
				// 营运单位+线路
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid and s.route.id=:routeid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("unitid", balanceformulaapply.getUnit()
						.getId());
				query.setParameter("routeid", balanceformulaapply.getRoute()
						.getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 6) {
				// 营运单位
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.unit.id=:unitid ")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("unitid", balanceformulaapply.getUnit()
						.getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 7) {
				// 线路
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.route.id=:routeid")
						.append(" and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("routeid", balanceformulaapply.getRoute()
						.getId());
				query.setParameter("id", balanceformulaapply.getId());
			} else if (balanceformulaapply.getBalancededucttargetid() == 8) {
				// 机构
				sql = new StringBuilder("select s from Balanceformulaapply s ")
						.append(" where s.balanceformulaid=:balanceformulaid and ")
						.append(" s.isactive=1 and s.balancededucttargetid=:balancededucttargetid")
						.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
						.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
						.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
						.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
						.append(" and s.org.id=:orgid and s.id!=:id");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("balanceformulaid",
						balanceformulaapply.getBalanceformulaid());
				query.setParameter("balancededucttargetid",
						balanceformulaapply.getBalancededucttargetid());
				query.setParameter("startdate",
						balanceformulaapply.getStartdate());
				query.setParameter("enddate", balanceformulaapply.getEnddate());
				query.setParameter("orgid", balanceformulaapply.getOrg().getId());
				query.setParameter("id", balanceformulaapply.getId());
			}
			if ("".equals(sql)) {
				return false;
			} else {
				List<Object> objlist = query.getResultList();
				return objlist != null && objlist.size() > 0 ? true : false;
			}
		}
	}
		
}
