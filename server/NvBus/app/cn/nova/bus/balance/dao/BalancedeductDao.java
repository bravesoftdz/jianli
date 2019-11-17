package cn.nova.bus.balance.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;


import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.model.ScheduleLostTreatments;
import cn.nova.bus.balance.model.VehicleParkFee;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.TicketpriceformulaDao;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Fuelfeegradedetail;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BalancedeductDao extends EntityManagerDaoSurport {
	
	private TicketpriceformulaDao ticketpriceformulaDao = new TicketpriceformulaDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	/**
	 * 根据发班id查询发班code
	 * @param Scheduleid
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	public String queryScheduleCode(Long Scheduleid) {
		StringBuilder sql = new StringBuilder(
				" select t.code from Schedule t  where t.id= :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", Scheduleid);
		return (String) query.getSingleResult();
	}

	
	// 查询公式扣费项应用
	@SuppressWarnings("unchecked")
	public Balanceformulaapply getFormulaapply(Date departdate,
			Vehicle vehicle, Schedule schedule) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balanceformula b,Balanceformulaapply ba,Balancededucttarget bg")
				.append(" where b.formulatype='0' and b.isactive=1")
				.append(" and b.id=ba.balanceformulaid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ( (ba.vehicle=:vehicle and ba.schedule=null) or (ba.vehicle=:vehicle and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" and b.orgid=:orgid")
				.append(" order by bg.prioritylevel");
		Query query = em.createQuery(sql.toString());
		// query.setParameter("formulaname", formulaname);
		query.setParameter("schedule", schedule);
		query.setParameter("vehicle", vehicle);
		query.setParameter("unitid", vehicle.getUnitid());
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		query.setParameter("departdate", departdate);
		List<Balanceformulaapply> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询公式扣费子扣费项应用
	@SuppressWarnings("unchecked")
	public Balanceformulaapply findChildFormulaapply(long parentid,
			Date departdate, Schedule schedule, Vehicle vehicle) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balanceformula b,Balanceformulaapply ba,Balancededucttarget bg")
				.append(" where b.parentid=:parentid and b.isactive=1")
				.append(" and b.id=ba.balanceformulaid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ( (ba.vehicle=:vehicle and ba.schedule=null) or (ba.vehicle=:vehicle and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" order by bg.prioritylevel");
		Query query = em.createQuery(sql.toString());
		query.setParameter("parentid", parentid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		query.setParameter("vehicle", vehicle);
		query.setParameter("unitid", vehicle.getUnitid());
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		List<Balanceformulaapply> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询其他固定扣费项
	@SuppressWarnings("unchecked")
	public Balancedeductapply findBalancedeductitemapply(long departorgid,
			Date departdate, Schedule schedule, Vehicle vehicle,
			boolean isdeductbeforebalance, long balancedeductitemid) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balancedeductitem b,Balancedeductapply ba,Balancededucttarget bg")
				.append(" where b.parentid=0 and b.isactive=1 ")
				.append(" and b.isdeductbeforebalance=:isdeductbeforebalance")
				.append(" and b.id=ba.balancedeductitemid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ba.balancededucttargetid=bg.id and b.orgid=:departorgid")
				// .append(" and b.name!='站务费' and  b.name!='燃油费'")
				.append(" and ( (ba.vehicle=:vehicle and ba.schedule=null) or (ba.vehicle=:vehicle and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" and b.id=:balancedeductitemid order by bg.prioritylevel");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departorgid", departorgid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		query.setParameter("isdeductbeforebalance", isdeductbeforebalance);
		query.setParameter("vehicle", vehicle);
		query.setParameter("unitid", vehicle.getUnitid());
		query.setParameter("balancedeductitemid", balancedeductitemid);
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		List<Balancedeductapply> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询其他固定扣费项
	@SuppressWarnings("unchecked")
	public List<Balancedeductapply> findBalancedeductitemapply(
			long departorgid, Date departdate, Schedule schedule,
			Vehicle vehicle, boolean isdeductbeforebalance) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balancedeductitem b,Balancedeductapply ba,Balancededucttarget bg")
				.append(" where b.parentid=0 and b.isactive=1 ")
				.append(" and b.isdeductbeforebalance=:isdeductbeforebalance")
				.append(" and b.id=ba.balancedeductitemid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ba.balancededucttargetid=bg.id and b.orgid=:departorgid")
				// .append(" and b.name!='站务费' and  b.name!='燃油费'")
				.append(" and ( (ba.vehicle=:vehicle and ba.schedule=null) or (ba.vehicle=:vehicle and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" order by bg.prioritylevel");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departorgid", departorgid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		query.setParameter("isdeductbeforebalance", isdeductbeforebalance);
		query.setParameter("vehicle", vehicle);
		query.setParameter("unitid", vehicle.getUnitid());
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		return query.getResultList();

	}

	// 查询其他固定扣费项
	@SuppressWarnings("unchecked")
	public List<Balancedeductitem> findBalancedeductite(long departorgid,
			Date departdate, Schedule schedule, Vehicle vehicle,
			boolean isdeductbeforebalance,boolean isexpress) {
		StringBuilder sql = new StringBuilder(
				"select distinct b from Balancedeductitem b,Balancedeductapply ba")
				.append(" where b.parentid=0 and b.isactive=1 ")
				.append(" and b.isdeductbeforebalance=:isdeductbeforebalance")
				.append(" and b.id=ba.balancedeductitemid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and b.orgid=:departorgid and b.isexpress=:isexpress")
				// .append(" and b.name!='站务费' and  b.name!='燃油费'")
				.append(" and ( (ba.vehicle=:vehicle and ba.schedule=null) or (ba.vehicle=:vehicle and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid )");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departorgid", departorgid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		query.setParameter("isdeductbeforebalance", isdeductbeforebalance);
		query.setParameter("isexpress", isexpress);		
		query.setParameter("vehicle", vehicle);
		query.setParameter("unitid", vehicle.getUnitid());
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		List<Balancedeductitem> list = query.getResultList();
		return list;

	}

	// 查询票价组成项的扣费
	@SuppressWarnings("unchecked")
	public List<Balancedeductapply> findBalancedeductitemapply(
			long departorgid, Date departdate, Schedule schedule,
			String itemcode) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balancedeductitem b,Balancedeductapply ba,Balancededucttarget bg,Ticketpriceformulaitem tp")
				.append(" where b.parentid=0 and b.isactive=1 ")
				// .append(" and b.isdeductbeforebalance=:isdeductbeforebalance")
				.append(" and b.name=tp.name and b.orgid=tp.orgid and tp.code=:itemcode and tp.isactive=1")
				.append(" and b.id=ba.balancedeductitemid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ba.balancededucttargetid=bg.id and b.orgid=:departorgid")
				.append(" and (ba.schedule=:schedule")
				.append(" or ba.route.id=:routeid")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" order by bg.prioritylevel");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departorgid", departorgid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		// query.setParameter("isdeductbeforebalance", isdeductbeforebalance);
		// query.setParameter("vehicle", vehicle);
		query.setParameter("itemcode", itemcode);
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		return query.getResultList();
	}

	// 查询其他扣费子扣费项应用
	@SuppressWarnings("unchecked")
	public Balancedeductapply findChilddeductitemapply(long parentid,
			Date departdate, Schedule schedule, long unitid, long vehicleid,
			boolean isdeductbeforebalance) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balancedeductitem b,Balancedeductapply ba,Balancededucttarget bg")
				.append(" where b.parentid=:parentid and b.isactive=1 ")
				.append(" and b.isdeductbeforebalance=:isdeductbeforebalance")
				.append(" and b.id=ba.balancedeductitemid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ( (ba.vehicle.id=:vehicleid and ba.schedule=null) or (ba.vehicle.id=:vehicleid and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" order by bg.prioritylevel");
		Query query = em.createQuery(sql.toString());
		query.setParameter("parentid", parentid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		query.setParameter("isdeductbeforebalance", isdeductbeforebalance);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("unitid", unitid);
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		List<Balancedeductapply> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 1、查询结算时按班次的固定扣费是否已经扣过
	@SuppressWarnings("unchecked")
	public boolean isDeductitemBySchedule(long reportid, long balanceitemid) {
		StringBuilder sql = new StringBuilder(
				"select d from Departinvoicesdeductdetail d,Departinvoices ds")
				.append(" where ds.reportid=:reportid and d.balanceitemid=:balanceitemid")
				.append(" and d.status!='1' and d.departinvoices=ds");
		Query query = em.createQuery(sql.toString());
		query.setParameter("reportid", reportid);
		query.setParameter("balanceitemid", balanceitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 2、查询结算时按车天的固定扣费是否已经扣过
	@SuppressWarnings("unchecked")
	public boolean isDeductitemByVehicleDay(Date departdate,
			long balanceitemid, long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select d from Departinvoicesdeductdetail d,Departinvoices ds")
				.append(" where ds.vehicleid=:vehicleid and d.balanceitemid=:balanceitemid")
				.append(" and d.status!='1' and d.departinvoices=ds")
				.append(" and ds.departdate=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("balanceitemid", balanceitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 3、 查询结算时按月的固定扣费是否已经扣过
	@SuppressWarnings("unchecked")
	public boolean isDeductitemByVehicleMonth(Date firstDay, Date lastDay,
			long balanceitemid, long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select d from Departinvoicesdeductdetail d,Departinvoices ds")
				.append(" where ds.vehicleid=:vehicleid and d.balanceitemid=:balanceitemid")
				.append(" and d.status!='1' and d.departinvoices=ds")
				.append(" and ds.departdate>=:firstDay and ds.departdate<=:lastDay");
		Query query = em.createQuery(sql.toString());
		query.setParameter("firstDay", firstDay);
		query.setParameter("lastDay", lastDay);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("balanceitemid", balanceitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 4、查询结算时按车属单位天的固定扣费是否已经扣过
	@SuppressWarnings("unchecked")
	public boolean isDeductitemByUnitDay(Date departdate, long balanceitemid,
			long unitid) {
		StringBuilder sql = new StringBuilder(
				"select d from Departinvoicesdeductdetail d,Departinvoices ds,Vehicle v")
				.append(" where v.unitid=:unitid and d.balanceitemid=:balanceitemid")
				.append(" and d.status!='1' and d.departinvoices=ds")
				.append(" and ds.departdate=:departdate and ds.vehicleid=v.id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("unitid", unitid);
		query.setParameter("balanceitemid", balanceitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 5、 查询结算时按月的固定扣费是否已经扣过
	@SuppressWarnings("unchecked")
	public boolean isDeductitemByUnitMonth(Date firstDay, Date lastDay,
			long balanceitemid, long unitid) {
		StringBuilder sql = new StringBuilder(
				"select d from Departinvoicesdeductdetail d,Departinvoices ds,Vehicle v")
				.append(" where ds.vehicleid=v.id and d.balanceitemid=:balanceitemid")
				.append(" and d.status!='1' and d.departinvoices=ds")
				.append(" and ds.departdate>=:firstDay and ds.departdate<=:lastDay")
				.append(" and v.unitid=:unitid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("firstDay", firstDay);
		query.setParameter("lastDay", lastDay);
		query.setParameter("unitid", unitid);
		query.setParameter("balanceitemid", balanceitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 查询站务费扣费
	@SuppressWarnings("unchecked")
	public Balancedeductapply getBalancedeductitemapply(long departorgid,
			Date departdate, Schedule schedule, long unitid, long vehicleid,
			String itemname) {
		StringBuilder sql = new StringBuilder(
				"select ba from Balancedeductitem b,Balancedeductapply ba,Balancededucttarget bg")
				.append(" where b.parentid=0 and b.isactive=1 ")
				.append(" and b.isdeductbeforebalance=1")
				.append(" and b.id=ba.balancedeductitemid and ba.isactive=1 and ba.isaudited=1")
				.append(" and ba.startdate<=:departdate and ba.enddate>=:departdate")
				.append(" and ba.balancededucttargetid=bg.id and b.orgid=:departorgid")
				.append(" and b.name=:itemname")
				.append(" and ( (ba.vehicle.id=:vehicleid and ba.schedule=null) or (ba.vehicle.id=:vehicleid and ba.schedule=:schedule) ")
				.append(" or (ba.unit.id=:unitid and ba.schedule=:schedule)")
				.append(" or ba.schedule=:schedule")
				.append(" or (ba.unit.id=:unitid and  ba.route.id=:routeid)")
				.append(" or (ba.unit.id=:unitid and  ba.route=null and ba.schedule=null) ")
				.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
				.append(" or ba.org.id=:orgid) and ba.balancededucttargetid=bg.id")
				.append(" order by bg.prioritylevel");

		Query query = em.createQuery(sql.toString());
		query.setParameter("departorgid", departorgid);
		query.setParameter("departdate", departdate);
		query.setParameter("schedule", schedule);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("itemname", itemname);
		query.setParameter("unitid", unitid);
		query.setParameter("routeid", schedule.getRoute().getId());
		query.setParameter("orgid", schedule.getOrgid());
		List<Object> list = query.getResultList();
		return (Balancedeductapply) (list != null && list.size() > 0 ? list
				.get(0) : null);
	}

	// 查询结算时生成的的固定扣费
	public BigDecimal qryOthterDeductfee(String invoicesids) {
		StringBuilder sql = new StringBuilder(
				"select sum(d.deductmoney) from Departinvoicesdeductdetail d")
				.append(" where d.status='0' and d.departinvoicesid in "
						+ invoicesids).append(
						" and d.isdeductbeforebalance=0 and d.type='2'");
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return (BigDecimal) (list != null && list.size() > 0 ? list.get(0) : 0);
	}
	//// 返回打单时的扣费明细，用于班次发班时的扣费调用
	@SuppressWarnings("unchecked")
	public List<Object>  qryDeductfee(long departinvoiceid) {
		StringBuilder sql = new StringBuilder(
				"select b.code,d.deductmoney from Departinvoicesdeductdetail d,Balancedeductitem b")
				.append(" where d.balanceitemid=b.id and d.departinvoices.id=:departinvoiceid")
				.append(" and d.type='2'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoiceid", departinvoiceid);
		return  query.getResultList();
	}
	// 查询结算时生成的的固定扣费
	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceDeduct(long balanceid,
			Boolean isdeductbeforebalance) {
		StringBuilder sql = new StringBuilder(
				"select bi.name,sum(d.deductmoney),bi.isticketpriceitem ")
				.append(" from Departinvoicesdeductdetail d,Balancedeductitem bi")
				.append(" where d.balanceitemid=bi.id and d.status='2'  ")
				.append(" and d.type='2' and d.balanceid=:balanceid ");
		if (isdeductbeforebalance) {
			sql.append(" and bi.isdeductbeforebalance!=1 ");
		}
		sql.append("  group by bi.name,bi.isticketpriceitem");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		List<Object> list = query.getResultList();
		sql = new StringBuilder(
				"select bi.formulaname as name,sum(d.deductmoney),0 as isticketpriceitem ")
				.append(" from Departinvoicesdeductdetail d,Balanceformula bi")
				.append(" where d.balanceitemid=bi.id and d.status='2'  ")
				.append(" and d.type='1' and d.balanceid=:balanceid");
		if (isdeductbeforebalance) {
			sql.append(" and d.isdeductbeforebalance!=1 ");
		}
		sql.append(" group by bi.formulaname");
		query = em.createNativeQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		list.addAll(query.getResultList());
		return list;
	}

	// 查询车票的固定扣费金额
	@SuppressWarnings("unchecked")
	public BigDecimal qryTicketDeduct(long scheduleplanid, String ticketids,
			String name) {
		try {
			StringBuilder sql = new StringBuilder("select sum(tpi.price)")
					.append(" from Ticketsell ts, ticketprice tp,ticketpriceitem tpi,ticketpriceformulaitem tf")
					.append(" where ts.scheduleplanid = tp.scheduleplanid")
					.append(" and ts.departstationid = tp.departstationid")
					.append(" and ts.reachstationid = tp.reachstationid")
					.append(" and ts.seattype=tp.seattype and ts.scheduleplanid =:scheduleplanid")
					.append(" and tp.id=tpi.ticketpriceid ")
					.append(" and tpi.isautoadjust=0 and tpi.tickettype=decode(ts.tickettype,'X','Q','B','Q','Q') ")
					.append(" and tpi.ticketpriceformulaitemid=tf.id and tf.name=:name")
					.append(" and ts.id in " + ticketids);
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			query.setParameter("name", name);
			List<Object> list = query.getResultList();
			return (BigDecimal) (list != null && list.size() > 0
					&& list.get(0) != null ? list.get(0) : new BigDecimal(0));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return new BigDecimal(0);
		}
	}
	// 查询车票的固定扣费金额
	@SuppressWarnings("unchecked")
	public BigDecimal qryTicketDeduct(String ticketids,String bicode) {
		try {
			String bisum="";
			if(bicode.equals("E")){
				bisum=" sum(computefee) ";
			}else if(bicode.equals("G")){
				bisum=" sum(coolairfee) ";
			}else if(bicode.equals("D")){
				bisum=" sum(additionfee) ";
			}else if(bicode.equals("H")){
				bisum=" sum(waterfee) ";
			}else if(bicode.equals("I")){
				bisum=" sum(insurefee) ";
			}else if(bicode.equals("J")){
				bisum=" sum(otherfee) ";
			}else if(bicode.equals("C")){
				bisum=" sum(stationservicefee) ";
			}else if(bicode.equals("K")){
				bisum=" sum(fueladditionfee) ";
			}else{
				bisum=" sum(0) ";
			}
			StringBuilder sql = new StringBuilder("select "+bisum)
					.append(" from Ticketsell ts")
					.append(" where ts.id in " + ticketids);
			Query query = em.createNativeQuery(sql.toString());
			List<Object> list = query.getResultList();
			return (BigDecimal) (list != null && list.size() > 0
					&& list.get(0) != null ? list.get(0) : new BigDecimal(0));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return new BigDecimal(0);
		}
	}
	// 查询车票的固定扣费金额
	@SuppressWarnings("unchecked")
	public BigDecimal qryTicketDeduct(Date departdate,long schduleid, long departstationid,
			long reachstationid,String name) {
		try {
			StringBuilder sql = new StringBuilder("select sum(tpi.price)")
					.append(" from Ticketprice tp,ticketpriceitem tpi,ticketpriceformulaitem tf")
					.append(" where tp.departstationid=:departstationid")
					.append(" and tp.reachstationid=:reachstationid")
					.append(" and tp.id=tpi.ticketpriceid ")
					.append(" and tpi.isautoadjust=0 and tpi.tickettype='Q' ")
					.append(" and tpi.ticketpriceformulaitemid=tf.id and tf.name=:name")
					.append(" and tp.departdate=:departdate")
					.append(" and tp.scheduleid=:schduleid");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("departstationid", departstationid);
			query.setParameter("reachstationid", reachstationid);
			query.setParameter("departdate", departdate);
			query.setParameter("schduleid", schduleid);
			query.setParameter("name", name);
			List<Object> list = query.getResultList();
			return (BigDecimal) (list != null && list.size() > 0
					&& list.get(0) != null ? list.get(0) : new BigDecimal(0));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return new BigDecimal(0);
		}
	}
	// 查询车票的固定扣费金额
	@SuppressWarnings("unchecked")
	public BigDecimal qryTicketDeduct(Ticketsell ticket, String code, long orgid) {
		try {
			String tickettype = "Q";
			//改为统一取全票票价的扣费
			/*
			if (!ticket.getTickettype().equals("Q")
					&& !ticket.getTickettype().equals("B")
					&& !ticket.getTickettype().equals("X")) {
				tickettype = "Q";
			} else {
				tickettype = ticket.getTickettype();
			}
			 */
			//增加参数1080 控制站务费可以设置为票价区间相关，公里数相关来取不同的值。
			String para_1080 = parameterService.findParamValue("1080", orgid);
			if("1".equals(para_1080)&&"C".equals(code)){
				Ticketpriceformulaitem ticketpriceformulaitem = ticketpriceformulaDao.qryformulaitem(
						orgid, code.charAt(0));
				//票价区间相关时，取票价公式中计算站务费
				if("7".equals(ticketpriceformulaitem.getRelatetype())){
					return qryStationPrice7(ticketpriceformulaitem,ticket);
				//公里区间相关时，取票价公式中计算的站务费
				}else if("8".equals(ticketpriceformulaitem.getRelatetype())){
					return qryStationPrice8(ticketpriceformulaitem,ticket);
				//固定值相关时，取票价公式中设置的站务费
				}else if("9".equals(ticketpriceformulaitem.getRelatetype())){
					return ticketpriceformulaDao.qryAboutFixValue(ticketpriceformulaitem);
				//否则，按原逻辑取值。
				}else{
					return qryNomalStationPrice(ticket, code, orgid);
				}
			}else{
				return qryNomalStationPrice(ticket, code, orgid);
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return new BigDecimal(0);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Fuelfeegradeapply> qryFuelfeegradeapply(Date departdate,
			long routeid, long vehicletypeid) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradeapply t where t.routeid=:routeid")
				.append(" and t.fromdate<=:departdate and t.todate>=:departdate")
				.append(" and t.vehicletype.id=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("routeid", routeid);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Fuelfeegradeapply> list = query.getResultList();
		if (list == null || list.size() == 0) {
			sql = new StringBuilder("select t ")
					.append(" from Fuelfeegradeapply t where t.routeid=:routeid")
					.append(" and t.fromdate<=:departdate and t.todate>=:departdate");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("departdate", departdate);
			query.setParameter("routeid", routeid);
			return query.getResultList();
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public BigDecimal qryFuelfeegradedetail(long fuelfeegradeid, long distance) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradedetail t where t.fuelfeegradeid=:fuelfeegradeid")
				.append(" and t.fromdistance<=:distance and t.todistance>=:distance");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fuelfeegradeid", fuelfeegradeid);
		query.setParameter("distance", distance);
		List<Fuelfeegradedetail> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0).getFee() != null) {
			return list.get(0).getFee();
		} else {
			return new BigDecimal(0);
		}
	}

	@SuppressWarnings("unchecked")
	public String getBalanceformulaitemShortname(String name) {
		StringBuilder sql = new StringBuilder(
				"select o from Balanceformulaitem o").append(
				" where  o.isactive=1").append(
				" and o.formulaitemname=:formulaitemname ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("formulaitemname", name);
		List<Balanceformulaitem> bf = query.getResultList();
		return bf != null && bf.size() > 0 ? bf.get(0).getShortname() : "";
	}

	// 3、 查询结算时查结算扣费明细按月的固定扣费是否已经扣过
	public boolean isDeductByVehicleMonth(Date firstDay, Date lastDay,
			long balanceitemid, long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select count(*) from Balancedeductdetail t,Departinvoices d")
				.append(" where t.balance.id=d.balance.id")
				.append(" and t.balancedeductitemid=:balanceitemid  and  d.vehicleid=:vehicleid ")
				.append(" and d.status!='1' and d.departdate>=:firstDay and d.departdate<=:lastDay");
		Query query = em.createQuery(sql.toString());
		query.setParameter("firstDay", firstDay);
		query.setParameter("lastDay", lastDay);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("balanceitemid", balanceitemid);
		long count = (Long) query.getSingleResult();
		if(count==0){
			sql = new StringBuilder(
					"select count(distinct(t.id)) from Balancedeductdetail t,Departinvoices d")
					.append(" where t.orgid=d.printorgid and t.balancevehicleid=d.vehicleid  and t.balanceid is null  ")
					.append(" and t.balancedeductitemid=:balanceitemid  and  d.vehicleid=:vehicleid ")
					.append(" and d.status!='1' and d.departdate>=:firstDay and d.departdate<=:lastDay");
			query = em.createNativeQuery(sql.toString());
			query.setParameter("firstDay", firstDay);
			query.setParameter("lastDay", lastDay);
			query.setParameter("vehicleid", vehicleid);
			query.setParameter("balanceitemid", balanceitemid);
			count = ((BigDecimal) query.getSingleResult()).longValue();
		}
		return count > 0 ? true : false;
	}

	// 2、 查询结算时查结算扣费明细按天\车的固定扣费是否已经扣过
	public boolean isDeductedByVehicleDay(Date departdate, long balanceitemid,
			long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select count(*) from Balancedeductdetail t,Departinvoices d")
				.append(" where t.balance.id=d.balance.id")
				.append(" and t.balancedeductitemid=:balanceitemid  and  d.vehicleid=:vehicleid ")
				.append(" and d.status!='1' and d.departdate=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("balanceitemid", balanceitemid);
		long count = (Long) query.getSingleResult();
		return count > 0 ? true : false;
	}
	// 2、 查询结算时查结算扣费明细按天\车的固定扣费是否已经扣过
	@SuppressWarnings("unchecked")
	public Balancedeductdetail qryDeductByVehicleDay(long balanceitemid,
			long vehicleid) {
		StringBuilder sql = new StringBuilder("select t from Balancedeductdetail t")
				.append(" where t.balance is null")
				.append(" and t.balancedeductitemid=:balanceitemid  and  t.balancevehicleid=:vehicleid ")
				.append(" and t.status='0'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("balanceitemid", balanceitemid);
		List<Balancedeductdetail> list = query.getResultList();
		return list!=null&&list.size()>0?list.get(0):null;
	}

	@SuppressWarnings("unchecked")
	public List<Balancedeductdetail> qryBalanceDeduct(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"select t from Balancedeductdetail t")
				.append(" where  t.status='0' and t.balance is null");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	// 查询本机构的扣费信息
	@SuppressWarnings("unchecked")
	public List<Balancedeductitem> qryBalancedeductitem(long orgid) {
		StringBuilder sql = new StringBuilder(
				"select b  from  Balancedeductitem b where  b.isticketpriceitem = 0")
				.append(" and b.isdeductbeforebalance = 0  and b.isactive = 1 and b.orgid=:orgid")
				.append(" order by b.name");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public List<Balancedeductdetail> qryMaxBalancedeductdetail(long orgid,
			long balanceunitid) {
		long maxid = 0;
		StringBuilder sql = new StringBuilder("select  max(d.balance.id)")
				.append(" from Balancedeductdetail d where d.balanceunitid =:balanceunitid")
				.append(" and d.orgid =:orgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("balanceunitid", balanceunitid);
		List<Object> list = query.getResultList();
		if (list == null || list.size() == 0 || list.get(0) == null) {
			return null;
		} else {
			maxid = (Long) list.get(0);
		}
		sql = new StringBuilder(
				"select t from Balancedeductdetail t,Balancedeductitem b")
				.append(" where  t.balance.id=:maxid and t.balancedeductitemid=b.id and b.isactive=1");
		query = em.createQuery(sql.toString());
		query.setParameter("maxid", maxid);
		return query.getResultList();
	}
	
	//新增查询结算公式组成项目表code对应的现金，做map，用来给入参的公式做替换用
	public Map qryBalanceformulaitemcodeAndValue()
	{
		String sql = "SELECT  b.code,b.deductmoney FROM balancedeductitem b where b.deducttype='0' and b.isdeductbeforebalance='1'";
		Query query = em.createNativeQuery(sql.toString());
		List<Object[]> list = query.getResultList();
		Map map = new HashMap();
		for(int i =0;i<list.size();i++)
		{
		/*	System.out.println(list.get(i)[0].toString());
			System.out.println(list.get(i)[1].toString());*/
			map.put(list.get(i)[0].toString(), list.get(i)[1].toString());
		}
		return map;
	}
	
	public BigDecimal qryStationPrice7(Ticketpriceformulaitem ticketpriceformulaitem,Ticketsell ticket) {
		BigDecimal stationprice = new BigDecimal(0);
		if (ticketpriceformulaitem != null) {
			List<Formulaitemprice> aboutPricelist = ticketpriceformulaDao
					.qryAboutPriceValue(ticketpriceformulaitem);
			boolean isfind=false;
			for (Formulaitemprice formulaitemprice : aboutPricelist) {
				BigDecimal tempprice = ticket.getPrice();
				if (formulaitemprice.getFromprice().compareTo(tempprice) <= 0
						&& formulaitemprice.getEndprice().compareTo(tempprice) >= 0) {
					stationprice = formulaitemprice.getValue();
					isfind=true;
					break;
				}
			}
			//若在票价区间中未找到该区间的票价则设置为0
			if(!isfind){
				stationprice = new BigDecimal(0);
			}
		}
		return stationprice;
	}
	
	public BigDecimal qryStationPrice8(Ticketpriceformulaitem ticketpriceformulaitem,Ticketsell ticket) throws ServiceException {
		StringBuilder sql = new StringBuilder(
		"select s from Formulaitemdistance s ")
		.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
		.append(" and s.fromdistance<=:fromdistance and s.enddistance>=:enddistance");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		long distance = ticket.getDistance();
		query.setParameter("fromdistance", distance);
		query.setParameter("enddistance", distance);
		List<Formulaitemdistance> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemdistance formulaitemdistance = (Formulaitemdistance) list
					.get(0);
			return formulaitemdistance.getValue();
		} else {
			throw new ServiceException(String.valueOf(distance), "0048");
		}
	}
	
	public BigDecimal qryNomalStationPrice(Ticketsell ticket,String code, long orgid){
		String tickettype = "Q";
		StringBuilder sql = new StringBuilder("select tpi.price")
			.append(" from ticketprice tp,ticketpriceitem tpi,Ticketpriceformulaitem tf")
			.append(" where tp.scheduleplanid=:scheduleplanid")
			.append(" and tp.departstationid=:departstationid")
			.append(" and tp.reachstationid=:reachstationid")
			.append(" and tp.seattype=:seattype ")
			.append(" and tp.id=tpi.ticketpriceid and tf.isactive=1 and tf.orgid=:orgid ")
			.append(" and tpi.isautoadjust=0 and tpi.tickettype=:tickettype ")
			.append(" and tpi.ticketpriceformulaitemid=tf.id and tf.code=:code");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", ticket.getScheduleplanid());
		query.setParameter("departstationid", ticket.getDepartstationid());
		query.setParameter("reachstationid", ticket.getReachstationid());
		query.setParameter("seattype", ticket.getSeattype());
		query.setParameter("tickettype", tickettype);
		query.setParameter("code", code);
		query.setParameter("orgid", orgid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? (BigDecimal) list.get(0)
				: new BigDecimal(0);
	}
	public List<Object> qryPriceItem(Ticketsell ticket,long orgid){
		String tickettype = "Q";
		StringBuilder sql = new StringBuilder("select tf.code, tpi.price")
			.append(" from ticketprice tp,ticketpriceitem tpi,Ticketpriceformulaitem tf")
			.append(" where tp.scheduleplanid=:scheduleplanid")
			.append(" and tp.departstationid=:departstationid")
			.append(" and tp.reachstationid=:reachstationid")
			.append(" and tp.seattype=:seattype ")
			.append(" and tp.id=tpi.ticketpriceid and tf.isactive=1 and tf.orgid=:orgid ")
			.append(" and tpi.isautoadjust=0 and tpi.tickettype=:tickettype ")
			.append(" and tpi.ticketpriceformulaitemid=tf.id");
		Query query = em.createNativeQuery(sql.toString());
		play.Logger.info("售票操作-----查询站务费sql："+sql.toString());
		query.setParameter("scheduleplanid", ticket.getScheduleplanid());
		query.setParameter("departstationid", ticket.getDepartstationid());
		query.setParameter("reachstationid", ticket.getReachstationid());
		query.setParameter("seattype", ticket.getSeattype());
		query.setParameter("tickettype", tickettype);
		//query.setParameter("code", code);
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}
	
	//根据票价区间查询站务费
	public List<Object> getStationserviceFee(String ticketprice){
		StringBuffer sql = new StringBuffer();
		sql.append("select nvl(f.value, 0) from formulaitemprice f left join ticketpriceformulaitem t on f.ticketpriceformulaitemid = t.id and t.isactive = 1 ")
			.append(" where t.code = 'C' and f.fromprice <= :ticketprice and f.endprice >= :ticketprice ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("ticketprice", ticketprice);
		return  query.getResultList();
	}
	
	/**
	 * 查询停车费
	 * @param fromdapart
	 * @param todapart
	 * @param invoinceids
	 * @param orgid
	 * @return
	 */
	public BigDecimal qryVehicleParkFee(Date fromdapart, Date todapart,
			String invoinceids, Long orgid){
		StringBuffer sql = new StringBuffer();
		sql.append("select nvl(sum(parkfee), 0) from ( ")
			.append(" select distinct tt.id, tt.parkfee from( ")
			.append(" 	select t.id, t.parkfee as parkfee from vehicleparkfee t, vehicle v, departinvoices ds ")
			.append(" 		where t.isbalanced = 0 and t.vehicleno = v.vehicleno ")
			.append("  		and v.id = ds.vehicleid and t.orgid = ds.printorgid ")
			.append("  		and t.orgid = :orgid ")
			.append("  		and t.departdate between :fromdapart and :todapart ")
			.append("  		and ds.id in (").append(invoinceids ).append(") ")
			.append(" 	union all")
			.append(" 	select t.id, t.parkfee as parkfee from vehicleparkfee t, vehicle v, departinvoicesother ds ")
			.append(" 		where t.isbalanced = 0 and t.vehicleno = v.vehicleno ")
			.append("  		and v.id = ds.vehicleid and t.orgid = ds.orgid ")
			.append("  		and t.orgid = :orgid ")
			.append("  		and t.departdate between :fromdapart and :todapart ")
			.append("  		and ds.id in (").append(invoinceids ).append(") ")
			.append(" ) tt ")
		.append(" ) ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("fromdapart", fromdapart);
		query.setParameter("todapart", todapart);

		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? (BigDecimal) list.get(0)
				: BigDecimal.ZERO;
	}
	
	/**
	 * 查询停车费对象
	 */
	public List<VehicleParkFee> qryVehicleParkFeeObjs(Date fromdapart, Date todapart,
			String invoinceids, String otherinvoicesids, Long orgid){
		StringBuffer sql = new StringBuffer();
		sql.append("select tt.id from (");
		if (invoinceids != null && invoinceids.length() > 0) {
			sql.append(" select t.id || '' as id from VehicleParkFee t, Vehicle v, Departinvoices ds ")
			.append(" where t.isbalanced = 0 and t.vehicleno = v.vehicleno ")
			.append(" and v.id = ds.vehicleid and t.orgid = ds.printorgid ")
			.append(" and t.orgid = :orgid ")
			.append(" and t.departdate between :fromdapart and :todapart and (1>2 ");
			String[]  ids = invoinceids.split(",");
			//查询sql in子查询集合不能超过1000
			int i = ((ids.length-1)/998)+1;
			for (int j = 0; j < i; j++) {
				if(j==(i-1)){
					String[] emp = Arrays.copyOfRange(ids,j*998,ids.length);
					String str = Arrays.toString(emp);
					str = str.substring(1, str.length()-1);
					sql.append("  or ds.id in (").append(str ).append(") ");
				}else{
					String[] emp = Arrays.copyOfRange(ids,j*998,(j+1)*998);
					String str = Arrays.toString(emp);
					str = str.substring(1, str.length()-1);
					sql.append("  or ds.id in (").append(str ).append(") ");
				}
			}
			sql.append(") "); 
		}
		if((invoinceids != null && invoinceids.length() > 0) && (otherinvoicesids != null && otherinvoicesids.length() > 0)){
			sql.append(" union all ");
		}
		if(otherinvoicesids != null && otherinvoicesids.length() > 0){
			sql.append(" select t.id || '' as id from VehicleParkFee t, Vehicle v, Departinvoicesother ds ")
			.append(" where t.isbalanced = 0 and t.vehicleno = v.vehicleno ")
			.append(" and v.id = ds.vehicleid and t.orgid = ds.orgid ")
			.append(" and t.orgid = :orgid ")
			.append(" and t.departdate between :fromdapart and :todapart and (");
			List idList = getLisrByStr(otherinvoicesids);
			for (int i = 0; i < idList.size(); i++) {
				if(i==0){
					sql.append(" t.id in ("+idList.get(i)+")");
				}else{
					sql.append(" or t.id in ("+idList.get(i)+")");
				}
			}
			sql.append("  ) ");
		}
		sql.append(") tt group by tt.id");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("fromdapart", fromdapart);
		query.setParameter("todapart", todapart);
		
		List<String> list = query.getResultList();
		StringBuffer parkFeeIds = new StringBuffer();
		
		List<VehicleParkFee> parkFeeList = null;
		if(list != null && list.size() > 0){
			for (String obj : list) {
				parkFeeIds.append(obj.toString()).append(",");
			}
			List idList = getLisrByStr(parkFeeIds.toString().substring(0, parkFeeIds.length() - 1));
			StringBuffer sql2 = new StringBuffer();
			sql2.append("select t from VehicleParkFee t where  (");
			for (int i = 0; i < idList.size(); i++) {
				if(i==0){
					sql2.append(" t.id in ("+idList.get(i)+")");
				}else{
					sql2.append(" or t.id in ("+idList.get(i)+")");
				}
			}
			sql2.append(")");;
			query = getEntityManager().createQuery(sql2.toString());
			parkFeeList = query.getResultList();
		}
		
		return parkFeeList;
	}
	/**
	 * 把ids长度超过1000的字符串拆分成list数组
	 * @return 
	 */
	private List getLisrByStr(String str) {
		List<String> idList = new ArrayList<String>();
		String[] oids = str.split(",");
		if(oids.length>=1000){
			for (int i = 0; i < (oids.length-1)/1000+1; i++) {
				String ids = StringUtils.join(oids, ",", i*1000, (i+1)*1000>oids.length?oids.length:(i+1)*1000);
				idList.add(ids);
			}
		}else{
			idList.add(str);
		}
		return idList;

	}


	/**
	 * 班次晚点脱班管理
	 * @param schedulelosttreatmentIds
	 */
	public List<ScheduleLostTreatments> qrySchedulelosttreatment(String schedulelosttreatmentIds) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t from ScheduleLostTreatments t where t.id in (" + schedulelosttreatmentIds + ")" );
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		return list;
	}
	
}
