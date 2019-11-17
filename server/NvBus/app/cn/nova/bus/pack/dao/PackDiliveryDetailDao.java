package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import play.db.jpa.JPA;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.PackDiliveryDetail;
import cn.nova.bus.system.dao.ParameterDao;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class PackDiliveryDetailDao extends EntityManagerDaoSurport<PackDiliveryDetail> {
	UserTransaction tr = new UserTransaction();
	
	public List<Object> listPackDiliveryDetailByPackIds(String packids){
		ParameterDao dao = new ParameterDao();
		String value = dao.findParamValue(ParamterConst.Param_8022, 0L);
		List<Object> objs = null;
		StringBuilder sb = new StringBuilder();
		Query query = null;
		if (packids != null && packids.trim().length() > 0) {
			sb.append("select p.id, p.id as packid, p.packno, p.weight, p.weight*"+value+" as deliveryfee from Pack p where p.id in ("+packids+")");
			query = JPA.em().createQuery(sb.toString());
			objs = query.getResultList();
		}
		return objs;
	}
	
	
//	id, packid, packdiliveryid, packno, 
//	 vehiclecode, sendstationname, sender, name, 
//	 packed, consignee, consigneephone, pieces, 
//	 weight, paymethod, shiptype, consigneeaddress,
//	 certificateno,shipprice, insuredamount, insurance, 
//	 handfee, packfee, insurancefee, transitfee, 
//	 deliveryfee, pdddeliveryfee, otherfee, totalfee, 
//	 packprice, unloadfee, remak	
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		StringBuffer sql = new StringBuffer("select ")
				.append("pdd.id,")
				.append("pdd.packid,")
				.append("pdd.packdiliveryid, p.packno,")
				.append("v.vehicleno as vehiclecode, f.name as sendstationname, p.sender, p.name," )
				.append("(select t0.packed from (select dd.code, dd.value as packed from digitaldictionary d,digitaldictionarydetail dd where d.tablename = 'pack' and d.columnname = 'packed' and dd.digitaldictionaryid = d.id) t0 where t0.code = p.packed) packed,")
				.append(" p.consignee, p.consigneephone, p.pieces,p.weight, ")
				.append("(select t1.paymethod from (select dd.code, dd.value as paymethod from digitaldictionary d,digitaldictionarydetail dd where d.tablename = 'pack' and d.columnname = 'paymethod' and dd.digitaldictionaryid = d.id) t1 where t1.code = p.paymethod) paymethod,")
				.append("(select t2.shiptype from (select dd.code, dd.value as shiptype from digitaldictionary d,digitaldictionarydetail dd where d.tablename = 'pack' and d.columnname = 'shiptype' and dd.digitaldictionaryid = d.id) t2 where t2.code = p.shiptype) shiptype,")
				.append("p.consigneeaddress,p.certificateno,p.shipprice, p.insuredamount, p.insurance, ")
				.append("p.handfee, p.packfee, p.insurancefee, p.transitfee, ")
				.append("p.deliveryfee, pdd.deliveryfee as pdddeliveryfee, p.otherfee, p.totalfee, ")
				.append("p.packprice, p.unloadfee, p.remak ")
				.append(" from PackDilivery pd, PackDiliveryDetail pdd, Pack p")
				.append(" left join Station f on f.id=p.sendstationid")
//				.append(" left join Station e on e.id=p.tostationid")
//				.append(" left join Schedule s on s.id=p.scheduleid ")
				.append(" left join Vehicle v on v.id=p.vehicleid")
				.append(" where pd.id = pdd.packdiliveryid and pdd.packid = p.id ")
				.append(PropertyFilter.toJpql(propertyFilters, true));
		
		System.out.println("sql-->"+sql.toString());
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> list = query.getResultList();
		return list;
	}

	public int delPackDiliveryDetail(String pddids){
		StringBuilder sb = new StringBuilder("delete from packdiliverydetail where id in ("+pddids+")");
		Query query = JPA.em().createNativeQuery(sb.toString());
		int i =0;
		try {
			tr.begin();
			i = query.executeUpdate();
			tr.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}	
		System.out.println("...........  i="+i);
		return i;
	}
}
