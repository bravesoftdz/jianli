package cn.nova.bus.insure.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class InsuranceturnoverdetailDao extends EntityManagerDaoSurport {

	public Insuranceturnoverdetail getInsuranceturnoverdetail(Long seller,
			long startno) {
		StringBuffer sql = new StringBuffer(
				"select t from Insuranceturnoverdetail t where t.seller=");
		sql.append(seller);
		sql.append(" and t.ticketstartno=");
		sql.append(startno);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (Insuranceturnoverdetail) query.getSingleResult();
	}

	public long getMaxId() {
		StringBuffer sql = new StringBuffer(
				"select max(t.id) from Insuranceturnoverdetail t");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public List getList(Long seller, long startno) {
		StringBuffer sql = new StringBuffer(
				"select t from Insuranceturnoverdetail t where t.seller=");
		sql.append(seller);
		sql.append(" and t.ticketstartno=");
		sql.append(startno);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("select t, u.name as sellername, us.name as createname, use.name as updatename, 1 as ischoose, ")
		.append(" t.sellnum - t.noncashnum as cashsellnum, t.sellmoney - t.noncashmoney as cashsellmoney,")
		.append(" t.returnnum - t.ereturnbacknum as cashreturnnum,t.returnmoney-t.ereturnbackmoney as cashreturnmoney,t.moneypayable - t.noncashmoneypayable  as  cashmoneypayable ")
		.append(" from Insuranceturnoverdetail t, Userinfo u, Userinfo us,")
		.append("  Userinfo use where t.seller=u.id and t.createby=us.id and t.updateby=use.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" order by t.createtime");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryCancelInsur(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select i.premium, ins.insuranceno ");
		sql.append(" from insuranceturnoverdetail t, insurancecancel i, insurance ins ");
		sql.append(" where i.turnoverdetailid=t.id and i.insuranceid=ins.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryReturnInsur(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select i.premium, ins.insuranceno ");
		sql.append(" from insuranceturnoverdetail t, insurancereturn i, insurance ins");
		sql.append(" where i.turnoverdetailid=t.id and i.insuranceid=ins.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryBillInsur(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("select cast(b.startno as varchar2(30)) startno,cast(b.endno as varchar2(30)) endno ")
				.append(" from insuranceturnoverdetail t, billdamaged b, billtype bi ")
				.append(" where b.billtypeid=bi.id and bi.code='Insure' and t.id=b.turnoverdetailid");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> getIds(Long ticketturnoverid) {
		StringBuffer sql = new StringBuffer(
				"select t.id from insuranceturnoverdetail t where t.ticketturnoverid=");
		sql.append(ticketturnoverid);
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();
	}

	public String getTicketturnoverdetailId(Long ticketturnoverid) {
		List<Object> list = getIds(ticketturnoverid);
		String ids = null;
		for (int i = 0; i < list.size(); i++) {
			ids = list.get(i).toString() + ",";
		}
		return ids;
	}

	public String queryInsureReturnno(Long ticketturnoverid) {
		String insurereturnno = "";
		String ids = getTicketturnoverdetailId(ticketturnoverid);
		if (ids != null) {
			String[] detailid = ids.split(",");
			for (int i = 0; i < detailid.length; i++) {
				StringBuffer sql = new StringBuffer("select ins.insuranceno ");
				sql.append(" from insuranceturnoverdetail t, insurancereturn i, insurance ins");
				sql.append(" where i.turnoverdetailid=t.id and i.insuranceid=ins.id and ");
				sql.append(" i.turnoverdetailid=");
				sql.append(Long.parseLong(detailid[i]));
				Query query = em.createNativeQuery(sql.toString());
				for (int j = 0; j < query.getResultList().size(); j++) {
					insurereturnno = insurereturnno
							+ query.getResultList().get(j) + ",";
				}
			}
			if (!"".equals(insurereturnno)) {
				insurereturnno = insurereturnno.substring(0,
						insurereturnno.length() - 1);
			}
		}
		return insurereturnno;
	}

	public String queryInsureCanceltno(Long ticketturnoverid) {
		String insurecancelno = "";
		String ids = getTicketturnoverdetailId(ticketturnoverid);
		if (ids != null) {
			String[] detailid = ids.split(",");
			for (int i = 0; i < detailid.length; i++) {
				StringBuffer sql = new StringBuffer("select ins.insuranceno ");
				sql.append(" from insuranceturnoverdetail t, insurancecancel i, insurance ins ");
				sql.append(" where i.turnoverdetailid=t.id and i.insuranceid=ins.id and ");
				sql.append(" t.id=");
				sql.append(Long.parseLong(detailid[i]));
				Query query = em.createNativeQuery(sql.toString());
				for (int j = 0; j < query.getResultList().size(); j++) {
					insurecancelno = insurecancelno
							+ query.getResultList().get(j) + ",";
				}
			}
			if (!"".equals(insurecancelno)) {
				insurecancelno = insurecancelno.substring(0,
						insurecancelno.length() - 1);
			}
		}
		return insurecancelno;
	}

	public String queryInsureBillno(Long ticketturnoverid) {
		String insurebillno = "";
		String ids = getTicketturnoverdetailId(ticketturnoverid);
		if (ids != null) {
			String[] detailid = ids.split(",");
			for (int i = 0; i < detailid.length; i++) {
				StringBuffer sql = new StringBuffer(
						"select b.startno || ',' || b.endno as insurebillno ");
				sql.append(" from insuranceturnoverdetail t, billdamaged b, billtype bi ");
				sql.append(" where b.billtypeid=bi.id and bi.code='Insure' and t.id=b.turnoverdetailid and ");
				sql.append(" b.turnoverdetailid=");
				sql.append(Long.parseLong(detailid[i]));
				Query query = em.createNativeQuery(sql.toString());
				for (int j = 0; j < query.getResultList().size(); j++) {
					insurebillno = insurebillno + query.getResultList().get(j)
							+ ",";
				}
			}
			if (!"".equals(insurebillno)) {
				insurebillno = insurebillno.substring(0,
						insurebillno.length() - 1);
			}
		}
		return insurebillno;
	}

	public Insuranceturnoverdetail getByTicketendno(String endno) {
		StringBuffer sql = new StringBuffer("select t from Insuranceturnoverdetail t ");
		sql.append(" where t.ticketendno=:endno ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("endno", endno);
		if (query.getResultList().size() <= 0) {
			return null;
		}
		return (Insuranceturnoverdetail) query.getSingleResult();
	}

}
