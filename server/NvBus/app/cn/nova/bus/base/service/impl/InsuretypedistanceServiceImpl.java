package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.InsuretypedistanceDao;
import cn.nova.bus.base.model.Insurancetypefares;
import cn.nova.bus.base.model.Insuretypedistance;
import cn.nova.bus.base.model.Insuretypeticketprice;
import cn.nova.bus.base.service.InsuretypedistanceService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class InsuretypedistanceServiceImpl implements InsuretypedistanceService {


	private InsuretypedistanceDao insuretypedistanceDao = new InsuretypedistanceDao();

	@SuppressWarnings("unchecked")
	@Override
	public Insuretypedistance save(Insuretypedistance insuretypedistance)
			throws ServiceException {
		if (insuretypedistanceDao.isexist(insuretypedistance)) {
			// 里程区间段不能交叉，请重新输入！
			throw new ServiceException("0421");
		}
		if (insuretypedistance.getId() == 0) {
			insuretypedistance.setCreatetime(new Date());
			insuretypedistance.setUpdateby(insuretypedistance.getCreateby());
			insuretypedistance.setUpdatetime(new Date());
		} else {
			insuretypedistance.setUpdatetime(new Date());
		}
		
		return (Insuretypedistance) insuretypedistanceDao.merge(insuretypedistance);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(Insuretypedistance insuretypedistance) {
		Insuretypedistance it = (Insuretypedistance) insuretypedistanceDao.get(
				Insuretypedistance.class, insuretypedistance.getId());
		if (it != null) {
			insuretypedistanceDao.del(it);
			return true;
		}
		return false;
	}
	@SuppressWarnings("unchecked")
	@Override
	public boolean deletefares(Insurancetypefares insurancetypefares) {
		Insurancetypefares itf = (Insurancetypefares) insuretypedistanceDao.get(
				Insurancetypefares.class, insurancetypefares.getId());
		if (itf != null) {
			insuretypedistanceDao.del(itf);
			return true;
		}
		return false;
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] {
				"id", "orgid","orgname", "insuretypeid",
				"fromdistance", "enddistance", "createtime", "createby",
				"updatetime", "updateby", "insuretypename", "createname",
				"updatename","insuretypecode","premium" },
				insuretypedistanceDao.query(propertyFilterList), new Object[] {
						long.class, long.class,String.class,long.class,
						long.class,long.class, Timestamp.class, long.class,
						Timestamp.class, long.class, String.class,
						String.class, String.class,String.class,BigDecimal.class });
	}
	
	public List<Map<String, Object>> qryinsuretypeprice(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] {
				"id", "orgid","orgname", "insuretypeid",
				"fromprice", "endprice", "createtime", "createby",
				"updatetime", "updateby", "insuretypename", "createname",
				"updatename","insuretypecode","premium" },
				insuretypedistanceDao.qryinsuretypeprice(propertyFilterList), new Object[] {
						long.class, long.class,String.class,long.class,
						long.class,long.class, Timestamp.class, long.class,
						Timestamp.class, long.class, String.class,
						String.class, String.class,String.class,BigDecimal.class });
	}
	
	@Override
	public List<Map<String, Object>> qryInsuranceTypeFares(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] {
				"id", "orgid","orgname", "insuretypeid","insuretypename",
				"fromprice", "endprice", "createtime", "createby",
				"updatetime", "updateby"},
				insuretypedistanceDao.qryInsuranceTypeFares(propertyFilterList), new Object[] {
						long.class, long.class,String.class,long.class, String.class,
						long.class,long.class, Date.class,  String.class,
						Date.class,  String.class });
	}
	@SuppressWarnings("unchecked")
	@Override
	public Insurancetypefares saveinsuretypeFares(Global global,Insurancetypefares insurancetypefares)
			throws ServiceException {
		if (insuretypedistanceDao.isexistinsuretypeFares(insurancetypefares)) {
			// 票价区间段不能交叉，请重新输入！
			throw new ServiceException("0516");
		}
		if (insurancetypefares.getId() == 0) {
			insurancetypefares.setCreateby(global.getUserinfo().getId());
			insurancetypefares.setCreatetime(new Date());
			insurancetypefares.setUpdateby(global.getUserinfo().getId());
			insurancetypefares.setUpdatetime(new Date());
		} else {
			Insurancetypefares itf = insuretypedistanceDao.getEntityManager().find(Insurancetypefares.class,insurancetypefares.getId());
			insurancetypefares.setId(itf.getId());
			insurancetypefares.setCreateby(itf.getCreateby());
			insurancetypefares.setCreatetime(itf.getCreatetime());
			insurancetypefares.setUpdateby(global.getUserinfo().getId());
			insurancetypefares.setUpdatetime(new Date());
		}
		
		return (Insurancetypefares) insuretypedistanceDao.merge(insurancetypefares);
	}


	@Override
	public Insuretypeticketprice saveinsuretypeprice(
			Insuretypeticketprice insuretypeticketprice) throws ServiceException {
		if (insuretypedistanceDao.ispriceexist(insuretypeticketprice)) {
			// 票价区间段不能交叉，请重新输入！
			throw new ServiceException("0611");
		}
		if (insuretypeticketprice.getId() == 0) {
			insuretypeticketprice.setCreatetime(new Date());
			insuretypeticketprice.setUpdateby(insuretypeticketprice.getCreateby());
			insuretypeticketprice.setUpdatetime(new Date());
		} else {
			insuretypeticketprice.setUpdatetime(new Date());
		}
		
		return  (Insuretypeticketprice) insuretypedistanceDao.merge(insuretypeticketprice);
	}
	@Override
	public boolean deleteinsuretypeprice(
			Insuretypeticketprice insuretypeticketprice) {
		Insuretypeticketprice it = (Insuretypeticketprice) insuretypedistanceDao.get(
				Insuretypeticketprice.class, insuretypeticketprice.getId());
		if (it != null) {
			insuretypedistanceDao.del(it);
			return true;
		}
		return false;
	}
}
