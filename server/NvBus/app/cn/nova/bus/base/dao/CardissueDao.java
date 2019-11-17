/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.dao<br/>
 * <b>文件名：</b>CardissueDao.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class CardissueDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select c.issueby, c.id, c.serialnumber, c.cardno, c.type, c.typeid, c.validdate, ");
		sql.append(
				" c.issuetime, c.issueip, c.status, c.createtime, c.updatetime, c.billtypeid, ")
				.append(" c.issueorgid, c.ticketoutletsid, u.name as createname, ts.name as outletsname, b.name as billname, ")
				.append(" ue.name as issuename, org.name as issueorgname, usi.name as updatename, ")
				.append(" case c.type when '0' then (select v.vehicleno from Vehicle v where c.typeid=v.id) ")
				.append(" when '1' then (select d.name from Driver d where c.typeid=d.id)")
				.append(" when '2' then (select s.name from Steward s where c.typeid=s.id)")
				.append(" when '3' then cu.name ")
				.append(" when '4' then (select u.name from Userinfo u where c.typeid=u.id)")
				.append(" when '5' then (select u.name from Unit u where c.typeid=u.id) end as typename, ")
				.append(" c.createby, c.updateby, ")
				.append(" cu.certificateno,cu.mobilephone,nvl(v.money,0),nvl(v.vipamount,0),nvl(v.id,0) vipid, ")
				.append(" nvl(v.cardcost,0),nvl(v.customerid,0),nvl(v.vipgrade,'-1') grade ")
		.append(" from Cardissue c left join Vip v on c.type=3 and c.typeid=v.id left join Customer cu on v.customerid=cu.id")
		.append("      , Userinfo u, Ticketoutlets ts, Billtype b, Userinfo ue, Organization org, Userinfo usi ")
		.append(" where c.billtypeid=b.id and c.createby = u.id and c.issueby=ue.id ");
		sql.append(" and c.issueorgid=org.id and c.updateby=usi.id and c.ticketoutletsid = ts.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Long getId(String tablename) {
		StringBuffer sql = new StringBuffer("select max(t.id) from ");
		sql.append(tablename);
		sql.append(" t");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public List getResult(Cardissue card) {
		StringBuffer sql = new StringBuffer(
				"select t from Cardissue t where t.status in (0,4) and ");
		sql.append(" t.typeid=:typeid and t.id!=:id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("typeid", card.getTypeid());
		query.setParameter("id", card.getId());
		return query.getResultList();
	}

	public String getSerialnumber(String cardno, String type) {
		StringBuffer sql = new StringBuffer(
				"select t.serialnumber from Initcard t where t.cardno='");
		sql.append(cardno).append("' and t.cardtype='").append(type)
				.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (String) query.getSingleResult();
	}

	public Long getidByCardno(String cardno, String type, String status) {
		StringBuffer sql = new StringBuffer(
				"select t.id from Cardissue t where t.cardno='");
		sql.append(cardno).append("' and t.type='").append(type)
				.append("' and t.status=").append(status);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Cardissue> query(Date date) {
		StringBuffer sql = new StringBuffer("from Cardissue t ");
		sql.append(" where t.validdate<:date and t.status='0' ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("date", date);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Cardissue> isIssue(Cardissue card) {
		StringBuffer sql = new StringBuffer("select t from Cardissue t ");
		sql.append(" where t.cardno=:cardno and t.typeid!=:typeid and t.type!=:type");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cardno", card.getCardno());
		query.setParameter("typeid", card.getTypeid());
		query.setParameter("type", card.getType());
		return query.getResultList();
	}

	/**
	 * @param vipcardno
	 * @return
	 */
	public Vip getVipBycardno(String vipcardno) {
		StringBuffer sql = new StringBuffer("select v from Vip v ");
		sql.append(" where v.vipcardno=:vipcardno ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vipcardno", vipcardno);
		return (Vip) (query.getResultList().size() > 0 ? query
				.getSingleResult() : null);
	}

	public boolean isExistSerialnumber(String serialnumber) {
		StringBuffer sql = new StringBuffer("select c from Cardissue c ");
		sql.append(" where c.serialnumber=:serialnumber ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("serialnumber", serialnumber);
		return query.getResultList().size() > 0 ? true : false;
	}

	/**
	 * @param customerid
	 * @return
	 */
	public boolean isExistCustomer(long customerid, String status) {
		StringBuffer sql = new StringBuffer("select v from Vip v ");
		sql.append(" where v.customerid=:customerid and v.status in "+status);
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("customerid", customerid);
		return query.getResultList().size() > 0 ? true : false;
	}
}
