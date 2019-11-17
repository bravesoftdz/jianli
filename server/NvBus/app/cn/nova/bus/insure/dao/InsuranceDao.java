package cn.nova.bus.insure.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Platforminsureorder;
import cn.nova.bus.base.model.Platforminsureorderdetail;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.vo.TicketreturnQueryDto;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;


public class InsuranceDao extends EntityManagerDaoSurport<Insurance> { 

	public List<Map<String, Object>> findTicket(
			List<PropertyFilter> propertyFilters,int isnet) {
		// " tr.ticketreturnid,tr.Billtype billtype,tr.returncharges,tr.remarks,tr.returnamount,"
		// +
		// " tr.returnip,tr.returntime,tr.returnvoucherno,tr.returnby," +
		if(isnet==1){
			StringBuilder sql = new StringBuilder();
			sql.append("select 1 as isnet,")
					.append(" case when isr.id is null and tsl.ticketstatus='0' then 1 else 0 end as isselected,")
					.append(" 0 as isselfschedule,tsl.distance,tsl.carrychildnum,")
					.append(" tsl.id,0 as scheduleplanid,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
					.append(" 0 as ischecked,0 as isdepartinvoices,tsl.islinework,tsl.orgid,tsl.paymethod,")
					.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
					.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,trim(tsl.tickettype) as tickettype,tsl.seattype,")
					.append(" tsl.departstationid,tsl.reachstationid,0 as scheduleid,")

					.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

					.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

					.append(" us.name as signbyname,")
					.append(" tsl.schedulecode,")
					.append(" ctm.name as customername,")
					.append(" std.name as departstationname,")
					.append(" str.name as reachstationname,")
					.append(" ' ' as reachstationsecondname,")
					.append(" tt.name ticketoutletsname,ctm.certificateno,ctm.mobilephone,isr.insureamount,ddt.value as certificatetypename")
					// trim(str.secondname)

					.append(" from Ticketsellagent tsl left join Ticketsign tsg")
					.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=0")
					.append(" left join Userinfo us on tsg.signby=us.id")
					.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
					.append(" left join ticketoutlets tt on isr.ticketoutletsid=tt.id")
					.append(" left join Customer ctm on tsl.customerid=ctm.id")
					.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
					.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")				
					.append(" ,Station std,Station str ")
					.append(" where tsl.departstationid=std.id")
					.append(" and tsl.reachstationid=str.id")
					.append(PropertyFilter.toJpql(propertyFilters, true));
			Query query = super.getEntityManager()
					.createNativeQuery(sql.toString()); // , TicketreturnQuery.class
			JPAPropertyFilterUtil.setParameter(query, propertyFilters);
			List<Object> result = query.getResultList();
			return ListUtil.listToMap(new Object[] {"isnet", "isselected",
					"isselfschedule", "distance", "carrychildnum", "id",
					"scheduleplanid", "departdate", "departtime", "fullprice",
					"ischecked", "isdepartinvoices", "islinework", "orgid",
					"paymethod", "price", "servicefee", "seatno", "sellby",
					"selltime", "ticketno", "sellway", "ticketstatus",
					"tickettype", "seattype", "departstationid", "reachstationid",
					"scheduleid",

					"ticketsignid", "signcharges", "signreason", "signtime",
					"signby", "insuranceid", "premium", "insurancepaymethod",
					"insuranceno", "signbyname", "schedulecode", "customername",
					"departstationname", "reachstationname",
					"reachstationsecondname","ticketoutletsname","certificateno",
					"mobilephone","insureamount","certificatetypename" }, result, new Object[] {Integer.class,
					Boolean.class, Boolean.class, Long.class, Byte.class,
					Long.class, Long.class, Date.class, String.class,
					BigDecimal.class, Boolean.class, Boolean.class, Boolean.class,
					Long.class, String.class, BigDecimal.class, BigDecimal.class,
					Short.class, Long.class, Timestamp.class, String.class,
					String.class, String.class, String.class, String.class,
					Long.class, Long.class, Long.class, Long.class,
					BigDecimal.class, String.class, Timestamp.class, Long.class,
					Long.class, BigDecimal.class, String.class, String.class,
					String.class, String.class, String.class, String.class,
					String.class, String.class,String.class,String.class,String.class,
					BigDecimal.class,String.class});
		}else{
			boolean isfindbyschedule = false; // 按班次查询
			Iterator<PropertyFilter> iterator = propertyFilters.iterator();
			while(iterator.hasNext()){
				PropertyFilter	propertyFilter = iterator.next();
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase("sc!id")) {
				isfindbyschedule = true;
			}
		}
			
		StringBuilder sql = new StringBuilder();
		sql.append("select 0 as isnet,")
				// isselfschedule reachstationsecondname distance carrychildnum
				.append(" case when isr.id is null and tsl.ticketstatus='0' then 1 else 0 end as isselected,")
				.append(" 1 as isselfschedule,tsl.distance,tsl.carrychildnum,")
				.append(" tsl.id,tsl.scheduleplanid,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
				.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.orgid,tsl.paymethod,")
				.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
				.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,trim(tsl.tickettype) as tickettype,tsl.seattype,")
				.append(" tsl.departstationid,tsl.reachstationid,tsl.scheduleid,")

				.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

				.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

				.append(" us.name as signbyname,")
				.append(" sc.code as schedulecode,")
				.append(" ctm.name as customername,")
				.append(" std.name as departstationname,")
				.append(" str.name as reachstationname,")
				.append(" ' ' as reachstationsecondname,")
				.append(" tt.name ticketoutletsname,ctm.certificateno,ctm.mobilephone,isr.insureamount,ddt.value as certificatetypename")
				// trim(str.secondname)

				.append(" from Ticketsell tsl left join Ticketsign tsg")
				.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=1")
				.append(" left join Userinfo us on tsg.signby=us.id")
				.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
				.append(" left join ticketoutlets tt on isr.ticketoutletsid=tt.id")
				.append(" left join Customer ctm on tsl.customerid=ctm.id")
				.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
				.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")				
				.append(" ,Schedule sc,Station std,Station str ")
				.append(" where tsl.scheduleid=sc.id")
				.append(" and tsl.departstationid=std.id")
				.append(" and tsl.reachstationid=str.id")
				.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = super.getEntityManager()
				.createNativeQuery(sql.toString()); // , TicketreturnQuery.class
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result = query.getResultList();
		
		if(result != null && result.size() > 0 && !isfindbyschedule ){ 
			Object[] arrayobj  = (Object[]) result.get(0);
			
			if(arrayobj[23].toString().equals("T")){//说明有团体票
				result.removeAll(result);
				return qryTuanTickets(propertyFilters);
			}
		}
		return ListUtil.listToMap(new Object[] {"isnet", "isselected",
				"isselfschedule", "distance", "carrychildnum", "id",
				"scheduleplanid", "departdate", "departtime", "fullprice",
				"ischecked", "isdepartinvoices", "islinework", "orgid",
				"paymethod", "price", "servicefee", "seatno", "sellby",
				"selltime", "ticketno", "sellway", "ticketstatus",
				"tickettype", "seattype", "departstationid", "reachstationid",
				"scheduleid",

				"ticketsignid", "signcharges", "signreason", "signtime",
				"signby", "insuranceid", "premium", "insurancepaymethod",
				"insuranceno", "signbyname", "schedulecode", "customername",
				"departstationname", "reachstationname",
				"reachstationsecondname","ticketoutletsname","certificateno",
				"mobilephone","insureamount","certificatetypename" }, result, new Object[] {Integer.class,
				Boolean.class, Boolean.class, Long.class, Byte.class,
				Long.class, Long.class, Date.class, String.class,
				BigDecimal.class, Boolean.class, Boolean.class, Boolean.class,
				Long.class, String.class, BigDecimal.class, BigDecimal.class,
				Short.class, Long.class, Timestamp.class, String.class,
				String.class, String.class, String.class, String.class,
				Long.class, Long.class, Long.class, Long.class,
				BigDecimal.class, String.class, Timestamp.class, Long.class,
				Long.class, BigDecimal.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class,String.class,String.class,String.class,
				BigDecimal.class,String.class});
		}
	}
	public List<Map<String, Object>> qryTuanTickets(
			List<PropertyFilter> propertyFilters) {
		Iterator<PropertyFilter> iterator = propertyFilters.iterator();
		while(iterator.hasNext()){
			PropertyFilter	propertyFilter = iterator.next();
			String ticketno = "";
		if (propertyFilter.getPropertyFullName().equalsIgnoreCase("tsl!ticketno")) {
			ticketno  = propertyFilter.getMatchValue().toString();
			iterator.remove();
			propertyFilters.add(new PropertyFilter("LIKELS_tsl!ticketno",ticketno));
			break;
		}
		}
		StringBuilder sql = new StringBuilder();
		sql.append("select 0 as isnet,")
				.append(" case when isr.id is null and tsl.ticketstatus='0' then 1 else 0 end as isselected,")
				.append(" 1 as isselfschedule,tsl.distance,tsl.carrychildnum,")
				.append(" tsl.id,tsl.scheduleplanid,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
				.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.orgid,tsl.paymethod,")
				.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,tsl.selltime,")
				.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,trim(tsl.tickettype) as tickettype,tsl.seattype,")
				.append(" tsl.departstationid,tsl.reachstationid,tsl.scheduleid,")

				.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

				.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

				.append(" us.name as signbyname,")
				.append(" sc.code as schedulecode,")
				.append(" ctm.name as customername,")
				.append(" std.name as departstationname,")
				.append(" str.name as reachstationname,")
				.append(" ' ' as reachstationsecondname,")
				.append(" tt.name ticketoutletsname,ctm.certificateno,ctm.mobilephone,isr.insureamount,ddt.value as certificatetypename")
				// trim(str.secondname)

				.append(" from Ticketsell tsl left join Ticketsign tsg")
				.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=1")
				.append(" left join Userinfo us on tsg.signby=us.id")
				.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
				.append(" left join ticketoutlets tt on isr.ticketoutletsid=tt.id")
				.append(" left join Customer ctm on tsl.customerid=ctm.id")
				.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
				.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")				
				.append(" ,Schedule sc,Station std,Station str ")
				.append(" where tsl.scheduleid=sc.id")
				.append(" and tsl.departstationid=std.id")
				.append(" and tsl.reachstationid=str.id")
				.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = super.getEntityManager()
				.createNativeQuery(sql.toString()); // , TicketreturnQuery.class
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result = query.getResultList();
		
		return ListUtil.listToMap(new Object[] {"isnet", "isselected",
				"isselfschedule", "distance", "carrychildnum", "id",
				"scheduleplanid", "departdate", "departtime", "fullprice",
				"ischecked", "isdepartinvoices", "islinework", "orgid",
				"paymethod", "price", "servicefee", "seatno", "sellby",
				"selltime", "ticketno", "sellway", "ticketstatus",
				"tickettype", "seattype", "departstationid", "reachstationid",
				"scheduleid",

				"ticketsignid", "signcharges", "signreason", "signtime",
				"signby", "insuranceid", "premium", "insurancepaymethod",
				"insuranceno", "signbyname", "schedulecode", "customername",
				"departstationname", "reachstationname",
				"reachstationsecondname","ticketoutletsname","certificateno",
				"mobilephone","insureamount","certificatetypename" }, result, new Object[] {Integer.class,
				Boolean.class, Boolean.class, Long.class, Byte.class,
				Long.class, Long.class, Date.class, String.class,
				BigDecimal.class, Boolean.class, Boolean.class, Boolean.class,
				Long.class, String.class, BigDecimal.class, BigDecimal.class,
				Short.class, Long.class, Timestamp.class, String.class,
				String.class, String.class, String.class, String.class,
				Long.class, Long.class, Long.class, Long.class,
				BigDecimal.class, String.class, Timestamp.class, Long.class,
				Long.class, BigDecimal.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class,String.class,String.class,String.class,
				BigDecimal.class,String.class});
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryInsurance(Date selldate) {
		StringBuilder sql = new StringBuilder(
				"select ty.name as planname,isr.bankcode,")
				.append(" ty.code as productCode,'乘客' as name,")
				.append(" to_char(ts.departdate, 'yyyymmdd') || ts.ticketno || ts.seatno as govtID,")
				.append(" to_char(ts.departdate, 'yyyy-mm-dd') as departdate,isr.selladdress,isr.returnaddress,iu.id")
				.append(" from ticketsell ts, insurance iu, insuretype ty, insurers isr")
				.append(" where ts.id = iu.sellid  and iu.insuretypeid = ty.id")
				.append(" and iu.insurersid = isr.id and iu.insurancestatus = '0'")
				.append(" and ts.ticketstatus = '0'  and iu.selltime>=:selldate ")
				.append(" and iu.polnumber is null and rownum<=50");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("selldate", selldate);
		return query.getResultList();
	}
	/**
	 * 获取平台售保险信息
	 * @param sellid
	 * @param schedulecode
	 * @return
	 */
	public List<Object[]> getPlatformInfo(long sellid) {
		StringBuilder sql = new StringBuilder();
		sql.append("select t.orderno orderno,t.selltime selltime,s.code code1,a.code code2 from ticketsell t,station s,station a where ")
		.append(" t.departstationid=s.id and t.reachstationid=a.id and t.id="+sellid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	/**
	 * 查询保险服务器保险订单表
	 * @return
	 */
	public List<Platforminsureorder> queryPlatformInsuranceOrder() {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t from  Platforminsureorder t where ")
		.append(" t.status=1 ");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	/**
	 * 查询保险订单详情表
	 * @param insureorderid
	 * @return
	 */
	public List<Platforminsureorderdetail> queryPlatformInsuranceDetail(
			long insureorderid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t from  Platforminsureorderdetail t where ")
		.append(" t.insureorderid="+insureorderid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	/**
	 * 查询保险服务器保险退单/废单
	 * @return
	 */
	public List queryPlatformReturnInsurance() {
		StringBuilder sql = new StringBuilder();
		sql.append(" select p.insuranceno,p.orderno,pd.insureno,pd.etinsureno,pd.id,p.issuingtype from  ")
		.append("  platforminsureorderdetail pd left join platforminsureorder p ")
		.append(" on pd.insureorderid=p.id where pd.status=4 ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

}
