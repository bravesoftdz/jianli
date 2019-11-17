package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.StandardpriceDao;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.service.StandardpriceService;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * @author lck
 * 
 */

public class StandardpriceServiceImpl implements StandardpriceService {


	private StandardpriceDao standardpriceDao = new StandardpriceDao();


	private TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Standardprice.class,
				"departstation", "reachstation", "vehicletype" },
				standardpriceDao.query(propertyFilterList), new Object[] {
						Standardprice.class, String.class, String.class,
						String.class });
	}

	@Override
	public List<Map<String, Object>> qryStandardPriceItem(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "code", "name", "price" },
				standardpriceDao.qryStandardPriceItem(propertyFilterList),
				new Object[] { String.class, String.class, BigDecimal.class });

	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean genPrice(Long scheduleid, Long createby)
			throws ServiceException {
		List<Long> vehicletypeids = standardpriceDao
				.qryCycleschemesVehicletype(scheduleid);
		if (vehicletypeids.size() == 0) {
			throw new ServiceException("0103");
		}
		List<Standardprice> standardpricelist = standardpriceDao
				.qryStandardPrice(scheduleid);
		for (Standardprice standardprice : standardpricelist) {
			standardpriceDao.delete(standardprice);
		}
		standardpriceDao.getEntityManager().flush();
		Schedule schedule = (Schedule) standardpriceDao.get(Schedule.class,
				scheduleid);
		for (long vehicletypeid : vehicletypeids) {
				ticketpriceformulaService.genPrice(schedule.getOrgid(),
						schedule.getRoute().getId(), schedule.getId(),
						vehicletypeid, createby);
		}
		return true;
	}

}
