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

import cn.nova.bus.base.dao.TickettypepermissionDao;
import cn.nova.bus.base.model.Tickettypepermission;
import cn.nova.bus.base.service.TickettypepermissionService;
import cn.nova.bus.exception.ServiceException;
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
public class TickettypepermissionServiceImpl implements
		TickettypepermissionService {

	
	private TickettypepermissionDao tickettypepermissionDao = new TickettypepermissionDao();

	@Override
	public Tickettypepermission save(Tickettypepermission ticket) throws ServiceException {
		boolean hasExist = isExist(ticket.getType(), ticket.getTypeid(),
				ticket.getTickettypeid());
		if (ticket.getId() == 0) {
			if (hasExist) {
				throw new ServiceException("0162");
			}
			return (Tickettypepermission) tickettypepermissionDao.merge(ticket);
		} else {
			Tickettypepermission permission = getById(ticket.getId());
			if ((!ticket.getType().equals(permission.getType()))
					|| (ticket.getTypeid() != permission.getTypeid())
					|| (ticket.getTickettypeid() != permission.getTickettypeid())) {
				if (hasExist) {
					throw new ServiceException("0162");
				}
			}
			ticket.setCreatetime(permission.getCreatetime());
			return (Tickettypepermission) tickettypepermissionDao.merge(ticket);
		}
	}

	@SuppressWarnings("rawtypes")
	private boolean isExist(String type, long typeid, long tickettypeid) {
		List list = tickettypepermissionDao.isExist(type, typeid, tickettypeid);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public boolean delete(Long id) {
		return tickettypepermissionDao.delete(Tickettypepermission.class, id);
	}

	@Override
	public boolean delete(Tickettypepermission tickettypepermission) {
		return tickettypepermissionDao.delete(Tickettypepermission.class);
	}

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { "id", "type", "typeid",
				"tickettypeid", "createby", "createtime", "updateby",
				"updatetime", "createname", "updatename", "name",
				"tickettypename", "orgname" },
				tickettypepermissionDao.query(propertyFilters),
				new Object[] { Long.class, String.class, Long.class,
						Long.class, Long.class, String.class, Long.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class });
	}

	@Override
	public Tickettypepermission getById(Long id) {
		return (Tickettypepermission) tickettypepermissionDao.get(
				Tickettypepermission.class, id);
	}
}
