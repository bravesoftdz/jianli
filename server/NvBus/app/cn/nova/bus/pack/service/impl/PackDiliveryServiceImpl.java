package cn.nova.bus.pack.service.impl;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.db.jpa.JPA;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.pack.dao.PackDiliveryDao;
import cn.nova.bus.pack.model.PackDilivery;
import cn.nova.bus.pack.model.PackDiliveryDetail;
import cn.nova.bus.pack.service.PackDiliveryDetailService;
import cn.nova.bus.pack.service.PackDiliveryService;
import cn.nova.bus.pack.service.PackService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackDiliveryServiceImpl implements PackDiliveryService {
	UserTransaction tr = new UserTransaction();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		PackDiliveryDao dao = new PackDiliveryDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"id", "orgid", "orgname", "diliveno", "outboundname", "outbound", "outdate", "dilivername", "diliver",
				"dilivedate", "deliveryfee", "creator", "createtime", "updater","updatetime"}, dao.query(propertyFilters), new Object[] {
				Long.class, Long.class, String.class, String.class, String.class, Long.class, Date.class, String.class, Long.class,
				Date.class, BigDecimal.class, String.class, Timestamp.class, String.class, Timestamp.class});
		return result;

	}
	public List<Map<String, Object>> getPackDiliveryByPackId(PackDilivery pd){
		PackDiliveryDao dao = new PackDiliveryDao();
		List<Object> objs = dao.getPackDiliveryByPackId(pd);
		List<Map<String, Object>> result = null;
		result = ListUtil.listToMap(new Object[] {
				"outbound", "outboundname", "diliver", "dilivername", "diliveno", "createby", "deliveryfee", "dilivedate", "createtime", "orgid", "id"}, 
				objs, 
				new Object[] {String.class, String.class, String.class, String.class, String.class, String.class, BigDecimal.class, Timestamp.class, Timestamp.class, Long.class, Long.class
		});
		return result;
	}
	
	public PackDilivery isExist(PackDilivery pd){
		PackDiliveryDao dao = new PackDiliveryDao();
		dao.getPackDiliveryByPackId(pd);
		return null;
	}
	
	@Override
	public PackDilivery savePackDilivery(PackDilivery pd) {
		PackDiliveryDao dao = new PackDiliveryDao();
		return dao.merge(pd);
	}

	@Override
	public int updatePackDilivery(PackDilivery pd) {
		// TODO Auto-generated method stub
		PackDiliveryDao dao = new PackDiliveryDao();
		PackDilivery p0 = null;
		int i = 0;
		StringBuilder sb = new StringBuilder();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		PackDilivery p = null;
		try {
			sb.append("update packdilivery p set p.outbound="+pd.getOutbound()+",")
			   .append(" p.diliveno="+pd.getDiliveno()+",")
			  .append(" p.outdate = date'"+sf.format(pd.getOutdate())+"',")
			  .append(" p.diliver="+pd.getDiliver()+",")
			  .append(" p.dilivedate= date'"+sf.format(pd.getDilivedate())+"',")
			  .append(" p.updateby="+pd.getUpdateby()+",")
			  .append(" p.updatetime= sysdate ")
			  .append(" where p.id="+pd.getId());
			Query query = JPA.em().createNativeQuery(sb.toString());
			i = query.executeUpdate();
//			JPA.em().getTransaction().commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}		
		/*try {
			if (!JPA.em().getTransaction().isActive()) {
				JPA.em().getTransaction().begin();
			}
			p0 = dao.merge(pd);
			JPA.em().flush();
			JPA.em().getTransaction().commit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}*/
		
		return i;
	}
	@Override
	public void delPackDilivery(PackDilivery pd) {
		// TODO Auto-generated method stub
		PackService pService = new PackServiceImpl();
		PackDiliveryDetailService pddService = new PackDiliveryDetailServiceImpl();
		
		String packids = ""; // 需要修改status的所有pack记录
		String pddids = "";
		int countpack = 0;
		int countpdd = 0;
		List<PackDiliveryDetail> pddList = null;
		try {
			tr.begin();
			if (pd != null && pd.getId() > 0) {
				pddList = pddService.list(pd.getId());
				if (pddList != null && pddList.size() > 0) {
					for (PackDiliveryDetail pdd: pddList) {
						packids += pdd.getPackid()+",";
						pddids += pdd.getId()+",";
					}
					countpack = pService.updatePackStatus(packids.substring(0,packids.length()-1), "0");  // 修改所有pack记录的状态为库存;
					countpdd = pddService.delPackDiliveryDetail(pddids.substring(0, pddids.length() - 1)); // 删除packdiliverydetail(同城送货详细)记录
				}
				// 删除packdilivery(同城送货)记录
				StringBuilder sb = new StringBuilder("delete from packdilivery where id="+pd.getId());
				Query query = JPA.em().createNativeQuery(sb.toString());
				tr.begin();
				query.executeUpdate();
				tr.commit();
			} else {
				try {
					throw new SystemException("实体为空或者id不存在");
				} catch (SystemException e) {
					// TODO Auto-generated catch block
					play.Logger.error(e.getMessage(), e);
				}
			}
			tr.commit();
		} catch (SystemException e1) {
			// TODO Auto-generated catch block
			try {
				tr.rollback();
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				play.Logger.error(e.getMessage(), e);
			}
			e1.printStackTrace();
		}
		
	}
	
	@Override
	public PackDilivery existDiliveno(String diliveno) {
		// TODO Auto-generated method stub
		String sql = "select pd from PackDilivery pd where pd.diliveno = "+diliveno;
		Object obj = null;
		Query query = JPA.em().createQuery(sql, PackDilivery.class);
		if (query.getResultList().size() > 0) {
			obj = query.getResultList().get(0);
		}
		return (PackDilivery)obj;
	}
}
