/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.archive.dao<br/>
 * <b>文件名：</b>VipDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-20 下午04:31:30 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.archive.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-20 下午04:31:30	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VipDao extends EntityManagerDaoSurport {

	/**
	 * @param customerid
	 * @return
	 */
	public Vip getByCustomerid(Long customerid, String status) {
		StringBuffer sql = new StringBuffer("select v from Vip v ");
		sql.append(" where v.status=:status and v.customerid=:customerid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("customerid", customerid);
		query.setParameter("status", status);
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (Vip) query.getSingleResult();
	}

	/**
	 * 查询发卡未缴款的记录
	 * @param startdate
	 * @param enddate
	 * @param issueby
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(Date startdate, Date enddate, long issueby) {
		StringBuilder sql = new StringBuilder("select v from Vip v ");
		sql.append(" where v.issuedate between :startdate and :enddate ")
		.append(" and v.issueby=:issueby and v.isturnover=0");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("issueby", issueby);
		return query.getResultList();
	}
	
	/**
	 * 查询退卡未缴款的记录
	 * @param startdate
	 * @param enddate
	 * @param returnby
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipcardreturn(Date startdate, Date enddate, long returnby) {
		StringBuilder sql = new StringBuilder("select v from Vipcardreturn v ");
		sql.append(" where v.returntime between :startdate and :enddate ")
		.append(" and v.returnby=:returnby and v.isturnover=0");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("returnby", returnby);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryVipBycardno(List<PropertyFilter> propertyFilterList){
		StringBuilder sql = new StringBuilder("select c.name,v.id,v.vipcardno,v.vipamount, ");
		sql.append(" v.money,v.cardcost from vip v, customer c where v.customerid=c.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/*
	 * VIP补卡后明细查询
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipremainmoneytransfer(List<PropertyFilter> propertyFilterList){
		StringBuffer sql = new StringBuffer("select vr.money, vr.vipamount, ");
		sql.append(" v.vipcardno, vi.vipcardno as newcardno, u.name as createname, ")
		.append(" us.name as updatename, vr.createtime, vr.updatetime ")
		.append(" from Vipremainmoneytransfer vr, Vip v, Vip vi, Userinfo u, Userinfo us ")
		.append(" where vr.oldvipid=v.id and vr.newvipid=vi.id and vr.createby=u.id and vr.updateby=us.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
