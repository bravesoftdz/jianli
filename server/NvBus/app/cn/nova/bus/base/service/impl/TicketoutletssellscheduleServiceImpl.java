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

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.TicketoutletssellscheduleDao;
import cn.nova.bus.base.model.Ticketoutletssellschedule;
import cn.nova.bus.base.service.TicketoutletssellscheduleService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class TicketoutletssellscheduleServiceImpl implements
		TicketoutletssellscheduleService {

	
	private TicketoutletssellscheduleDao dao = new TicketoutletssellscheduleDao();

	@Override
	public Ticketoutletssellschedule save(
			Ticketoutletssellschedule ssellschedulte) {
		if (ssellschedulte.getId() == 0) {
			return (Ticketoutletssellschedule) dao.merge(ssellschedulte);
		} else {
			return (Ticketoutletssellschedule) dao.merge(ssellschedulte);
		}
	}

	@Override
	public boolean delete(Ticketoutletssellschedule ssellschedulte) {
		if (ssellschedulte != null) {
			return dao.del(ssellschedulte);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Ticketoutletssellschedule.class, id);
	}

	@Override
	public List<Ticketoutletssellschedule> query() {
		return dao.query(Ticketoutletssellschedule.class, null);
	}

	@Override
	public Ticketoutletssellschedule getById(Long id) {
		return (Ticketoutletssellschedule) dao.get(
				Ticketoutletssellschedule.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {

		return ListUtil.listToMap(new Object[] { "createtime", "updatetime",
				"enddate", "startdate", "id", "ticketname", "createname",
				"updatename", "value", "typename" },
				dao.query(propertyFilterList, "1"),
				new Object[] { Timestamp.class, Timestamp.class,
						Timestamp.class, Timestamp.class, Long.class,
						String.class, String.class, String.class, String.class,
						String.class });
	}

	@Override
	public boolean equals(Long ticketoutletid, String type, Long typeid) {
		return dao.isExist(ticketoutletid, type, typeid);
	}

	@Override
	public String getValue(Long ticketoutletid, String type, Long typeid) {
		return dao.getValue(ticketoutletid, type, typeid);
	}

	@Override
	public Long findId(String code) {
		return null;
	}

}
