/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.query.dao<br/>
 * <b>文件名：</b>InsuranceQryDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-2-22 上午10:08:56<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.query.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import util.CurrentUtil;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>InsuranceQryDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-2-22 上午10:08:56<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class InsuranceQryDao extends EntityManagerDaoSurport { 
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
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryInsurance(List<PropertyFilter> buildFromHttpRequest,
			long routeid, String schedulecode, String orderno) {
		
		StringBuffer sql = new StringBuffer();
		sql.append("select trim(og.name) sellorg ,trim(o.name) htsellorg,ti.name ticketname, ")
		.append(" t.ticketno, t.departdate, r.name routename, s.code code,  ")
		.append(" st.name endname, trim(t.departtime) departtime, i.insuranceno, c.name customername, ")
		.append(" c.mobilephone, c.certificateno, ise.name insurername, it.name typename, ")
		.append(" i.premium, i.insureamount, i.insurancestatus, ")
		.append(" u.name sellname, i.selltime, i.paymethod, i.sellway, i.sellip, i.polnumber, ")
		.append(" i.createtime insuranceprintdatetime, ")
		.append(" it.ywmoney ywmoney, ")
		.append(" it.shmoney shmoney, ")
		.append(" it.emoney emoney, ")
		.append(" it.emmoney emmoney, ")
		.append(" '0' reprintnum, ")
		.append(" ti.address outletsaddress, ")
		.append(" case i.insurancestatus when '1' then (select ufo1.code from insurancereturn ir,userinfo ufo1 where ufo1.id=ir.returnby and ir.insuranceid=i.id) ")
		.append(" when '2' then (select ufo2.code from insurancecancel ic,userinfo ufo2 where ufo2.id=ic.cancelby and ic.insuranceid=i.id) ")
		.append(" else '' end returnorcancelby, ")
		.append(" case i.insurancestatus when '1' then (select to_char(returntime,'yyyy-mm-dd hh24:mi:ss') from insurancereturn ir where ir.insuranceid=i.id) ")
		.append(" when '2' then (select to_char(canceltime,'yyyy-mm-dd hh24:mi:ss') from insurancecancel ic where ic.insuranceid=i.id) ")
		.append(" else '' end returnorcanceltime, ")
		.append(" ise.bankcode insurersbankcode, ")
		.append(" stst.name startname, ")
		.append(" it.code insuretypecode, ")
		.append(" t.islinework islinework, ")
		.append(" t.seatno seatno, ")
		.append(" i.sellby sellby, ")
		.append(" (select org.code from organization org where org.id=ti.orgid ) orgcode, ")
		.append(" c.certificatetype certificatetype ,")
		.append(" case when i.insurancestatus='0' and t.ischecked = 0 then 1 else null end as isreturninsure,t.ischecked,t.isdepartinvoices,i.id insuranceid, tso.orderno,")
		.append(" t.ticketstatus ticketstatus,nvl(decode(i.orgid,t.orgid,t.returnfeemode,'0'),'0') returnfeemode")
		.append(" ,ss.isdeparted as isdeparted ,i.orderno as iorderno")
		.append(" from insurance i  ")
		.append(" left join ticketsell t on i.sellid=t.id ")
		.append(" left join ticketsellother tso on tso.ticketsellid=t.id ")
		.append(" left join ticketoutlets ti on t.ticketoutletsid=ti.id ")
		.append(" left join schedule s on t.scheduleid=s.id ")
		.append(" left join schedulestatus ss on ss.scheduleplanid=t.scheduleplanid ")
		.append(" left join route r on s.routeid=r.id ")
		.append(" left join station st on t.reachstationid=st.id ")
		.append(" left join station stst on t.departstationid=stst.id ")
		.append(" left join customer c on i.customerid=c.id ")
		.append(" left join insurers ise on i.insurersid=ise.id ")
		.append(" left join insuretype it on i.insuretypeid=it.id ")
		.append(" left join userinfo u on i.sellby=u.id,organization o,organization og ")
		.append(" where og.id=i.orgid and i.isselfschedule=1 and t.departstationid = o.stationid");
		if (!"".equals(orderno) && orderno != null) {
			sql.append(" and tso.orderno like '%" + orderno + "%'");
		}
	
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		if (routeid > 0) {
			sql.append(" and r.id="+routeid);
		}
			
//		if (scheduleid > 0) {
//			sql.append(" and s.id="+scheduleid);
//		} 
		if (schedulecode!=null && !"".equals(schedulecode)) {
		sql.append(" and s.code like '%"+ schedulecode+"%' ");
		}
//		else {
			sql.append(" union ")
					.append(" select trim(og.name) sellorg ,trim(o.name), ti.name ticketname, t.ticketno, t.departdate, '' routename, t.schedulecode code, ")
					.append(" st.name endname, trim(t.departtime) departtime, i.insuranceno, c.name customername, ")
					.append(" c.mobilephone, c.certificateno, ise.name insurername, it.name typename, ")
					.append(" i.premium, i.insureamount, i.insurancestatus, ")
					.append(" u.name sellname, i.selltime, i.paymethod, i.sellway, i.sellip, i.polnumber, ")
					.append(" i.createtime insuranceprintdatetime, ")
					.append(" it.ywmoney ywmoney, ")
					.append(" it.shmoney shmoney, ")
					.append(" it.emoney emoney, ")
					.append(" it.emmoney emmoney, ")
					.append(" '0' reprintnum, ")
					.append(" ti.address outletsaddress, ")
					.append(" case i.insurancestatus when '1' then (select ufo1.code from insurancereturn ir,userinfo ufo1 where ufo1.id=ir.returnby and ir.insuranceid=i.id)  ")
					.append(" when '2' then (select ufo2.code from insurancecancel ic,userinfo ufo2 where ufo2.id=ic.cancelby and ic.insuranceid=i.id) ")
					.append(" else '' end returnorcancelby, ")
					.append(" case i.insurancestatus when '1' then (select to_char(returntime,'yyyy-mm-dd hh24:mi:ss') from insurancereturn ir where ir.insuranceid=i.id) ")
					.append(" when '2' then (select to_char(canceltime,'yyyy-mm-dd hh24:mi:ss') from insurancecancel ic where ic.insuranceid=i.id) ")
					.append(" else '' end returnorcanceltime, ")
					.append(" ise.bankcode insurersbankcode, ")
					.append(" stst.name startname, ")
					.append(" it.code insuretypecode, ")
					.append(" t.islinework islinework, ")
					.append(" t.seatno seatno, ")
					.append(" i.sellby sellby, ")
					.append(" (select org.code from organization org where org.id=ti.orgid ) orgcode, ")
					.append(" c.certificatetype certificatetype, ")
					.append(" case when i.insurancestatus='0' then 1 else null end as isreturninsure,null ischecked,null isdepartinvoices,i.id insuranceid,")
					.append("  '' orderno,t.ticketstatus ticketstatus,'0' returnfeemode, null as isdeparted,i.orderno as iorderno")
					.append(" from insurance i ")
					.append(" left join ticketsellagent t on i.sellid=t.id ")
					.append(" left join ticketoutlets ti on t.ticketoutletsid=ti.id ")
					.append(" left join station st on t.reachstationid=st.id ")
					.append(" left join station stst on t.departstationid=stst.id ")
					.append(" left join customer c on i.customerid=c.id ")
					.append(" left join insurers ise on i.insurersid=ise.id ")
					.append(" left join insuretype it on i.insuretypeid=it.id ")
					.append(" left join userinfo u on i.sellby=u.id,organization o,organization og")
					.append(" where og.id=i.orgid and i.isselfschedule=0 and t.departstationid = o.stationid");
			if (schedulecode!=null && !"".equals(schedulecode)) {
				sql.append(" and t.schedulecode like '%"+ schedulecode+"%' ");
				}
			sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
//		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}
	
	public List<Object> summaryQuery(List<PropertyFilter> propertyFilters) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select o.name cancelorgid, ")
		   .append(" t.ticketno, ")
		   .append(" i.insuranceno, ")
		   .append(" t.departdate, ")
		   .append(" trim(t.departtime) departtime, ")
		   .append(" r.name routename, ")
		   .append(" s.code  code, ")
		   .append(" it.name typename, ")
		   .append(" i.premium premium, ")
		   .append(" ise.name insurername, ")
		   .append(" u.name sellname, ")
		   .append(" ui.name cancelname, ")
		   .append(" k.canceltime canceltime, ")
		   .append(" k.cancelip cancelip ")
		   .append(" from insurance i ")
		   .append(" left join insurancecancel k on k.insuranceid=i.id ")
		   .append(" left join userinfo u on i.sellby=u.id ")
		   .append(" left join organization o on o.id=u.orgid ")
		   .append(" left join ticketsell t on i.sellid = t.id ")
		   .append(" left join schedule s on t.scheduleid=s.id ")
		   .append(" left join route r on s.routeid=r.id ")
		   .append(" left join insuretype it on i.insuretypeid=it.id ")
		   .append(" left join insurers ise on i.insurersid = ise.id ")
		   .append(" left join userinfo ui on ui.id=k.cancelby  ")
		   .append(" where i.insurancestatus=2  ")
		   .append(PropertyFilter.toJpql(propertyFilters, true))
		   .append(" order by departdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	/**
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryInsurancedetail(
			List<PropertyFilter> buildFromHttpRequest) {
		// StringBuffer sql = new StringBuffer(" select o.name sellorg, ");
		// sql.append(" og.name htsellorg, ")
		// .append(" irs.name irsname, ")
		// .append(" count(i.id) sellisnum, ")
		// .append(" nvl(sum(i.premium),0) sellismount, ")
		// .append(" count(ir.insuranceid) returnisnum, ")
		// .append(" nvl(sum(ir.premium),0) returnismount, ")
		// .append(" count(ic.insuranceid) cancelisnum, ")
		// .append(" nvl(sum(ic.premium),0) cancelimount, ")
		// .append(" nvl(nvl(sum(i.premium),0) - nvl(sum(ir.premium),0) -
		// nvl(sum(ic.premium),0),0) subtotal, ")
		// .append(" nvl(ity.dividedrate,0)* ( nvl(nvl(sum(i.premium),0) -
		// nvl(sum(ir.premium),0) - nvl(sum(ic.premium),0),0)) stationget ")
		// .append(" from insurance i ").append(" left join insuretype ity on
		// ity.id = i.insuretypeid ")
		// .append(" left join insurancereturn ir on ir.insuranceid = i.id ")
		// .append(" left join insurancecancel ic on ic.insuranceid = i.id,
		// ticketsell t, ")
		// .append(" organization o, organization og, station s, ")
		// .append(" insurers irs ")
		// .append(" where t.id = i.sellid ")
		// .append(" and o.id = i.orgid ")
		// .append(" and t.departstationid = s.id ")
		// .append(" and s.id = og.stationid ")
		// .append(" and irs.id = i.insurersid ")
		// .append(PropertyFilter.toJpql(buildFromHttpRequest, true))
		// .append(" group by o.name, og.name, irs.name,ity.dividedrate");

		List<PropertyFilter> fsqlreturn = new ArrayList<PropertyFilter>();
		fsqlreturn.addAll(buildFromHttpRequest);
		List<PropertyFilter> fsqlcancle = new ArrayList<PropertyFilter>();
		fsqlcancle.addAll(buildFromHttpRequest);
		PropertyFilter propertyFilter_returntime1 = null;
		PropertyFilter propertyFilter_returntime2 = null;
		PropertyFilter propertyFilter_canceltime1 = null;
		PropertyFilter propertyFilter_canceltime2 = null;
		Iterator<PropertyFilter> itsoreturn = fsqlreturn.iterator();
		while (itsoreturn.hasNext()) {
			PropertyFilter pf = itsoreturn.next();
			if (pf.getPropertyFullName().equals("i!selltime") && pf.getMatchType().toString().equals(">=")) {
				propertyFilter_returntime1 = new PropertyFilter("GED_ir!returntime", pf.getMatchValue());
				itsoreturn.remove();
			}
			if (pf.getPropertyFullName().equals("i!selltime") && pf.getMatchType().toString().equals("<=")) {
				propertyFilter_returntime2 = new PropertyFilter("LED_ir!returntime", pf.getMatchValue());
				itsoreturn.remove();
			}
		}
		if (propertyFilter_returntime1 != null && propertyFilter_returntime2 != null) {
			fsqlreturn.add(propertyFilter_returntime1);
			fsqlreturn.add(propertyFilter_returntime2);
		}
		Iterator<PropertyFilter> itsocancle = fsqlcancle.iterator();
		while (itsocancle.hasNext()) {
			PropertyFilter pf = itsocancle.next();
			if (pf.getPropertyFullName().equals("i!selltime") && pf.getMatchType().toString().equals(">=")) {
				propertyFilter_canceltime1 = new PropertyFilter("GED_ic.canceltime", pf.getMatchValue());
				itsocancle.remove();
			}
			if (pf.getPropertyFullName().equals("i!selltime") && pf.getMatchType().toString().equals("<=")) {
				propertyFilter_canceltime2 = new PropertyFilter("LED_ic.canceltime", pf.getMatchValue());
				itsocancle.remove();
			}
		}
		if (propertyFilter_canceltime1 != null && propertyFilter_canceltime2 != null) {
			fsqlcancle.add(propertyFilter_canceltime1);
			fsqlcancle.add(propertyFilter_canceltime2);
		}
		String sqlsale = PropertyFilter.toJpql(buildFromHttpRequest, true);
		String sqlreturn = PropertyFilter.toJpql(fsqlreturn, true);
		String sqlcancle = PropertyFilter.toJpql(fsqlcancle, true);
		StringBuffer sql = new StringBuffer();
		sql.append(" select sellorg,  htsellorg, irsname,  sum(sellisnum),  sum(sellismount),sum(returnisnum), ")
				.append(" sum(returnismount),  sum(cancelisnum),  sum(cancelimount), sum(subtotal),  sum(stationget) from (")
				.append(" select o.name sellorg,  og.name htsellorg,  irs.name irsname,  count(i.id) sellisnum,")
				.append(" nvl(sum(i.premium), 0) sellismount,  0 returnisnum, 0 returnismount,  0 cancelisnum,")
				.append(" 0 cancelimount, nvl(sum(i.premium), 0) subtotal,  nvl(ity.dividedrate, 0) * nvl(sum(i.premium), 0) stationget")
				.append(" from insurance i  left join insuretype ity on ity.id = i.insuretypeid, ticketsell t,")
				.append(" organization o, organization og, station s, insurers irs")
				.append(" where t.id = i.sellid and o.id = i.orgid  and t.departstationid = s.id  and s.id = og.stationid  and irs.id = i.insurersid")
				.append(sqlsale).append(" group by o.name, og.name, irs.name, ity.dividedrate")
				.append(" union all  select o.name sellorg,  og.name htsellorg, irs.name irsname,  0 sellisnum,")
				.append(" 0 sellismount,  count(ir.insuranceid) returnisnum,  nvl(sum(ir.premium), 0) returnismount,  0 cancelisnum,")
				.append(" 0 cancelimount,  -nvl(sum(ir.premium), 0) subtotal,  nvl(ity.dividedrate, 0) * -nvl(sum(ir.premium), 0) stationget")
				.append(" from insurance i left join insuretype ity on ity.id = i.insuretypeid")
				.append(" left join insurancereturn ir on ir.insuranceid = i.id, ticketsell t,")
				.append(" organization o, organization og, station s, insurers irs")
				.append(" where t.id = i.sellid  and o.id = i.orgid and t.departstationid = s.id and s.id = og.stationid and irs.id = i.insurersid")
				.append(sqlreturn).append(" group by o.name, og.name, irs.name, ity.dividedrate")
				.append("   union all  select o.name sellorg, og.name htsellorg,  irs.name irsname,  0 sellisnum,  0 sellismount,")
				.append("  0 returnisnum,  0 returnismount,  count(ic.insuranceid) cancelisnum,  nvl(sum(ic.premium), 0) cancelimount,")
				.append("  -nvl(sum(ic.premium), 0) subtotal,  nvl(ity.dividedrate, 0) * -nvl(sum(ic.premium), 0) stationget")
				.append("  from insurance i left join insuretype ity on ity.id = i.insuretypeid")
				.append(" left join insurancecancel ic on ic.insuranceid = i.id, ticketsell t,")
				.append("  organization o, organization og,station s, insurers irs")
				.append("   where t.id = i.sellid and o.id = i.orgid  and t.departstationid = s.id and s.id = og.stationid ")
				.append("  and irs.id = i.insurersid").append(sqlcancle)
				.append(" group by o.name, og.name, irs.name, ity.dividedrate)")
				.append("  group by sellorg, htsellorg, irsname");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		JPAPropertyFilterUtil.setParameter(query, fsqlreturn);
		JPAPropertyFilterUtil.setParameter(query, fsqlcancle);
		return query.getResultList();
	}

	/**
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> insuranceReport(
			List<PropertyFilter> buildFromHttpRequest, long routeid,long returnOrcanceluserid,Date begindate,Date enddate,
			String orgids,Date departbegindate,Date departenddate, String paymethod) {
		StringBuffer sql = new StringBuffer("select sellby,code,sum(sellnum) sellnum,sum(totalpremium),")
		.append(" sum(returnnum) returnnum,sum(returnpremium) returnpremium,sum(cancelnum) cancelnum,sum(cancelpremium) cancelpremium,")
		.append(" sum(sellnum)-sum(returnnum)-sum(cancelnum)  ticketnum,sum(totalpremium)-sum(returnpremium)-sum(cancelpremium) premium,")
		.append(" min(mininsuranceno) mininsuranceno,max(maxinsuranceno) maxinsuranceno , ")
		.append(" sum(cashnum) cashnum,sum(nocashnum) nocashnum,")
		.append(" sum(cashprice)-sum(returnpremium)-sum(cancelpremium) cashprice,sum(nocashprice) nocashprice")
		.append(" from (select u.name sellby,u.code,count(*) sellnum,")
		.append(" sum(i.premium) totalpremium,0 returnnum,")
		.append(" 0 returnpremium,")
		.append(" 0 cancelnum,0 cancelpremium,")
		.append(" 0 ticketnum,")
		.append(" 0 premium,")
		.append("  min(i.insuranceno) mininsuranceno, max(i.insuranceno) maxinsuranceno, ")
		.append("  sum(decode(i.paymethod,'0',1,0)) cashnum,sum(decode(i.paymethod,'0',0,1)) nocashnum,")
		.append("  sum(decode(i.paymethod,'0',i.premium,0)) cashprice,sum(decode(i.paymethod,'0',0,i.premium)) nocashprice ")
		.append(" from insurance i, ticketsell t, schedule s, organization o, userinfo u ")
		.append(" where i.orgid=o.id and i.sellby=u.id and i.sellid=t.id and i.isselfschedule=1 and t.scheduleid=s.id ")
		.append(departbegindate==null?"": " and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
		.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ");  //增加支付方式查询条件
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		if (routeid > 0) {
			sql.append(" and s.routeid="+routeid);
			sql.append(" group by o.name,u.name , u.code ");
			sql.append(" union all ");
			sql.append("select u.name sellby,u.code,0 sellnum,")
			.append(" 0 totalpremium,count(i.id) returnnum,")
			.append(" sum(ir.premium) returnpremium,")
			.append(" 0 cancelnum,0 cancelpremium,")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno,max(i.insuranceno) maxinsuranceno ,")
			.append(" 0 cashnum,0 nocashnum,0 cashprice,0 nocashprice")
			.append(" from insurance i,insurancereturn ir, ticketsell t, schedule s, organization o, userinfo u ")
			.append(" where i.orgid=o.id and ir.returnby=u.id and i.sellid=t.id and i.isselfschedule=1 and t.scheduleid=s.id and ir.insuranceid = i.id ")
			.append(" and ir.returntime>=:beginreturntime and ir.returntime<=:endreturntime ")
			.append(departbegindate==null?"": " and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ")  //增加支付方式查询条件
			.append(" and i.orgid in ").append(orgids);
			if(returnOrcanceluserid>0){
				sql.append(" and ir.returnby=:returnby ");
			}
			sql.append(" and s.routeid="+routeid);
			sql.append(" group by o.name,u.name , u.code ");
			
			sql.append(" union all select u.name sellby,u.code,0 sellnum,")
			.append(" 0 totalpremium,0 returnnum,")
			.append(" 0 returnpremium,")
			.append(" count(i.id) cancelnum,sum(ic.premium) cancelpremium,")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno,max(i.insuranceno) maxinsuranceno, ")
			.append(" 0 cashnum,0 nocashnum,0 cashprice,0 nocashprice")
			.append(" from insurance i,insurancecancel ic,ticketsell t, schedule s, organization o, userinfo u ")
			.append(" where i.orgid=o.id and ic.cancelby=u.id and i.sellid=t.id and i.isselfschedule=1 and t.scheduleid=s.id and ic.insuranceid = i.id")
			.append(" and ic.canceltime>=:beginreturntime and ic.canceltime<=:endreturntime ")
			.append(departbegindate==null?"":" and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ")  //增加支付方式查询条件
			.append(" and i.orgid in ").append(orgids);
			if(returnOrcanceluserid>0){
				sql.append(" and ic.cancelby=:returnby ");
			}
			sql.append(" and s.routeid="+routeid);
			sql.append(" group by o.name,u.name , u.code) ");
			sql.append(" group by sellby,code ");
			
		} else {
			sql.append(" group by o.name,u.name , u.code ");
			sql.append(" union all ");
			sql.append(" select u.name sellby,u.code,0 sellnum,")
			.append(" 0 totalpremium,count(i.id) returnnum,")
			.append(" sum(ir.premium) returnpremium,")
			.append(" 0 cancelnum,0 cancelpremium,")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno,max(i.insuranceno) maxinsuranceno, ")
			.append("  0 cashnum,0 nocashnum,")
			.append("  0 cashprice,0 nocashprice ")			
			.append(" from insurance i,insurancereturn ir, ticketsell t, schedule s, organization o, userinfo u ")
			.append(" where i.orgid=o.id and ir.returnby=u.id and i.sellid=t.id and i.isselfschedule=1 and t.scheduleid=s.id and ir.insuranceid = i.id ")
			.append(" and ir.returntime>=:beginreturntime and ir.returntime<=:endreturntime ")
			.append(departbegindate==null?"":" and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ")  //增加支付方式查询条件
			.append(" and i.orgid in ").append(orgids);
			if(returnOrcanceluserid>0){
				sql.append(" and ir.returnby=:returnby ");
			}
			sql.append(" group by o.name,u.name , u.code ");
						
			sql.append(" union all select u.name sellby,u.code,0 sellnum,")
			.append(" 0 totalpremium,0 returnnum,")
			.append(" 0 returnpremium,")
			.append(" count(i.id) cancelnum,sum(ic.premium) cancelpremium,")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno,max(i.insuranceno) maxinsuranceno, ")
			.append("  0 cashnum,0 nocashnum,")
			.append("  0 cashprice,0 nocashprice ")			
			.append(" from insurance i,insurancecancel ic,ticketsell t, schedule s, organization o, userinfo u ")
			.append(" where i.orgid=o.id and ic.cancelby=u.id and i.sellid=t.id and i.isselfschedule=1 and t.scheduleid=s.id and ic.insuranceid = i.id ")
			.append(" and ic.canceltime>=:beginreturntime and ic.canceltime<=:endreturntime ")
			.append(departbegindate==null?"":" and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ")  //增加支付方式查询条件
			.append(" and i.orgid in ").append(orgids);
			if(returnOrcanceluserid>0){
				sql.append(" and ic.cancelby=:returnby ");
			}
			sql.append(" group by o.name,u.name , u.code ");
						
			sql.append(" union all ");
			
			sql.append(" select u.name sellby,u.code,count(*) sellnum, ")
			.append(" sum(i.premium) totalpremium,0 returnnum,")
			.append(" 0 returnpremium,")
			.append(" 0 cancelnum,0 cancelpremium, ")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno, max(i.insuranceno) maxinsuranceno, ")
			.append(" 0 cashnum,0 nocashnum,0 cashprice,0 nocashprice")
			.append(" from insurance i, ticketsellagent t, organization o, userinfo u ")
			.append(" where i.orgid=o.id and i.sellby=u.id and i.sellid=t.id and i.isselfschedule=0 ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ");  //增加支付方式查询条件
			sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
			sql.append(" group by o.name,u.name, u.code ");
			sql.append(" union all select u.name sellby,u.code,0 sellnum, ")
			.append(" 0 totalpremium,count(i.id) returnnum,")
			.append(" sum(ir.premium) returnpremium,")
			.append(" 0 cancelnum,0 cancelpremium, ")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno, max(i.insuranceno) maxinsuranceno, ")
			.append(" 0 cashnum,0 nocashnum,0 cashprice,0 nocashprice")
			.append(" from insurance i,insurancereturn ir, ticketsellagent t, organization o, userinfo u ")
			.append(" where i.orgid=o.id and ir.returnby=u.id and i.sellid=t.id and i.id = ir.insuranceid and i.isselfschedule=0 ")
			.append(" and ir.returntime>=:beginreturntime and ir.returntime<=:endreturntime ")
			.append(departbegindate==null?"":" and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ")  //增加支付方式查询条件
			.append(" and i.orgid in ").append(orgids);
			if(returnOrcanceluserid>0){
				sql.append(" and ir.returnby=:returnby ");
			}
			sql.append(" group by o.name,u.name, u.code ");
			sql.append(" union all select u.name sellby,u.code,0 sellnum, ")
			.append(" 0 totalpremium,0 returnnum,")
			.append(" 0 returnpremium,")
			.append(" count(i.id) cancelnum,sum(ic.premium) cancelpremium, ")
			.append(" 0 ticketnum,")
			.append(" 0 premium,")
			.append("  min(i.insuranceno) mininsuranceno, max(i.insuranceno) maxinsuranceno ,")
			.append(" 0 cashnum,0 nocashnum,0 cashprice,0 nocashprice")
			.append(" from insurance i,insurancecancel ic,ticketsellagent t, organization o, userinfo u ")
			.append(" where i.orgid=o.id and ic.cancelby=u.id and i.sellid=t.id and i.id = ic.insuranceid and i.isselfschedule=0 ")
			.append(" and ic.canceltime>=:beginreturntime and ic.canceltime<=:endreturntime ")
			.append(departbegindate==null?"":" and t.departdate >= :departbegindate and t.departdate <= :departenddate ")
			.append("".equals(paymethod) ? "" : " and i.paymethod =:paymethod ")  //增加支付方式查询条件
			.append(" and i.orgid in ").append(orgids);
			if(returnOrcanceluserid>0){
				sql.append(" and ic.cancelby=:returnby ");
			}
			sql.append(" group by o.name,u.name, u.code) ");
			sql.append(" group by sellby,code ");
		}
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		query.setParameter("beginreturntime", begindate);
		query.setParameter("endreturntime", enddate);
		if(departbegindate!=null){
			query.setParameter("departbegindate", departbegindate);
			query.setParameter("departenddate", departenddate);
		}
		if(returnOrcanceluserid>0){
			query.setParameter("returnby", returnOrcanceluserid);
		}
		if (!"".equals(paymethod)) {
			query.setParameter("paymethod", paymethod);
		}
		
		return query.getResultList();
	}
	
}
