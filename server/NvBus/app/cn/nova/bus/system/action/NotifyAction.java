package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.NotifyService;
import cn.nova.bus.system.service.impl.NotifyServiceImpl;

public class NotifyAction extends BaseAction{
	private List<Map<String, Object>> datalist;

	private NotifyService notifyService;

	private long notifyid;

	public String queryNotify() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo() != null) {
				notifyService = new NotifyServiceImpl();
				setDatalist(notifyService.queryNotify(global)); 
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public String updateNotifyByid() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo() != null) {
				notifyService = new NotifyServiceImpl();
				notifyService.updateNotify(notifyid);
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public List<Map<String, Object>> getDatalist() {
		return datalist;
	}

	public void setDatalist(List<Map<String, Object>> datalist) {
		this.datalist = datalist;
	}

	public long getNotifyid() {
		return notifyid;
	}

	public void setNotifyid(long notifyid) {
		this.notifyid = notifyid;
	}
}
