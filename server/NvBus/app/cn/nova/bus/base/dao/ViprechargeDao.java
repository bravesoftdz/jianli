/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.dao<br/>
 * <b>文件名：</b>ViprechargeDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-30 下午05:36:51<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ViprechargeDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-30 下午05:36:51<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ViprechargeDao extends EntityManagerDaoSurport {

	/**
	 * VIP充值明细
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryViprecharge(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select r.name activityname, ");
		sql.append(
				" v.vipcardno,v.money vipmoney, v.vipamount,vr.money, u.name rechargename,us.name createname,")
				.append(" use.name updatename, vr.isturnover,vr.rechargetime, vr.createtime, vr.updatetime ")
				.append(" from Viprecharge vr left join Rechargepromotionactivity r on vr.rechargepromotionactivityid=r.id, ")
				.append(" Vip v, Userinfo u, Userinfo us, Userinfo use ")
				.append(" where vr.vipid=v.id and vr.rechargeby=u.id and vr.createby=us.id and vr.updateby=use.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * VIP消费明细
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipconsumeldetail(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select c.name customername, ");
		sql.append(" u.name createname, vc.id, vc.vipcardno, vc.moneychange, ")
				.append(" vc.pointchange, vc.remainmoney, vc.remainpoint, vc.createtime,t.ticketno,t.departdate, ")
				.append(" trim(t.departtime) departtime,t.selltime, s.code, st.name startname, ")
				.append(" sn.name endname, t.paymethod, t.sellway, t.ticketstatus, v.money, v.vipamount, ")
				.append(" use.name sellname, vc.type, vc.vipgrade, t.price ")
				.append(" from vipconsume vc,vip v, customer c, userinfo u,vipconsumeldetail cd, ")
				.append(" ticketsell t, schedule s, station st, station sn, userinfo use ")
				.append(" where vc.vipid=v.id and v.customerid=c.id and vc.createby=u.id and cd.vipconsumeid=vc.id ")
				.append(" and cd.sellid=t.id and t.scheduleid=s.id and t.departstationid=st.id  ")
				.append(" and t.reachstationid=sn.id and t.sellby=use.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryVipconsume(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select c.name customername, ");
		sql.append(" u.name createname, vc.id, vc.vipcardno, vc.moneychange, ")
				.append(" vc.pointchange, vc.remainmoney, vc.remainpoint, vc.createtime, v.money, ")
				.append(" v.vipamount, vc.type, vc.vipgrade ")
				.append(" from vipconsume vc, vip v, customer c, userinfo u ")
				.append(" where vc.vipid=v.id and v.customerid=c.id and vc.createby=u.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by c.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * VIP购票汇总表
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipsellticket(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				" select cs.name, v.vipcardno, t.departdate, ");
		sql.append(
				" sum(case v.type when '0' then 1 else 0 end)+ sum(case v.type when '3' then 1 else 0 end) sellnum,")
				.append(" sum(case v.type when '0' then t.price else 0 end)+ sum(case v.type when '3' then t.price else 0 end) price,")
				.append(" sum(case v.type when '1' then ")
				.append("(select tr.charges from ticketreturn tr where tr.sellid=t.id) else 0 end) charges,")
				.append(" sum(case v.type when '1' then 1 else 0 end) returnnum ")
				.append(" from vipconsumeldetail vd, vipconsume v, ticketsell t, vip vp, customer cs ")
				.append(" where vd.vipconsumeid=v.id and t.id=vd.sellid ")
				.append(" and v.vipid=vp.id and vp.customerid=cs.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by v.vipcardno,cs.name, t.departdate order by cs.name, t.departdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 查询充值未缴款的记录
	 * 
	 * @param startdate
	 * @param enddate
	 * @param rechargeby
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(Date startdate, Date enddate, long rechargeby) {
		StringBuilder sql = new StringBuilder("select v from Viprecharge v ");
		sql.append(" where v.rechargetime between :startdate and :enddate ")
				.append(" and v.rechargeby=:rechargeby and v.isturnover=0 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("rechargeby", rechargeby);
		return query.getResultList();
	}

}
