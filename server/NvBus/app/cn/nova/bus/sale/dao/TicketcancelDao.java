package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;


public class TicketcancelDao extends EntityManagerDaoSurport<Ticketcancel> {
	
	public List<Map<String,Object>> find(List<PropertyFilter> propertyFilters,Long loginorgid){
		//判断查询方式
		boolean isfindbyvip = false; //按VIP查询
		boolean isfindbyschedule = false; //按班次查询
		for (PropertyFilter propertyFilter : propertyFilters) {
			if(propertyFilter.getPropertyFullName().equalsIgnoreCase("v!vipcardno")){
				isfindbyvip = true;
			}
			if(propertyFilter.getPropertyFullName().equalsIgnoreCase("sc!id")){
				isfindbyschedule = true;
			}
		}
		StringBuilder sql = new StringBuilder();
		sql.append("select 1 as isselfschedule,");
		if(loginorgid==null||loginorgid<=0){
			sql.append(" case tsl.ticketstatus when '0' then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' then 1 else null end as iscancelinsure,");
		}else{
			sql.append(" case when tsl.ticketstatus='0' and (tsl.orgid="+loginorgid+" or sc.orgid="+loginorgid+")  then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' and (tsl.orgid="+loginorgid+" or sc.orgid="+loginorgid+") then 1 else null end as iscancelinsure,");
		}
//		.append(" tsl.id,tsl.scheduleplanid,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
		sql.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
		.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.orgid,sc.orgid as scheduleorgid,tsl.paymethod,")
		.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
		.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
//		.append(" tsl.departstationid,tsl.reachstationid,tsl.scheduleid,") 
		.append(" tsl.departstationid,tsl.reachstationid,")
		
		.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,isr.sellby as insurancesellby,")
		
		.append(" sc.code as schedulecode,")
		.append(" ctm.name as customername,")
		.append(" std.name as departstationname,")
		.append(" str.name as reachstationname")
		
		.append(" from Ticketsell tsl left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0 and isr.isselfschedule=1")
		.append(" left join Customer ctm on tsl.customerid=ctm.id")
		.append(" ,Station std,Station str,Schedule sc ");
		if(isfindbyvip){
			sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
		}
		sql.append(" where tsl.departstationid=std.id") 
		.append("   and tsl.scheduleid=sc.id")
		.append(" and tsl.sellway<>'12'")
		.append(" and ((tsl.ticketstatus in( '0','1')) or ") //新增废票查询只查询退票状态的
		.append(" 	(tsl.tickettype = 'T' ) ) ") //团体票全部查询出来 下面处理
		.append(" and tsl.reachstationid=str.id");
		if(isfindbyvip){
			sql.append(" and v.id=vc.vipid")
			.append(" and vc.type='0'")
			.append(" and vc.id=vcd.vipconsumeid")
			.append(" and vcd.isselfschedule=1")
			.append(" and vcd.sellid=tsl.id");
		}
		String clientCondition = PropertyFilter.toJpql(propertyFilters, true);
		if(clientCondition==null||clientCondition.trim().equals("")){
			clientCondition = " and 1=2";
		}
		sql.append(clientCondition);

		List<PropertyFilter> propertyFilters_agent = new ArrayList<PropertyFilter>();
		propertyFilters_agent.addAll(propertyFilters);
		if(!isfindbyschedule){
			//查询售异站票表
			sql.append(" union all select 0 as isselfschedule,")
			.append(" case tsl.ticketstatus when '0' then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' then 1 else null end as iscancelinsure,")
			.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
			.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
			.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
			.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
			.append(" tsl.departstationid,tsl.reachstationid,")
			
			.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,isr.sellby as insurancesellby,")
			
			.append(" tsl.schedulecode,")
			.append(" ctm.name as customername,")
			.append(" std.name as departstationname,")
			.append(" str.name as reachstationname")
			
			.append(" from Ticketsellagent tsl left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0 and isr.isselfschedule=0")
			.append(" left join Customer ctm on tsl.customerid=ctm.id")
			.append(" ,Station std,Station str ,Userinfo usell "); 
			if(isfindbyvip){
				sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
			}
			sql.append(" where tsl.departstationid=std.id")
			.append(" and tsl.reachstationid=str.id")
			.append(" and ((tsl.ticketstatus in( '0','1')) or ") //新增废票查询只查询退票状态的
			.append(" 	(tsl.tickettype = 'T' ) ) ") //团体票全部查询出来 下面处理
			.append(" and tsl.sellby=usell.id");
			if(isfindbyvip){
				sql.append(" and v.id=vc.vipid")
				.append(" and vc.type='0'")
				.append(" and vc.id=vcd.vipconsumeid")
				.append(" and vcd.isselfschedule=0")
				.append(" and vcd.sellid=tsl.id");
			}
			String clientCondition_agent = PropertyFilter.toJpql(propertyFilters_agent, true);
			if(clientCondition_agent==null||clientCondition_agent.trim().equals("")){
				clientCondition_agent = " and 1=2";
			}
			sql.append(clientCondition_agent);			
			
			//openAPI省中心联网废票查询
			sql.append(" union all select 0 as isselfschedule,")
			.append(" case tsl.ticketstatus when '0' then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' then 1 else null end as iscancelinsure,")
			.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
			.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
			.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
			.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
			.append(" tsl.departstationid,tsl.reachstationid,")
			
			.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,isr.sellby as insurancesellby,")
			
			.append(" tsl.schedulecode,")
			.append(" ctm.name as customername,")
			.append(" tsl.departstationname as departstationname,")
			.append(" tsl.reachstationname as reachstationname")
			
			.append(" from Ticketsellagent tsl left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0 and isr.isselfschedule=0")
			.append(" left join Customer ctm on tsl.customerid=ctm.id")
			.append(" ,Userinfo usell "); 
			if(isfindbyvip){
				sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
			}
			sql.append(" where 1=1")
			.append(" and tsl.departstationname is not null and tsl.reachstationname is not null")
			.append(" and ((tsl.ticketstatus in( '0','1')) or ") //新增废票查询只查询退票状态的
			.append(" 	(tsl.tickettype = 'T' ) ) ") //团体票全部查询出来 下面处理
			.append(" and tsl.sellby=usell.id");
			if(isfindbyvip){
				sql.append(" and v.id=vc.vipid")
				.append(" and vc.type='0'")
				.append(" and vc.id=vcd.vipconsumeid")
				.append(" and vcd.isselfschedule=0")
				.append(" and vcd.sellid=tsl.id");
			}
			 clientCondition_agent = PropertyFilter.toJpql(propertyFilters_agent, true);
			if(clientCondition_agent==null||clientCondition_agent.trim().equals("")){
				clientCondition_agent = " and 1=2";
			}
			sql.append(clientCondition_agent);
			sql.append(" order by ticketno");
		
			
		}
				
		
		else{
			sql.append(" order by ticketno");
		}
		Query query = super.getEntityManager().createNativeQuery(sql.toString()); 
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result= query.getResultList();
		// ---------------------------退票：查询团体票begin---------------------------//
		String ticketno = null;
		List<String> ticket_t_nos = new ArrayList<String>();
		if(result != null && result.size() > 0){
			Object[] arr = null;
			BilltypeService billtypeService = new BilltypeServiceImpl();
			for(int i = result.size() - 1 ; i >= 0  ; i --){
				arr = (Object[]) result.get(i);
				if ("T".equals(arr[21].toString())) {
					ticketno = (String) arr[18];//团体票主票票号
					if(ticketno.length() > (billtypeService.findByCode("Ticket").getTicketnolength())){
						play.Logger.info(ticketno + "该团体票票号长度大于车票票据类型长度，则认为是团体票副票！");
					}else{
						//票号长度小于等于票据类型长度，则认为是团体票主票
						ticket_t_nos.add(ticketno);
					}
					result.remove(i);
				}else{
					continue;
				}
			}
		}
		if(ticket_t_nos.size() > 0){
			for(int i = 0 ; i < ticket_t_nos.size() ; i ++){
				ticketno = ticket_t_nos.get(i);
				result.addAll(qryTuanTickets(propertyFilters, ticketno, loginorgid));//根据主票票号查询出所有主票和副票数据	
			}
		}
		// ---------------------------退票：查询团体票end---------------------------//
		return ListUtil.listToMap(new Object[]{"isselfschedule","isselected","iscancelinsure","id","departdate","departtime","fullprice",
												"ischecked","isdepartinvoices","islinework","orgid","scheduleorgid","paymethod",
												"price","servicefee","seatno","sellby","selltime",
												"ticketno","sellway","ticketstatus","tickettype","seattype",
												"departstationid","reachstationid",
												
												"insuranceid","premium","insurancepaymethod","insuranceno","insurancesellby",
												"schedulecode","customername","departstationname","reachstationname"}, 
								  result, 
								  new Object[]{Boolean.class,Boolean.class,Boolean.class,Long.class,Date.class,String.class,BigDecimal.class,
											   Boolean.class,Boolean.class,Boolean.class,Long.class,Long.class,String.class,
											   BigDecimal.class,BigDecimal.class,Short.class,Long.class,Timestamp.class,
											   String.class,String.class,String.class,String.class,String.class,
											   Long.class,Long.class,
											   
											   Long.class,BigDecimal.class,String.class,String.class,Long.class,
											   String.class,String.class,String.class,String.class});
	}
	
	public List<Object> findspecialticket(List<PropertyFilter> propertyFilters) {
		StringBuffer sql = new StringBuffer("select ts.id specialticketid,so.id specialid")
		.append(" from ticketsell ts, specialorderinfo so ")
		.append(" where so.orderno = ts.orderno");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = super.getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}
	
	/**
	 * 团体票：根据主票票号查询出所有主票和副票数据
	 * @param propertyFilters
	 * @param ticketno：主票票号
	 * @return
	 */
	private List<Object> qryTuanTickets(List<PropertyFilter> propertyFilters, String ticketno, Long loginorgid){
		Iterator<PropertyFilter> iterator = propertyFilters.iterator();
		while(iterator.hasNext()){
			PropertyFilter propertyFilter = iterator.next();
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase("tsl!ticketno")) {
				iterator.remove();
				break;
			}
		}
		
		//判断查询方式
		boolean isfindbyvip = false; //按VIP查询
		boolean isfindbyschedule = false; //按班次查询
		for (PropertyFilter propertyFilter : propertyFilters) {
			if(propertyFilter.getPropertyFullName().equalsIgnoreCase("v!vipcardno")){
				isfindbyvip = true;
			}
			if(propertyFilter.getPropertyFullName().equalsIgnoreCase("sc!id")){
				isfindbyschedule = true;
			}
		}
		StringBuilder sql = new StringBuilder();
		sql.append("select 1 as isselfschedule,");
		if(loginorgid==null||loginorgid<=0){
			sql.append(" case tsl.ticketstatus when '0' then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' then 1 else null end as iscancelinsure,");
		}else{
			sql.append(" case when tsl.ticketstatus='0' and (tsl.orgid="+loginorgid+" or sc.orgid="+loginorgid+")  then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' and (tsl.orgid="+loginorgid+" or sc.orgid="+loginorgid+") then 1 else null end as iscancelinsure,");
		}
//		.append(" tsl.id,tsl.scheduleplanid,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
		sql.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
		.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.orgid,sc.orgid as scheduleorgid,tsl.paymethod,")
		.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
		.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
//		.append(" tsl.departstationid,tsl.reachstationid,tsl.scheduleid,") 
		.append(" tsl.departstationid,tsl.reachstationid,")
		
		.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,isr.sellby as insurancesellby,")
		
		.append(" sc.code as schedulecode,")
		.append(" ctm.name as customername,")
		.append(" std.name as departstationname,")
		.append(" str.name as reachstationname")
		
		.append(" from Ticketsell tsl left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0 and isr.isselfschedule=1")
		.append(" left join Customer ctm on tsl.customerid=ctm.id")
		.append(" ,Station std,Station str,Schedule sc ");
		if(isfindbyvip){
			sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
		}
		sql.append(" where tsl.departstationid=std.id") 
		.append("   and tsl.scheduleid=sc.id")
		.append(" and tsl.sellway<>'12'")
		.append(" and tsl.ticketstatus in( '0','2')") //新增废票查询只查询退票状态的
		.append(" and tsl.reachstationid=str.id");
		if(isfindbyvip){
			sql.append(" and v.id=vc.vipid")
			.append(" and vc.type='0'")
			.append(" and vc.id=vcd.vipconsumeid")
			.append(" and vcd.isselfschedule=1")
			.append(" and vcd.sellid=tsl.id");
		}
		if (!"".equals(ticketno)) {
			sql.append(" and tsl.ticketno like '").append(ticketno).append("%' ");//团体票票号查询使用like
		}
		String clientCondition = PropertyFilter.toJpql(propertyFilters, true);
		if(clientCondition==null||clientCondition.trim().equals("")){
			clientCondition = " and 1=2";
		}
		sql.append(clientCondition);

		List<PropertyFilter> propertyFilters_agent = new ArrayList<PropertyFilter>();
		propertyFilters_agent.addAll(propertyFilters);
		if(!isfindbyschedule){
			//查询售异站票表
			sql.append(" union all select 0 as isselfschedule,")
			.append(" case tsl.ticketstatus when '0' then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' then 1 else null end as iscancelinsure,")
			.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
			.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
			.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
			.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
			.append(" tsl.departstationid,tsl.reachstationid,")
			
			.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,isr.sellby as insurancesellby,")
			
			.append(" tsl.schedulecode,")
			.append(" ctm.name as customername,")
			.append(" std.name as departstationname,")
			.append(" str.name as reachstationname")
			
			.append(" from Ticketsellagent tsl left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0 and isr.isselfschedule=0")
			.append(" left join Customer ctm on tsl.customerid=ctm.id")
			.append(" ,Station std,Station str ,Userinfo usell "); 
			if(isfindbyvip){
				sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
			}
			sql.append(" where tsl.departstationid=std.id")
			.append(" and tsl.reachstationid=str.id")
			.append(" and tsl.ticketstatus in( '0','2')") //新增废票查询只查询退票状态的
			.append(" and tsl.sellby=usell.id");
			if(isfindbyvip){
				sql.append(" and v.id=vc.vipid")
				.append(" and vc.type='0'")
				.append(" and vc.id=vcd.vipconsumeid")
				.append(" and vcd.isselfschedule=0")
				.append(" and vcd.sellid=tsl.id");
			}
			if (!"".equals(ticketno)) {
				sql.append(" and tsl.ticketno like '").append(ticketno).append("%' ");//团体票票号查询使用like
			}
			String clientCondition_agent = PropertyFilter.toJpql(propertyFilters_agent, true);
			if(clientCondition_agent==null||clientCondition_agent.trim().equals("")){
				clientCondition_agent = " and 1=2";
			}
			sql.append(clientCondition_agent);			
			
			//openAPI省中心联网废票查询
			sql.append(" union all select 0 as isselfschedule,")
			.append(" case tsl.ticketstatus when '0' then 1 else null end as isselected,")
			.append(" case when isr.id is not null and tsl.ticketstatus='0' then 1 else null end as iscancelinsure,")
			.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
			.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
			.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
			.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
			.append(" tsl.departstationid,tsl.reachstationid,")
			
			.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,isr.sellby as insurancesellby,")
			
			.append(" tsl.schedulecode,")
			.append(" ctm.name as customername,")
			.append(" tsl.departstationname as departstationname,")
			.append(" tsl.reachstationname as reachstationname")
			
			.append(" from Ticketsellagent tsl left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0 and isr.isselfschedule=0")
			.append(" left join Customer ctm on tsl.customerid=ctm.id")
			.append(" ,Userinfo usell "); 
			if(isfindbyvip){
				sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
			}
			sql.append(" where 1=1")
			.append(" and tsl.departstationname is not null and tsl.reachstationname is not null")
			.append(" and tsl.ticketstatus in( '0','2')") //新增废票查询只查询退票状态的
			.append(" and tsl.sellby=usell.id");
			if(isfindbyvip){
				sql.append(" and v.id=vc.vipid")
				.append(" and vc.type='0'")
				.append(" and vc.id=vcd.vipconsumeid")
				.append(" and vcd.isselfschedule=0")
				.append(" and vcd.sellid=tsl.id");
			}
			if (!"".equals(ticketno)) {
				sql.append(" and tsl.ticketno like '").append(ticketno).append("%' ");//团体票票号查询使用like
			}
			 clientCondition_agent = PropertyFilter.toJpql(propertyFilters_agent, true);
			if(clientCondition_agent==null||clientCondition_agent.trim().equals("")){
				clientCondition_agent = " and 1=2";
			}
			sql.append(clientCondition_agent);
			sql.append(" order by ticketno");
		
			
		}
		else{
			sql.append(" order by ticketno");
		}
		
		Query query = super.getEntityManager().createNativeQuery(sql.toString()); 
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result= query.getResultList();
		
		return result;
	}

}
