package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Viproomcheckin;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface ViproomcheckinService {

	/**
	 * 会员进入贵宾室登记
	 * @param Viproomcheckin v
	 */
	public  Viproomcheckin  saveViproomcheckin(Viproomcheckin viproomcheckin,String ticketsellids)
				throws ServiceException ;
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryViproomcheckin(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 查询用户当天发车的购票明细
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketdetail(String vipcardno) ;
}
