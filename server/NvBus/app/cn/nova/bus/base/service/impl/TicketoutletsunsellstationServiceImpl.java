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

import cn.nova.bus.base.dao.TicketoutletsunsellstationDao;
import cn.nova.bus.base.model.Ticketoutletssellschedule;
import cn.nova.bus.base.model.Ticketoutletsunsellstation;
import cn.nova.bus.base.service.TicketoutletsunsellstationService;
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
public class TicketoutletsunsellstationServiceImpl implements
		TicketoutletsunsellstationService {


	private TicketoutletsunsellstationDao dao = new TicketoutletsunsellstationDao();

	@Override
	public Boolean save(
			Ticketoutletsunsellstation ssellschedulte, String ticketoutletsids) {
		ticketoutletsids = ticketoutletsids.substring(1, ticketoutletsids.length()-1);//(1158016, 1168359, 1226808, 1226809)
		String[] ticketoutletsid = ticketoutletsids.split(",");
		for (String string : ticketoutletsid) {
			ssellschedulte.setTicketoutletsid(Long.parseLong(string));
			dao.merge(ssellschedulte);
		}
		return true;
//		if (ssellschedulte.getId() == 0) {
//			return (Ticketoutletsunsellstation) dao.merge(ssellschedulte);
//		} else {
//			return (Ticketoutletsunsellstation) dao.merge(ssellschedulte);
//		}
	}

	@Override
	public boolean delete(Ticketoutletsunsellstation ssellschedulte) {
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
	public List<Ticketoutletsunsellstation> query() {
		return dao.query(Ticketoutletssellschedule.class, null);
	}

	@Override
	public Ticketoutletsunsellstation getById(Long id) {
		return (Ticketoutletsunsellstation) dao.get(
				Ticketoutletsunsellstation.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {

		return ListUtil.listToMap(new Object[] { "createtime", "updatetime",
				"enddate", "startdate", "id", "ticketname", "createname",
				"updatename", "value", "typename","stationname" },
				dao.query(propertyFilterList), new Object[] { Timestamp.class,
						Timestamp.class, Timestamp.class, Timestamp.class,
						Long.class, String.class, String.class, String.class,
						String.class, String.class,String.class });
	}

	@Override
	public boolean equals(Ticketoutletsunsellstation ticketoutletsunsellstation) {
		return dao.isExist(ticketoutletsunsellstation);
	}

	@Override
	public String getValue(Long ticketoutletid, String type, Long typeid,
			Long stationid) {
		return dao.getValue(ticketoutletid, type, typeid, stationid);
	}

	@Override
	public Long findId(String code) {
		return null;
	}

}
