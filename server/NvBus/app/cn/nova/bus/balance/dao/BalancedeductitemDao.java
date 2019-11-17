package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balancedeductapplysell;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balancedeductitemdistance;
import cn.nova.bus.balance.model.Balancedeductitemprice;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BalancedeductitemDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public boolean isExistbyName(Balancedeductitem balancedeductitem) {
		if (balancedeductitem == null) {
			return false;
		} else {
			if (balancedeductitem.getId() == 0) {
				StringBuilder sql = new StringBuilder(
						"select b from Balancedeductitem b").append(
						" where b.orgid=:orgid and b.isactive=1").append(
						" and b.name=:name ");
				Query query = em.createQuery(sql.toString());
				query.setParameter("name", balancedeductitem.getName());
				query.setParameter("orgid", balancedeductitem.getOrgid());
				List<Object> list = query.getResultList();
				return list != null && list.size() > 0 ? true : false;
			} else {
				StringBuilder sql = new StringBuilder(
						"select b from Balancedeductitem b").append(
						" where b.orgid=:orgid and b.isactive=1").append(
						" and b.name=:name and b.id!=:id");
				Query query = em.createQuery(sql.toString());
				query.setParameter("name", balancedeductitem.getName());
				query.setParameter("orgid", balancedeductitem.getOrgid());
				query.setParameter("id", balancedeductitem.getId());
				List<Object> list = query.getResultList();
				return list != null && list.size() > 0 ? true : false;
			}
		}
	}
	@SuppressWarnings("unchecked")
	public Balancedeductitem qryBalancedeductitemByCode(long orgid,String code) {
		StringBuilder sql = new StringBuilder(
				"select b from Balancedeductitem b").append(
				" where b.orgid=:orgid and b.isactive=1").append(
				" and b.code=:code");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code",code);
		query.setParameter("orgid",orgid);
		List<Balancedeductitem> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	@SuppressWarnings("unchecked")
	public List<Object> queryBalancedeductitem(
			List<PropertyFilter> propertyFilterList, long balancedeductitemid) {
		StringBuilder sql = null;
		if (balancedeductitemid > 0) {
			sql = new StringBuilder(
					"select b,u1.name as createname,u2.name as updatename,o.name as orgname")
					.append(" from Balancedeductitem b,Userinfo u1,Userinfo u2,Organization o")
					.append(" where b.createby=u1.id and b.updateby=u2.id")
					.append(" and b.isactive = 1 and b.orgid=o.id")
					.append(" and (b.id=:id or b.parentid=:id)");
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			Query query = em.createQuery(sql.toString());
			query.setParameter("id", balancedeductitemid);
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		}
		{
			sql = new StringBuilder(
					"select b,u1.name as createname,u2.name as updatename,o.name as orgname")
					.append(" from Balancedeductitem b,Userinfo u1,Userinfo u2,Organization o")
					.append(" where b.createby=u1.id and b.updateby=u2.id")
					.append(" and b.isactive = 1 and b.orgid=o.id");
			sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			Query query = em.createQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
		}

	}

	@SuppressWarnings("unchecked")
	public List<Object> createTree(long orgid) {
		StringBuilder sql = new StringBuilder("select b").append(
				" from Balancedeductitem b").append(
				"  where b.isactive = 1 and b.orgid=:orgid ");
		sql.append(" order by b.parentid,b.name");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid",orgid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public Printtemplatetypeitem qryPrinttemplatetypeitem(long printtemplatetypeid,String code) {
		StringBuilder sql = new StringBuilder("select b").append(
				" from Printtemplatetypeitem b").append(
				"  where b.printtemplatetype.id=:printtemplatetypeid and b.itemcode=:code ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("printtemplatetypeid",printtemplatetypeid);
		query.setParameter("code",code);
		List<Object> list= query.getResultList();
		return (Printtemplatetypeitem) (list!=null && list.size()>0?list.get(0):null);
	}
	@SuppressWarnings("unchecked")
	public boolean isExistChildItem(long parentid) {
		StringBuilder sql = new StringBuilder("select b").append(
				" from Balancedeductitem b").append(
				" where b.isactive = 1 and b.parentid=:parentid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("parentid", parentid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public Balancedeductitem isExistDelName(Balancedeductitem balancedeductitem) {
		StringBuilder sql = new StringBuilder("select b")
				.append(" from Balancedeductitem b")
				.append(" where b.isactive = 0 and b.orgid=:orgid")
				.append(" and b.name=:name");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", balancedeductitem.getOrgid());
		query.setParameter("name", balancedeductitem.getName());
		List<Object> list = query.getResultList();
		return (Balancedeductitem) (list != null && list.size() > 0 ? list
				.get(0) : null);
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryDeductitemdetail(long balancedeductitemid) {
		StringBuilder sql = new StringBuilder(
				"select b.id as aboutid,'0' as abouttype, b.fromdistance as startvalue,")
				.append(" b.enddistance as endvalue,b.value as deductmoney,b.createby,b.createtime")
				.append(" from Balancedeductitemdistance b")
				.append(" where b.balancedeductitem.id =:balancedeductitemid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balancedeductitemid", balancedeductitemid);
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0) {
			return list;
		}
		sql = new StringBuilder(
				"select b.id as aboutid,'1' as abouttype,b.fromprice as startvalue,")
				.append(" b.endprice as endvalue,b.value as deductmoney,b.createby,b.createtime")
				.append(" from Balancedeductitemprice b")
				.append(" where b.balancedeductitem.id =:balancedeductitemid");
		query = em.createQuery(sql.toString());
		query.setParameter("balancedeductitemid", balancedeductitemid);
		list = query.getResultList();
		if (list != null && list.size() > 0) {
			return list;
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Balancedeductitemprice> qryBalanceDeductitemdetail(long balancedeductitemid) {
		StringBuilder sql = new StringBuilder("select b.id,b.balancedeductitemid,b.fromprice,b.endprice,b.value,b.createtime,b.createby,b.updatetime,b.updateby ")
				.append(" from Balancedeductitemprice b")
				.append(" where b.balancedeductitemid =:balancedeductitemid order by b.fromprice");
		Query query = em.createNativeQuery(sql.toString(),Balancedeductitemprice.class);
		query.setParameter("balancedeductitemid", balancedeductitemid);
		List<Balancedeductitemprice> list = query.getResultList();
		if (list != null && list.size() > 0) {
			return list;
		}
		return null;
	}

	
	@SuppressWarnings("unchecked")
	public boolean isExistAboutDistance(
			Balancedeductitemdistance balancedeductitemdistance) {
		if (balancedeductitemdistance.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Balancedeductitemdistance s ")
					.append(" where s.balancedeductitem=:balancedeductitem")
					.append(" and ((s.fromdistance>=:fromdistance and fromdistance<=:enddistance) ")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:enddistance)")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:fromdistance)")
					.append(" or (s.fromdistance>=:fromdistance and s.enddistance<=:enddistance))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("balancedeductitem",
					balancedeductitemdistance.getBalancedeductitem());
			query.setParameter("fromdistance",
					balancedeductitemdistance.getFromdistance());
			query.setParameter("enddistance",
					balancedeductitemdistance.getEnddistance());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Balancedeductitemdistance s ")
					.append(" where  s.id!=:id and s.balancedeductitem=:balancedeductitem")
					.append(" and ((s.fromdistance>=:fromdistance and s.fromdistance<=:enddistance) ")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:enddistance)")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:fromdistance)")
					.append(" or (s.fromdistance>=:fromdistance and s.enddistance<=:enddistance))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", balancedeductitemdistance.getId());
			query.setParameter("ticketpriceformulaitem",
					balancedeductitemdistance.getBalancedeductitem());
			query.setParameter("fromdistance",
					balancedeductitemdistance.getFromdistance());
			query.setParameter("enddistance",
					balancedeductitemdistance.getEnddistance());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}
	@SuppressWarnings("unchecked")
	public boolean isExistBalancedeductitemdistance(long balancedeductitemid) {
		StringBuilder sql = new StringBuilder("select b")
				.append(" from Balancedeductitemdistance b")
				.append(" where b.balancedeductitem.id =:balancedeductitemid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balancedeductitemid", balancedeductitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistBalancedeductitemprice(long balancedeductitemid) {
		StringBuilder sql = new StringBuilder("select b")
				.append(" from Balancedeductitemprice b")
				.append(" where b.balancedeductitem.id =:balancedeductitemid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balancedeductitemid", balancedeductitemid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistAboutPrice(
			Balancedeductitemprice balancedeductitemprice) {
		if (balancedeductitemprice.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Balancedeductitemprice s ")
					.append(" where s.balancedeductitem=:balancedeductitem")
					.append(" and ((s.fromprice>=:fromprice and fromprice<=:endprice) ")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:endprice)")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:fromprice)")
					.append(" or (s.fromprice>=:fromprice and s.endprice<=:endprice))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("balancedeductitem",
					balancedeductitemprice.getBalancedeductitem());
			query.setParameter("fromprice",
					balancedeductitemprice.getFromprice());
			query.setParameter("endprice",
					balancedeductitemprice.getEndprice());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Balancedeductitemprice s ")
					.append(" where  s.id!=:id and s.balancedeductitem=:balancedeductitem")
					.append(" and ((s.fromprice>=:fromprice and s.fromprice<=:endprice) ")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:endprice)")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:fromprice)")
					.append(" or (s.fromprice>=:fromprice and s.endprice<=:endprice))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", balancedeductitemprice.getId());
			query.setParameter("ticketpriceformulaitem",
					balancedeductitemprice.getBalancedeductitem());
			query.setParameter("fromprice",
					balancedeductitemprice.getFromprice());
			query.setParameter("enddistance",
					balancedeductitemprice.getEndprice());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}
	
	@SuppressWarnings("unchecked")
	public Balancedeductitem qryBalancedeductitembyName(Balancedeductitem balancedeductitem) {
				StringBuilder sql = new StringBuilder(
						"select b from Balancedeductitem b").append(
						" where b.orgid=:orgid and b.isactive=1").append(
						" and b.name=:name ");
				Query query = em.createQuery(sql.toString());
				query.setParameter("name", balancedeductitem.getName());
				query.setParameter("orgid", balancedeductitem.getOrgid());
				List<Object> list = query.getResultList();
				return (Balancedeductitem) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	
	@SuppressWarnings("unchecked")
	public boolean existBalancedeductitemApply(Balancedeductitem balancedeductitem) {
				StringBuilder sql = new StringBuilder(
						"select b from Balancedeductapply b").append(
						" where b.balancedeductitemid=:balancedeductitemid and b.isactive=1");
				Query query = em.createQuery(sql.toString());
				query.setParameter("balancedeductitemid", balancedeductitem.getId());
				List<Object> list = query.getResultList();
				return list != null && list.size() > 0 ? true: false;
	}
	
	public List<Balancedeductapplysell> qryBalancedeductapplysell(long balancedeductapplyid) {
		StringBuilder sql = new StringBuilder("select b ")
				.append(" from Balancedeductapplysell b")
				.append(" where balancedeductapplyid =:balancedeductapplyid and b.type='1'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balancedeductapplyid", balancedeductapplyid);
		return query.getResultList();
	}
}
