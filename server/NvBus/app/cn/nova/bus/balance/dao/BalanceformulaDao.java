package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;


@SuppressWarnings("rawtypes")
public class BalanceformulaDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceformulaitem() {
		StringBuilder sql = new StringBuilder(
				"select b from Balanceformulaitem b where b.isactive=1")
				.append(" order by b.shortname");
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryBalanceformula(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select b,u1.name as createname,u2.name as updatename,o.name as orgname")
				.append(" from Balanceformula b,Userinfo u1,Userinfo u2,Organization o")
				.append(" where b.createby=u1.id and b.updateby=u2.id")
				.append(" and b.isactive = 1 and b.orgid=o.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isExistbyName(Balanceformula balanceformula) {
		if (balanceformula == null) {
			return false;
		} else {
			if (balanceformula.getId() == 0) {
				StringBuilder sql = new StringBuilder(
						"select b from Balanceformula b").append(
						" where b.orgid=:orgid and b.isactive=1").append(
						" and b.formulaname=:formulaname ");
				Query query = em.createQuery(sql.toString());
				query.setParameter("formulaname",
						balanceformula.getFormulaname());
				query.setParameter("orgid", balanceformula.getOrgid());
				List<Object> list = query.getResultList();
				return list != null && list.size() > 0 ? true : false;
			} else {
				StringBuilder sql = new StringBuilder(
						"select b from Balanceformula b").append(
						" where b.orgid=:orgid and b.isactive=1").append(
						" and b.formulaname=:formulaname and b.id!=:id");
				Query query = em.createQuery(sql.toString());
				query.setParameter("formulaname",
						balanceformula.getFormulaname());
				query.setParameter("orgid", balanceformula.getOrgid());
				query.setParameter("id", balanceformula.getId());
				List<Object> list = query.getResultList();
				return list != null && list.size() > 0 ? true : false;
			}
		}
	}

	@SuppressWarnings("unchecked")
	public Balanceformula getDelBalanceformula(Balanceformula balanceformula) {
		StringBuilder sql = new StringBuilder("select b from Balanceformula b")
				.append(" where b.orgid=:orgid and b.isactive=0").append(
						" and b.formulaname=:formulaname ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("formulaname", balanceformula.getFormulaname());
		query.setParameter("orgid", balanceformula.getOrgid());
		List<Object> list = query.getResultList();
		return (Balanceformula) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	@SuppressWarnings("unchecked")
	public Balanceformula qryBalanceformula(long orgid,
			long balanceunitid,long routeid,long vehicleid,String formulatype) {
		StringBuilder sql = new StringBuilder("select b from Balanceformula b,")
		.append(" Balanceformulaapply ba, Balancededucttarget bd")
		.append(" where b.orgid=:orgid and b.isactive=1 and ba.isactive=1 and b.formulatype=:formulatype")
		.append(" and b.id = ba.balanceformulaid and ba.balancededucttargetid = bd.id")
		.append(" and ((ba.unit.id=:balanceunitid and ba.route=null and ba.vehicle=null)")
		.append(" or (ba.route.id=:routeid and ba.unit=null and ba.vehicle=null)")
		.append(" or (ba.route.id=:routeid and ba.unit.id=:balanceunitid)")
		.append(" or (ba.route.id=:routeid and ba.vehicle.id=:vehicleid)")
		.append(" or (ba.vehicle.id=:vehicleid and ba.unit=null and ba.route=null)) order by bd.prioritylevel");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("balanceunitid", balanceunitid);
		query.setParameter("routeid", routeid);
		query.setParameter("vehicleid", vehicleid);		
		query.setParameter("formulatype", formulatype);		
		List<Object> list = query.getResultList();
		if(list==null ||list.size()==0){
			sql = new StringBuilder("select b from Balanceformula b")
			.append(" where b.orgid=:orgid and b.isactive=1 and b.formulatype=:formulatype");
			query = em.createQuery(sql.toString());
			query.setParameter("orgid", orgid);	
			query.setParameter("formulatype", formulatype);		
			list = query.getResultList();			
			return (Balanceformula) (list != null && list.size() > 0 ? list.get(0)
					: null);
		}else{
			return (Balanceformula) (list != null && list.size() > 0 ? list.get(0)
				: null);
		}
	}
}
