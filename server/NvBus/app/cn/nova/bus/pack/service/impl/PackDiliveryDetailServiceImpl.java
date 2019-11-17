package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.db.jpa.JPA;
import cn.nova.bus.pack.dao.PackDiliveryDao;
import cn.nova.bus.pack.dao.PackDiliveryDetailDao;
import cn.nova.bus.pack.model.PackDiliveryDetail;
import cn.nova.bus.pack.service.PackDiliveryDetailService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackDiliveryDetailServiceImpl implements PackDiliveryDetailService {

	@Override
	public List<Map<String, Object>> query(String packids) {
		// TODO Auto-generated method stub
		PackDiliveryDetailDao dao = new PackDiliveryDetailDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"id","packid", "packno", "weight", "deliveryfee"}, dao.listPackDiliveryDetailByPackIds(packids), new Object[] {
				Long.class, Long.class, String.class, BigDecimal.class, BigDecimal.class});
		return result;
	}
	
	@Override
	public List<Map<String, Object>> queryByDiliveryid(List<PropertyFilter> propertyFilters) {
		PackDiliveryDetailDao dao = new PackDiliveryDetailDao();
//		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
//				"id", "packid", "packdiliveryid", "packno", "weight", "deliveryfee","consigneeaddress","consignee","consigneephone"}, dao.query(propertyFilters), new Object[] {
//				Long.class, Long.class, Long.class, String.class, BigDecimal.class, BigDecimal.class, String.class, String.class, String.class});
		
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {  
				"id", "packid", "packdiliveryid", "packno", 
				 "vehiclecode", "sendstationname", "sender", "name", 
				 "packed", "consignee", "consigneephone", "pieces", 
				 "weight", "paymethod", "shiptype", "consigneeaddress",
				 "certificateno","shipprice", "insuredamount", "insurance", 
				 "handfee", "packfee", "insurancefee", "transitfee", 
				 "deliveryfee", "pdddeliveryfee", "otherfee", "totalfee", 
				 "packprice", "unloadfee", "remak"				 
			 },	dao.query(propertyFilters), new Object[] { 
				Long.class,Long.class,Long.class,String.class,
				String.class, String.class, String.class,String.class,
				String.class, String.class, String.class,BigDecimal.class,
				BigDecimal.class, String.class, String.class,String.class, 
				String.class, BigDecimal.class,BigDecimal.class, BigDecimal.class, 
				BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class, 
				BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,String.class});
		return result;
	}

	@Override
	public PackDiliveryDetail savePackDiliveryDetail(PackDiliveryDetail pdd) {
		// TODO Auto-generated method stub
		PackDiliveryDetailDao dao = new PackDiliveryDetailDao();
		return dao.merge(pdd);
	}

	@Override
	public int updatePackDiliveryDetail(PackDiliveryDetail pdd) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delPackDiliveryDetail(String pddids) {
		// TODO Auto-generated method stub
		PackDiliveryDetailDao dao = new PackDiliveryDetailDao();
//		dao.delete(PackDiliveryDetail.class, pdd.getId());
		return dao.delPackDiliveryDetail(pddids);
	}

	@Override
	public List<PackDiliveryDetail> list(Long packdiliveryid) {
		// TODO Auto-generated method stub
		String sql = "select pdd from PackDiliveryDetail pdd where pdd.packdiliveryid="+packdiliveryid;
		Query query = JPA.em().createQuery(sql, PackDiliveryDetail.class);
		return query.getResultList();
	}

	
}
