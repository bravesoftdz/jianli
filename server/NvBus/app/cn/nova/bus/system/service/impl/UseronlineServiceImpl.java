package cn.nova.bus.system.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.UseronlineDao;
import cn.nova.bus.system.model.Useronline;
import cn.nova.bus.system.service.UseronlineService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CurrentUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

@SuppressWarnings("unchecked")
public class UseronlineServiceImpl implements UseronlineService {

	
	private UseronlineDao dao = new UseronlineDao();

	@Override
	public boolean save(Useronline online) {
		if (online.getUserid() == 0) {
			return dao.save(online);
		} else {
			return dao.update(online);
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Useronline.class, id);
	}

	@Override
	public List<Useronline> query() {
		return dao.query(Useronline.class, null);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Useronline.class, "username",
				"usercode", "islock", "ismultipoint", "orgname", "depname" },
				dao.query(propertyFilterList), new Object[] { Useronline.class,
						String.class, String.class, Boolean.class,
						Boolean.class, String.class, String.class });
	}

	@Override
	public Date getById(Long userid) {
		return dao.getlastlogintime(userid);
	}

	@Override
	public Useronline getByUserid(Long userid) {
		return dao.getByUserid(userid);
	}

	@Override
	public boolean logout(long userid, Global global) {
		Useronline useronline = getByUserid(userid);
		useronline.setIsonline(false);
		useronline.setLastlogintime(useronline.getLogintime());
		if (global != null) {
			RedisUtil.delete(RedisDBApp.Lessee, global.getUserinfo().getId() + ":" + global.getIpAddress());
		}
		return dao.update(useronline);
	}

	@Override
	public boolean relogin(long userid,Global global) {
		Useronline useronline = getByUserid(userid);
		useronline.setIsonline(true);
		useronline.setLogintime(new Date());
		useronline.setLastlogintime(useronline.getLogintime());
		if (global != null) {
			global.setIsonline(true);
		}
		return dao.update(useronline);
	}

}
