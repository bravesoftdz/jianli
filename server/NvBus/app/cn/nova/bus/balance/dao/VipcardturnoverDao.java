/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.dao<br/>
 * <b>文件名：</b>VipcardturnoverDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-12-6 下午02:48:06<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipcardturnoverDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-12-6 下午02:48:06<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VipcardturnoverDao extends EntityManagerDaoSurport {

	/**
	 * 已缴款查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select u.name sellname,us.name createname,use.name updatename,");
		sql.append(" v.id,v.turnoverdate, v.money, v.lastlost,v.lost, v.issuenum,v.moneypayable, ")
				.append(" v.rechargemoney,v.returnnum,v.returnmoney, v.cardcost, v.remark, ")
				.append(" v.createtime,v.updatetime,v.rechargecount,v.returncardcost ")
				.append(" from vipcardturnover v, userinfo u, userinfo us, userinfo use ")
				.append(" where v.sellerid=u.id and v.createby=us.id and v.updateby=use.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 查询应缴款的数据
	 * 
	 * @param startdate
	 * @param enddate
	 * @param sellid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTurnover(Date startdate, Date enddate, Long sellid) {
		StringBuilder sql = new StringBuilder(
				"select 0 choose,id sellid,name,moneydate,sum(issuenum) issuenum,");
		sql.append(
				" sum(issuemoney) issuemoney,sum(rechargenum) rechargenum,sum(rechargemoney) rechargemoney, ")
				.append(" sum(returnnum) returnnum,sum(returnmoney) returnmoney, sum(cardcose) cardcose ")
				.append(" from(select u.id,u.name,to_char(v.issuedate,'yyyy-mm-dd') moneydate,count(v.id) issuenum, ")
				.append(" sum(v.cardcost) issuemoney,0 rechargenum,0 rechargemoney,0 returnnum,0 returnmoney, ")
				.append(" 0 cardcose from vip v,userinfo u where v.issueby=u.id and v.isturnover=0 ")
				.append(" and v.createtime between :startdate and trunc(:enddate)+0.99999 ");
		if(sellid!=null&&sellid>0){
			sql.append(" and u.id=").append(sellid);
		}
		sql.append(" group by u.id,u.name, to_char(v.issuedate,'yyyy-mm-dd') union ")
				.append(" select u.id,u.name,to_char(v.rechargetime,'yyyy-mm-dd'),0,0,count(v.id) count, sum(v.money) money,0,0,0 ")
				.append(" from viprecharge v, userinfo u where v.rechargeby=u.id and v.isturnover=0 ")
				.append(" and v.rechargetime between :startdate and trunc(:enddate)+0.99999 ");
		if(sellid!=null&&sellid>0){
			sql.append(" and u.id=").append(sellid);
		}
		sql.append(" group by u.id,u.name,to_char(v.rechargetime,'yyyy-mm-dd') union ")
				.append(" select u.id,u.name,to_char(v.returntime,'yyyy-mm-dd'),0,0,0,0,count(v.id) count, sum(v.remainmoney) money, ")
				.append(" sum(v.cardcost) from vipcardreturn v, userinfo u where v.returnby=u.id and v.isturnover=0 ")
				.append(" and v.returntime between :startdate and trunc(:enddate)+0.99999 ");
		if(sellid!=null&&sellid>0){
			sql.append(" and u.id=").append(sellid);
		}
		sql.append(" group by u.id,u.name,to_char(v.returntime,'yyyy-mm-dd'))group by id,name,moneydate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryVipturnover(long sellerid) {
		StringBuffer sql = new StringBuffer(
				"select t from Vipcardturnover t where t.id=");
		sql.append("(select max(vc.id) from Vipcardturnover vc where vc.sellerid=");
		sql.append(sellerid);
		sql.append(")");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
}
