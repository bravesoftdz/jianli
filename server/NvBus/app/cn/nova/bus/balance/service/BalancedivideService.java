package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancedivide;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <b>类描述：结算分层协议设置</b><br/>
 * <b>类名称：</b>BalancedivideService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface BalancedivideService {
	// 保存结算分层协议信息
	public Balancedivide saveBalancedivide(Balancedivide balancedivide)
			throws ServiceException;

	// 删除结算分层协议信息
	public boolean deleteBalancedivide(Balancedivide balancedivide)
			throws ServiceException;

	// 查询结算分层协议信息
	public List<Map<String, Object>> qryBalancedivide(
			List<PropertyFilter> propertyFilterList);
}
