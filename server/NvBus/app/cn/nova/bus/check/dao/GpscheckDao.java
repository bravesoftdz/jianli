package cn.nova.bus.check.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class GpscheckDao extends EntityManagerDaoSurport{

	/**
	 * 查询已经GPS 检查过的记录
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querychecked(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name orgname,")
		.append(" ut.name unitname,")
		.append(" v.vehicleno,")
		.append(" gp.checkdate,")
		.append(" trim('合格') checkresult,")
//		.append(" dd.value resultname,")
		.append("  decode(gp.checkresult,1,'合格',0,'不合格','') resultname,")
		.append(" gp.remark,")
		.append(" gp.checkno,")
		.append(" op.name operatername,")
		.append(" c.name creatname,")
		.append(" u.name updatename,")
		.append(" gp.createtime,")
		.append(" gp.updatetime,")
		.append(" gp.vehicleid,")
		.append(" gp.orgid,gp.id")
		.append(" from GPSCHECK gp,")
		.append(" vehicle v,")
		.append(" userinfo op,")
		.append(" userinfo c,")
		.append(" unit ut,")
		.append(" userinfo u,")
		.append(" organization o,")
		.append(" digitaldictionary d,")
		.append(" digitaldictionarydetail dd")
		.append(" where gp.vehicleid = v.id")
		.append(" and gp.operater = op.id")
		.append(" and gp.createby = c.id")
		.append(" and gp.updateby = u.id")
		.append(" and gp.orgid = o.id")
		.append(" and v.isactive=1")
		.append(" and v.unitid=ut.id")
		.append(" and d.id = dd.digitaldictionaryid")
		.append(" and d.tablename = 'securitycheck'")
		.append(" and d.columnname = 'result'")
		.append(" and dd.code = gp.checkresult ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" order by gp.createtime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 查询gps未检查,但已安检合格的记录，显示在主页面上，供选择进行检查
	 * @param propertyFilterList
	 * @return
	 */	
	@SuppressWarnings("unchecked")
	public List<Object> queryunchecked(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name orgname,")
		.append(" u.name unitname,")
		.append(" v.vehicleno,")
		.append(" a.checktime,")
		.append(" dd.value checkresult,")
		.append(" '' resultname,")
		.append(" '' remark,")
		.append(" '' checkno,")
		.append(" '' operatername,")
		.append(" '' creatname,")
		.append(" '' updatename,")
		.append(" '' createtime,")
		.append(" '' updatetime,")
		.append(" a.vehicleid,")
		.append(" a.orgid,")
		.append(" a.id")
		.append(" from (select chk.id, chk.orgid, ")
		.append(" chk.vehicleid, chk.checktime, chk.result")
		.append(" from (select gp.vehicleid,")
		.append(" gp.orgid,")
		.append(" gp.id,")
		.append(" max(gp.checktime) checktime,")
		.append(" gp.result")
		.append(" from securitycheck gp,vehicle v")
		.append(" where gp.result <> 1 and gp.vehicleid =v.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" group by gp.vehicleid, gp.orgid, gp.id, gp.result) chk,")
		.append(" (select gps.vehicleid, max(gps.createtime) createtime")
		.append(" from gpscheck gps")
		.append(" group by gps.vehicleid) gpsed,")
		.append(" vehicle v")
		.append(" where chk.vehicleid = v.id")
		.append(" and chk.vehicleid = gpsed.vehicleid")
		.append(" and chk.checktime > gpsed.createtime")
		.append(" union all")
		.append(" select gp.id,")
		.append(" gp.orgid,")
		.append(" gp.vehicleid,")
		.append(" max(gp.checktime) checktime,")
		.append(" gp.result")
		.append(" from securitycheck gp, vehicle v")
		.append(" where gp.result <> 1")
		.append(" and gp.vehicleid not in (select c.vehicleid from gpscheck c)")
		.append(" and gp.vehicleid = v.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" group by gp.vehicleid, gp.orgid, gp.id, gp.result) a,")
		.append(" vehicle v,")
		.append(" unit u,")
		.append(" organization o,")
		.append(" digitaldictionary d,")
		.append(" digitaldictionarydetail dd")
		.append(" where a.vehicleid = v.id")
		.append(" and v.unitid = u.id")
		.append(" and a.orgid = o.id")
		.append(" and d.id = dd.digitaldictionaryid")
		.append(" and d.tablename = 'securitycheck'")
		.append(" and d.columnname = 'result'")
		.append(" and dd.code = a.result order by a.checktime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> querySummary(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name orgname,")
		.append(" ut.name unitname,")
		.append(" v.vehicleno,")
		.append(" sum(case when gp.checkresult=0 then 1 else 0 end) qualifiednum,")
		.append(" sum(case when gp.checkresult=1 then 1 else 0 end) unqualifiednum,")
		.append("  count(gp.id) tatolnum")
		.append(" from GPSCHECK  gp,vehicle v,organization o,unit ut")
		.append(" where gp.vehicleid = v.id and gp.orgid = o.id and v.isactive=1 ")
		.append(" and v.unitid=ut.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" group by o.name, v.vehicleno,ut.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	
	/**
	 * 
	 * @param checkby
	 * @return
	 */
	public String qryCheckno(Long checkby) {
		String sql = "select t.checkno from Gpscheck t where t.id = ";
		sql = sql + "(select max(s.id) from Gpscheck s ) ";;
//		String sql ="select max(s.checkno) from Gpscheck s ";
		Query query = em.createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return "1";
		} else {
			if(query.getSingleResult() == null){
				return "1";
			}
			String notenum = (String) query.getSingleResult();
			
			String num = notenum.substring(8,notenum.length());
			int i = Integer.parseInt(num);
			if (i>10000){
				return "1";
			}
			return ""+ ++i;
			
		}
	}

}
