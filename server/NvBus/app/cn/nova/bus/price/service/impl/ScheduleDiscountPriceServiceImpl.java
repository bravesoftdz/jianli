package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.HandHolidaypriceDao;
import cn.nova.bus.price.dao.ScheduleDiscountPriceDao;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.ScheduleDiscountPrice;
import cn.nova.bus.price.service.ScheduleDiscountPriceService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

public class ScheduleDiscountPriceServiceImpl implements
		ScheduleDiscountPriceService {
	private ScheduleDiscountPriceDao scheduleDiscountPriceDao = new ScheduleDiscountPriceDao();
	//private IDAO<ScheduleDiscountPrice> dao = new EntityManagerDaoSurport<ScheduleDiscountPrice>();

	@Override
	public List<Map<String, Object>> save(
			List<ScheduleDiscountPrice> scheduleDiscountPrices, Long userid,
			Long scheduleid, Date startDate, Date endDate,int salenum, boolean savesameroute)
			throws ServiceException, Exception {
		List<Object> saveobj = new ArrayList<Object>();
		if (!savesameroute) {
			for (ScheduleDiscountPrice sch : scheduleDiscountPrices) {
				sch.setEnddate(endDate);
				sch.setStartdate(startDate);
				sch.setSalenum(salenum);
				if (sch.getId() > 0) {
					sch.setUpdateby(userid);
					sch.setUpdatetime(new Date());
					saveobj.add(scheduleDiscountPriceDao.merge(sch));
				} else {
					if (sch.getPrice() == null) {
						continue;
					}
					sch.setCreateby(userid);
					sch.setCreatetime(new Date());
					sch.setUpdateby(userid);
					sch.setUpdatetime(new Date());
					sch.setScheduleid(scheduleid);
					saveobj.add(scheduleDiscountPriceDao.merge(sch));
				}
			}
		} else {
			List<Object> schedules = scheduleDiscountPriceDao
					.querySchedule(scheduleid);
			for (Object schid : schedules) {
				for (ScheduleDiscountPrice sch : scheduleDiscountPrices) {
					// if (sch.getId() > 0) {
					if (sch.getPrice() == null) {
						continue;
					}
					List<ScheduleDiscountPrice> scds = scheduleDiscountPriceDao.query(
							Long.parseLong(schid + ""),
							sch.getDepartstationid(), sch.getReachstationid());
					ScheduleDiscountPrice sdp = null;
					if (scds.size() == 0) {
						sdp = new ScheduleDiscountPrice();
						sdp.setDepartstationid(sch.getDepartstationid());
						sdp.setReachstationid(sch.getReachstationid());
						sdp.setReferenceprice(sch.getReferenceprice());
						sdp.setCreateby(userid);
						sdp.setCreatetime(new Date());
						sdp.setScheduleid(Long.parseLong(schid + ""));
					} else {
						sdp = scds
								.get(0);
					}
					sdp.setPrice(sch.getPrice());
					sdp.setReferenceprice(sch.getReferenceprice());
					sdp.setSalenum(salenum);
					sdp.setEnddate(endDate);
					sdp.setStartdate(startDate);
					sdp.setUpdateby(userid);
					sdp.setUpdatetime(new Date());
					saveobj.add(scheduleDiscountPriceDao.merge(sdp));
					// } else {
					// if (sch.getPrice() == null) {
					// continue;
					// }
					// sch.setCreateby(userid);
					// sch.setCreatetime(new Date());
					// sch.setUpdateby(userid);
					// sch.setEnddate(endDate);
					// sch.setStartdate(startDate);
					// sch.setUpdatetime(new Date());
					// sch.setScheduleid(Long.parseLong(schid + ""));
					// // sch.setScheduleid(scheduleid);
					// saveobj.add(scheduleDiscountPriceDao.merge(sch));
					// }
				}
			}

		}
		return ListUtil.listToMap(new Object[] { ScheduleDiscountPrice.class },
				saveobj, new Object[] { ScheduleDiscountPrice.class });
	}

	@Override
	public boolean delScheduleDiscountPrice(
			ScheduleDiscountPrice schedulediscountprice) {
		// scheduleDiscountPriceDao.delSchDiscountPrice(scheduleid);
		return false;
	}

	@Override
	public List<Map<String, Object>> qryScheduleDiscountPrice(Long scheduleid) {
		// return ListUtil.listToMap(new Object[] { ScheduleDiscountPrice.class
		// },
		// scheduleDiscountPriceDao.query(scheduleid),
		// new Object[] { ScheduleDiscountPrice.class });
		return ListUtil.listToMap(new Object[] { "id", "scheduleid",
				"startdate", "enddate", "departstationid", "reachstationid",
				"price", "salenum", "orgid", "createtime", "createby",
				"updatetime", "updateby","referenceprice" },
				scheduleDiscountPriceDao.query(scheduleid), new Object[] {
						Long.class, Long.class, Date.class, Date.class,
						Long.class, Long.class, BigDecimal.class,
						Integer.class, Long.class, Timestamp.class, Long.class,
						Timestamp.class, Long.class,BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> qryScheduleDiscountPrice(Long routeid,
			Long scheduleid) {
		System.out.println("===" + scheduleid);
		return ListUtil.listToMap(new Object[] { "id", "scheduleid",
				"startdate", "enddate", "departstationid", "reachstationid",
				"price", "salenum", "orgid", "createtime", "createby",
				"updatetime", "updateby","referenceprice" },
				scheduleDiscountPriceDao.query(routeid, scheduleid),
				new Object[] { Long.class, Long.class, Date.class, Date.class,
						Long.class, Long.class, BigDecimal.class,
						Integer.class, Long.class, Timestamp.class, Long.class,
						Timestamp.class, Long.class,BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> qryStation(Long scheduleid) {

		return ListUtil.listToMap(new Object[] { "id", "name" },
				scheduleDiscountPriceDao.queryStation(scheduleid),
				new Object[] { Long.class, String.class });
	}

	@Override
	public boolean delScheduleDiscountPrice(Long scheduleid) {
		return scheduleDiscountPriceDao.delSchDiscountPrice(scheduleid);
	}
	
	
       @Override
	public boolean modifyScheduleDiscountPrice(long scheduleid,
			long departstationid, long reachstationid,long userid,int discountpricenum) {
		// TODO Auto-generated method stub
		List<Object> list = scheduleDiscountPriceDao.findScheduleDiscountPrice(scheduleid, departstationid, reachstationid);
		ScheduleDiscountPrice sDiscountPrice = new ScheduleDiscountPrice();
		if(list!=null&&list.size()>0){			
			sDiscountPrice = (ScheduleDiscountPrice)list.get(0);
		}
		int oldsalenum = sDiscountPrice.getSalenum();
		sDiscountPrice.setSalenum(oldsalenum-discountpricenum);
		Date date = new Date();
		sDiscountPrice.setUpdatetime(date);
		sDiscountPrice.setUpdateby(userid);
		scheduleDiscountPriceDao.merge(sDiscountPrice);
		return true;
	}

	@Override
	public Long addScheduleDiscountPrice (
			ScheduleDiscountPrice schedulediscountprice, Global global) throws ServiceException{
		// TODO Auto-generated method stub
		Long returnId = 0L;
		Date now = new Date();
		long id = global.getUserinfo().getId();		
		if(scheduleDiscountPriceDao.isExistRoutePrice(schedulediscountprice.getScheduleid(), schedulediscountprice.getDepartstationid(), schedulediscountprice.getReachstationid())){
			throw new ServiceException("0009");
		}
		
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Date fromdate=new Date();
		Date todate=new Date();		
		try {
			fromdate=sf.parse(sf.format(new Date()));
			todate=sf.parse("9999-12-12");			
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		schedulediscountprice.setStartdate(fromdate);
		schedulediscountprice.setEnddate(todate);
		schedulediscountprice.setCreatetime(now);
		schedulediscountprice.setCreateby(id);
		schedulediscountprice.setUpdatetime(now);
		schedulediscountprice.setUpdateby(id);
				
		scheduleDiscountPriceDao.save(schedulediscountprice);
		returnId = schedulediscountprice.getId();
		
		return returnId;
	}

}
