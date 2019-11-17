package cn.nova.bus.dispatch.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.dispatch.dao.NetSaleControlDao;
import cn.nova.bus.dispatch.service.NetSaleControlService;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.NetSaleControl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CurrentUtil;

public class NetSaleControlServiceImpl implements NetSaleControlService {
	private NetSaleControlDao dao = new NetSaleControlDao();

	@Override
	public List<Map<String, Object>> queryschbyrouteid(List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "isselect", "code", "starttime", "scheduleid" },
				dao.queryschbyrouteid(propertyFilterList),
				new Object[] { boolean.class, String.class, String.class, long.class });
	}

	@Override
	public MethodResult saveNetSaleControl(String scheduleidlist, String orgid, String netorgid, long routeid,
			String savestyle) {
		MethodResult result = new MethodResult();
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		String[] netorgids = netorgid.contains(",") 
				? netorgid.substring(1, netorgid.length() - 1).split(",")
				: new String[] { netorgid.substring(1, netorgid.length() - 1) };
		orgid = orgid.substring(1, orgid.length() - 1);
		// ==============================================
		NetSaleControl nc = new NetSaleControl();
		nc.setCreateby(global.getUserinfo().getId());
		nc.setCreatetime(now);
		nc.setUpdateby(global.getUserinfo().getId());
		nc.setUpdatetime(now);
		nc.setOrgid(Long.parseLong(orgid));
		// ==============================================
		// savestyle 0 选中班次 ,1 线路所有班次 ,2 机构所有班次
		for (String netorg : netorgids) {
			if (!"2".equals(savestyle)) {
				String[] schids = scheduleidlist.substring(0, scheduleidlist.length() - 1).split(",");
				for (String scheduleid : schids) {
					if (!dao.exitNetSaleControl(Long.parseLong(scheduleid), Long.parseLong(orgid),
							Long.parseLong(netorg))) {
						nc.setScheduleid(Long.parseLong(scheduleid));
						nc.setNetorgid(Long.parseLong(netorg));
						nc.setRouteid(routeid);
						dao.merge(nc);
					}
				}
				// 按照机构所有班次保存
			} else {
				List<Schedule> schlist = dao.getOrgAllSchedule(Long.parseLong(orgid));
				for (Schedule sc : schlist) {
					if (!dao.exitNetSaleControl(sc.getId(), Long.parseLong(orgid), Long.parseLong(netorg))) {
						nc.setScheduleid(sc.getId());
						nc.setNetorgid(Long.parseLong(netorg));
						nc.setRouteid(sc.getRoute().getId());
						dao.merge(nc);
					}
				}
			}
		}
		result.setResult(1);
		result.setResultMsg("保存成功!");
		return result;
	}

	@Override
	public List<Map<String, Object>> queryNetSaleControl(List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(
				new Object[] { "id", "netorg", "routename", "schedulecode", "createby", "createtime", "updateby",
						"updatetime" },
				dao.queryNetSaleControl(propertyFilterList), new Object[] { long.class, String.class, String.class,
						String.class, String.class, Timestamp.class, String.class, Timestamp.class });
	}

	@Override
	public boolean delNetSaleControl(long id) {
		return dao.del(dao.get(NetSaleControl.class, id));
	}

}
