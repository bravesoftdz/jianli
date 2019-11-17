/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.SchedulevipdiscountDao;
import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.bus.base.service.SchedulevipdiscountService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class SchedulevipdiscountServiceImpl implements
		SchedulevipdiscountService {

	private SchedulevipdiscountDao dao = new SchedulevipdiscountDao();

	@Override
	public Schedulevipdiscount save(Schedulevipdiscount discount) {
		if (discount.getId() == 0) {
			return (Schedulevipdiscount) dao.merge(discount);
		} else {
			return (Schedulevipdiscount) dao.merge(discount);
		}
	}

	@Override
	public boolean delete(Schedulevipdiscount discount) {
		if (discount != null) {
			return dao.del(discount);
		} else {
			return false;
		}
	}

	@Override
	public List<Schedulevipdiscount> query() {
		return dao.query(Schedulevipdiscount.class, null);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulevipdiscount.class, id);
	}

	@Override
	public boolean isExist(Long discountid, String vipgrade) {
		return dao.isExist(discountid, vipgrade);
	}

	@Override
	public String getVipgrade(Long id) {
		return dao.getVipgrade(id);
	}

	@Override
	public Long getdiscountid(Long id) {
		return dao.getdiscountid(id);
	}

	@Override
	public Schedulevipdiscount getByid(Long id) {
		return dao.findByid(id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Schedulevipdiscount.class,
				"createname", "updatename", "schedulename" },
				dao.query(propertyFilterList), new Object[] {
						Schedulevipdiscount.class, String.class, String.class,
						String.class });
	}

}
