package cn.nova.bus.price.service.impl;
/**
 * @author lck
 * 
 */
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.HolidayDao;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Holiday;
import cn.nova.bus.price.service.HolidayService;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class HolidayServiceImpl implements HolidayService {

	private HolidayDao holidayDao = new HolidayDao();
	
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Holiday.class,"username"},
		holidayDao.qryHoliday(propertyFilterList),
		new Object[] { Holiday.class,String.class});
	}

	@SuppressWarnings("unchecked")
	@Override
	public Holiday save(Holiday holiday) throws ServiceException {
		/*if (holidayDao.isExistHolidayByDate(holiday)){
			throw new ServiceException("0056");
		}		*/
		if (holidayDao.isExistActiveHoliday(holiday)){
			throw new ServiceException("0057");
		}
		//是否存在该名称的节日
		if (holidayDao.isExistDelHoliday(holiday)){
			Holiday oldholiday=holidayDao.getHolidaybyName(holiday);
			oldholiday.setCreateby(holiday.getCreateby());
			oldholiday.setCreatetime(new Date());
			oldholiday.setEnddate(holiday.getEnddate());
			oldholiday.setIsactive(true);
			oldholiday.setIslocaldelete(false);
			oldholiday.setStartdate(holiday.getStartdate());
			oldholiday.setType(holiday.getType());
			oldholiday.setUpdateby(holiday.getCreateby());
			oldholiday.setUpdatetime(new Date());
			return (Holiday) holidayDao.merge( oldholiday );
		}else{
			return (Holiday) holidayDao.merge( holiday );
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(long id,long updateby) {
		Holiday holiday=(Holiday) holidayDao.get(Holiday.class,id);
		holiday.setIsactive(false);
		holiday.setIslocaldelete(true);
		holiday.setUpdateby(updateby);
		holiday.setUpdatetime(new Date());
		holidayDao.merge(holiday);
		return true;
	}

	@Override    
	public List<Map<String, Object>> importholidayprice() {
		List<Object> listobj = holidayDao.getHolidayPrice();
		Object[] fields =new Object[]{"fullname","startdate","enddate","routename","code",
										"starttime","typename","planseatnum","endstationname","fullprice",
										"halfprice","viastation"};
		Object[] types = new Object[]{String.class,String.class,String.class,String.class,String.class,
										String.class,String.class,String.class,String.class,BigDecimal.class,
										BigDecimal.class,String.class};
		List<Map<String, Object>> list = ListUtil.listToMap(fields,listobj, types);
//		String[] heads = new String[]{"节日名称","开始日期","结束日期","所属线路","班次号","发车时间","车型","计划座位数","到达站","半价","全价","途径站点"};
		
		return list;
	}

	@Override
	/**
	 * 通过节日ID获取节日票价信息并更新其中的节日信息
	 */
	public MethodResult updateHolidayPrices(Holiday holiday) {
		MethodResult result = new MethodResult();
//		if (holidayDao.isHolidayAcrossEachother(holiday)) {
//			result.setResult(0);
//			result.setResultMsg("节日日期不能交叉!");
//		} else {
			List<Handholidayprice> list = holidayDao.getHandholidaypriceByHolidayid(holiday.getId());
			if (list != null && list.size() > 0) {
				for (Handholidayprice handholidayprice : list) {
					handholidayprice.setStartdate(holiday.getStartdate());
					handholidayprice.setEnddate(holiday.getEnddate());
					holidayDao.merge(handholidayprice);
				}
				result.setResultMsg("相关节日票价日期也修改成功!");
			}else{
				result.setResultMsg("");
			}
			result.setResult(1);
//		}
		return result;
	}

}
