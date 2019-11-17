package cn.nova.bus.hirebus.service.Impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.hirebus.dao.HirebusDao;
import cn.nova.bus.hirebus.model.Hirebus;
import cn.nova.bus.hirebus.service.HirebusService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class HirebusServiceImpl implements HirebusService {

	
	private HirebusDao hirebusDao = new HirebusDao();
	
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { Hirebus.class, "unitname",
				"fullname", "operatername", "orgname","vehicleno","tlname","districtname" },
				hirebusDao.query(propertyFilters), new Object[] {
						Hirebus.class, String.class, String.class,
						String.class, String.class,String.class,String.class,String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Hirebus saveHirebus(Hirebus hirebus,Global global) throws ServiceException {

		if (hirebus.getId() == 0) {
			
				 Billtype billtype = billtypeService
				.findByCode(ConstDefiniens.HirebusBill);
				
				Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
						hirebus.getOperater(), new Long(hirebus.getHirebusno()));
				if (billinuse == null || "2".equals(billinuse.getStatus())) {
					// 您的票据已经用完
					throw new ServiceException("0143");
				}
			
			hirebusDao.save(hirebus);
			billinuseService.jumpBillinuse(global.getUserinfo().getId(),
					billtype.getCode(),hirebus.getHirebusno(),1);
		} else {
			hirebusDao.getEntityManager().merge(hirebus);
		}
		return hirebus;
	}
	
	/**
	 * 作废
	 * @param hirebus
	 * @return
	 * @throws ServiceException
	 */
	@Override
	public boolean wastePack(Hirebus hirebus) throws ServiceException{
		boolean bol = hirebusDao.wastePack(hirebus);
		return bol;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Hirebus whackhirebus(Hirebus hirebus)throws ServiceException{
		
		Billtype billtype = billtypeService
		.findByCode(ConstDefiniens.HirebusBill);
		
		Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
				hirebus.getOperater(), new Long(hirebus.getHirebusno()));
		if (billinuse == null || "2".equals(billinuse.getStatus())) {
			// 您的票据已经用完
			throw new ServiceException("0143");
		}
		
		Hirebus p = (Hirebus) hirebusDao.get(Hirebus.class, hirebus.getId());
		Hirebus p2 =null;
		
		p2 = (Hirebus) p.clone();
			
		
		String status=p.getStatus();
		p.setStatus("2");
		p.setUpdatetime(hirebus.getUpdatetime());
		p.setUpdateby(hirebus.getUpdateby());
		hirebusDao.getEntityManager().merge(p);
		
		
		p2.setId(0);
		p2.setStatus(status);
		p2.setSynccode(null);//重新生成同步码
		p2.setHirebusno(hirebus.getHirebusno());
		p2.setCreateby(hirebus.getOperater());
		p2.setCreatetime(new Date());
		p2.setUpdateby(hirebus.getOperater());
		p2.setUpdatetime(new Date());
		hirebusDao.save(p2);
		
		return p2;
	}
	
}
