/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.bill.dao<br/>
 * <b>文件名：</b>BillinventoryDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.bill.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author 蒋伟
 * 
 */
@SuppressWarnings("rawtypes")
public class BillinventoryDao extends EntityManagerDaoSurport<Billinventory> {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append("select (b.putinendno-b.putinstartno+1) as count, ")
		.append(" (case b.availableenno when 0 then 0 ")
		.append(" else b.availableenno-b.availablestartno+1 end) ")
		.append("  as availablecount, bt.name as typename, ")
		.append(" bt.parvalue as parvalue, bt.ticketnolength as ticketnolength, bs.name as storagename , ")
		.append(" u.name as username ,dic.value as putintypename, o.name as orgname, ")
		.append(" b.id, b.batchno, b.putinendno, b.putinstartno, b.availableenno, b.availablestartno, ")
		.append(" b.createtime, b.billtypeid, b.storageid,bt.numperbox ")
		.append(" from  Billinventory b ,Billtype bt,Billstorage bs,Userinfo u, ")
		.append(" Digitaldictionarydetail dic,Digitaldictionary dig, Organization o ")
		.append(" where b.isactive='1' and bt.id=b.billtypeid and bs.id=b.storageid and b.adder=u.id ")
		.append(" and dig.columnname='putintype' and dig.tablename='billinventory' and ")
		.append(" dic.digitaldictionaryid=dig.id and dic.code=b.putintype and b.orgid=o.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" order by b.createtime desc");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean isExist(long billtypeid, String batchno, long putinstartno,
			long putinendno) {
		StringBuffer sql = new StringBuffer("select t from Billinventory t ");
		sql.append(" where t.batchno='").append(batchno)
				.append("' and t.billtypeid ='").append(billtypeid)
				.append("' and not (t.putinendno<").append(putinstartno)
				.append(" or t.putinstartno>").append(putinendno)
				.append(" ) and t.isactive=1 ");
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}
	
	/**
	 * 不同批次号，票号不重复
	 * @param billtypeid
	 * @param putinstartno
	 * @param putinendno
	 * @return
	 */
	public boolean isExist(long billtypeid, long putinstartno,
			long putinendno) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.id from Billinventory t ")
		.append(" where 1=1 and t.billtypeid = :billtypeid ")
		.append(" and not (t.putinendno< :putinstartno or t.putinstartno> :putinendno )")
		.append(" and t.isactive =1 ")
		.append(" and not exists ( ")//不包含putinstartno至putinendno票号段 出库的数据
		.append(" select id from billlog b where 1=1 and b.billinventoryid = t.id  and b.operationtype = '1' ")
		.append(" and b.startno<= :putinstartno and b.endno>= :putinendno  ")
		.append(" ) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("billtypeid", billtypeid);
		query.setParameter("putinstartno", putinstartno);
		query.setParameter("putinendno", putinendno);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		play.Logger.info("Billinventory.isExist="+sql);
		play.Logger.info("验证不同批次号票号不重复 >> putinstartno="+putinstartno+",putinendno="+putinendno+",billtypeid="+billtypeid);
		return true;
	}
	// 
	@SuppressWarnings("unchecked")
	public Billinventory qryBillinventory(long orgid, String billtype) {
		StringBuilder sql = null;
		sql = new StringBuilder("select t")
				.append(" from Billinventory t, Billtype b")
				.append(" where t.billtypeid = b.id and b.code =:billtype")
				.append(" and t.orgid =:orgid and t.putintype ='0' and t.availablestartno>0")
				.append(" and t.availableenno >=t.availablestartno and t.isactive = 1");
		sql.append(" order by t.availableenno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("billtype", billtype);
		List<Billinventory> bi = query.getResultList();
		return bi != null && bi.size()>0 ? bi.get(0) : null;

	}

	public Long isContinuous(String batchno, long typeid, long availablestartno){
		StringBuffer sql = new StringBuffer("select t.id from Billinventory t where t.batchno=:batchno ");
		sql.append(" and t.billtypeid=:typeid and t.availablestartno=:availablestartno ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("batchno", batchno);
		query.setParameter("typeid", typeid);
		query.setParameter("availablestartno", availablestartno);
		if (query.getResultList().size() <= 0) {
			return (long)0;
		}
		return (Long) query.getSingleResult();
	}
	
}
