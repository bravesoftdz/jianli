package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.pack.dao.PackRecycleDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.service.PackRecycleService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackRecycleServiceImpl implements PackRecycleService {

	PackRecycleDao packRecycleDao = new PackRecycleDao();

	@Override
	public List<Map<String, Object>> getList(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "tostationname", "pieces",
				"totalfee", "createtime", "sellbyname", "packno", "vehicleno",
				"vehicleid", "id" },
				packRecycleDao.getList(buildFromHttpRequest), new Object[] {
						String.class, Integer.class, BigDecimal.class,
						Date.class, String.class, String.class, String.class,
						Long.class, Long.class });
	}

	@Override
	public void recycle(Long packid, Long vehicleid) {
		Global global = CurrentUtil.getGlobal();

		Pack pack = (Pack) packRecycleDao.get(Pack.class, packid);
		pack.setCollectstatus("2");// 已回收
		pack.setRecycleby(global.getUserinfo().getId());
		pack.setRecycledate(new Date());

		packRecycleDao.merge(pack);
	}

}
