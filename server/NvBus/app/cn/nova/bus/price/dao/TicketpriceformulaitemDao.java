package cn.nova.bus.price.dao;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Ticketpriceformula;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketpriceformulaitemDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select t,us1.name as username,org.name as orgname ")
				.append(" from Ticketpriceformulaitem t ,Userinfo us1,Organization org").append(
						" where t.createby=us1.id and t.isactive=1 and t.orgid=org.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.code ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	// 判断是否已经存在相同代码
	public boolean checkTicketpriceformulaitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		if (ticketpriceformulaitem.getId() >= 0) {
			StringBuilder sql = new StringBuilder(
					"select t from Ticketpriceformulaitem t ").append(
					" where t.isactive=1 and t.code=:code").append(
					" and t.orgid=:orgid and t.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("code", ticketpriceformulaitem.getCode());
			query.setParameter("orgid", ticketpriceformulaitem.getOrgid());
			query.setParameter("id", ticketpriceformulaitem.getId());
			return query.getResultList().size() > 0;
		} else {
			StringBuilder sql = new StringBuilder(
					"select t from Ticketpriceformulaitem t ").append(
					" where t.isactive=1 and t.code=:code").append(
					" and t.orgid=:orgid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("code", ticketpriceformulaitem.getCode());
			query.setParameter("orgid", ticketpriceformulaitem.getOrgid());
			return query.getResultList().size() > 0;

		}
	}

	@SuppressWarnings("unchecked")
	public boolean checkTicketpriceitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		String itemformula = ticketpriceformulaitem.getItemformula();
		Long orgid = ticketpriceformulaitem.getOrgid();
		for (char b : itemformula.toCharArray()) {
			StringBuilder sql = null;
			if (ConstDefiniens.ITEM.indexOf(b) > 0) {
				if (ticketpriceformulaitem.getId() == 0) {
					sql = new StringBuilder(
							"select t from Ticketpriceformulaitem t ").append(
							" where t.isactive=1 and t.code=:code").append(
							" and t.orgid=:orgid");
				} else {
					sql = new StringBuilder(
							"select t from Ticketpriceformulaitem t ").append(
							" where t.isactive=1 and t.code=:code").append(
							" and t.orgid=:orgid and t.id!="
									+ ticketpriceformulaitem.getId());
				}
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("code", String.valueOf(b));
				query.setParameter("orgid", orgid);
				List<Ticketpriceformulaitem> list = query.getResultList();
				if (list != null && list.size() > 0) {
					for (Ticketpriceformulaitem obj : list) {
						if (obj.getRelatetype().equals("11")) {
							return true;
						}
					}
				}
			}

		}
		return false;
	}

	// 判断是否已经注销
	@SuppressWarnings("unchecked")
	public Ticketpriceformulaitem isExistTicketpriceformulaitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", ticketpriceformulaitem.getOrgid());
		map.put("code", ticketpriceformulaitem.getCode());
		map.put("isactive", false);
		List<Ticketpriceformulaitem> aticketpriceformulaitem = find(
				Ticketpriceformulaitem.class, map);
		return aticketpriceformulaitem != null
				&& aticketpriceformulaitem.size() > 0 ? aticketpriceformulaitem
				.get(0) : null;

	}

	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemDetail(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = null;
		if (ticketpriceformulaitem.getRelatetype() == "0") {
			sql = new StringBuilder("select s from Formulaitemvehcile s ")
					.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem");
		} else if (ticketpriceformulaitem.getRelatetype() == "5") {
			sql = new StringBuilder("select s from Formulaitemroute s ")
					.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem");
		} else if (ticketpriceformulaitem.getRelatetype() == "6") {
			sql = new StringBuilder("select s from Formulaitemroutestop s ")
					.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem");
		} else {
			return false;
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		List<Object> objlist = query.getResultList();
		return objlist != null && objlist.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public Ticketpriceformulaitem queryFormulaitem(String itemname, long orgid) {
		StringBuilder sql = new StringBuilder("select t ").append(
				" from Ticketpriceformulaitem t ").append(
				" where t.name=:name and t.isactive=1 and t.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", itemname);
		query.setParameter("orgid", orgid);
		List<Ticketpriceformulaitem> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 票价区间相关
	@SuppressWarnings("unchecked")
	public Formulaitemprice queryFormulaitemprice(long itemid, BigDecimal price) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Formulaitemprice t ")
				.append(" where t.ticketpriceformulaitem.id=:itemid")
				.append(" and t.fromprice<=:price and t.endprice>=:price");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("itemid", itemid);
		query.setParameter("price", price);
		List<Formulaitemprice> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 公里区间相关
	@SuppressWarnings("unchecked")
	public Formulaitemdistance queryFormulaitemdistance(long itemid,
			long distance) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Formulaitemdistance t ")
				.append(" where t.ticketpriceformulaitem.id=:itemid")
				.append(" and t.fromdistance<=:distance and t.enddistance>=:distance");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("itemid", itemid);
		query.setParameter("distance", distance);
		List<Formulaitemdistance> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询公式扣费组成项目
	@SuppressWarnings("unchecked")
	public Balanceformulaitem queryBalanceformulaitem(String name) {
		StringBuilder sql = new StringBuilder("select t ").append(
				" from Balanceformulaitem t ").append(
				" where t.formulaitemname=:formulaitemname and t.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("formulaitemname", name);
		List<Balanceformulaitem> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 查询固定扣费组成项目
	@SuppressWarnings("unchecked")
	public Balancedeductitem queryBalancedeductitem(String name, long orgid) {
		StringBuilder sql = new StringBuilder("select t ").append(
				" from Balancedeductitem t ").append(
				" where t.name=:name and t.isactive=1 and t.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", name);
		query.setParameter("orgid", orgid);
		List<Balancedeductitem> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public boolean isExistStandardPriceItem(long ticketpriceformulaitemid) {
		StringBuilder sql = new StringBuilder(
				"select s from Standardpriceitem s where s.ticketpriceformulaitemid=:ticketpriceformulaitemid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitemid", ticketpriceformulaitemid);
		List<Balancedeductitem> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
	@SuppressWarnings("unchecked")
	public boolean isExistFormalitem(long orgid,String code) {
		StringBuilder sql = new StringBuilder(
				"select s from Ticketpriceformula s where s.formula like '%"
						+ code + "%'")
				.append(" and s.isactive=1 and s.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		List<Ticketpriceformula> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
}
