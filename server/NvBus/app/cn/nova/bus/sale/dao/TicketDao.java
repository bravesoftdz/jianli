package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;
import javax.persistence.Query;


import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.CarryChild;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author lck
 * 
 */
@SuppressWarnings("rawtypes")
public class TicketDao extends EntityManagerDaoSurport {

	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BilltypeServiceImpl billtypeService = new BilltypeServiceImpl();
	
	// 获取车票并锁住
	@SuppressWarnings("unchecked")
	public Ticketsell getTicket(String ticketno) {
		StringBuilder sql = new StringBuilder(
				"select  t from Ticketsell t where t.ticketno=:ticketno");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("ticketno", ticketno);
		List<Ticketsell> list = query.getResultList();
		if(list==null ||list.size()==0){
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}			
			sql = new StringBuilder(
			"select  t from Ticketsell t where t.ticketno=:ticketno");
			query = em.createQuery(sql.toString());
			query.setLockMode(LockModeType.PESSIMISTIC_READ);
			query.setParameter("ticketno", cuticketno);
			list = query.getResultList();
		}
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	// 获取车票并锁住
	@SuppressWarnings("unchecked")
	public Ticketsell getTicket(String ticketno,Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select  t from Ticketsell t where t.ticketno=:ticketno")
				.append(" and t.departdate>=:departdate order by t.departdate desc");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("ticketno", ticketno);
		query.setParameter("departdate", departdate);
		List<Ticketsell> list = query.getResultList();
		if(list==null ||list.size()==0){
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
			sql = new StringBuilder(
					"select  t from Ticketsell t where t.ticketno=:ticketno")
					.append(" and t.departdate>=:departdate order by t.departdate desc");
			query = em.createQuery(sql.toString());
			query.setLockMode(LockModeType.PESSIMISTIC_READ);
			query.setParameter("ticketno", cuticketno);
			query.setParameter("departdate", departdate);
			list = query.getResultList();			
		}
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	// 获取车票并锁住	
	@SuppressWarnings("unchecked")
	public Ticketsell getTicket(long scheduleplanid, Short seatno) {
		StringBuilder sql = new StringBuilder(
				"select  t from Ticketsell t where t.seatno=:seatno")
				.append(" and t.scheduleplanid=:scheduleplanid");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);			
		query.setParameter("seatno", seatno);
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Ticketsell> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		//车票重打：当系统为12位票段，支持输入8位票号
		for (int i = 0; i < propertyFilterList.size(); i++) {
			if("t!ticketno".equals(propertyFilterList.get(i).getPropertyFullName())){
				Ticketsell ticketsell = getTicket((String) propertyFilterList.get(i).getMatchValue());//通过前台传过来的票号得到数据库中的真实票号
				if(null != ticketsell){
					propertyFilterList.remove(i); //移除propertyFilterList中前台传过来的票号参数
					propertyFilterList.add(new PropertyFilter("EQS_t!ticketno",
							ticketsell.getTicketno())); //将数据库中的真实票号add到propertyFilterList中
				}
				break;
			}
		}
		
		StringBuilder sql = new StringBuilder(
				"select t.id, t.seatno, t.ticketno, t.departdate, trim(t.departtime), t.carrychildnum, ")
				.append(" t.fullprice, t.price, t.discountrate, t.stationservicefee, ")
				.append(" t.distance, t.selltime, t.ticketentrance, t.createtime, t.updatetime, ")
				.append(" ve.vehicleno as vehicleno, s.code as schedulecode, o.name as orgname, ")
				.append(" st.name as departname, so.name as reachname, u.name as sellname, ")
				.append(" us.name as createname, use.name as updatename, ti.name as ticketname,t.sellby as sellid ")
				.append(" from Ticketsell t left join vehiclereport v left join vehicle ve on v.vehicleid=ve.id ")
				.append(" on t.vehiclereportid=v.id, Schedule s, Organization o, Station st, ")
				.append(" Station so, Userinfo u, Userinfo us, Userinfo use, Ticketoutlets ti, Scheduleplan sp ")
				.append(" where t.scheduleid=s.id and t.orgid=o.id and t.departstationid=st.id and ")
				.append(" t.reachstationid=so.id and t.sellby=u.id and t.createby=us.id and ")
				.append(" t.updateby=use.id and t.ticketoutletsid=ti.id and t.scheduleplanid=sp.id ")
				.append(" and t.ticketstatus='0' and t.ischecked='0' ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketsellagent(List<PropertyFilter> propertyFilterList) {
		//车票重打：当系统为12位票段，支持输入8位票号
		for (int i = 0; i < propertyFilterList.size(); i++) {
			if("t!ticketno".equals(propertyFilterList.get(i).getPropertyFullName())){
				Ticketsell ticketsell = getTicket((String) propertyFilterList.get(i).getMatchValue());//通过前台传过来的票号得到数据库中的真实票号
				if(null != ticketsell){
					propertyFilterList.remove(i); //移除propertyFilterList中前台传过来的票号参数
					propertyFilterList.add(new PropertyFilter("EQS_t!ticketno",
							ticketsell.getTicketno())); //将数据库中的真实票号add到propertyFilterList中
				}
				break;
			}
		}
		
		StringBuilder sql = new StringBuilder(
		"select t.id, t.seatno, t.ticketno, t.departdate, trim(t.departtime), t.carrychildnum, ")
		.append(" t.fullprice, t.price, t.discountrate, t.stationservicefee, ")
		.append(" t.distance, t.selltime, t.ticketentrance, t.createtime, t.updatetime, ")
		.append(" '' as vehicleno, '' as schedulecode, o.name as orgname, ")
		.append(" st.name as departname, so.name as reachname, u.name as sellname, ")
		.append(" us.name as createname, use.name as updatename, ti.name as ticketname,t.sellby as sellid,length(t.ticketno) ticketlength,t.tickettype tickettype ")
		.append(" from Ticketsellagent t , Organization o, Station st, ")
		.append(" Station so, Userinfo u, Userinfo us, Userinfo use, Ticketoutlets ti ")
		.append(" where t.orgid=o.id and t.departstationid=st.id and ")
		.append(" t.reachstationid=so.id and t.sellby=u.id and t.createby=us.id and ")
		.append(" t.updateby=use.id and t.ticketoutletsid=ti.id ")
		.append(" and t.ticketstatus='0' ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findTicketChange(
			List<PropertyFilter> propertyFilters,Global global) {
		String ticketno = "";
		Iterator<PropertyFilter> iterator = propertyFilters.iterator();
		while(iterator.hasNext()){
			PropertyFilter propertyFilter = iterator.next();
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase("t!ticketno")) {
				//String ticketno = (String) propertyFilter.getMatchValue();
				iterator.remove();//移除票号精确查询的条件
				//propertyFilters.add(new PropertyFilter("LIKES_t!ticketno", ticketno));//此模糊查询慢，修改为 like 'xxx%'
				ticketno = (String) propertyFilter.getMatchValue();
				break;
			}
		}
		String onlyonce = getParameterService().findParamValue(ParamterConst.Param_1507, global.getOrganization().getId());
		StringBuilder sql = new StringBuilder();
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(onlyonce)){
			sql.append("select case when t.ticketstatus='0' and t.ischecked<>1 then 1 when ss.isdeparted=1 then 0 else null end as isselected,");
		}else{
			sql.append("select case when t.ticketstatus='0' and t.ischecked<>1 and tc.newticketsellid is null then 1 when ss.isdeparted=1 then 0 else null end as isselected,");
		}
				sql.append("t.sellby,t.selltime,isr.insuranceno,ss.status,t.orgid,")
				.append("t.id,t.scheduleplanid,t.ticketno,t.departdate,t.scheduleid,trim(t.departtime),t.seatno,t.islinework,t.carrychildnum,")
				.append("t.departstationid,t.reachstationid,t.tickettype,t.price,t.paymethod,t.ticketoutletsid,t.customerid,t.ischecked,t.ticketstatus,")
				.append("ss.isdeparted,case when tc.newticketsellid is null then 0 else 1 end as ischanged,")
				.append(" cm.certificateno,cm.certificatetype,cm.name as customername, ")
				.append(" isr.id as insuranceid,isr.premium,isr.insuretypeid,isr.paymethod as insurancepaymethod, ")
				.append(" std.name as departstationname, str.name as reachstationname,str.isroundtrip,ro.returntripvaliddays ")
				.append(" from Ticketsell t left join Ticketchange tc on t.id=tc.newticketsellid ")
				.append(" left join Customer cm on t.customerid=cm.id ")
				.append(" left join Insurance isr on t.id=isr.sellid and isr.insurancestatus='0'")
				.append("      ,Schedulestatus ss, Station std, Station str,Schedule sc,Route ro ")
				.append(" where t.departstationid=ss.departstationid")
				.append("   and t.scheduleplanid=ss.scheduleplanid")
				.append("   and t.departstationid=std.id ")
				.append(" 	and t.reachstationid=str.id ")
				.append("   and t.scheduleid=sc.id")
				.append("   and sc.routeid=ro.id ");
		sql.append(" and t.ticketno like :ticketno ");
		String clientCondition = PropertyFilter.toJpql(propertyFilters, true);
		if(clientCondition==null||clientCondition.trim().equals("")){
			clientCondition = " and 1=2";
		}
		sql.append(clientCondition);
//		sql.append(" order by t.id ");
		
		
		//本售异
		sql.append(" union all ");
		sql.append("select case when t.ticketstatus = '0' and tc.newticketsellid is null then 1 else null end as isselected,");
		sql.append("       t.sellby, t.selltime, isr.insuranceno, '' as status, t.orgid, t.id, 0 as scheduleplanid, t.ticketno,");
		sql.append("       t.departdate, 0 as scheduleid, trim(t.departtime), t.seatno, t.islinework, t.carrychildnum, t.departstationid,");
		sql.append("       t.reachstationid, t.tickettype, t.price, t.paymethod, t.ticketoutletsid, t.customerid, 0 as ischecked,");
		sql.append("       t.ticketstatus, 0 as isdeparted,");
		sql.append("       case when tc.newticketsellid is null then 0 else 1 end as ischanged,");
		sql.append("       cm.certificateno, cm.certificatetype, cm.name as customername, isr.id as insuranceid, isr.premium,");
		sql.append("       isr.insuretypeid, isr.paymethod as insurancepaymethod, std.name as departstationname, str.name as reachstationname,");
		sql.append("       str.isroundtrip, 0 as returntripvaliddays");
//		sql.append("       , 1 as isnet, t.schedulecode as schedulecode");
		sql.append("  from Ticketsellagent t left join Ticketchange tc on t.id = tc.newticketsellid");
		sql.append("	   left join Customer cm on t.customerid = cm.id");
		sql.append("	   left join Insurance isr on t.id = isr.sellid and isr.insurancestatus = '0' ");
		sql.append("	   , Station std, Station str");
		sql.append("  where t.departstationid = std.id");
		sql.append("        and t.reachstationid = str.id ");
		sql.append(" and t.ticketno like :ticketno ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
//		sql.append(" order by t.id ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketno", ticketno + "%");
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return ListUtil.listToMap(
				new Object[] {"isselected","sellby","selltime","insuranceno","status","orgid",
						"id", "scheduleplanid", "ticketno",
						"departdate", "scheduleid", "departtime", "seatno",
						"islinework", "carrychildnum", "departstationid",
						"reachstationid", "tickettype", "price", "paymethod",
						"ticketoutletsid", "customerid", "ischecked",
						"ticketstatus", "isdeparted", "ischanged",
						"certificateno", "certificatetype", "customername",
						"insuranceid", "premium", "insuretypeid",
						"insurancepaymethod", "departstationname",
						"reachstationname","isroundtrip","returntripvaliddays" },
				query.getResultList(),
				new Object[] { Boolean.class,Long.class,Timestamp.class,String.class,String.class,Long.class,
						Long.class, Long.class, String.class,
						Date.class, Long.class, String.class, Short.class,
						Boolean.class, Short.class, Long.class, Long.class,
						String.class, BigDecimal.class, String.class,
						Long.class, Long.class, Boolean.class
						, String.class,Boolean.class, Boolean.class
						, String.class,String.class, String.class
						, Long.class,BigDecimal.class, Long.class
						, String.class,String.class
						, String.class,Boolean.class,Short.class });
	}

	@SuppressWarnings("unchecked")
	public List<Ticketsell> getTicketResult(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer("select t from Ticketsell t ");
		sql.append(" where t.departinvoices.id=:departinvoicesid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<RemoteTicketsell> getRemoteTicketsell(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer("select t from RemoteTicketsell t ");
		sql.append(" where t.departinvoicesid=:departinvoicesid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		return query.getResultList();
	}
	// 获取车票并锁住
	@SuppressWarnings("unchecked")
	public RemoteTicketsell getRemoteTicketSell(String ticketno,Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select  t from RemoteTicketsell t where t.ticketno=:ticketno")
		.append(" and t.departdate>=:departdate order by t.departdate desc");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);		
		query.setParameter("ticketno", ticketno);
		query.setParameter("departdate", departdate);
		List<RemoteTicketsell> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	
	
	public ParameterService getParameterService() {
		return parameterService;
	}
	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}
	
	// 获取车票并锁住
	@SuppressWarnings("unchecked")
	public List<Ticketsell> getTickets(String ticketno,Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select  t from Ticketsell t where t.ticketno like :ticketno and t.tickettype='T'")
		.append(" and t.departdate>=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);	
		Billtype billtype = billtypeService.findByCode("Ticket");
		//如果是团体票的子号，则取母号 ---- 用于点击检团体票时，子号退检后，母号不能退检，如有影响其他方法，可以隐藏
		if((billtype.getTicketnolength()+1)==ticketno.length()){//小于十人情况的团体票票号处理
			ticketno=ticketno.substring(0, ticketno.length()-1);
		}else if((billtype.getTicketnolength()+2)==ticketno.length()){//大于10人小于100人团体票
			ticketno=ticketno.substring(0, ticketno.length()-2);
		}
		query.setParameter("ticketno",ticketno+"%");
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}
	//用来判断当前票号和发车日期决定的车票数量是否大于一张
	public List<Object> getTicketcout(String ticketno,Date departdate,String certificateno){
	    SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	    String fromdates=sdf.format(departdate);
	    List<Object> list  = null;
		StringBuilder sql =new  StringBuilder();
		//如果票号不为空，则使用票号。
		if(!"".equals(ticketno)&&ticketno!=null){
			sql.append("select t.id,t.scheduleplanid, t.ticketno , c.name ,c.certificateno,ddd.value as certificatetype,s.code as schedulecode,trim(t.departtime) as departtime,r.isrealnameticket,t.ticketstatus ticketstatus")
			.append(" from Ticketsell t left join schedule s on s.id = t.scheduleid ")
			.append(" left join route r on r.id = s.routeid  ")
			.append(" left join customer c on c.id = t.customerid  ")
			.append(" left join digitaldictionary dd on dd.tablename = 'customer' and dd.columnname = 'certificatetype' ")
			.append(" left join digitaldictionarydetail ddd on ddd.digitaldictionaryid = dd.id and ddd.code = c.certificatetype ")
			.append(" where t.ticketno=:ticketno and t.departdate =to_date('"+fromdates+"','yyyymmdd') ");
		//否则，如果证件号不为空 使用证件号校验。
		}else if(!"".equals(certificateno)&&certificateno!=null){
			sql.append(
					"select ts.id,ts.scheduleplanid, ts.ticketno, c.name ,c.certificateno,ddd.value as certificatetype,s.code as schedulecode,trim(ts.departtime) as departtime,r.isrealnameticket,ts.ticketstatus ticketstatus ")
					.append(" from customer c left join ticketsell ts on c.id= ts.customerid ")
					.append(" left join digitaldictionary dd on dd.tablename = 'customer' and dd.columnname = 'certificatetype' ")
					.append(" left join digitaldictionarydetail ddd on ddd.digitaldictionaryid = dd.id and ddd.code = c.certificatetype ")
					.append(" left join schedule s on s.id = ts.scheduleid left join route r on r.id = s.routeid  ")
					.append(" where c.certificateno=:certificateno and ts.departdate =to_date('"+fromdates + "','yyyymmdd')  ");
		}else{
			return null;
		}
		Query query = em.createNativeQuery(sql.toString());
		//query.setParameter("departdate", departdate);
		if(!"".equals(ticketno)&&ticketno!=null){
			query.setParameter("ticketno", ticketno);
		}
		if(!"".equals(certificateno)&&certificateno!=null){
			query.setParameter("certificateno", certificateno);
		}
		//如果没有记录,则增加票号位数至设定长度再次查询
		list =query.getResultList();
		if((list==null||list.size()<=0) && !"".equals(ticketno) && ticketno!=null){
			sql = new  StringBuilder("select t.id,t.scheduleplanid, t.ticketno,c.name ,c.certificateno,ddd.value as certificatetype,s.code as schedulecode,trim(t.departtime) as departtime,r.isrealnameticket,t.ticketstatus ticketstatus ")
					.append(" from Ticketsell t left join schedule s on s.id = t.scheduleid ")
					.append(" left join route r on r.id = s.routeid  ")
					.append(" left join customer c on c.id = t.customerid   ")
					.append(" left join digitaldictionary dd on dd.tablename = 'customer' and dd.columnname = 'certificatetype' ")
					.append(" left join digitaldictionarydetail ddd on ddd.digitaldictionaryid = dd.id and ddd.code = c.certificatetype ")
					.append(" where t.ticketno=:ticketno and t.departdate =to_date('"+fromdates+"','yyyymmdd') ");
			query = em.createNativeQuery(sql.toString());
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
			query.setParameter("ticketno", cuticketno);
			list =query.getResultList();
			
			if((list==null||list.size()<=0) && !"".equals(ticketno) && ticketno!=null){
				sql = new  StringBuilder("select t.id,t.scheduleplanid, t.ticketno,c.name ,c.certificateno,ddd.value as certificatetype,s.code as schedulecode,trim(t.departtime) as departtime,r.isrealnameticket,t.ticketstatus ticketstatus ")
						.append(" from Ticketsell t left join schedule s on s.id = t.scheduleid ")
						.append(" left join route r on r.id = s.routeid  ")
						.append(" left join customer c on c.id = t.customerid   ")
						.append(" left join digitaldictionary dd on dd.tablename = 'customer' and dd.columnname = 'certificatetype' ")
						.append(" left join digitaldictionarydetail ddd on ddd.digitaldictionaryid = dd.id and ddd.code = c.certificatetype ")
						.append(" where t.eticketno=:ticketno and t.departdate =to_date('"+fromdates+"','yyyymmdd') ");
				query = em.createNativeQuery(sql.toString());
				query.setParameter("ticketno", ticketno);
				list =query.getResultList();
			}
		}
		return list;
	}
	//显示票号和发车日期对应的多条记录的显示信息
	//获取多条票号的详细信息
	public List<Object> querymultickets(String ticketno,Date departdate,String certificateno)
	{
	    SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	    String fromdates=sdf.format(departdate);
 		StringBuilder sql = new StringBuilder("select t.id, t.ticketno, t.departdate, s.name,");
 		sql.append(" sd.code, t.seatno, dd.value,sp.id as scheduleplanid,trim(t.departtime) departtime,");
 		sql.append("  c.name customername, dd1.value certificatetypename, c.certificateno ");
		sql.append(" FROM ticketsell t left join schedule  sd on t.scheduleid = sd.id ");
 		sql.append(" left join scheduleplan sp on sp.id = t.scheduleplanid ");
		sql.append(" left join station s on t.reachstationid = s.id left join  customer c on t.customerid = c.id");
		sql.append(" left join  digitaldictionarydetail dd on dd.digitaldictionaryid=52 and t.ticketstatus = dd.code ");
		sql.append(" left join digitaldictionarydetail dd1 on dd1.digitaldictionaryid = 35 and c.certificatetype=dd1.code ");
		sql.append(" where t.ticketstatus='0' and t.ischecked=0 and t.departdate=sp.departdate and t.departdate =to_date('"+fromdates+"','yyyymmdd') ");
		if(!"".equals(ticketno)&&ticketno!=null){
			sql.append(" and t.ticketno=:ticketno ");
		}
		if(!"".equals(certificateno)&&certificateno!=null){
			sql.append(" and c.certificateno=:certificateno ");
		}
		sql.append("  order by t.departtime");
		Query query = em.createNativeQuery(sql.toString());
		if(!"".equals(ticketno)&&ticketno!=null){
			query.setParameter("ticketno", ticketno);
		}
		if(!"".equals(certificateno)&&certificateno!=null){
			query.setParameter("certificateno", certificateno);
		}
		//query.setParameter("departdate", departdate);
	    play.Logger.info("querymultickets begin");
	    List<Object> list=query.getResultList();
	    play.Logger.info("list.size="+list.size());
	    play.Logger.info("querymultickets end");
	    //如果没有数据，则修改票号至设置长度再次查询
	    if(list.size()<=0&&!"".equals(ticketno)&&ticketno!=null){
	    	Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
	    	query = em.createNativeQuery(sql.toString());
	    	query.setParameter("ticketno", cuticketno);
	    	list=query.getResultList();
	    }
	    return list;
	}
	//通过售票ID获取唯一车票
	public Ticketsell getonlyTicketsell(long ticketsellid)
	{
		String sql="select t from Ticketsell t where t.id=:ticketsellid";
		Query query = em.createQuery(sql.toString());
		query.setParameter("ticketsellid", ticketsellid);
		List<Ticketsell> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;	
	}
	//新增通过车票ID号获取到车票号，然后获取团体票所有票
	public String getTicketno(long ticketid){
		String sql = "select ticketno from ticketsell t where t.id="+ticketid;
		Query query = em.createNativeQuery(sql.toString());
		return (String)query.getSingleResult();
	}
	//通过售票ID获取售票信息
	public Ticketsell getTicketsell(Long ticketid)
	{
		String sql ="select t from Ticketsell t where t.id ="+ticketid;
		Query query = em.createQuery(sql.toString());
		List<Ticketsell> list = query.getResultList();
		return list.get(0);
	}
	//判断当前票号所对应的流水班是否存在发车记录
	public boolean lineworkexistdepart(String ticketno,String departdate)
	{
		StringBuffer sql =new StringBuffer("select d.departinvoicesno as departinvoicesno")
		.append(" from schedule s,departinvoices d ")
		.append("  where s.routeid in (select distinct r.id ")
		.append("  from ticketsell   ts, schedulestop ss, schedule     t,  route        r")
		.append("  where ts.ticketno = '"+ticketno+"' ")
		.append("  and ts.islinework = '1' ")
		.append("  and ts.reachstationid = ss.stationid ")
		.append(" and ss.issellable='1' ")
		.append(" and ss.scheduleid = t.id ")
		.append("   and t.routeid = r.id) ")
		.append(" and d.scheduleid = s.id ")
		.append(" and  d.departdate=to_date('"+departdate+"','yyyy/mm/dd')")
		.append(" union all ")
		.append(" select ds.departinvoicesno as departinvoicesno ")
		.append(" from schedule s,departinvoicesother ds ")
		.append("  where s.routeid in (select distinct r.id ")
		.append("  from ticketsell   ts, schedulestop ss, schedule     t,  route        r")
		.append("  where ts.ticketno =  '"+ticketno+"'  ")
		.append("  and ts.islinework = '1' ")
		.append("  and ts.reachstationid = ss.stationid ")
		.append(" and ss.issellable='1' ")
		.append(" and ss.scheduleid = t.id ")
		.append("   and t.routeid = r.id) ")
		.append(" and ds.scheduleid = s.id ")
		.append(" and  ds.departdate=to_date('"+departdate+"','yyyy/mm/dd')");
		
		Query query = em.createNativeQuery(sql.toString());
		List<Object> list = query.getResultList();
		if (list.size()>0)
			return true;
		else
			return false;
		
		
	}
	/**
	 * @Title queryTicketByTicketno
	 * @Description 查询单表(售票表)，关联departinvoicesothersell
	 * @param ticketno
	 * @return List<Object> 
	 * @author tianhb
	 * @date 2016年6月13日-下午9:48:34
	 * @update 
	 * @throws
	 */
	public List<Object> queryTicketByTicketno(String ticketno) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select 0 as isselect,ts.id as id,ts.ticketno as ticketno ,ts.seatno as seatno,ts.price as price")
		.append(" ,trim(ts.departtime) as departtime,ts.computefee as computefee,ts.otherfee as otherfee, ts.stationservicefee as stationservicefee,ts.departstationid as departstationid,ts.ischecked as ischecked")
		.append(" ,nvl(do.id,-1) as departinvoicesotherid,restation.name reachstationname,tt.name tickettype,s.code schedulecode ")
		.append(" from ticketsell ts left join station restation on ts.reachstationid = restation.id left join tickettype tt on tt.code = ts.tickettype"
				+ " left join departinvoicesothersell dos on ts.id = dos.ticketsellid")
		.append(" left join departinvoicesotherdetail dod on dod.id = dos.departinvoicesotherdetailid")
		.append(" left join departinvoicesother do on do.id = dod.departinvoicesotherid")
		.append("    left join schedule s on s.id = ts.scheduleid ")
		.append(" where ts.ticketno = :ticketno and ts.ticketstatus='0'")
		.append(" and ts.departdate >= trunc(sysdate-180)");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		List<Object> list = query.getResultList();
		if(list==null||list.size()<=0){
			query = em.createNativeQuery(sql.toString());	
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
			query.setParameter("ticketno", cuticketno);
			list=query.getResultList();
		}
		return list;
	}
	/**
	 * 
	 * @Title queryTicketByDepartinvoicesotherid
	 * @Description 查询单表(售票表)，关联departinvoicesothersell
	 * @param departinvoicesotherid
	 * @return List<Object> 
	 * @author tianhb
	 * @date 2016年6月13日-下午9:48:31
	 * @update 
	 * @throws
	 */
	public List<Object> queryTicketByDepartinvoicesotherdetailid(Long departinvoicesotherdetailid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select 0 as isselect, nvl(ts.id,-1) as id,ts.ticketno as ticketno ,ts.seatno as seatno,ts.price as price")
		.append(" ,trim(ts.departtime) as departtime,ts.stationservicefee as stationservicefee,ts.departstationid as departstationid,ts.ischecked as ischecked")
		.append(" ,nvl(do.id,-1) as departinvoicesotherid,restation.name reachstationname,tt.name tickettype,ts.computefee  computefee")
		.append(" from departinvoicesothersell dos left join ticketsell ts on ts.id = dos.ticketsellid")
		.append(" left join station restation on ts.reachstationid = restation.id left join tickettype tt on tt.code = ts.tickettype ")
		.append(" left join departinvoicesotherdetail dod on dod.id = dos.departinvoicesotherdetailid")
		.append(" left join departinvoicesother do on do.id = dod.departinvoicesotherid")
		.append(" where dod.id = :departinvoicesotherdetailid");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesotherdetailid", departinvoicesotherdetailid);
		List<Object> list = query.getResultList();
		return list;
				   
	}
	
	/**
	 * 通过 scheduleplanid,seatno 查询改签车票的新票对象
	 * @return
	 */
	public Ticketsell qryChangeTicketsell(Long scheduleplanid, Short seatno){
		StringBuffer sql =new StringBuffer();
		sql.append("select nt from Ticketsell ot, Ticketchange tc, Ticketsell nt  ")
			.append(" where ot.id = tc.oldticketsellid and tc.newticketsellid = nt.id ")
			.append("       and nt.scheduleplanid = :scheduleplanid ")
			.append("       and nt.seatno = :seatno ")
			.append("       and nt.ticketstatus = '0' ")
			.append("  order by nt.id desc  ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		List<Ticketsell> list = query.getResultList();
		return (list != null && list.size() > 0) ? list.get(0) : null;
	}
	
	public List<Object> query_(List<PropertyFilter> propertyFilterList,String certificateno) {
		//车票重打：当系统为12位票段，支持输入8位票号
		for (int i = 0; i < propertyFilterList.size(); i++) {
			if("t!ticketno".equals(propertyFilterList.get(i).getPropertyFullName())){
				Ticketsell ticketsell = getTicket((String) propertyFilterList.get(i).getMatchValue());//通过前台传过来的票号得到数据库中的真实票号
				if(null != ticketsell){
					propertyFilterList.remove(i); //移除propertyFilterList中前台传过来的票号参数
					propertyFilterList.add(new PropertyFilter("EQS_t!ticketno",
							ticketsell.getTicketno())); //将数据库中的真实票号add到propertyFilterList中
				}
				break;
			}
		}
		StringBuilder sql = new StringBuilder(
				"select t.id, t.seatno, t.ticketno, t.departdate, trim(t.departtime), t.carrychildnum, ")
				.append(" t.fullprice, t.price, t.discountrate, t.stationservicefee, ")
				.append(" t.distance, t.selltime, t.ticketentrance, t.createtime, t.updatetime, ")
				.append(" ve.vehicleno as vehicleno, s.code as schedulecode, o.name as orgname, ")
				.append(" st.name as departname, so.name as reachname, u.name as sellname, ")
				.append(" us.name as createname, use.name as updatename, ti.name as ticketname ")
				.append(" ,t.sellby,t.sellway,t.sellby as sellid,length(t.ticketno) ticketlength,t.tickettype tickettype ")// 李电志  2015年8月25日 10:51:58 
				.append(" from Ticketsell t ")
				.append(" left join vehiclereport v ")
                .append(" left join vehicle ve on v.vehicleid = ve.id on t.vehiclereportid = v.id ")
                .append(" left join Schedule s on t.scheduleid = s.id ")
                .append(" left join Organization o on t.orgid = o.id  ")
                .append(" left join Station st on t.departstationid = st.id ")
                .append(" left join Station so on t.reachstationid = so.id ")
                .append(" left join Userinfo u on t.sellby = u.id ")
                .append(" left join Userinfo us on t.createby = us.id ")
                .append(" left join Userinfo use on t.updateby = use.id ")
                .append(" left join Ticketoutlets ti on t.ticketoutletsid = ti.id ")
                .append(" left join Scheduleplan sp on t.scheduleplanid = sp.id ")
                .append(" left join ticketsellother tso on tso.ticketsellid = t.id ")
                .append(" left join customer c on c.id = t.customerid ")
                .append(" where t.ticketstatus = '0' and t.ischecked = '0' ");
		if(!"".equals(certificateno)){
			sql.append(" and upper(c.certificateno) = upper('"+certificateno+"')");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 关联主票-儿童票表，查询出所有童票对应的主票号id和儿童票票号
	 * @param ticketsellIds： 车票id
	 * @return: (车票中)儿童票对应的主票号
	 */
	public List<Object[]> findQTicket(List<Long> ticketsellIds){
		StringBuffer sql = new StringBuffer();
		sql.append("select t.qticketid, ts.ticketno from carrychild t, ticketsell ts ");
		sql.append("where t.childticketid = ts.id ");
		sql.append("  and ts.id in :ticketsellIds ");
		Query query = super.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketsellIds", ticketsellIds);
		return query.getResultList();
	}
	
	/**
	 * 查询所勾选的车票（主票）中所有的儿童票
	 * @param primaryIdList
	 * @return
	 */
	public List<Object[]> findChildTicket(List<Long> primaryIdList){
		StringBuffer sql = new StringBuffer();
		sql.append("select t.qticketid,t.childticketid from carrychild t ");
		sql.append("where t.qticketid in :primaryIdList ");
		Query query = super.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("primaryIdList", primaryIdList);
		return query.getResultList();
	}
	
	/**
	 * 通过儿童票sellid查到主票记录
	 * @param childTicketsellId
	 * @return
	 */
	public Ticketsell findQticketBychild(Long childTicketsellId){
		StringBuffer sql = new StringBuffer();
		sql.append("select t from Ticketsell t, CarryChild c where t.id = c.qticketid and c.childticketid = :childTicketsellId  ");
		Query query = super.getEntityManager().createQuery(sql.toString());
		query.setParameter("childTicketsellId", childTicketsellId);
		List list = query.getResultList();
		return (Ticketsell) ((list != null && list.size() > 0) ? list.get(0) : null);
	}
	
	/**
	 * 通过主票sellid查到儿童票记录
	 * @param childTicketsellId
	 * @return
	 */
	public Ticketsell findChildByQticket(Long qticketId){
		StringBuffer sql = new StringBuffer();
		sql.append("select t from Ticketsell t, CarryChild c where t.id = c.childticketid and c.qticketid = :qticketId ");
		Query query = super.getEntityManager().createQuery(sql.toString());
		query.setParameter("qticketId", qticketId);
		List list = query.getResultList();
		return (Ticketsell) ((list != null && list.size() > 0) ? list.get(0) : null);
	}
	
	/**
	 * 通过儿童票id查询CarryChild记录
	 * @param childid
	 * @return
	 */
	public CarryChild findCarryChildByChildid(Long childid){
		StringBuffer sql = new StringBuffer();
		sql.append("select t from CarryChild t where t.childticketid = :childid ");
		Query query = super.getEntityManager().createQuery(sql.toString());
		query.setParameter("childid", childid);
		List list = query.getResultList();
		return (CarryChild) ((list != null && list.size() > 0) ? list.get(0) : null);
	}
	
	/**
	 * 通过改签之前的车票id，查询到改签之后的新车票
	 * @param oldtiketid
	 * @return
	 */
	public Ticketsell findNewTicketByOldTicket(Long oldtiketid){
		StringBuffer sql = new StringBuffer();
		sql.append("select tn from Ticketsell ot, Ticketchange tc, Ticketsell tn ");
		sql.append("  where ot.id = tc.oldticketsellid and tc.newticketsellid = tn.id ");
		sql.append("        and ot.id = :oldtiketid ");
		Query query = super.getEntityManager().createQuery(sql.toString());
		query.setParameter("oldtiketid", oldtiketid);
		List list = query.getResultList();
		return (Ticketsell) ((list != null && list.size() > 0) ? list.get(0) : null);
	}
	 
	 public static void main(String[] args) throws InterruptedException {
	        while (true) {

	        }
	    }
	
}
