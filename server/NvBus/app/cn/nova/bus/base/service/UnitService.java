/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service<br/>
 * <b>文件名：</b>UnitService.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Unit;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface UnitService {

	public Unit save(Unit unit, Global global) throws ServiceException;

	public List<Unit> query();

	public Unit getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean delete(Long id);

	public boolean unique(String value, String key);

	// 检测车属单位是否在车牌中已经使用
	public boolean isApply(long id);

	public List<Map<String, Object>> getUnitInfo();

}
