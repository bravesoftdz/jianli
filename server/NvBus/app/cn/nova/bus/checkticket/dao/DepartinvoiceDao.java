package cn.nova.bus.checkticket.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehicledriverreport;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author lck
 * 
 */
@SuppressWarnings("rawtypes")
public class DepartinvoiceDao extends EntityManagerDaoSurport {

	public Organization getOrganization(long stationid) {
		StringBuilder sql = new StringBuilder("select o from Organization o")
				.append(" where (o.type='1' or o.type='2') and o.isactive=1")
				.append(" and o.station.id=:stationid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		return (Organization) query.getSingleResult();
	}

	//重打结算单时获取打印次数，增加结算单号参数
	public BigDecimal qryDepartinvoicesOfreprint(long vehiclereportid, String originaldepartinvoicesno) {
		StringBuffer sql = new StringBuffer();
//		sql.append(" select t.id, (t.printnum + 1) from Departinvoices t where t.reportid=:reportid and t.status = 0");
		sql.append(" select t.id from Departinvoices t where t.reportid=:reportid and t.status = 0");
		sql.append(" and t.departinvoicesno = :originaldepartinvoicesno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("reportid", vehiclereportid);
		query.setParameter("originaldepartinvoicesno", originaldepartinvoicesno);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return new BigDecimal(list.get(0).toString());
		}
		return BigDecimal.ZERO;
	}
	// 查询正班的报到记录
	@SuppressWarnings("unchecked")
	public Vehiclereport getVehiclereport(Scheduleplan scheduleplan,
			long reportorgid) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1  ")
				.append(" and vr.scheduleplanid=:scheduleplanid and vr.reportorgid=:reportorgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		query.setParameter("reportorgid", reportorgid);
		//query.setParameter("isdeparted", isdeparted);		
		List<Object> list = query.getResultList();
		return (Vehiclereport) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 查询正班的报到记录
	@SuppressWarnings("unchecked")
	public Vehiclereport getVehiclereport(long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select vr").append(
				" from Vehiclereport vr").append(
				" where vr.isactive=1 and vr.id=:vehiclereportid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehiclereportid", vehiclereportid);
		List<Object> list = query.getResultList();
		return (Vehiclereport) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 查询已检车票未开结算单的并且是本站检的车票信息
	@SuppressWarnings("unchecked")
	public List<Ticketsell> getUnDepartTickets(long scheduleplanid,
			long vehiclereportid,long departstationid) {
		StringBuilder sql = new StringBuilder("select s from Ticketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.ticketstatus='0'")
				.append(" and s.ischecked=1 and s.isdepartinvoices=0")
				.append(" and s.vehiclereport.id=:vehiclereportid")
				.append(" and s.checkstation.id=:departstationid");
		
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("departstationid", departstationid);
		return query.getResultList();
	}

	// 查询已检车票未开结算单的并且是本站检的车票信息
	@SuppressWarnings("unchecked")
	public List<RemoteTicketsell> getUnRemoteTicket(long scheduleplanid,long vehiclereportid,long departorgid) {
		StringBuilder sql = new StringBuilder("select s from RemoteTicketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.ticketstatus='0'")
				.append(" and s.ischecked=1 and s.isdepartinvoices=0")
				.append(" and s.vehiclereportid=:vehiclereportid and s.departorgid=:departorgid");		
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("departorgid", departorgid);		
		return query.getResultList();
	}
	// 查询已检车票未开结算单的并且是本站检的车票信息机构
	@SuppressWarnings("unchecked")
	public List<Object> qryRemoteTickOrgid(long scheduleplanid,long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select s.ticketoutletsname from RemoteTicketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.ticketstatus='0'")
				.append(" and s.ischecked=1 and s.isdepartinvoices=0")
				.append(" and s.vehiclereportid=:vehiclereportid group by s.ticketoutletsname");		
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		return query.getResultList();
	}
	// 查询已检车票未开结算单的并且是本站检的车票信息机构
	@SuppressWarnings("unchecked")
	public List<RemoteTicketsell> qryRemoteTicketsell(long scheduleplanid,long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select s from RemoteTicketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.ticketstatus='0'")
				.append(" and s.ischecked=1 and s.isdepartinvoices=0")
				.append(" and s.vehiclereportid=:vehiclereportid");		
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		return query.getResultList();
	}
	// 更新开结算单的车票信息
	/**
	 * 根据旧运量单ID 和发车日期，修改车票的运量单信息，用于换车重打--by hhz
	 */
	public boolean upateTickets(String ticketids, Departinvoices departinvoices,long olddepartinvoicesid,Date departdate) {
		StringBuilder sql = new StringBuilder("update Ticketsell t ")
				.append(" set t.departinvoicesid=:departinvoicesid,")
				.append(" t.departinvoicesby=:departinvoicesby,")
				.append(" t.departinvoicestime=:departinvoicestime,")
				.append(" t.isdepartinvoices=1,")
				.append(" t.updateby=:updateby,")
				.append(" t.updatetime=:updatetime where 1 = 1 ");
		if (ticketids!=null){
			sql.append(" and t.id in " + ticketids);
		}
		if (olddepartinvoicesid!=0 ){
			sql.append(" and t.departinvoicesid = "+olddepartinvoicesid);
		}
		if (departdate!=null){
			sql.append(" and t.departdate = :departdate");
		}			
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoices.getId());
		query.setParameter("departinvoicesby", departinvoices.getCreateby());
		query.setParameter("departinvoicestime", departinvoices.getCreatetime());
		query.setParameter("updateby", departinvoices.getCreateby());
		query.setParameter("updatetime", departinvoices.getCreatetime());
		if (departdate !=null){
			query.setParameter("departdate", departdate);
		}
		query.executeUpdate();
		return true;
	}

	// 查询班次状态信息
	@SuppressWarnings("unchecked")
	public Schedulestatus getSchedulestatus(long scheduleplanid,
			long departstationid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s ")
				.append(" where s.scheduleplan.id=:scheduleplanid ").append(
						" and s.departstationid=:departstationid");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		List<Schedulestatus> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询结算单明细信息
	@SuppressWarnings("unchecked")
	public List<Object> findDepartinvoicesdetail(long departinvoicesid) {
		ParameterService parameterService = new ParameterServiceImpl();
		Global global = CurrentUtil.getGlobal();
		//打印结算单时 0:相同（始站）相同止站相同距离相同票价分组打印;1:相同（始站）相同止站相同距离相同票价相同(票种)分组打印
		//2:相同止站相同距离相同票价分组打印;3:相同止站相同距离相同票价相同(票种)分组打印
		//4:相同到站分组打印
		//5:相同到站相同票价分组打印
		//6:相同到站相同票价相同站务费分组打印
		String isPrintTicketType = parameterService.findParamValue(ParamterConst.Param_4015, global.getOrganization().getId());
		String groupbySql = "";
		if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_ZERO.equals(isPrintTicketType) ){//0
			groupbySql = " group by tmp.fromstation, tmp.reachstation, tmp.distance, tmp.price ";
		}
		else if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_ONE.equals(isPrintTicketType) ) {//1
			groupbySql = " group by tmp.fromstation, tmp.reachstation, tmp.distance, tmp.price, tmp.tickettype ";
		}
		else if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_TWO.equals(isPrintTicketType) ){//2
			groupbySql = " group by tmp.reachstation, tmp.distance, tmp.price ";
		}
		else if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_FIVE.equals(isPrintTicketType) ){//5
			groupbySql = " group by tmp.reachstation, tmp.price ";
		}
		else if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_SIX.equals(isPrintTicketType) ){//6
//			经讨论当参数=6时 取售票Ticketsell 的明细数据     没有考虑客运代理费的情况 因为没有地方取值 默认为0  如需改动则在讨论修改
			StringBuilder sqltypesix =  new StringBuilder();
			sqltypesix.append(" select '' fromstation, t.reachstation,")
			.append(" sum(case when t.tickettype = 'B' or t.tickettype = 'Z' then 0  else  t.peoples  end) fullpeople,")
			.append(" sum(case  when t.tickettype = 'B' then 0  else  t.peoples end) fullpeoples,")
			.append(" sum(t.peoples) reachstationpeople,")
			.append(" sum(case  when t.tickettype = 'B' then  t.peoples  else  0  end) halfpeople,")
			.append(" sum(t.totalamount) as totalamount,")
			.append(" max(t.distance) as distance,")
			.append(" max(t.price) as price,")
			.append(" sum(t.balanceamount) balanceamount,")
			.append(" max(t.balanceprice) balanceprice,")
			.append(" max(t.noservicestationfee) noservicestationfee,")
			.append(" sum(t.noagentbalanceamount) noagentbalanceamount,")
			.append(" sum(case when t.tickettype = 'Z' then t.peoples else 0 end) discountpeople,")
			.append(" sum(t.stationservicefee) stationservicefee")
//			----25443 湖北十堰中心站 结算单打印增加电子票的计数
			.append(" ,sum(case  when t.tickettype = 'B' then 0  else  t.peoples end) fulltickets,  "
			+ " sum(case  when t.tickettype = 'B' then  t.peoples  else  0  end) halftickets , "
			+ " sum(nopaperticketnum) as nopaperticketnum, "
			+ " sum(paperticketnum)  as paperticketnum")
//			----
			.append(" from (select s1.name as fromstation, s2.name as reachstation, count(1) as peoples,")
			.append(" ts.tickettype tickettype, sum(ts.price) totalamount, ts.distance distance,  ts.price price, ")
			.append(" sum(ts.price) - sum(ts.stationservicefee) - sum(ts.Fueladditionfee) - sum(ts.Computefee) -  sum(ts.Coolairfee)")
			.append("  - sum(ts.Additionfee) - sum(ts.Waterfee) - sum(ts.Insurefee) - sum(ts.otherfee) as balanceamount, ")
			.append(" (sum(ts.price) - sum(ts.stationservicefee) -  sum(ts.Fueladditionfee) - sum(ts.Computefee) -  sum(ts.Coolairfee)")
			.append("  - sum(ts.Additionfee) - sum(ts.Waterfee) -  sum(ts.Insurefee) - sum(ts.otherfee)) / count(1) as balanceprice,")
			.append(" (sum(ts.price) - sum(ts.stationservicefee)) / count(1) as noservicestationfee,")
			.append(" sum(ts.price) - sum(ts.stationservicefee) - sum(ts.Coolairfee) - sum(ts.Additionfee) ")
			.append("  - sum(ts.Waterfee) - sum(ts.Insurefee) - sum(ts.otherfee) as noagentbalanceamount,")
			.append("  sum(ts.stationservicefee) as stationservicefee")
//			---25443 湖北十堰中心站 结算单打印增加电子票的计数
			.append(",sum(decode(ts.sellway,13,0, case when nvl(tso.id,0)>0 and tso.istaked = 0 then  1 else 0 end )) nopaperticketnum, " 
			+ " sum(decode(ts.sellway,13,0,  case when nvl(tso.id,0)>0 and tso.istaked = 0 then 0 else 1 end )) paperticketnum") 
//			---
			.append(" from ticketsell ts left join ticketsellother tso on ts.id =tso.ticketsellid, Station s1, Station s2")
			.append("  where ts.departinvoicesid = :departinvoicesid  and ts.departstationid = s1.id")
			.append("  and ts.reachstationid = s2.id  group by s1.name,  s2.name,")
			.append(" ts.price,  ts.stationservicefee,  ts.tickettype,  ts.distance) t ")
			.append("  group by t.reachstation, t.price, t.stationservicefee")
			.append(" order by t.reachstation desc ");	
			Query query = em.createNativeQuery(sqltypesix.toString());
			query.setParameter("departinvoicesid", departinvoicesid);
			//System.out.println("发班打印结算单jcdsqrydetail数据集 sql--> "+sql.toString() + "  参数：departinvoicedid"+departinvoicesid);
			return query.getResultList();
//			groupbySql = " group by tmp.reachstation, tmp.price, tmp.stationservicefee ";
		}
		else{//此时设置弹性参数值>=3
			groupbySql = " group by tmp.reachstation, tmp.distance, tmp.price, tmp.tickettype ";
		}

		StringBuilder sql = new StringBuilder();
		if ( ParamterConst.DEPARTINVOICE_FLAG.FALG_ZERO.equals(isPrintTicketType) || ParamterConst.DEPARTINVOICE_FLAG.FALG_ONE.equals(isPrintTicketType) ){
			sql.append(" select fromstation, ");
		}
		else {
			sql.append(" select '' fromstation, ");
		}
		if (ParamterConst.DEPARTINVOICE_FLAG.FALG_FOU.equals(isPrintTicketType)){
			sql.append(" reachstation, "
					+ " sum(fullpeople), "
					+ " sum(fullpeoples), "
					+ " sum(reachstationpeople),"//到达站票价
					+ " sum(halfpeople), "
					+ " sum(totalamount), "
					+ " max(distance), "
					+ " max(price), "
					+ " sum(balanceamount), "
					+ " max(balanceprice), "
//					+ " max(balanceprice), "	//呼市专用，结算单显示为  全票价  全票数  半票数
					+ " max(noservicestationfee),"
					+ " sum(noagentbalanceamount), "
					+ " sum(discountpeople), "
					+ " sum(stationservicefee) " //结算单打印模板增加一个"站务费明细"打印数据集（20180112，禅道号：16298，青海刚察汽车站
//					----25443 湖北十堰中心站 结算单打印增加电子票的计数
					+ " ,sum(fulltickets), "
					+ " sum(halftickets), "
					+ " sum(nopaperticketnum), "
					+ " sum(paperticketnum) "
//					----
					+ " from ( "
					+" select s1.name as fromstation,"
							+ " s2.name as reachstation,"
							+ " sum(case when ds.tickettype = 'B' then 0 else ds.ticketnum end) fullpeoples,"
							+ " sum(ds.ticketnum) reachstationpeople,"
							+ " sum(case when ds.tickettype = 'B' or ds.tickettype = 'Z' then"
							+ " 0 else  ds.ticketnum"
							+ " end) fullpeople, sum(case when ds.tickettype = 'B' then"
							+ " ds.ticketnum else 0  end) halfpeople, "
							+ " sum(ds.totalamount) as totalamount, ds.distance,"
							+ " max(case when ds.tickettype = 'T' then ds.totalamount / ds.ticketnum else ds.price end) price,"
							+ " sum(ds.balanceamount) balanceamount,"
							+ " max(ds.balanceamount / ds.ticketnum) balanceprice, "
							+ " max(ds.price-ds.stationservicefee/ds.ticketnum) noservicestationfee,"//新增只扣除站务费的结算单价，按照到达站分组
							+ " sum(ds.balanceamount +ds.agentfee) noagentbalanceamount, "
							+ " sum(case  when ds.tickettype = 'Z' then  ds.ticketnum else 0 end) discountpeople," 
							+ " ds.tickettype tickettype, "
							+ " sum(ds.stationservicefee) stationservicefee " //结算单打印模板增加一个"站务费明细"打印数据集（20180112，禅道号：16298，青海刚察汽车站
//							---25443 湖北十堰中心站 结算单打印增加电子票的计数
							+ " ,sum(case when ds.tickettype = 'B' then 0 else  ds.ticketnum end) fulltickets, "
							+ " sum(case when ds.tickettype = 'B' then ds.ticketnum else 0  end) halftickets, "
							+ " sum(ds.nopaperticketnum) nopaperticketnum, " 
							+ " sum(ds.paperticketnum) paperticketnum " 
//							---
							+ " from Departinvoicesdetail ds, Station s1, Station s2"
							+ " where ds.departinvoicesid =:departinvoicesid"
							+ " and ds.issupply = 0 and ds.fromstationid = s1.id"
							+ " and ds.reachstationid = s2.id "
							+ " group by s1.name, s2.name, ds.distance, ds.price, ds.ticketnum, ds.tickettype )tmp "
						    +" group by tmp.reachstation order by max(tmp.distance) desc");
		}else if(ParamterConst.DEPARTINVOICE_FLAG.FALG_FIVE.equals(isPrintTicketType)){
			sql.append(" reachstation, "
					+ " sum(fullpeople), "
					+ " sum(fullpeoples), "
					+ " sum(reachstationpeople),"//到达站票价
					+ " sum(halfpeople), "
					+ " sum(totalamount), "
					+ " max(distance), "
					+ " max(price), "
					+ " sum(balanceamount), "
					+ " max(balanceprice), "
//					+ " max(balanceprice), "	//呼市专用，结算单显示为  全票价  全票数  半票数
					+ " max(noservicestationfee),"
					+ " sum(noagentbalanceamount), "
					+ " sum(discountpeople), "
					+ " sum(stationservicefee) " //结算单打印模板增加一个"站务费明细"打印数据集（20180112，禅道号：16298，青海刚察汽车站
//					----25443 湖北十堰中心站 结算单打印增加电子票的计数
					+ " ,sum(fulltickets), "
					+ " sum(halftickets), "
					+ " sum(nopaperticketnum), "
					+ " sum(paperticketnum) "
//					----
					+ " from ( "
					+" select s1.name as fromstation,"
							+ " s2.name as reachstation,"
							+ " sum(case when ds.tickettype = 'B' then 0 else ds.ticketnum end) fullpeoples,"
							+ " sum(ds.ticketnum) reachstationpeople,"
							+ " sum(case when ds.tickettype = 'B' or ds.tickettype = 'Z' then"
							+ " 0 else  ds.ticketnum"
							+ " end) fullpeople, sum(case   when ds.tickettype = 'B' then"
							+ " ds.ticketnum else 0  end) halfpeople, "
							+ "  sum(ds.totalamount) as totalamount, ds.distance,"
							+ " max(case when ds.tickettype = 'T' then ds.totalamount / ds.ticketnum else ds.price end) price,"
							+ " sum(ds.balanceamount) balanceamount,"
							+ " max(ds.balanceamount / ds.ticketnum) balanceprice, "
							+ " max(ds.price-ds.stationservicefee/ds.ticketnum) noservicestationfee,"//新增只扣除站务费的结算单价，按照到达站分组
							+ " sum(ds.balanceamount +ds.agentfee) noagentbalanceamount, "
							+ " sum(case  when ds.tickettype = 'Z' then  ds.ticketnum else 0 end) discountpeople," 
							+ " ds.tickettype tickettype, "
							+ " sum(ds.stationservicefee) stationservicefee " //结算单打印模板增加一个“站务费明细”打印数据集（20180112，禅道号：16298，青海刚察汽车站
//							---25443 湖北十堰中心站 结算单打印增加电子票的计数
							+ " ,sum(case when ds.tickettype = 'B' then 0 else  ds.ticketnum end) fulltickets, "
							+ " sum(case when ds.tickettype = 'B' then ds.ticketnum else 0  end) halftickets, "
							+ " sum(ds.nopaperticketnum) nopaperticketnum, " 
							+ " sum(ds.paperticketnum) paperticketnum " 
//							---
							+ " from Departinvoicesdetail ds, Station s1, Station s2"
							+ " where ds.departinvoicesid =:departinvoicesid"
							+ " and ds.issupply = 0 and ds.fromstationid = s1.id"
							+ " and ds.reachstationid = s2.id "
							+ " group by s1.name, s2.name, ds.distance, ds.price, ds.ticketnum, ds.tickettype )tmp "
							+ groupbySql
						    +" order by tmp.reachstation desc");
			
		}else if(ParamterConst.DEPARTINVOICE_FLAG.FALG_SIX.equals(isPrintTicketType)){
			sql.append(" reachstation, "
					+ " sum(fullpeople), "
					+ " sum(fullpeoples), "
					+ " sum(reachstationpeople),"//到达站票价
					+ " sum(halfpeople), "
					+ " sum(totalamount), "
					+ " max(distance), "
					+ " max(price), "
					+ " sum(balanceamount), "
					+ " max(balanceprice), "
//					+ " max(balanceprice), "	//呼市专用，结算单显示为  全票价  全票数  半票数
					+ " max(noservicestationfee),"
					+ " sum(noagentbalanceamount), "
					+ " sum(discountpeople), "
					+ " sum(stationservicefee) " //结算单打印模板增加一个"站务费明细"打印数据集（20180112，禅道号：16298，青海刚察汽车站
//					----25443 湖北十堰中心站 结算单打印增加电子票的计数
					+ " ,sum(fulltickets), "
					+ " sum(halftickets), "
					+ " sum(nopaperticketnum), "
					+ " sum(paperticketnum) "
//					----
					+ " from ( "
					+" select s1.name as fromstation,"
							+ " s2.name as reachstation,"
							+ " sum(case when ds.tickettype = 'B' then 0 else ds.ticketnum end) fullpeoples,"
							+ " sum(ds.ticketnum) reachstationpeople,"
							+ " sum(case when ds.tickettype = 'B' or ds.tickettype = 'Z' then"
							+ " 0 else  ds.ticketnum"
							+ " end) fullpeople, sum(case   when ds.tickettype = 'B' then"
							+ " ds.ticketnum else 0  end) halfpeople, "
							+ "  sum(ds.totalamount) as totalamount, ds.distance,"
							+ " max(case when ds.tickettype = 'T' then ds.totalamount / ds.ticketnum else ds.price end) price,"
							+ " sum(ds.balanceamount) balanceamount,"
							+ " max(ds.balanceamount / ds.ticketnum) balanceprice, "
							+ " max(ds.price-ds.stationservicefee/ds.ticketnum) noservicestationfee,"//新增只扣除站务费的结算单价，按照到达站分组
							+ " sum(ds.balanceamount +ds.agentfee) noagentbalanceamount, "
							+ " sum(case  when ds.tickettype = 'Z' then  ds.ticketnum else 0 end) discountpeople," 
							+ " ds.tickettype tickettype, "
							+ " ds.stationservicefee stationservicefee " //结算单打印模板增加一个"站务费明细"打印数据集（20180112，禅道号：16298，青海刚察汽车站
//							---25443 湖北十堰中心站 结算单打印增加电子票的计数
							+ " ,sum(case when ds.tickettype = 'B' then 0 else  ds.ticketnum end) fulltickets, "
							+ " sum(case when ds.tickettype = 'B' then ds.ticketnum else 0  end) halftickets, "
							+ " sum(ds.nopaperticketnum) nopaperticketnum, " 
							+ " sum(ds.paperticketnum) paperticketnum " 
//							---
							+ " from Departinvoicesdetail ds, Station s1, Station s2"
							+ " where ds.departinvoicesid =:departinvoicesid"
							+ " and ds.issupply = 0 and ds.fromstationid = s1.id"
							+ " and ds.reachstationid = s2.id "
							+ " group by s1.name, s2.name, ds.distance, ds.price, ds.ticketnum, ds.tickettype,ds.stationservicefee )tmp "
							+ groupbySql
						    +" order by tmp.reachstation desc");
		}
		else{ 
			sql.append(" reachstation, "
				+ " sum(fullpeople), "
				+ " sum(fullpeoples), "
				+ " sum(reachstationpeople),"
				+ " sum(halfpeople), "
				+ " sum(totalamount), "
				+ " distance, "
				+ " max(price), "
				+ " sum(balanceamount), "
				+ " max(balanceprice), "
				+ " max(noservicestationfee),"
				+ " sum(noagentbalanceamount), "
				+ " sum(discountpeople), "
				+ " sum(stationservicefee) " //结算单打印模板增加一个"站务费明细"打印数据集（20180112，禅道号：16298，青海刚察汽车站
//				----25443 湖北十堰中心站 结算单打印增加电子票的计数
				+ " ,sum(fulltickets), "
				+ " sum(halftickets), "
				+ " sum(nopaperticketnum), "
				+ " sum(paperticketnum) "
//				----
				+ " from ( "
				+"select s1.name as fromstation,"
						+ " s2.name as reachstation,"
						+ " sum(case when ds.tickettype = 'B' or ds.tickettype = 'Z' then 0 else  ds.ticketnum end) fullpeople, "
						+ " sum(case when ds.tickettype = 'B' then 0 else  ds.ticketnum end) fullpeoples, "
						+ " sum(ds.ticketnum) reachstationpeople,"
						+ " sum(case   when ds.tickettype = 'B' then ds.ticketnum else 0  end) halfpeople, "
						+ " sum(ds.totalamount) as totalamount, ds.distance,"
						+ " max(case when ds.tickettype = 'T' then ds.totalamount / ds.ticketnum else ds.price end) price,"
						+ " sum(ds.balanceamount) balanceamount,"
						+ " max(ds.balanceamount / ds.ticketnum) balanceprice, "
						+ " max(ds.price-ds.stationservicefee/ds.ticketnum) noservicestationfee,"//新增只扣除站务费的结算单价，按照到达站分组
						+ " sum(ds.balanceamount +ds.agentfee) noagentbalanceamount, "
						+ " sum(case  when ds.tickettype = 'Z' then  ds.ticketnum else 0 end) discountpeople," 
						+ " ds.tickettype tickettype, "
						+ " sum(ds.stationservicefee) stationservicefee " //结算单打印模板增加一个“站务费明细”打印数据集（20180112，禅道号：16298，青海刚察汽车站
//						---25443 湖北十堰中心站 结算单打印增加电子票的计数
						+ " ,sum(case when ds.tickettype = 'B' then 0 else  ds.ticketnum end) fulltickets, "
						+ " sum(case when ds.tickettype = 'B' then ds.ticketnum else 0  end) halftickets, "
						+ " sum(ds.nopaperticketnum) nopaperticketnum, " 
						+ " sum(ds.paperticketnum) paperticketnum " 
//						---
						+ " from Departinvoicesdetail ds, Station s1, Station s2"
						+ " where ds.departinvoicesid =:departinvoicesid"
						+ " and ds.issupply = 0 and ds.fromstationid = s1.id"
						+ " and ds.reachstationid = s2.id "
						+ " group by s1.name, s2.name, ds.distance, ds.price, ds.ticketnum, ds.tickettype )tmp "
					+ groupbySql
					+ " order by tmp.distance desc");
		}
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		//System.out.println("发班打印结算单jcdsqrydetail数据集 sql--> "+sql.toString() + "  参数：departinvoicedid"+departinvoicesid);
		return query.getResultList();
	}
	// 查询结算单明细信息
	@SuppressWarnings("unchecked")
	public List<Object> findDepartinvoicesdetailbySchplanid(long scheduleplanid) {

		StringBuilder sql = new StringBuilder(
				"select s1.name as fromstation,"
						+ " s2.name as reachstation,sum(ds.ticketnum) peoples,sum(ds.ticketnum*ds.distance) peopledistance,ds.distance"
						+ " from Departinvoices d,Departinvoicesdetail ds, Station s1, Station s2"
						+ " where d.id=ds.departinvoicesid and d.scheduleplanid=:scheduleplanid and d.status='0'"
						+ " and ds.issupply = 0 and ds.fromstationid = s1.id"
						+ " and ds.reachstationid = s2.id group by s1.name, s2.name,ds.distance order by ds.distance desc");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select t from Departinvoices t");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Departinvoices> queryDepartinvoices(long scheduleplanid,long reportid,String departinvoicesno) {
		StringBuilder sql = new StringBuilder("select t from Departinvoices t")
		.append(" where t.scheduleplanid = :scheduleplanid and t.reportid =:reportid ");
		if(departinvoicesno!=null&&!"".equals(departinvoicesno)){
			sql.append(" and t.departinvoicesno= '"+departinvoicesno+"' " );
		}
		sql.append(" and t.status!='1' order by t.id desc");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportid", reportid);
		return query.getResultList();
	}
	// 查询结算单
	@SuppressWarnings("unchecked")
	public List<Object> findDepartinvoices(long departinvoicesid) {
		StringBuilder sql = new StringBuilder(
				"select d.id,d.departinvoicesno,d.ticketnum,")
				.append(" d.stationservicefee,d.fueladditionfee,d.agentfee,")
				.append(" d.othterfee,d.totalamount,d.balanceamount,")
				.append(" s.route.name as routename,s.route.distance,")
				.append(" u.name as unitname,d1.name as driver1,")
				.append(" d2.name as driver2,d3.name as driver3,")
				.append(" d4.name as driver4,st1.name as steward1,u2.name as balanceunit")
				.append(" from Departinvoices d, Vehicle v, Unit u, Unit u2, Schedule s,")
				.append(" Vehiclereport vr left join vr.driver1 d1")
				.append(" left join vr.driver2 d2 left join vr.driver3 d3")
				.append(" left join vr.driver4 d4 left join vr.steward1 st1")
				.append("  where d.vehicleid = v.id and v.unitid = u.id")
				.append(" and d.scheduleid = s.id and d.id=:departinvoicesid")
				.append(" and v.balanceid=u2.id")
				.append(" and d.reportid=vr.id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		return query.getResultList();
	}

	// 流水班时判断是否还有报到的车辆未发班的车辆
	@SuppressWarnings("unchecked")
	public boolean isexistVehiclereport(Vehiclereport vehiclereport) {
		StringBuilder sql = new StringBuilder("select t from Vehiclereport t")
				.append(" where t.scheduleplanid=:scheduleplanid")
				.append(" and t.isdeparted=0 and t.isactive=1 ")
				.append(" and t.reportorgid=:reportorgid and t.id!=:id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", vehiclereport.getId());
		query.setParameter("scheduleplanid", vehiclereport.getScheduleplanid());
		query.setParameter("reportorgid", vehiclereport.getReportorgid());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 流水班已发班数
	@SuppressWarnings("unchecked")
	public int getVehiclereportCount(Vehiclereport vehiclereport) {
		StringBuilder sql = new StringBuilder("select t from Vehiclereport t")
				.append(" where t.scheduleplanid=:scheduleplanid")
				.append(" and t.isdeparted=1 and t.isactive=1")
				.append(" and t.reportorgid=:reportorgid and t.id!=:id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", vehiclereport.getId());
		query.setParameter("scheduleplanid", vehiclereport.getScheduleplanid());
		query.setParameter("reportorgid", vehiclereport.getReportorgid());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? list.size() : 0;
	}

	// 查询晚点信息
	@SuppressWarnings("unchecked")
	public Vehiclelate getVehiclelate(long reportid) {
		StringBuilder sql = new StringBuilder("select t from Vehiclelate t")
				.append(" where t.reportid=:reportid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("reportid", reportid);
		List<Object> list = query.getResultList();
		return (Vehiclelate) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 查询结算单信息
	@SuppressWarnings("unchecked")
	public List<Departinvoices> qryDepartinvoices(long scheduleplanid,
			long reportid) {
		StringBuilder sql = new StringBuilder("select t from Departinvoices t")
				.append(" where t.reportid=:reportid and t.scheduleplanid=:scheduleplanid")
				.append(" and t.status!='1'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportid", reportid);
		return query.getResultList();
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
	
	@SuppressWarnings("unchecked")
	public List<Handholidayprice>  qryHandholidayprice(Date departdate,long scheduleid,long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select t from Handholidayprice t where t.scheduleid =:scheduleid")
		.append(" and t.vehicletypeid =:vehicletypeid and t.startdate <=:departdate")
		.append(" and t.enddate >= :departdate order by t.holidayid desc");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Handprice>  qryHandprice(long scheduleid,long vehicletypeid,long vehiclebrandmodelid) {
		StringBuilder sql = new StringBuilder(
				"select t from Handprice t where t.scheduleid =:scheduleid")
		.append(" and t.vehicletypeid =:vehicletypeid and t.vehiclebrandmodel.id=:vehiclebrandmodelid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodelid);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Handprice> hps=query.getResultList();
		if(hps==null || hps.size()==0 || hps.get(0)==null){
		   sql = new StringBuilder(
			"select t from Handprice t where t.scheduleid =:scheduleid")
				.append(" and t.vehicletypeid =:vehicletypeid ");
			query = em.createQuery(sql.toString());
			query.setParameter("scheduleid", scheduleid);
			query.setParameter("vehicletypeid", vehicletypeid);
			return query.getResultList();
		}
		return query.getResultList();
	}
	
	/**
	 * 获取检票发班班次的检票员
	 * @return
	 */
	public String getCheckedName(Long scheduleplanid, Long vehiclereportid){
		StringBuffer sql = new StringBuffer("select u.name from Ticketsell t,");
		sql.append(" Userinfo u where t.checkedby=u.id and t.scheduleplanid=:scheduleplanid ");
		sql.append(" and t.vehiclereport.id=:vehiclereportid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		List<Object> list=query.getResultList();
		if (list!=null &&list.size()>0) {
			return list.get(0).toString();
		}else{
			sql = new StringBuffer("select checkby from RemoteTicketsell t");
			sql.append("  where t.scheduleplanid=:scheduleplanid ");
			sql.append(" and vehiclereportid=:vehiclereportid ");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			query.setParameter("vehiclereportid", vehiclereportid);
			list=query.getResultList();
			if (list!=null &&list.size()>0) {
				return list.get(0).toString();
			}else{
				return "";
			}
		}
	}
	
	/**
	 * 查询指定的运量单号是否存在
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean qryDepartinvoices(long orgid,String departinvoicesno){
		StringBuffer sql = new StringBuffer("select t from Departinvoices t");
		sql.append(" where t.departinvoicesno=:departinvoicesno ");
		sql.append(" and t.printorgid=:orgid and t.status!='1'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departinvoicesno", departinvoicesno);
		query.setParameter("orgid", orgid);
		List<Object> list=query.getResultList();
		return list!=null&&list.size()>0?true:false;
	}
	
	/**
	 * 获取运量单 的他站售票情况，用于打印在结算单上。
	 * @param departinvoicesid
	 * @param departdate
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public List<Object> getOthersells(long departinvoicesid,Date departdate){
		StringBuffer sql = new StringBuffer(//--异站售票点
				"select sellorg.name as name,count(ts.id) as num")
		.append(" from Ticketsell ts ,Organization sellorg")
		.append(" where (ts.sellby = 0 or sellorg.type=0 ) and ts.orgid=sellorg.id")
		.append(" and ts.departinvoicesid = :departinvoicesid")
		.append(" and ts.departdate = :departdate")
		.append(" group by sellorg.name")
		.append(" union all")//--站外售票点
		.append(" select tos.name as name,count(ts.id) as num")
		.append(" from Ticketsell ts,Ticketoutlets tos")
		.append(" where  tos.type=1 and ts.sellby <> 0 and ts.ticketoutletsid = tos.id")
		.append(" and ts.departinvoicesid = :departinvoicesid")
		.append(" and ts.departdate = :departdate")
		.append(" group by tos.name");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		query.setParameter("departdate", departdate);
		List<Object> list=query.getResultList();
		return list ;
	}
	//根据车辆报道卡卡号查询报班信息，用于自助刷卡打印结算单
	public List<Object> qryVehcilereport(String cardno,long reportorgid) {
		StringBuilder sql = new StringBuilder("select vr.id, vr.scheduleplanid")
		.append("  from vehiclereport vr, vehicle v")
		.append(" where vr.vehicleid = v.id  and v.isactive = 1 and vr.isactive=1")
		.append(" and vr.reportorgid=:reportorgid   and v.cardno =:cardno")
		.append(" and vr.departdate = trim(sysdate) and vr.isdeparted=0");		
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("cardno", cardno);
		query.setParameter("reportorgid", reportorgid);
		return query.getResultList();
	}	
	//查询要打印的售票票点
	public List<Ticketoutlets> qryTicketoutlets() {
		StringBuilder sql = new StringBuilder("select o from Ticketoutlets o")
				.append(" where o.isactive=1 and isprint=1 order by id");
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	public List<Vehicledriverreport> queryVehicledriverreport(long scheduleplanid) {
		StringBuffer sql=new StringBuffer("select t from Vehicledriverreport t where t.scheduleplanid=:scheduleplanid");
		Query query=em.createQuery(sql.toString(), Vehicledriverreport.class);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}

	//查询初检单信息
	public List<Object> queryFirstCheck(Long scheduleplanid,
			Long departstationid, Long vehiclereportid, boolean islinework,Long firstcheckid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct s.name as reachstation,s.id as reachstationid, count(ts.ticketno) ticketnum ");
		sql.append(" from ticketsell ts left join station s on s.id = ts.reachstationid ");
		if(firstcheckid!=null&&firstcheckid > 0){
			sql.append(" left join ticketsellfirstcheck tsf on ts.id = tsf.ticketsellid ");
		}
		sql.append(" where ts.scheduleplanid = :scheduleplanid and ts.departstationid =:departstationid and  ts.ischecked =1 ");
		if(islinework){
			sql.append(" and ts.vehiclereportid = "+vehiclereportid+" ");
		}
		if(firstcheckid!=null&&firstcheckid > 0){
			sql.append(" and tsf.firstcheckid = "+ firstcheckid);
		}
		sql.append(" group by s.name,s.id ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		return query.getResultList();
	}

/*	//根据车牌获取座位类型
	public List<Object> getVehicleSeatTypeName(String seattype) {
		StringBuffer sql=new StringBuffer("select dd.value from  digitaldictionarydetail dd left join digitaldictionary d  on d.id = dd.digitaldictionaryid");
		sql.append(" where d.tablename = 'vehicle' and d.columnname = 'seattype' and dd.code = "+seattype);
		Query query=em.createNativeQuery(sql.toString());
		return query.getResultList();
	}*/
	
	public Departinvoices findOneDepartinvoices(long vehiclereportid,
			Date departdate, long scheduleplanid, long scheduleid) {
		StringBuilder sql = new StringBuilder(
		"select d from Departinvoices d where d.scheduleid=:scheduleid and d.departdate=:departdate and d.scheduleplanid=:scheduleplanid and d.reportid=:reportid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departdate", departdate);
		query.setParameter("reportid", vehiclereportid);
		query.setParameter("scheduleid", scheduleid);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return null;
		}
		return (Departinvoices)query.getResultList().get(0);
	}
	
	public List<Object> qrysecuresult(Vehiclereport vehiclereport) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select sc.result from Securitycheck sc ,Vehicle v where v.id=sc.vehicleid  and v.id =:vehicleid   and trunc(sc.checktime) = :departdate  order by  sc.checktime desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehiclereport.getVehicleid());
		query.setParameter("departdate", vehiclereport.getDepartdate());
		List list = query.getResultList();
		return list;
	}
	
	//获取行包信息  呼市迁移到5041 打印结算单获取行包信息
		public List<Pack> qyrPack(long scheduleid,Date departdate,long vehicleid) {
			StringBuilder sql = new StringBuilder("select p from Pack p")
					.append(" where p.packtype='0' and p.scheduleid=:scheduleid")
					.append(" and p.departdate=:departdate and  p.vehicleid=:vehicleid and p.status=1");
			Query query = em.createQuery(sql.toString());
			query.setParameter("scheduleid", scheduleid);
			query.setParameter("departdate", departdate);
			query.setParameter("vehicleid", vehicleid);	
			return query.getResultList();
		}

		public List<Object> qryBalancedetailPrint(long balanceid) {
			StringBuffer sql = new StringBuffer();   	
//	    	sql.append(" select bd.id,bd.balanceid,bd.fromstationid,bd.reachstationid,bd.ticketnum,bd.totalamount,bd.stationservicefee,bd.agentfee, ")
//			.append(" bd.balanceamount,bd.createtime,bd.createby,bd.updatetime,bd.updateby,fs.name fromstationname,rs.name as reachstationname ")
			sql.append(" select bd.reachstationid,sum(bd.ticketnum),sum(bd.totalamount),sum(bd.stationservicefee),sum(bd.agentfee),sum(bd.balanceamount),fs.name fromstationname,rs.name as reachstationname ")
			.append(" from balancedetail bd left join station fs on bd.fromstationid=fs.id left join station rs on bd.reachstationid=rs.id where 1=1")
			.append(" and bd.balanceid = ("+balanceid+")");
			
			sql.append(" group by bd.reachstationid,rs.name,fs.name");
					
			Query query = em.createNativeQuery(sql.toString());
			
			List<Object> list = query.getResultList();
			
			return list;
		}
		
		public List<Object> qryBalancedetail(long balanceid) {
			StringBuffer sql = new StringBuffer();   	
			sql.append(" select reachstationid,sum(ticketnum),sum(totalamount),sum(stationservicefee),sum(agentfee),sum(balanceamount),fromstationname,reachstationname ")
			.append(" from (select dd.reachstationid,dd.ticketnum,dd.totalamount,dd.stationservicefee,dd.agentfee,dd.balanceamount,fs.name fromstationname,rs.name as reachstationname")
			.append(" from departinvoicesdetail dd left join station fs on dd.fromstationid=fs.id left join station rs on dd.reachstationid=rs.id where 1=1")
			.append(" and dd.departinvoicesid in (select id from departinvoices where balanceid="+balanceid+") ")
			.append(" union all ")
			.append(" select dd.reachstationid,dd.ticketnum,dd.totalamount,dd.stationservicefee,dd.agentfee,dd.balanceamount,fs.name fromstationname,rs.name as reachstationname")
			.append(" from departinvoicesotherdetail dd left join station fs on dd.fromstationid=fs.id left join station rs on dd.reachstationid=rs.id where 1=1")
			.append(" and dd.departinvoicesotherid in (select id from departinvoicesother where balanceid="+balanceid+"))");
			sql.append(" group by reachstationid,fromstationname,reachstationname");
					
			Query query = em.createNativeQuery(sql.toString());
			List<Object> list = query.getResultList();
			return list;
		}
		//查询结算单按站点和票价进行分组的汇总明细  20151114 liyi  isByprice:0表示只按照站点进行分组，1表示按照站点也要按照站点票价进行分组
		public List<Object> qryBalanceStationdetailPrint(long balanceid,String isByprice)
		{
			StringBuffer sql = new StringBuffer();   	
			sql.append("SELECT s.name,sum(dd.ticketnum),sum(dd.totalamount),trunc(b.balancetime),");//dd.price,
			sql.append(" sum(dd.balanceamount),sum(dd.stationservicefee),sum(dd.agentfee), ");
			sql.append(" sum(dd.fueladditionfee),sum(dd.othterfee),sum(dd.price)");
			sql.append("  FROM departinvoices d, departinvoicesdetail dd, balance b,station s  ");
			sql.append("  where d.balanceid = b.id");
			sql.append("  and dd.departinvoicesid = d.id");
			sql.append(" and dd.reachstationid=s.id");
			sql.append(" and b.id="+balanceid);
			sql.append(" group by dd.reachstationid,s.name,trunc(b.balancetime)");
			if("1".endsWith(isByprice))
			{
				sql.append(",dd.price");
			}
			Query query = em.createNativeQuery(sql.toString());
			List<Object> list = query.getResultList();
			return list;
			
			
		}
		
		//查询结算单按站点和票价进行分组的汇总明细时的结算单号和结算单张数（20160323通城需求：增加结算单张数、结算单号）
		public List<Object> qryDepartinvoicesnos(long balanceid){
			StringBuffer sql = new StringBuffer(); 
			sql.append(" select  wm_concat(t.dptinvoicesnos) as dptinvoicesnos, sum(t.dptinvoicesnums) as dptinvoicesnums from ( ");
			sql.append("select wm_concat(distinct d.departinvoicesno) as dptinvoicesnos, ");
			sql.append(" count(distinct d.departinvoicesno) as dptinvoicesnums ");
			sql.append("from departinvoices d, departinvoicesdetail dd, balance b,station s  ");
			sql.append("where d.balanceid = b.id");
			sql.append(" and dd.departinvoicesid = d.id");
			sql.append(" and dd.reachstationid = s.id");
			sql.append(" and b.id = :balanceid ")
//			.append(" order by d.departinvoicesno ");
			.append(" union all")
			.append(" select wm_concat(distinct dvo.departinvoicesno) as dptinvoicesnos, ")
			.append("  count(distinct dvo.departinvoicesno) as dptinvoicesnums")
			.append(" from departinvoicesother dvo, departinvoicesotherdetail dvod, balance bb, station ss ")
			.append(" where dvo.balanceid = bb.id and dvod.departinvoicesotherid = dvo.id ")
			.append("  and dvod.reachstationid = ss.id and bb.id = :balanceid ")
			.append(" ) t ");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("balanceid", balanceid);
			return query.getResultList();
		}
		
		//查询AcReport打印结算单时的车票明细和结算单明细
	public List<Object> queryTicketDetail(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("select ts.seatno || '' as orderno, ")
				.append("  ts.ticketno as ticketno, ")
				.append("  s.name as reachstationname, ")
				.append("  trim(to_char(ts.price, 'FM99999999.00') || '元') as price, ")
				.append("  u.name as seller ")
				.append(" from departinvoices t, ticketsell ts, station s, userinfo u ")
				.append(" where t.id = ts.departinvoicesid ")
				.append("  and ts.departdate = ts.departdate ")
				.append("  and ts.reachstationid = s.id ")
				.append("  and ts.sellby = u.id ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" union all  ");
		sql.append(" select '' as orderno,'' as ticketno, '' as reachstationname, '' as price, '' as seller from dual ");
		sql.append(" union all  ");
		sql.append(
				" select '' as orderno, trim('小  计') as ticketno, s.name as reachstationname,  ")
				.append(" trim(to_char(nvl(dd.totalamount, 0), 'FM99999999.00') || '元') as price, trim(nvl(dd.ticketnum, 0) || '人') as seller ")
				.append("from departinvoices t, departinvoicesdetail dd, station s ")
				.append("where t.id = dd.departinvoicesid ")
				.append(" and dd.reachstationid = s.id ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));

		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	// 打印结算单:只查询检到该结算单上的车票，包括：【座号】、【票号】、【到达站】、【票价】、【售票员】
	public List<Object> qryDptTicketdetail(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("select ts.seatno as orderno, ")
				.append("  ts.ticketno as ticketno, ")
				.append("  s.name as reachstationname, ")
				.append("  ts.price as price, ")
				.append("  u.name as seller ")
				.append(" from departinvoices t, ticketsell ts, station s, userinfo u ")
				.append(" where t.id = ts.departinvoicesid ")
				.append("  and ts.departdate = ts.departdate ")
				.append("  and ts.reachstationid = s.id ")
				.append("  and ts.sellby = u.id ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ts.seatno ");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	//查询该班次结算单对应的车辆的座位数
	public int qryScheduleSeatnums(long departinvoicesid){
		StringBuffer sql = new StringBuffer();
		sql.append("select v.seatnum as seatnums ")
			.append(" from departinvoices t, vehicle v ")
			.append(" where t.vehicleid = v.id  ")
			.append(" and t.id = :departinvoicesid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		
		return ((BigDecimal) query.getSingleResult()).intValue();
	}
	
	//根据结算单id查询该车牌颜色
	public String qryVehicleColor(Long vehiclereportid){
		StringBuffer sql = new StringBuffer();
		sql.append("select trim(dd.value) as color ")
//				.append(" , t.id as vehiclereportid, departdate as departdate ")
//				.append(" v.id as vehicleid, v.vehicleno as v.vehicleno ")
				.append(" from vehiclereport t, vehicle v, digitaldictionarydetail dd, digitaldictionary d  ")
				.append(" where t.vehicleid = v.id ")
				.append(" and v.color = dd.code and dd.digitaldictionaryid=d.id ")
				.append(" and d.tablename = 'vehicle' and d.columnname = 'color' ")
				.append(" and t.id = :vehiclereportid ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehiclereportid", vehiclereportid);
		
		return ((String) query.getSingleResult());
	}
	
	//查询该结算单对应的补票人数
	public int qryBupiaoNum(Long scheduleplanid){
		StringBuffer sql = new StringBuffer();
		sql.append("select count(t.id) as bupiaonum ")
				.append(" from ticketsell t, scheduleplan sp ")
				.append(" where t.scheduleplanid = sp.id ")
				.append("  and t.departdate = sp.departdate ")
				.append("  and t.sellway in ('1', '2') ") //--1补票 2特权补票
				.append("  and sp.id = :scheduleplanid ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		
		return ((BigDecimal) query.getSingleResult()).intValue();
	}

	public long getOtherticketnum(long id) {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(t.id) from ticketsell t where  t.departinvoicesid = :id and t.tickettype <> 'B' ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id",id);
//		((BigDecimal) query.getSingleResult()).intValue();
		return query.getResultList()!=null&&!"".equals(query.getResultList())?((BigDecimal) query.getSingleResult()).intValue():0;
	}
	/**
	 * 自助发班检查同一天同一车前前一个报到班次是否发班
	 * @param vehicleid
	 * @param departdate
	 * @param reporttime
	 * @return
	 */
	public boolean checkPreDepart(long vehicleid, Date departdate,
			String reporttime) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from    vehiclereport vr where vr.vehicleid=:vehicleid ")
		.append(" and vr.reporttime<to_date(:reporttime,'yyyy/MM/dd hh24:mi:ss') and vr.departdate=:departdate  ")
		.append(" and vr.isdeparted=0 and vr.isactive = 1 and exists(select * from ticketsell ts where ts.scheduleplanid=vr.scheduleplanid ")
		.append(" and ts.departdate=:departdate and ts.ischecked=1) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid",vehicleid);
		query.setParameter("departdate",departdate);
		query.setParameter("reporttime",reporttime);
		int flag = ((BigDecimal)query.getSingleResult()).intValue();
		return flag>0?false:true;
	}
	
	//查询初检单信息
		public List<Object> queryOpenFirstCheck(Long scheduleplanid,
				Long departstationid, Long vehiclereportid, boolean islinework) {
			StringBuffer sql = new StringBuffer();
			sql.append(" select  s.name as reachstation,");
			sql.append(" s.id as reachstationid,");
			sql.append(" count(ts.ticketno) ticketnum ");
			sql.append(" from ticketsell ts ");
			sql.append(" left join station s on s.id = ts.reachstationid ");
			sql.append(" where ts.scheduleplanid = :scheduleplanid and ts.departstationid = :departstationid ");
			sql.append(" and ts.ischecked = 1 ");
			if(islinework){
				sql.append(" and ts.vehiclereportid = "+vehiclereportid+" ");
			}
			sql.append(" and not exists (select tst.id ");
			sql.append(" from ticketsell tst ,ticketsellfirstcheck tsf ")
			.append("  where tst.id = tsf.ticketsellid and tst.id = ts.id and tsf.isactive=1 ");
			/*sql.append(" left join firstcheck f on tsf.firstcheckid = f.id ");
			sql.append(" left join station s on s.id = ts.reachstationid ");
			sql.append(" where  ts.scheduleplanid = :scheduleplanid and ts.departstationid = :departstationid ");
			sql.append(" and ts.ischecked = 1 and f.status = 0 ");*/
			if(islinework){
				sql.append(" and tst.vehiclereportid = "+vehiclereportid+" ");
			}
			sql.append(") group by s.name,s.id ");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			query.setParameter("departstationid", departstationid);
			return query.getResultList();
		}

		public Schedulestatus getSchedulestatus(long scheduleplanid, long departstationid,long id) {
			StringBuilder sql = new StringBuilder("select ss from Schedulestatus ss,Schedulestop st  ")
					.append(" where ss.scheduleid = st.schedule.id and ss.departstationid <> :departstationid and st.isdepart = 1 and ss.scheduleplan.id = :scheduleplanid ");
			Query query = em.createQuery(sql.toString());
			query.setLockMode(LockModeType.PESSIMISTIC_READ);
			query.setParameter("scheduleplanid", scheduleplanid);
			query.setParameter("departstationid", departstationid);
			List<Schedulestatus> list = query.getResultList();
			return list != null && list.size() > 0 ? list.get(0) : null;
		}

		public Schedulestop getTwoStationDepTime(long scheduleplanid, long departstationid) {
			StringBuilder sql = new StringBuilder("select st from Schedulestatus ss,Schedulestop st  ")
					.append(" where ss.scheduleid = st.schedule.id and ss.departstationid <> :departstationid and st.stationid <> :departstationid and st.isdepart = 1 and ss.scheduleplan.id = :scheduleplanid ");
			Query query = em.createQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			query.setParameter("departstationid", departstationid);
			List<Schedulestop> list = query.getResultList();
			return list != null && list.size() > 0 ? list.get(0) : null;
		}
		
		public List<Object> qryDepartInvoicesOtherDetailPrintInfo(Long departinvoicesotherid) {
			ParameterService parameterService = new ParameterServiceImpl();
			Global global = CurrentUtil.getGlobal();
			//打印结算单时 0:相同（始站）相同止站相同距离相同票价分组打印;1:相同（始站）相同止站相同距离相同票价相同(票种)分组打印
			//2:相同止站相同距离相同票价分组打印;3:相同止站相同距离相同票价相同(票种)分组打印
			//4:相同到站分组打印
			String isPrintTicketType = parameterService.findParamValue(ParamterConst.Param_4015, global.getOrganization().getId());
			String groupbySql = "";
			if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_ZERO.equals(isPrintTicketType) ){//0
				groupbySql = " group by tmp.fromstation, tmp.reachstation, tmp.distance, tmp.price ";
			}
			else if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_ONE.equals(isPrintTicketType) ) {//1
				groupbySql = " group by tmp.fromstation, tmp.reachstation, tmp.distance, tmp.price, tmp.tickettype ";
			}
			else if( isPrintTicketType!=null && ParamterConst.DEPARTINVOICE_FLAG.FALG_TWO.equals(isPrintTicketType) ){//2
				groupbySql = " group by tmp.reachstation, tmp.distance, tmp.price ";
			}
			else{//此时设置弹性参数值>=3
				groupbySql = " group by tmp.reachstation, tmp.distance, tmp.price, tmp.tickettype ";
			}
			StringBuilder sql = new StringBuilder();
			if ( ParamterConst.DEPARTINVOICE_FLAG.FALG_ZERO.equals(isPrintTicketType) || ParamterConst.DEPARTINVOICE_FLAG.FALG_ONE.equals(isPrintTicketType) ){
				sql.append(" select fromstation, ");
			}
			else {
				sql.append(" select '' fromstation, ");
			}
			if ( ParamterConst.DEPARTINVOICE_FLAG.FALG_FOU.equals(isPrintTicketType)){
				sql.append(" reachstation,sum(fullpeople),sum(reachstationpeople),sum(halfpeople), ")
				   .append(" sum(totalamount),max(distance),max(price),sum(balanceamount),max(balanceprice),max(noservicestationfee), ")
				   .append(" sum(noagentbalanceamount),sum(discountpeople) from ( " )
					.append(" select s1.name as fromstation, ")
					.append(" s2.name as reachstation, ")
					.append(" sum(ds.ticketnum) reachstationpeople, ")
					.append(" sum(case when tp.tickettype = 'B' or tp.tickettype = 'Z' then 0 else ds.ticketnum  end) fullpeople, ")
					.append(" sum(case when tp.tickettype = 'B' then ")
					.append(" ds.ticketnum else 0  end) halfpeople, ")
					.append(" sum(ds.totalamount) as totalamount, ds.distance, ")
					.append(" max(case when tp.tickettype = 'T' then ds.totalamount / ds.ticketnum else ds.price end) price, ")
					.append(" sum(ds.balanceamount) balanceamount, ")
					.append(" max(ds.balanceamount / ds.ticketnum) balanceprice, ")
					.append(" max(ds.price-ds.stationservicefee/ds.ticketnum) noservicestationfee, ")
					.append(" sum(ds.balanceamount +ds.agentfee) noagentbalanceamount, ")
					.append(" sum(case when tp.tickettype = 'Z' then ds.ticketnum else 0 end) discountpeople, ")
					.append(" tp.tickettype tickettype  ")
					.append(" from Departinvoicesotherdetail ds,tickettype tp, Station s1, Station s2 ")
					.append(" where ds.departinvoicesotherid =:departinvoicesotherid ")
					.append(" and ds.issupply = 0 and ds.fromstationid = s1.id ")
					.append(" and ds.status  = 0 and  ds.tickettypeid = tp.id ")
					.append(" and ds.reachstationid = s2.id  ")
					.append(" group by s1.name, s2.name, ds.distance, ds.price, ds.ticketnum, ds.tickettype )tmp ")
					.append(" group by tmp.reachstation order by max(tmp.distance) desc ");
			}else{ 
				sql.append(" reachstation,sum(fullpeople),sum(reachstationpeople),sum(halfpeople), ")
				   .append(" sum(totalamount),distance,max(price),sum(balanceamount),max(balanceprice),max(noservicestationfee),")
				   .append(" sum(noagentbalanceamount),sum(discountpeople) from ( ")
				   .append(" select s1.name as fromstation, ")
		           .append(" s2.name as reachstation, ")
		           .append(" sum(case when tp.code = 'B' or tp.code = 'Z' then 0 else ds.ticketnum end) fullpeople, ")
		           .append(" sum(ds.ticketnum) reachstationpeople, ")
		           .append(" sum(case when tp.code = 'B' then ds.ticketnum else 0 end) halfpeople, ")
		           .append(" sum(ds.totalamount) as totalamount, ")
		           .append(" ds.distance, ")
		           .append(" max(case when tp.code = 'T' then ds.totalamount / ds.ticketnum else ds.price end) price, ")
		           .append(" sum(ds.balanceamount) balanceamount, ")
		           .append(" max(ds.balanceamount / ds.ticketnum) balanceprice, ")
		           .append(" max(ds.price - ds.stationservicefee / ds.ticketnum) noservicestationfee, ")
		           .append(" sum(ds.balanceamount + ds.agentfee) noagentbalanceamount, ")
		           .append(" sum(case when tp.code = 'Z' then ds.ticketnum else 0 end) discountpeople, ")
		           .append(" tp.code tickettype ")
		           .append(" from Departinvoicesotherdetail ds,tickettype tp, Station s1, Station s2 ")
		           .append(" where ds.departinvoicesotherid = :departinvoicesotherid ")
		           .append(" and ds.status = 0 and ds.fromstationid = s1.id ")
		           .append(" and ds.reachstationid = s2.id and ds.tickettypeid = tp.id ")
		           .append(" group by s1.name,s2.name,ds.distance,ds.price,ds.ticketnum,tp.code) tmp ")
		           .append( groupbySql + "order by tmp.distance desc");
			}
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("departinvoicesotherid", departinvoicesotherid);
			return query.getResultList();
		}

		public BigDecimal queryLostfee(long scheduleplanid) {
			StringBuffer sql = new StringBuffer();
			sql.append("select nvl(sum(t.forfeit),0) from vehiclelost t where t.scheduleplanid = :scheduleplanid");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			return (BigDecimal) query.getResultList().get(0);
		}


		/**
		 * 取状态为“未结算”，ishandle 为“未处理”和违规日期小于等于当前日期的违规 信息
		 * @param vehicleid
		 * @return
		 */
		public List<Vehicleviolation> queryVehicleviolation(long vehicleid) {
			StringBuffer sql = new StringBuffer();
			sql.append(" select v from Vehicleviolation v where v.ishandle=0 and v.violationdate<=trunc(sysdate) ")
			.append(" and v.status='0' and vehicleid = :vehicleid ");
			Query query = em.createQuery(sql.toString());
			query.setParameter("vehicleid",vehicleid );
			query.setLockMode(LockModeType.PESSIMISTIC_READ);
			return query.getResultList();
		}

		public List<String> qryDriverName(String vehicleids) {
			StringBuilder sql = new StringBuilder();
			sql.append(" select d.name from driver d where d.vehicleid in (" + vehicleids + ") ");
			Query query = em.createNativeQuery(sql.toString());
			return  query.getResultList();
		}
}
