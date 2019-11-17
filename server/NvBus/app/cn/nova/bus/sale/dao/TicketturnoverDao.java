package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.PropertyFilter.MatchType;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketturnoverDao extends EntityManagerDaoSurport {

	/**
	 * 查询售票员已缴款信息，用来重打缴款单
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList,Global global) {
		ParameterService parameterService = new ParameterServiceImpl();
		String billtypecode = parameterService.findParamValue("1102", global.getOrganization().getId());
		
		Date startdate = new Date();
		Date enddate = new Date();
		long userid = 0;
		for (PropertyFilter propertyFilter : propertyFilterList) {
			if ("t!receipttime".equals(propertyFilter.getPropertyFullName())&&propertyFilter.getMatchType().toString().equals(">="))
				startdate = (Date) propertyFilter.getMatchValue();
			if ("t!receipttime".equals(propertyFilter.getPropertyFullName())&&propertyFilter.getMatchType().toString().equals("<="))
				enddate = (Date) propertyFilter.getMatchValue();
			if ("t!seller".equals(propertyFilter.getPropertyFullName()))
				userid = (Long) propertyFilter.getMatchValue();
		}
		
	// 查询出ticketturnover缴款表中的所有字段，去掉CreateQuery方法使用对象查询sql
		StringBuffer sql = new StringBuffer();
		sql.append("select t.id,")
		.append("  nvl(td.neticketreturncharge, 0),")
	    .append("  nvl(td.neticketreturnmoney, 0),")
	    .append("  nvl(td.neticketreturnnum, 0),")
	    .append("  nvl(td.neticketreturnbacknum, 0),")
	    .append("  nvl(td.neticketreturnbackmoney, 0),")
	    .append("  nvl(td.neticketreturnbackcharge, 0),")
	    .append("  nvl(ttd.ieticketreturnnum, 0), ")
	    .append("  nvl(ttd.ieticketreturnmoney, 0), ")
	    .append("  nvl(ttd.ieticketreturncharge, 0), ")
	    .append("  nvl(ttd.iereturnbacknum, 0), ")
	    .append("  nvl(ttd.iereturnbackmoney, 0), ")
	    .append("  nvl(ttd.iereturnbackcharge, 0), ");
		
		sql.append(" t.bookservicefee,t.changeservicefee,t.cancelmoney,"
			+ "t.cancelnum,t.createby,t.createtime,t.eticketnum,t.insurecancelmoney,t.insurecancelnum,"
			+ "t.insurechargemoney,t.insurechargenum,t.insureeticketnum,t.insurenonvouchermoneypayable,"
			+ "t.insurereturnhandcharge,t.insurereturnmoney,t.insurereturnnum,t.insuresellmoney,t.insuresellnum,"
			+ "t.lastlost,t.lost,t.money,t.moneypayable,t.noncashmoney,t.noncashnum,t.nonvouchermoneypayable,"
			+ "t.receiptip,t.receiptorgid,t.receipttime,t.receiver,t.remarks,t.returnhandcharge,t.returnmoney,"
			+ "t.returnnum,t.seller,t.sellmoney,t.sellnum,t.servicefee,t.turnovertime,t.sellreturntripnum,t.returnprintnum,"
			+ "t.billdamagednum,t.stationservicefee,t.fueladditionfee,t.computefee,t.coolairfee,t.additionfee,t.waterfee,"
			+ "t.insurefee,t.otherfee,t.ticketstrike,t.insurstrike,"
			+ "t.ticketmoney,t.insuremoney,t.ticketmoneypayable,t.insuremoneypayable,t.balance, o.name as orgname,"
			+ "uso.name as receivername, ");
	
	sql.append(
			" us.name as sellername, us.code as code, u.name as createname, 0 as ischoose, ")
//			.append(" (select ti.moneydate from Ticketturnoverdetail ti where ti.id = ")
//			.append(" (select min(id) from Ticketturnoverdetail td ")
//			.append(" where td.ticketturnoverid=t.id )) as startmoneydate, ")
			.append(" nvl((select ti.moneydate from Ticketturnoverdetail ti  where ti.id = (select min(id) from Ticketturnoverdetail td where td.ticketturnoverid = t.id)),")
			.append(" (select ti.moneydate from insuranceturnoverdetail ti where ti.id = (select min(id) from insuranceturnoverdetail td where td.ticketturnoverid = t.id))) as startmoneydate,")
//			.append(" (select ti.ticketstartno from Ticketturnoverdetail ti where ti.id = ")
//			.append(" (select min(id) from Ticketturnoverdetail td ")
//			.append(" where td.ticketturnoverid=t.id )) as startticketno, ")
			.append("  nvl((select ti.ticketstartno from Ticketturnoverdetail ti where ti.id = (select min(id)  from Ticketturnoverdetail td where td.ticketturnoverid = t.id)),")
			.append(" (select ti.ticketstartno  from insuranceturnoverdetail ti where ti.id = (select min(id)  from insuranceturnoverdetail td  where td.ticketturnoverid = t.id))) as startticketno,")
//			.append(" (select ti.moneydate from Ticketturnoverdetail ti where ti.id = ")
//			.append(" (select max(id) from Ticketturnoverdetail td ")
//			.append(" where td.ticketturnoverid=t.id )) as endmoneydate, ")
			.append(" nvl((select ti.moneydate from Ticketturnoverdetail ti where ti.id = (select max(id) from Ticketturnoverdetail td where td.ticketturnoverid = t.id)),")
			.append("  (select ti.moneydate from insuranceturnoverdetail ti where ti.id = (select max(id) from insuranceturnoverdetail td  where td.ticketturnoverid = t.id))) as endmoneydate,")
//			.append(" (select ti.ticketendno from Ticketturnoverdetail ti where ti.id = ")
//			.append(" (select max(id) from Ticketturnoverdetail td ")
//			.append(" where td.ticketturnoverid=t.id )) as endticketno,")
			.append("  nvl((select ti.ticketendno from Ticketturnoverdetail ti where ti.id = (select max(id) from Ticketturnoverdetail td where td.ticketturnoverid = t.id)),")
			.append(" (select ti.ticketendno from insuranceturnoverdetail ti where ti.id = (select max(id) from insuranceturnoverdetail td where td.ticketturnoverid = t.id))) as endticketno,")
			.append("  (t.sellmoney -t.stationservicefee) as nostationfeemoney, ")
			.append("nsellnum,nsellmoney,nreturnnum,nreturnmoney,nreturnhandcharge,")
			.append("nreturtotalnnum,nreturntotalmoney,nreturnhandtotalcharge,ninsuresellnum,")
			.append("ninsuresellmoney,ninsurenoncashnum,ninsurenoncashmoney,ninsurereturnnum,")
			.append("ninsurereturnmoney,ninsurereturntotalnum,ntinsurereturntotalmoney,neticketpayable ")
			//电子应缴款=电子票应缴款+电子保险应缴款 ，
			.append(" ,(td.tnoncashmoneypayable+ttd.inoncashmoneypayable)totalpayable, ")
			//车票现金应缴款 
			.append(" td.tcashmoneypayable ticketcashmoneypayable, ")
			//保险现金应缴
			.append(" ttd.icashmoneypayable insurecashmoneypayable, ")
			//保险电子应缴
			.append(" ttd.inoncashmoneypayable insurenocashmoneypayable ")
		    
			.append(" from Ticketturnover t ")
			.append("   left join ")
		    .append("   (select td.ticketturnoverid,td.seller,")
		    .append("      sum(td.sellnum-td.noncashnum) nsellnum,")
		    .append("      sum(td.sellmoney-td.noncashmoney) nsellmoney,")
		    .append("      sum(td.returnnum - td.eticketreturnnum-td.eticketreturnbacknum) nreturnnum,")
		    .append("      sum(td.returnmoney - td.eticketreturnmoney-td.eticketreturnbackmoney) nreturnmoney,")
		    .append("      sum(td.returnhandcharge - td.eticketreturncharge-td.eticketreturnbackcharge) nreturnhandcharge,")
		    .append("      sum(td.returnnum-td.eticketreturnbacknum) nreturtotalnnum,")
		    .append("      sum(td.returnmoney-td.eticketreturnbackmoney) nreturntotalmoney,")
		    .append("      sum(td.returnhandcharge-td.eticketreturnbackcharge) nreturnhandtotalcharge,")
		    .append("   sum(td.noncashmoney-td.eticketreturnbackmoney+td.eservicefee+td.ebookservicefee+td.echangeservicefee) neticketpayable,")
		    .append("   sum(td.noncashmoneypayable) tnoncashmoneypayable, ")
		    .append("   sum(td.moneypayable -td.noncashmoneypayable) tcashmoneypayable ")
		    
		    .append("  , sum(eticketreturncharge) neticketreturncharge,")
		    .append("  sum(eticketreturnmoney) neticketreturnmoney,")
		    .append("  sum(eticketreturnnum) neticketreturnnum,")
		    .append("  sum(eticketreturnbacknum) neticketreturnbacknum,")
		    .append("  sum(eticketreturnbackmoney) neticketreturnbackmoney,")
		    .append("  sum(eticketreturnbackcharge) neticketreturnbackcharge")
		     
		    .append("      from Ticketturnoverdetail td where td.turnovertime between :startdate and :enddate   ");
		    if(userid>0){
				sql.append(" and td.seller ="+userid);
			}
		    sql.append("     group by td.ticketturnoverid,td.seller) td on td.ticketturnoverid = t.id and td.seller = t.seller")
		    .append("   left join (select ttd.ticketturnoverid,ttd.seller,")
		    .append("   sum(ttd.sellnum - ttd.noncashnum) ninsuresellnum,sum(ttd.sellmoney - ttd.noncashmoney) ninsuresellmoney,")
		    .append("   sum(ttd.noncashnum) ninsurenoncashnum,sum(ttd.noncashmoney) ninsurenoncashmoney,")
		    .append("   sum(ttd.returnnum - ttd.ereturnnum-ttd.ereturnbacknum) ninsurereturnnum,sum(ttd.returnmoney - ttd.ereturnmoney-ttd.ereturnbackmoney) ninsurereturnmoney,")
		    .append("   sum(ttd.returnnum-ttd.ereturnbacknum) ninsurereturntotalnum, sum(ttd.returnmoney-ttd.ereturnbackmoney) ntinsurereturntotalmoney,")
		    .append("   sum(ttd.noncashmoneypayable) inoncashmoneypayable, ")
		    .append("   sum(ttd.moneypayable -ttd.noncashmoneypayable) icashmoneypayable ")
		    
		    .append("  , sum(ereturnnum) ieticketreturnnum, ")
		    .append("  sum(ereturnmoney) ieticketreturnmoney, ")
		    .append("  0 ieticketreturncharge, ")
		    .append("  sum(ereturnbacknum) iereturnbacknum, ")
		    .append("  sum(ereturnbackmoney) iereturnbackmoney, ")
		    .append("  0 as iereturnbackcharge ")
		    
		    .append("    from insuranceturnoverdetail ttd where ttd.turnovertime between :startdate and :enddate ");
		    if(userid>0){
		    	sql.append(" and ttd.seller ="+userid);
		    }
		    sql.append("  group by ttd.ticketturnoverid,ttd.seller) ttd on ttd.ticketturnoverid = t.id and ttd.seller = t.seller")
			.append(" , Userinfo us, Organization o, Userinfo u, Userinfo uso  ")
			.append(" where t.receiptorgid=o.id and t.createby=u.id and t.seller=us.id ")
			.append(" and t.receiver=uso.id ");
		if(userid>0){
			sql.append(" and t.seller ="+userid);
		}
		sql.append(" and t.receipttime between :startdate and :enddate");
//		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.receipttime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		
		StringBuffer sql1 = new StringBuffer("select tid, sum(ticketallnum), sum(price) from (select td.id, t . id tid,");
		if(billtypecode.equals("Ticket")){
			sql1.append("(td.sellnum+td.sellreturntripnum+td.returnprintnum+td.billdamagednum+td.eticketnum)  ticketallnum,");
		}else{
			sql1.append("(td.sellnum+td.sellreturntripnum+td.billdamagednum+td.eticketnum)  ticketallnum,");
		}
		sql1.append(" sum (nvl(ts.price,0)) price from ticketturnoverdetail td left join ticketsellother tso on td.seller = tso.printby");
		if(userid>0){
			sql1.append("  and tso.printby = "+userid);
		}
		sql1.append(" left join ticketsell ts on ts. id = tso.ticketsellid and ts.ticketno between td.ticketstartno")
			.append(" and td.ticketendno,ticketturnover t where td.ticketturnoverid = t . id");
		sql1.append(PropertyFilter.toJpql(propertyFilterList, true))
			.append(" group by td.id, t . id, ");
		if(billtypecode.equals("Ticket")){
			sql1.append("(td.sellnum+td.sellreturntripnum+td.returnprintnum+td.billdamagednum+td.eticketnum)");
		}else{
			sql1.append("(td.sellnum+td.sellreturntripnum+td.billdamagednum+td.eticketnum)");
		}
		sql1.append(" ) group by tid");
		query = getEntityManager().createNativeQuery(sql1.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list2 =  query.getResultList();
		
		
		List<Object> reslist = new ArrayList<Object>();
		for (Object object : list) {
			Object[] obj1 = (Object[]) object;
			Object[] objlist = new Object[obj1.length+2];
			for (int i=0 ; i<obj1.length;i++) {
				objlist[i] = obj1[i];
			}
			for (Object object2 : list2) {
				Object[] obj2 = (Object[]) object2;
//				Ticketturnover ticketturnover = (Ticketturnover) obj1[0];
				if(Long.parseLong(obj1[0].toString())==((BigDecimal)obj2[0]).longValue()){
					objlist[objlist.length-1] =obj2[1];
					objlist[objlist.length-2] =obj2[2];
				}
			}
			reslist.add(objlist);
		}
		
		return reslist;
	}

	/**
	 * 日营收单数据查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Object> queryRevenueOfDay(Long billtypeid,
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		Date startDate = null;
		Date endDate = null;
		String userids = null;
		//(汽车票日营收单)
		if (billtypeid==1L) {
			if(null != propertyFilterList && propertyFilterList.size()> 0 ){
				for(PropertyFilter pf :propertyFilterList){
					pf.getMatchType();
					if("moneydate".equalsIgnoreCase(pf.getPropertyName()) && pf.getMatchType().equals(MatchType.GE)){
						startDate = (Date)pf.getMatchValue();
					}
					if("moneydate".equalsIgnoreCase(pf.getPropertyName()) &&pf.getMatchType().equals(MatchType.LE)){
						endDate = (Date)pf.getMatchValue();
					}
					if (pf.getPropertyFullName().equals("tt!userid")) {
						userids = pf.getMatchValue().toString().replace("(", "").replace(")", "");
					}
				}
			}
			sql.append("select tt.userid,tt.code,tt.name,sum(tt.ticketnum),sum(tt.sellnum),sum(tt.sellmoney),sum(tt.returnnum),sum(tt.returnmoney),sum(tt.cancelnum),")
					.append(" sum(tt.handcharge),sum(tt.changeservicefee),sum(tt.sellnum-tt.returnnum-tt.cancelnum) realsellnum,sum(tt.nonvouchermoneypayable),sum(tt.revenuemoneypayable),sum(tt.moneypayable),sum(tt.strike),sum(tt.money),min(tt.ticketstartno),max(tt.ticketendno),")
					.append(" sum((case when tt.lost>0 then tt.lost else 0.00 end)) longlost,sum((case when tt.lost<0 then tt.lost else 0.00 end)) shortlost, sum(tt.balance) balance ")
					.append("  from (")
					.append("select tdd.moneydate moneydate, ")
					.append(" u.id userid,u.code code,u.name name,")
					.append(" sum( tdd.ticketnum) ticketnum, ")
					.append(" sum(t.sellnum) sellnum,sum(t.sellmoney) sellmoney,sum(t.returnnum) returnnum,sum(t.returnmoney+t.returnhandcharge) returnmoney,sum(t.cancelnum) as cancelnum,")
					.append(" sum(t.returnhandcharge) handcharge,sum(t.changeservicefee) changeservicefee, sum(t.nonvouchermoneypayable) nonvouchermoneypayable,")
					.append(" sum(t.ticketmoneypayable+t.ticketstrike) revenuemoneypayable,sum(t.ticketmoneypayable) moneypayable,sum(t.ticketstrike) strike,sum(t.ticketmoney) money,")
					.append(" min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno")
					.append(" ,sum(t.lost) lost,sum(balance) balance")
					.append(" from Ticketturnover t ")
					.append(" LEFT JOIN (select td.moneydate moneydate,td.ticketturnoverid")
					.append(" ,MIN(td.ticketstartno) ticketstartno, MAX(td.ticketendno) ticketendno")
					//退票凭证数和坏票登记数和改签凭证数和补票凭证数
					.append(" ,sum(nvl(td.returnprintnum,0))+sum(nvl(td.billdamagednum,0))+sum(nvl(td.changeprintnum,0))+sum(nvl(td.supplementprintnum,0)) ticketnum")
					.append(" from Ticketturnoverdetail td ")
					//单独查询自助机售票数-begin-20160721-bug:1654
//					.append(" LEFT JOIN ( SELECT COUNT(DISTINCT ts.id) tickets,TRUNC(ts.selltime) selltime,ts.sellby sellby,MIN(ts.ticketno) minticketno,MAX(ts.ticketno) maxticketno")
//					.append(" FROM  ticketsell ts where ts.sellway='10' AND ts.selltime BETWEEN :startDate AND :endDate +0.99999")
//					.append(" GROUP BY ts.sellby,TRUNC(ts.selltime))ts ON td.seller = ts.sellby AND ts.selltime = td.moneydate ")
					//单独查询自助机售票数-end-20160721-bug:1654
					.append(" where  td.ticketturnoverid is not null ")
					.append(" and td.moneydate BETWEEN :startDate AND :endDate +0.99999 ")
					.append(" group by td.ticketturnoverid,td.moneydate) tdd ")
					.append(" on t.id=tdd.ticketturnoverid left join Userinfo u  on t.seller = u.id")
					.append(" group by tdd.moneydate,u.id,u.code,u.name,t.lost ")
					.append(" union all ")
					.append(" select ti.moneydate moneydate,us.id userid,us.code code,us.name name,")
					//退票凭证数和坏票登记数和改签凭证数和补票凭证数
					.append(" sum(nvl(ti.returnprintnum,0))+sum(nvl(ti.billdamagednum,0))+sum(nvl(ti.changeprintnum,0))+sum(nvl(ti.supplementprintnum,0)) ticketnum")
					.append(" ,sum(ti.sellnum) as sellnum,sum(ti.sellmoney) as sellmoney,sum(ti.returnnum) as returnnum,sum(ti.returnmoney+ti.returnhandcharge) as returnmoney,sum(ti.cancelnum) as cancelnum,")
					.append(" sum(ti.returnhandcharge) as handcharge,sum(ti.changeservicefee) as changeservicefee, sum(ti.nonvouchermoneypayable) nonvouchermoneypayable,")
					.append(" sum(ti.moneypayable) as revenuemoneypayable,sum(ti.moneypayable) as moneypayable,0.00 strike,0.00 money")
					.append(" ,MIN(ti.ticketstartno) ticketstartno, MAX(ti.ticketendno) ticketendno")
					.append(" ,0.00 lost,0.00 balance ")
					.append(" from Ticketturnoverdetail ti")
					//单独查询自助机售票数-begin-20160721-bug:1654
//					.append(" LEFT JOIN ( SELECT COUNT(DISTINCT ts.id) tickets,TRUNC(ts.selltime) selltime,ts.sellby sellby,MIN(ts.ticketno) minticketno,MAX(ts.ticketno) maxticketno")
//					.append(" FROM ticketsell ts where ts.sellway='10' AND ts.selltime BETWEEN :startDate AND :endDate +0.99999")
//					.append(" GROUP BY ts.sellby,TRUNC(ts.selltime))ts ON ti.seller = ts.sellby AND ti.moneydate=ts.selltime")
					//单独查询自助机售票数-end-20160721-bug:1654
					.append(" ,Userinfo us")
					.append(" where ti.seller=us.id and ti.ticketturnoverid is null  ")
					.append(" and ti.moneydate BETWEEN :startDate AND :endDate +0.99999 ")
					.append(" group by us.id,ti.moneydate,us.code,us.name ")
					//窗口非电子票用票张数
					.append(" 		union all                                          ")
					.append(" 		 select trunc(ts.selltime) moneydate,              ")
					.append("          u.id userid,                                    ")
					.append("          u.code code,                                    ")
					.append("          u.name name,                                    ")
					.append("          count(ts.id) ticketnum,                                    ")
					.append("          0 sellnum,0 sellmoney0	,0 AS returnnum0	, 0 AS returnmoney,0 AS cancelnum,0 AS handcharge,0 AS changeservicefee, 0 AS nonvouchermoneypayable ")
					.append(" 		,0 AS revenuemoneypayable, 0 AS moneypayable, 0.00 AS strike, 0.00 AS money	,  min(ts.ticketno) AS ticketstartno, max(ts.ticketno) AS ticketendno ")
					.append(" 		, 0.00 AS lost, 0.00 AS balance                                                       ")
					.append(" 		  from ticketsell ts,userinfo u where 1=1 and u.id = ts.sellby                        ")
					.append(" 		  and ts.selltime BETWEEN :startDate AND :endDate +0.99999 ")
					.append(" 		  and not exists (select * from ticketsellother tso where tso.ticketsellid = ts.id)   ");
					if (userids!=null) {
						sql.append(" and ts.sellby in (").append(userids).append(" ) ");
					}
					sql.append("  group by trunc(ts.selltime),u.id,u.code,u.name    ")
						.append(" 		  union all                                                                           ")
					//电子票网售自助机已取数 
					.append(" 		  SELECT                                                                              ")
					.append(" 		  decode(tso.taketime ,null,trunc(tso.updatetime),trunc(tso.taketime))moneydate,      ")
					.append(" 		  decode(pu.id,null,u.id,pu.id) userid,                                               ")
					.append(" 		  decode(pu.id,null,u.code,pu.code) code,                                             ")
					.append(" 		  decode(pu.id,null,u.name,pu.name) name,                                             ")
					.append(" 		  count(ts.id) ticketnum,                                                                        ")
					.append(" 			0 sellnum,0 sellmoney0	,0 AS returnnum0	, 0 AS returnmoney,0 AS cancelnum,0 AS handcharge,0 AS changeservicefee, 0 AS nonvouchermoneypayable ")
					.append(" 				,0 AS revenuemoneypayable, 0 AS moneypayable, 0.00 AS strike, 0.00 AS money	,min(ts.ticketno) AS ticketstartno, max(ts.ticketno) AS ticketendno ")
					.append(" 				, 0.00 AS lost, 0.00 AS balance                              ")
					.append(" 		 from ticketsell ts,ticketsellother tso                              ")
					.append(" 		 left join userinfo u on u.id = tso.updateby                         ")
					.append(" 		 left join userinfo pu on pu.id = tso.printby                        ")
					.append(" 		where tso.ticketsellid = ts.id                                       ")
					.append("     and tso.istaked =1                                                     ")
					.append("     and ((tso.taketime is not null and tso.taketime BETWEEN :startDate AND :endDate +0.99999 ) or   ")
					.append("     (tso.taketime is null and tso.updatetime BETWEEN :startDate AND :endDate +0.99999))             ");
					if (userids!=null) {
						sql.append(" and ((pu.id is null and u.id in (").append(userids).append(" )) or  ")
							.append(" (pu.id is not null and pu.id in (").append(userids).append(" )) ) ");
					}
					sql.append("group by decode(tso.taketime, NULL, trunc(tso.updatetime), trunc(tso.taketime)),decode(pu.id, NULL, u.id, pu.id), ")
						.append(" decode(pu.id, NULL, u.code, pu.code),decode(pu.id, NULL, u.name, pu.name) ");
					sql.append(") tt where 1=1 "+PropertyFilter.toJpql(propertyFilterList, true))
					.append(" group by tt.userid,tt.code,tt.name order by tt.code");
		}else if(billtypeid==3L){//(保险票日营收单)
			sql.append("select tt.userid,tt.code,tt.name,sum(tt.ticketnum),sum(tt.sellnum),sum(tt.sellmoney),sum(tt.returnnum),sum(tt.returnmoney),sum(tt.cancelnum),")
					.append(" sum(tt.handcharge),sum(tt.changeservicefee),sum(tt.sellnum-tt.returnnum) realsellnum,sum(tt.nonvouchermoneypayable),sum(tt.revenuemoneypayable),sum(tt.moneypayable),sum(tt.strike),sum(tt.money),min(tt.ticketstartno),max(tt.ticketendno),0.00 longlost,0.00 shortlost,0.00 balance from (")
					.append("select nvl(tdd.moneydate,tdll.moneydate) moneydate, ")
					.append(" u.id userid,u.code code,u.name name,")
					.append(" sum(t.insuresellnum+t.insureeticketnum ) ticketnum,")
					.append(" sum(t.insuresellnum) sellnum,sum(t.insuresellmoney) sellmoney,sum(t.insurereturnnum) returnnum,sum(t.insurereturnmoney+t.insurereturnhandcharge) returnmoney,sum(t.insurecancelnum) as cancelnum,")
					.append(" sum(t.insurereturnhandcharge) handcharge,0.00 changeservicefee, sum(t.insurenonvouchermoneypayable) nonvouchermoneypayable,")
					.append(" sum(t.insuremoneypayable+t.insurstrike) revenuemoneypayable,sum(t.insuremoneypayable) moneypayable,sum(t.insurstrike) strike,sum(t.insuremoney) money,")
					.append(" min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno ")
					.append(" from Ticketturnover t ")
					.append(" left join (select distinct tdl.ticketturnoverid,tdl.moneydate from ticketturnoverdetail tdl) tdll on tdll.ticketturnoverid=t.id ")
					.append(" left join (select td.moneydate moneydate,td.ticketturnoverid,min(td.ticketstartno) ticketstartno,max(td.ticketendno) ticketendno")
					.append("  from insuranceturnoverdetail td where  td.ticketturnoverid is not null group by td.ticketturnoverid,td.moneydate) tdd ")
					.append(" on t.id=tdd.ticketturnoverid left join Userinfo u  on t.seller = u.id")
					.append(" group by tdd.moneydate,tdll.moneydate,u.id,u.code,u.name ")
					.append(" union all ")
					.append(" select ti.moneydate moneydate,us.id userid,us.code code,us.name name,")
					.append(" (sum(ti.sellnum) + sum(ti.eticketnum)) ticketnum,")
					.append(" sum(ti.sellnum) as sellnum,sum(ti.sellmoney) as sellmoney,sum(ti.returnnum) as returnnum,sum(ti.returnmoney+ti.returnhandcharge) as returnmoney,sum(ti.cancelnum) as cancelnum,")
					.append(" sum(ti.returnhandcharge) as handcharge,0.00 changeservicefee, sum(ti.nonvouchermoneypayable) nonvouchermoneypayable,")
					.append(" sum(ti.moneypayable) as revenuemoneypayable,sum(ti.moneypayable) as moneypayable,0.00 strike,0.00 money,min(ti.ticketstartno) ticketstartno,max(ti.ticketendno) ticketendno ")
					.append(" from insuranceturnoverdetail ti,Userinfo us")
					.append(" where ti.seller=us.id and ti.ticketturnoverid is null group by us.id,ti.moneydate,us.code,us.name")
					.append(") tt where 1=1 "+PropertyFilter.toJpql(propertyFilterList, true))
					.append(" group by tt.userid,tt.code,tt.name order by tt.code");
		}
		else{return null;}
		//System.out.println("billtypeid="+billtypeid+"日营收单sql -->"+sql.toString());
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if(billtypeid == 1L){
			query.setParameter("startDate", startDate);
			query.setParameter("endDate", endDate);
		}
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	/**
	 * 根据缴款ID，获取多号段起止票号，拼成一个串到前端显示
	 * 
	 * 
	 * @author liyi
	 */
	public String getTicketnoStartAndEnd(long id)
	{
		String result = "";
		StringBuffer sb = new StringBuffer(" select td.ticketstartno,td.ticketendno  ");
		sb.append(" from ticketturnoverdetail td,ticketturnover t ");
		sb.append(" where td.ticketturnoverid = t.id ");
		sb.append(" and t.id="+id);
		Query query = getEntityManager().createNativeQuery(sb.toString());
		List<Object> ticketnolist = query.getResultList();
		//获取所有的缴款起止票号段（包括一个票号段和多个票号段）
		for(int i=0;i<ticketnolist.size();i++)
		{
			Object[] obj = (Object[])ticketnolist.get(i);
			String ticketnotem = obj[0]+"-"+obj[1];
			result+=ticketnotem+"  ";
			
		}
		return result;
	}
	
	
	/**
	 * 根据缴款ID，获取缴款的信息，用来打印缴款单
	 * 
	 * @param id
	 * @param returnticketno
	 * @param cancelticketno
	 * @param damagedticketno
	 * @param returninsureno
	 * @param cancelinsureno
	 * @param damagedinsureno
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketturnover(long id) {
		/*List<Object> startinfo = getTicketStartInfo(id);
		List<Object> endinfo = getTicketEndInfo(id);
		Object[] startobj = null;
		Object[] endobj = null;
		if (startinfo != null) {
			startobj = (Object[]) startinfo.get(0);
		}
		if (endinfo != null) {
			endobj = (Object[]) endinfo.get(0);
		}*/
		StringBuffer sql = new StringBuffer("select  ");
		sql.append(" t.id, t.turnovertime, t.seller, t.money, ")
		.append(" t.lastlost, t.lost, t.moneypayable, t.receiver, ")
		.append(" t.receipttime, t.receiptorgid, t.receiptip, t.remarks, ")
		.append(" t.sellnum, t.sellmoney, t.returnnum, t.returnmoney, ")
		.append(" t.returnhandcharge, t.cancelnum, t.noncashnum, t.noncashmoney, ")
		.append(" t.eticketnum, t.insuresellnum, t.insuresellmoney, t.insurereturnnum, ")
		.append(" t.insurereturnmoney, t.insurereturnhandcharge, t.insurecancelnum, t.insurechargenum, ")
		.append(" t.insurechargemoney,t.insureeticketnum, t.createtime, t.createby, ")
		.append(" t.servicefee, t.bookservicefee, t.cancelmoney, t.insurecancelmoney, ")
		.append(" t.insurenonvouchermoneypayable, t.nonvouchermoneypayable, t.changeservicefee, t.sellreturntripnum, ")
		.append(" t.returnprintnum, t.billdamagednum, t.stationservicefee, t.fueladditionfee, ")
		.append(" t.computefee, t.coolairfee, t.additionfee, t.waterfee, ")
		.append(" t.insurefee, t.otherfee, t.insurstrike, t.ticketstrike, ")
		.append(" t.ticketmoney,t.insuremoney, t.ticketmoneypayable, t.insuremoneypayable, ")
		.append(" t.balance, ")
		.append(" use.name as receivername, o.name as orgname, us.name as sellername, ")
				.append(" u.name as createname, us.code, ")
		/*if (startobj == null) {
			sql.append(" null as startmoneydate, '").append(
					"").append("' as startticketno, ");
		} else {
			sql.append("trim('").append(startobj[0]).append("') as startmoneydate, ").append(
					"trim('").append(startobj[1]).append("') as startticketno, ");
		}
		if (endinfo == null) {
			sql.append(" null as endmoneydate, '").append(
					"").append("' as endticketno ");
		} else {
			sql.append("trim('").append(endobj[0]).append("') as endmoneydate,").append(
					"trim('").append(endobj[1]).append("') as endticketno ");
		}*/
		.append(" nvl((select ti.moneydate from Ticketturnoverdetail ti where ti.id = ")
		.append(" (select min(id) from Ticketturnoverdetail td ")
		.append(" where td.ticketturnoverid=t.id )),tt.insurancestartdate) as startmoneydate, ")
		.append(" nvl((select ti.ticketstartno from Ticketturnoverdetail ti where ti.id = ")
		.append(" (select min(id) from Ticketturnoverdetail td ")
		.append(" where td.ticketturnoverid=t.id )),tt.ticketstartno) as startticketno, ")
		.append(" nvl((select ti.moneydate from Ticketturnoverdetail ti where ti.id = ")
		.append(" (select max(id) from Ticketturnoverdetail td ")
		.append(" where td.ticketturnoverid=t.id )),insuranceenddate) as endmoneydate, ")
		.append(" nvl((select ti.ticketendno from Ticketturnoverdetail ti where ti.id = ")
		.append(" (select max(id) from Ticketturnoverdetail td ")
		.append(" where td.ticketturnoverid=t.id )),tt.endticketno) as endticketno,");
		
		
		sql.append(" nvl(precount,0) as precount, nvl(preprice,0)as preprice ");
		//9053 【呼运总站】营收缴款：缴款打印时保险起始票号和保险结束票号没有打印数据
		sql.append("  ,(select ti.ticketstartno from insuranceturnoverdetail ti where ti.id = (  ");
		sql.append(" select min(id) from insuranceturnoverdetail td where td.ticketturnoverid = t.id)) as insurancestartno, ");
		sql.append(" (select ti.ticketendno from insuranceturnoverdetail ti where ti.id = ( ");
		sql.append(" select max(id) from insuranceturnoverdetail td where td.ticketturnoverid = t.id)) as insuranceendno ");
		sql.append(" from Ticketturnover t ")
		.append(" left join  (select  tt.ticketturnoverid, sum(tt.moneypayable) as insuremoneypayable,")
		.append("     (sum(tt.moneypayable)-sum(tt.noncashmoney)) as insurecashmoneypayable,")
		.append("     sum(tt.noncashmoney) as insurenoncashmoney, min(tt.moneydate) insurancestartdate ,")
		.append("     max(tt.moneydate) insuranceenddate , min(tt.ticketstartno) ticketstartno, max(tt.ticketendno) endticketno,")
		.append("     sum(nvl(tt.sellnum,0)) sellnum")
		.append("       from   Insuranceturnoverdetail tt group by tt.ticketturnoverid ) tt")
		.append("        on t.id=tt.ticketturnoverid")		
		.append("  left join (select ts.sellby, COUNT(ts.id) precount, sum(ts.price) preprice")
		.append("  from Ticketsell ts, Ticketturnoverdetail td")
		.append(" where ts.turnoverdetailid = td.id  and td.seller = td.seller")
		.append(" and ts.selltime < ts.departdate and td.ticketturnoverid="+id)
		.append(" group by ts.sellby) ts on t.seller=ts.sellby ,");
		sql.append(" Userinfo us, Organization o, Userinfo u, Userinfo use ")
		.append(" where t.receiver=use.id and ");
		sql.append(" t.receiptorgid=o.id and t.createby=u.id and t.seller=us.id and t.id= ");
		sql.append(id);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> ll = query.getResultList();
		Object[] preObj=null;
		if(ll!=null&&ll.size()>0){
		   preObj = (Object[]) ll.get(0);
		   /*
			 * @author liyi
			 * @20151104 获取网购票号和废票号来添加到营收缴款统计表中
			 */
			StringBuffer sql1 = new StringBuffer("select t.id,ts.ticketno as ticketnoOnline,ts1.ticketno as ticketnoCancel");
			sql1.append("   from ticketturnover       t, ");
			sql1.append("  ticketturnoverdetail td ");
			sql1.append(" left join ticketsell      ts on td.id = ts.turnoverdetailid and ts.sellway ='7' ");
			sql1.append(" left join ticketcancel    tc on td.id = tc.turnoverdetailid");
			sql1.append(" left join ticketsell      ts1 on tc.sellid = ts1.id ");
			sql1.append("  where td.ticketturnoverid = t.id  and t.seller = ts.sellby");
			sql1.append(" and t.id="+id);
		
			query = getEntityManager().createNativeQuery(sql1.toString());
			List<Object> list =  query.getResultList();
			StringBuffer ticketnoOnline = new StringBuffer(" ");
			StringBuffer ticketnoCancel = new StringBuffer(" ");
			if(list!=null && list.size()>0){
				for(int i =0;i<list.size();i++)
				{
					Object[] obj = (Object[]) list.get(i);
					if(obj[1]!=null)
					ticketnoOnline.append(obj[1]+",");
					if(obj[2]!=null)
					ticketnoCancel.append(obj[2]+",");
				}
			}
			Object[] allobj = new Object[preObj.length+3];//定义一个数组来存储所有的显示数据
			for(int i =0;i<preObj.length;i++)
			{
				allobj[i]=preObj[i];
			}
			allobj[allobj.length-3]=ticketnoOnline.substring(0, ticketnoOnline.length()-1);
			allobj[allobj.length-2]=ticketnoCancel.substring(0, ticketnoCancel.length()-1);
			allobj[allobj.length-1]=getTicketnoStartAndEnd(id);  //新增显示的起止票号段
			List<Object> reslist = new ArrayList<Object>();
			reslist.add(allobj);
			return reslist;
		}else{
			return null;
		}
		
	}
		
	/**
	 * 通过缴款ID来获取缴款的开始日期、开始票号
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<Object> getTicketStartInfo(long id) {
		StringBuilder sql = new StringBuilder(
				" select ti.moneydate, ti.ticketstartno ")
				.append(" from Ticketturnoverdetail ti where ti.id = (select min(id)")
				.append(" from Ticketturnoverdetail t where t.ticketturnoverid=:id)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		List<Object> list = query.getResultList();
		if (list.size() <= 0) {
			sql = new StringBuilder(
					" select ti.moneydate, ti.ticketstartno ")
					.append(" from Insuranceturnoverdetail ti where ti.id = (select min(id)")
					.append(" from Insuranceturnoverdetail t where t.ticketturnoverid=:id)");
			query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("id", id);
			if (query.getResultList().size() <= 0) {
				return null;
			}else {
				return query.getResultList();
			}
		}
		return list;
	}

	/**
	 * 通过缴款ID来获取缴款的结束日期、结束票号
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<Object> getTicketEndInfo(long id) {
		StringBuilder sql = new StringBuilder(
				" select ti.moneydate, ti.ticketendno ")
				.append(" from Ticketturnoverdetail ti where ti.id = (select max(id)")
				.append(" from Ticketturnoverdetail t where t.ticketturnoverid=:id)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		List<Object> list = query.getResultList();
		if (list.size() <= 0) {
			sql = new StringBuilder(
					" select ti.moneydate, ti.ticketendno ")
					.append(" from Insuranceturnoverdetail ti where ti.id = (select max(id)")
					.append(" from Insuranceturnoverdetail t where t.ticketturnoverid=:id)");
			query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("id", id);
			if (query.getResultList().size() <= 0) {
				return null;
			}else {
				return query.getResultList();
			}
		}
		return list;
	}

	public long getMaxId() {
		StringBuffer sql = new StringBuffer(
				"select max(t.id) from Ticketturnoverdetail t ");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryTicket(long seller) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketturnover t where t.id=");
		sql.append("(select max(ti.id) from Ticketturnover ti where ti.seller=");
		sql.append(seller);
		sql.append(")");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	/**
	 * 根据缴款ID，获取售票员缴款金额
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTurnovermoney(
			List<PropertyFilter> buildFromHttpRequest) {
		StringBuffer sql = new StringBuffer(
				"select sum(t.money) as turnovermoney from Ticketturnover t where 1=1 ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}

	/**
	 * @param moneydate
	 * @param seller
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketsell(Date moneydate, long seller) {
		StringBuilder sql = new StringBuilder();
		// sql.append("Select u.Name||'('||u.code||')', Decode(a.Money, Null, 0, a.Money) Money, decode(a.Lost,Null,0,a.lost) lost, decode(a.Lastlost,Null,0,a.lastlost) lastlost,b.Moneypayable")
		// .append(" From (Select tmin.Lastlost,tmax.lost,a.seller,a.money ")
		// .append("         From Ticketturnover tmin ,Ticketturnover tmax,")
		// .append("              (Select t.Seller, Sum(t.Money) Money ,Min(t.id) As minid,Max(t.id) As maxid ")
		// .append("				 From Ticketturnover t ")
		// .append("			    Where Exists (Select Td.Ticketturnoverid ")
		// .append("								From Ticketturnoverdetail Td ")
		// .append("								Where Td.Moneydate Between :moneydate_begin And :moneydate_end")
		// .append("                                 And t.Id=Td.ticketturnoverid ")
		// .append("                              )  ")
		// .append("                        Or (Not Exists (Select Td.Ticketturnoverid  ")
		// .append("				    			           From Ticketturnoverdetail Td ")
		// .append("                                         Where t.Id=td.ticketturnoverid) ")
		// .append("                           And t.turnovertime  Between :moneydate_begin And :moneydatetime_end ")
		// .append("                           )  ")
		// .append("				Group By t.Seller ")
		// .append("              ) a ")
		// .append("         Where tmin.Id=a.minid And tmax.Id=a.maxid  ")
		// .append("	  ) a ")
		// .append("      Right Join (Select td.seller, Sum(Td.Moneypayable - Td.Nonvouchermoneypayable) Moneypayable ")
		// .append("				    From Ticketturnoverdetail Td ")
		// .append("				   Where Td.Moneydate Between :moneydate_begin And :moneydate_end")
		// .append("				   Group By td.seller) b	On a.seller = b.seller ")
		// .append("      Join Userinfo u On b.seller=u.Id");

		sql.append("Select u.Name||'('||u.code||')',")
				.append("       decode(b.money,Null,0,b.money) money,")
				.append("       a.Moneypayable_before-decode(b.Money_before,Null,0,b.Money_before)+a.Moneypayable-decode(b.money,Null,0,b.money) lost,")
				.append("       a.Moneypayable_before-decode(b.Money_before,Null,0,b.Money_before) lastlost,a.Moneypayable")
				.append(" From")
				.append("      (Select ttd.seller,")
				.append("              sum(Case When ttd.moneydate<:moneydate_begin and ttd.moneydate>=:moneydate_start Then Ttd.Moneypayable - Ttd.Nonvouchermoneypayable")
				.append("                       Else 0 End) Moneypayable_before,")
				.append("       		  sum(Case When ttd.moneydate>=:moneydate_begin And ttd.moneydate<=:moneydate_end Then Ttd.Moneypayable - Ttd.Nonvouchermoneypayable")
				.append("            		   Else 0 End) Moneypayable")
				.append(" 	    From ticketturnoverdetail ttd")
				.append(" 		Group By ttd.seller) a")
				.append(" Left Join")
				.append(" 		(Select tt.seller,")
				.append("       			sum(Case When tt.turnovertime<:moneydate_begin and tt.turnovertime>=:moneydate_start Then Tt.Money")
				.append("            			 Else 0 End) Money_before,")
				.append("       			sum(Case When tt.turnovertime>=:moneydate_begin And tt.turnovertime<=:moneydatetime_end Then Tt.Money")
				.append("            			 Else 0 End) Money")
				.append(" 		  From ticketturnover tt")
				.append(" 		  Group By tt.seller) b On a.seller=b.seller")
				.append(" Join userinfo u On a.seller=u.Id")
				.append(" Where (a.Moneypayable<>0 Or b.money<>0 Or a.Moneypayable_before-decode(b.Money_before,Null,0,b.Money_before)<>0)");
		if (seller != 0 && !"".equals(seller)) {
			sql.append(" and u.id=").append(seller);
		}
		sql.append(" Order By u.code ");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		Date moneydate_begin = DateUtils.getFirstDayOfMonth(DateUtils
				.trunc(moneydate));
		query.setParameter("moneydate_begin", moneydate_begin);
		query.setParameter("moneydate_start", new Date(2013 - 1900, 6 - 1, 1));
		Date nowDate = DateUtils.trunc(new Date());
		Date moneydate_end = DateUtils.getLastDayOfMonth(moneydate_begin);
		if (nowDate.before(moneydate_end) || nowDate.equals(moneydate_end)) {
			moneydate_end = DateUtils.add(nowDate, Calendar.DAY_OF_MONTH, -1);
		}
		query.setParameter("moneydate_end", moneydate_end);
		Date moneydate_time = DateUtils.add(moneydate_end, Calendar.SECOND,
				60 * 60 * 24 - 1);
		query.setParameter("moneydatetime_end", moneydate_time);
		return query.getResultList();
	}
	public List<Object> queryticketturnoverReturnAndCancel(Long ticketturnoverid)
	{
		List<Object> resultlist = new ArrayList<Object>();
		//退票记录
		StringBuffer sql= new StringBuffer();
//		sql.append(" select ts.ticketno, tr.returnamount from ticketreturn tr,ticketsell ts ,ticketturnover t ,ticketturnoverdetail td ");
//		sql.append(" where tr.sellid = ts.id and tr.turnoverdetailid = td.id and t.id = td.ticketturnoverid ");
//		sql.append(" and t.id="+ticketturnoverid);
//		sql.append(" and tr.returnway <> '3' ");//排除改签退票
		
		sql.append(" select tt.ticketno, sum(tt.price) from  ")
		.append(" (select ts.ticketno, ts.price ")
		.append("           from ticketreturn tr, ticketsell ts,ticketturnover t,ticketturnoverdetail td ")
		.append("          where tr.sellid = ts.id and tr.turnoverdetailid = td.id and t.id = td.ticketturnoverid ")
		.append("            and (length(ts.ticketno) = 8 or length(ts.ticketno) = 12 or length(ts.ticketno) = 17) ")
		.append("            and tr.returnway <> '3' and t.id= :ticketturnoverid ")
		.append("         union all  ")
		.append("         SELECT CASE WHEN length(ts.ticketno) > 17 THEN substr(ts.ticketno, 1, 17) ")
		.append("                     WHEN length(ts.ticketno) > 12 THEN substr(ts.ticketno, 1, 12) ")
		.append("                     WHEN length(ts.ticketno) >  8 THEN substr(ts.ticketno, 1, 7) ")
		.append("                     ELSE '' END, ts.price ")
		.append("          from ticketreturn tr, ticketsell ts,ticketturnover t,ticketturnoverdetail td ")
		.append("          where tr.sellid = ts.id and tr.turnoverdetailid = td.id and t.id = td.ticketturnoverid and ts.tickettype = 'T' ")
		.append("            and (length(ts.ticketno) in (9,10) or length(ts.ticketno)  in (13,14) or length(ts.ticketno) in (18,19)) ")
		.append("            and tr.returnway <> '3' and t.id= :ticketturnoverid ) tt ")
		.append("  group by tt.ticketno ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketturnoverid", ticketturnoverid);
		List<Object> ticketreturnlist = query.getResultList();
		/*	TicketRetrunVo ticketreturnvo = new TicketRetrunVo();
		for(int i=0;i<ll.size()&&i%4==0;i++)
		{
			ticketreturnvo.setTicketno1(((Object[])ll.get(i))[0].toString());
			ticketreturnvo.setPrice1(new BigDecimal(((Object[])ll.get(i))[1].toString()));
		}*/
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object []ticketreturnobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for(int i=0;i<ticketreturnlist.size();i++)
		{
			ticketreturnobj[0]="退票";
			Object[] objll = (Object[])ticketreturnlist.get(i);
			ticketreturnobj[i*2%8+1] = objll[0];
			ticketreturnobj[(i*2+1)%8+1]=objll[1];
//			if(i%4==0&&i>0)//长度为4，一个数组填充满
//			{
//				resultlist.add(ticketreturnobj);
//				ticketreturnobj = new Object[9];
//			}
			if (i % 4 == 3) {// 长度为4，一个数组填充满
				resultlist.add(ticketreturnobj);
				ticketreturnobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketreturnobj[0]!=null)
		resultlist.add(ticketreturnobj);
		//废票
//		sql= new StringBuffer(" select ts.ticketno,tc.ticketprice ");
//		sql.append(" from ticketcancel tc,ticketsell ts,ticketturnover t,ticketturnoverdetail td  ");
//		sql.append(" where tc.sellid = ts.id ");
//		sql.append(" and tc.turnoverdetailid =td.id ");
//		sql.append(" and td.ticketturnoverid = t.id ");
//		sql.append(" and t.id="+ticketturnoverid);
		sql= new StringBuffer("  select tt.ticketno, sum(tt.price) from  ");
	    sql.append(" (select ts.ticketno, ts.price ")
		.append("           from ticketcancel tc, ticketsell ts,ticketturnover t,ticketturnoverdetail td ")
		.append("          where tc.sellid = ts.id and tc.turnoverdetailid =td.id and td.ticketturnoverid = t.id ")
		.append("            and (length(ts.ticketno) = 8 or length(ts.ticketno) = 12 or length(ts.ticketno) = 17) ")
		.append("            and t.id= :ticketturnoverid ")
		.append("         union all  ")
		.append("         SELECT CASE WHEN length(ts.ticketno) > 17 THEN substr(ts.ticketno, 1, 17) ")
		.append("                     WHEN length(ts.ticketno) > 12 THEN substr(ts.ticketno, 1, 12) ")
		.append("                     WHEN length(ts.ticketno) >  8 THEN substr(ts.ticketno, 1, 7) ")
		.append("                     ELSE '' END, ts.price ")
		.append("          from ticketcancel tc, ticketsell ts,ticketturnover t,ticketturnoverdetail td ")
		.append("          where tc.sellid = ts.id and tc.turnoverdetailid =td.id and td.ticketturnoverid = t.id and ts.tickettype = 'T' ")
		.append("            and (length(ts.ticketno) in (9,10) or length(ts.ticketno)  in (13,14) or length(ts.ticketno) in (18,19)) ")
		.append("            and t.id= :ticketturnoverid ) tt ")
		.append("  group by tt.ticketno ");
		query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketturnoverid", ticketturnoverid);
		List<Object> ticketcancellist = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object []ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for(int i=0;i<ticketcancellist.size();i++)
		{
			ticketcancelobj[0]="废票";
			Object[] objll = (Object[])ticketcancellist.get(i);
			ticketcancelobj[i*2%8+1] = objll[0];
			ticketcancelobj[(i*2+1)%8+1]=objll[1];
//			if(i%4==0&&i>0)//长度为4，一个数组填充满
//			{
//				resultlist.add(ticketcancelobj);
//				ticketcancelobj = new Object[9];
//			}
			if(i % 4 == 3){ //长度为4，一个数组填充满
				resultlist.add(ticketcancelobj);
				ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketcancelobj[0]!=null)
		resultlist.add(ticketcancelobj);
		
		//改签记录
		sql= new StringBuffer(" select ts.ticketno, tr.returnamount ");
		sql.append(" from ticketreturn tr,ticketsell ts ,ticketturnover t ,ticketturnoverdetail td ");
		sql.append(" where tr.sellid = ts.id and tr.turnoverdetailid = td.id and t.id = td.ticketturnoverid ");
		sql.append(" and t.id="+ticketturnoverid);
		sql.append(" and tr.returnway = '3' ");//排除改签退票
		query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> ticketChangeList = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object[] ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for(int i=0;i<ticketChangeList.size();i++)
		{
			ticketChangeArray[0]="改签";
			Object[] objll = (Object[])ticketChangeList.get(i);
			ticketChangeArray[i*2%8+1] = objll[0];
			ticketChangeArray[(i*2+1)%8+1]=objll[1];
			if (i % 4 == 3) {// 长度为4，一个数组填充满
				resultlist.add(ticketChangeArray);
				ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketChangeArray[0]!=null)
			resultlist.add(ticketChangeArray);
		
		return resultlist;
	}
	
	/**
	 * 查询未缴款营收或已缴款营收的  退票/废票  票号和金额
	 * @param buildFromHttpRequest：包含多个或单个ticketturnoverdeatilid和是否已缴款isturnover
	 * 此类似于上面的方法，上面的方法只能查询  某个tickturnover 对应的记录
	 * @return
	 */
	public List<Object> qryRtnCelByTktoverDetails(
			List<PropertyFilter> buildFromHttpRequest) {
		List<Object> resultlist = new ArrayList<Object>();
		//退票记录
		StringBuffer sql= new StringBuffer("select ts.ticketno, tr.returnamount ");
		sql.append(" from ticketreturn tr, ticketsell ts, ticketturnoverdetail td ");
		sql.append(" where tr.sellid = ts.id and tr.turnoverdetailid = td.id ");
		sql.append(" and tr.returnway <> '3' ");//排除改签退票
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> ticketreturnlist = query.getResultList();

		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object[] ticketreturnobj =new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for (int i = 0; i < ticketreturnlist.size(); i++) {
			ticketreturnobj[0] = "退票";
			Object[] objll = (Object[])ticketreturnlist.get(i);
			ticketreturnobj[i*2%8+1] = objll[0];
			ticketreturnobj[(i*2+1)%8+1] = objll[1];
			if ((i % 4 == 3)) {// 长度为4，一个数组填充满
				resultlist.add(ticketreturnobj);
				ticketreturnobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketreturnobj[0] != null)
			resultlist.add(ticketreturnobj);
		//废票
		sql= new StringBuffer(" select ts.ticketno, tc.ticketprice ");
		sql.append(" from ticketcancel tc, ticketsell ts, ticketturnoverdetail td ");
		sql.append(" where tc.sellid = ts.id and tc.turnoverdetailid = td.id ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> ticketcancellist = query.getResultList();
		
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object[] ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for (int i = 0; i < ticketcancellist.size(); i++) {
			ticketcancelobj[0] = "废票";
			Object[] objll = (Object[])ticketcancellist.get(i);
			ticketcancelobj[i*2%8+1] = objll[0];
			ticketcancelobj[(i*2+1)%8+1] = objll[1];
			if(i % 4 == 3) { //长度为4，一个数组填充满
				resultlist.add(ticketcancelobj);
				ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketcancelobj[0] != null)
			resultlist.add(ticketcancelobj);
		
		
		//改签记录
		sql= new StringBuffer("select ts.ticketno, tr.returnamount ");
		sql.append(" from ticketreturn tr, ticketsell ts, ticketturnoverdetail td ");
		sql.append(" where tr.sellid = ts.id and tr.turnoverdetailid = td.id ");
		sql.append(" and tr.returnway = '3' ");//改签退票
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> ticketchangelist = query.getResultList();

		//定义一个长度为9的数组来存放返回到界面每行的数据集
//		Object[] ticketChangeArray = new Object[9];
		Object[] ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for (int i = 0; i < ticketchangelist.size(); i++) {
			ticketChangeArray[0] = "改签";
			Object[] objll = (Object[])ticketchangelist.get(i);
			ticketChangeArray[i*2%8+1] = objll[0];
			ticketChangeArray[(i*2+1)%8+1] = objll[1];
			if ((i % 4 == 3)) {// 长度为4，一个数组填充满
				resultlist.add(ticketChangeArray);
				ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketChangeArray[0] != null)
			resultlist.add(ticketChangeArray);
		
		return resultlist;
	}
	/**
	 * 通过缴款ID来获取缴款的开始日期、开始保险票号
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<Object> getInsurenceStartInfo(long id) {
		StringBuilder sql = new StringBuilder(
				" select ti.moneydate, ti.ticketstartno ")
				.append(" from insuranceturnoverdetail ti where ti.id = (select min(id)")
				.append(" from insuranceturnoverdetail t where t.ticketturnoverid=:id)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		if (query.getResultList().size() <= 0) {
			return null;
		}
		return query.getResultList();
	}
	/**
	 * 通过缴款ID来获取缴款的结束日期、结束保险票号
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private List<Object> getInsurenceEndInfo(long id) {
		StringBuilder sql = new StringBuilder(
				" select ti.moneydate, ti.ticketendno ")
				.append(" from insuranceturnoverdetail ti where ti.id = (select max(id)")
				.append(" from insuranceturnoverdetail t where t.ticketturnoverid=:id)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		if (query.getResultList().size() <= 0) {
			return null;
		}
		return query.getResultList();
	}

	public List<Object> queryinsurenceturnover(long id){
		List<Object> startinfo = getInsurenceStartInfo(id);
		List<Object> endinfo = getInsurenceEndInfo(id);
		Object[] startobj = null;
		Object[] endobj = null;
		if (startinfo != null) {
			startobj = (Object[]) startinfo.get(0);
		}
		if (endinfo != null) {
			endobj = (Object[]) endinfo.get(0);
		}
		StringBuffer sql = new StringBuffer("select  ");
		sql.append(" t.id, t.turnovertime, t.seller, t.money, ")
		.append(" t.lastlost, t.lost, t.moneypayable, t.receiver, ")
		.append(" t.receipttime, t.receiptorgid, t.receiptip, t.remarks, ")
		.append(" t.sellnum, t.sellmoney, t.returnnum, t.returnmoney, ")
		.append(" t.returnhandcharge, t.cancelnum, t.noncashnum, t.noncashmoney, ")
		.append(" t.eticketnum, t.insuresellnum, t.insuresellmoney, t.insurereturnnum, ")
		.append(" t.insurereturnmoney, t.insurereturnhandcharge, t.insurecancelnum, t.insurechargenum, ")
		.append(" t.insurechargemoney,t.insureeticketnum, t.createtime, t.createby, ")
		.append(" t.servicefee, t.bookservicefee, t.cancelmoney, t.insurecancelmoney, ")
		.append(" t.insurenonvouchermoneypayable, t.nonvouchermoneypayable, t.changeservicefee, t.sellreturntripnum, ")
		.append(" t.returnprintnum, t.billdamagednum, t.stationservicefee, t.fueladditionfee, ")
		.append(" t.computefee, t.coolairfee, t.additionfee, t.waterfee, ")
		.append(" t.insurefee, t.otherfee, t.insurstrike, t.ticketstrike, ")
		.append(" t.ticketmoney,t.insuremoney, t.ticketmoneypayable, t.insuremoneypayable, ")
		.append(" t.balance, ")
		.append(" use.name as receivername, o.name as orgname, us.name as sellername, ")
				.append(" u.name as createname, us.code, ");
		if (startobj == null) {
			sql.append("' ").append("' as startmoneydate, '").append(
					"").append("' as startticketno, ");
		} else {
			sql.append("trim('").append(startobj[0]).append("') as startmoneydate, ").append(
					"trim('").append(startobj[1]).append("') as startticketno, ");
		}
		if (endinfo == null) {
			sql.append("' ").append("' as endmoneydate, '").append(
					"").append("' as endticketno ");
		} else {
			sql.append("trim('").append(endobj[0]).append("') as endmoneydate,").append(
					"trim('").append(endobj[1]).append("') as endticketno ");
		}
		sql.append(" , nvl(precount,0) as precount, nvl(preprice,0)as preprice ");
		sql.append(" from Ticketturnover t ")
		.append("  left join (select ts.sellby, COUNT(ts.id) precount, sum(ts.price) preprice")
		.append("  from Ticketsell ts, Ticketturnoverdetail td")
		.append(" where ts.turnoverdetailid = td.id  and td.seller = td.seller")
		.append(" and ts.selltime < ts.departdate and td.ticketturnoverid="+id)
		.append(" group by ts.sellby) ts on t.seller=ts.sellby ,");
		sql.append(" Userinfo us, Organization o, Userinfo u, Userinfo use ")
		.append(" where t.receiver=use.id and ");
		sql.append(" t.receiptorgid=o.id and t.createby=u.id and t.seller=us.id and t.id= ");
		sql.append(id);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> ll = query.getResultList();
		Object[] preObj=null;
		if(ll!=null&&ll.size()>0){
		   preObj = (Object[]) ll.get(0);
			StringBuffer sql1 = new StringBuffer("select t.id,ts.insuranceno as ticketnoOnline,ts1.insuranceno as ticketnoCancel");
			sql1.append("   from ticketturnover       t, ");
			sql1.append("  ticketturnoverdetail td ");
			sql1.append(" left join insurance      ts on td.id = ts.turnoverdetailid and ts.sellway = '7' ");
			sql1.append(" left join insurancecancel    tc on td.id = tc.turnoverdetailid");
			sql1.append(" left join insurance      ts1 on tc.insuranceid = ts1.id ");
			sql1.append("  where td.ticketturnoverid = t.id  and t.seller = ts.sellby");
			sql1.append(" and t.id="+id);
			query = getEntityManager().createNativeQuery(sql1.toString());
			List<Object> list =  query.getResultList();
			StringBuffer ticketnoOnline = new StringBuffer(" ");
			StringBuffer ticketnoCancel = new StringBuffer(" ");
			if(list!=null && list.size()>0){
				for(int i =0;i<list.size();i++)
				{
					Object[] obj = (Object[]) list.get(i);
					if(obj[1]!=null)
					ticketnoOnline.append(obj[1]+",");
					if(obj[2]!=null)
					ticketnoCancel.append(obj[2]+",");
				}
			}
			Object[] allobj = new Object[preObj.length+3];//定义一个数组来存储所有的显示数据
			for(int i =0;i<preObj.length;i++)
			{
				allobj[i]=preObj[i];
			}
			allobj[allobj.length-3]=ticketnoOnline.substring(0, ticketnoOnline.length()-1);
			allobj[allobj.length-2]=ticketnoCancel.substring(0, ticketnoCancel.length()-1);
			allobj[allobj.length-1]=getTicketnoStartAndEnd(id);  //新增显示的起止票号段
			List<Object> reslist = new ArrayList<Object>();
			reslist.add(allobj);
			return reslist;
		}else{
			return null;
		}
	}
	
	public List<Object> queryinsurenceturnoverReturnAndCancel(long ticketturnoverid){
		List<Object> resultlist = new ArrayList<Object>();
		//退票记录ts., tc. 
		StringBuffer sql= new StringBuffer(" select isc.insuranceno ticketno, ir.premium ticketprice ");
		sql.append(" from insurancereturn ir,insurance isc,ticketturnover t ,insuranceturnoverdetail td ");
		sql.append(" where ir.insuranceid = isc.id and ir.turnoverdetailid = td.id and t.id = td.ticketturnoverid ");
		sql.append(" and t.id="+ticketturnoverid);
		sql.append(" and ir.returnway <> '3' ");//排除改签退票
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> ticketreturnlist = query.getResultList();
		Object []ticketreturnobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for(int i=0;i<ticketreturnlist.size();i++){
			ticketreturnobj[0]="退保";
			Object[] objll = (Object[])ticketreturnlist.get(i);
			ticketreturnobj[i*2%8+1] = objll[0];
			ticketreturnobj[(i*2+1)%8+1]=objll[1];
			if (i % 4 == 3) {// 长度为4，一个数组填充满
				resultlist.add(ticketreturnobj);
				ticketreturnobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketreturnobj[0]!=null)
		resultlist.add(ticketreturnobj);
		//废票
		sql= new StringBuffer(" select isc.insuranceno ticketno, ic.premium ticketprice ");
		sql.append(" from insurancecancel ic,insurance isc,ticketturnover t,insuranceturnoverdetail td  ");
		sql.append(" where ic.insuranceid = isc.id ");
		sql.append(" and ic.turnoverdetailid = td.id ");
		sql.append(" and td.ticketturnoverid = t.id ");
		sql.append(" and t.id="+ticketturnoverid);
		query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> ticketcancellist = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object []ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		
		for(int i=0;i<ticketcancellist.size();i++){
			ticketcancelobj[0]="废保";
			Object[] objll = (Object[])ticketcancellist.get(i);
			ticketcancelobj[i*2%8+1] = objll[0];
			ticketcancelobj[(i*2+1)%8+1]=objll[1];
			if(i % 4 == 3){ //长度为4，一个数组填充满
				resultlist.add(ticketcancelobj);
				ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketcancelobj[0]!=null)
		resultlist.add(ticketcancelobj);
		//改签记录
		sql= new StringBuffer(" select isc.insuranceno ticketno, ir.premium ticketprice ");
		sql.append(" from insurancereturn ir,insurance isc,ticketturnover t ,insuranceturnoverdetail td ");
		sql.append(" where ir.insuranceid = isc.id and ir.turnoverdetailid = td.id and t.id = td.ticketturnoverid ");
		sql.append(" and t.id="+ticketturnoverid);
		sql.append(" and ir.returnway = '3' ");//排除改签退票
		query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> ticketChangeList = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object[] ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		for(int i=0;i<ticketChangeList.size();i++){
			ticketChangeArray[0]="改签";
			Object[] objll = (Object[])ticketChangeList.get(i);
			ticketChangeArray[i*2%8+1] = objll[0];
			ticketChangeArray[(i*2+1)%8+1]=objll[1];
			if (i % 4 == 3) {// 长度为4，一个数组填充满
				resultlist.add(ticketChangeArray);
				ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketChangeArray[0]!=null)
			resultlist.add(ticketChangeArray);
		return resultlist;
	}

	public List<Object> qryRtnCelByIstoverDetails(List<PropertyFilter> buildFromHttpRequest) {
		List<Object> resultlist = new ArrayList<Object>();
		//退保记录
		StringBuffer sql= new StringBuffer("select ts.insuranceno ticketno, tr.premium returnamount");
		sql.append(" from insurancereturn tr, insurance ts, insuranceturnoverdetail td ");
		sql.append(" where tr.insuranceid = ts.id and tr.turnoverdetailid = td.id ");
		sql.append(" and tr.returnway <> '3' ");//排除改签退保
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> ticketreturnlist = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object[] ticketreturnobj =new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		for (int i = 0; i < ticketreturnlist.size(); i++) {
			ticketreturnobj[0] = "退保";
			Object[] objll = (Object[])ticketreturnlist.get(i);
			ticketreturnobj[i*2%8+1] = objll[0];
			ticketreturnobj[(i*2+1)%8+1] = objll[1];
			if ((i % 4 == 3)) {// 长度为4，一个数组填充满
				resultlist.add(ticketreturnobj);
				ticketreturnobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketreturnobj[0] != null)
			resultlist.add(ticketreturnobj);
		//废保
		sql= new StringBuffer(" select ts.insuranceno ticketno, tc.premium ticketprice ");
		sql.append(" from insurancecancel tc, insurance ts, insuranceturnoverdetail td ");
		sql.append("  where tc.insuranceid = ts.id and tc.turnoverdetailid = td.id ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> ticketcancellist = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
		Object[] ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		for (int i = 0; i < ticketcancellist.size(); i++) {
			ticketcancelobj[0] = "废保";
			Object[] objll = (Object[])ticketcancellist.get(i);
			ticketcancelobj[i*2%8+1] = objll[0];
			ticketcancelobj[(i*2+1)%8+1] = objll[1];
			if(i % 4 == 3) { //长度为4，一个数组填充满
				resultlist.add(ticketcancelobj);
				ticketcancelobj = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketcancelobj[0] != null)
			resultlist.add(ticketcancelobj);
		//改签记录
		sql= new StringBuffer("select ts.insuranceno ticketno, tr.premium returnamount ");
		sql.append(" from insurancereturn tr, insurance ts, insuranceturnoverdetail td ");
		sql.append(" where tr.insuranceid = ts.id and tr.turnoverdetailid = td.id ");
		sql.append(" and tr.returnway = '3' ");//改签退票
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> ticketchangelist = query.getResultList();
		//定义一个长度为9的数组来存放返回到界面每行的数据集
//		Object[] ticketChangeArray = new Object[9];
		Object[] ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
		for (int i = 0; i < ticketchangelist.size(); i++) {
			ticketChangeArray[0] = "改签";
			Object[] objll = (Object[])ticketchangelist.get(i);
			ticketChangeArray[i*2%8+1] = objll[0];
			ticketChangeArray[(i*2+1)%8+1] = objll[1];
			if ((i % 4 == 3)) {// 长度为4，一个数组填充满
				resultlist.add(ticketChangeArray);
				ticketChangeArray = new Object[]{null, "--", "--", "--", "--", "--", "--", "--", "--" };
			}
		}
		if(ticketChangeArray[0] != null)
			resultlist.add(ticketChangeArray);
		
		return resultlist;
	}
	public List<Ticketturnoverdetail> qyrTicketturnoverdetaillistbyId(String ticketdetailids) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketturnoverdetail t where t.id in("+ticketdetailids+") order by t.moneydate ");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	public List<Insuranceturnoverdetail> qyrInsuranceturnoverdetaillistbyId(String ticketdetailids) {
		StringBuffer sql = new StringBuffer(
				"select t from Insuranceturnoverdetail t where t.id in("+ticketdetailids+") order by t.moneydate ");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}	
	@SuppressWarnings("unchecked")
	public BigDecimal querylastlost(long seller) {
		StringBuffer sql = new StringBuffer(
				"select t.lost from ticketturnover t where t.id=");
		sql.append("(select max(ti.id) from ticketturnover ti where ti.seller=");
		sql.append(seller);
		sql.append(")");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}
	/**
	 * 缴款之后查询网售取票张数和金额
	 * turnover/queryWebTakedInfo
	 * @return
	 */
	public List<Object> queryWebTakedInfo(List<PropertyFilter> propertyFilter) {
		StringBuilder sql = new StringBuilder(
				" select nvl(count(ts.id),0) count, nvl(sum(ts.price), 0) price ")
						.append("   from ticketturnoverdetail t ")
						.append(" left join ticketsellother tso on tso.printby = t.seller  and t.moneydate = trunc(tso.taketime) ")
						.append(" left join ticketsell ts on tso.ticketsellid = ts.id ")
						.append(" where 1=1 and tso.istaked = 1 ");
//		t.ticketturnoverid = :id
		sql.append(PropertyFilter.toJpql(propertyFilter, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilter);
		if (query.getResultList().size() <= 0) {
			return null;
		}
		return query.getResultList();
	}
	
	/**
	 * 根据缴款id 查询电子退票相关的打印数据源
	 * 
	 * @return
	 */
	public List<Object> qryReturnMoney(String ticketturnoverids) {
		StringBuffer sql = new StringBuffer();
		sql.append(" ")
				.append(" select sum(eticketreturnnum),                                    ")
				.append("  sum(eticketreturnmoney),                                        ")
				.append("  sum(eticketreturncharge),                                       ")
				.append("  sum(eticketreturnbacknum),                                      ")
				.append("  sum(eticketreturnbackmoney),                                    ")
				.append("  sum(eticketreturnbackcharge),                                   ")
				.append("  sum(ereturnnum),                                                ")
				.append("  sum(ereturnmoney),                                              ")
				.append("  sum(ereturncharge),                                             ")
				.append("  sum(ereturnbacknum),                                            ")
				.append("  sum(ereturnbackmoney),                                          ")
				.append("  sum(ereturnbackcharge),                                         ")
				.append("  sum(noncashmoneypayable),                                        ")
				.append("  sum(insurereturnnumweb),                                        ")
				.append("  sum(insurereturnamountweb)                                        ")
				.append(" from (select td.eticketreturnnum eticketreturnnum,               ")
				.append("              td.eticketreturnmoney eticketreturnmoney,           ")
				.append("              td.eticketreturncharge eticketreturncharge,         ")
				.append("              td.eticketreturnbacknum eticketreturnbacknum,       ")
				.append("              td.eticketreturnbackmoney eticketreturnbackmoney,   ")
				.append("              td.eticketreturnbackcharge eticketreturnbackcharge, ")
				.append("              0 ereturnnum,                                       ")
				.append("              0 ereturnmoney,                                     ")
				.append("              0 ereturncharge,                                    ")
				.append("              0 ereturnbacknum,                                   ")
				.append("              0 ereturnbackmoney,                                 ")
				.append("              0 ereturnbackcharge,                                ")
				.append("              td.noncashmoneypayable,0 insurereturnnumweb ,0 insurereturnamountweb      ")
				.append("         from ticketturnover t,ticketturnoverdetail td  ")
				.append("        where t.id = td.ticketturnoverid and t.id in ")
									.append(ticketturnoverids)
				.append("   ")
				.append("       union all                                                  ")
				.append("       select 0 eticketreturnnum,                                 ")
				.append("              0 eticketreturnmoney,                               ")
				.append("              0 eticketreturncharge,                              ")
				.append("              0 eticketreturnbacknum,                             ")
				.append("              0 eticketreturnbackmoney,                           ")
				.append("              0 eticketreturnbackcharge,                          ")
				.append("              tr.ereturnnum,                                      ")
				.append("              tr.ereturnmoney,                                    ")
				.append("              tr.ereturncharge,                                   ")
				.append("              tr.ereturnbacknum,                                  ")
				.append("              tr.ereturnbackmoney,                                ")
				.append("              0 ereturnbackcharge,                                ")
				.append("              tr.noncashmoneypayable,0 insurereturnnumweb ,0 insurereturnamountweb   ")
				.append("         from ticketturnover t,insuranceturnoverdetail tr   ")
				.append("        where t.id = tr.ticketturnoverid and t.id in  ")
						.append(ticketturnoverids).append("   ")
				.append("   ) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> list = query.getResultList();
		return list;
	}
	/**
	 * 营收缴款打印模板增加打印项【网售票价】、【网售张数】和【网售金额】打印数据集，并且按照票价分组
	 * 
	 * @param id
	 * @return
	 */
	public List<Object> queryWebInfoGroup(long id) {
		StringBuilder sql = new StringBuilder(
				" select u.name as takeby, t.seller,ts.price, count(ts.id) wcount, sum(ts.price) wprice from ticketturnoverdetail t  ")
						.append(" left join ticketsellother tso on tso.printby = t.seller and trunc(tso.taketime) = t.moneydate ")
						.append(" left join ticketsell ts on tso.ticketsellid = ts.id ")
						.append(" left join userinfo u on u.id = t.seller ")
						.append(" where t.ticketturnoverid = :id group by u.name, t.seller, ts.price order by ts.price");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		if (query.getResultList().size() <= 0) {
			return null;
		}
		return query.getResultList();
	}
}
