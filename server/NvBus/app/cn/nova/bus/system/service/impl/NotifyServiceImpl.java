package cn.nova.bus.system.service.impl;
/**
 * 系统提示信息
 */
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.NotityDao;
import cn.nova.bus.system.model.Notify;
import cn.nova.bus.system.service.NotifyService;
import cn.nova.utils.orm.jpa.ListUtil;


public class NotifyServiceImpl implements NotifyService {

	private NotityDao notityDao = new NotityDao();

	@Override
	public List<Map<String, Object>> queryNotify(Global global)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { "id", "name", "lastlogintime",
				"msg" }, notityDao.queryNotify(global.getUserinfo().getId()),
				new Object[] { Long.class, String.class, Timestamp.class,
						String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean updateNotify(long id) throws ServiceException {
//		Notify notify = (Notify) notityDao.get(Notify.class, id);
		Notify notify = notityDao.getpresaleNotify();
		notify.setIsnotify(true);
		notify.setUpdatetime(new Date());
		return notityDao.save(notify);
	}

}
