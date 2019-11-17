/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service.impl<br/>
 * <b>文件名：</b>NetticketbalanceServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-14 上午09:14:04 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.Netticketbalancedao;
import cn.nova.bus.balance.model.Netticketbalance;
import cn.nova.bus.balance.service.NetticketbalanceService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>NetticketbalanceServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-14 上午09:14:04 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")

public class NetticketbalanceServiceImpl implements NetticketbalanceService {


	private Netticketbalancedao dao = new Netticketbalancedao();

	@Override
	public boolean save(Netticketbalance netticketbalance) {
		if (netticketbalance.getId() == 0) {
			return dao.save(netticketbalance);
		}
		return dao.update(netticketbalance);
	}

	@Override
	public boolean delete(Netticketbalance netticketbalance) {
		return dao.delete(netticketbalance);
	}

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyfilter) {
		return ListUtil.listToMap(new Object[] { Netticketbalance.class,
				"orgname", "createname", "updatename" },
				dao.query(propertyfilter), new Object[] {
						Netticketbalance.class, String.class, String.class,
						String.class });
	}

}
