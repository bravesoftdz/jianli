/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service.impl<br/>
 * <b>文件名：</b>OrgdayneedbalancedetailServiceimpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-14 上午08:58:06 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.Orgdayneedbalancedetaildao;
import cn.nova.bus.balance.model.Orgdayneedbalancedetail;
import cn.nova.bus.balance.service.OrgdayneedbalancedetailService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>OrgdayneedbalancedetailServiceimpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-14 上午08:58:06 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class OrgdayneedbalancedetailServiceImpl implements
		OrgdayneedbalancedetailService {


	private Orgdayneedbalancedetaildao dao = new Orgdayneedbalancedetaildao();

	@Override
	public boolean save(Orgdayneedbalancedetail orgdayneedbalancedetail) {
		if (orgdayneedbalancedetail.getId() == 0) {
			return dao.save(orgdayneedbalancedetail);
		}
		return dao.update(orgdayneedbalancedetail);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Orgdayneedbalancedetail.class,
				"orgname", "balanceno", "createname", "updatename",
				"otherorgname" }, dao.query(propertyFilterList), new Object[] {
				Orgdayneedbalancedetail.class, String.class, String.class,
				String.class, String.class, String.class });
	}

	@Override
	public boolean delete(Orgdayneedbalancedetail orgdayneedbalancedetail) {
		return false;
	}

}
