package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import util.CommonUtil;

@SuppressWarnings("rawtypes")
public class TicketturnoverdetailDao extends EntityManagerDaoSurport {

	public Ticketturnoverdetail getTicketturnoverdetail(Long seller,
			long startno) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketturnoverdetail t where t.seller=");
		sql.append(seller);
		sql.append(" and t.ticketstartno=");
		sql.append(startno);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (Ticketturnoverdetail) query.getSingleResult();
	}

	public long getMaxid() {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketturnoverdetail t");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public Ticketturnoverdetail getList(Long seller, long startno) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketturnoverdetail t where t.seller=");
		sql.append(seller);
		sql.append(" and t.ticketstartno=");
		sql.append(startno);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (!list.isEmpty()) {
			Ticketturnoverdetail detail = getTicketturnoverdetail(seller,
					startno);
			if (detail != null) {
				return detail;
			}
		}
		return null;
	}

	/**
	 * 查询车票票款缴款明细
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("select t.*, use.name as updatename, us.name as sellername, ")
		.append(" u.name as createname, 1 as ischoose, us.code as code,(t.sellmoney-t.stationservicefee ) as nostationfeemoney,tto.lost  lastlost, tto1.money ")
		.append(" from Ticketturnoverdetail t left outer join Ticketturnover tto on tto.seller = t.seller  left  join Ticketturnover tto1 on tto1.id = t.ticketturnoverid, Userinfo us , Userinfo u , Userinfo use" )
		.append(" where  t.seller=us.id and t.createby=u.id and  t.updateby=use.id and tto.turnovertime = (SELECT max(turnovertime) FROM Ticketturnover) ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" order by t.createtime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 查询车票票款对应的退票数
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryReturnTicketno(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select tr.ticketprice, (case tr.isselfschedule ");
		sql.append(
				" when 1 then (select ts.ticketno from ticketsell ts where ts.id=tr.sellid)")
				.append(" when 0 then (select ts.ticketno from ticketsellagent ts where ts.id=tr.sellid) ")
				.append(" end) as returnticketno ")
				.append(" from ticketturnoverdetail t, ticketreturn tr where t.id=tr.turnoverdetailid ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 查询车票票款对应的废票数
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryCancelTicketno(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select tc.ticketprice, (case tc.isselfschedule ");
		sql.append(
				" when 1 then (select ts.ticketno from ticketsell ts where ts.id=tc.sellid) ")
				.append(" when 0 then (select ts.ticketno from ticketsellagent ts where ts.id=tc.sellid)")
				.append(" end) as cancelticketno ")
				.append(" from ticketturnoverdetail t, ticketcancel tc where t.id=tc.turnoverdetailid ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 查询车票票款对应的坏票登记数
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBillTicketno(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("select b.startno,b.endno ,b.damageddscribe")
				.append(" from ticketturnoverdetail t, billdamaged b, billtype bi ")
				.append(" where b.billtypeid=bi.id and bi.code='Ticket' and t.id=b.turnoverdetailid");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> getIds(Long ticketturnoverid) {
		StringBuffer sql = new StringBuffer(
				"select t.id from Ticketturnoverdetail t where t.ticketturnover.id=");
		sql.append(ticketturnoverid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public String getTicketturnoverdetailId(Long ticketturnoverid) {
		List<Object> list = getIds(ticketturnoverid);
		if (list.size() == 0) {
			return null;
		}
		StringBuffer ids = new StringBuffer(""); 
		for (int i = 0; i < list.size(); i++) {
			ids.append(list.get(i).toString());
			ids.append(",");
		}
		return ids.toString();
	}
	
	public String queryTicketReturnno(Long ticketturnoverid) {
		String ticketreturnno = "";
		String ids = getTicketturnoverdetailId(ticketturnoverid);
		if (ids != null) {
			String[] detailid = ids.split(",");
			for (int i = 0; i < detailid.length; i++) {
				StringBuffer sql = new StringBuffer(
						"select (case tr.isselfschedule ");
				sql.append(" when 1 then (select ts.ticketno from ticketsell ts where ts.id=tr.sellid)");
				sql.append(" when 0 then (select ts.ticketno from ticketsellagent ts where ts.id=tr.sellid) ");
				sql.append(" end) as returnticketno ");
				sql.append(" from ticketturnoverdetail t, ticketreturn tr where t.id=tr.turnoverdetailid and ");
				sql.append(" tr.turnoverdetailid=");
				sql.append(Long.parseLong(detailid[i]));
				Query query = em.createNativeQuery(sql.toString());
				for (int j = 0; j < query.getResultList().size(); j++) {
					ticketreturnno = ticketreturnno
							+ query.getResultList().get(j) + ",";
				}
			}
			if (!"".equals(ticketreturnno)) {
				ticketreturnno = ticketreturnno.substring(0,
						ticketreturnno.length() - 1);
			}
		}
		return ticketreturnno;
	}

	public String queryTicketCancelno(Long ticketturnoverid) {
		String ticketcancelno = "";
		String ids = getTicketturnoverdetailId(ticketturnoverid);
		if (ids != null) {
			String[] detailid = ids.split(",");
			for (int i = 0; i < detailid.length; i++) {
				StringBuffer sql = new StringBuffer(
						"select (case tc.isselfschedule ");
				sql.append(" when 1 then (select ts.ticketno from ticketsell ts where ts.id=tc.sellid) ");
				sql.append(" when 0 then (select ts.ticketno from ticketsellagent ts where ts.id=tc.sellid) ");
				sql.append(" end) as cancelticketno ");
				sql.append(" from ticketturnoverdetail t, ticketcancel tc where t.id=tc.turnoverdetailid and ");
				sql.append(" tc.turnoverdetailid=");
				sql.append(Long.parseLong(detailid[i]));
				Query query = em.createNativeQuery(sql.toString());
				for (int j = 0; j < query.getResultList().size(); j++) {
					ticketcancelno = ticketcancelno
							+ query.getResultList().get(j) + ",";
				}
			}
			if (!"".equals(ticketcancelno)) {
				ticketcancelno = ticketcancelno.substring(0,
						ticketcancelno.length() - 1);
			}
		}
		return ticketcancelno;
	}

	public String queryTicketBillno(Long ticketturnoverid) {
		String ticketbillno = "";
		String ids = getTicketturnoverdetailId(ticketturnoverid);
		if (ids != null) {
			String[] detailid = ids.split(",");
			for (int i = 0; i < detailid.length; i++) {
				StringBuffer sql = new StringBuffer(
						"select b.startno || '-' || b.endno as damagedticketno ");
				sql.append(" from ticketturnoverdetail t, billdamaged b, billtype bi ");
				sql.append(" where b.billtypeid=bi.id and bi.code='Ticket' and t.id=b.turnoverdetailid and ");
				sql.append(" b.turnoverdetailid=");
				sql.append(Long.parseLong(detailid[i]));
				Query query = em.createNativeQuery(sql.toString());
				for (int j = 0; j < query.getResultList().size(); j++) {
					ticketbillno = ticketbillno + query.getResultList().get(j)
							+ ",";
				}
			}
			if (!"".equals(ticketbillno)) {
				ticketbillno = ticketbillno.substring(0,
						ticketbillno.length() - 1);
			}
		}
		return ticketbillno;
	}

	public Ticketturnoverdetail getByTicketendno(String endno) {
		StringBuffer sql = new StringBuffer("select t from Ticketturnoverdetail t ");
		sql.append(" where t.ticketendno=:endno ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("endno", endno);
		if (query.getResultList().size() <= 0) {
			return null;
		}
		return (Ticketturnoverdetail) query.getSingleResult();
	}
	
	/**
	 * 统计某日,月票款明细信息，用来打营收表 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketRevenue(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select sum(t.sellnum) as sellnum,sum(t.sellmoney) as sellmoney," +
				"sum(t.returnnum) as returnnum,sum(t.returnmoney) as returnmoney, " +
				"sum(t.cancelnum) as cancelnum,sum(t.cancelmoney) as cancelmoney," +
				"sum(t.eticketnum) as eticketnum,sum(t.billdamagednum) as billdamagednum," +
				"sum(t.returnhandcharge) as returnhandcharge, sum(t.servicefee) as servicefee," +
				"sum(t.bookservicefee) as bookservicefee,sum(t.changeservicefee) as changeservicefee," +
				"sum(t.moneypayable) as moneypayable," +
				"sum(t.stationservicefee) as stationservicefee," +
				"sum(t.fueladditionfee) as fueladditionfee," +
				"sum(t.computefee) as computefee," +
				"sum(t.coolairfee) as coolairfee," +
				"sum(t.additionfee) as additionfee," +
				"sum(t.waterfee) as waterfee," +
				"sum(t.insurefee) as insurefee," +
				"sum(t.otherfee) as otherfee" +
				" from Ticketturnoverdetail t,Userinfo us" +
				" where t.seller=us.id " 
						+ " "); 
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		 
		Query query = getEntityManager().createQuery(sql.toString());
		
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		
		List<Object> result = query.getResultList();
		
		return result;
	}
	
	/**
	 * 查询某日,月票款明细信息的总站务费
	 * @param propertyFilterList
	 * @return
	 */
	public Object queryTicketStationservicefee(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select sum(s.stationservicefee) " +
				"from Ticketturnoverdetail t ,Userinfo us,Ticketsell s  " +
				"where t.seller=us.id and s.turnoverdetailid=t.id " +
				"");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		
		Query query = getEntityManager().createQuery(sql.toString());
		
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		
		Object result = query.getSingleResult();
		
		return result;
	}

	public Timestamp qrylastturnovertime(long seller) {
		StringBuffer sql = new StringBuffer("SELECT max(turnovertime) FROM Ticketturnover where 1=1");
		if(seller!=0){
			sql.append(" and seller = "+seller);
		}
		Query query = getEntityManager().createQuery(sql.toString());
		return (Timestamp) query.getSingleResult();
	}
	public String qrylastlostmoney(long seller)
	{
		Timestamp lastturnovertime = qrylastturnovertime(seller);
		StringBuffer sql = new StringBuffer("select t.lost from Ticketturnover t where t.seller="+seller);
		sql.append(" and t.turnovertime = "+"to_timestamp('"+lastturnovertime+"','yyyy-mm-dd hh24:mi:ss.ff')");
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list!=null&&list.size()>0)
			return list.get(0).toString();
		else
			return null;
	}

	public List<Object> queryticketturnover(
			List<PropertyFilter> propertyFilterList, Timestamp lastturnovertime, Global global) {
		ParameterService parameterService = new ParameterServiceImpl();
		String billtypecode = parameterService.findParamValue("1102", global.getOrganization().getId());
		StringBuffer sql = new StringBuffer();
		sql.append("select ttd.id, ttd.ticketturnoverid, ttd.moneydate, ttd.seller, ttd.ticketstartno, ttd.ticketendno, ttd.turnovertime, ")
		.append("ttd.moneypayable, ttd.sellnum, ttd.sellmoney, ttd.returnnum, ttd.returnmoney, ttd.returnhandcharge, ttd.cancelnum,")
		.append("ttd.noncashnum, ttd.noncashmoney, ttd.eticketnum, ttd.createtime, ttd.createby, ttd.updatetime, ttd.updateby,")
		.append("ttd.servicefee, ttd.bookservicefee, ttd.isturnover, ttd.cancelmoney, ttd.nonvouchermoneypayable,")
		.append("ttd.changeservicefee, ttd.billinuseid, ttd.batchno, ttd.sellreturntripnum, ttd.returnprintnum, ttd.billdamagednum,")
		.append("ttd.stationservicefee, ttd.fueladditionfee, ttd.computefee, ttd.coolairfee, ttd.additionfee, ttd.waterfee,")
		.append("ttd.insurefee, ttd.otherfee, ttd.synccode, ttd.changenum, ttd.updatename, ttd.sellername, ttd.createname, ttd.ischoose,")
		.append("ttd.code, ttd.nostationfeemoney, ttd.lastlost, ttd.money,")
		.append("ttd.eticketreturncharge,ttd.eservicefee,ttd.ebookservicefee,ttd.echangeservicefee,ttd.eticketreturnnum,ttd.eticketreturnmoney,")
		//.append("nvl(ttd2.price,0),");
		.append("nvl(ttd.takeeticketmoney, 0),");
		if(billtypecode.equals("Ticket")){
			//sql.append("(ttd.sellnum+ttd.sellreturntripnum+ttd.returnprintnum+ttd.billdamagednum+eticketnum)  ticketallnum");
			//sql.append("(ttd.ticketprintnum+ttd.sellreturntripnum+ttd.returnprintnum+ttd.billdamagednum+eticketnum)  ticketallnum");
			//本机构车票使用张数取车票打印张数字段; 非本机构车票使用张数采用原查询方式，即取售票数
			sql.append("decode(ttd.userorgid, :localorgid, (ttd.ticketprintnum+ttd.sellreturntripnum+ttd.returnprintnum+ttd.billdamagednum+eticketnum), ");
			sql.append(" (ttd.sellnum+ttd.sellreturntripnum+ttd.returnprintnum+ttd.billdamagednum+eticketnum) ) ticketallnum ");
		}else{
			sql.append("(ttd.sellnum+ttd.sellreturntripnum+ttd.billdamagednum+eticketnum)  ticketallnum");
		}
		sql.append(" , nvl(ttd3.changeprice,0), case when nvl(ttd.returnnum - ttd3.changenum ,0) <0 then 0 else nvl(ttd.returnnum - ttd3.changenum ,0) end, case when nvl(ttd.returnmoney - ttd3.changeprice ,0) <0 then 0 else nvl(ttd.returnmoney - ttd3.changeprice ,0) end");
		sql.append(" , ttd.noncashmoneypayable, ttd.eticketreturnbacknum, ttd.eticketreturnbackmoney,");
		sql.append(" ttd.eticketreturnbackcharge, ttd.noncashreturnnum, ttd.noncashreturnmoney,");
		sql.append(" ttd.noncashreturnhandcharge, ttd.cashmoneypayable, ttd.cashsellnum,");
		sql.append(" ttd.cashsellmoney, ttd.cashreturnnum, ttd.cashreturnmoney,");
		sql.append(" ttd.cashreturnhandcharge, ttd.cashservicefee,");
		sql.append(" ttd.cashbookservicefee, ttd.cashchangeservicefee ");
		//===begin===2017年9月21日 by dongy 售票员营收缴款==应缴款查询报错
		sql.append(" from (select ");
		 sql.append("  t.id,t.ticketturnoverid,t.moneydate,t.seller,t.ticketstartno,t.ticketendno,t.turnovertime,t.moneypayable,              ");
		 sql.append("  t.sellnum,t.sellmoney,t.returnnum,t.returnmoney,t.returnhandcharge,t.cancelnum,t.noncashnum,t.noncashmoney,            ");
		 sql.append("  t.eticketnum,t.createtime,t.createby,t.updatetime,t.updateby,t.servicefee,t.bookservicefee,t.isturnover,               ");
		 sql.append("  t.cancelmoney,t.nonvouchermoneypayable,t.changeservicefee,t.billinuseid,t.batchno,t.sellreturntripnum,                 ");
		 sql.append("  t.returnprintnum,t.billdamagednum,t.stationservicefee,t.fueladditionfee,t.computefee,t.coolairfee,t.additionfee,       ");
		 sql.append("  t.waterfee,t.insurefee,t.otherfee,t.synccode,t.changenum,t.eticketreturncharge,t.eticketreturnmoney,                   ");
		 sql.append("  t.eticketreturnnum,t.eservicefee,t.ebookservicefee,t.echangeservicefee,  ");
		 sql.append("  use.name as updatename, us.name as sellername, ")
//		sql.append(" from (select t.*, use.name as updatename, us.name as sellername, ")
		 //===end===
//		.append(" u.name as createname,case t.isturnover when 1 then 0 else 1 end as ischoose,")
		.append(" u.name as createname,0 as ischoose,") //20160225西安需求变更: 明细表不默认全选
		.append(" us.code as code,(t.sellmoney-t.stationservicefee ) as nostationfeemoney," )
		.append(" t.lost as lastlost,t.money as money ")
		//.append(" , t.eticketreturncharge,t.eservicefee, t.ebookservicefee  ,  t.echangeservicefee,t.eticketreturnnum,t.eticketreturnmoney ")
		.append(" , t.ticketprintnum as ticketprintnum, us.orgid as userorgid ")
		.append(" , 0 as takeeticketmoney")
		.append(" ,t.noncashmoneypayable as noncashmoneypayable,")
		.append(" t.eticketreturnbacknum  as  eticketreturnbacknum,")
		.append(" t.eticketreturnbackmoney  as  eticketreturnbackmoney,")
		.append(" t.eticketreturnbackcharge as eticketreturnbackcharge,")
		.append(" t.eticketreturnbacknum + t.returnnumweb as  noncashreturnnum,")
		.append(" t.eticketreturnbackmoney + t.returnamountweb as noncashreturnmoney,")
		.append(" t.eticketreturnbackcharge + t.chargesweb as noncashreturnhandcharge,")
		.append(" t.moneypayable - t.noncashmoneypayable as cashmoneypayable,")
		.append(" t.sellnum - t.noncashnum as cashsellnum,")
		.append(" t.sellmoney - t.noncashmoney as cashsellmoney,")
		.append("  t.returnnum - t.eticketreturnbacknum - t.returnnumweb  as cashreturnnum,")
		.append("  t.returnmoney -  t.eticketreturnbackmoney - t.returnamountweb as cashreturnmoney,")
		.append("  t.returnhandcharge -  t.eticketreturnbackcharge - t.chargesweb as cashreturnhandcharge,")
		.append(" t.servicefee - t.eservicefee as cashservicefee,")
		.append(" t.bookservicefee - t.ebookservicefee as cashbookservicefee,")
		.append(" t.changeservicefee - t.echangeservicefee as cashchangeservicefee")
		.append(" from Ticketturnoverdetail t , Userinfo us , Userinfo u , Userinfo use" )
		.append(" where  t.seller=us.id and t.createby=u.id and  t.updateby=use.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" order by t.createtime) ttd ")
		.append(" left join (SELECT T.ID,SUM(TS.PRICE) changeprice, count(ts.id) changenum FROM Ticketturnoverdetail T")
		.append(" LEFT JOIN TICKETSELL ts ON t.id = ts.turnoverdetailid and ts.selltime >= sysdate-30")
		.append(" AND TS.TICKETNO BETWEEN T.Ticketstartno AND T.ticketendno,userinfo us,ticketreturn tr where t.seller=us.id and tr.sellid = ts.id and tr.returnway = '3'");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" GROUP BY t.ID) ttd3 ON ttd.id = ttd3.id");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		if(billtypecode.equals("Ticket")){
			query.setParameter("localorgid", global.getOrganization().getId());
		}
		return query.getResultList();
	}
	/**
	 * 售票点应缴金额
	 * @param ticketoutletid
	 * @return
	 */
	public BigDecimal querySumMoneyByLetoutsid(Long ticketoutletid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select nvl(sum(td.moneypayable),0) from ticketturnoverdetail td,userticketoutlets ut where ")
		.append("td.seller=ut.userinfoid and ut.ticketoutletsid=:ticketoutletid and td.isturnover=0");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketoutletid", ticketoutletid);
		return (BigDecimal)query.getSingleResult();
	}
	/**
	 * 获取营收支付信息
	 * @param propertyFilterList
	 * @return
	 */
	public List<Object> qryticketturnoverdetailEPay(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select te.id,case te.paymethod ")
		.append(" when '0' then '现金' when '1' then '银联卡' when '2' then '贵客卡余额' when '3' then '贵客卡积分'  ")
		.append("  when '4' then '支付宝' when '5' then '微信' when '6' then '公务卡' ")
		.append("  else '其他' end paymethod,te.ticketnum ticketnum,te.price price  from Ticketturnoverdetailepay te where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Ticketturnoverdetail> getByIds(String[] ids) {
		StringBuffer sql = new StringBuffer();
		String id = "";
		for (String string : ids) {
			id = id + string + ",";
		}
		if(!"".equals(id) && id.length() > 0) {
			id = id.substring(0,id.length()-1);
		}else {
			return null;
		}
		sql.append("select t from Ticketturnoverdetail t where t.id in ("+id+")");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		return query.getResultList();
	}

	/** 禅道号  15893 
	 * 售票员营收缴款  打印 应缴合计 查询出预售票和预售票款  “预售票数”和“预售金额” 
	 * @return
	 */
	public List<Object> queryDetailBalanceAllow(String ticketturnoverdetailids,String ticketturnoverids) {
		List<Object> list = null;
		if(CommonUtil.isNotEmptyString(ticketturnoverids) &&!"()".equals(ticketturnoverids)){//说明是重打已缴款单合计   如果这个不是空说明是打印应缴合计
			StringBuffer sql = new StringBuffer();
			sql.append(" select to_char(wm_concat(tt.id)) from ticketturnover t, ticketturnoverdetail tt where t.id = tt.ticketturnoverid and t.id  in ")
			.append(ticketturnoverids );
			Query query = getEntityManager().createNativeQuery(sql.toString());
			 ticketturnoverdetailids = "("+query.getSingleResult() +")";
		}
		if(CommonUtil.isNotEmptyString(ticketturnoverdetailids) &&!"()".equals(ticketturnoverdetailids)){
			StringBuffer sql = new StringBuffer();
			sql.append(" select count(ts.id) precount ,nvl(sum(ts.price),0) preprice  from Ticketsell ts ")
			.append(" where ts.selltime < ts.departdate and ts.turnoverdetailid in "+ticketturnoverdetailids );
			Query query = getEntityManager().createNativeQuery(sql.toString());
			list = query.getResultList();
		}
		return list;
	}
}
