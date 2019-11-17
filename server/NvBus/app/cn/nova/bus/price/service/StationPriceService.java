/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.price.service<br/>
 * <b>文件名：</b>StationPriceService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-4-25  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Stationprice;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：站点平时票价管理</b><br/>
 * <b>类名称：</b>StationPriceService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-4-25  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface StationPriceService {

	public List<Map<String, Object>> qryStationPrice(List<PropertyFilter> propertyFilterList);
	
	public Stationprice save( Stationprice stp) throws ServiceException;

	public boolean delete(long id) throws ServiceException;
	
}
