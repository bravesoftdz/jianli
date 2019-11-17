package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Fuelfeegrade;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Fuelfeegradedetail;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <b>类描述： 燃油费档次信息</b><br/>
 * <b>类名称：</b>FuelfeegradeService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface FuelfeegradeService {
	public List<Map<String, Object>> qryFuelfeegrade(String orgids);

	public List<Map<String, Object>> qryFuelfeegrade(long orgid);

	public Fuelfeegrade saveFuelfeegrade(Fuelfeegrade fuelfeegrade)
			throws ServiceException;

	public boolean delFuelfeegrade(Fuelfeegrade fuelfeegrade);

	public List<Map<String, Object>> qryFuelfeegradedetail(long fuelfeegradeid);

	public Fuelfeegradedetail saveFuelfeegradedetail(
			Fuelfeegradedetail fuelfeegradedetail) throws ServiceException;

	public boolean delFuelfeegradedetail(Fuelfeegradedetail fuelfeegradedetail);

	public List<Map<String, Object>> qryFuelfeegradeapply(List<PropertyFilter> propertyFilterList);

	public Fuelfeegradeapply saveFuelfeegradeapply(
			Fuelfeegradeapply fuelfeegradeapply) throws ServiceException;

	public boolean delFuelfeegradeapply(Fuelfeegradeapply fuelfeegradeapply);

	
	public List<Map<String, Object>> qryRoutes(long orgid);
}
