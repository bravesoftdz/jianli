package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.query.param.Qryparam;
import cn.nova.bus.query.vo.SaleLocalTicketQryVo;
import cn.nova.bus.query.vo.TicketsellQryVo;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketSellQryDao extends EntityManagerDaoSurport {
	public IDAO<Ticketsell> dao;
	
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

	/**
	 * 售票情况查询：售本站票
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TicketsellQryVo> query(Qryparam qp) {
		List<TicketsellQryVo> list = null;
		if (qp.getIslocalticket() == null || qp.getIslocalticket().equals("1")) {
			StringBuffer sql = new StringBuffer("select ts.id,ts.sellip,")
					.append(" ts.selltime,ts.buspark,ts.ticketentrance,ts.price,ts.fueladditionfee,ts.stationservicefee,")
					.append(" ts.discountrate,ts.fullprice,ts.distance,ts.carrychildnum,ts.departdate,trim(ts.departtime) as departtime,")
					.append(" ts.seatno,ts.ticketno,dt2.value as sellway,dt3.value as ticketstatus,dt1.value as paymethod,o.name as orgname,s.code as schedulecode,")
					.append(" stt.name as dpartname,ste.name as reachname,u.name as sellname,ts.ischecked as ischecked,ts.isdepartinvoices as isdepartinvoices, ts.iseticketsell as iseticketsell,")
					.append(" 0 as islocal,vt.name as vehicletypename,tt.name as tickettypename,ts.islinework,tos.name as ticketoutletname, ts.customername,");
					//判断身份证是否完全显示，参数取自前台
					if ("0".equals(qp.getShowfullidno())){
					sql.append(" ts.certificateno as certificateno,");	
					}else{
					sql.append(" case when ts.certificatetypename='居民身份证' then case when length(ts.certificateno) >= 18 then substr(ts.certificateno,0,10)||'****'||substr(ts.certificateno,-4,4) else ts.certificateno end else ts.certificateno end as certificateno,");
					}
					sql.append(" ts.certificatetypename, th.name as hticketoutlesname,th.address as houtletsaddress,ck.name as checkedname,")
					.append(" cks.name as checkstationname,du.name as departinvoicesbyname,ts.departinvoicesno,ts.departinvoicestime,")
					.append(" ts.servicefee,vbm.brandname as vehiclebrandmodelname,ts.checktime,ts.computefee,ts.coolairfee,ts.additionfee,")
					.append(" sp.isovertime,r.name as routename,trt.ticketprice,(trt.returnamount+ nvl(trt.returnamountweb,0)) as returnamount,ru.name as returnbyname,trt.returntime,")
					.append(" dt4.value as returnway,ts.moreprice,ts.otherfee,ts.insurefee,ts.waterfee,0 serviceprice,")
					.append(" (ts.coolairfee + ts.additionfee + ts.fueladditionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee + ts.computefee) subtotal,")
					.append(" pby.name printname,porg.name printorgname,v.vehicleno , ts.olddepartdate, ")
					.append(" case when trt.id > 0 and trt.returnfeemode = 1 then 1 when trt.id > 0 and trt.returnfeemode = 0 then  0 else 0 end returnmethod, ")
					.append(" ts.batchno ")   //禅道号 1894 十堰+售票情况查询售,增加一列“批次号”查询信息
					.append(" from Ticketsell ts")
					.append("   left join digitaldictionarydetail dt1 on ts.paymethod=dt1.code and dt1.digitaldictionaryid=50")
					.append("   left join digitaldictionarydetail dt2 on ts.sellway=dt2.code and dt2.digitaldictionaryid=51")
					.append("   left join digitaldictionarydetail dt3 on ts.ticketstatus=dt3.code and dt3.digitaldictionaryid=52 ")
					.append("   left  join customer cus on ts.customerid = cus.id ")
					.append(" Left join Vehiclebrandmodel vbm on ts.vehiclebrandmodelid = vbm.id")
					.append(" LEFT JOIN ticketoutlets th on ts.handticketoutletsid = th.id")
					.append(" LEFT JOIN station cks on ts.checkstationid = cks.id LEFT JOIN userinfo ck on ts.checkedby = ck.id")
//					.append(" LEFT JOIN vehiclereport vr on ts.vehiclereportid = vr.id left join vehicle v on v.id = vr.vehicleid ")
					//售票情况查询，取报到车辆的车牌，不取计划
					//有冗余字段了 可以直接查询
				    .append(" left join vehicle v on v.id = ts.vehicleid ")
					.append("  LEFT JOIN userinfo du on ts.departinvoicesby = du.id ")
					.append("  LEFT JOIN ticketreturn trt ON ts.id = trt.sellid  LEFT JOIN userinfo ru on trt.returnby = ru.id")
					.append("  left join digitaldictionarydetail dt4 on trt.returnway=dt4.code and dt4.digitaldictionaryid=55   ")
					//.append("  left join (select tmc.ticketsellid,tmc.olddepartdate from  ticketmixcheck tmc where  tmc.isactive = 1) tmc on ts.id = tmc.ticketsellid ")
					.append("  left join ticketsellother tso on ts.id = tso.ticketsellid left join Userinfo pby on tso.printby = pby.id   ")
					.append("  left join Organization porg on pby.orgid = porg.id left join Vehicletype vt on  v.vehicletypeid = vt.id ")
					.append(" ,Scheduleplan sp, Schedule s,Organization o, Station stt, Station ste, Route r, Userinfo u, Tickettype tt, Ticketoutlets tos ")// Schedulevehiclepeopleplan svp,
					.append(" where ts.scheduleplanid = sp.id and ts.departdate=sp.departdate  and o.id = ts.orgid   and sp.scheduleid = s.id ")
					.append("   and stt.id = ts.departstationid   and ste.id = ts.reachstationid   and u.id = ts.sellby   ")
					.append("   and tt.code = ts.tickettype   and ts.ticketoutletsid = tos.id") //and ts.scheduleplanid = svp.scheduleplanid   and svp.orderno = 0 
					.append("   and s.routeid = r.id ")
					.append("   and ts.orgid in " + qp.getSaleorgids());
			if (qp.getSellSdate() != null) {
				sql.append(" and ts.selltime between :sellSdate and :sellEdate+0.99999");
			}
			if (qp.getTicketoutletsid() != null && qp.getTicketoutletsid() > 0) {
				sql.append(" and ts.ticketoutletsid= "
						+ qp.getTicketoutletsid());
			}
			if (qp.getSchcode() != null && !qp.getSchcode().equals("")) {
			//	sql.append(" and s.code like '%" + qp.getSchcode() + "%'");
				sql.append(" and s.code= '" + qp.getSchcode() + "'");
				
			}
			if("1".equals(qp.getIsred())){
				sql.append(" and cus.isred= '1' ");	
			}
			if (qp.getSellway() != null && !qp.getSellway().equals("")) {
				sql.append(" and ts.sellway = " + qp.getSellway());
			}
			if (qp.getIslinework() != null && !qp.getIslinework().equals("")) {
				sql.append(" and sp.islinework=" + qp.getIslinework());
			}
			if (qp.getPaymethod() != null && !qp.getPaymethod().equals("")) {
				sql.append(" and ts.paymethod=" + qp.getPaymethod());
			}
			if (qp.getIsovertime() != null && !qp.getIsovertime().equals("")) {
				sql.append(" and sp.isovertime = " + qp.getIsovertime());
			}
			if (qp.getSellby() != null && qp.getSellby() > 0) {
				sql.append(" and ts.sellby=" + qp.getSellby());
			}
			if (qp.getReturnby() != null && !qp.getReturnby().equals("")) {
				sql.append(" and trt.returnby = " + qp.getReturnby());
			}
			if (qp.getTakeby() != null && !qp.getTakeby().equals("")) {
				sql.append(" and tso.printby = " + qp.getTakeby());
			}
			if (qp.getRouteid() != null && qp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + qp.getRouteid());
			}
			if (qp.getTicketstatus() != null
					&& !qp.getTicketstatus().equals("")) {
				sql.append(" and ts.ticketstatus=" + qp.getTicketstatus());
			}
			if (qp.getTicketno() != null && !qp.getTicketno().equals("")) {
				sql.append(" and ts.ticketno='" + qp.getTicketno() + "'");
			}
			if (qp.getTickettype() != null && !qp.getTickettype().equals("")) {
				sql.append(" and ts.tickettype='" + qp.getTickettype() + "'");
			}
			if (qp.getIschecked() != null && !qp.getIschecked().equals("")) {
				sql.append(" and ts.ischecked='" + qp.getIschecked() + "'");
			}
			if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
				sql.append(" and ts.departstationid=" + qp.getDepartstationid());
			}
			if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
				sql.append(" and ts.reachstationid=" + qp.getReachstationid());
			}
			if (qp.getVehicleid() != null && qp.getVehicleid() > 0) {
				sql.append(" and v.id=" + qp.getVehicleid());
			}
			if(qp.getCustomername()!=null && !"".equals(qp.getCustomername())){
				sql.append(" and ts.customername like '" + qp.getCustomername() +"'");
			}
			if(qp.getCertificateno()!=null && !"".equals(qp.getCertificateno())){
				sql.append(" and ts.certificateno = '" + qp.getCertificateno()+"'");
			}
			if(qp.getDepartSdate() != null){
				if(qp.getIsolddate()){
					//sql.append(" and  nvl(tmc.olddepartdate,sp.departdate) between :departSdate and :departEdate and ts.departdate=sp.departdate and  ts.departdate >= :departSdate -30  ")
					//.append(" and ts.departdate = sp.departdate and sp.departdate >= :departSdate - 30 and ts.departdate >= :departSdate - 30");
					//优化语句去掉混检表关联
					sql.append(" and  ts.olddepartdate between :departSdate and :departEdate and ts.departdate=sp.departdate and  ts.departdate >= :departSdate -30  ")
					.append(" and ts.departdate = sp.departdate and sp.departdate >= :departSdate - 30 and ts.departdate >= :departSdate - 30");					
				}else{
					sql.append(" and sp.departdate between :departSdate and :departEdate and ts.departdate between :departSdate and :departEdate ");
				}
			}
			if(qp.getIsShield().equals("1")){
				sql.append(" and (length(ts.ticketno) = "+qp.getTicketlength() +" or ts.sellway = '7'  or ts.sellway = '10' ) " );
			}
			if("1".equals(qp.getReturnmethod())){//
				sql.append(" and (trt.returnfeemode  = '0' or trt.returnfeemode is null) " );	
			}else if("2".equals(qp.getReturnmethod())){
				sql.append(" and trt.returnfeemode  = '1' " );	
			}
			//新添加判断是不是只查看电子票
			if("1".equals(qp.getIseticketsell())){
				sql.append(" and ts.iseticketsell= '1' ");	
			}
			Query query = getEntityManager().createNativeQuery(sql.toString(),TicketsellQryVo.class);
			
			if (qp.getSellSdate() != null) {
				query.setParameter("sellSdate", qp.getSellSdate());
				query.setParameter("sellEdate", qp.getSellEdate());
			}
			if(qp.getDepartSdate() != null){
				query.setParameter("departSdate", qp.getDepartSdate());
				query.setParameter("departEdate", qp.getDepartEdate());
			}
			long a = System.currentTimeMillis();
			list = query.getResultList();
			System.out.println(System.currentTimeMillis() - a);
		}
		if (qp.getIslocalticket() == null || qp.getIslocalticket().equals("0")) {
			StringBuffer sql = new StringBuffer(
					"select ts.id,ts.sellip,ts.selltime,ts.buspark, ts.ticketentrance,")
					.append(" ts.price,ts.fueladditionfee ,ts.stationservicefee,ts.discountrate,ts.fullprice,")
					.append(" ts.distance,ts.carrychildnum,ts.departdate,trim(ts.departtime) as departtime,")
					.append(" ts.seatno,ts.ticketno,dt2.value as sellway,dt3.value as ticketstatus,dt1.value as paymethod,o.name as orgname, ts.schedulecode,")
					.append(" stt.name as dpartname ,ste.name as reachname,u.name as sellname,0 as ischecked ,0 as isdepartinvoices, 0 as iseticketsell,")
					.append(" 1 as islocal ,'' as vehicletypename,tt.name as tickettypename,ts.islinework,tos.name as ticketoutletname,ts.customername as customername ,");
					
					if ("0".equals(qp.getShowfullidno())){
						sql.append(" ts.certificateno as certificateno,");	
					}else{
						sql.append(" case when ts.certificatetypename='居民身份证' then case when length(ts.certificateno) >= 18 then substr(ts.certificateno,0,10)||'****'||substr(ts.certificateno,-4,4) else ts.certificateno end else ts.certificateno end as certificateno,");
					}
					
					sql.append(" ts.certificatetypename, '' as hticketoutlesname,'' as houtletsaddress,'' as checkedname,")
					.append(" '' as checkstationname,'' as departinvoicesbyname,'' as departinvoicesno,null as departinvoicestime,")
					.append(" ts.servicefee,ts.vehiclebrandmodelname,null as checktime,ts.computefee,ts.coolairfee,ts.additionfee,")
					.append(" 0 as isovertime,'' as routename,trt.ticketprice,trt.returnamount,ru.name as returnbyname,trt.returntime,")
					.append(" dt4.value as returnway,ts.moreprice,ts.otherfee,ts.insurefee,ts.waterfee,ts.serviceprice,")
					.append(" (ts.coolairfee+ts.additionfee+ts.fueladditionfee+ts.waterfee+ts.insurefee+")
					.append(" ts.otherfee+ts.stationservicefee+ts.computefee) subtotal,'' as printname,'' as printorgname,v.vehicleno,ts.departdate olddepartdate, ")
					.append(" case when trt.id > 0 and trt.returnfeemode = 1 then 1 when trt.id > 0 and trt.returnfeemode = 0 then  0 else  0  end returnmethod, ")
					.append(" ts.batchno ")
					.append(" from Ticketsellagent ts ")
					.append("   left join digitaldictionarydetail dt1 on ts.paymethod=dt1.code and dt1.digitaldictionaryid=50")
					.append("   left join digitaldictionarydetail dt2 on ts.sellway=dt2.code and dt2.digitaldictionaryid=51")
					.append("   left join digitaldictionarydetail dt3 on ts.ticketstatus=dt3.code and dt3.digitaldictionaryid=52 ")
					.append("   left  join customer cus on ts.customerid = cus.id ")
					.append("    LEFT JOIN  ticketreturn trt ON ts.id = trt.sellid  LEFT JOIN userinfo ru on trt.returnby= ru.id ")
					.append("  left join digitaldictionarydetail dt4 on trt.returnway=dt4.code and dt4.digitaldictionaryid=55   ")					
					.append("  left join ticketsellother tso on ts.id = tso.ticketsellid ")
					.append("    LEFT JOIN  vehicle v on v.vehicleno = ts.vehicleno , ")
					.append("    Organization o,Station stt,Station ste,Userinfo u,Tickettype tt,Ticketoutlets tos")
					.append("  where o.id = u.orgid and stt.id = ts.departstationid and ste.id = ts.reachstationid ")
					.append("    and u.id = ts.sellby and tt.code = ts.tickettype and ts.ticketoutletsid = tos.id ");
					if(qp.getDepartSdate() != null){
						sql.append("    and ts.departdate between :departSdate and :departEdate");
					}
					sql.append("    and u.orgid in " + qp.getSaleorgids());
			if (qp.getSellSdate() != null) {
				sql.append(" and ts.selltime between :sellSdate and :sellEdate+0.99999");
			}
			if (qp.getVehicleid() != null && qp.getVehicleid() > 0) {
				sql.append(" and v.id=" + qp.getVehicleid());
			}
			if (qp.getTakeby() != null && !qp.getTakeby().equals("")) {
				sql.append(" and tso.printby = " + qp.getTakeby());
			}
			if (qp.getSchcode() != null && !qp.getSchcode().equals("")) {
				sql.append(" and ts.schedulecode= '" + qp.getSchcode() + "'");
			}
			if("1".equals(qp.getIsred())){
				sql.append(" and cus.isred= '1' ");	
			}
			if (qp.getTicketoutletsid() != null && qp.getTicketoutletsid() > 0) {
				sql.append(" and ts.ticketoutletsid= "
						+ qp.getTicketoutletsid());
			}
			if (qp.getSellway() != null && !qp.getSellway().equals("")) {
				sql.append(" and ts.sellway = " + qp.getSellway());
			}
			if (qp.getPaymethod() != null && !qp.getPaymethod().equals("")) {
				sql.append(" and ts.paymethod=" + qp.getPaymethod());
			}
			if (qp.getSellby() != null && qp.getSellby() > 0) {
				sql.append(" and ts.sellby=" + qp.getSellby());
			}
			if (qp.getReturnby() != null && !qp.getReturnby().equals("")) {
				sql.append(" and trt.returnby = " + qp.getReturnby());
			}
			if (qp.getTicketstatus() != null
					&& !qp.getTicketstatus().equals("")) {
				sql.append(" and ts.ticketstatus=" + qp.getTicketstatus());
			}
			if (qp.getTicketno() != null && !qp.getTicketno().equals("")) {
				sql.append(" and ts.ticketno='" + qp.getTicketno() + "'");
			}
			if (qp.getTickettype() != null && !qp.getTickettype().equals("")) {
				sql.append(" and ts.tickettype='" + qp.getTickettype() + "'");
			}
			if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
				sql.append(" and ts.departstationid=" + qp.getDepartstationid());
			}
			if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
				sql.append(" and ts.reachstationid=" + qp.getReachstationid());
			}
			if(qp.getCustomername()!=null && !"".equals(qp.getCustomername())){
				sql.append(" and ts.customername like '" + qp.getCustomername() +"'");
			}
			if(qp.getCertificateno()!=null && !"".equals(qp.getCertificateno())){
				sql.append(" and ts.certificateno = '" + qp.getCertificateno()+"'");
			}
			if("1".equals(qp.getReturnmethod())){//
				sql.append(" and (trt.returnfeemode  = '0' or trt.returnfeemode is null) " );	
			}else if("2".equals(qp.getReturnmethod())){
				sql.append(" and trt.returnfeemode  = '1' " );	
			}
//			//新添加判断是不是只查看电子票
//			if("1".equals(qp.getIseticketsell())){
//				sql.append(" and ts.iseticketsell= '1' ");	
//			}
			Query query = getEntityManager().createNativeQuery(sql.toString(),TicketsellQryVo.class);
			if(qp.getDepartSdate() != null){
				query.setParameter("departSdate", qp.getDepartSdate());
				query.setParameter("departEdate", qp.getDepartEdate());
			}
			if (qp.getSellSdate() != null) {
				query.setParameter("sellSdate", qp.getSellSdate());
				query.setParameter("sellEdate", qp.getSellEdate());
			}
			long b = System.currentTimeMillis();
			if (list == null) {
				list = query.getResultList();
			} else {
				list.addAll(query.getResultList());
			}
			System.out.println(System.currentTimeMillis() - b);
		}
		return list;
		
	}

	/**
	 * 售票情况查询：售异站票
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryAgent(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select ts.sellip,ts.selltime,ts.buspark, ts.ticketentrance,ts.price,ts.fueladditionfee ,ts.stationservicefee,")
				.append(" ts.discountrate,ts.fullprice,ts.distance,ts.carrychildnum,ts.departdate,trim(ts.departtime),ts.seatno,ts.ticketno,ts.sellway, ts.ticketstatus,")
				.append(" ts.paymethod,o.name as orgname, ts.schedulecode,stt.name as dpartname ,ste.name as reachname,")
				.append(" u.name as sellname, ")
				.append(" 0 as ischecked ,0 as isdepartinvoices ,1 as islocal ,'' as vehicletypename,tt.name as tickettypename, ")
				.append(" ts.islinework,tos.name as ticketoutletname ,cc.name as customername , '' as hticketoutlesname,")
				.append(" '' as houtletsaddress,'' as checkedname,'' as checkstationname ,'' as departinvoicesbyname,'' as departinvoicesno ,")
				.append(" '' as departinvoicestime,ts.serviceprice as otherfee,ts.vehiclebrandmodelname,'' as checktime,")
				.append(" ts.computefee,ts.coolairfee,ts.additionfee,ts.orderno,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice")
				.append(" from Ticketsellagent ts LEFT JOIN ts.customer cc ,Organization o,Station stt,Station ste, ")
				.append(" Userinfo u,Tickettype tt,Ticketoutlets tos ")
				.append(" where o.id = ts.orgid and stt.id = ts.departstationid and ste.id = ts.reachstationid ")
				.append(" and u.id = ts.sellby and tt.code = ts.tickettype ")
				.append(" and ts.ticketoutletsid = tos.id  ");
		String code = changeFilter(propertyFilterList);
		if (code != null) {
			sql = sql.append(" and ts.schedulecode like '%" + code + "%'");
		}

		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ts.selltime desc ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 预售本站票查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPerselllocal(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select ts.stationservicefee,ts.selltime,ts.departdate,trim(ts.departtime),ts.sellip,"
						+ "ts.price,ts.seatno,ts.ticketno,ts.ticketstatus,tol.name as ticketoutlestname,"
						+ "us.name as sellname,o.name as orgname,std.name as departstationname,str.name as reachstationname,"
						+ "s.code as schedulecode,tt.name as tickettypename,0 as islocal,"
						+ "ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice,"
						+ "( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal "
						+ ", ts.paymethod from Ticketsell ts,Scheduleplan sp,Schedule s,Organization o,Station std,Station str,"
						+ "Userinfo us,Tickettype tt,Ticketoutlets tol "
						+ " where ts.scheduleplanid = sp.id and o.id = ts.orgid and sp.scheduleid =s.id"
						+ " and std.id = ts.departstationid and str.id = ts.reachstationid and us.id = ts.sellby"
						+ " and tt.code = ts.tickettype and ts.ticketoutletsid = tol.id "
						+ " and to_date(ts.selltime) < ts.departdate ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ts.selltime desc ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 预售异站票查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPersellother(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select ts.stationservicefee,ts.selltime,ts.departdate,trim(ts.departtime),ts.sellip,")
				.append(" ts.price,ts.seatno,ts.ticketno,ts.ticketstatus,tol.name as ticketoutlestname,")
				.append(" us.name as sellname,o.name as orgname,std.name as departstationname,")
				.append(" str.name as reachstationname,ts.schedulecode,tt.name as tickettypename,1 as islocal,")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal, ")
				.append(" ts.paymethod").append(" from Ticketsellagent ts ,Ticketoutlets tol,")
				.append(" Station std,Station str, Userinfo us ,Organization o,Tickettype tt ")
				.append(" where ts.ticketoutletsid = tol.id and ts.departstationid =std.id and tt.code = ts.tickettype  ")
				.append(" and ts.reachstationid = str.id and ts.sellby= us.id and us.orgid = o.id")
				.append(" and to_date(ts.selltime) < ts.departdate ");
		String code = changeFilter(propertyFilterList);
		if (code != null) {
			sql = sql.append(" and ts.schedulecode like '%" + code + "%'");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ts.selltime desc ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	private String changeFilter(List<PropertyFilter> propertyFilterList) {
		String code = null;
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("svp!planunitid")) {
					propertyFilterList.remove(t);
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!id")) {
					propertyFilterList.remove(t);
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!code")) {
					code = (String) propertyFilterList.get(t).getMatchValue();
					propertyFilterList.remove(t);
				}
			}
		}
		return code;
	}

	/**
	 * 车票改签情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketchange(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select c.changetime,c.olddepartdate,c.newdepartdate,c.oldticketno,")
				.append("c.newticketno,c.oldseatno,c.newseatno,c.changeip,c.remarks,")
				.append("ots.tickettype,ots.price,ots.stationservicefee,")
				.append("osu.name as sellname, csu.name as changebyname,")
				.append("ct.name as changeticketoutlets,trim(ots.departtime) as olddeparttime,")
				.append("trim(nts.departtime) as newdeparttime,os.code as oldschedulecode ,")
				.append("ns.code as newschedulecode,o.name as orgname,tt.name as tickettypename,")
				.append("ots.computefee,ots.coolairfee,ots.additionfee,ots.waterfee,ots.insurefee,ots.otherfee,ots.moreprice, ")
				.append("( ots.computefee + ots.coolairfee + ots.additionfee + ots.waterfee + ots.insurefee + ots.otherfee + ")
				.append(" ots.stationservicefee ) as subtotal,nts.servicefee,c.changeticketno,nts.paymethod ")
				.append(" from Ticketchange c ,Ticketsell ots ,Ticketsell nts,Schedule os,")
				.append(" Schedule ns,Userinfo osu,Userinfo csu,Ticketoutlets ct,Organization o,Tickettype tt")
				.append(" where c.oldticketsellid = ots.id and c.newticketsellid = nts.id")
				.append(" and c.oldscheduleid = os.id and c.newscheduleid = ns.id")
				.append(" and ots.sellby = osu.id and c.changeby = csu.id")
				.append(" and c.ticketoutletsid = ct.id and ots.orgid = o.id and tt.code = ots.tickettype ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		
		sql.append(" union all ");		
		sql.append("select c.changetime, c.olddepartdate,c.newdepartdate,c.oldticketno,c.newticketno,");
		sql.append(" c.oldseatno,c.newseatno,c.changeip,c.remarks,ots.tickettype,ots.price,");
		sql.append(" ots.stationservicefee,osu.name as sellname,csu.name as changebyname,ct.name as changeticketoutlets,");
		sql.append(" trim(ots.departtime) as olddeparttime,trim(nts.departtime) as newdeparttime,os.code as oldschedulecode,");
		sql.append(" nts.schedulecode as newschedulecode,o.name as orgname,tt.name as tickettypename,ots.computefee,");
		sql.append(" ots.coolairfee,ots.additionfee,ots.waterfee,ots.insurefee,ots.otherfee,ots.moreprice,");
		sql.append(" (ots.computefee + ots.coolairfee + ots.additionfee + ots.waterfee + ots.insurefee + ots.otherfee + ots.stationservicefee) as subtotal,");
		sql.append(" nts.servicefee,c.changeticketno,nts.paymethod");
		sql.append(" from Ticketchange c,Ticketsell ots,Ticketsellagent nts,Schedule os,");
		sql.append(" Userinfo osu,Userinfo csu,Ticketoutlets ct,Organization o,Tickettype tt");
		sql.append(" where c.oldticketsellid = ots.id and c.newticketsellid = nts.id");
		sql.append(" and c.oldscheduleid = os.id and ots.sellby = osu.id and c.changeby = csu.id");
		sql.append(" and c.ticketoutletsid = ct.id and ots.orgid = o.id and tt.code = ots.tickettype");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
	   sql.append(" union all ");	   
	   sql.append(" select c.changetime,c.olddepartdate,c.newdepartdate,c.oldticketno,c.newticketno,");
	   sql.append(" c.oldseatno,c.newseatno,c.changeip,c.remarks,ots.tickettype,ots.price,");
	   sql.append(" ots.stationservicefee,osu.name as sellname,csu.name as changebyname,ct.name as changeticketoutlets,");
	   sql.append(" trim(ots.departtime) as olddeparttime,trim(nts.departtime) as newdeparttime,");
	   sql.append(" ots.schedulecode as oldschedulecode,ns.code as newschedulecode,o.name as orgname,");
	   sql.append(" tt.name as tickettypename,ots.computefee,ots.coolairfee,ots.additionfee,");
	   sql.append(" ots.waterfee,ots.insurefee,ots.otherfee,ots.moreprice,");
	   sql.append(" (ots.computefee + ots.coolairfee + ots.additionfee + ots.waterfee + ots.insurefee + ots.otherfee + ots.stationservicefee) as subtotal,");
	   sql.append(" nts.servicefee,c.changeticketno,nts.paymethod");
	   sql.append("  from Ticketchange c, Ticketsellagent ots,");
	   sql.append("       Ticketsell nts, Schedule ns, Schedule os, Userinfo osu,");
	   sql.append("       Userinfo csu, Ticketoutlets ct, Organization o, Tickettype tt");
	   sql.append(" where c.oldticketsellid = ots.id and c.newticketsellid = nts.id");
	   sql.append("   and c.newscheduleid = ns.id and ots.sellby = osu.id and c.oldscheduleid = os.id");
	   sql.append("   and c.changeby = csu.id and c.ticketoutletsid = ct.id");
	   sql.append("   and ots.orgid = o.id and tt.code = ots.tickettype");
	   sql.append(PropertyFilter.toJpql(propertyFilterList, true));
	   
	   Query query = getEntityManager().createNativeQuery(sql.toString());
		//sql.append(" order by c.changetime desc ");
		//Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);

		return query.getResultList();
	}

	/**
	 * 留票情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryReserveTicket(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select sr.fullprice,sr.seatno,sr.serviceprice,sr.carrychildnum,")
				.append("sr.isautocancel,sr.autocanceltime,sr.reservetime,sr.reserveip,")
				.append("sr.reserveway,sr.sellstate,sr.remarks,sr.canceltime, sr.departdate,")
				.append("trim(sr.departtime),s.code as schedulecode,std.name as departstationname,")
				.append("ct.name as customername,str.name as reachstationname,usr.name as reservebyname,")
				.append("uc.name as cencelbyname,o.name as orgname,tt.name as tickettypename,")
				.append("tos.name as ticketoutletsname,ct.certificateno ")
				.append(" from Seatreserve sr LEFT JOIN station std on sr.departstationid = std.id")
				.append(" LEFT JOIN station str on sr.reachstationid= str.id ")
				.append(" LEFT JOIN userinfo uc on sr.cancelby= uc.id ")
				.append(" LEFT JOIN customer ct on sr.customerid=ct.id")
				.append(" left join Tickettype tt on sr.tickettype = tt.code ,")
				.append("Schedule s,Organization o ,Ticketoutlets tos,Userinfo usr ")
				.append(" where  sr.scheduleid = s.id  and sr.ticketoutletsid= tos.id ")
				.append(" and sr.reserveby = usr.id and sr.orgid = o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by sr.reservetime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 退本站票情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketreturn(
			List<PropertyFilter> propertyFilterList, String schedulecode,
			Long routeid,Qryparam qp) {
		StringBuilder sql = new StringBuilder(
				"select ts.selltime,ts.ticketno,tr.isselfschedule as islocal,tr.ticketprice, ")
				.append(" nvl(tr.returnamountweb,0) + tr.returnamount as  returnamount,tr.returnvoucherno,tr.returntime,tr.returnip,tr.returnway, ")
				.append(" nvl(tr.chargesweb,0)+ tr.charges as  charges,retby.name as returnbyname,retby.code as returnbycode, ")
				.append(" sellby.name as sellbyname,ts.stationservicefee,s.code as schedulecode, ")
				.append(" ts.departdate,trim(ts.departtime),ts.seatno,sellorg.name as orgname,bp.name as billbypename, ")
				.append(" bp.code as billcode,str.name as reachstationname, ")
				.append(" std.name as departstationname,tr.remarks,tos.name as ticketoutletsname,scheduleorg.name as scheduleorgname, ")
				.append(" ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal, ")
				.append(" r.name as routename")
				.append(" , decode(tr.returnway, 1, '', 2, '',tsg.charges ) as signcharges  ")
				.append(" , decode(tr.returnway, 1, '', 2, '',uus.name ) as signbyname ")
				.append(" , decode(tr.returnway, 1, '', 2, '',tsg.signreason ) as signreason ")
				.append(" , decode(tr.returnway, 1, '', 2, '',to_char(tsg.signtime,'yyyy/mm/dd HH:MM:ss') ) as signtime,tr.chargesweb  ")
				.append(" , decode(tr.returnfeemode,1,1,0) as returnmethod ")
				.append(" from Ticketreturn tr left join billtype bp on tr.billtypeid = bp.id, ")
				.append(" Ticketsell ts")
				.append(" left join Ticketsign tsg on tsg.sellid = ts.id and tsg.isselfschedule = 1 left ")
				.append("join Userinfo uus on tsg.signby = uus.id, Userinfo retby, Userinfo sellby, ")
                .append("Station str, Station std, Route r,")
				.append(" Schedule s,Organization sellorg,Ticketoutlets tos,Organization scheduleorg")
				// ,Ticketturnoverdetail turnde
				.append(" where tr.sellid=ts.id  and tr.returnby =retby.id and tr.ticketoutletsid = tos.id and s.routeid = r.id ")
				// and tr.isselfschedule =00为不是本站买的票//and tr.isselfschedule =1
				// and ts.sellby not in('0')
				.append(" and tr.returnway <> '3' ") //过滤掉改签退票
				.append(" and sellby.id = ts.sellby and ts.scheduleid = s.id and ts.departstationid= std.id")
				.append(" and ts.reachstationid=str.id and ts.orgid= sellorg.id and s.orgid = scheduleorg.id ");
		if (schedulecode != null && !schedulecode.equals("")) {
			sql.append(" and s.code like '%" + schedulecode + "%' ");
		}
		if (routeid != null && routeid > 0) {
			sql.append(" and r.id = " + routeid + " ");
		}
		if("1".equals(qp.getReturnmethod())){//
			sql.append(" and (tr.returnfeemode  = '0' or tr.returnfeemode is null) " );	
		}else if("2".equals(qp.getReturnmethod())){
			sql.append(" and tr.returnfeemode  = '1' " );	
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tr.returntime desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 本站废票情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketCancel(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select  co.name as cancelstationname , tc.canceltime, ts.ticketno,"
						+ "ts.departdate,trim(ts.departtime), ts.seatno, std.name as departstationname,"
						+ "str.name as reachstationname,tt.name as tickettypename,ts.stationservicefee,"
						+ "sellby.name as sellbyname,sellby.code as sellbycode,ts.selltime,"
						+ "cancelby.code as cancelbycode,cancelby.name as cancelbyname,"
						+ "tc.cancelip,tc.remarks, s.code as schedulecode, tc.isselfschedule as islocal,"
						+ "tc.cancelway,tc.ticketprice,")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal ")
				.append(" from Ticketcancel tc,"
						+ "Ticketsell ts,Userinfo cancelby,Userinfo sellby,"
						+ "Station str,Station std,Organization o,"
						+ "Tickettype tt,Schedule s,Organization co")
				.append(" where tc.sellid = ts.id and ts.departstationid = std.id "
						+ " and ts.reachstationid = str.id and ts.tickettype = tt.code and ts.sellby = sellby.id "
						+ " and cancelby.id = tc.cancelby and s.orgid = o.id and ts.orgid= co.id "
						+ " and ts.scheduleid = s.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tc.canceltime desc  ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 异站废票情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketCancelOther(
			List<PropertyFilter> propertyFilterList) {
		String code = null;
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!code")) {
					code = (String) propertyFilterList.get(t).getMatchValue();
					propertyFilterList.remove(t);
				}
			}
		}
		StringBuilder sql = new StringBuilder(
				"select  co.name as cancelstationname , tc.canceltime, ts.ticketno,")
				.append("ts.departdate,trim(ts.departtime), ts.seatno, std.name as departstationname,")
				.append("str.name as reachstationname,tt.name as tickettypename,ts.stationservicefee,")
				.append("sellby.name as sellbyname,sellby.code as sellbycode,ts.selltime,")
				.append("cancelby.code as cancelbycode,cancelby.name as cancelbyname,")
				.append("tc.cancelip,tc.remarks, ts.schedulecode, tc.isselfschedule as islocal,")
				.append("tc.cancelway,tc.ticketprice,")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal ")
				.append(" from Ticketcancel tc,")
				.append("Ticketsellagent ts,Userinfo cancelby,Userinfo sellby,")
				.append("Station str,Station std, Organization o,")
				.append("Tickettype tt,Organization co")
				.append(" where tc.sellid = ts.id and ts.departstationid = std.id ")
				.append(" and ts.reachstationid = str.id and ts.tickettype = tt.code and ts.sellby = sellby.id ")
				.append(" and cancelby.id = tc.cancelby and ts.orgid = o.id and sellby.orgid= co.id ");
		if (code != null) {
			sql.append(" and ts.schedulecode like '" + code + "' ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tc.canceltime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		
		List<Object> list = query.getResultList();
		
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int i = 0; i < propertyFilterList.size(); i++) {
				PropertyFilter pf = propertyFilterList.get(i);
				if (pf.getPropertyFullName().equals("o!id")) {
					propertyFilterList.remove(i);
					break;
				}
			}
		}

		StringBuilder sql2 = new StringBuilder(
				"select  co.name as cancelstationname , tc.canceltime, ts.ticketno,")
				.append("ts.departdate,trim(ts.departtime), ts.seatno, ts.departstationname as departstationname,")
				.append("ts.reachstationname as reachstationname,tt.name as tickettypename,ts.stationservicefee,")
				.append("sellby.name as sellbyname,sellby.code as sellbycode,ts.selltime,")
				.append("cancelby.code as cancelbycode,cancelby.name as cancelbyname,")
				.append("tc.cancelip,tc.remarks, ts.schedulecode, tc.isselfschedule as islocal,")
				.append("tc.cancelway,tc.ticketprice,")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal ")
				.append(" from Ticketcancel tc,")
				.append("Ticketsellagent ts,Userinfo cancelby,Userinfo sellby,")
				
				.append("Tickettype tt,Organization co")
				.append(" where tc.sellid = ts.id  ")
				.append(" and ts.departstationname is not null and ts.reachstationname is not null and ts.tickettype = tt.code and ts.sellby = sellby.id ")
				.append(" and cancelby.id = tc.cancelby and ts.orgname is not null and sellby.orgid= co.id ");
		if (code != null) {
			sql2.append(" and ts.schedulecode like '" + code + "' ");
		}
		sql2.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql2.append(" order by tc.canceltime desc ");
		Query query2 = getEntityManager().createNativeQuery(sql2.toString());
		JPAPropertyFilterUtil.setParameter(query2, propertyFilterList);

		list.addAll(query2.getResultList());
		return list;
	}

	/**
	 * 坏票登记情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBilldamaged(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name as orgname,t.name as ticketoutletname,u.name as recordbyname,"
						+ "bt.name as billtypename, b.recordtime,b "
						+ " from Billdamaged b,Organization o,Ticketoutlets t,Userinfo u,Billtype bt"
						+ " where b.ticketoutletsid = t.id and t.orgid = o.id and b.recordby= u.id "
						+ "and b.billtypeid = bt.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by  b.recordtime desc ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 异站退本站票情况查询 (修改了只要售票机构不等于班次机构， 班次机构为用户机构，就符合。适用集中式和分布式)
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryReturnLocla(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select ts.selltime,ts.ticketno,tr.ticketprice,")
				.append("tr.returnamount,tr.returnvoucherno,tr.returntime,tr.returnip,tr.returnway,")
				.append("tr.charges,retby.name as returnbyname,retby.code as returnbycode,")
				.append("sellby.name as sellbyname,ts.stationservicefee,s.code as schedulecode,")
				.append("ts.departdate,trim(ts.departtime),ts.seatno,o.name as orgname,bp.name as billbypename,")
				.append("bp.code as billcode,str.name as reachstationname,")
				.append("std.name as departstationname,tr.remarks,reto.name as returnorgname, ")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal, ")
				.append(" r.name as routename ")
				.append(" from Ticketreturn tr LEFT JOIN tr.billtype bp, ")
				.append(" Ticketsell ts,Userinfo retby,Userinfo sellby,Station str,Station std,")
				.append(" Route r,Schedule s,Organization o,Organization reto")
				.append(" where tr.sellid=ts.id  and tr.returnby =retby.id and tr.isselfschedule =1 and ts.orgid<>reto.id ")
				// 0为不是本站买的票//and tr.isselfschedule =1 and ts.sellby not in('0')
				.append(" and sellby.id = ts.sellby and ts.scheduleid = s.id and ts.departstationid= std.id")
				.append(" and r.id = s.route.id ")
				.append(" and ts.reachstationid=str.id and ts.orgid = o.id and ts.orgid<>s.orgid and retby.orgid=reto.id ");// and
																															// ts.sellby
																															// =
																															// 0
																															// and
																															// tr.returnby=0
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tr.returntime desc  ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 分布式、集中式异站售本站票 (异站售本站ticketsell )
	 * 
	 * @param propertyFilterList
	 * @param qp 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SaleLocalTicketQryVo> queryFocusSaleLocal(
			List<PropertyFilter> propertyFilterList,long orgid, Qryparam qp) {
		
		String orgsql = "select org.name from Organization org where org.id="+orgid;
		Query queryorg = getEntityManager().createNativeQuery(orgsql.toString());
		String orgname = (String) queryorg.getResultList().get(0);
		StringBuilder sql = new StringBuilder()
				.append("select ts.id as id ,trim('"+orgname+"') as currorgname,ts.orderno as orderno,dt4.value  as returnway,")
				.append(" (case tso.istaked when 1 then '是' else '否' end) as istaked,to_char(tso.taketime,'yyyy-mm-dd hh24:mi:ss') as taketime,dt2.value as sellway,dt1.value as paymethod,")
				.append(" ts.sellip as sellip ,ts.selltime as selltime,ts.buspark as buspark,ts.price as price,ts.discountrate as discountrate,ts.fullprice as fullprice,")
				.append(" ts.distance as distance,ts.islinework as islinework,ts.ticketentrance as ticketentrance,ts.departdate as departdate,")
				.append(" trim(ts.departtime) as departtime,ts.seatno as seatno,ts.ticketno as ticketno,dt3.value  as ticketstatus, ")
				.append(" ts.tickettype as tickettype,ts.stationservicefee as stationservicefee,ts.ischecked as ischecked,ts.checktime as checktime,")
				.append(" ck.name as checkedname,cks.name as checkstationname,")
				.append(" usby.name as sellname,sre.name as reachstationname,")
				.append(" sd.name as departstationname,s.code as schedulecode,")
				.append(" tt.name as tickettypename,'' as agentname,tr.remarks as remarks,tr.charges as charges,")
				.append(" tr.returnip as returnip,tos.name as ticketoutletname ,tol.name as returnsationname, ")
				.append(" re.name as returnbyname,tr.returntime as returntime, ")
				.append(" (case sp.islinework when 0 then (select vt.name from Schedulevehiclepeopleplan svp, Vehicletype vt ")
				.append(" where ts.scheduleplanid = svp.scheduleplanid and svp.planvehicletypeid = vt.id) else ")
				.append(" (case ts.ischecked when 0 then '' else (select vt.name from Vehicletype vt, Vehicle v, Vehiclereport vr ")
				.append(" where vr.id=ts.vehiclereportid and vr.vehicleid=v.id and v.vehicletypeid=vt.id) end) end) vehicletypename, ")
				.append(" o.name as orgname,ts.isdepartinvoices as isdepartinvoices, ")
				.append("ts.computefee as computefee,ts.coolairfee as coolairfee,ts.additionfee as additionfee,ts.waterfee as waterfee,ts.insurefee as insurefee,ts.otherfee as otherfee,ts.moreprice as moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal, ")
				.append(" r.name as routename , nvl(ts.olddepartdate,ts.departdate) as olddepartdate, ")
				.append(" decode(soi.orderno,null,0,1) as manualreturnnum,decode(soi.orderno,null,0,ts.price) as manualreturnmoney ")
				.append(" from Ticketsell ts LEFT JOIN station cks on ts.checkstationid=cks.id ")
				.append("   left join digitaldictionarydetail dt1 on ts.paymethod=dt1.code and dt1.digitaldictionaryid=50")
				.append("   left join digitaldictionarydetail dt2 on ts.sellway=dt2.code and dt2.digitaldictionaryid=51")
				.append("   left join digitaldictionarydetail dt3 on ts.ticketstatus=dt3.code and dt3.digitaldictionaryid=52 ")
				.append(" left join ticketsellother tso on ts.id=tso.ticketsellid ")
				.append(" LEFT JOIN userinfo ck on ts.checkedby=ck.id ")
				.append(" LEFT JOIN  Ticketreturn tr ON ts.id= tr.sellid left join userinfo re on tr.returnby= re.id ")
				.append("  left join digitaldictionarydetail dt4 on tr.returnway=dt4.code and dt4.digitaldictionaryid=55   ")
				.append(" left join specialorderinfo soi on soi.orderno=ts.orderno ")  //增加手工退票数和手工退还乘客票款两个列信息（20180523，禅道号20437，应城汽车客运站）
				.append(" left join Ticketoutlets tol on tr.ticketoutletsid =tol.id,Userinfo usby, ")
				.append(" Station sre,Station sd ,Scheduleplan sp,Route r,Schedule s,Tickettype tt ,")
				.append(" Ticketoutlets tos ,Organization o, Organization scheduleorg ")
//				.append(" where ts.reachstationid = sre.id and s.orgid=scheduleorg.id ")
				.append(" where ts.reachstationid = sre.id ")
				.append(" and ts.departstationid = sd.id and tt.code = ts.tickettype  ")
				.append(" and r.id = s.routeid  and scheduleorg.stationid = ts.departstationid")
				.append(" and ts.scheduleplanid=sp.id  and sp.scheduleid = s.id and ts.sellby = usby.id ")
				.append(" and ts.ticketoutletsid = tos.id and ts.orgid = o.id and scheduleorg.id != o.id ");
		if(qp.getDepartSdate()!=null ){
			if (qp.getIsolddate()){
				sql.append(" and  nvl(ts.olddepartdate,ts.departdate) between :departSdate and :departEdate  ");
			}else{
				sql.append(" and ts.departdate between :departSdate and :departEdate ");
			}
		}		 
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ts.selltime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString(),SaleLocalTicketQryVo.class);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		if(qp.getDepartSdate()!=null){
		query.setParameter("departSdate", qp.getDepartSdate());
		query.setParameter("departEdate", qp.getDepartEdate());
		}
		
		return query.getResultList();

	}

	/**
	 * 分布式、集中式本站售异站票查询 （本站售异站ticketsell）
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryFocusSaleOther(
			List<PropertyFilter> propertyFilterList, String scheduleorgid,
			Long sellorgid) {
		
		String orgsql = "select org.name from Organization org where org.id="+sellorgid;
		Query queryorg = getEntityManager().createNativeQuery(orgsql.toString());
		String orgname = (String) queryorg.getResultList().get(0);
		
		StringBuilder sql = new StringBuilder(
				"select trim('"+orgname+"') as sellorgname,tio.name as ticketoutletsname,ts.orderno,ts.distance,ts.ticketentrance ticketentrance,ts.departdate departdate,");
		sql.append(
				" trim(ts.departtime) departtime,ts.sellip sellip,ts.fullprice fullprice,ts.tickettype,tr.returnway,")
				.append(" ts.sellway, ts.paymethod,ts.price price,ts.seatno seatno,")
				.append(" ts.ticketno ticketno,ts.selltime selltime,ts.ticketstatus ticketstatus,")
				.append(" us.name as sellname, ts.schedulecode schedulecode,")
				.append(" tr.remarks remarks,tr.charges charges,tr.returnip returnip,tr.returntime returntime,")
				.append(" tol.name as returnsationname,re.name as returnbyname,")
				.append(" std.name as departstationname ,str.name as reachstationname,o.name as orgname,ts.stationservicefee, ")
				.append(" ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append(" ( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal ")
				.append(" from Ticketsellagent ts left join Ticketreturn tr on ts.id = tr.sellid ")
				.append(" left join Ticketoutlets tio on ts.ticketoutletsid=tio.id")
//				.append(" left join Organization org on tio.orgid=org.id")
				.append(" left join userinfo re on tr.returnby= re.id ")
				.append(" left join Ticketoutlets tol on tr.ticketoutletsid =tol.id,")
				.append(" Station std,Station str, Userinfo us ,Organization o ")
				.append(" where std.id = ts.departstationid and ts.reachstationid = str.id ")
				.append(" and ts.sellby = us.id and ts.orgid = o.id ")
				.append(" and ts.orgid in ")
				.append(scheduleorgid);
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
				// sql.append(" order by ts.selltime desc ")
		//本售异不存入ticketsell表，注释此段，liyi 20160225
				/*.append(" union select trim('"+orgname+"') as sellorgname,tio.name as ticketoutletsname,ts.orderno,ts.distance, ts.ticketentrance ticketentrance, ts.departdate departdate,")
				.append("trim(ts.departtime) departtime,ts.sellip sellip,ts.fullprice fullprice,ts.tickettype,tr.returnway,")
				.append(" ts.sellway, ts.paymethod,ts.price price,ts.seatno seatno,")
				.append("ts.ticketno ticketno,ts.selltime selltime,ts.ticketstatus ticketstatus,")
				.append(" us.name as sellname, s.code schedulecode,")
				.append(" tr.remarks remarks,tr.charges charges,tr.returnip returnip,tr.returntime returntime,")
				.append(" tol.name as returnsationname,re.name as returnbyname,")
				.append(" std.name as departstationname ,str.name as reachstationname,o.name as orgname,ts.stationservicefee, ")
				.append(" ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append(" ( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal ")
				.append(" from Ticketsell ts left join Ticketreturn tr on ts.id = tr.sellid ")
				.append(" left join Ticketoutlets tio on ts.ticketoutletsid=tio.id")
//				.append(" left join Organization org1 on tio.orgid=org1.id ")
				.append(" left join userinfo re on tr.returnby= re.id ")
				.append(" left join Ticketoutlets tol on tr.ticketoutletsid =tol.id,")
				.append(" Station std,Station str, Userinfo us ,Organization org, ")
				.append("  schedule s, route r ,Organization o ")
				.append(" where std.id = ts.departstationid and ts.reachstationid = str.id ")
				.append(" and org.id=")
				.append(sellorgid)
//				.append(" and ts.scheduleid=s.id and s.routeid=rs.routeid and rs.stationid = ts.reachstationid")
				.append(" and ts.sellby = us.id  and ts.scheduleid=s.id ")
				.append(" and s.routeid=r.id and r.orgid=o.id and ts.orgid!=o.id and o.id in ")// and
																								// std.id!=org.stationid
				.append(scheduleorgid);
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));*/

		sql.append(
				" union select trim('"+orgname+"') as sellorgname,tio.name as ticketoutletsname,ts.orderno,ts.distance, ts.ticketentrance ticketentrance,ts.departdate departdate,")

				.append(" trim(ts.departtime) departtime,ts.sellip sellip,ts.fullprice fullprice,ts.tickettype,tr.returnway,")
				.append("ts.sellway, ts.paymethod,ts.price price,ts.seatno seatno,")
				.append(" ts.ticketno ticketno,ts.selltime selltime,ts.ticketstatus ticketstatus,")
				.append(" us.name as sellname, ts.schedulecode schedulecode,")
				.append(" tr.remarks remarks,tr.charges charges,tr.returnip returnip,tr.returntime returntime,")
				.append(" tol.name as returnsationname,re.name as returnbyname,")
				.append(" ts.departstationname as departstationname, ts.reachstationname as reachstationname,ts.orgname as orgname,ts.stationservicefee, ")
				.append(" ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append(" ( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal ")
				.append(" from Ticketsellagent ts left join Ticketreturn tr on ts.id = tr.sellid ")
				.append(" left join Ticketoutlets tio on ts.ticketoutletsid=tio.id")
//				.append(" left join Organization org on tio.orgid=org.id")
				.append(" left join userinfo re on tr.returnby= re.id ")
				.append(" left join Ticketoutlets tol on tr.ticketoutletsid =tol.id,")
				.append(" Userinfo us  ")
				.append(" where 1=1 and ts.departstationname is not null and ts.reachstationname is not null ")
				.append(" and ts.sellby = us.id and ts.orgname is not null ");

		sql.append(PropertyFilter.toJpql(propertyFilterList, true));

		sql.append(" order by selltime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 退异站票情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketreturnOther(
			List<PropertyFilter> propertyFilterList, String schedulecode,Qryparam qp) {
		StringBuilder sql = new StringBuilder(
				"select ts.selltime,ts.ticketno,tr.isselfschedule as islocal,tr.ticketprice,")
				.append("decode(tr.returnfeemode, 1,tr.returnamountweb , tr.returnamount) returnamount,tr.returnvoucherno,tr.returntime,tr.returnip,tr.returnway,")
				.append("decode(tr.returnfeemode, 1,tr.chargesweb, tr.charges) charges,retby.name as returnbyname,retby.code as returnbycode,")
				.append("sellby.name as sellbyname,ts.stationservicefee,ts.schedulecode,")
				.append("ts.departdate,trim(ts.departtime),ts.seatno,sellorg.name as orgname,bp.name as billbypename,")
				.append("bp.code as billcode,str.name as reachstationname,")
				.append("std.name as departstationname,tr.remarks,tos.name as ticketoutletsname,scheduleorg.name as scheduleorgname, ")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal,'' as routename ")
				.append(" , decode(tr.returnway, 1, '', 2, '',tsg.charges ) as signcharges  ")
				.append(" , decode(tr.returnway, 1, '', 2, '',uus.name ) as signbyname ")
				.append(" , decode(tr.returnway, 1, '', 2, '',tsg.signreason ) as signreason ")
				.append(" , decode(tr.returnway, 1, '', 2, '',to_char(tsg.signtime,'yyyy/mm/dd HH:MM:ss') ) as signtime,tr.chargesweb  ")
				.append(" , decode(tr.returnfeemode,1,1,0) as returnmethod ")
				.append(" from Ticketreturn tr LEFT JOIN billtype bp on bp.id=tr.billtypeid,")
				.append(" Ticketsellagent ts left join Ticketsign tsg on tsg.sellid = ts.id and tsg.isselfschedule = 1 left join Userinfo uus on tsg.signby = uus.id") 
				//.append(" left join digitaldictionarydetail d on d.code=ts.paymethod and d.digitaldictionaryid=50")
				.append( ",Userinfo retby,Userinfo sellby,Station str,Station std,")
				.append(" Organization sellorg,Ticketoutlets tos,Organization scheduleorg ")
				// Ticketturnoverdetail turnde,
				.append(" where tr.sellid = ts.id and tr.returnby = retby.id and tr.ticketoutletsid = tos.id")
				// and tr.isselfschedule = 1
				.append(" and tr.returnway <> '3' ") //过滤掉改签退票
				.append(" and sellby.id = ts.sellby and ts.departstationid = std.id and ts.orgid = scheduleorg.id")
				.append(" and ts.reachstationid = str.id and sellby.orgid= sellorg.id  ");// and
																							// tr.turnoverdetailid
																							// =
																							// turnde.id
		if (schedulecode != null && !schedulecode.equals("")) {
			sql.append(" and ts.schedulecode like '%" + schedulecode + "%' ");
		}
		if("1".equals(qp.getReturnmethod())){//
			sql.append(" and (tr.returnfeemode  = '0' or tr.returnfeemode is null) " );	
		}else if("2".equals(qp.getReturnmethod())){
			sql.append(" and tr.returnfeemode  = '1' " );	
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tr.returntime desc  ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		StringBuilder sql2 = new StringBuilder();
		sql2.append(
				"  select ts.selltime,ts.ticketno,tr.isselfschedule as islocal,tr.ticketprice,")
				.append("decode(tr.returnfeemode, 1,tr.returnamountweb , tr.returnamount) returnamount,tr.returnvoucherno,tr.returntime,tr.returnip,tr.returnway,")
				.append("decode(tr.returnfeemode, 1,tr.chargesweb, tr.charges) charges ,retby.name as returnbyname,retby.code as returnbycode,")
				.append("sellby.name as sellbyname,ts.stationservicefee,ts.schedulecode,")
				.append("ts.departdate,trim(ts.departtime),ts.seatno,sellorg.name as orgname,bp.name as billbypename,")
				.append("bp.code as billcode,ts.reachstationname as reachstationname,")
				.append("ts.departstationname as departstationname,tr.remarks,tos.name as ticketoutletsname,ts.orgname as scheduleorgname, ")
				.append("ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee,ts.moreprice, ")
				.append("( ts.computefee + ts.coolairfee + ts.additionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee ) as subtotal,'' as routename ")
				.append(" , decode(tr.returnway, 1, '', 2, '',tsg.charges ) as signcharges  ")
				.append(" , decode(tr.returnway, 1, '', 2, '',uus.name ) as signbyname ")
				.append(" , decode(tr.returnway, 1, '', 2, '',tsg.signreason ) as signreason ")
				.append(" , decode(tr.returnway, 1, '', 2, '',to_char(tsg.signtime,'yyyy/mm/dd HH:MM:ss') ) as signtime,d.value  ")
				.append(" from Ticketreturn tr LEFT JOIN billtype bp on bp.id=tr.billtypeid,")
				.append(" Ticketsellagent ts left join Ticketsign tsg on tsg.sellid = ts.id and tsg.isselfschedule = 1 left join Userinfo uus on tsg.signby = uus.id ")
				.append(" left join digitaldictionarydetail d on d.code=ts.paymethod and d.digitaldictionaryid=50")
				.append(" ,Userinfo retby,Userinfo sellby,")
				.append(" Organization sellorg,Ticketoutlets tos ")
				.append(" where tr.sellid = ts.id and tr.returnby = retby.id and tr.ticketoutletsid = tos.id")
				.append(" and sellby.id = ts.sellby and ts.departstationname is not null and ts.orgname is not null and ts.reachstationname is not null ")
				.append(" and tr.returnway <> '3' ") //过滤掉改签退票
				.append(" and sellby.orgid= sellorg.id  ");
		if (schedulecode != null && !schedulecode.equals("")) {
			sql2.append(" and ts.schedulecode like '%" + schedulecode + "%' ");
		}

		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int i = 0; i < propertyFilterList.size(); i++) {
				PropertyFilter pf = propertyFilterList.get(i);
				if (pf.getPropertyFullName().equals("scheduleorg!id")) {
					propertyFilterList.remove(i);
					break;
				}
			}
		}
		if("1".equals(qp.getReturnmethod())){//
			sql.append(" and (tr.returnfeemode  = '0' or tr.returnfeemode is null) " );	
		}else if("2".equals(qp.getReturnmethod())){
			sql.append(" and tr.returnfeemode  = '1' " );	
		}
		sql2.append(PropertyFilter.toJpql(propertyFilterList, true));

		sql2.append(" order by tr.returntime desc  ");
		Query query2 = getEntityManager().createNativeQuery(sql2.toString());
		JPAPropertyFilterUtil.setParameter(query2, propertyFilterList);
		list.addAll(query2.getResultList());
		return list;
	}


	/**
	 * 电子票明细查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketDetail(Qryparam qp) {
		List<Object> list = null;
		if (qp.getIslocalticket() == null || qp.getIslocalticket().equals("1")) {
			StringBuffer sql = new StringBuffer("select ts.sellip,")
					.append(" ts.selltime,ts.buspark,ts.ticketentrance,ts.price,ts.fueladditionfee,ts.stationservicefee,")
					.append(" ts.discountrate,ts.fullprice,ts.distance,ts.carrychildnum,ts.departdate,trim(ts.departtime) as departtime,")
					.append(" ts.seatno,ts.ticketno,ts.sellway,ts.ticketstatus,ts.paymethod,o.name as orgname,s.code as schedulecode,")
					.append(" stt.name as dpartname,ste.name as reachname,u.name as sellname,ts.ischecked as ischecked,ts.isdepartinvoices as isdepartinvoices,")
					.append(" 0 as islocal,vt.name as vehicletypename,tt.name as tickettypename,ts.islinework,tos.name as ticketoutletname,")
					.append(" cc.name as customername,th.name as hticketoutlesname,th.address as houtletsaddress,ck.name as checkedname,")
					.append("  cks.name as checkstationname,decode(ts.isdepartinvoices,0,'',1,du.name) as departinvoicesbyname,dv.departinvoicesno,ts.departinvoicestime,")
					.append(" ts.servicefee,vbm.brandname as vehiclebrandmodelname,ts.checktime,ts.computefee,ts.coolairfee,ts.additionfee,")
					.append(" sp.isovertime,r.name as routename,trt.ticketprice,trt.returnamount,ru.name as returnbyname,trt.returntime,")
					.append(" trt.returnway,ts.moreprice,ts.otherfee,ts.insurefee,ts.waterfee,0 serviceprice,")
					.append(" (ts.coolairfee + ts.additionfee + ts.fueladditionfee + ts.waterfee + ts.insurefee + ts.otherfee + ts.stationservicefee + ts.computefee) subtotal,")
					.append(" pby.name printname,(case when utls.ticketoutletsid is null then porg.name else tts.name end) printorgname,cc.certificatetype,");
					//判断身份证是否完全显示，参数取自前台
					if ("0".equals(qp.getShowfullidno())){
						sql.append(" cc.certificateno as certificateno,");	
					}else{
						sql.append(" case when cc.certificatetype='0' then substr(cc.certificateno,0,10)||'****'||substr(cc.certificateno,-4,4) else cc.certificateno end as certificateno,");
					}
					sql.append(" cc.mobilephone,cc.email,cc.lastbuytickettime,tso.taketime,tso.istaked,tso.orderno from Ticketsell ts")
					.append(" left join customer cc on ts.customerid=cc.id ")  //20317 高台西站售票情况查询表和电子票明细查询表对不上
					// .append(" LEFT JOIN customer cc on ts.customerid = cc.id LEFT JOIN ticketoutlets th on ts.handticketoutletsid = th.id")
					.append(" LEFT JOIN ticketoutlets th on ts.handticketoutletsid = th.id")
					.append(" LEFT JOIN station cks on ts.checkstationid = cks.id LEFT JOIN userinfo ck on ts.checkedby = ck.id")
					.append("  LEFT JOIN userinfo du on ts.departinvoicesby = du.id  LEFT JOIN departinvoices dv on ts.departinvoicesid = dv.id")
					.append("  LEFT JOIN ticketreturn trt ON ts.id = trt.sellid  LEFT JOIN userinfo ru on trt.returnby = ru.id")
					// .append("  left join ticketsellother tso on ts.id = tso.ticketsellid  left join Userinfo pby on tso.printby = pby.id  left join Organization porg on pby.orgid = porg.id,")
					// .append(" ,ticketsellother tso , Userinfo pby , Organization porg ,")
					.append(",ticketsellother tso LEFT JOIN userinfo pby on tso.printby = pby.id LEFT JOIN Organization porg on pby.orgid = porg.id  ")
					.append(" left join userticketoutlets utls on utls.userinfoid  = pby.id left join ticketoutlets tts on tts.id = utls.ticketoutletsid , ")
					.append(" Scheduleplan sp, Schedule s,")
					.append(" Organization o, Station stt, Station ste, Route r, Userinfo u, Schedulevehiclepeopleplan svp,")
					.append(" Vehicletype vt, Tickettype tt, Ticketoutlets tos, Vehiclebrandmodel vbm")
					.append(" where ts.scheduleplanid = sp.id   and o.id = ts.orgid   and sp.scheduleid = s.id   and svp.planvehiclebrandmodelid = vbm.id")
					.append("   and ts.id = tso.ticketsellid")
					// .append("   and ts.id = tso.ticketsellid and tso.printby = pby.id and pby.orgid = porg.id")
					.append("   and stt.id = ts.departstationid   and ste.id = ts.reachstationid   and u.id = ts.sellby   and svp.planvehicletypeid = vt.id")
					.append("   and ts.scheduleplanid = svp.scheduleplanid   and svp.orderno = 0   and tt.code = ts.tickettype   and ts.ticketoutletsid = tos.id")
					.append("   and s.routeid = r.id and sp.departdate between :departSdate and :departEdate")
					//.append("   and ts.customerid = cc.id ")  
					.append("   and ts.orgid in " + qp.getSaleorgids());

			if (qp.getSellSdate() != null) {
				sql.append(" and ts.selltime between :sellSdate and :sellEdate+0.99999");
			}
			if (qp.getTicketoutletsid() != null && qp.getTicketoutletsid() > 0) {
				sql.append(" and ts.ticketoutletsid= "
						+ qp.getTicketoutletsid());
				sql.append(" and porg.id in" + qp.getTicketoutletsid());
			}
			if (qp.getPrintorgids() != null && !"".equals(qp.getPrintorgids())) {
				sql.append(" and porg.id in" + qp.getPrintorgids());
			}
			if (qp.getSchcode() != null && !qp.getSchcode().equals("")) {
				sql.append(" and s.code = '" + qp.getSchcode() + "'");  //班次要求精准查询
			}
			if (qp.getSellway() != null && !qp.getSellway().equals("")) {
				sql.append(" and ts.sellway = " + qp.getSellway());
			}
			if (qp.getIslinework() != null && !qp.getIslinework().equals("")) {
				sql.append(" and sp.islinework=" + qp.getIslinework());
			}
			if (qp.getPaymethod() != null && !qp.getPaymethod().equals("")) {
				sql.append(" and ts.paymethod=" + qp.getPaymethod());
			}
			if (qp.getIsovertime() != null && !qp.getIsovertime().equals("")) {
				sql.append(" and sp.isovertime = " + qp.getIsovertime());
			}
			if (qp.getIstaked() != null && !qp.getIstaked().equals("")) {
				sql.append(" and tso.istaked = " + qp.getIstaked());
			}
			if (qp.getSellby() != null && qp.getSellby() > 0) {
				sql.append(" and ts.sellby=" + qp.getSellby());
			}
			if (qp.getReturnby() != null && !qp.getReturnby().equals("")) {
				sql.append(" and trt.returnby in " + qp.getReturnby());
			}
			if (qp.getRouteid() != null && qp.getRouteid() > 0) {
				sql.append(" and s.routeid=" + qp.getRouteid());
			}
			if (qp.getOrderno() != null && !qp.getOrderno().equals("")) {
				sql.append(" and tso.orderno like '%" + qp.getOrderno() + "%'");
			}
			if (qp.getTicketstatus() != null
					&& !qp.getTicketstatus().equals("")) {
				sql.append(" and ts.ticketstatus=" + qp.getTicketstatus());
			}
			if (qp.getTicketno() != null && !qp.getTicketno().equals("")) {
				sql.append(" and ts.ticketno='" + qp.getTicketno() + "'");
			}
			if (qp.getTickettype() != null && !qp.getTickettype().equals("")) {
				sql.append(" and ts.tickettype='" + qp.getTickettype() + "'");
			}
			if (qp.getIschecked() != null && !qp.getIschecked().equals("")) {
				sql.append(" and ts.ischecked='" + qp.getIschecked() + "'");
			}
			if (qp.getDepartstationid() != null && qp.getDepartstationid() > 0) {
				sql.append(" and ts.departstationid=" + qp.getDepartstationid());
			}
			if (qp.getReachstationid() != null && qp.getReachstationid() > 0) {
				sql.append(" and ts.reachstationid=" + qp.getReachstationid());
			}
			if (qp.getTaketimeSdate() != null) {
				sql.append(" and tso.taketime between :taketimeSdate and :taketimeEdate+0.99999");
			}
			if (qp.getCustomername() != null
					&& !"".equals(qp.getCustomername())) {
				sql.append(" and cc.name like '%" + qp.getCustomername() + "%'");
			}
			if (qp.getCertificateno() != null
					&& !"".equals(qp.getCertificateno())) {
				sql.append(" and cc.certificateno like '%"
						+ qp.getCertificateno() + "%'");
			}
			if (qp.getMobilephone() != null && !"".equals(qp.getMobilephone())) {
				sql.append(" and cc.mobilephone like '%" + qp.getMobilephone()
						+ "%'");
			}
			sql.append(" and rownum <= 30000 ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("departSdate", qp.getDepartSdate());
			query.setParameter("departEdate", qp.getDepartEdate());
			if (qp.getSellSdate() != null) {
				query.setParameter("sellSdate", qp.getSellSdate());
				query.setParameter("sellEdate", qp.getSellEdate());
			}
			if (qp.getTaketimeSdate() != null) {
				query.setParameter("taketimeSdate", qp.getTaketimeSdate());
				query.setParameter("taketimeEdate", qp.getTaketimeEdate());
			}
			long a = System.currentTimeMillis();
			list = query.getResultList();
			System.out.println(System.currentTimeMillis() - a);
		}
		// if (qp.getIslocalticket() == null ||
		// qp.getIslocalticket().equals("0")) {
		// StringBuffer sql = new StringBuffer(
		// "select ts.sellip,ts.selltime,ts.buspark, ts.ticketentrance,")
		// .append(" ts.price,ts.fueladditionfee ,ts.stationservicefee,ts.discountrate,ts.fullprice,")
		// .append(" ts.distance,ts.carrychildnum,ts.departdate,trim(ts.departtime) as departtime,")
		// .append(" ts.seatno,ts.ticketno,ts.sellway, ts.ticketstatus,ts.paymethod,o.name as orgname, ts.schedulecode,")
		// .append(" stt.name as dpartname ,ste.name as reachname,u.name as sellname,0 as ischecked ,0 as isdepartinvoices,")
		// .append(" 1 as islocal ,'' as vehicletypename,tt.name as tickettypename,ts.islinework,tos.name as ticketoutletname,")
		// .append(" cc.name as customername , '' as hticketoutlesname,'' as houtletsaddress,'' as checkedname,")
		// .append(" '' as checkstationname,'' as departinvoicesbyname,'' as departinvoicesno,null as departinvoicestime,")
		// .append(" ts.servicefee,ts.vehiclebrandmodelname,null as checktime,ts.computefee,ts.coolairfee,ts.additionfee,")
		// .append(" 0 as isovertime,'' as routename,trt.ticketprice,trt.returnamount,ru.name as returnbyname,trt.returntime,")
		// .append(" trt.returnway,ts.moreprice,ts.otherfee,ts.insurefee,ts.waterfee,ts.serviceprice,")
		// .append(" (ts.coolairfee+ts.additionfee+ts.fueladditionfee+ts.waterfee+ts.insurefee+")
		// .append(" ts.otherfee+ts.stationservicefee+ts.computefee) subtotal,'' as printname,'' as printorgname ")
		// .append(" from Ticketsellagent ts LEFT JOIN customer cc on ts.customerid =cc.id ")
		// .append("    LEFT JOIN  ticketreturn trt ON ts.id = trt.sellid  LEFT JOIN userinfo ru on trt.returnby= ru.id, ")
		// .append("    Organization o,Station stt,Station ste,Userinfo u,Tickettype tt,Ticketoutlets tos")
		// .append("  where o.id = u.orgid and stt.id = ts.departstationid and ste.id = ts.reachstationid ")
		// .append("    and u.id = ts.sellby and tt.code = ts.tickettype and ts.ticketoutletsid = tos.id ")
		// .append("    and ts.departdate between :departSdate and :departEdate")
		// .append("    and u.orgid in " + qp.getSaleorgids());
		// if (qp.getSellSdate() != null) {
		// sql.append(" and ts.selltime between :sellSdate and :sellEdate+0.99999");
		// }
		// if (qp.getSchcode() != null && !qp.getSchcode().equals("")) {
		// sql.append(" and ts.schedulecode= '" + qp.getSchcode()+"'");
		// }
		// if (qp.getSellway() != null && !qp.getSellway().equals("")) {
		// sql.append(" and ts.sellway = " + qp.getSellway());
		// }
		// if (qp.getPaymethod() != null && !qp.getPaymethod().equals("")) {
		// sql.append(" and ts.paymethod=" + qp.getPaymethod());
		// }
		// if (qp.getSellby()!=null && qp.getSellby() > 0) {
		// sql.append(" and ts.sellby=" + qp.getSellby());
		// }
		// if (qp.getReturnby()!=null && qp.getReturnby() > 0) {
		// sql.append(" and trt.returnby=" + qp.getReturnby());
		// }
		// if (qp.getTicketstatus() != null
		// && !qp.getTicketstatus().equals("")) {
		// sql.append(" and ts.ticketstatus=" + qp.getTicketstatus());
		// }
		// if (qp.getTicketno() != null && !qp.getTicketno().equals("")) {
		// sql.append(" and ts.ticketno='" + qp.getTicketno() + "'");
		// }
		// if (qp.getTickettype() != null && !qp.getTickettype().equals("")) {
		// sql.append(" and ts.tickettype='" + qp.getTickettype() + "'");
		// }
		// if (qp.getDepartstationid()!=null && qp.getDepartstationid() > 0) {
		// sql.append(" and ts.departstationid=" + qp.getDepartstationid());
		// }
		// if (qp.getReachstationid()!=null && qp.getReachstationid() > 0) {
		// sql.append(" and ts.reachstationid=" + qp.getReachstationid());
		// }
		// Query query = getEntityManager()
		// .createNativeQuery(sql.toString());
		// query.setParameter("departSdate", qp.getDepartSdate());
		// query.setParameter("departEdate", qp.getDepartEdate());
		// if (qp.getSellSdate() != null) {
		// query.setParameter("sellSdate", qp.getSellSdate());
		// query.setParameter("sellEdate", qp.getSellEdate());
		// }
		// long b = System.currentTimeMillis();
		// if(list==null){
		// list=query.getResultList();
		// }else{
		// list.addAll(query.getResultList());
		// }
		// System.out.println(System.currentTimeMillis() - b);
		// }
		return list;

	}

	/**
	 * 远程检票信息查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryrRemoteticketsell(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select ");

		sb.append(" rt.ticketno,rt.departdate,rt.schedulecode,rt.departtime,rt.seatno ");
		sb.append(" ,rt.vehicletypename,rt.vehicleno,rt.serviceprice,rt.islinework,rt.carrychildnum ");
		sb.append(" ,rt.distance,rt.fullprice,rt.tickettype,rt.discountrate,rt.stationservicefee ");
		sb.append(" ,rt.fueladditionfee,rt.price,rt.paymethod,rt.ticketentrance ");
		sb.append(" ,rt.buspark,rt.ticketoutletsname,rt.sellby,rt.selltime,rt.sellip,rt.sellway ");
		sb.append(" ,rt.ticketstatus,rt.batchno,rt.servicefee,rt.toplimitprice,rt.seattype ");
		sb.append(" ,rt.computefee,rt.additionfee,rt.coolairfee,rt.moreprice,rt.orderno,rt.waterfee ");
		sb.append(" ,rt.insurefee,rt.otherfee,rt.checkby,rt.checktime,rt.checktype ");
		sb.append(" ,rt.isdepartinvoices,rt.ischecked,rt.departinvoicestime, ");

		sb.append(" dorg.name as dorgname,corg.name as corgname,sellorg.name as sellorgname, ");
		sb.append(" ft.name as dpartname,et.name as reachname, rt.sellby as sellbyname,'' routename ");
		sb.append(" ,(rt.stationservicefee+rt.computefee+rt.coolairfee+rt.fueladditionfee+rt.waterfee+rt.additionfee+rt.insurefee+rt.otherfee) as subtotal ");
		sb.append(" ,tt.name as tickettypename ");
		sb.append(" from RemoteTicketsell rt left join Organization sellorg on sellorg.id=rt.ticketsellorgid,Station ft,Station et, ");
		sb.append(" Organization dorg,Organization corg,Tickettype tt ");
		sb.append(" where dorg.id=rt.departorgid and corg.id=rt.checkorgid ");
		sb.append(" and ft.id=rt.departstationid and et.id=rt.reachstationid and tt.code=rt.tickettype ");
		sb.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> qryTaketicketlog(String operatorgname,
			String sellticketorgid, String ticketoutletsid, Date dtpstartdate,
			Date dtpenddate) {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT t.sellorgname,t.schorgname,t.ticketno,t.departdate,t.departtime,t.schcode,t.departstationname ")
				.append(" ,t.reachstationname,t.tickettypename,t.ticketprice,t.seatno,t.orderno,t.password,t.customername ")
				.append(" ,t.certificateno,t.mobilephone,t.selltime,t.taketime,d.value takeway,t.status,t.operatorname ")
				.append(" ,t.operatorgname,t.ticketoutletsname,t.takecompute,t.remark ")
				.append("	FROM taketicketlog t left join Organization o1 on o1.name = t.operatorgname ")
				.append("  left join Organization o2 on o2.name = t.sellorgname  left join ticketoutlets tol on tol.name = t.ticketoutletsname ")
				.append("   left join digitaldictionarydetail d on d.digitaldictionaryid = 71 and d.code = t.takeway ")
				.append("	 where t.taketime between :dtpstartdate and :dtpenddate + 0.99999");
		if (operatorgname != null && operatorgname != "") {
			sb.append(" and o1.id in " + operatorgname);
		}
		if (sellticketorgid != null && sellticketorgid != "") {
			sb.append(" and o2.id in  " + sellticketorgid);
		}
		if (ticketoutletsid != null && ticketoutletsid != "") {
			sb.append(" and tol.id in " + ticketoutletsid);
		}

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("dtpstartdate", dtpstartdate);
		query.setParameter("dtpenddate", dtpenddate);
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> queryChangeCancelTicket(List<PropertyFilter> propertyFilterList, String sign, Date dtpstartdate, Date dtpenddate) {
		StringBuffer sb = new StringBuffer();
		if ("0".equals(sign)) {
			sb.append(" select name,id, sum(cancelnum), sum(cancelmoney), sum(eticketnum), sum(eticketmoney) ")
					.append(" from ( select u.name,u.id, count(t.ticketno) cancelnum, sum(t.price) cancelmoney, 0 as eticketnum, 0 as eticketmoney ")
					.append("   from ticketsell t left join ticketcancel tc on tc.sellid = t.id left join userinfo u on u.id = tc.cancelby ")
					.append("  where t.ticketstatus = '2' and tc.canceltime between :dtpstartdate and :dtpenddate +0.99999  ");
			sb.append(PropertyFilter.toJpql(propertyFilterList, true));
			sb.append("  group by u.name,u.id union all ")
					.append(" select u.name,u.id, 0 as cancelnum, 0 as cancelmoney, count(t.ticketno) as eticketnum, sum(t.price) as eticketmoney ")
					.append("   from ticketsell t left join ticketsellother tso on tso.ticketsellid = t.id left join userinfo u on u.id = t.sellby ")
					.append("  where t.sellway = '7' and t.selltime between :dtpstartdate and :dtpenddate +0.99999 ");
			sb.append(PropertyFilter.toJpql(propertyFilterList, true));
			sb.append("  group by u.name,u.id) group by name,id ");
		} else if ("1".equals(sign)) {// 1 废票
			sb.append(
					" select t.ticketno,t.price from ticketsell t left join ticketcancel tc on tc.sellid = t.id left join userinfo u on u.id = tc.cancelby ")
					.append(" where t.ticketstatus = '2' and tc.canceltime between :dtpstartdate and :dtpenddate +0.99999 ");
			sb.append(PropertyFilter.toJpql(propertyFilterList, true));
		} else if ("2".equals(sign)) {// 2 换票
			sb.append(
					" select t.ticketno, t.price from ticketsell t left join ticketsellother tso on tso.ticketsellid = t.id ")
					.append(" left join userinfo u on u.id = t.sellby where t.sellway = '7' and t.selltime between :dtpstartdate and :dtpenddate +0.99999 ");
			sb.append(PropertyFilter.toJpql(propertyFilterList, true));
		} else {
			return null;
		}
		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("dtpstartdate", dtpstartdate);
		query.setParameter("dtpenddate", dtpenddate);
		List<Object> list = query.getResultList();
		return list;
	}

	public Customer findCustomer(String certificateno) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select c from Customer c where c.certificateno = :certificateno and c.certificatetype = '0' ");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("certificateno", certificateno);
		return query.getResultList().size()>0?(Customer) query.getResultList().get(0):null;
	}

	public Ticketsell findTicketsell(String ticketno) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select c from Ticketsell c where c.ticketno = :ticketno ");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("ticketno", ticketno);
		return query.getResultList().size()>0?(Ticketsell) query.getResultList().get(0):null;
	}

}