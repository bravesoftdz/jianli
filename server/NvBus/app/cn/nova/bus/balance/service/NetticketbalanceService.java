/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service<br/>
 * <b>文件名：</b>NetticketbalanceService.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-14 上午09:11:17 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Netticketbalance;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>NetticketbalanceService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-14 上午09:11:17 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface NetticketbalanceService {

	public boolean save(Netticketbalance netticketbalance);

	public boolean delete(Netticketbalance netticketbalance);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyfilter);

}
