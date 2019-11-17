package cn.nova.bus.pack.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.vo.PackDeparVO;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PacktturnoverDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(String orgid, Long userid, Date fromdate,
			Date enddate) {
		// sb.append(" select 0 as ischoose,u.id as sellby,u.name as sellbyname,a.sellbytime");
		StringBuffer sb = new StringBuffer();

		// sb.append(" select distinct 0 as ischoose,u.id as sellby,u.name as sellbyname,nvl(a.sellbytime,nvl(b.sellbytime,nvl(c.sellbytime,nvl(d.sellbytime,'')))) as sellbytime");
		// sb.append(" ,u.orgid,o.name as orgname,nvl(a.acceptpieces,0) as acceptpieces ,nvl(a.accepttotalfee,0),(nvl(b.goodspieces,0)+nvl(c.goodspieces,0)) as goodspieces");
		// sb.append(" ,(nvl(b.goodstotalfee,0)+nvl(c.goodstotalfee,0)) as goodstotalfee,nvl(d.pkuppieces,0),nvl(d.pkuptotalfee,0)");
		// sb.append(" ,(nvl(a.accepttotalfee,0)+nvl(b.goodstotalfee,0)+nvl(c.goodstotalfee,0)+nvl(d.pkuptotalfee,0)) as totalmoney");
		// sb.append(" ,nvl(pt.sellby,0) as upmoneystatus");
		// sb.append(" ,pt.upmoneydate,pt.receipttime,pt.receiver,pt.receivername,nvl(la.lost,0) as lastlost");
		// sb.append(" ,nvl(b.goodspieces,0) as depositpieces,nvl(c.goodspieces,0) as recaptionspieces");
		// sb.append(" from Userinfo u ");
		// sb.append(" left join (");
		// //受理
		// sb.append(" select p.sellby,to_char(p.createtime,'yyyy-MM-dd') as sellbytime,sum(p.pieces) as acceptpieces,sum(p.totalfee) as accepttotalfee from Pack p");
		// sb.append(" where p.paymethod='0' and p.status in(0,1) and p.packtype='0' and p.orgid in").append(orgid).append(" and p.createtime>=:formtime ");
		// sb.append(" and p.createtime<=:endtime group by p.sellby,to_char(p.createtime,'yyyy-MM-dd')");
		// sb.append(" ) a on a.sellby=u.id");
		// sb.append(" left join (");
		// //小件寄存
		// sb.append(" select g.consignee as sellby,to_char(g.deposittiime,'yyyy-MM-dd') as sellbytime,sum(g.pieces) as goodspieces,");
		// sb.append(" sum(g.custodial) as goodstotalfee from Goods g where g.status!='2' and g.orgid in").append(orgid).append(" and g.deposittiime>=:formtime");
		// sb.append(" and g.deposittiime<=:endtime group by g.consignee,to_char(g.deposittiime,'yyyy-MM-dd')");
		// sb.append(" ) b on b.sellby=u.id");
		//
		// sb.append(" left join (");
		// //小件提领
		// sb.append(" select g.operator as sellby,to_char(g.pickupdate,'yyyy-MM-dd') as sellbytime,sum(g.pieces) as goodspieces,");
		// sb.append(" sum(g.penalty) as goodstotalfee from Goods g where g.status='1' and g.orgid in").append(orgid).append(" and g.pickupdate>=:formtime");
		// sb.append(" and g.pickupdate<=:endtime group by g.operator,to_char(g.pickupdate,'yyyy-MM-dd')");
		// sb.append(" ) c on c.sellby=u.id");
		//
		// sb.append(" left join (");
		// //行包提领
		// sb.append(" select pk.operator as sellby,to_char(pk.createtime,'yyyy-MM-dd') as sellbytime, sum(p.pieces) as pkuppieces,sum(pk.totalfee) as Pkuptotalfee from Pack p,packpickup pk where p.id=pk.packid");
		// sb.append(" and pk.orgid in").append(orgid).append(" and pk.createtime>=:formtime");
		// sb.append(" and pk.createtime<=:endtime group by pk.operator,to_char(pk.createtime,'yyyy-MM-dd')");
		// sb.append(" ) d on d.sellby=u.id");
		//
		// sb.append(" left join (");
		// //判断是否已缴款
		// sb.append(" select pt.sellby,pt.upmoneydate,pt.receipttime,pt.receiver,ptu.name as receivername");
		// sb.append(" from Packtturnover pt  ,Userinfo ptu where ptu.id=pt.receiver and pt.upmoneydate>=:formtime");
		// sb.append(" and pt.upmoneydate<=:endtime");
		// sb.append(" ) pt on pt.sellby=u.id");
		// //获取上期溢欠款
		// sb.append(" left join (");
		// sb.append(" select pt.lost,pt.sellby");
		// sb.append(" from Packtturnover pt ,Userinfo ptu where ptu.id=pt.receiver ");
		// sb.append(" and pt.upmoneydate<:endtime");
		// sb.append(" ) la on la.sellby=u.id");
		//
		// sb.append(" ,Organization o where o.id=u.orgid and u.id in(");
		// sb.append(" select distinct u.id");
		// sb.append(" from Userinfo u");
		// sb.append(" where u.id in");
		// sb.append(" (");
		// //受理
		// sb.append(" select p.sellby from Pack p");
		// sb.append(" where p.paymethod='0' and p.status in(0,1) and p.packtype='0' and p.orgid in").append(orgid).append(" and p.createtime>=:formtime");
		// sb.append(" and p.createtime<=:endtime group by p.sellby");
		// sb.append(" )");
		//
		// sb.append(" or u.id in");
		// sb.append(" ("); // 小件寄存
		// sb.append(" select g.consignee as sellby from Goods g where g.status!='2' and g.orgid in").append(orgid).append(" and g.deposittiime>=:formtime");
		// sb.append(" and g.deposittiime<=:endtime group by g.consignee");
		// sb.append(" )");
		// sb.append(" or u.id in");
		// sb.append(" (");
		// //小件提领
		// sb.append(" select g.operator as sellby from Goods g where g.status=1 and g.orgid in").append(orgid).append(" and g.pickupdate>=:formtime");
		// sb.append(" and g.pickupdate<=:endtime group by g.operator");
		// sb.append(" )");
		// sb.append(" or u.id in");
		// sb.append(" (");
		// //行包提领
		// sb.append(" select pk.operator as sellby from Packpickup pk where pk.orgid in").append(orgid).append(" and pk.createtime>=:formtime");
		// sb.append(" and pk.createtime<=:endtime group by pk.operator");
		// sb.append(" )");
		// sb.append(" )");
		// if (userid!=null && userid>0){
		// sb.append(" and u.id=").append(userid);
		// }
		// sb.append(" order by u.id ");

		sb.append(" select distinct 0 as ischoose,m.sellby,u.name sellbyname, ");
		sb.append(" m.sellbytime  ");
		sb.append(" ,u.orgid,o.name as orgname,nvl(a.acceptpieces,0) as acceptpieces ,nvl(a.accepttotalfee,0) ");
		sb.append(" ,(nvl(b.goodspieces,0)+nvl(c.goodspieces,0)) as goodspieces ");
		sb.append(" ,(nvl(b.goodstotalfee,0)+nvl(c.goodstotalfee,0)) as goodstotalfee,nvl(d.pkuppieces,0),nvl(d.pkuptotalfee,0) ");
		sb.append(" ,(nvl(a.accepttotalfee,0)+nvl(b.goodstotalfee,0)+nvl(c.goodstotalfee,0)+nvl(d.pkuptotalfee,0)) as totalmoney ");
		sb.append(" ,nvl(pt.sellby,0) as upmoneystatus ");
		sb.append(" ,pt.upmoneydate,pt.receipttime,pt.receiver,pt.receivername,nvl(la.lost,0) as lastlost ");
		sb.append(" ,nvl(b.goodspieces,0) as depositpieces,nvl(c.goodspieces,0) as recaptionspieces ");
		sb.append(" from ( ");
		sb.append("   select orgid,sellby,to_char(sellbytime,'yyyy-MM-dd') sellbytime from  ");
		sb.append("   ( ");
		// --受理
		sb.append("       select p.orgid as orgid,p.sellby,p.createtime sellbytime from Pack p ");
		sb.append("       where p.paymethod='0' and p.paymethod='0' and p.status in(0,1) and p.packtype='0' ");
		sb.append("       and p.orgid in").append(orgid)
				.append("  and p.createtime>=:formtime ");
		sb.append("       and p.createtime<=:endtime ");
		sb.append("       group by p.orgid,p.sellby,p.createtime ");
		sb.append("        ");
		sb.append("       union all ");
		sb.append("       ( ");
		// -- 小件寄存
		sb.append("            select g.orgid as orgid,g.consignee as sellby,g.deposittiime as sellbytime from Goods g where g.status!='2' ");
		sb.append("            and g.orgid in").append(orgid)
				.append("  and g.deposittiime>=:formtime ");
		sb.append("            and g.deposittiime<=:endtime  ");
		sb.append("            group by g.orgid,g.consignee,g.deposittiime ");
		sb.append("       ) ");
		sb.append("       union all  ");
		sb.append("       (    ");
		// --小件提领
		sb.append("           select g.orgid as orgid,g.operator as sellby,g.pickupdate as sellbytime from Goods g where g.status=1  ");
		sb.append("           and g.orgid in").append(orgid)
				.append("  and g.pickupdate>=:formtime ");
		sb.append("           and g.pickupdate<=:endtime  ");
		sb.append("           group by g.orgid,g.operator,g.pickupdate ");
		sb.append("       )  ");
		sb.append("       union all ");
		sb.append("       (        ");
		// --行包提领
		sb.append("           select pk.orgid as orgid,pk.operator as sellby,pk.createtime as sellbytime from Packpickup pk  ");
		sb.append("           where pk.orgid in").append(orgid)
				.append("  and pk.createtime>=:formtime ");
		sb.append("           and pk.createtime<=:endtime  ");
		sb.append("           group by pk.orgid,pk.operator,pk.createtime ");
		sb.append("       ) ");
		sb.append("   ) group by orgid,sellby,to_char(sellbytime,'yyyy-MM-dd') ");
		sb.append(" )m  ");
		sb.append("  ");
		sb.append(" full join( ");
		// --受理
		sb.append("       select p.orgid orgid,p.sellby,to_char(p.createtime,'yyyy-MM-dd') as sellbytime,sum(p.pieces) as acceptpieces, ");
		sb.append("       sum(p.totalfee) as accepttotalfee from Pack p      where p.paymethod='0' and p.status in(0,1)  ");
		sb.append(
				"       and p.packtype='0' and p.paymethod='0' and p.orgid in")
				.append(orgid).append("  and p.createtime>=:formtime  ");
		sb.append("       and p.createtime<=:endtime  ");
		sb.append("       group by p.orgid,p.sellby,to_char(p.createtime,'yyyy-MM-dd') ");
		sb.append(" ) a on a.sellby=m.sellby and a.sellbytime=m.sellbytime and a.orgid=m.orgid ");
		sb.append(" full join( ");
		// --小件寄存
		sb.append("     select g.orgid,g.consignee as sellby,to_char(g.deposittiime,'yyyy-MM-dd') as sellbytime,sum(g.pieces) as goodspieces, ");
		sb.append(
				"     sum(g.custodial) as goodstotalfee from Goods g where g.status!='2' and g.orgid in")
				.append(orgid).append("   ");
		sb.append("     and g.deposittiime>=:formtime  ");
		sb.append("     and g.deposittiime<=:endtime  ");
		sb.append("     group by g.orgid,g.consignee,to_char(g.deposittiime,'yyyy-MM-dd') ");
		sb.append(" ) b on b.sellby=m.sellby and b.sellbytime=m.sellbytime and b.orgid=m.orgid ");
		sb.append("   ");
		sb.append(" full join( ");
		// --小件提领
		sb.append("     select g.orgid,g.operator as sellby,to_char(g.pickupdate,'yyyy-MM-dd') as sellbytime,sum(g.pieces) as goodspieces, ");
		sb.append(
				"     sum(g.penalty) as goodstotalfee from Goods g where g.status='1' and g.orgid in")
				.append(orgid).append("   ");
		sb.append("     and g.pickupdate>=:formtime  ");
		sb.append("     and g.pickupdate<=:endtime  ");
		sb.append("     group by g.orgid,g.operator,to_char(g.pickupdate,'yyyy-MM-dd') ");
		sb.append("  ) c on c.sellby=m.sellby and c.sellbytime=m.sellbytime and c.orgid=m.orgid  ");
		sb.append("   ");
		sb.append(" full join( ");
		// --行包提领
		sb.append("     select pk.orgid,pk.operator as sellby,to_char(pk.createtime,'yyyy-MM-dd') as sellbytime, sum(p.pieces) as pkuppieces, ");
		sb.append("     sum(pk.totalfee) as Pkuptotalfee from Pack p,packpickup pk where p.id=pk.packid  ");
		sb.append("     and pk.orgid in").append(orgid)
				.append("  and pk.createtime>=:formtime ");
		sb.append("     and pk.createtime<=:endtime  ");
		sb.append("     group by pk.orgid,pk.operator,to_char(pk.createtime,'yyyy-MM-dd')  ");
		sb.append(" ) d on d.sellby=m.sellby and d.sellbytime=m.sellbytime and d.orgid=m.orgid ");
		sb.append("         ");
		sb.append(" full join ( ");
		// --判断是否已缴款
		sb.append("        select pt.orgid,pt.sellby,to_char(pt.upmoneydate,'yyyy-MM-dd') upmoneydate,pt.receipttime,pt.receiver,ptu.name as receivername ");
		sb.append("        from Packtturnover pt  ,Userinfo ptu where ptu.id=pt.receiver  ");
		sb.append("        and pt.orgid in").append(orgid).append("  ");
		sb.append("        and pt.upmoneydate>=:formtime ");
		sb.append("        and pt.upmoneydate<=:endtime ");
		sb.append(" ) pt on pt.sellby=m.sellby and pt.upmoneydate=m.sellbytime and pt.orgid=m.orgid ");
		// --获取上期溢欠款
		sb.append(" full join( ");
//		sb.append("        select pt.orgid,pt.lost,pt.sellby,to_char(pt.upmoneydate,'yyyy-MM-dd') as sellbytime ");
//		sb.append("        from Packtturnover pt ,Userinfo ptu where ptu.id=pt.receiver ");
//		sb.append("        and pt.orgid in").append(orgid).append("   ");
//		sb.append("        and pt.upmoneydate<:endtime ");

		sb.append("        select pt.orgid,pt.lost,pt.sellby ");
		sb.append("        from Packtturnover pt right join ( ");
		sb.append("             select pt2.sellby,max(pt2.id) id,max(pt2.receipttime) receipttime from Packtturnover pt2 ");
		sb.append("             where pt2.orgid in").append(orgid).append("  ");
		sb.append("             group by pt2.orgid,pt2.sellby ");
		sb.append("        ) pt2 on pt.id=pt2.id and pt.receipttime=pt2.receipttime,Userinfo ptu where ptu.id=pt.receiver ");
//		sb.append("        and pt.orgid in").append(orgid).append("  ");
//		sb.append(" ) la on la.sellby=m.sellby and la.sellbytime=m.sellbytime and la.orgid=pt.orgid ");
		sb.append(" ) la on la.sellby=m.sellby and la.orgid=m.orgid ");
		sb.append(" ,Organization o ,Userinfo u where u.id=m.sellby and o.id=m.orgid ");
		sb.append("  ");
		if (userid != null && userid >= 0) {
			sb.append(" and m.sellby=").append(userid);
		}
		sb.append(" order by m.sellbytime desc ");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("formtime", fromdate);
		query.setParameter("endtime", enddate);
		List<Object> list = query.getResultList();
		return list;

	}
	
	
	public List<Object> queryRevenueOfDay(String packdatafrom,
			List<PropertyFilter> propertyFilter){
		
		StringBuffer sql = new StringBuffer();
		//(行包发货日营收单)
		if (packdatafrom.equals("0")) {
			sql.append(" select tt.userid,tt.code,tt.name,sum(packnum) packnum,sum(tt.sendpacktnum) sendpacktnum,sum(tt.sendpackamount) sendpackamount,sum(tt.pickupsnum) pickupsnum, ")
			.append(" sum(tt.pickupamount) pickupamount,sum(tt.moneypayable) moneypayable,sum(tt.actupmoney) actupmoney,min(tt.ticketstartno) ticketstartno,max(tt.ticketendno) ticketendno, ")
			.append(" sum((case when tt.lost < 0 then tt.lost else 0.00 end)) shortlost, ")
			.append(" sum((case when tt.lost > 0 then tt.lost else 0.00 end)) longlost, ")
			.append(" sum(tt.packstrike) packstrike ")
			.append(" from (select tdd.moneydate moneydate,u.id userid,u.code code,u.name name,to_number(max(tdd.ticketendno))-to_number(min(tdd.ticketstartno))+1 packnum,sum(t.sendpacks) sendpacktnum,sum(t.sendpackamount) sendpackamount, ")
			.append(" sum(t.pickups) pickupsnum,sum(t.pickupamount) pickupamount,sum(t.moneypayable) moneypayable,sum(t.actupmoney) actupmoney,min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno,sum(t.lost) lost,sum(t.packstrike) packstrike ")
			.append(" from packtturnover t left join (select td.moneydate moneydate,td.packtturnoverid,min(td.ticketstartno) ticketstartno,max(td.ticketendno) ticketendno ")
			.append(" from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='0' group by td.packtturnoverid, td.moneydate) tdd on t.id = tdd.packtturnoverid ")
			.append(" left join Userinfo u on t.sellby = u.id group by tdd.moneydate, u.id, u.code, u.name, t.lost) tt where 1=1 ")
			.append(PropertyFilter.toJpql(propertyFilter, true))
			.append(" group by tt.userid, tt.code, tt.name order by tt.code ");
			
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilter);
			return query.getResultList();
			
		}else if(packdatafrom.equals("1")){ //行包到货日营收单
			sql.append(" select tt.userid,tt.code,tt.name,sum(packnum) packnum,sum(tt.sendpacktnum) sendpacktnum,sum(tt.sendpackamount) sendpackamount,sum(tt.pickupsnum) pickupsnum, ")
			.append(" sum(tt.pickupamount) pickupamount,sum(tt.moneypayable) moneypayable,sum(tt.actupmoney) actupmoney,min(tt.ticketstartno) ticketstartno,max(tt.ticketendno) ticketendno, ")
			.append(" sum((case when tt.lost < 0 then tt.lost else 0.00 end)) shortlost, ")
			.append(" sum((case when tt.lost > 0 then tt.lost else 0.00 end)) longlost, ")
			.append(" sum(tt.packstrike) packstrike ")
			.append(" from (select tdd.moneydate moneydate,u.id userid,u.code code,u.name name,to_number(max(tdd.ticketendno))-to_number(min(tdd.ticketstartno))+1 packnum,sum(t.sendpacks) sendpacktnum,sum(t.sendpackamount) sendpackamount, ")
			.append(" sum(t.pickups) pickupsnum,sum(t.pickupamount) pickupamount,sum(t.moneypayable) moneypayable,sum(t.actupmoney) actupmoney,min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno,sum(t.lost) lost,sum(t.packstrike) packstrike ")
			.append(" from packtturnover t left join (select td.moneydate moneydate,td.packtturnoverid,min(td.ticketstartno) ticketstartno,max(td.ticketendno) ticketendno ")
			.append(" from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='1' group by td.packtturnoverid, td.moneydate) tdd on t.id = tdd.packtturnoverid ")
			.append(" left join Userinfo u on t.sellby = u.id group by tdd.moneydate, u.id, u.code, u.name, t.lost) tt where 1=1 ")
			.append(PropertyFilter.toJpql(propertyFilter, true))
			.append(" group by tt.userid, tt.code, tt.name order by tt.code ");
			
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilter);
			return query.getResultList();
			
		}
//		else{
//			sql.append(" select tt.userid,tt.code,tt.name,sum(packnum) packnum,sum(tt.sendpacktnum) sendpacktnum,sum(tt.sendpackamount) sendpackamount,sum(tt.pickupsnum) pickupsnum, ")
//			.append(" sum(tt.pickupamount) pickupamount,sum(tt.moneypayable) moneypayable,sum(tt.actupmoney) actupmoney,min(tt.ticketstartno) ticketstartno,max(tt.ticketendno) ticketendno, ")
//			.append(" sum((case when tt.lost < 0 then tt.lost else 0.00 end)) shortlost, ")
//			.append(" sum((case when tt.lost > 0 then tt.lost else 0.00 end)) longlost ")
//			.append(" from (select tdd.moneydate moneydate,u.id userid,u.code code,u.name name,to_number(max(tdd.ticketendno))-to_number(min(tdd.ticketstartno))+1 packnum,sum(t.sendpacks) sendpacktnum,sum(t.sendpackamount) sendpackamount, ")
//			.append(" sum(t.pickups) pickupsnum,sum(t.pickupamount) pickupamount,sum(t.moneypayable) moneypayable,sum(t.actupmoney) actupmoney,min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno,sum(t.lost) lost ")
//			.append(" from packtturnover t left join (select td.moneydate moneydate,td.packtturnoverid,min(td.ticketstartno) ticketstartno,max(td.ticketendno) ticketendno ")
//			.append(" from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='0' group by td.packtturnoverid, td.moneydate) tdd on t.id = tdd.packtturnoverid ")
//			.append(" left join Userinfo u on t.sellby = u.id group by tdd.moneydate, u.id, u.code, u.name, t.lost) tt where 1=1 ")
//			.append(PropertyFilter.toJpql(propertyFilter, true))
//			.append(" group by tt.userid, tt.code, tt.name order by tt.code ");
//			
//			Query query = getEntityManager().createNativeQuery(sql.toString());
//			JPAPropertyFilterUtil.setParameter(query, propertyFilter);
//			List<Object> list = query.getResultList();
//			
//			StringBuffer sql2 = new StringBuffer();
//			
//			sql2.append(" select tt.userid,tt.code,tt.name,sum(packnum) packnum,sum(tt.sendpacktnum) sendpacktnum,sum(tt.sendpackamount) sendpackamount,sum(tt.pickupsnum) pickupsnum, ")
//			.append(" sum(tt.pickupamount) pickupamount,sum(tt.moneypayable) moneypayable,sum(tt.actupmoney) actupmoney,min(tt.ticketstartno) ticketstartno,max(tt.ticketendno) ticketendno, ")
//			.append(" sum((case when tt.lost < 0 then tt.lost else 0.00 end)) shortlost, ")
//			.append(" sum((case when tt.lost > 0 then tt.lost else 0.00 end)) longlost ")
//			.append(" from (select tdd.moneydate moneydate,u.id userid,u.code code,u.name name,to_number(max(tdd.ticketendno))-to_number(min(tdd.ticketstartno))+1 packnum,sum(t.sendpacks) sendpacktnum,sum(t.sendpackamount) sendpackamount, ")
//			.append(" sum(t.pickups) pickupsnum,sum(t.pickupamount) pickupamount,sum(t.moneypayable) moneypayable,sum(t.actupmoney) actupmoney,min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno,sum(t.lost) lost ")
//			.append(" from packtturnover t left join (select td.moneydate moneydate,td.packtturnoverid,min(td.ticketstartno) ticketstartno,max(td.ticketendno) ticketendno ")
//			.append(" from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='1' group by td.packtturnoverid, td.moneydate) tdd on t.id = tdd.packtturnoverid ")
//			.append(" left join Userinfo u on t.sellby = u.id group by tdd.moneydate, u.id, u.code, u.name, t.lost) tt where 1=1 ")
//			.append(PropertyFilter.toJpql(propertyFilter, true))
//			.append(" group by tt.userid, tt.code, tt.name order by tt.code ");
//			
//			Query query2 = getEntityManager().createNativeQuery(sql2.toString());
//			JPAPropertyFilterUtil.setParameter(query2, propertyFilter);
//			list.addAll(query2.getResultList());
//			return list;
//		}
		else if(packdatafrom.equals("2")){ //行包寄存日营收单
			sql.append(" select tt.userid,tt.code,tt.name,sum(packnum) packnum,sum(tt.sendpacktnum) sendpacktnum,sum(tt.sendpackamount) sendpackamount,sum(tt.pickupsnum) pickupsnum, ")
			.append(" sum(tt.pickupamount) pickupamount,sum(tt.moneypayable) moneypayable,sum(tt.actupmoney) actupmoney,min(tt.ticketstartno) ticketstartno,max(tt.ticketendno) ticketendno, ")
			.append(" sum((case when tt.lost < 0 then tt.lost else 0.00 end)) shortlost, ")
			.append(" sum((case when tt.lost > 0 then tt.lost else 0.00 end)) longlost, ")
			.append(" sum(tt.packstrike) packstrike ")
			.append(" from (select tdd.moneydate moneydate,u.id userid,u.code code,u.name name,to_number(max(tdd.ticketendno))-to_number(min(tdd.ticketstartno))+1 packnum,sum(t.sendpacks) sendpacktnum,sum(t.sendpackamount) sendpackamount, ")
			.append(" sum(t.pickups) pickupsnum,sum(t.pickupamount) pickupamount,sum(t.moneypayable) moneypayable,sum(t.actupmoney) actupmoney,min(tdd.ticketstartno) ticketstartno,max(tdd.ticketendno) ticketendno,sum(t.lost) lost,sum(t.packstrike) packstrike ")
			.append(" from packtturnover t left join (select td.moneydate moneydate,td.packtturnoverid,min(td.ticketstartno) ticketstartno,max(td.ticketendno) ticketendno ")
			.append(" from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='2' group by td.packtturnoverid, td.moneydate) tdd on t.id = tdd.packtturnoverid ")
			.append(" left join Userinfo u on t.sellby = u.id group by tdd.moneydate, u.id, u.code, u.name, t.lost) tt where 1=1 ")
			.append(PropertyFilter.toJpql(propertyFilter, true))
			.append(" group by tt.userid, tt.code, tt.name order by tt.code ");
			
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilter);
			return query.getResultList();
			
		}
		return null;		
		
	}
	
	public List queryTicketErrorReport(List<PropertyFilter> propertyFilter,String packdatafrom){
		if(packdatafrom.equals("0")){//发货
			StringBuffer sql = new StringBuffer(" select tt.moneydate,u.code,u.name,sum(t.lost + nvl(td2.difmoney, 0)) lost ")
			.append(" from packtturnover t left join userinfo u on t.sellby = u.id ")
			.append(" left join (select distinct td.moneydate, td.packtturnoverid from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='0') tt on t.id = tt.packtturnoverid ")
			.append(" left join (select packtturnoverid, sum(tds.difmoney) difmoney from (select td.packtturnoverid, td.moneydate, td.sellby from packtturnoverdetail td group by td.packtturnoverid, td.moneydate, td.sellby) td, ")
			.append(" ticketturnoverdifadjust tds where td.moneydate = tds.moneydate and td.sellby = tds.seller group by td.packtturnoverid) td2 on t.id = td2.packtturnoverid  ")
	        .append(" where 1=1 and lost <> 0 ")        
			.append(PropertyFilter.toJpql(propertyFilter, true))
			.append(" group by tt.moneydate, u.code, u.name order by tt.moneydate, u.code");		
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilter);
			return query.getResultList();
		}else if(packdatafrom.equals("1")){//到货
			StringBuffer sql2 = new StringBuffer(" select tt.moneydate,u.code,u.name,sum(t.lost + nvl(td2.difmoney, 0)) lost ")
			.append(" from packtturnover t left join userinfo u on t.sellby = u.id ")
			.append(" left join (select distinct td.moneydate, td.packtturnoverid from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='1') tt on t.id = tt.packtturnoverid ")
			.append(" left join (select packtturnoverid, sum(tds.difmoney) difmoney from (select td.packtturnoverid, td.moneydate, td.sellby from packtturnoverdetail td group by td.packtturnoverid, td.moneydate, td.sellby) td, ")
			.append(" ticketturnoverdifadjust tds where td.moneydate = tds.moneydate and td.sellby = tds.seller group by td.packtturnoverid) td2 on t.id = td2.packtturnoverid  ")
	        .append(" where 1=1 and lost <> 0 ")        
			.append(PropertyFilter.toJpql(propertyFilter, true))
			.append(" group by tt.moneydate, u.code, u.name order by tt.moneydate, u.code");		
			Query query2 = getEntityManager().createNativeQuery(sql2.toString());
			JPAPropertyFilterUtil.setParameter(query2, propertyFilter);
			return query2.getResultList();
		}else if(packdatafrom.equals("2")){//小件
			StringBuffer sql2 = new StringBuffer(" select tt.moneydate,u.code,u.name,sum(t.lost + nvl(td2.difmoney, 0)) lost ")
			.append(" from packtturnover t left join userinfo u on t.sellby = u.id ")
			.append(" left join (select distinct td.moneydate, td.packtturnoverid from packtturnoverdetail td where td.packtturnoverid is not null and td.datafrom='2') tt on t.id = tt.packtturnoverid ")
			.append(" left join (select packtturnoverid, sum(tds.difmoney) difmoney from (select td.packtturnoverid, td.moneydate, td.sellby from packtturnoverdetail td group by td.packtturnoverid, td.moneydate, td.sellby) td, ")
			.append(" ticketturnoverdifadjust tds where td.moneydate = tds.moneydate and td.sellby = tds.seller group by td.packtturnoverid) td2 on t.id = td2.packtturnoverid  ")
	        .append(" where 1=1 and lost <> 0 ")        
			.append(PropertyFilter.toJpql(propertyFilter, true))
			.append(" group by tt.moneydate, u.code, u.name order by tt.moneydate, u.code");		
			Query query2 = getEntityManager().createNativeQuery(sql2.toString());
			JPAPropertyFilterUtil.setParameter(query2, propertyFilter);
			return query2.getResultList();
		}
		return null;
	}
	
	public List<Object> qryPacktturnoverinfo(long packtturndetailid){
		
		StringBuffer sql = new StringBuffer("select p from Packtturnover p,Packtturnoverdetail pd where p.id=pd.packtturnoverid and pd.id=").append(packtturndetailid);
		Query query = getEntityManager().createQuery(sql.toString());			
		return query.getResultList();
	}
	/**
	 * 行包结算单查询
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> packManualMakeup(List<PropertyFilter> propertyFilters) {
		StringBuffer sbf = new StringBuffer();
		sbf.append("select p.id as id ,p.departdate       as departdate, p.departinvoicesno as departinvoicesno,")
				.append(" pk.packno  as packno, s.name  as tostationname,   p.shipprice  as shipprice, ")
				.append(" p.balanceamount    as balanceamount, p.status   as status  ")
				.append(" from packdepartinvoices p ")
				.append(" left join packdepartinvoicesdetail pd on p.id=pd.packdepartinvoicesid ")
				.append(" left join packdepartinvoicespack pdk on p.id = pdk.packdepartinvoicesid")
				.append(" left join pack pk on pdk.packid = pk.id")
				.append(" left join station s on nvl(pd.tostationid,pk.tostationid) = s.id")
				.append(" where p.datatype='1'  ");
		sbf.append(PropertyFilter.toJpql(propertyFilters, true));

		Query q = getEntityManager().createNativeQuery(sbf.toString());
		JPAPropertyFilterUtil.setParameter(q, propertyFilters);
		return q.getResultList();
	}

	
	/**
	 * 行包结算单添加查询
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> packManualaddquery(List<PropertyFilter> propertyFilters) {
		StringBuffer sbf = new StringBuffer();
		sbf.append("select p.id as id,p.sendstationid as sendstationid, p.tostationid as tostationid,   p.pieces as pieces,")
		   .append("  p.shipprice as shipprice,p.packfee as packfee, p.handfee as handfee, p.custodial as custodial,")
		   .append("  p.transitfee as transitfee,p.insuredamount as insuredamount,p.insurancefee as insurancefee,")
		   .append("   p.deliveryfee as deliveryfee,p.otherfee as otherfee, p.packprice as packprice,p.servicefee as servicefee,")
		   .append("  p.totalfee as totalfee,pc.packbalancemoney as packbalancemoney,s.name  as tostationname,p.departdate as departdate ")
		   .append(" from pack p ")
		   .append(" left join packbalance  pc on p.balanceid = pc.id ")
		   .append(" left join station  s on s.id = p.tostationid ")
		   .append(" where 1=1 ")
		   .append("")
		   .append("")
		   .append("");
		sbf.append(PropertyFilter.toJpql(propertyFilters, true));

		Query q = getEntityManager().createNativeQuery(sbf.toString());
		JPAPropertyFilterUtil.setParameter(q, propertyFilters);
		List ls = q.getResultList();
		return q.getResultList();
	}
	
	public  Pack queryPackById(Pack pack){
		StringBuffer sbf = new StringBuffer();
		sbf.append("select p from Pack p where p.id = "+ pack.getId());
		Query q = getEntityManager().createQuery(sbf.toString());
		List ls = q.getResultList();
		if(ls!=null && ls.size()>0)
			return (Pack) ls.get(0);
		else
			return pack;
	}

	public Packdepartinvoices  queryPackdepartinvoicesById(Packdepartinvoices packdepartinvoices){
		StringBuffer sbf = new StringBuffer();
		sbf.append("select p from Packdepartinvoices p where p.departinvoicesno = "+ packdepartinvoices.getDepartinvoicesno());
		Query q = getEntityManager().createQuery(sbf.toString());
		List ls = q.getResultList();
		if(ls!=null && ls.size()>0)
			return (Packdepartinvoices) ls.get(0);
		else
			return packdepartinvoices;
	}

	public List<Object> findpackAndDepinfo(String packno){
		
		StringBuffer sbf = new StringBuffer();
		sbf.append("select p.packno,p.tostationid,s.name tostationname,pd.departinvoicesno,p.shipprice,pd.balanceamount,pd.departdate,pd.vehicleid,v.vehicleno,pd.id packdepartinvoiceid ")
		.append(" from pack p,packdepartinvoices pd,packdepartinvoicespack pdp,station s,vehicle v ")
		.append(" where p.id=pdp.packid and pd.id=pdp.packdepartinvoicesid and p.tostationid=s.id and pd.vehicleid=v.id ")
		.append(" and p.packno=:packno ");
				
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		q.setParameter("packno", packno);
		
		return q.getResultList().size()>0?q.getResultList():null;
	}
	
	public boolean packManualdel(Packdepartinvoices packdepartinvoices){
		
		StringBuffer sbf = new StringBuffer();
		sbf.append(" delete from packdepartinvoices p where p.id = :id ");
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		q.setParameter("id", packdepartinvoices.getId());
		return q.executeUpdate()>0?true:false;
	}
	
	public List<Object> findpackedepartinvoiceAndDepinfo(String packdepartinvoicesno){
		
		StringBuffer sbf = new StringBuffer();
		sbf.append("select a.id from packdepartinvoices  a where a.departinvoicesno = :departinvoicesno");
				
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		q.setParameter("departinvoicesno", packdepartinvoicesno);
		
		return q.getResultList().size()>0?q.getResultList():null;
	}
	
	public boolean updatePackDepart(PackDeparVO packDeparvo){
		
		StringBuffer sbf = new StringBuffer();
		sbf.append(" update  packdepartinvoices pd set pd.datatype='1' where pd.id=:id ");
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		q.setParameter("id", packDeparvo.getPackdepartinvoicesid());
		return q.executeUpdate()>0?true:false;
	}
	
}
