package cn.nova.bus.bill.dao;

import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author 蒋伟
 * 
 */

public class BillinuseDao extends EntityManagerDaoSurport<Billinuse> {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select b ,b.endno-b.nextno+1 as availablecount ,");
		sql.append(" b.endno-b.startno+1 as count ,bs.name as storagename, bt.name as billtypename, ");
		sql.append(" bt.parvalue as parvalue ,u.name as recipientsname,u.code as recipientscode,dic.value as dicvalue,b.status ");
		sql.append(" from Billinuse b ,Billinventory b1 ,Billtype bt,Billstorage bs,Userinfo u, ");
		sql.append(" Digitaldictionarydetail dic,Digitaldictionary dig  ");
		sql.append(" where b.billinventoryid=b1.id and bs.id=b1.storageid and b.billtypeid=bt.id  and u.id=b.recipients ");
		sql.append(" and dig.columnname='status' and dig.tablename='billinuse' and dic.digitaldictionary.id=dig.id and ");
		sql.append(" dic.code=b.status");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public Billinuse getBilluse(long billtypeid, long recipients,
			long billno) {
		StringBuilder sql = new StringBuilder(
				"select b from Billinuse b where b.billtypeid=:billtypeid")
				.append(" and b.recipients =:recipients and b.status=1 ")
				.append(" and b.startno<=:billno and b.endno>=:billno")
				.append(" and b.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("billtypeid", billtypeid);
		query.setParameter("recipients", recipients);
		query.setParameter("billno", billno);
		List<Object> list = query.getResultList();
		return (Billinuse) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	@SuppressWarnings("unchecked")
	public Billinuse getBilluseBy(String code, long recipients,
			String billno) {		
		StringBuilder sql = new StringBuilder(
				"select b.id,b.billinventoryid,b.orgid,b.billtypeid,b.startno,b.nextno,b.endno,  ")
				.append(" b.status,b.recipients,b.isactive,b.createtime,b.createby,b.updatetime,b.updateby")
				.append(" from Billinuse b left join Billtype bt on b.billtypeid=bt.id")
				.append(" where 1=1 and b.recipients =:recipients and bt.code=:code ")
				.append(" and b.startno<=:billno and b.endno>=:billno")
				.append(" and b.isactive=1").append(" order by b.updatetime desc");
		Query query = em.createNativeQuery(sql.toString(),Billinuse.class);		
		query.setParameter("recipients", recipients);
		query.setParameter("code", code);
		query.setParameter("billno", Long.valueOf(billno));
		List<Billinuse> list = query.getResultList();
		return (Billinuse) (list != null && list.size() > 0 ? list.get(0)
				: null);
	} 
}
