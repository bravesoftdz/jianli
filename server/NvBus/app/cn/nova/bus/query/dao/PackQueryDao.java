package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackQueryDao extends EntityManagerDaoSurport {
	/**
	 * 行包发货营收统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPackShipment(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();
		// sb.append(" select p.orgid,org.name as orgname,v.vehicleno,to_char(p.departdate,'yyyy-MM-dd') as departdate,sum(p.pieces) as pieces,sum(p.shipprice) as shipprice,");
		sb.append(" select p.orgid,org.name as orgname,to_char(p.createtime,'yyyy-MM-dd') as departdate,sum(p.pieces) as pieces,sum(p.shipprice) as shipprice,");
		sb.append(" sum(p.packfee) as packfee,sum(handfee) as handfee,sum(p.custodial) as custodial,");
		sb.append(" sum(p.transitfee) as transitfee,sum(p.insurancefee) as insurancefee,");
		sb.append(" sum(p.deliveryfee) as deliveryfee,sum(p.insurance) as insurance,sum(p.otherfee) as otherfee,");
		sb.append(" sum(p.totalfee) as totalfee");
		// sb.append(" from Pack p left join Vehicle v on v.id=p.vehicleid,Organization org where org.id=p.orgid ");
		sb.append(" from Pack p ,Organization org where org.id=p.orgid ");
		// sb.append(" and p.status in('0','1') and p.packtype='0'");
		// sb.append(" and p.orgid=:orgid,and p.departdate>=:fromdate and p.departdate<=enddate and p.vehicleid=:vehicleid");

		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		// sb.append(" group by p.orgid,org.name,v.vehicleno,to_char(p.departdate,'yyyy-MM-dd')");
		sb.append(" group by p.orgid,org.name,to_char(p.createtime,'yyyy-MM-dd')");
		sb.append(" order by to_char(p.createtime,'yyyy-MM-dd') desc");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		return query.getResultList();
	}

	/**
	 * 行包提领营收统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPackReceive(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();

		// sb.append(" Select p.orgid,org.name as orgname,v.vehicleno,to_char(pk.signdate,'yyyy-MM-dd') as departdate");
		sb.append(" Select p.orgid,org.name as orgname,to_char(pk.signdate,'yyyy-MM-dd') as departdate");
		sb.append(" ,sum(p.pieces) as pieces,sum(pk.shipprice) as shipprice,sum(pk.handfee) as handfee");
		sb.append(" ,sum(pk.packfee) as packfee,sum(pk.totalfee) as totalfee,sum(pk.goodsprice) as goodsprice");
		// sb.append(" from Packpickup pk,Pack p,Vehicle v,Organization org where p.id=pk.packid");
		sb.append(" from Packpickup pk,Pack p,Organization org where p.id=pk.packid");
		// sb.append(" and v.id=p.vehicleid and org.id=pk.orgid");
		sb.append(" and org.id=pk.orgid");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		// sb.append(" group by p.orgid,org.name,v.vehicleno,to_char(pk.signdate,'yyyy-MM-dd')");
		sb.append(" group by p.orgid,org.name,to_char(pk.signdate,'yyyy-MM-dd')");
		sb.append(" order by to_char(pk.signdate,'yyyy-MM-dd') desc");

		// sb.append(" and p.orgid=:orgid,and pk.signdate>=:fromdate and pk.signdate<=enddate and p.vehicleid=:vehicleid");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		return query.getResultList();
	}

	/**
	 * 小件营收统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryGoods(List<PropertyFilter> propertyFilters,
			boolean isbysellgroup) {
		StringBuffer sb = new StringBuffer();

//		if (!isbysellgroup) {
//			sb.append(" select org.id,org.name as orgname,'' sellbyname,");
//			sb.append(" to_char(g.deposittiime,'yyyy-MM-dd') as deposittiime,sum(g.pieces) as pieces,");
//			sb.append(" sum(g.custodial) as custodial,sum(g.penalty) as penalty,sum(g.totalfee) as totalfee");
//			sb.append(" from Goods g ,Organization org where org.id=g.orgid ");
//
//			sb.append(PropertyFilter.toJpql(propertyFilters, true));
//
//			sb.append(" group by org.id,org.name,to_char(g.deposittiime,'yyyy-MM-dd')");
//			sb.append(" order by to_char(g.deposittiime,'yyyy-MM-dd') desc");
//		} else {
//			sb.append(" select org.id,org.name as orgname,u.name as sellbyname,");
//			sb.append(" to_char(g.deposittiime,'yyyy-MM-dd') as deposittiime,sum(g.pieces) as pieces,");
//			sb.append(" sum(g.custodial) as custodial,sum(g.penalty) as penalty,sum(g.totalfee) as totalfee");
//			sb.append(" from Goods g ,Organization org,Userinfo u where org.id=g.orgid and u.id=g.consignee");
//
//			sb.append(PropertyFilter.toJpql(propertyFilters, true));
//
//			sb.append(" group by org.id,org.name,u.id,u.name,to_char(g.deposittiime,'yyyy-MM-dd')");
//			sb.append(" order by to_char(g.deposittiime,'yyyy-MM-dd') desc");
//		}
		
		String orgids = null;

		Date startdate = null;
		Date enddate = null;
		Long seller =null;
		if (propertyFilters != null && propertyFilters.size() > 0) {
			for (int t = 0; t < propertyFilters.size(); t++) {
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("g!orgid")) {
					orgids = (String) propertyFilters.get(t).getMatchValue();
					continue;
				}

				if (propertyFilters.get(t).getPropertyFullName()
						.equals("g!startdate")) {
					startdate = (Date) propertyFilters.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("g!enddate")) {
					enddate = (Date) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("g!consignee")) {
					seller = (Long) propertyFilters.get(t).getMatchValue();
					continue;
				}
				
			}
		}
		
		sb.append(" select");
		sb.append(" nvl(a.orgid,b.orgid) as orgid,");
			sb.append(" nvl(a.orgname,b.orgname) as orgname,");
		
		if (!isbysellgroup) {
			sb.append(" '' as sellbyname,");
		}else{
			sb.append(" nvl(a.sellbyname,b.sellbyname) as sellbyname,");
		}
		
		sb.append(" nvl(a.sellbytime,b.sellbytime) as sellbytime,");
		sb.append(" nvl(a.goodspieces,0) as depositpieces, nvl(a.goodstotalfee,0) as depositprice,");
		sb.append(" nvl(b.goodspieces,0) as recaptionspieces,nvl(b.goodstotalfee,0) as recaptionsprice,");
		sb.append(" (nvl(a.goodstotalfee,0)+nvl(b.goodstotalfee,0)) as totalfee");
		sb.append(" from ");
		sb.append(" (");
		//sb.append("      --小件寄存");
		sb.append("      select g.orgid,o.name as orgname,");
		
		if (!isbysellgroup) {
			sb.append(" '' sellby,'' as sellbyname,");
		}else{
			sb.append("      u.id as sellby,u.name as sellbyname,");
		}
		sb.append("      to_char(g.deposittiime,'yyyy-MM-dd') as sellbytime,sum(g.pieces) as goodspieces,");
		sb.append("      sum(g.custodial) as goodstotalfee from Goods g ,Userinfo u,");
		sb.append("      Organization o where u.id=g.consignee and o.id=g.orgid");
		sb.append("      and g.status!='2' and g.orgid in" + orgids + "  ");
		sb.append("      and g.deposittiime between :startdate and :enddate");
		if(seller!=null){
			sb.append(" and u.id=:seller");
		}
		sb.append("      group by g.orgid,o.name,to_char(g.deposittiime,'yyyy-MM-dd')");
		if (isbysellgroup) {
			sb.append("      ,u.id,u.name");
		}
		sb.append(" ) a     ");
		sb.append(" full join(");
		//sb.append("      --小件提领");
		sb.append("       select g.orgid,o.name as orgname,");
		if (!isbysellgroup) {
			sb.append(" '' sellby,'' as sellbyname,");
		}else{
			sb.append("      u.id as sellby,u.name as sellbyname,");
		}
		sb.append("       to_char(g.pickupdate,'yyyy-MM-dd') as sellbytime,sum(g.pieces) as goodspieces,");
		sb.append("       sum(g.penalty) as goodstotalfee from Goods g,Userinfo u,");
		sb.append("       Organization o where u.id=g.operator and o.id=g.orgid");
		sb.append("       and g.status='1' and g.orgid in" + orgids + "  ");
		sb.append("       and g.pickupdate between :startdate and :enddate ");
		if(seller!=null){
			sb.append(" and u.id=:seller");
		}
		sb.append("       group by g.orgid,o.name,to_char(g.pickupdate,'yyyy-MM-dd')");
		if (isbysellgroup) {
			sb.append("      ,u.id,u.name");
		}
		sb.append(" ) b on a.orgid=b.orgid and a.sellbytime=b.sellbytime");
		if (isbysellgroup) {
			sb.append(" and a.sellby=b.sellby");
		}
		
		sb.append(" order by nvl(a.sellbytime,b.sellbytime) desc");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		if(seller!=null){
			query.setParameter("seller", seller);
		}
		
		return query.getResultList();
	}

	/**
	 * 车辆返款统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPackVehiclePrice(
			List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select p.orgid,org.name as orgname,v.vehicleno,to_char(p.departdate,'yyyy-MM-dd') as departdate");
		sb.append(" ,sum(p.totalfee) as totalfee");
		sb.append(" ,decode(sum(p.totalfee),0,'0.00',trim(to_char((sum(p.totalfee)*decode(pt.showvalue,0,1,pt.showvalue)),'9999999.99'))) as vehicleprice ");
		sb.append(" ,count(v.vehicleno) vehiclenum");
		sb.append(" from Pack p , Vehicle v ,Organization org");
		sb.append(" ,(select pd.orgid,nvl(pd.value,nvl(p.value,1)) showvalue from Parameter p ");
		sb.append("     left join parameterorgdetail pd on p.id=pd.parameterid ");
		sb.append("     where p.code='8015' ");
		sb.append(" ) pt ");
		sb.append(" where org.id=p.orgid and v.id=p.vehicleid");
		sb.append(" and pt.orgid=p.orgid ");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		sb.append(" group by p.orgid,org.name,v.vehicleno,to_char(p.departdate,'yyyy-MM-dd'),pt.showvalue");
		sb.append(" order by to_char(p.departdate,'yyyy-MM-dd') desc");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		return query.getResultList();
	}
	
	/**
	 * 前台明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPackDetails(float balancefeerate,
			List<PropertyFilter> propertyFilters) {
		StringBuffer sbf = new StringBuffer();

		// sbf.append("select p.DEPARTDATE , null , p.BALANCEID , u.name ,p.PIECES ,p.SHIPPRICE ,p.HANDFEE ,p.TRANSITFEE ,p.OTHERFEE ,p.TOTALFEE ,null ,null,s.name ,p.VEHICLEID ")
		sbf.append(
				"select p.DEPARTDATE as DEPARTDATE, p.packno as packno,pp.departinvoicesno as singbillno,u.name as name1,p.PIECES as PIECES,p.SHIPPRICE as SHIPPRICE,")
				.append("  p.HANDFEE as HANDFEE,p.TRANSITFEE as TRANSITFEE, p.OTHERFEE as OTHERFEE,p.TOTALFEE as TOTALFEE, p.TOTALFEE as shishoujine ,p.SHIPPRICE*")
				.append(balancefeerate)
				.append("as jiesuanjine, s.name as name2,v.vehicleno as chepaihao ,p.status as  status from PACK P ")
				.append(" left join STATION S on s.id = p.tostationid ")
				.append(" left join userinfo u on p.sellby = u.id ")
				.append(" left join vehicle v on p.vehicleid = v.id   ")
				.append(" left join PACKDEPARTINVOICESPACK ps on p.id = ps.packid   ")
				.append(" left join  PACKDEPARTINVOICES pp  on ps.packdepartinvoicesid = pp.id   ")
				.append("  where 1 = 1 and p.status = 0 and packtype = 0  and ")
				.append(PropertyFilter.toJpql(propertyFilters));
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		JPAPropertyFilterUtil.setParameter(q, propertyFilters);
		return q.getResultList();
	}

	/**
	 * 出库明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryLibraryDetails(List<PropertyFilter> propertyFilters) {
		StringBuffer sbf = new StringBuffer();

		sbf.append(
				"select  p.DEPARTDATE as DEPARTDATE,p.PACKNO     as PACKNO,s.name       as name,")
				.append(" p.status  as status, ")
				.append("  v.vehicleno  as vehicleno, p.PIECES     as PIECES, nvl(  p.SHIPPRICE ,0) as SHIPPRICE, nvl(  p.PACKPRICE,0)  as PACKPRICE, ")
				.append(" nvl( p.SERVICEFEE,0) as SERVICEFEE,nvl(  p.CUSTODIAL,0)  as CUSTODIAL, pb.BALANCBY  as BALANCBY,pb.Balancetime as Balancetime, ")
				.append(" p.updatetime   as updatetime, u.code  as code ")
				.append("  from pack p  ")
				.append(" left join station  s on s.id = p.SENDSTATIONID ")
				.append(" left join userinfo u on p.updateby = u.id ")
				.append(" left join vehicle  v on p.vehicleid = v.id ")
				.append(" left join PACKBALANCE pb on  p.BALANCEID = pb.id ")
				.append(" where 1=1 AND p.status in('2','7')  and ")
				.append(PropertyFilter.toJpql(propertyFilters));
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		JPAPropertyFilterUtil.setParameter(q, propertyFilters);
		return q.getResultList();
	}

	/**
	 * 对付明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryCollectDetail(List<PropertyFilter> propertyFilters) {
		StringBuffer sbf = new StringBuffer();

		sbf.append(
				" select s.name  as TOSTATION, v.VEHICLENO as VEHICLENO, nvl( p.PACKPRICE,0)   as PACKPRICE, p.DEPARTDATE as DEPARTDATE,")
				.append("  u.name     as SELLBY, p.packno   as packno,  pp.departinvoicesno as  packbalanceno,  p.createtime as  createtime,")
				.append("  p.RECYCLESTATUS as recyclestatus ,uu.name as RECYCLEBY,p.RECYCLEDATE as RECYCLEDATE ")
				.append(" ,p.status as  status from pack p  ")
				.append(" left join station  s on s.id = p.TOSTATIONID ")
				.append(" left join userinfo u on p.sellby = u.id ")
				.append(" left join userinfo uu on p.RECYCLEBY = uu.id ")
				.append(" left join PACKBALANCE pb on  p.BALANCEID = pb.id ")
				.append(" left join vehicle  v on v.id = p.vehicleid ")
				.append(" left join PACKDEPARTINVOICESPACK ps on p.id = ps.packid ")
				.append(" left join  PACKDEPARTINVOICES pp  on ps.packdepartinvoicesid = pp.id ")
				.append(" where  p.PAYMETHOD =1   ");
		if (propertyFilters.size() > 0) {
			sbf.append(" and ");
		}
		sbf.append(PropertyFilter.toJpql(propertyFilters));
		Query q = getEntityManager().createNativeQuery(sbf.toString());
		JPAPropertyFilterUtil.setParameter(q, propertyFilters);
		return q.getResultList();
	}
	/**
	 * 发货明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySendGoodsdGetails(
			List<PropertyFilter> propertyFilters) {
		StringBuffer sbf = new StringBuffer();
		sbf.append(" select s.name as sendstationname,")
				.append(" p.packno        as packno,ss.name   as tostationname, ")
				.append("  p.name          as packname, p.goodtype      as goodtype,")
				.append(" p.pieces        as pieces, p.weight   as weight, p.sender  as sender, ")
				.append("  p.senderphone as senderphone, p.senderaddress  as senderaddress,")
				.append(" p.consignee as consignee , p.consigneephone as consigneephone,")
				.append("  p.consigneeaddress as consigneeaddress, p.departdate as departdate, p.shiptype as shiptype,")
				.append(" p.paymethod as paymethod, p.status as  packstatus, ")
				.append(" u.name as sellby, p.singbillno as singbillno, v.vehicleno as vehicleno, trim(st.departtime)as departtime,dr.mobilephone as driverhpone, ")
				.append("  uu.name as  signby,p.signtime as signtime,")
				.append("   p.volume as volume,p.packed as packed,")
				.append(" p.shipprice as shipprice, p.packfee as packfee, ")
				.append("  p.handfee as handfee,p.transitfee as transitfee, p.insurancefee as insurancefee,p.deliveryfee as deliveryfee,")
				.append(" p.otherfee as otherfee ,p.servicefee as servicefee,p.packprice as packeprice, p.totalfee as totalfee,p.remak as remak ,")
				.append("  p.createtime as createtime ,ufo.name as createby, p.updatetime as updatetime ,uf.name  as updateby  ")
				.append("   from pack p")
				.append(" left join vehicle v on p.vehicleid = v.id")
				.append(" left join station s on p.sendstationid = s.id")
				.append(" left join station ss on p.tostationid = ss.id")
				.append(" left join userinfo  u on p.sellby = u.id")
				.append(" left join userinfo  uu on p.signby = uu.id")
				.append(" left join userinfo  ufo on p.createby = ufo.id")
				.append(" left join userinfo  uf on p.updateby = uf.id")
				.append(" left join   vehiclereport vp on vp.id = p.vehiclereportid ")
				.append(" left join   driver dr on dr.id = vp.driver1id")
				.append(" left join   schedulestatus st on vp.scheduleplanid = st.scheduleplanid  and   vp.scheduleid = st.scheduleid")
				.append(" where 1=1 and p.status=1 ");
		sbf.append(PropertyFilter.toJpql(propertyFilters, true));

		Query q = getEntityManager().createNativeQuery(sbf.toString());
		JPAPropertyFilterUtil.setParameter(q, propertyFilters);
		List ls = q.getResultList();
		return q.getResultList();
	}

}
