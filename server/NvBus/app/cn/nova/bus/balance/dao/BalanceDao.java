package cn.nova.bus.balance.dao;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balancescheduleminimum;
import cn.nova.bus.balance.model.Balancestationdeduct;
import cn.nova.bus.balance.model.Balanceunitdeduct;
import cn.nova.bus.balance.model.Balancevehicleagentrate;
import cn.nova.bus.balance.model.Balancevehiclededuct;
import cn.nova.bus.balance.model.VehicleParkFee;
import cn.nova.bus.balance.model.Vehicleturnover;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BalanceDao extends EntityManagerDaoSurport {
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
	// 根据区域创建车属单位、车牌目录树
	@SuppressWarnings("unchecked")
	public List<Object> createTree(long orgid) {
		List<Object> list = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(
				"select DISTINCT d.id,d.name,SUBSTRING(d.code,1,2) as code,1 as arealevel,'0' as pcode")
				.append(" from Route r,Station s,District d")
				.append(" where r.endstationid=s.id and s.districtid=d.id")
				.append(" and r.orgid=:orgid and SUBSTRING(d.code,3,4)='0000'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list = query.getResultList();

		sql = new StringBuilder(
				"select DISTINCT d.id,d.name,SUBSTRING(d.code,1,4) as code,2 as arealevel,SUBSTRING(d.code,1,2) as pcode")
				.append(" from Route r,Station s,District d")
				.append(" where r.endstationid=s.id and s.districtid=d.id")
				.append(" and r.orgid=:orgid ")
				.append(" and SUBSTRING(d.code,5,2)='00' and SUBSTRING(d.code,3,4)!='0000'");
		query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list.addAll(query.getResultList());

		sql = new StringBuilder(
				"select u.id,u.name, u.id as code, 3 as arealevel,SUBSTRING(d.code,1,4)  as pcode")
				.append(" from Unit u,District d,Cycleschemesvehicle c, Cycleschemes cs")
				.append(" where u.districtid = d.id and u.id = c.unitid")
				.append(" and c.cyclescheme=cs and cs.orgid =:orgid")
				.append(" group by SUBSTRING(d.code,1,4) ,u.id,u.name");
		query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list.addAll(query.getResultList());

		sql = new StringBuilder(
				"select v.id,v.vehicleno as name,v.vehicleno as code, 4 as arealevel,v.unitid as pcode")
				.append(" from Vehicle v,Cycleschemesvehicle c,Cycleschemes cs")
				.append(" where v = c.vehicle and c.cyclescheme=cs and cs.orgid=:orgid")
				.append(" group by v.unitid,v.id, v.vehicleno ");
		query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list.addAll(query.getResultList());

		return list;
	}

	// 查询结算单信息
	@SuppressWarnings("unchecked")
	public List<Object> qryDepartinvoices(
			List<PropertyFilter> propertyFilterList, String invoinceids,
			String orgids, int departinvoicestype) {
		List<Object> list = new ArrayList<Object>();
		StringBuilder sql = null;
		if (departinvoicestype == 1) {// 微机运量
			sql = new StringBuilder(
					"select '',r.name as routename,ds.id,s1.name as endstation,")
					.append(" ds.departinvoicesno,ds.departdate,s.code,trim(ds.departtime) as departtime,")
					.append(" (ds.ticketnum + ds.supplyticketnum) as ticketnum,")
					.append(" (ds.totalamount + ds.supplyamount) as totalamount,")
					.append(" (ds.balanceamount + ds.supplybalanceamount) as balanceamount,")
					.append(" ui.name as printname,ds.printtime,u.name as unitname,")
					.append(" v.vehicleno, ds.stationservicefee,ds.fueladditionfee,")
					.append(" ds.agentfee,ds.othterfee,ds.supplyticketnum,")
					.append(" ds.supplyamount,ds.supplybalanceamount,ds.status,ds.vehicleid,s.routeid,")
					.append(" ds.balanceunitid,u2.name as balanceunitname,1 as iscomputerno,trim('微机运量') as departinvoicetypename,")
					.append(" u.fullname as vehicleUnitFullName,u2.fullname as balanceFullName,'' as datafrom,  ") //u.name车属单位  u2.name结算单位
					.append(" bal.balanceno as balanceno")
					.append(" from Departinvoices ds left join balance bal on ds.balanceid=bal.id,Schedule s,Userinfo ui,")
					.append(" Vehicle v,Unit u,Station s1,Route r,Unit u2")
					.append(" where ds.scheduleid = s.id and ds.vehicleid = v.id")
					.append(" and v.unitid = u.id and ds.printby = ui.id ")
					.append(" and s.routeid=r.id and r.endstationid = s1.id and ds.balanceunitid=u2.id")
					.append(" and ds.id not in " + invoinceids);
			if (orgids != null && !orgids.equals("")) {
				sql.append(" and ds.printorgid in " + orgids);
			}
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order by ds.departdate,s.routeid,ds.departtime");
			Query query = em.createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);

			return query.getResultList();
		} else if (departinvoicestype == 2) {// 手工运量

			sql = new StringBuilder(
					" select ds.isaudit as isaudit,r.name as routename,ds.id,s1.name as endstation,ds.departinvoicesno,ds.departdate,s.code, ");
			sql.append(
					" trim(ds.departtime) as departtime,ds.ticketnum as ticketnum,ds.totalmoney as totalamount,ds.balancemoney as balanceamount, ")
					.append(" ui.name as printname,ds.createtime as printtime,u.name as unitname,v.vehicleno,ds.stationfee as stationservicefee, 0 as fueladditionfee, ")
					.append(" ds.agentfee, ds.othterfee as othterfee, 0 as supplyticketnum,0 as supplyamount,0 as supplybalanceamount,ds.status,ds.vehicleid,s.routeid,ds.balanceunitid as balanceunitid,u2.name as balanceunitname,2 as iscomputerno,trim('手工运量') as departinvoicetypename, ")
					.append(" u.fullname as vehicleUnitFullName,u2.fullname as balanceFullName,ds.datafrom, ")
					.append(" bal.balanceno as balanceno")
					.append(" from (departinvoicesother ds left join Unit u2 on ds.balanceunitid=u2.id) left join balance bal on ds.balanceid=bal.id, Schedule s, Userinfo ui,Vehicle v,Unit u,Station s1,Route r ")
					.append("  where ds.scheduleid = s.id and ds.vehicleid = v.id and v.unitid = u.id  and ds.createby = ui.id and s.routeid = r.id and r.endstationid = s1.id ")
					.append(" and ds.id not in " + invoinceids);
			if (orgids != null && !orgids.equals("")) {
				sql.append(" and ds.orgid in " + orgids);
			}
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order by ds.departdate,s.routeid,ds.departtime");
			Query query = em.createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);

			return query.getResultList();
		} else {// 全部
			sql = new StringBuilder(
					"select '', r.name as routename,ds.id,s1.name as endstation,")
					.append(" ds.departinvoicesno,ds.departdate,s.code,trim(ds.departtime) as departtime,")
					.append(" (ds.ticketnum + ds.supplyticketnum) as ticketnum,")
					.append(" (ds.totalamount + ds.supplyamount) as totalamount,")
					.append(" (ds.balanceamount + ds.supplybalanceamount) as balanceamount,")
					.append(" ui.name as printname,ds.printtime,u.name as unitname,")
					.append(" v.vehicleno, ds.stationservicefee,ds.fueladditionfee,")
					.append(" ds.agentfee,ds.othterfee,ds.supplyticketnum,")
					.append(" ds.supplyamount,ds.supplybalanceamount,ds.status,ds.vehicleid,s.routeid,")
					.append(" ds.balanceunitid,u2.name as balanceunitname,1 as iscomputerno,trim('微机运量') as departinvoicetypename,")
					.append(" u.fullname as vehicleUnitFullName,u2.fullname as balanceFullName,'' as datafrom ,  0 as pieces,  ")
					.append(" bal.balanceno as balanceno")
					.append(" from Departinvoices ds left join balance bal on ds.balanceid=bal.id,Schedule s,Userinfo ui,")
					.append(" Vehicle v,Unit u,Station s1,Route r,Unit u2")
					.append(" where ds.scheduleid = s.id and ds.vehicleid = v.id")
					.append(" and v.unitid = u.id and ds.printby = ui.id ")
					.append(" and s.routeid=r.id and r.endstationid = s1.id and ds.balanceunitid=u2.id")
					.append(" and ds.id not in " + invoinceids);
			if (orgids != null && !orgids.equals("")) {
				sql.append(" and ds.printorgid in " + orgids);
			}
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order by ds.departdate,s.routeid,ds.departtime");
			Query query = em.createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);

			list = query.getResultList();

			sql = new StringBuilder(
					" select ds.isaudit as isaudit,r.name as routename,ds.id,s1.name as endstation,ds.departinvoicesno,ds.departdate,s.code, ");//手工运量单要查出isaudit字段，前台需进行4050参数的判断 2016-03-28
			sql.append(
					" trim(ds.departtime) as departtime,ds.ticketnum as ticketnum,ds.totalmoney as totalamount,ds.balancemoney as balanceamount, ")
					.append(" ui.name as printname,ds.createtime as printtime,u.name as unitname,v.vehicleno,ds.stationfee as stationservicefee, 0 as fueladditionfee, ")
					.append(" ds.agentfee, ds.othterfee as othterfee, 0 as supplyticketnum,0 as supplyamount,0 as supplybalanceamount,ds.status,ds.vehicleid,s.routeid,ds.balanceunitid as balanceunitid,u2.name as balanceunitname,2 as iscomputerno,trim('手工运量') as departinvoicetypename, ")
					.append(" u.fullname as vehicleUnitFullName,u2.fullname as balanceFullName,ds.datafrom , ds.pieces, ")
					.append(" bal.balanceno as balanceno")
					.append(" from (departinvoicesother ds left join Unit u2 on ds.balanceunitid=u2.id) left join balance bal on ds.balanceid=bal.id, Schedule s, Userinfo ui,Vehicle v,Unit u,Station s1,Route r ")
					.append("  where ds.scheduleid = s.id and ds.vehicleid = v.id and v.unitid = u.id  and ds.createby = ui.id and s.routeid = r.id and r.endstationid = s1.id ")
					.append(" and ds.id not in " + invoinceids);
			if (orgids != null && !orgids.equals("")) {
				sql.append(" and ds.orgid in " + orgids);
			}
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			sql.append(" order by ds.departdate,s.routeid,ds.departtime");
			query = em.createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);

			list.addAll(query.getResultList());

			return list;

		}

		
		
		
	}

	// 查询结算单信息
	@SuppressWarnings("unchecked")
	public List<Object> qryDepartinvoicesByNo(String departinvoicesno) {
		StringBuilder sql = null;
		sql = new StringBuilder("select ds.id,ds.departinvoicesno,ds.status")
				.append(" from Departinvoices ds").append(
						" where ds.departinvoicesno =:departinvoicesno");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesno", departinvoicesno);
		return query.getResultList();
	}

	// 查询结算单信息用于生成扣费明细
	@SuppressWarnings("unchecked")
	public List<Departinvoices> qryDepartinvoices(long orgid, Date fromdapart,
			Date todapart, long routeid, long scheduleid, long unitid,
			long vehicleid) {
		StringBuilder sql = new StringBuilder("select d ")
				.append(" from Departinvoices d,Schedule s,Vehicle v")
				.append(" where d.departdate>=:fromdapart and d.departdate<=:todapart")
				.append(" and d.scheduleid=s.id and s.orgid=:orgid")
				.append(" and d.vehicleid=v.id ");
		if (vehicleid > 0) {
			sql.append(" and d.vehicleid=" + vehicleid);
		} else if (unitid > 0) {
			sql.append(" and v.unitid=" + unitid);
		}
		if (scheduleid > 0) {
			sql.append(" and s.route.id=" + routeid);
		} else if (routeid > 0) {
			sql.append(" and s.route.id=" + routeid);
		}
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("fromdapart", fromdapart);
		query.setParameter("todapart", todapart);
		return query.getResultList();
	}

	// 查询要结算的结算单班次保底信息
	@SuppressWarnings("unchecked")
	public List<Balancescheduleminimum> qryBalancescheduleminimum(
			String invoicesids) {
		StringBuilder sql = new StringBuilder("select d ").append(
				" from Balancescheduleminimum d").append(
				" where d.departinvoicesid in " + invoicesids);
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	// 查询结算时的扣费明细信息, 用于删除结算扣费信息
	@SuppressWarnings("unchecked")
	public List<Departinvoicesdeductdetail> qryDepartinvoicesdeductdetail(
			Date fromdapart, Date todapart, String invoinceids) {

		StringBuilder sql = null;
		String curids = "";
		List<Departinvoicesdeductdetail> alllist = new ArrayList<Departinvoicesdeductdetail>();
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 1000) {
				curids = invoinceids.substring(0, 900);
				curids = curids.substring(0, curids.lastIndexOf(","));
				// System.out.println(curids);
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder("select d ")
					.append(" from Departinvoicesdeductdetail d")
					.append(" where d.departdate>=:fromdapart and d.departdate<=:todapart")
					.append(" and d.status='0' and d.isdeductbeforebalance=0 and (d.departinvoices.id in ("+ curids + ") )");

			Query query = em.createQuery(sql.toString());
			query.setParameter("fromdapart", fromdapart);
			query.setParameter("todapart", todapart);
			alllist.addAll(query.getResultList());

		}
		return alllist;

	}

	// 查询结算时的扣费明细信息
	@SuppressWarnings("unchecked")
	public List<Object> qryInvoicesdeductdetail(long departinvoicesid) {
		// 固定扣费
		StringBuilder sql = new StringBuilder("select ")
				.append(" bi.deducttype,bi.name,d.isdeductbeforebalance,d.deductmoney,")
				.append(" bg.name as target,ba.startdate,ba.enddate")
				.append(" from Departinvoicesdeductdetail d,Balancedeductitem bi,")
				.append(" Balancedeductapply ba,Balancededucttarget bg")
				.append(" where d.balanceitemid=bi.id and d.balanceapplyid=ba.id ")
				.append(" and d.status!='1'")
				.append(" and ba.balancededucttargetid=bg.id")
				.append(" and d.departinvoices.id=:departinvoicesid")
				.append(" and d.type='2'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		List<Object> list = query.getResultList();

		// 公式扣费,定位按人扣费
		sql = new StringBuilder("select ")
				.append(" '0' as deducttype,bf.formulaname as name,d.isdeductbeforebalance,d.deductmoney,")
				.append(" bg.name as target,ba.startdate,ba.enddate")
				.append(" from Departinvoicesdeductdetail d,Balanceformula bf,")
				.append(" Balanceformulaapply ba,Balancededucttarget bg")
				.append(" where d.balanceitemid=bf.id and d.balanceapplyid=ba.id ")
				.append(" and d.isdeductbeforebalance=1 and d.status!='1'")
				.append(" and ba.balancededucttargetid=bg.id")
				.append(" and d.departinvoices.id=:departinvoicesid")
				.append(" and d.type='1'");
		query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		list.addAll(query.getResultList());

		return list;
	}

	// 查询结算时的扣费明细信息bi.deducttype= 6、手工输入
	@SuppressWarnings("unchecked")
	public List<Object> qryInvoicesdeductdetail(String invoicesids) {
		// 固定扣费
		StringBuilder sql = new StringBuilder("select d.id,")
				.append(" ds.departinvoicesno,bi.name,d.deductmoney,bi.isticketpriceitem")
				.append(" from Departinvoices ds,Departinvoicesdeductdetail d,Balancedeductitem bi")
				.append(" where ds=d.departinvoices and d.balanceitemid=bi.id ")
				.append(" and ds.status='0' and bi.deducttype='6'")
				.append(" and ds.id in " + invoicesids)
				.append(" and d.type='2'");
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	// 查询最新的结账信息
	@SuppressWarnings("unchecked")
	public Balance qryMaxBalance(long orgid, String balanceobject, long objectid) {
		StringBuilder sql = new StringBuilder("select b")
				.append(" from Balance b")
				.append(" where b.orgid=:orgid and b.balanceobject=:balanceobject")
				.append(" and b.status='0' and b.objectid=:objectid")
				.append(" order by b.balancetime");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("balanceobject", balanceobject);
		query.setParameter("objectid", objectid);
		List<Balance> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询最新的结账信息
	@SuppressWarnings("unchecked")
	public Balance qryLastBalance(long orgid, long objectid) {
		StringBuilder sql = new StringBuilder("select a")
				.append(" from Balance a where a.id = (select max(t.id)")
				.append(" from Balance t where t.objectid =:objectid")
				.append(" and t.status = '0' and t.orgid=:orgid)");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("objectid", objectid);
		List<Balance> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询行包扣费
	@SuppressWarnings("unchecked")
	public BigDecimal qryPackBalance(long orgid, String vehicleids,
			Date startdate, Date enddate) {
		StringBuilder sql = new StringBuilder("select sum(packfee + ")
				.append(" handfee + custodial + transitfee + insurancefee + insurance + deliveryfee + otherfee) fee")
				.append(" from Pack t")
				.append(" where (t.status = '0' or t.status = '1' or t.status = '2')")
				.append("  and t.vehicleid in " + vehicleids
						+ " and t.orgid=:orgid")
				.append(" and t.departdate between :startdate and :enddate");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		return (BigDecimal) (list != null && list.size() > 0 ? list.get(0)
				: new BigDecimal(0));
	}

	// 查询行包扣费
	@SuppressWarnings("unchecked")
	public BigDecimal qryPackBalance(long vehicleid, Date startdate,
			Date enddate) {
		StringBuilder sql = new StringBuilder("select sum(packfee + ")
				.append(" handfee + custodial + transitfee + insurancefee + insurance + deliveryfee + otherfee) fee")
				.append(" from Pack t")
				.append(" where (t.status = '0' or t.status = '1' or t.status = '2')")
				.append("  and t.vehicleid=:vehicleid")
				.append(" and t.departdate between :startdate and :enddate");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		return (BigDecimal) (list != null && list.size() > 0 ? list.get(0)
				: new BigDecimal(0));
	}

	// 结算时更新结算单信息
	public boolean updateDepartinvoices(Balance balance, String invoinceids,
			Station station) {

		StringBuilder sql = new StringBuilder("");
		String curids = "";
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder("update ")
					.append(" Departinvoices as d set d.balance=:balance,")
					.append(" d.balanceby=:balanceby,d.balancedate=:balancedate,")
					.append(" d.balancestation=:balancestation,d.status='2',")
					.append(" d.updateby=:updateby,d.updatetime=:updatetime")
					.append(" where d.id in  (" + curids + ")");
			Query query = em.createQuery(sql.toString());
			query.setParameter("balance", balance);
			Userinfo balanceby = new Userinfo();
			balanceby.setId(balance.getBalancby());
			query.setParameter("balanceby", balanceby);
			query.setParameter("balancedate", new Date());
			query.setParameter("balancestation", station);
			query.setParameter("updateby", balance.getCreateby());
			query.setParameter("updatetime", new Date());
			query.executeUpdate();
		}
		return true;

	}

	// 结算时更新结算单补录信息
	public boolean updateDepartinvoicesother(Balance balance,
			String otherinvoicesids, Station station) {

		StringBuilder sql = new StringBuilder("");
		String curids = "";
		while (otherinvoicesids.length() > 0) {
			if (otherinvoicesids.length() > 2000) {
				curids = otherinvoicesids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				otherinvoicesids = otherinvoicesids.substring(
						curids.length() + 1, otherinvoicesids.length());
			} else {
				curids = otherinvoicesids;
				otherinvoicesids = "";
			}
			sql = new StringBuilder("update ")
					.append(" Departinvoicesother as d set d.balance=:balance,")
					.append(" d.balanceby=:balanceby,d.balancedate=:balancedate,")
					.append(" d.balancestation=:balancestation,d.status='2',")
					.append(" d.updateby=:updateby,d.updatetime=:updatetime")
					.append(" where d.id in  (" + curids + ")");
			Query query = em.createQuery(sql.toString());
			query.setParameter("balance", balance);
			query.setParameter("balanceby", balance.getBalancby());
			query.setParameter("balancedate", new Date());
			query.setParameter("balancestation", station);
			query.setParameter("updateby", balance.getCreateby());
			query.setParameter("updatetime", new Date());
			query.executeUpdate();
		}
		return true;

	}

	// 结算时更新结算单明细信息
	public boolean updateDepartinvoicesdetail(Balance balance,
			String invoinceids) {
		StringBuilder sql = new StringBuilder("");
		invoinceids = invoinceids.substring(1, invoinceids.length() - 1);
		String curids = "";
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder("update ")
					.append(" Departinvoicesdetail d set d.status='2',")
					.append(" d.updateby=:updateby,d.updatetime=:updatetime")
					.append(" where d.departinvoices.id in  (" + curids + ")");
			Query query = em.createQuery(sql.toString());
			query.setParameter("balance", balance);
			query.setParameter("updateby", balance.getCreateby());
			query.setParameter("updatetime", new Date());
			query.executeUpdate();
		}
		return true;
	}

	// 结算时更新结算单扣费明细信息
	public boolean updateDepartinvoicesdeductdetail(Balance balance,
			String invoinceids) {
		StringBuilder sql = new StringBuilder("");
		String curids = "";
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder("update ")
					.append(" Departinvoicesdeductdetail d ")
					.append(" set d.balance=:balance,d.status='2',")
					.append(" d.updateby=:updateby,d.updatetime=:updatetime")
					.append(" where d.departinvoices.id in  (" + curids + ")")
					.append(" and (d.status='0' or d.status='3')");
			Query query = em.createQuery(sql.toString());
			query.setParameter("balance", balance);
			query.setParameter("updateby", balance.getCreateby());
			query.setParameter("updatetime", new Date());
			query.executeUpdate();
		}
		return true;
	}

	// 结算时更新结算单补录扣费明细信息
	public boolean updateDepartinvoicesdeductdetailother(Balance balance,
			String otherinvoicesids) {
		StringBuilder sql = new StringBuilder("");
		String curids = "";
		while (otherinvoicesids.length() > 0) {
			if (otherinvoicesids.length() > 2000) {
				curids = otherinvoicesids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				otherinvoicesids = otherinvoicesids.substring(
						curids.length() + 1, otherinvoicesids.length());
			} else {
				curids = otherinvoicesids;
				otherinvoicesids = "";
			}
			sql = new StringBuilder("update ")
					.append(" Departinvoicesdeductdetail d ")
					.append(" set d.balance=:balance,d.status='2',")
					.append(" d.updateby=:updateby,d.updatetime=:updatetime")
					.append(" where d.departinvoices.id in  (" + curids + ")")
					.append(" and (d.status='0' or d.status='3')");
			Query query = em.createQuery(sql.toString());
			query.setParameter("balance", balance);
			query.setParameter("updateby", balance.getCreateby());
			query.setParameter("updatetime", new Date());
			query.executeUpdate();
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	public long qryPersonkilometre(String invoinceids) {

		StringBuilder sql = new StringBuilder("");
		String curids = "";

		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			if (sql.toString().equals("")) {
				sql = sql
						.append("select sum(perkilometre) from (select sum(d.distance*ticketnum) perkilometre from Departinvoicesdetail d")
						.append(" where d.departinvoicesid in  (" + curids
								+ ")");
			} else {
				sql = sql
						.append(" union all select sum(d.distance*ticketnum) perkilometre from Departinvoicesdetail d")
						.append(" where d.departinvoicesid in  (" + curids
								+ ")");
			}
		}
		sql.append(" )");
		Query query = em.createNativeQuery(sql.toString());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 && list.get(0) != null ? ((BigDecimal) list
				.get(0)).longValue() : new Long(0);

	}

	@SuppressWarnings("unchecked")
	public long qryPersonkilometreOther(String otherinvoicesids) {

		StringBuilder sql = new StringBuilder("");
		String curids = "";

		while (otherinvoicesids.length() > 0) {
			if (otherinvoicesids.length() > 2000) {
				curids = otherinvoicesids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				otherinvoicesids = otherinvoicesids.substring(
						curids.length() + 1, otherinvoicesids.length());
			} else {
				curids = otherinvoicesids;
				otherinvoicesids = "";
			}
			if (sql.toString().equals("")) {
				sql = sql
						.append("select sum(perkilometre) from (select sum(d.distance*ticketnum) perkilometre from Departinvoicesotherdetail d")
						.append(" where d.departinvoicesotherid in  (" + curids
								+ ")");
			} else {
				sql = sql
						.append(" union all select sum(d.distance*ticketnum) perkilometre from Departinvoicesotherdetail d")
						.append(" where d.departinvoicesotherid in  (" + curids
								+ ")");
			}
		}
		sql.append(" )");
		Query query = em.createNativeQuery(sql.toString());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 && list.get(0) != null ? ((BigDecimal) list
				.get(0)).longValue() : new Long(0);

	}

	// 获取该班次该日期的终点站票价
	public Ticketprice qryTicketprice(Departinvoices dd) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Ticketprice t,Schedule s ")
				.append(" where t.scheduleplan.id =:scheduleplanid")
				.append(" and s.id =:scheduleid and t.reachstationid =s.route.endstationid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", dd.getScheduleplanid());
		query.setParameter("scheduleid", dd.getScheduleid());
		List list = query.getResultList();
		return (Ticketprice) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 查询车辆预缴款信息
	@SuppressWarnings("unchecked")
	public List<Vehicleturnover> qryVehicleturnover(String vehicleids,
			long receiptorgid) {
		StringBuilder sql = new StringBuilder("select v ")
				.append(" from Vehicleturnover v ")
				.append(" where v.isbalance=0 and v.receiptorgid=:receiptorgid")
				.append(" and v.vehicleid in " + vehicleids);
		Query query = em.createQuery(sql.toString());
		query.setParameter("receiptorgid", receiptorgid);
		return query.getResultList();
	}

	// 根据结算单位查询车辆预缴款信息
	@SuppressWarnings("unchecked")
	public List<Vehicleturnover> qryVehicleturnover(long unitid,
			long receiptorgid) {
		StringBuilder sql = new StringBuilder("select v ")
				.append(" from Vehicleturnover v,Vehicle vc ")
				.append(" where v.isbalance=0 and v.receiptorgid=:receiptorgid")
				.append(" and v.vehicleid=vc.id and vc.balanceunitid=:unitid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("receiptorgid", receiptorgid);
		query.setParameter("unitid", unitid);
		return query.getResultList();
	}

	// 根据承包者单位查询车辆预缴款信息
	@SuppressWarnings("unchecked")
	public List<Vehicleturnover> qryVehicleturnoverBycontractor(
			long contractorid, long receiptorgid) {
		StringBuilder sql = new StringBuilder("select v ")
				.append(" from Vehicleturnover v,Contractor c")
				.append(" where v.isbalance=0 and v.receiptorgid=:receiptorgid")
				.append(" and v.vehicleid=c.vehicleid and c.id=:contractorid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("receiptorgid", receiptorgid);
		query.setParameter("contractorid", contractorid);
		return query.getResultList();
	}

	// 查询结算单信息用于生成扣费明细
	@SuppressWarnings("unchecked")
	public List<Departinvoices> qryDepartinvoices(Date fromdapart,
			Date todapart, long routeid) {
		StringBuilder sql = new StringBuilder("select d ")
				.append(" from Departinvoices d,Schedule s")
				.append(" where d.scheduleid=s.id and d.departdate between :fromdapart")
				.append(" and :todapart and s.route.id=:routeid")
				.append(" and d.status='0'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("fromdapart", fromdapart);
		query.setParameter("todapart", todapart);
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}

	// 查询结算时的扣费明细信息, 用于删除结算扣费信息
	@SuppressWarnings("unchecked")
	public List<Departinvoicesdeductdetail> qryDepartinvoicesdeductdetail(
			String invoicesids) {
		StringBuilder sql = new StringBuilder("select d ")
				.append(" from Departinvoicesdeductdetail d")
				.append(" where d.departinvoices.id in " + invoicesids)
				.append(" and d.isdeductbeforebalance=0 and d.status='0' and d.type='2'");
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	// 查询结算时的扣费明细信息, 用于删除结算扣费信息	 删除扣费时要对单号进行全部查询，包括结算单和手工单
	@SuppressWarnings("unchecked")
	public List<Balancedeductdetail> qryBalancedeductdetail(String invoicesids) {
		List<Balancedeductdetail> resultlist = null;
		String ids = "";
		StringBuilder sql = new StringBuilder("select d ")
				.append(" from Balancedeductdetail d")
				.append(" where d.balance is null")
				.append(" and d.orgid in (select distinct printorgid from Departinvoices")
				.append(" where id in " + invoicesids +")")// UNION  select distinct orgid from Departinvoicesother dd where id in " + invoicesids+")"
				.append(" and d.balanceunitid in (select distinct balanceunitid from Departinvoices")
				.append(" where id in " + invoicesids + ")");//UNION  select distinct balanceunitid from Departinvoicesother dd where id in "+ invoicesids+")"
		Query query = em.createQuery(sql.toString());
		resultlist = query.getResultList();
		for(Balancedeductdetail bd :resultlist)
		{
			ids +=bd.getId()+",";
		}
		if(!"".equals(ids))
			ids ="("+ids.substring(0,ids.length()-1)+")";
		//在查询手工单的扣费项目明细  加到一个list进行返回
		sql = new StringBuilder("select d ")
			.append(" from Balancedeductdetail d")
			.append(" where d.balance is null")
			.append(" and d.orgid in (select distinct orgid from Departinvoicesother");
			
			sql.append(" where id in " + invoicesids +")");
			if(resultlist.size()>0)
			{
			sql.append(" and d.id not in"+ids);
			}
			sql.append(" and d.balanceunitid in (select distinct balanceunitid from Departinvoicesother")
			.append(" where id in " + invoicesids + ")");
		query = em.createQuery(sql.toString());
		List<Balancedeductdetail> bdolist = query.getResultList();
		for(Balancedeductdetail bd:bdolist)
		{
			resultlist.add(bd);
		}
		
		return resultlist;
	}

	/**
	 * 已结算查询 by hhz
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBalanced(List<PropertyFilter> propertyFilterList) {
		String andSql = null;
		Long contranctorid = 0L;
		// 如果包含查询字段；承包者
//		if (propertyFilterList != null && propertyFilterList.size() > 0) {
//			for (int t = 0; t < propertyFilterList.size(); t++) {
//				if (propertyFilterList.get(t).getPropertyFullName()
//						.equals("b.objectid")) {
//					andSql = " or ";
//					break;
//				} else {
//					andSql = " and ";
//				}
//			}
//		}
//		if (propertyFilterList != null && propertyFilterList.size() > 0) {
//			for (int t = 0; t < propertyFilterList.size(); t++) {
//				if (propertyFilterList.get(t).getPropertyFullName()
//						.equals("co!id")) {
//					contranctorid = (Long) propertyFilterList.get(t)
//							.getMatchValue();
//					andSql = andSql + " b.objectid = " + contranctorid; 
//					propertyFilterList.remove(t);
//				}
//			}
//		}
		
		

		StringBuilder sql = null;
		sql = new StringBuilder(
				"select b.vehicleno,b.preupmoney, b.routename, b.status,b.id,b.balanceno,b.ditotalnum,b.ditotalmoney,b.distationservicefee,")
				.append("b.fueladditionfee,b.diotherpredeductifee,b.diagentfee,b.dibalanceablemoney,")
				.append("b.dipersonkilometre,b.dideductmoney,b.dibalancemoney,b.returnmoney,")
				.append("b.vipscoremoney,b.lastlost,b.lost,b.deratemoney,b.lateforfeit,b.lostforfeit,")
				.append("b.balancemoney,b.remarks,to_char(b.balancetime,'HH:ss:MM') balancetime,b.balanceip,b.cleartime,")
				.append("b.cancelip,o.name as orgname,u.name as balancebyname,c.name as cancelbyname,")
				.append("trim((case b.status when '1' then '注销' when '0' then '正常' end)) as statusname,")
				.append("trim((case b.balanceobject when '0' then '车属单位' when '1' then '承包者' end)) as objecttype,")
				.append("(case b.balanceobject when '0' then (select ut.name from unit ut where b.objectid=ut.id ) ")
//				.append("  when '1' then (select co.name from contractor co where b.objectid=co.id ) end ) as objectname,b.invoicesnum, ")
				.append("  when '1' then (select vu.name  from (select vv.id,uu.name from vehicle vv,unit uu where vv.balanceunitid = uu.id) vu where vu.id =b.objectid  ) end ) as objectname,b.invoicesnum, ")
				.append("  (select ut.fullname from unit ut where b.objectid = ut.id) as vehicleunitname,")
				.append(" b.ticketincome,b.packmoney,to_char(b.balancetime,'yyyy-mm-dd') balancemonth,b.departstartdate, b.departenddate,")
				.append(" b.additionfee,b.divide,vh.vehicleno as dividename,b.packprice,b.rentmoney,b.rentprice,b.debit,b.backmoney,")
				.append(" b.balanceobject,b.bysj,b.syqj,b.goodsagent")
				.append(" from Organization o,Balance b left join Userinfo c  ")
				.append(" on b.cancelby=c.id left join Vehicle vh on b.balancedividevehicleid=vh.id,Userinfo u ")
				.append(" where b.balancby = u.id and b.orgid = o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));

//		if (contranctorid != 0l) {
//			sql = sql.append(andSql);
//		}
//		sql.append(" and  b.balanceobject = 0  order by b.createtime desc ");
		sql.append("  order by b.createtime desc ");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}

	// 查询结算的车辆预缴款信息
	@SuppressWarnings("unchecked")
	public List<Vehicleturnover> qryBalanceVehicleturnover(long balanceid) {
		StringBuilder sql = new StringBuilder("select v ").append(
				" from Vehicleturnover v ").append(
				" where v.isbalance=1 and v.balance.id=:balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		return query.getResultList();
	}

	// 根据结算车辆获取该车辆的回程结算信息
	@SuppressWarnings("unchecked")
	public List<Departinvoicesother> getInvoicesotherBalance(long balanceid) {
		StringBuffer sql = new StringBuffer("select d from ")
				.append(" Departinvoicesother d")
				.append(" where d.balance.id=:balanceid")
				.append(" and d.status='2'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		return query.getResultList();
	}

	// 结算时更新结算单信息
	public boolean updateDepartinvoices(long balanceid, long updateby) {
		StringBuilder sql = new StringBuilder("update ")
				.append(" Departinvoices as d set d.balance=null,")
				.append(" d.balanceby=null,d.balancedate=null,")
				.append(" d.balancestation=null,d.status='3',")
				.append(" d.updateby=:updateby,d.updatetime=:updatetime")
				.append(" where d.balance.id=:balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		query.setParameter("updateby", updateby);
		query.setParameter("updatetime", new Date());
		int count = query.executeUpdate();
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}

	// 结算时更新结算单扣费明细信息
	public boolean updateDepartinvoicesdeductdetail(long balanceid,
			long updateby) {
		StringBuilder sql = new StringBuilder("update ")
				.append(" Departinvoicesdeductdetail d ")
				.append(" set d.balance=null,d.status='3',")
				.append(" d.updateby=:updateby,d.updatetime=:updatetime")
				.append(" where d.balance.id=:balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		query.setParameter("updateby", updateby);
		query.setParameter("updatetime", new Date());
		int count = query.executeUpdate();
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}

	//
	@SuppressWarnings("unchecked")
	public Balance qryBalanceByNo(String departinvoicesno) {
		StringBuilder sql = null;
		sql = new StringBuilder("select b")
				.append(" from Departinvoices ds,Balance b")
				.append(" where ds.departinvoicesno =:departinvoicesno")
				.append(" and ds.balance.id=b.id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesno", departinvoicesno);
		List<Balance> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Departinvoices> qryInvoinces(Date startdate, Date enddate,
			String invoinceids) {
		StringBuilder sql = null;
		String curids = "";
		List<Departinvoices> alllist = new ArrayList<Departinvoices>();
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 1000) {
				curids = invoinceids.substring(0, 980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder("select ds")
					.append(" from Departinvoices ds")
					.append(" where (ds.status='0' or ds.status='3') and ds.id in ("
							+ curids + ")")
					.append(" and ds.departdate>=:startdate and ds.departdate<=:enddate");

			Query query = em.createQuery(sql.toString());
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
			alllist.addAll(query.getResultList());
		}
		return alllist;
	}
	@SuppressWarnings("unchecked")
	public List<Departinvoicesother> qryDepartinvoicesother(Date startdate, Date enddate,
			String invoinceids) {
		StringBuilder sql = null;
		String curids = "";
		List<Departinvoicesother> alllist = new ArrayList<Departinvoicesother>();
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 1000) {
				curids = invoinceids.substring(0, 980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder("select ds")
					.append(" from Departinvoicesother ds")
					.append(" where (ds.status='0' or ds.status='3') and ds.id in ("
							+ curids + ")")
					.append(" and ds.departdate>=:startdate and ds.departdate<=:enddate");

			Query query = em.createQuery(sql.toString());
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
			List ll = query.getResultList();
			Collections.reverse(ll);
			alllist.addAll(ll);
		}
		return alllist;
	}

	@SuppressWarnings("unchecked")
	public List<Ticketsell> qryTickets(Date departdate, long departinvoicesid) {
		StringBuilder sql = null;
		sql = new StringBuilder("select s")
				.append(" from Ticketsell s")
				.append(" where s.departdate=:departdate and s.departinvoices.id=:departinvoicesid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		query.setParameter("departdate", departdate);
		List<Ticketsell> list = query.getResultList();
		return list;
	}

	// 查询结算时的扣费明细信息
	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceductdetail(long orgid, long balanceunitid) {
		StringBuilder sql = new StringBuilder("select ")
				.append(" d.id,bi.name, round(nvl(d.deductmoney, 0), 2)  as deductmoney,nvl(d.divdedeductmoney,0) as divdedeductmoney")
				.append(" from Balancedeductdetail d,Balancedeductitem bi")
				.append(" where d.balancedeductitemid=bi.id and d.balanceunitid=:balanceunitid")
				.append(" and (d.status='0' or d.status='3') and d.balance is null and d.orgid=:orgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("balanceunitid", balanceunitid);
		return query.getResultList();
	}

	// 查询结算时的扣费明细信息
	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceductdetailByVehicleid(long orgid,
			long balancevehicleid) {
		StringBuilder sql = new StringBuilder("select ")
				.append(" d.id,bi.name, round(nvl(d.deductmoney, 0), 2) as deductmoney,nvl(d.divdedeductmoney,0) as divdedeductmoney")
				.append(" from Balancedeductdetail d,Balancedeductitem bi")
				.append(" where d.balancedeductitemid=bi.id and d.balancevehicleid=:balancevehicleid ")
				.append(" and (d.status='0' or d.status='3') and d.balance is null and d.orgid=:orgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("balancevehicleid", balancevehicleid);
		return query.getResultList();
	}

	// 打印时查询结算时的扣费明细信息
	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceDeductDetail(long balanceid, String isprint) {
		List<Object> list = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder("");
		if (isprint.equals("1")) {
			sql = new StringBuilder(
								"select name,nvl(sum(deductmoney), 0) as deductmoney,")
			.append("  0 divdedeductmoney,code")
			.append("  from (select bt.name,nvl(sum(dd.deductmoney), 0) as deductmoney,")
			.append("  0 divdedeductmoney, bt.code")
			.append("   from departinvoices             d,departinvoicesdeductdetail dd,")
			.append("        balancedeductitem          bt   where d.id = dd.departinvoicesid")
			.append("        and dd.balanceitemid = bt.id and d.balanceid =:balanceid")
			.append("        and d.status = '2'  and dd.status = '2'  group by bt.name, bt.code")
			.append("     union all")
			.append("   select bt.name, nvl(sum(t.stationfee), 0) as deductmoney,")
			.append("     0 divdedeductmoney,bt.code from departinvoicesother t, balancedeductitem bt")
			.append("   where t.orgid = bt.orgid  and bt.code = 'C' and bt.isticketpriceitem=1 and t.balanceid =:balanceid")
			.append("   group by bt.name, bt.code) group by name, code");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("balanceid", balanceid);
			list = query.getResultList();
		}
		sql = new StringBuilder("select ")
				.append(" bi.name,nvl(d.deductmoney,0) as deductmoney,nvl(d.divdedeductmoney,0) as divdedeductmoney,bi.code")
				.append(" from Balancedeductdetail d,Balancedeductitem bi")
				.append(" where d.balancedeductitemid=bi.id ")
				.append(" and d.status='0' and d.balance.id=:balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		list.addAll(query.getResultList());
		return list;
	}

	// 打印时查询结算时的扣费明细信息
	@SuppressWarnings("unchecked")
	public List<Vehicleviolation> qryVehicleviolation(long balanceid) {
		StringBuilder sql = new StringBuilder("select d").append(
				" from Vehicleviolation d").append(
				" where d.balance.id=:balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Balancedeductdetail> qryBalanceDeductDetail2(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder("select d ")
				.append(" from Balancedeductdetail d,Balancedeductitem bi")
				.append(" where d.balancedeductitemid=bi.id ")
				.append(" and d.status='0' and d.balance is null");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public Balancedeductdetail qryPackDeduct(long balancevehicleid, long orgid) {
		StringBuilder sql = new StringBuilder("select d ")
				.append(" from Balancedeductdetail d,Balancedeductitem bi")
				.append(" where d.balancedeductitemid=bi.id and d.orgid=:orgid")
				.append(" and d.status='0' and d.balance is null ")
				.append(" and d.balancevehicleid=:balancevehicleid and bi.code='packfee'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balancevehicleid", balancevehicleid);
		query.setParameter("orgid", orgid);
		List<Balancedeductdetail> blist = query.getResultList();
		return blist != null && blist.size() > 0 ? blist.get(0) : null;
	}

	// 查询计算附加费扣费信息
	@SuppressWarnings("unchecked")
	public List<Object> qryAdditionFee(String invoinceids, long vehicleid,
			long orgid, String otherinvoicesids) {
		StringBuilder sql = new StringBuilder("");
		String curids = "";

		while (invoinceids.length() > 0 && otherinvoicesids.length() == 0) {
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			if (sql.toString().equals("")) {
				sql = sql
						.append("select nvl(id,1),reachstationid,name,sum(ticketnum) sum,deductmoney,vehicleid,orgid,sum(totalfee) totalfee")
						.append(" from ( select bs.id,dd.reachstationid ,")
						.append("s.name,sum(dd.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dd.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesdetail dd")
						.append(" left join balancestationdeduct bs on dd.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dd.reachstationid = s.id")
						.append(" and dd.departinvoicesid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dd.reachstationid , s.name");
			} else {
				sql = sql
						.append(" union all ")
						.append(" select bs.id,dd.reachstationid ,")
						.append("s.name,sum(dd.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dd.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesdetail dd")
						.append(" left join balancestationdeduct bs on dd.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dd.reachstationid = s.id")
						.append(" and dd.departinvoicesid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dd.reachstationid , s.name");
			}
			sql.append(
					" )group by id, orgid, vehicleid, deductmoney, reachstationid, name")
					.append(" order by reachstationid");
			Query query = em.createNativeQuery(sql.toString());
			return query.getResultList();
		}

		while (invoinceids.length() == 0 && otherinvoicesids.length() > 0) {
			if (otherinvoicesids.length() > 2000) {
				curids = otherinvoicesids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				otherinvoicesids = otherinvoicesids.substring(
						curids.length() + 1, otherinvoicesids.length());
			} else {
				curids = otherinvoicesids;
				otherinvoicesids = "";
			}
			if (sql.toString().equals("")) {
				sql = sql
						.append("select nvl(id,1),reachstationid,name,sum(ticketnum) sum,deductmoney,vehicleid,orgid,sum(totalfee) totalfee")
						.append(" from ( select bs.id,dod.reachstationid ,")
						.append("s.name,sum(dod.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dod.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesotherdetail dod")
						.append(" left join balancestationdeduct bs on dod.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dod.reachstationid = s.id")
						.append(" and dod.departinvoicesotherid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dod.reachstationid , s.name");
			} else {
				sql = sql
						.append(" union all ")
						.append(" select bs.id,dod.reachstationid ,")
						.append("s.name,sum(dod.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dod.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesotherdetail dod")
						.append(" left join balancestationdeduct bs on dod.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dod.reachstationid = s.id")
						.append(" and dod.departinvoicesotherid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dod.reachstationid , s.name");
			}
			sql.append(
					" )group by id, orgid, vehicleid, deductmoney, reachstationid, name")
					.append(" order by reachstationid");
			Query query = em.createNativeQuery(sql.toString());
			return query.getResultList();
		}
		
		
		while(invoinceids.length() > 0 && otherinvoicesids.length() > 0){
			
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			if (sql.toString().equals("")) {
				sql = sql.append(" select id,reachstationid,name,sum(sum) sum,sum(deductmoney) deductmoney,vehicleid,orgid,sum(totalfee) totalfee from ")				
						.append(" (select nvl(id,1) id,reachstationid,name,sum(ticketnum) sum,deductmoney,vehicleid,orgid,sum(totalfee) totalfee")
						.append(" from ( select bs.id,dd.reachstationid ,")
						.append("s.name,sum(dd.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dd.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesdetail dd")
						.append(" left join balancestationdeduct bs on dd.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dd.reachstationid = s.id")
						.append(" and dd.departinvoicesid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dd.reachstationid , s.name");
			} else {
				sql = sql
						.append(" union all ")
						.append(" select bs.id,dd.reachstationid ,")
						.append("s.name,sum(dd.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dd.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesdetail dd")
						.append(" left join balancestationdeduct bs on dd.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dd.reachstationid = s.id")
						.append(" and dd.departinvoicesid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dd.reachstationid , s.name");
			}
			sql.append(
					" )group by id, orgid, vehicleid, deductmoney, reachstationid, name");
					
			
			if (otherinvoicesids.length() > 2000) {
				curids = otherinvoicesids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				otherinvoicesids = otherinvoicesids.substring(
						curids.length() + 1, otherinvoicesids.length());
			} else {
				curids = otherinvoicesids;
				otherinvoicesids = "";
			}
			
			StringBuilder sql2 = new StringBuilder();
			if (sql2.toString().equals("")) {
				sql2 = sql2.append(" union all ")
				 
						.append(" select nvl(id,1) id,reachstationid,name,sum(ticketnum) sum,deductmoney,vehicleid,orgid,sum(totalfee) totalfee")
						.append(" from ( select bs.id,dod.reachstationid ,")
						.append("s.name,sum(dod.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dod.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesotherdetail dod")
						.append(" left join balancestationdeduct bs on dod.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dod.reachstationid = s.id")
						.append(" and dod.departinvoicesotherid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dod.reachstationid , s.name ");
			} else {
				sql2 = sql2
						.append(" union all ")
						.append(" select bs.id,dod.reachstationid ,")
						.append("s.name,sum(dod.ticketnum) ticketnum,")
						.append(" nvl(bs.deductmoney, 0) deductmoney,")
						.append(" nvl(bs.vehicleid," + vehicleid
								+ ") vehicleid,nvl(bs.orgid," + orgid
								+ ") orgid,")
						.append(" nvl(sum(dod.ticketnum*bs.deductmoney), 0) totalfee")
						.append(" from departinvoicesotherdetail dod")
						.append(" left join balancestationdeduct bs on dod.reachstationid = bs.stationid")
						.append(" and bs.vehicleid=" + vehicleid)
						.append(" and bs.orgid=" + orgid + ",")
						.append(" station s where dod.reachstationid = s.id")
						.append(" and dod.departinvoicesotherid in (" + curids + ")")
						.append(" group by bs.id,bs.orgid,bs.vehicleid,bs.deductmoney,dod.reachstationid , s.name");
			}
			sql2.append(
					" )group by id, orgid, vehicleid, deductmoney, reachstationid, name)");
			
			
			sql.append(sql2).append(" group by id, orgid, vehicleid, deductmoney, reachstationid, name ")
			.append(" order by reachstationid ");
			
			Query query = em.createNativeQuery(sql.toString());
			return query.getResultList();
			
						
		}
		
		return null;
				

	}

	// 结算界面中自动获取站务附加费扣费信息
	@SuppressWarnings("unchecked")
	public BigDecimal qryStatioinAdditionFee(String invoinceids,
			long vehicleid, long orgid) {
		StringBuilder sql = new StringBuilder();
		BigDecimal additionfee = new BigDecimal(0);
		// invoinceids = invoinceids.substring(1, invoinceids.length() - 1);
		String curids = "";
		while (invoinceids.length() > 0) {
			if (invoinceids.length() > 2000) {
				curids = invoinceids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoinceids = invoinceids.substring(curids.length() + 1,
						invoinceids.length());
			} else {
				curids = invoinceids;
				invoinceids = "";
			}
			sql = new StringBuilder(
					"select nvl(sum(dd.ticketnum*bs.deductmoney), 0) totalfee")
					.append(" from departinvoicesdetail dd,")
					.append("  balancestationdeduct bs where  dd.reachstationid = bs.stationid")
					.append(" and bs.vehicleid=" + vehicleid)
					.append(" and bs.orgid=" + orgid)
					.append(" and dd.departinvoicesid in (" + curids + ")");

			Query query = em.createNativeQuery(sql.toString());
			List<Object> list = query.getResultList();
			additionfee = additionfee.add((BigDecimal) list.get(0));
		}
		return additionfee;

	}

	// 查询站点附加费扣费信息
	@SuppressWarnings("unchecked")
	public List<Balancestationdeduct> qryBalancestationdeduct(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"select t  from  Balancestationdeduct t where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();

	}

	// 查询车辆固定扣费信息
	@SuppressWarnings("unchecked")
	public List<Balancevehiclededuct> qryBalancevehiclededuct(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"select t  from  Balancevehiclededuct t where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();

	}

	// 查询结算单位固定扣费信息
	@SuppressWarnings("unchecked")
	public List<Balanceunitdeduct> qryBalanceunitdeduct(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"select t  from  Balanceunitdeduct t where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();

	}

	// 查询车辆固定扣费信息
	@SuppressWarnings("unchecked")
	public List<Balancevehicleagentrate> qryBalancevehicleagentrate(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"select t  from  Balancevehicleagentrate t where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();

	}

	// 查询车辆营运线路
	@SuppressWarnings("unchecked")
	public String qryRoutename(String vehicleno) {
		StringBuilder sql = new StringBuilder(
				"select r.name from  Vehicle v,route r where v.routeid=r.id and v.vehicleno=:vehicleno");

		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("vehicleno", vehicleno);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0).toString() : "";

	}

	// 车辆罚金
	@SuppressWarnings("unchecked")
	public BigDecimal qryVehicleviolation(String vehicleids, long orgid) {
		StringBuilder sql = new StringBuilder(
				"select sum(debit) from  Vehicleviolation v where ishandle=0 and v.balance is null")
				.append(" and status=0 and v.orgid=:orgid and v.vehicleid in "
						+ vehicleids);
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		List<Object> list = query.getResultList();
		return (BigDecimal) (list != null && list.size() > 0 ? list.get(0)
				: new BigDecimal(0));

	}

	// 车辆罚金
	@SuppressWarnings("unchecked")
	public List<Vehicleviolation> qryVehicleviolations(String vehicleids,
			long orgid) {
		StringBuilder sql = new StringBuilder(
				"select v from  Vehicleviolation v where ishandle=0 and v.balance is null")
				.append(" and status=0 and v.orgid=:orgid and v.vehicleid in "
						+ vehicleids);
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		List<Vehicleviolation> list = query.getResultList();
		return list;
	}

	// 车辆晚点罚金
	@SuppressWarnings("unchecked")
	public List<Vehiclelate> qryVehiclelate(String vehicleids) {
		StringBuilder sql = new StringBuilder(
				"select v from  Vehiclelate v where v.balance is null and v.vehicleid in "
						+ vehicleids);
		Query query = em.createQuery(sql.toString());
		List<Vehiclelate> list = query.getResultList();
		return list;
	}

	// 车辆晚点罚金
	@SuppressWarnings("unchecked")
	public List<Vehiclelate> qryVehiclelate(long balanceid) {
		StringBuilder sql = new StringBuilder(
				"select v from  Vehiclelate v where v.balance.id=:balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		List<Vehiclelate> list = query.getResultList();
		return list;
	}

	//
	@SuppressWarnings("unchecked")
	public boolean isExistBalancedeNo(String balanceno) {
		StringBuilder sql = new StringBuilder("select d ").append(
				" from Balance d").append(" where d.balanceno=:balanceno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceno", balanceno);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 查询单车已结算信息
	@SuppressWarnings("unchecked")
	public List<Object> qryVehicleBalanced(Date startdate, Date enddate,
			String orgids, long vehicleid, long unitid) {
		StringBuilder sql = new StringBuilder("select b.id, b.balancetime,")
				.append(" v.vehicleno,u.name as unitname,(b.ditotalmoney-distationservicefee) ditotalmoney,")
				.append(" b.dibalancemoney,b.diagentfee,b.balancemoney")
				.append(" from Balance b, Vehicle v, Unit u")
				.append(" where b.objectid = v.id and v.unitid = u.id")
				.append(" and b.balanceobject = 1 and b.status = '0'")
				.append(" and b.balancetime between :startdate and :enddate+0.99999")
				.append(" and b.orgid in " + orgids);
		if (vehicleid > 0) {
			sql.append(" and v.id=" + vehicleid);
		}
		if (unitid > 0) {
			sql.append(" and u.id=" + unitid);
		}
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		return list;
	}

	// 查询单车已结算信息扣费信息
	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceductdetail(long balanceid) {
		StringBuilder sql = new StringBuilder("select ")
				.append(" decode(bi.parentid,0,bi.name,(select pbi.name from balancedeductitem pbi where pbi.id = bi.parentid)) name,")
				.append(" decode(bi.parentid,0,bi.code,(select pbi.code from balancedeductitem pbi where pbi.id = bi.parentid)) code,")
				.append(" sum(d.deductmoney) as deductmoney")
				.append(" from Balancedeductdetail d,Balancedeductitem bi")
				.append(" where d.balancedeductitemid=bi.id ")
				.append(" and (d.status='0' or d.status='3') and d.balanceid=:balanceid")
				.append(" group by bi.parentid,bi.code ,bi.name");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		return query.getResultList();
	}

	// 查询单车已结算信息所有扣费项目
	@SuppressWarnings("unchecked")
	public List<Object> qryVehicleBalancedItem(Date startdate, Date enddate,
			String orgids, long vehicleid, long unitid) {
		StringBuilder sql = new StringBuilder("select name, code")
				.append(" from (select ")
				.append(" decode(bi.parentid,0,bi.name,(select pbi.name from balancedeductitem pbi where pbi.id = bi.parentid)) name,")
				.append(" decode(bi.parentid,0,bi.code,(select pbi.code from balancedeductitem pbi where pbi.id = bi.parentid)) code ")
				.append(" from balance  b,vehicle v,unit u,")
				.append(" balancedeductdetail d,balancedeductitem bi")
				.append(" where b.objectid = v.id and v.unitid = u.id and b.id=d.balanceid")
				.append("  and d.balancedeductitemid = bi.id and b.balanceobject = 1")
				.append("  and b.status = '0' ")
				.append("  and b.balancetime between :startdate and :enddate+0.99999")
				.append("  and b.orgid in " + orgids);
		if (vehicleid > 0) {
			sql.append(" and v.id=" + vehicleid);
		}
		if (unitid > 0) {
			sql.append(" and u.id=" + unitid);
		}
		sql.append(" ) group by name, code");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		return list;
	}

	// 查询单车企业运输费
	@SuppressWarnings("unchecked")
	public List<Object> qryBalancedBusTransport(
			List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer("select orgname,").append(
				" routename,vehicleno,nvl(sum(deductmoney), 0) as deductmoney")
				.append(" from (");
		sb.append(" select  ");
		sb.append(" org.name as orgname,r.name as routename,b.vehicleno,nvl(sum(bd.deductmoney),0) as deductmoney ");
		sb.append(" from Balance b,Balancedeductdetail bd,Balancedeductitem bt,Vehicle v,Route r,Organization org, Unit u ");
		sb.append(" where bd.balanceid=b.id and bt.id=bd.balancedeductitemid and v.vehicleno=b.vehicleno ");
		sb.append(" and r.id=v.routeid and org.id=b.orgid and b.status=0 and  bt.parentid=0");
		sb.append(" and u.id=v.unitid and bt.code='qyysffee' and b.balanceobject='1' ");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		sb.append(" group by  org.name ,r.name ,b.vehicleno");
		sb.append(" union all select  ");
		sb.append(" org.name as orgname,r.name as routename,b.vehicleno,nvl(sum(bd.deductmoney),0) as deductmoney ");
		sb.append(" from Balance b,Balancedeductdetail bd,Balancedeductitem bt,Balancedeductitem pbt,Vehicle v,Route r,Organization org, Unit u ");
		sb.append(" where bd.balanceid=b.id and bt.id=bd.balancedeductitemid and v.vehicleno=b.vehicleno ");
		sb.append(" and r.id=v.routeid and org.id=b.orgid and b.status=0 and bt.parentid = pbt.id");
		sb.append(" and u.id=v.unitid and pbt.code='qyysffee' and b.balanceobject='1' ");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		sb.append(" group by  org.name ,r.name ,b.vehicleno)");
		sb.append(" group by  orgname ,routename ,vehicleno");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> list = query.getResultList();
		return list;
	}

	// 结算月报表
	@SuppressWarnings("unchecked")
	public List<Object> qryBalancedMonth(Date startdate, Date enddate) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");
		String stdate = sf.format(startdate);
		String eddate = sf.format(enddate);
		StringBuilder sql = new StringBuilder(
				" select sum(totalamount-stationservicefee) totalamount,")
				.append(" sum(stationservicefee) stationservicefee,sum(returnhandcharge) returnhandcharge,")
				.append(" sum(outprice) outprice, sum(balancemoney) balancemoney,sum(returnmoney) returnmoney,")
				.append(" (sum(totalamount)-sum(stationservicefee) + sum(outprice) - sum(balancemoney) - sum(returnmoney)) income")
				.append(" from (select sum(totalamount) totalamount,sum(stationservicefee) stationservicefee,")
				.append(" 0 returnhandcharge,0 outprice,0 balancemoney,0 returnmoney")
				.append("       from departinvoices d")
				.append("     where d.status <> '1' and d.departdate between :startdate and :enddate")
				.append("  union all")
				.append("    select 0 totalamount,0 stationservicefee,sum(returnhandcharge) returnhandcharge,")
				.append("           0 outprice,0 balancemoney,sum(returnmoney) returnmoney")
				.append("       from ticketturnoverdetail d")
				.append("     where d.moneydate between :startdate and :enddate")
				.append("  union all")
				.append("    select 0 totalamount,0 stationservicefee,0 returnhandcharge,")
				.append("           0 outprice,sum(balancemoney) balancemoney,0 returnmoney")
				.append("       from balance d, departinvoices dd")
				.append("	  where d.id = dd.balanceid and dd.departdate between :startdate and :enddate")
				.append("       and d.status = '0'")
				.append("  union all")
				.append("   select 0 totalamount,0 stationservicefee,0 returnhandcharge,sum(balancemoney) outprice,")
				.append("          0 balancemoney,0 returnmoney")
				.append("       from outstationupmoney d")
				.append("     where d.departmonth between :stdate and :eddate)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("stdate", stdate);
		query.setParameter("eddate", eddate);
		List<Object> list = query.getResultList();
		return list;
	}

	public boolean updateTicketsellinfo(String ticketsellids) {

		StringBuilder sql = new StringBuilder();
		sql.append(
				" update ticketsell ts set ts.isdepartinvoices=0,ts.departinvoicesby=null,ts.departinvoicestime=null,ts.departinvoicesid=null ")
				.append(" where ts.id = ").append(ticketsellids);

		Query query = getEntityManager().createNativeQuery(sql.toString());

		int result = query.executeUpdate();

		if (result > 0) {
			return true;
		} else {
			return false;
		}

	}

	public long getTicketnum(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.ticketnum),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		Long sumticketnum = (Long) query.getSingleResult();

		return sumticketnum;
	}

	public BigDecimal getTotalamount(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.totalamount),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getAgentfee(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.agentfee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getStationfee(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.stationservicefee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getBalanceamount(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.balanceamount),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getOtherfee(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.othterfee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getFueladditionfee(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.fueladditionfee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public List<Departinvoicesdetail> qryDepartinvoicesDetail(
			long departinvoicesid, long fromstationid, long reachstationid,
			String tickettype, BigDecimal price) {

		StringBuffer sql = new StringBuffer();
		sql.append(
				" select dd from Departinvoicesdetail dd where dd.departinvoices.id=:departinvoicesid and dd.fromstationid=:fromstationid ")
				.append(" and dd.reachstationid =:reachstationid and dd.tickettype =:tickettype and dd.price =:price ");

		Query query = getEntityManager().createQuery(sql.toString(),
				Departinvoicesdetail.class);
		query.setParameter("departinvoicesid", departinvoicesid);
		query.setParameter("fromstationid", fromstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("tickettype", tickettype);
		query.setParameter("price", price);

		List<Departinvoicesdetail> list = query.getResultList();

		return list;
	}

	public boolean updateDepartinvoicesdetail(
			Departinvoicesdetail departinvoicesdetail) {

		StringBuffer sql = new StringBuffer();
		sql.append(
				" update departinvoicesdetail dd set dd.totalamount = round(dd.totalamount / dd.ticketnum,2) * (dd.ticketnum - 1), ")
				.append(" dd.stationservicefee = round(dd.stationservicefee / dd.ticketnum,2) * (dd.ticketnum - 1), ")
				.append(" dd.othterfee = round(dd.othterfee / dd.ticketnum,2) * (dd.ticketnum - 1), ")
				.append(" dd.agentfee = round(dd.agentfee / dd.ticketnum,2) * (dd.ticketnum - 1), ")
				.append(" dd.balanceamount = round(dd.balanceamount / dd.ticketnum,2) * (dd.ticketnum - 1), ")
				.append(" dd.fueladditionfee = round(dd.fueladditionfee / dd.ticketnum,2) * (dd.ticketnum - 1),dd.ticketnum = dd.ticketnum - 1 ")
				.append("  where dd.id =").append(departinvoicesdetail.getId());

		Query query = getEntityManager().createNativeQuery(sql.toString());

		int result = query.executeUpdate();

		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}

	public List<Object> qryvehicleno(String param,
			List<PropertyFilter> propertyFilters) {
		StringBuffer sql = new StringBuffer();
		sql.append(
		"select t.id,t.vehicleno as name,t.cardno as code,t.seatnum ")
		.append(" from Vehicle t ,Vehiclebrandmodel  v,Unit u,Vehicletype ve,Unit u2,Digitaldictionary d,Digitaldictionarydetail dd ")
		.append(" where t.isactive=1 and t.unitid=u.id and t.vehiclebrandmodelid=v.id and d.tablename = 'vehicle' and d.columnname = 'type' and dd.digitaldictionaryid = d.id and dd.code = t.type and t.vehicletypeid=ve.id and t.vehicleno like '%")
		.append(param).append("%'")
		.append(" and t.balanceunitid=u2.id ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result = query.getResultList();
		return result;
	}
	
	// 注销时更新实际收费管理
	public boolean updateActualfee(long balanceid, long updateby) {
		StringBuilder sql = new StringBuilder("update ")
				.append(" actualfee af set af.balanceid=null,")
				.append(" af.updatetime=:updatetime,af.updateby=:updateby,af.isbalanceed=0")								
				.append(" where af.balanceid=:balanceid ");
		Query query = em.createNativeQuery(sql.toString());			
		query.setParameter("updatetime", new Date());
		query.setParameter("updateby", updateby);
		query.setParameter("balanceid", balanceid);	
		int count = query.executeUpdate();
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 注销时清除结算明细数据
	public boolean delBalancedetail(long balanceid) {
		StringBuilder sql = new StringBuilder();
				sql.append(" delete from balancedetail bd where bd.balanceid=:balanceid ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("balanceid", balanceid);		
		int count = query.executeUpdate();
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public List<Pack> getPack(long vehicleid, Date fromdapart, Date todapart) {

		StringBuilder sql = new StringBuilder("select t from Pack t")
				.append(" where (t.status = '0' or t.status = '1' or t.status = '2')")
				.append("  and t.vehicleid=:vehicleid and t.departdate between :fromdapart and :todapart");
		Query query = em.createQuery(sql.toString());
		query.setParameter("fromdapart", fromdapart);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("todapart", todapart);
		return query.getResultList();

	}
	public List<Object> qrybalanceACPrintinfo(Long balanceid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select MAX(vehicleno),WM_CONCAT(distinct routename), sum(jyglfee),  sum(sghzjprice), sum(jcfkdeduct),  sum(skdeduct),sum(qtitem88),    ")
            .append(" sum(dqtcl), sum(bqqrw),  sum(clzj), sum(phc), sum(hpitem80),  sum(hffee), sum(aqcbjprice), sum(zwrffee),sum(hpbalanceamount)     ")
            .append(" from ( select b.vehicleno,WM_CONCAT(distinct s.name) as routename, 0 as jyglfee, 0 as sghzjprice, 0 as jcfkdeduct,  ")
            .append(" 0 as skdeduct, 0 as qtitem88, 0 as dqtcl, 0 as bqqrw, 0 as clzj, 0 as phc, 0 as hpitem80, 0 as hffee, 0 as aqcbjprice , 0 as zwrffee   ")   
            .append(" ,0 as hpbalanceamount   ")
            .append(" from balance b  ")
            .append(" left join departinvoices d on d.balanceid = b.id   ")
            .append(" left join scheduleplan sp on sp.id = d.scheduleplanid ")
            .append(" left join station s on s.id = sp.endstationid   ")
            .append(" where b.id = :balanceid ")
            .append(" group by b.vehicleno ")
            .append(" union all ")
	        .append(" select b.vehicleno,WM_CONCAT(distinct s.name) as routename, 0 as jyglfee, 0 as sghzjprice, 0 as jcfkdeduct,   ")
	        .append(" 0 as skdeduct, 0 as qtitem88, 0 as dqtcl, 0 as bqqrw, 0 as clzj, 0 as phc, 0 as hpitem80, 0 as hffee, 0 as aqcbjprice , 0 as zwrffee     ")  
	        .append(" ,sum(case when do.ticketnum = 0 then do.balancemoney  else 0 end) hpbalanceamount    ")
	        .append(" from balance b   ")
	        .append(" left join departinvoicesother do on do.balanceid = b.id    ")
	        .append(" left join schedule  sc on sc.id = do.scheduleid  ")
	        .append(" left join route r on r.id = sc.routeid ")
	        .append(" left join station s on s.id = r.endstationid ")
	        .append(" where b.id = :balanceid ")
	        .append(" group by b.vehicleno  ")
	        .append(" union all  ")
            .append(" select '' vehicleno,null routename,  ")
            .append(" sum(case when bi.code = 'jyglffee' then d.deductmoney else 0 end) jyglfee, ")
            .append(" sum(case when bi.code = 'sghzjprice' then d.deductmoney else 0 end) sghzjprice, ")
            .append(" sum(case when bi.code = 'jcfkdeduct' then d.deductmoney else 0 end) jcfkdeduct, ")
            .append(" sum(case when bi.code = 'skdeduct' then d.deductmoney else 0 end )skdeduct, ")
            .append(" sum(case when (bi.code = 'qtitem88' or bi.name = '其他') then d.deductmoney else 0 end) qtitem88, ")
            .append(" sum(case when bi.code = 'dqtcl' then d.deductmoney else 0 end) dqtcl, ")
            .append(" sum(case when bi.code = 'bqqrw' then d.deductmoney else 0 end) bqqrw, ")
            .append(" sum(case when bi.code = 'clzj' then d.deductmoney else 0 end) clzj, ")
            .append(" sum(case when bi.code = 'phc' then d.deductmoney else 0 end) phc, ")
            .append(" sum(case when bi.code = 'hpitem80' or bi.name = '货票' then d.deductmoney else 0 end) hpitem80, ")
            .append(" sum(case when bi.code = 'hffee' then d.deductmoney else 0 end) hffee, ")
            .append(" sum(case when bi.code = 'aqcbjprice' then d.deductmoney else 0 end) aqcbjprice , ")
            .append(" sum(case when bi.code = 'zw(r)ffee' then d.deductmoney else 0 end) zwrffee  , ")
            .append(" 0 as hpbalanceamount    ")
            .append(" from Balancedeductdetail d,Balancedeductitem bi  ")
            .append(" where d.balancedeductitemid=bi.id and d.balanceid  = :balanceid )");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		List<Object> result = query.getResultList();
		return result;
	}

	public boolean saveagentfee(long departinvoicesid, String deductmoney,BigDecimal balanceamount) {
		// TODO Auto-generated method stub
		boolean flag=false;
		StringBuilder sqldeductdetail = new StringBuilder();
		StringBuilder sqldepartinvoices = new StringBuilder();
		sqldepartinvoices.append(
		"update departinvoices d set d.agentfee =").append(deductmoney)
						.append(" ,d.balanceamount=").append(balanceamount)
		.append(" where d.id= ").append(departinvoicesid);

		Query query = getEntityManager().createNativeQuery(sqldepartinvoices.toString());
		int result = query.executeUpdate();
		
		if (result > 0) {
			flag= true;
			sqldeductdetail.append(
			" update departinvoicesdeductdetail d set d.deductmoney=").append(deductmoney)
			.append(" where d.departinvoicesid= ").append(departinvoicesid)
			.append(" and d.isdeductbeforebalance = 1 and d.status != '1' and d.type = '1'");

			query = getEntityManager().createNativeQuery(sqldeductdetail.toString());
			result = query.executeUpdate();
			if (result > 0) {
				flag= true;
			}
		}
			return flag;	
	}
	
	/**
	 * 九江：查询已经结算的停车费记录
	 * @param balanceid
	 * @return
	 */
	public List<VehicleParkFee> qryBalancedVehicleParkFees(Long balanceid){
		StringBuffer sql = new StringBuffer();
		sql.append("select t from VehicleParkFee t ")
			.append(" where t.isbalanced = 1 and t.balanceid = :balanceid  ");
		
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("balanceid", balanceid);
		
		return query.getResultList();
	}
	
	public String getVehicleUnitname(long id) {
		StringBuffer sql = new StringBuffer();
//		sql.append(" select u.fullname from balance b ")
//		.append(" left join departinvoices d on d.balanceid = b.id ")
//		.append(" left join vehicle v on v.id = d.vehicleid ")
//		.append(" left join unit u on u.id = v.unitid ")
//		.append(" where b.id = :id ");
		sql.append("select u.fullname from unit u where u.id =:id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		List list = query.getResultList();
		return (String) (list!=null&&list.size()>0?list.get(0):"");
	}
	public BigDecimal qryBaoChePrice(String otherinvoicesids) {
		List<String> idList = new ArrayList<String>();
		String[] oids = otherinvoicesids.split(",");
		if(oids.length>=1000){
			for (int i = 0; i < (oids.length-1)/1000+1; i++) {
				String ids = StringUtils.join(oids, ",", i*1000, (i+1)*1000>oids.length?oids.length:(i+1)*1000);
				idList.add(ids);
			}
		}else{
			idList.add(otherinvoicesids);
		}
		StringBuffer sql = new StringBuffer();
		sql.append("select nvl(sum(t.totalmoney),0) as totalmoney  from departinvoicesother t where t.datafrom = '9' and t.status<>1 and(");
		for (int i = 0; i < idList.size(); i++) {
			if(i==0){
				sql.append(" t.id in ("+idList.get(i)+")");
			}else{
				sql.append(" or t.id in ("+idList.get(i)+")");
			}
		}
		sql.append(")");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List list = query.getResultList();
		return (BigDecimal) (list!=null && list.size()>0 ? list.get(0) : BigDecimal.ZERO);
	}
	
	public List<Object> qryDepartinvoices(List<String> list) {
		// 全部
		StringBuilder sql = new StringBuilder("select '', r.name as routename,ds.id,s1.name as endstation,")
				.append(" ds.departinvoicesno,ds.departdate,s.code,trim(ds.departtime) as departtime,")
				.append(" (ds.ticketnum + ds.supplyticketnum) as ticketnum,")
				.append(" (ds.totalamount + ds.supplyamount) as totalamount,")
				.append(" (ds.balanceamount + ds.supplybalanceamount) as balanceamount,")
				.append(" ui.name as printname,ds.printtime,u.name as unitname,")
				.append(" v.vehicleno, ds.stationservicefee,ds.fueladditionfee,")
				.append(" ds.agentfee,ds.othterfee,ds.supplyticketnum,")
				.append(" ds.supplyamount,ds.supplybalanceamount,ds.status,ds.vehicleid,s.routeid,")
				.append(" ds.balanceunitid,u2.name as balanceunitname,1 as iscomputerno,trim('微机运量') as departinvoicetypename,")
				.append(" u.fullname as vehicleUnitFullName,u2.fullname as balanceFullName,'' as datafrom ,  0 as pieces,  ")
				.append(" bal.balanceno as balanceno")
				.append(" from Departinvoices ds left join balance bal on ds.balanceid=bal.id,Schedule s,Userinfo ui,")
				.append(" Vehicle v,Unit u,Station s1,Route r,Unit u2")
				.append(" where ds.scheduleid = s.id and ds.vehicleid = v.id")
				.append(" and v.unitid = u.id and ds.printby = ui.id ")
				.append(" and s.routeid=r.id and r.endstationid = s1.id and ds.balanceunitid=u2.id and ds.status not in ('1','2') ")
				.append(" and ds.id in  :ids ");
		sql.append(" order by ds.departdate,s.routeid,ds.departtime");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("ids", list);
		List resultList = query.getResultList();

		sql = new StringBuilder(
				" select ds.isaudit as isaudit,r.name as routename,ds.id,s1.name as endstation,ds.departinvoicesno,ds.departdate,s.code, ");// 手工运量单要查出isaudit字段，前台需进行4050参数的判断
		sql.append(
				" trim(ds.departtime) as departtime,ds.ticketnum as ticketnum,ds.totalmoney as totalamount,ds.balancemoney as balanceamount, ")
				.append(" ui.name as printname,ds.createtime as printtime,u.name as unitname,v.vehicleno,ds.stationfee as stationservicefee, 0 as fueladditionfee, ")
				.append(" ds.agentfee, ds.othterfee as othterfee, 0 as supplyticketnum,0 as supplyamount,0 as supplybalanceamount,ds.status,ds.vehicleid,s.routeid,ds.balanceunitid as balanceunitid,u2.name as balanceunitname,2 as iscomputerno,trim('手工运量') as departinvoicetypename, ")
				.append(" u.fullname as vehicleUnitFullName,u2.fullname as balanceFullName,ds.datafrom , ds.pieces, ")
				.append(" bal.balanceno as balanceno")
				.append(" from (departinvoicesother ds left join Unit u2 on ds.balanceunitid=u2.id) left join balance bal on ds.balanceid=bal.id, Schedule s, Userinfo ui,Vehicle v,Unit u,Station s1,Route r ")
				.append("  where ds.scheduleid = s.id and ds.vehicleid = v.id and v.unitid = u.id  and ds.createby = ui.id and s.routeid = r.id and r.endstationid = s1.id and ds.status not in ('1','2') ")
				.append(" and ds.id in  :ids ");
		sql.append(" order by ds.departdate,s.routeid,ds.departtime");
		query = em.createNativeQuery(sql.toString());
		query.setParameter("ids", list);
		resultList.addAll(query.getResultList());

		return resultList;
	}
	
	/**
	 * 结算单结算时，4008参数为0 ，根据结算单id,查询状态为已打单的
	 * @param invoicesids
	 * @return
	 */
	public List<Vehicleviolation> qryVehicleviolationByInvoicesid(
			String invoicesids) {
		String curids = "";
		List<Vehicleviolation> list = new ArrayList<Vehicleviolation>();
		while (invoicesids.length() > 0) {
			StringBuilder sql = new StringBuilder("");
			if (invoicesids.length() > 2000) {
				curids = invoicesids.substring(0, 1980);
				curids = curids.substring(0, curids.lastIndexOf(","));
				invoicesids = invoicesids.substring(curids.length() + 1,
						invoicesids.length());
			} else {
				curids = invoicesids;
				invoicesids = "";
			}
			sql.append(" select v from Vehicleviolation v where v.ishandle=0 and v.violationdate<=trunc(sysdate) ")
		    .append(" and v.status='4' and v.departinvoicesid in (" + curids + ")");
			Query query = em.createQuery(sql.toString());
			query.setLockMode(LockModeType.PESSIMISTIC_READ);
			list.addAll(query.getResultList());
		}
		return list;
	}
	public List<Object> qryCleanfee(Long balanceid) {
		StringBuilder sql = new StringBuilder("");
		sql.append(" select t from Balance t where t.id = :balanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceid",balanceid);
		Balance b = (Balance) query.getSingleResult();
		sql = new StringBuilder();
		sql.append(" select 'aaa' aaa,t.vehicleid,sum(cleanfee)* :Invoicesnum as cleanfee, ")
		.append(" sum(advfee)* :Invoicesnum as advfee,")
		.append("  sum(otherfee)* :Invoicesnum as otherfee, ")
		.append(" sum(recefee)* :Invoicesnum as recefee ")
		.append("  from (select af.vehicleid as vehicleid, ")//扣费
		.append(" nvl(af.recefee, 0) as recefee, 0 as cleanfee, ")
		.append("  0 as advfee, 0 as otherfee ")
		.append("   from actualfee af,vehicle v where af.vehicleid = v.id and ")
		.append("   af.isaddbalance=1 and af.balanceid is null ");
		sql.append("  and v.vehicleno in ('"+b.getVehicleno()+"') ");		
		sql.append(" and af.feefromdate between :startdate and :enddate and  af.feetodate between :startdate and :enddate ");	
		sql.append(" union all ")//清洁、宣传、其他费
		.append("  select fg.vehicleid as vehicleid, 0 as recefee,")
		.append("  nvl(fg.cleanfee, 0) as cleanfee,nvl(fg.advfee, 0) advfee, ")
		.append("  nvl(fg.otherfee, 0) as otherfee ")
		.append("  from feestandardstationagent fg,vehicle v ")
		.append("  where fg.vehicleid = v.id and v.vehicleno in ('"+b.getVehicleno()+"')");					
		sql.append("  ) t group by t.vehicleid ");
		query =em.createNativeQuery(sql.toString());
		query.setParameter("startdate", b.getDepartstartdate());
		query.setParameter("enddate", b.getDepartenddate());
		query.setParameter("Invoicesnum", b.getInvoicesnum());
		List list=query.getResultList();
		return list;
	}

}
