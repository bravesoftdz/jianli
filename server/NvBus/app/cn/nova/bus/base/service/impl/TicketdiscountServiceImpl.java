/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service.impl<br/>
 * <b>文件名：</b>TicketdiscountServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-1-9 上午10:15:50<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.TicketdiscountDao;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.base.service.TicketdiscountService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>TicketdiscountServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-1-9 上午10:15:50<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketdiscountServiceImpl implements TicketdiscountService {

	
	private TicketdiscountDao discountDao = new TicketdiscountDao();

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.base.service.TicketdiscountService#save(cn.nova.bus.base.
	 * model.Ticketdiscount, cn.nova.bus.security.Global)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Ticketdiscount save(Ticketdiscount ticketdiscount, Global global)
			throws ServiceException {
		if (ticketdiscount.getId() == 0) {
			if (discountDao.isExist(ticketdiscount)) {
				String exInfo = null;
				if ("B".equals(ticketdiscount.getTickettype())) {
					exInfo = "半票";
				} else if ("X".equals(ticketdiscount.getTickettype())) {
					exInfo = "学生票";
				} else if ("Z".equals(ticketdiscount.getTickettype())) {
					exInfo = "打折票";
				}
				if ("0".equals(ticketdiscount.getDatatype())) {
					Organization org = (Organization) discountDao.get(Organization.class, ticketdiscount.getDataid());
					exInfo = exInfo + "对应的机构 " + org.getName();
				} else if ("1".equals(ticketdiscount.getDatatype())) {
					Route route = (Route) discountDao.get(Route.class, ticketdiscount.getDataid());
					exInfo = exInfo + "对应的线路 " + route.getName();
				} else if ("2".equals(ticketdiscount.getDatatype())) {
					Schedule schedule = (Schedule) discountDao.get(Schedule.class, ticketdiscount.getDataid());
					exInfo = exInfo + "对应的班次 " + schedule.getCode();
				}
				throw new ServiceException(exInfo,"0419");
			}
			ticketdiscount.setCreatetime(new Date());
			ticketdiscount.setUpdatetime(new Date());
			ticketdiscount.setCreateby(global.getUserinfo().getId());
			ticketdiscount.setUpdateby(global.getUserinfo().getId());
			ticketdiscount.setOrgid(global.getOrganization().getId());
		} else {
			ticketdiscount.setUpdatetime(new Date());
			ticketdiscount.setUpdateby(global.getUserinfo().getId());
		}
		ticketdiscount = (Ticketdiscount) discountDao.merge(ticketdiscount);
		return ticketdiscount;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.base.service.TicketdiscountService#delete(long)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(long id) {
		return discountDao.delete(Ticketdiscount.class, id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.base.service.TicketdiscountService#query(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "id", "dataid", "orgname",
				"createname", "updatename", "startdate", "enddate",
				"defaultdiscountrate", "mindiscountrate", "createtime",
				"updatetime", "sellnum", "orgid", "typename", "tickettype",
				"dataname", "createby","code" },
				discountDao.queryTicketdiscount(propertyFromHttpRequest),
				new Object[] { Long.class, Long.class, String.class,
						String.class, String.class, Timestamp.class,
						Timestamp.class, BigDecimal.class, BigDecimal.class,
						Timestamp.class, Timestamp.class, Long.class,
						Long.class, String.class, String.class, String.class,
						Long.class, String.class});

	}

}
