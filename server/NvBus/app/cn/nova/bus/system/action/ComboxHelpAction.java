package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.HelpService;
import cn.nova.bus.system.service.impl.HelpServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class ComboxHelpAction extends BaseAction{
	private String helpType;
	private List<Map<String, Object>> datalist;

	public String query() {
	//	setDatalist(helpService.find(helpType, "",ServletPropertyFilterUtil.buildFromHttpRequest(Struts2Utils.getRequest())));
		Global global = CurrentUtil.getGlobal();
		try {
			HelpService helpService = new HelpServiceImpl();
			if (global != null && global.getUserinfo()!=null)
				datalist = helpService.find(helpType, "",ServletPropertyFilterUtil.buildFromHttpRequest(),global);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public String getHelpType() {
		return helpType;
	}

	public void setHelpType(String helpType) {
		this.helpType = helpType;
	}

	public List<Map<String, Object>> getDatalist() {
		return datalist;
	}

	public void setDatalist(List<Map<String, Object>> datalist) {
		this.datalist = datalist;
	}

}
