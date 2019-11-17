/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service.impl<br/>
 * <b>文件名：</b>OrgdayneedbalanceServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午03:18:11 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.Orgdayneedbalancedao;
import cn.nova.bus.balance.model.Orgdayneedbalance;
import cn.nova.bus.balance.service.OrgdayneedbalanceService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午03:18:11 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class OrgdayneedbalanceServiceImpl implements OrgdayneedbalanceService {


	private Orgdayneedbalancedao dao = new Orgdayneedbalancedao();

	@Override
	public boolean save(Orgdayneedbalance orgdayneedbalance) {
		if (orgdayneedbalance.getId() == 0) {
			return dao.save(orgdayneedbalance);
		}
		return dao.update(orgdayneedbalance);
	}

	@Override
	public boolean delete(Orgdayneedbalance orgdayneedbalance) {
		return dao.del(orgdayneedbalance);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Orgdayneedbalance.class,
				"orgname", "balanceno", "createname", "updatename" },
				dao.query(propertyFilterList), new Object[] {
						Orgdayneedbalance.class, String.class, String.class,
						String.class, String.class });
	}

}
