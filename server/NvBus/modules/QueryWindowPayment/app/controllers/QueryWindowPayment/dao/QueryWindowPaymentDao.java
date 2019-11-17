package controllers.QueryWindowPayment.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Gateway;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import util.CommonUtil;
import util.DateUtils;

/**
 * 
 * @author Administrator
 *
 */

public class QueryWindowPaymentDao extends EntityManagerDaoSurport {

	public List<Object> queryPayment(List<PropertyFilter> propertyFilterList,Date beginDate,Date endDate) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select  trim('付款') as paytype, p.orderno,p.payorderno, p.payno,")
				.append(" p.totalprice,p.paymessage,p.createtime, p.paytradenameval,")
				.append("  p.sellorgname,0 returnmoneytotal,p.cardcode,p.ip,")
				.append("   dt1.value          paystatusname, decode(dt2.code,'1', dt2.value||'(已出票)',dt2.value||'(未出票)')   orderstatusname,")
				.append("   dt3.value          paymethod, u.name, u.code,p.tickets, (p.totalprice-p.insurefee) ticketprice, p.insures, p.insurefee ")
				.append("  from payinfo p  left join digitaldictionarydetail dt1")
				.append("    on p.paystatus = dt1.code  and dt1.digitaldictionaryid = 2018012401")
				.append("    left join digitaldictionarydetail dt2 on p.paystatus = dt2.code")
				.append("   and dt2.digitaldictionaryid = 2018012402 left join digitaldictionarydetail dt3")
				.append("    on p.paymethod = dt3.code  and dt3.digitaldictionaryid = 50")
				.append("  left join userinfo u on p.createby = u.id").append(" where 1 = 1 ")
				.append(" and p.createtime  between :beginDate and :endDate+0.99999")
				.append(" ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" union all ")
		.append(" select trim('退款') as paytype,p.orderno,p.payorderno,p.payno,0 totalprice,p.paymessage,")
		.append("  pd.returntime createtime, p.paytradenameval,p.sellorgname,")
		.append("  pd.returnprice returnmoneytotal,p.cardcode,pd.ip, nvl(dt1.value,'已完成') paystatusname,")
		.append("  decode(dt2.code,'1', dt2.value||'(已出票)',dt2.value||'(未出票)') orderstatusname,")
		.append("  dt3.value paymethod,u.name,u.code,pd.tickets, pd.ticketprice,pd.insures,")
		.append("  pd.insurefee ")
		.append(" from payinfo p left join digitaldictionarydetail dt1")
		.append("  on p.paystatus = dt1.code  and dt1.digitaldictionaryid = 2018012401")
		.append("  left join digitaldictionarydetail dt2 on p.paystatus = dt2.code")
		.append("  and dt2.digitaldictionaryid = 2018012402 left join digitaldictionarydetail dt3")
		.append("  on p.paymethod = dt3.code  and dt3.digitaldictionaryid = 50,")
		.append("    payinfodetail pd left join userinfo u  on pd.returnby = u.id")
		.append("    where p.id = pd.payinfoid  and pd.returnstatus = '1'")
		.append("   and pd.returntime between :beginDate and :endDate+0.99999");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("beginDate",beginDate);
		query.setParameter("endDate",endDate);
		return query.getResultList();
	}

	/**
	 * 窗口电子支付对账汇总表
	 * 
	 * @param propertyFilterList
	 * @param summaryway
	 *            [ 0 交易日期分组 || 1 支付方式分组 || 2 交易日期和支付方式分组]
	 * @return
	 */
	public List<Object> queryPaymentSummary(List<PropertyFilter> propertyFilterList, String summaryway,Date beginDate,Date endDate){
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT code,name,sellorgname,selldate,paymethod,paymerchant, ");
//		sql.append(" count(orderno),sum(price),sum(returnprice),sum(price-returnprice) amount from (");
		//已完成订单：订单数、车票数、车票金额、保险数、保险金额、订单总金额
		sql.append(" SUM(sellordernum) sellordernum,SUM(sellticketnum) AS sellticketnum,SUM(sellticketmoney) AS sellticketmoney,SUM(sellinsurenum) AS sellinsurenum,SUM(sellinsuremoney) AS sellinsuremoney,SUM(selltotalmoney) AS selltotalmoney,");
		//原路返还订单：订单数、退票数、退票金额、退保数、退保金额、返还金额
		sql.append(" SUM(returnordernum) AS returnordernum,NVL(SUM(returnticketnum),0) AS returnticketnum,SUM(returnticketmoney) AS returnticketmoney,SUM(returninsurenum) AS returninsurenum,SUM(returninsuremoney) AS returninsuremoney,SUM(returntotalmoney) AS returntotalmoney");
		sql.append(" ,SUM(selltotalmoney - returntotalmoney) AS amount from (");
		
		sql.append(" select p.sellorgname sellorgname,p.paytradenameval AS paymerchant, ");
		if ("0".equals(summaryway)) {
			// summaryway = 0 交易日期分组
			sql.append(" TO_CHAR(p.createtime, 'yyyy-MM-dd') selldate, ");
			sql.append(" '' as paymethod, ");
		} else if ("1".equals(summaryway)) {
			// summaryway = 1 支付方式分组
			sql.append(" '' selldate, ");
			sql.append(" dit.value AS paymethod, ");
		} else if ("2".equals(summaryway)) {
			// summaryway = 2 交易日期和支付方式分组
			sql.append(" TO_CHAR(p.createtime, 'yyyy-MM-dd') selldate, ");
			sql.append(" dit.value as paymethod, ");
		}else{
			sql.append(" TO_CHAR(p.createtime, 'yyyy-MM-dd') AS selldate,dit.value AS paymethod,");
		}
		play.Logger.info("窗口电子支付对账汇总表-汇总方式[ 0 交易日期分组 || 1 支付方式分组 || 2 交易日期和支付方式分组]:" + summaryway);
		//正常票 + 保险
		sql.append("  COUNT(distinct p.orderno) AS sellordernum ,SUM(NVL(p.tickets,0)) AS sellticketnum,NVL(SUM(p.totalprice-p.insurefee),0) AS sellticketmoney");
		sql.append("  ,SUM(NVL(p.insures,0)) AS sellinsurenum,SUM(NVL(p.insurefee,0))  AS sellinsuremoney,NVL(SUM(p.totalprice),0) AS selltotalmoney");
		sql.append("  ,0 AS returnordernum , 0 AS returnticketnum, 0 AS returnticketmoney");
		sql.append("  ,0 AS returninsurenum, 0 AS returninsuremoney, 0 AS returntotalmoney");
		sql.append("  ,u.code,u.name");
		sql.append(" FROM Payinfo p ");
		sql.append(" LEFT JOIN digitaldictionary dig ON dig.tablename = 'ticketsell' AND dig.columnname = 'paymethod'");
		sql.append(" LEFT JOIN digitaldictionarydetail dit ON dit.digitaldictionaryid = dig.id AND dit.code = p.paymethod");
		sql.append(" left join userinfo u on p.createby=u.id");
		sql.append(" WHERE  1 = 1 ");
		sql.append(" AND p.createtime >= :beginDate");
		sql.append(" AND p.createtime < :endDate + 0.99999 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" GROUP BY p.sellorgname,to_char(p.createtime, 'yyyy-MM-dd'),dit.value,p.paytradenameval,u.code,u.name");
		
		//退票 + 退保险
		sql.append(" UNION ALL");
		sql.append(" select p.sellorgname sellorgname,p.paytradenameval AS paymerchant, ");
		if ("0".equals(summaryway)) {
			// summaryway = 0 交易日期分组
			sql.append(" TO_CHAR(pd.returntime, 'yyyy-MM-dd') selldate, ");
			sql.append(" '' as paymethod, ");
		} else if ("1".equals(summaryway)) {
			// summaryway = 1 支付方式分组
			sql.append(" '' selldate, ");
			sql.append(" dit.value as paymethod, ");
		} else if ("2".equals(summaryway)) {
			// summaryway = 2 交易日期和支付方式分组
			sql.append(" TO_CHAR(pd.returntime, 'yyyy-MM-dd') selldate, ");
			sql.append(" dit.value as paymethod, ");
		}else{
			sql.append(" TO_CHAR(pd.returntime, 'yyyy-MM-dd') as selldate,dit.value as paymethod,");
		}
		
		sql.append("  0 AS sellordernum ,0 AS sellticketnum,0 AS sellticketmoney");
		sql.append("  ,0 AS sellinsurenum,0 AS sellinsuremoney,0 AS selltotalmoney");
		sql.append("  ,COUNT(distinct p.id) AS returnordernum , SUM(NVL(pd.tickets,0)) AS returnticketnum, NVL(SUM(pd.ticketprice),0) AS returnticketmoney");
		sql.append("  ,SUM(NVL(pd.insures,0)) AS returninsurenum, SUM(NVL(pd.insurefee,0)) AS returninsuremoney,")
		.append(" NVL(SUM(decode(pd.returnstatus, '1',  decode(pd.ticketprice + pd.insurefee,0,pd.returnprice,pd.ticketprice + pd.insurefee), 0)),0) AS returntotalmoney");
		sql.append("  ,u.code,u.name");
		sql.append(" FROM payinfo p left join Payinfodetail pd on p.id = pd.payinfoid  and  pd.returnstatus='1'");
		sql.append(" LEFT JOIN digitaldictionary dig on dig.tablename = 'ticketsell' and dig.columnname = 'paymethod'");
		sql.append(" LEFT JOIN digitaldictionarydetail dit on dit.digitaldictionaryid = dig.id and dit.code = p.paymethod");
		sql.append(" left join userinfo u on pd.returnby=u.id");
		sql.append(" WHERE pd.id IS NOT NULL ");
		sql.append(" AND pd.returntime >= :beginDate");
		sql.append(" AND pd.returntime < :endDate +  0.99999 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" GROUP BY p.sellorgname,to_char(pd.returntime, 'yyyy-MM-dd'),dit.value,p.paytradenameval,u.code,u.name");
		
		sql.append(" )GROUP BY sellorgname,selldate, paymethod,paymerchant,code,name ");
		sql.append(" ORDER BY selldate ASC ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if(null != beginDate && null != endDate){
			query.setParameter("beginDate", beginDate);
			query.setParameter("endDate", endDate);
		}else{
			play.Logger.info("窗口电子支付对账汇总表 - 查询开始日期 和 结束日期为空，查询将会出错！");
		}
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> query(String sql) {
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	/**
	 * 查询窗口电子支付明细
	 * #21596 将查询条件由售票日期修改为交易日期
	 * @param beginDate： 交易开始日期
	 * @param endDate： 交易截止日期
	 * @return
	 */
	public List<Object> ticketEpayDetail(Global g,Date beginDate, Date endDate, List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append("select operatetype, operatetime, departdate, ticketno, routetime, schedulecode, stationname,  ");
		//add by tianhb 2018年12月13日 增加一列：服务费 servicefee
		sql.append(" price, returnamount, charge, seatno, premium, orderno, ticketstatus, paymethod, username, cardno ,servicefee ");
		sql.append("from( ");
		//售票
		//售票group by 根据 operatetype和ticketno
		sql.append(" select operatetype,max(soid.operatetime) operatetime, max(soid.departdate) departdate, ")
		.append(" max(soid.ticketno) ticketno,max(soid.routetime) routetime,max(soid.schedulecode) schedulecode, ")
		.append(" max(soid.stationname) stationname,sum(soid.price) price,sum(soid.returnamount) returnamount, ")
		.append(" sum(soid.charge) charge,max(soid.seatno) seatno,sum(soid.premium) premium,max(soid.orderno) orderno,  ")
		.append(" max(soid.ticketstatus) ticketstatus,max(soid.paymethod) paymethod,max(soid.username) username, ")
		.append(" max(soid.cardno) cardno,sum(servicefee) servicefee from( ");  //售票外层的group by
		sql.append(" select trim('售票') operatetype, ts.selltime operatetime, ts.departdate departdate,ts.ticketno ticketno, ")
		.append(" r.name routetime, s.code schedulecode, st.name stationname, ts.price price, 0 returnamount, 0 charge, ts.seatno seatno, ")
		.append(" 0 premium, ts.orderno orderno,dd1.value ticketstatus,dd2.value paymethod,ui.name username,ui.code cardno ")
		.append(" ,ts.servicefee AS servicefee")
		.append("  from ticketsell ts  ")
		.append(" left join insurance i on ts.id=i.sellid ")
		.append(" left join schedule s on ts.scheduleid=s.id ")
		.append(" left join route r on s.routeid=r.id ")
		.append(" left join userinfo ui on ts.sellby=ui.id ")
		.append(" left join station st on ts.reachstationid=st.id ")
		.append(" ,digitaldictionary d1,digitaldictionarydetail dd1, ")
		.append(" digitaldictionary d2,digitaldictionarydetail dd2 ")
		.append(" where d1.id=dd1.digitaldictionaryid and d1.tablename='ticketsell'  ")
		.append(" and d1.columnname='ticketstatus' and dd1.code=ts.ticketstatus ")
		.append(" and d2.id=dd2.digitaldictionaryid and d2.tablename='ticketsell'  ")
		.append(" and d2.columnname='paymethod' and dd2.code=ts.paymethod ")
		.append(" and ts.sellway not in ('7', '10') and ts.paymethod in('1','4','5','10','11','12','13') ");
		sql.append(" and ui.orgid = " + g.getOrganization().getId());
		if(beginDate != null && endDate != null){
			sql.append(" and ts.selltime between trunc(:beginDate) and trunc(:endDate) + 0.99999 ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		//改签
		
		//售保险
		sql.append(" union all ")
		.append(" select trim('售票') operatetype, i.selltime operatetime, ts.departdate departdate,ts.ticketno ticketno, ")
		.append(" r.name routetime, s.code schedulecode, st.name stationname, 0 price, 0 returnamount, 0 charge, ts.seatno seatno, ")
		.append(" i.premium premium, ts.orderno orderno,dd1.value ticketstatus,dd2.value paymethod,ui.name username,ui.code cardno  ")
		.append(" ,0 AS servicefee")
		.append(" from ticketsell ts ")
		.append(" left join schedule s on ts.scheduleid=s.id ")
		.append(" left join route r on s.routeid=r.id ")
		.append(" left join userinfo ui on ts.sellby=ui.id ")
		.append(" left join station st on ts.reachstationid=st.id ")
		.append(" ,digitaldictionary d1,digitaldictionarydetail dd1, ")
		.append(" digitaldictionary d2,digitaldictionarydetail dd2,insurance i ")
		.append(" where d1.id=dd1.digitaldictionaryid and d1.tablename='ticketsell'  ")
		.append(" and d1.columnname='ticketstatus' and dd1.code=ts.ticketstatus ")
		.append(" and d2.id=dd2.digitaldictionaryid and d2.tablename='ticketsell'  ")
		.append(" and d2.columnname='paymethod' and dd2.code=ts.paymethod ")
		.append(" and i.sellway not in('7','10')  and  ts.id = i.sellid  and  i.paymethod <> '0'");
		sql.append(" and ui.orgid = " + g.getOrganization().getId());
		if(beginDate != null && endDate != null){
			sql.append(" and i.selltime between trunc(:beginDate) and trunc(:endDate) + 0.99999 ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" ) soid group by soid.operatetype, soid.ticketno ");  //售票外层group by
		//退票
		sql.append(" union all ");
		//退票外层 group by
		sql.append(" select operatetype,max(soid.operatetime) operatetime, max(soid.departdate) departdate, ")
		.append(" max(soid.ticketno) ticketno,max(soid.routetime) routetime,max(soid.schedulecode) schedulecode, ")
		.append(" max(soid.stationname) stationname,sum(soid.price) price,sum(soid.returnamount) returnamount, ")
		.append(" sum(soid.charge) charge,max(soid.seatno) seatno,sum(soid.premium) premium,max(soid.orderno) orderno,  ")
		.append(" max(soid.ticketstatus) ticketstatus,max(soid.paymethod) paymethod,max(soid.username) username, ")
		.append(" max(soid.cardno) cardno,sum(servicefee) servicefee from( ");  //退票外层的group by
		sql.append(" select trim('退票') operatetype, tr.returntime operatetime, ts.departdate departdate,ts.ticketno ticketno, ")
		.append(" r.name routetime, s.code schedulecode, st.name stationname, ")
		//退票的票价显示0，退票款、退票手续费为正数；
		.append(" 0 price, tr.returnamount returnamount, tr.charges charge, ts.seatno seatno,")
		.append(" 0 premium, ts.orderno orderno, ")
		.append(" dd1.value ticketstatus,dd2.value paymethod,ui.name username,ui.code cardno ")
		.append(" ,0 AS servicefee")
		.append(" from ticketreturn tr ")
		.append(" left join ticketsell ts on tr.sellid = ts.id ")
		.append(" left join insurance i on ts.id=i.sellid ")
		.append(" left join schedule s on ts.scheduleid=s.id ")
		.append(" left join route r on s.routeid=r.id ")
		.append(" left join userinfo ui on tr.returnby = ui.id ")
		.append(" left join station st on ts.reachstationid=st.id ")
		.append(" ,digitaldictionary d1,digitaldictionarydetail dd1, ")
		.append(" digitaldictionary d2,digitaldictionarydetail dd2 ")
		.append(" where d1.id=dd1.digitaldictionaryid and d1.tablename='ticketsell'  ")
		.append(" and d1.columnname='ticketstatus' and dd1.code=ts.ticketstatus ")
		.append(" and d2.id=dd2.digitaldictionaryid and d2.tablename='ticketsell'  ")
		.append(" and d2.columnname='paymethod' and dd2.code=ts.paymethod ")
		.append(" and ts.sellway not in ('7', '10') and ts.paymethod in('1','4','5','10','11','12','13') and nvl(i.paymethod,'1')<>'0' ")
		.append(" and tr.returnfeemode='1' ");  //只查原路返还
		sql.append(" and ui.orgid = " + g.getOrganization().getId());
		if(beginDate != null && endDate != null){
			sql.append(" and tr.returntime between trunc(:beginDate) and trunc(:endDate) + 0.99999 ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		//退保险
		sql.append(" union all ");
		sql.append(" select trim('退票') operatetype, inr.returntime operatetime, ts.departdate departdate,ts.ticketno ticketno, ")
		.append(" r.name routetime, s.code schedulecode, st.name stationname, ")
		.append(" 0 price, 0 returnamount,0 charge, ts.seatno seatno,")
		.append(" decode(i.insurancestatus, '0', 0, -nvl(i.premium, 0)) premium, ts.orderno orderno, ")
		.append(" dd1.value ticketstatus,dd2.value paymethod,ui.name username,ui.code cardno ")
		.append(" ,0 AS servicefee")
		.append(" from ticketsell ts ")
		.append(" left join schedule s on ts.scheduleid=s.id ")
		.append(" left join route r on s.routeid=r.id ")
		.append(" left join station st on ts.reachstationid=st.id ")
		.append(" ,digitaldictionary d1,digitaldictionarydetail dd1, ")
		.append(" digitaldictionary d2,digitaldictionarydetail dd2 ")
		.append(" ,insurance i,insurancereturn inr ")
		.append(" left join userinfo ui on inr.returnby = ui.id ")
		.append(" where d1.id=dd1.digitaldictionaryid and d1.tablename='ticketsell'  ")
		.append(" and d1.columnname='ticketstatus' and dd1.code=ts.ticketstatus ")
		.append(" and d2.id=dd2.digitaldictionaryid and d2.tablename='ticketsell'  ")
		.append(" and d2.columnname='paymethod' and dd2.code=ts.paymethod ")
		.append(" and i.paymethod<>'0' and ts.id=i.sellid and inr.insuranceid=i.id and inr.returnfeemode='1' ");
		sql.append(" and ui.orgid = " + g.getOrganization().getId());
		if(beginDate != null && endDate != null){
			sql.append(" and inr.returntime between trunc(:beginDate) and trunc(:endDate) + 0.99999 ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" ) soid group by soid.operatetype, soid.ticketno ");  //退票外层 group by
		
		sql.append(" ) tsrc order by tsrc.ticketno, tsrc.operatetime ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if(beginDate != null && endDate != null){
			query.setParameter("beginDate", beginDate);
			query.setParameter("endDate", endDate);
		}
//		System.out.println(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 窗口电子支付汇总表
	 * #21596 将查询条件由售票日期修改为交易日期
	 * @param propertyFilterList
	 * @param summaryway
	 *            [ 0 支付方式分组 || 1 交易日期分组 || 2 交易日期和支付方式分组]
	 * @param datetype
	 *            [0 售票日期 || 1 发车日期]
	 * @return
	 * 
	 */
	public List<Object> queryEpaymentTicketsSum(List<PropertyFilter> propertyFilterList, String summaryway,
			String datetype,Date starttime,Date endtime,Global g) {
		String startdatesql = null;//开始日期字符串
		String enddatesql = null;//结束日期字符串
		boolean isdeptdate = false;// 是否发车日期
		if (CommonUtil.isNotEmptyString(datetype) && datetype.equals("1")) {
			isdeptdate = true;
		}
		startdatesql = "date'"+DateUtils.formatDate(starttime)+"' ";
		enddatesql = "date'"+DateUtils.formatDate(endtime)+"'+0.99999 ";
		String datesql = " between "+startdatesql+" and "+enddatesql;
		
		//操作人id：售票员/退票员id
		Iterator<PropertyFilter> iterator = propertyFilterList.iterator();
		String operateUserIds = "";
		while(iterator.hasNext()){
			PropertyFilter filter = iterator.next();
			if("t!sellby".equals(filter.getPropertyFullName())){
				operateUserIds = (String) filter.getMatchValue();
				iterator.remove();
				break;
			}
		}
		// ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓明细内层sql	↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
		StringBuilder detailsql = new StringBuilder();// 明细sql
		//售本站票
		detailsql.append("	select ").append(isdeptdate ? " t.departdate " : " trunc(t.selltime) ")
				.append("  as selltime, ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("  t.paymethod, ")
				.append("  1 as tsellnum, ")
				.append("  t.price as tsellprice, ")
				.append("  0 as treturnnum, ")
				.append("  0 as treturnprice, ")
				.append("  0 as dfcharges, ")//垫付手续费
				.append("  0 as ylcharges, ")//原路返还手续费
				.append("  0 inssellnum, ")
				.append("  0 inssellprice, ")
				.append("  0 insretrnnum, ")
				.append("  0 insreturnprice ")
				//add by tianhb 2018年12月13日 增加一列：服务费 servicefee
				.append(" ,t.servicefee")
				.append(" from ticketsell t  ")
				.append(" left join userinfo u on t.sellby = u.id ")
				.append(" where t.paymethod <> '0' ")
				.append(" and t.sellway not in ('7', '10') ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and t.departdate ").append(datesql);
				}else {
					detailsql.append(" and t.selltime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
		//退本站票
		detailsql.append(" union all ");
		detailsql.append("	select ").append(isdeptdate ? " t.departdate " : " trunc(tr.returntime) ")
				.append(" as selltime,   ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("       t.paymethod,                                                        ")
				.append("       0 as tsellnum,                                                      ")
				.append("       0 as tsellprice,                                              ")
				.append("       decode(tr.returnfeemode, '1', 1, 0) as treturnnum, ")//原路返还退票数
				.append("		decode(tr.returnfeemode, '1', tr.returnamount, 0) as treturnprice, ")//原路返还退票款
				.append("		decode(tr.returnfeemode, '1', 0, tr.charges) as dfcharges, ")//垫付手续费
				.append("		decode(tr.returnfeemode, '1', tr.charges, 0) as ylcharges, ")//原路返还手续费
				.append("		0 inssellnum,                                                  ")
				.append("       0 inssellprice,                                                     ")
				.append("       0 insretrnnum,                                                      ")
				.append("       0 insreturnprice                                                    ")
				.append(" ,0 servicefee")
				.append("     from ticketreturn tr                                                     ")
				.append("     left join ticketsell t on tr.isselfschedule = 1 and t.id = tr.sellid and t.ticketstatus = '1' ")
				.append(" left join userinfo u on tr.returnby = u.id ")
				.append("     where 1 = 1                                                             ")
				.append("     and t.paymethod <> '0'                                                  ")
				.append("     and t.sellway not in ('7', '10')                                        ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and t.departdate ").append(datesql);
				}else {
					detailsql.append(" and tr.returntime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//售本站保险
				detailsql.append(" union all ")
				.append(" select ").append(isdeptdate ? " ts.departdate " : " trunc(t.selltime) ")
				.append("  as selltime, ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("  t.paymethod,  ")
				.append("  0 as tsellnum, ")
				.append("  0 as tsellprice,  ")
				.append("  0 as treturnnum, ")
				.append("  0 as treturnprice,  ")
				.append("  0 as dfcharges, ")
				.append("  0 as ylcharges, ")
				.append("  1 inssellnum,   ")
				.append("  t.premium inssellprice, ")
				.append("  0 insretrnnum, ")
				.append("  0 insreturnprice  ")
				.append(" ,0 servicefee")
				.append(" from insurance t   ")
				.append("  left join userinfo u on t.sellby = u.id,ticketsell ts ")
				.append(" where  t.paymethod <> '0' and ts.id = t.sellid and t.isselfschedule = 1  ")
				.append(" and t.sellway not in ('7', '10')  ");
//				.append(" and ts.paymethod  in ('1', '4', '5', '10', '11') ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and ts.departdate ").append(datesql);
				}else {
					detailsql.append(" and t.selltime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//退本站保险
				detailsql.append("     union all                                                               ")
				.append("    select ").append(isdeptdate ? " ts.departdate " : " trunc(inr.returntime) ")
				.append(" as selltime,   ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("            t.paymethod,                                                     ")
				.append("            0 as tsellnum,                                                   ")
				.append("            0 as tsellprice,                                                 ")
				.append("            0 as treturnnum,                                                 ")
				.append("            0 as treturnprice,                                               ")
				.append("            0 as dfcharges, ")
				.append("            0 as ylcharges, ")
				.append("            0 inssellnum,                                                    ")
				.append("            0 inssellprice,                                          ")
				.append("     		 1 insretrnnum, ")
				.append("            inr.premium insreturnprice  ")
				.append(" ,0 servicefee")
				.append("     from insurancereturn inr ")
				.append("     left join insurance t on inr.insuranceid = t.id  and inr.returnfeemode = '1'  left join userinfo u on inr.returnby = u.id,ticketsell ts                ")
				.append("     where 1 = 1                                                             ")
				.append("     and t.paymethod <> '0'   and ts.id = t.sellid and t.isselfschedule = 1                                               ")
				.append("     and t.sellway not in ('7', '10')                                        ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and ts.departdate ").append(datesql);
				}else {
					detailsql.append(" and inr.returntime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//售异站票
				detailsql.append("	union all ")
				.append(" select ").append(isdeptdate ? " t.departdate " : " trunc(t.selltime) ")
				.append("   as selltime, ")
				.append("   u.name username,")
				.append("   u.code usercode,")
				.append("	t.paymethod, ")
				.append("	1 as tsellnum, ")
				.append("	t.price as tsellprice, ")
				.append("	0 as treturnnum, ")
				.append("	0 as treturnprice, ")
				.append("   0 as dfcharges, ")
				.append("   0 as ylcharges, ")
				.append("	0 inssellnum, ")
				.append("	0 inssellprice, ")
				.append("	0 insretrnnum,  ")
				.append("	0 insreturnprice  ")
				.append(" ,0 servicefee")
				.append(" from ticketsellagent t ")
				.append(" left join userinfo u on t.sellby = u.id ")
				.append("    where t.paymethod <> '0' ")
				.append("	and t.sellway not in ('7', '10') ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and t.departdate ").append(datesql);
				}else {
					detailsql.append(" and t.selltime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//退异站票:
				detailsql.append("	union all                                                                 ")
				.append("    select ").append(isdeptdate ? " t.departdate " : " trunc(tr.returntime) ")
				.append(" as selltime,   ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("	       t.paymethod,                                                       ")
				.append("	       1 as tsellnum,                                                     ")
				.append("	       t.price as tsellprice,                                             ")
				.append("	       decode(tr.returnfeemode, '1', 1, 0) as treturnnum, ")//原路返还退票数
				.append("		   decode(tr.returnfeemode, '1', tr.returnamount, 0) as treturnprice, ")//原路返还退票款
				.append("		   decode(tr.returnfeemode, '1', 0, tr.charges) as dfcharges, ")//垫付手续费
				.append("		   decode(tr.returnfeemode, '1', tr.charges, 0) as ylcharges, ")//原路返还手续费
				.append("		   0 inssellnum,                                                      ")
				.append("		   0 inssellprice,                                                    ")
				.append("		   0 insretrnnum,                                                     ")
				.append("		   0 insreturnprice                                                   ")
				.append(" ,0 servicefee")
				.append("	from ticketreturn tr ")
				.append("	left join ticketsellagent t on tr.isselfschedule = 0 and t.id = tr.sellid and t.ticketstatus = '1'  left join userinfo u on tr.returnby = u.id ")
				.append("    where 1 = 1                                                                   ")
				.append("	and t.paymethod <> '0'                                                         ")
				.append("	and t.sellway not in ('7', '10')                                               ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and t.departdate ").append(datesql);
				}else {
					detailsql.append(" and tr.returntime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//售异站票保险
				detailsql.append("	union all   ")
				.append(" select ").append(isdeptdate ? " ts.departdate " : " trunc(t.selltime) ")
				.append("  as selltime,   ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("  t.paymethod, ")
				.append("  0 as tsellnum,  ")
				.append("  0 as tsellprice, ")
				.append("  0 as treturnnum, ")
				.append("  0 as treturnprice, ")
				.append("   0 as dfcharges, ")
				.append("   0 as ylcharges, ")
				.append("  1 inssellnum, ")
				.append("  t.premium inssellprice, ")
				.append("  0 insretrnnum, ")
				.append("  0 insreturnprice ")
				.append(" ,0 servicefee")
				.append(" from insurance t ")
				.append("  left join userinfo u on t.sellby = u.id,ticketsellagent ts  ")
				.append(" where t.paymethod <> '0'  and ts.id = t.sellid and t.isselfschedule = 0  ")
				.append("  and t.sellway not in ('7', '10') ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and ts.departdate ").append(datesql);
				}else {
					detailsql.append(" and t.selltime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//退异站票保险
				detailsql.append("	union all   ")
				.append("    select ").append(isdeptdate ? " ts.departdate " : " trunc(inr.returntime) ")
				.append(" as selltime,   ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("	       t.paymethod,                                                            ")
				.append("	       0 as tsellnum,                                                          ")
				.append("	       0 as tsellprice,                                                        ")
				.append("	       0 as treturnnum,                                                        ")
				.append("	       0 as treturnprice,                                                      ")
				.append("   0 as dfcharges, ")
				.append("   0 as ylcharges, ")
				.append("	       0 inssellnum,                                                           ")
				.append("	       0 inssellprice,                                                 ")
				.append("		   1 insretrnnum, ")
				.append("		   inr.premium insreturnprice ")
				.append(" ,0 servicefee")
				.append("	from insurancereturn inr ")
				.append("	left join insurance t on inr.insuranceid = t.id and inr.returnfeemode = '1'  left join userinfo u on inr.returnby = u.id,ticketsellagent ts     ")
				.append("	where 1 = 1                                                                    ")
				.append("	   and t.paymethod <> '0'  and ts.id = t.sellid and t.isselfschedule = 0       ")
				.append("	   and t.sellway not in ('7', '10')                                            ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and ts.departdate ").append(datesql);
				}else {
					detailsql.append(" and inr.returntime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				//改签表
				detailsql.append("	union all   ")
				.append("    select ").append(isdeptdate ? " t.departdate " : " trunc(t.selltime) ")
				.append(" as selltime,   ")
				.append("  u.name username,")
				.append("  u.code usercode,")
				.append("	       t.paymethod,                                                            ")
				.append("	       0 as tsellnum,                                                          ")
				.append("	       -ts.price as tsellprice,                                                        ")
				.append("	       0 as treturnnum,                                                        ")
				.append("	       0 as treturnprice,                                                      ")
				.append("   0 as dfcharges, ")
				.append("   0 as ylcharges, ")
				.append("	       0 inssellnum,                                                           ")
				.append("	       0 inssellprice,                                                 ")
				.append("		   0 insretrnnum, ")
				.append("		   0 insreturnprice ")
				.append(" ,0 servicefee")
				.append("	from ticketsell t ")
				.append("	left join userinfo u on t.sellby = u.id ,ticketchange tc,ticketsell ts")
				.append("	where 1 = 1                                                                    ")
				.append("	   and t.id=tc.newticketsellid and tc.oldticketsellid=ts.id and t.paymethod <> '0'  and ts.paymethod <> '0'    ")
				.append("	   and t.sellway not in ('7', '10')                                            ");
				detailsql.append(" and u.orgid =" +g.getOrganization().getId());
				if (isdeptdate) {
					detailsql.append(" and t.departdate ").append(datesql);
				}else {
					detailsql.append(" and t.selltime ").append(datesql);
				}
				if(!"".equals(operateUserIds)){
					detailsql.append(" and u.id in ").append(operateUserIds).append(" ");//售票员
				}
				detailsql.append(PropertyFilter.toJpql(propertyFilterList, true));
				
				// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑明细内层sql	↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑	
				
		// =============汇总外层sql		=============
		StringBuilder summarysql = new StringBuilder();
		summarysql.append(" select ");
				if (CommonUtil.isNotEmptyString(summaryway) && summaryway.equals("0")) { //支付方式汇总
					summarysql.append(" '' as selltime,username,usercode,  ");
					summarysql.append(" dit.value paymethod, ");
				}else if (CommonUtil.isNotEmptyString(summaryway) && summaryway.equals("1")) {//日期汇总
					summarysql.append(" to_char(s.selltime,'yyyy-MM-dd') selltime,username,usercode,  ");
					summarysql.append(" '' as paymethod, ");
				}else if (CommonUtil.isNotEmptyString(summaryway) && summaryway.equals("2")) {//支付方式和日期汇总
					summarysql.append(" to_char(s.selltime,'yyyy-MM-dd') selltime,username,usercode,  ");
					summarysql.append(" dit.value paymethod, ");
				}else {
					summarysql.append(" null as selltime ,username,usercode,  ");
					summarysql.append(" null paymethod, ");
				}
				summarysql.append(" ")
				.append(" sum(tsellnum),                                                       ")
				.append(" sum(tsellprice),                                                     ")
				.append(" sum(treturnnum),                                                     ")
				.append(" sum(treturnprice),                                                   ")
				.append(" sum(dfcharges), ")
				.append(" sum(ylcharges), ")
				.append(" sum(inssellnum),                                                     ")
				.append(" sum(inssellprice),                                                   ")
				.append(" sum(insretrnnum),                                                    ")
				.append(" sum(insreturnprice),                                                 ")
				.append(" sum(tsellprice+inssellprice-treturnprice-insreturnprice+servicefee) as total    ")
				.append(" ,sum(servicefee) AS servicefee")
				.append(" from (   ");
		summarysql.append(detailsql);
		summarysql.append(" )s ")
		.append(" left join digitaldictionary dig on dig.tablename = 'ticketsell' and dig.columnname = 'paymethod' ")
		.append(" left join digitaldictionarydetail dit on dit.digitaldictionaryid = dig.id and s.paymethod = dit.code ")
		.append(" where 1=1  ");
		if (CommonUtil.isNotEmptyString(summaryway) && summaryway.equals("0")) { //支付方式汇总
			summarysql.append(" group by dit.value,username,usercode ");
			summarysql.append(" order by  dit.value ");
		}else if (CommonUtil.isNotEmptyString(summaryway) && summaryway.equals("1")) {//日期汇总
			summarysql.append(" group by s.selltime,username,usercode ");
			summarysql.append(" order by s.selltime ");
		}else if (CommonUtil.isNotEmptyString(summaryway) && summaryway.equals("2")) {//日期汇总
			summarysql.append(" group by s.selltime,dit.value,username,usercode ");
			summarysql.append(" order by s.selltime, dit.value ");
		}else {//支付方式和日期汇总
			summarysql.append(" group by username,usercode ");
			summarysql.append(" order by username ");
		}
		Query query = getEntityManager().createNativeQuery(summarysql.toString());
//		System.out.println(summarysql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		return list;
	}
}
