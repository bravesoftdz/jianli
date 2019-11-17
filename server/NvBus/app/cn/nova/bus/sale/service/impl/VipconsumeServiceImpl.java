package cn.nova.bus.sale.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipconsumeldetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.service.VipconsumeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;


public class VipconsumeServiceImpl implements VipconsumeService {


	private IDAO dao = new EntityManagerDaoSurport();	
	@Override
	public Vip getConsumeVip(boolean isselfschedule, long sellid) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule", isselfschedule));
		propertyFilters.add(new PropertyFilter("EQL_t!sellid", sellid));
		Vipconsumeldetail vipconsumeldetail = (Vipconsumeldetail) dao.uniqueResult(Vipconsumeldetail.class, propertyFilters);
		if (vipconsumeldetail!=null){
			long vipid = vipconsumeldetail.getVipconsume().getVipid();
			return (Vip) dao.get(Vip.class, vipid);
		}
		return null;
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

}
