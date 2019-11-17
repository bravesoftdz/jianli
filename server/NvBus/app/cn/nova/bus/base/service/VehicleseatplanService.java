/**
 * 
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicleseatplan;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public interface VehicleseatplanService {
	//查询车辆座位图主表
	public List<Map<String,Object>> find(List<PropertyFilter> propertyFilterList);
	//查询车辆座位图明细表用来展现座位图
	public List<Map<String,Object>> finddetail(long id);
	//添加、修改座位图及明细
	public boolean save(Vehicleseatplan vehicleseatplan,long userid) throws ServiceException;
	//删除座位图
	public boolean delete(long vehicleseatplanid,long userid) throws ServiceException;
	//根据车辆品牌类型号ID和座位号取出座位打印备注
	public String getSeatnoRemark(long vehiclebrandmodelid,short seatno);
}
