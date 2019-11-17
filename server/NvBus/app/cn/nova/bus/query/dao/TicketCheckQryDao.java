package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：检票查询 </b><br/>
 * <b>类名称：</b>TicketCheckQryDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4  <br/>
 * <b>关键修改：修改班次报班情况查询，</b><br/>
 * <b>修改时间：2013-4-11</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class TicketCheckQryDao extends EntityManagerDaoSurport{
	
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
	 * 结算单情况查询
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDepartinvoices(List<PropertyFilter> propertyFilterList,long printby) {
		List<Object> list = null;
		StringBuilder sql = new StringBuilder(
				"select st.name as departstationname,ds.id,o.name as orgname," +
				"ds.departinvoicesno,ds.status,ds.departdate,ds.departtime,r.name as routename," +
				"s.code as schedulecode,u.name as unitname,v.vehicleno,sp.seatnum," +
				"vt.name as vehicletypname,ds.ticketnum,ds.totalamount,ds.stationservicefee," +
				"ds.printip,printby.name as printbyname,ds.printtime,ds.supplyticketnum," +
				"ds.supplyamount,ds.supplybalanceamount,d1.name as d1name,d2.name as d2name," +
				"d3.name as d3name,d4.name as d4name,s1.name as s1name,s2.name as s2name, " +
				"s.type,s.worktype,ds.fueladditionfee,ds.othterfee,ds.agentfee,ds.balanceamount,u2.name as balanceunitname,ds.moreprice ")
		.append(" from Departinvoices ds,Organization o,Schedule s,Route r,Unit u,Unit u2," +
				"Vehicle v,Vehicletype vt,Userinfo printby,Station st,Scheduleplan sp," +
				"Vehiclereport vr left join vr.driver1 d1 left join vr.driver2 d2 " +
				" left join vr.driver3 d3 left join vr.driver4 d4 left join vr.steward1 s1" +
				" left join vr.steward2 s2 ")
		.append(" where ds.printorgid = o.id and ds.scheduleid = s.id and s.route.id = r.id and v.balanceunitid = u2.id " +
				" and ds.reportid = vr.id and ds.vehicleid = v.id and v.unitid =  u.id and ds.scheduleplanid = sp.id " +
				" and v.vehicletypeid = vt.id and ds.printby = printby.id and ds.departstationid = st.id ");
		if(printby != 0){
			sql = sql.append(" and ds.printby = " + printby);
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		list = query.getResultList();
//		if(list.size()<=1){
			sql =new StringBuilder();
		  sql.append(" select st.name as departstationname, ds.id, o.name as orgname, ds.departinvoicesno, ds.status,                  ")
		  .append(" ds.departdate, ds.departtime, r.name as routename, s.code as schedulecode, u.name as unitname,                  ")
		  .append(" v.vehicleno, 0 as seatnum, vt.name as vehicletypname, ds.ticketnum, ds.totalmoney as totalamount, ds.stationfee as stationservicefee,         ")
		  .append(" '' as printip, '' as printbyname,'' as printtime, 0 as supplyticketnum,0 as supplyamount,                     ")
		  .append(" 0 as supplybalanceamount, d1.name as d1name, d2.name as d2name, d3.name as d3name, d4.name as d4name,             ")
		  .append(" s1.name as s1name, s2.name as s2name, s.type, s.worktype, 0 as fueladditionfee, ds.othterfee as othterfee,                     ")
		  .append(" ds.agentfee, ds.balancemoney as balanceamount, u2.name as balanceunitname, 0 as moreprice                                         ")
		  .append(" from Departinvoicesother ds left join ds.driver1 d1 left join ds.driver2 d2  left join ds.driver3 d3            ")
		  .append(" left join ds.driver4 d4 left join ds.steward1 s1 left join ds.steward2 s2,                                      ")
		  .append(" Organization o, Schedule s, Route r, Unit u, Unit u2, Vehicle v, Vehicletype vt, Station st   ")
		  .append(" where ds.orgid  = o.id and ds.schedule.id  = s.id and s.route.id = r.id and v.balanceunitid = u2.id               ")
		  .append(" and ds.vehicleid = v.id and v.unitid = u.id and v.vehicletypeid = vt.id                                         ")
		  .append(" and ds.departstationid = st.id ");
			Iterator<PropertyFilter> iterator = propertyFilterList.iterator();
			PropertyFilter orgids = null;
			PropertyFilter propertyFilter =  null;
			while(iterator.hasNext()){
				 propertyFilter = iterator.next();
				if("printtime".equals(propertyFilter.getPropertyName())){
					iterator.remove();
				}
				if ("printorgid".equals(propertyFilter.getPropertyName())) {
					iterator.remove();
//					orgids = new PropertyFilter("INS_ds!orgid", propertyFilter.getMatchValue());
//				
				}
				
			}
			
//			propertyFilterList.add(orgids);
			if(printby != 0){
				sql = sql.append(" and ds.createby = " + printby);
			}
		  sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			query = getEntityManager().createQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			List ll = query.getResultList();
			for(int i=0;i<ll.size();i++)
			{
				list.add(ll.get(i));
			}
//		}
		return list;
	}
	
	/**
	 * 结算单明细情况查询
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querydepartinvoicesDetail(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select fs.name as fromstaionname,rs.name as reachstationname," +
				"tt.name as tickettypename,dtd.distance,dtd.price,dtd.ticketnum,dtd.totalamount," +
				"dtd.fueladditionfee,dtd.othterfee,dtd.agentfee,dtd.balanceamount,dtd.issupply,dtd.stationservicefee,dtd.moreprice" +
				" from Departinvoicesdetail dtd,Station fs,Station rs,Tickettype tt" +
				" where dtd.fromstationid = fs.id and dtd.reachstationid = rs.id and dtd.tickettype = tt.code ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		if(list.size() > 0 ){
			return list;
		}else{
			//updateby by tianhb--begin 二〇一七年四月二十八日  综合查询+班次结算情况查询+结算单明细情况加一个票号 (支持 任务 7704)
			//查询结算单补录扣费项
			Long departinvoicesotherid = null;
			for(PropertyFilter propertyFilter:propertyFilterList){
				if("departinvoices.id".equalsIgnoreCase(propertyFilter.getPropertyName())){
					departinvoicesotherid = (Long)propertyFilter.getMatchValue();
				}
			}
			sql = new StringBuilder(
					"SELECT fs.name as fromstaionname,rs.name as reachstationname," +
							"tt.name as tickettypename,dtd.distance,dtd.price,dtd.ticketnum,dtd.totalamount," +
							"0 AS fueladditionfee,dtd.othterfee,dtd.agentfee,dtd.balanceamount,0 AS issupply,dtd.stationservicefee,0 AS moreprice" +
							" FROM Departinvoicesotherdetail dtd,Station fs,Station rs,Tickettype tt" +
					" WHERE dtd.fromstationid = fs.id AND dtd.reachstationid = rs.id AND dtd.tickettypeid = tt.id "
					+ " AND dtd.departinvoicesotherid =:departinvoicesotherid"		);
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("departinvoicesotherid",departinvoicesotherid);
			list = query.getResultList();
			//updateby by tianhb--end 二〇一七年四月二十八日  综合查询+班次结算情况查询+结算单明细情况加一个票号 (支持 任务 7704)
		}
		return list;
	}
	
	/**
	 * 扣费明显情况查询1--固定扣费
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDeductdetailDeductapply(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				" select '固定扣费' as typenme,bg.name as objectname,btm.name as itemname," +
				"dd.value as type,ds.deductmoney,v.vehicleno,s.code as scheduename," +
				"r.name as routenamebdy,u.name as unitname,bdy.startdate,bdy.enddate,bdy.remarks" +
				" from  Departinvoicesdeductdetail ds,Balancedeductapply bdy left join bdy.vehicle v " +
				" left join bdy.schedule s left join bdy.route r left join bdy.unit u," +
				"Balancededucttarget bg,Balancedeductitem btm,Digitaldictionarydetail dd,Digitaldictionary d " +
				" where ds.balanceapplyid= bdy.id and ds.type=2 and bdy.balancededucttargetid=bg.id " +
				" and bdy.balancedeductitemid=btm.id  and bg.isactive=1 " +
				" and bg.isactive=1 and dd.digitaldictionary.id=d.id and btm.deducttype = dd.code " +
				" and d.tablename ='balancedeductitem' and d.columnname ='deducttype' and ds.status='0'");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 扣费明显情况查询2--扣费公式
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDeductdetailFormulaapply(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select '扣费公式' as typenme,bg.name as objectname,ba.formulaname as itemname," +
				" dd.value as type,ds.deductmoney,v.vehicleno,s.code as scheduename," +
				" r.name as routenamebdy,u.name as unitname,bfy.startdate,bfy.enddate,bfy.remarks" +
				" from  Departinvoicesdeductdetail ds,Balanceformulaapply bfy left join bfy.vehicle v " +
				" left join bfy.schedule s left join bfy.route r left join bfy.unit u," +
				" Balancededucttarget bg,Balanceformula ba,Digitaldictionarydetail dd,Digitaldictionary d" +
				" where ds.balanceapplyid= bfy.id " +
				" and ds.type=1 and bfy.balancededucttargetid=bg.id and bfy.balanceformulaid=ba.id " +
				" and bfy.isactive=1 and bg.isactive=1 and ba.formulatype = dd.code  and ds.status='0' " +
				" and dd.digitaldictionary.id=d.id and d.tablename ='balanceformula' and d.columnname ='formulatype' ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 班次漏乘情况查询
	 * 过滤注销的报到、以及配载的报到导致的重复数据
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryScheduleMiss(List<PropertyFilter> propertyFilterList,boolean ticketnoVisible) {
		StringBuilder sql = new StringBuilder();
			if(ticketnoVisible){
				sql.append("select o.name as orgname,ts.ticketno,sellby.name as sellbyname,ts.selltime,s.code as schedulecode," +
						"rs.name as reachstationname,ds.name as departstationname,ts.departdate,ts.departtime," +
						"ts.seatno,tt.name as tickettypename,ts.price,ts.stationservicefee,ts.distance,ts.buspark," +
						"sp.islinework,sp.isovertime,tos.name as ticketoutletsname,ts.sellip,r.name as routename," +
						"ts.ischecked,ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee," +
						"ts.fueladditionfee,(ts.stationservicefee+ts.computefee+ts.coolairfee+ts.additionfee+"+
						"ts.waterfee+ts.insurefee+ts.otherfee+ts.fueladditionfee) as subtotal"+
						" from Ticketsell ts,Scheduleplan sp,Userinfo sellby,Schedule s," +
						" Station rs,Station ds,Tickettype tt,Ticketoutlets tos,Route r,Organization o " +
						" where ts.scheduleplanid =  sp.id " +
						" and ts.sellby = sellby.id and ts.scheduleid =  s.id and ts.isdepartinvoices = 0 " +
						" and ts.reachstationid = rs.id and ts.departstationid = ds.id and ts.tickettype = tt.code" +
						" and ts.ticketoutletsid = tos.id and s.route.id = r.id and ts.orgid = o.id and ts.ticketstatus = 0 ");
				}else{
					sql.append("select o.name as orgname,'********' as ticketno,sellby.name as sellbyname,ts.selltime,s.code as schedulecode," +
							"rs.name as reachstationname,ds.name as departstationname,ts.departdate,ts.departtime," +
							"ts.seatno,tt.name as tickettypename,ts.price,ts.stationservicefee,ts.distance,ts.buspark," +
							"sp.islinework,sp.isovertime,tos.name as ticketoutletsname,ts.sellip,r.name as routename," +
							"ts.ischecked,ts.computefee,ts.coolairfee,ts.additionfee,ts.waterfee,ts.insurefee,ts.otherfee," +
							"ts.fueladditionfee,(ts.stationservicefee+ts.computefee+ts.coolairfee+ts.additionfee+"+
							"ts.waterfee+ts.insurefee+ts.otherfee+ts.fueladditionfee) as subtotal"+
							" from Ticketsell ts,Scheduleplan sp,Userinfo sellby,Schedule s," +
							" Station rs,Station ds,Tickettype tt,Ticketoutlets tos,Route r,Organization o " +
							" where ts.scheduleplanid =  sp.id " +
							" and ts.sellby = sellby.id and ts.scheduleid =  s.id and ts.isdepartinvoices = 0 " +
							" and ts.reachstationid = rs.id and ts.departstationid = ds.id and ts.tickettype = tt.code" +
							" and ts.ticketoutletsid = tos.id and s.route.id = r.id and ts.orgid = o.id and ts.ticketstatus = 0 ");
				}
		
				
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	
//	/**
//	 * 班次漏乘情况查询(过了发车日期后再处理的票)
//	 * * @param propertyFilterList
//	 * @return
//	 */
//	@SuppressWarnings("unchecked")
//	public List<Object> queryScheduleMissDepart(List<PropertyFilter> propertyFilterList) {
//		Date returndate = null;
//		if (propertyFilterList != null && propertyFilterList.size() > 0) {
//			for (int t = 0; t < propertyFilterList.size(); t++) {
//				if (propertyFilterList.get(t).getPropertyFullName().equals("ts!departdate")){
//					if (propertyFilterList.get(t).getMatchType().toString().equals("<=")){
//						returndate = DateUtils.add((Date) propertyFilterList.get(t).getMatchValue(), 1);
//					}
//				}
//			}
//		}
//		StringBuilder sql = new StringBuilder(
//				"select o.name as orgname,ts.ticketno,sellby.name as sellbyname,ts.selltime,s.code as schedulecode,")
//		.append("rs.name as reachstationname,ds.name as departstationname,ts.departdate,ts.departtime,")
//		.append("ts.seatno,tt.name as tickettypename,ts.price,ts.stationservicefee,ts.distance,ts.buspark,")
//		.append("sp.islinework,sp.isovertime,tos.name as ticketoutletsname,ts.sellip,r.name as routename,ts.ischecked")
//		.append(" from Ticketsell ts, Ticketreturn tr,Scheduleplan sp,Userinfo sellby,Schedule s,")
//		.append(" Station rs,Station ds,Tickettype tt,Ticketoutlets tos,Route r,Organization o")
//		.append(" where ts.scheduleplanid =  sp.id")
//		.append(" and ts.sellby = sellby.id and ts.scheduleid = s.id and ts.isdepartinvoices = 0")
//		.append(" and ts.reachstationid = rs.id and ts.departstationid = ds.id and ts.tickettype = tt.code")
//		.append(" and ts.ticketoutletsid = tos.id and s.route.id = r.id and ts.orgid = o.id")
//		.append(" and ts.id = tr.sellid  and tr.returntime > :returndate ");
//		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
//		Query query = getEntityManager().createQuery(sql.toString());
//		query.setParameter("returndate", returndate);
//		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
//		return query.getResultList();
//	}
	
	
	
	
	/**
	 * 班次报班情况查询
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleReport(List<PropertyFilter> propertyFilterList) {
		boolean isreport = false;
		int checkone=0;
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("ss!isreported")) {
					isreport=(Boolean) propertyFilterList.get(t).getMatchValue();
					propertyFilterList.remove(t);
					checkone=1;//执行到这里，证明要么查发班，要么查未发班，如果没执行到这里，就是查询全部
				}
			}
		}
		StringBuilder sql = new StringBuilder(
				"select ut.name as unitname,case when vr.id>0 then 1 else 0 end as isreported,ss.status,st.name as orgname,s.code as schedulecode,trim(ss.departtime),r.name as routename,"+
				"sp.departdate,vr.reporttime,vh.vehicleno,sp.seatnum,sp.islinework,sp.isovertime,"+
				"pu.name as planunitname,pv.vehicleno as planvehicleno,d1.name as drivername1,"+
				"d2.name as drivername2,d3.name as drivername3,d4.name as drivername4,"+
				"s1.name as stewardname1,s2.name as stewardname2,pd1.name as plandriver1,"+
				"pd2.name as plandriver2,pd3.name as plandriver3,pd4.name as plandriver4,"+
				"ps1.name as plansteward1,ps2.name as plansteward2 "+
				" from Schedulestatus ss ,Schedule s ,Route r ,station st, "+
				" Scheduleplan sp left join Vehiclereport vr LEFT JOIN driver d1 on vr.driver1id = d1.id"+ 
				" LEFT JOIN driver d2 on vr.driver2id = d2.id  LEFT JOIN driver d3 on vr.driver3id = d3.id "+ 
				" LEFT JOIN driver d4 on vr.driver4id = d4.id  LEFT JOIN steward s1 on  vr.steward1id=s1.id"+
                " LEFT JOIN steward s2 on  vr.steward2id=s2.id  left join vehicle vh on vh.id = vr.vehicleid" +
				" left join unit ut on ut.id = vh.unitid"+
				" on sp.id = vr.scheduleplanid and vr.isactive = 1 and sp.orgid=vr.reportorgid"+
				" and sp.departdate = vr.departdate and sp.scheduleid=vr.scheduleid ,"+
				" Schedulevehiclepeopleplan svp  "+
				"LEFT JOIN steward ps1 on svp.plansteward1id = ps1.id "+
				"LEFT JOIN steward ps2 on svp.plansteward2id = ps2.id  "+
				"LEFT JOIN vehicle pv on svp.planvehicleid = pv.id LEFT JOIN driver pd1 on svp.plandriver1id = pd1.id "+
				"LEFT JOIN driver pd2 on svp.plandriver2id = pd2.id "+
				"LEFT JOIN driver pd3 on svp.plandriver3id = pd3.id LEFT JOIN driver pd4 on svp.plandriver4id = pd4.id  "+
				"LEFT JOIN unit pu on svp.planunitid = pu.id "+
				" where  ss.scheduleplanid = sp.id "+
				" and svp.scheduleplanid = sp.id  and svp.scheduleplanid =ss.scheduleplanid and svp.scheduleid = s.id "+
				" and (svp.orderno=(select max(orderno) from Schedulevehiclepeopleplan vv  "+
				"  where vv.scheduleplanid=svp.scheduleplanid) or svp.id is null )  "+
				"  and sp.scheduleid = s.id and s.routeid = r.id and ss.departstationid= st.id ");
		if(checkone==1){
			if(isreport){
				sql.append(" and vr.id is not null");
			}else{
				sql.append(" and vr.id is null");
			}
		}			
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by st.name,sp.departdate desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 班次混检情况查询
	 * * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketmixcheck(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name as orgname,tm.ticketno,tm.oldticketno,tm.olddepartdate,trim(tm.olddeparttime)," )
			.append("tm.newdepartdate,trim(tm.newdeparttime),tm.oldseatno,tm.newseatno,tm.actualvehicleseatnum,")
			.append("tm.createtime,cu.name as createbyname,ts.isdepartinvoices,tdd.value as ticketstats,")
			.append("ns.code as newschedulecode,os.code as oldschdulecode,nrt.name as newroutename,")
			.append("ort.name as oldroutename,sst.name as startstation,est.name as endstation,")
			.append("dd.value as mixchecktype,osst.name as oldstartstation,oest.name as oldendstation ")
			.append("from ticketmixcheck tm left join ticketsell ots left join station osst on")
			.append(" ots.departstationid =osst.id left join station oest on ots.reachstationid  =oest.id")
			.append(" on tm.oldticketno = ots.ticketno,ticketsell ts,organization o,")
			.append("digitaldictionary d,digitaldictionarydetail dd,")
			.append("digitaldictionary td,digitaldictionarydetail tdd,")
			.append("schedule os,schedule ns,route ort,route nrt,station sst,station est,userinfo cu")
			.append(" where tm.orgid = o.id and tm.ticketsellid = ts.id")
			.append(" and tm.type = dd.code and d.id = dd.digitaldictionaryid")
			.append(" and d.tablename ='ticketmixcheck' and d.columnname='type'")
			.append(" and ts.ticketstatus = tdd.code and td.id = tdd.digitaldictionaryid")
			.append(" and td.tablename ='ticketsell' and td.columnname='ticketstatus'")
			.append(" and tm.oldscheduleid = os.id and tm.newscheduleid = ns.id")
			.append(" and os.routeid  = ort.id and ns.routeid = nrt.id and tm.createby = cu.id")
			.append(" and ts.departstationid  = sst.id and ts.reachstationid  = est.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ort.id,trim(tm.newdeparttime),tm.newdepartdate desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 班次检票汇总表
	 * * @param propertyFilterList,
	 *  add by lck 2011-09-29
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryScheduleCheckSum(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select a.usercode as usercode,a.username as checkname," +
				"sum(a.departmun) as departnum,sum(a.checknum) as checknum,sum(a.fee) as fee,sum(a.departpeplo) departpeplo,sum(price) price, sum(checkprice) checkprice " +
				" , sum(departinvoicesnum) departinvoicesnum" +
				" from ( select username,usercode,routename,scode,checknum,fee,departmun,departpeplo,0 price, 0 checkprice,0 departinvoicesnum " +
				 " from (select u.name as username,u.code as usercode,r.name as routename," +
				 "s.code as scode,null as checknum, null as fee,count(distinct(dv.reportid)) as departmun,null as departpeplo,0 price, 0 checkprice,0 departinvoicesnum " +
				 " from departinvoices dv,scheduleplan sp,userinfo u,schedule s,route r" +
				 " where dv.scheduleplanid=sp.id and dv.status<>1 and dv.printby=u.id" +
				 " and sp.scheduleid=s.id and s.routeid= r.id " +
				 PropertyFilter.toJpql(propertyFilterList, true)+
				 " group by u.name,u.code,r.name,s.code" +
				 ") d union " +
				 " select u.name as username,u.code as usercode ,r.name as routename," +
				 "s.code as scode,count(ts.id) as checknum,sum(ts.additionfee) fee,null as departmun ,null as departpeplo, 0 price, sum(ts.price-ts.stationservicefee) checkprice,0 departinvoicesnum " +
				 " from ticketsell ts,scheduleplan sp,userinfo u,schedule s,route r" +
				 " where ts.scheduleplanid= sp.id and ts.ischecked=1 and ts.checkedby= u.id" +
				 " and sp.scheduleid=s.id and s.routeid= r.id " +
				 PropertyFilter.toJpql(propertyFilterList, true)+
				 " group by u.name,u.code ,r.name,s.code " +
				 "  union select u.name as username,u.code as usercode ,r.name as routename," +
				 "  s.code as scode,null as checknum,null as fee,null as departmun,sum(sp.ticketnum) as departpeplo,sum(sp.balanceamount) price, 0 checkprice,0 departinvoicesnum" +
				 "  from departinvoices sp,userinfo u,schedule s,route r" +
				 "  where sp.printby= u.id and sp.scheduleid=s.id and s.routeid= r.id  " +
				 PropertyFilter.toJpql(propertyFilterList, true)+
				 "  group by u.name,u.code ,r.name,s.code " +
				 " UNION ALL SELECT  u.name as username, u.code as usercode, r.name as routename, s.code as scode,"+
				 " 0 as checknum, 0 as fee, 0 as departmun, 0 as departpeplo, 0 as price, 0 as checkprice," +
				 " COUNT(sp.id) departinvoicesnum FROM departinvoices sp LEFT JOIN userinfo u ON sp.printby = u.id"+
				 " LEFT JOIN schedule s ON sp.scheduleid = s.id LEFT JOIN route r ON s.routeid = r.id where 1=1 "+
				 PropertyFilter.toJpql(propertyFilterList, true)+
				 " GROUP BY u.name,u.code, r.name, s.code" +
				 ") a group by a.username,a.usercode");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	/**
	 * @Title qrycheckworkmonth
	 * @Description 检票员工作月报表
	 * @param propertyFilterList
	 * @return List<Object> 
	 * @author ……
	 * @date 2016年8月17日-上午11:58:00
	 * @update tianhb
	 * @throws
	 */
	public List<Object> qrycheckworkmonth(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
	   sql.append(" select code,name,sum(sticketnum),sum(sdepartinvoicesno),sum(stotalamount), ")
       .append(" sum(fticketnum),sum(fdepartinvoicesno),sum(ftotalamount),sum(sdepartinvoicesno + fdepartinvoicesno) totalno ")
       //begin 20160816 tianhb 鄂尔多斯检票员工作月报增加 2 列(站务费,结算金额)
       .append(" ,SUM(NVL(stationservicefee,0)) AS stationservicefee")
       .append(" ,SUM(stotalamount) - SUM(NVL(stationservicefee,0)) AS balanceamount")
       //end 20160816 tianhb 鄂尔多斯检票员工作月报增加 2 列(站务费,结算金额)
       .append(" from (SELECT u.code,u.name,sum(dis.ticketnum) sticketnum,count(dis.departinvoicesno) sdepartinvoicesno, ")
       .append(" sum(dis.totalamount) stotalamount,0 fticketnum,0 fdepartinvoicesno,0 ftotalamount, ")
       .append(" dis.departdate,dis.printtime,sp.orgid ")
       //begin 20160816 tianhb 鄂尔多斯检票员工作月报增加 2 列(站务费,结算金额)
       .append(" ,SUM(dis.stationservicefee) AS stationservicefee")
       //end 20160816 tianhb 鄂尔多斯检票员工作月报增加 2 列(站务费,结算金额)
       .append(" FROM departinvoices dis left join userinfo u on dis.printby = u.id left join scheduleplan sp on sp.id = dis.scheduleplanid ")
       .append(" where dis.status <> 1 "+ PropertyFilter.toJpql(propertyFilterList, true)+" group by u.code, u.name,dis.departdate, dis.printtime, sp.orgid ")
       .append(" union all ")
       .append(" SELECT u.code checkbycode, u.name checkby, 0 sticketnum, 0 sdepartinvoicesno, 0 stotalamount, ")
       .append(" sum(dis.ticketnum) fticketnum, count(dis.departinvoicesno) fdepartinvoicesno, ")
       .append(" sum(dis.totalamount) ftotalamount, dis.departdate, dis.printtime, sp.orgid ")
       //begin 20160816 tianhb 鄂尔多斯检票员工作月报增加 2 列(站务费,结算金额)
       .append(" ,0 AS stationservicefee")
       //end 20160816 tianhb 鄂尔多斯检票员工作月报增加 2 列(站务费,结算金额)
       .append(" FROM departinvoices dis left join userinfo u on dis.printby = u.id ")
       .append(" left join scheduleplan sp on sp.id = dis.scheduleplanid ")
       .append(" where dis.status = 1 "+ PropertyFilter.toJpql(propertyFilterList, true)+" group by u.code, u.name, dis.departdate, dis.printtime, sp.orgid) ")
       .append(" where 1=1 " )
       .append(" group by code, name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> qrychecklog(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				" select dd.value as checktype,dd1.value as operationtype,c.ticketno,c.departdate,c.departtime,c.schedulecode,c.reachstation      ")
				.append(" ,c.customername,dd2.value as certificatetype ,c.certificateno,c.checkedby,c.checkedbycode,c.checkedip,c.checktime               ")
				.append(" from checkticketlog c                                                                                                           ")
				.append(" left join digitaldictionary d on d.tablename = 'checkticketlog' and d.columnname = 'checktype'                                  ")
				.append(" left join digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and dd.code = c.checktype                                 ")
				.append(" left join digitaldictionary d1 on d1.tablename = 'checkticketlog' and d1.columnname = 'operationtype'                           ")
				.append(" left join digitaldictionarydetail dd1 on dd1.digitaldictionaryid = d1.id and dd1.code = c.operationtype                         ")
				.append(" left join digitaldictionary d2 on d2.tablename = 'customer' and d2.columnname = 'certificatetype'                               ")
				.append(" left join digitaldictionarydetail dd2 on dd2.digitaldictionaryid = d2.id and dd2.code = c.certificatetype                       ")
				.append(" left join userinfo u on u.code = c.checkedbycode  where 1=1 "
						+ PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	
}
