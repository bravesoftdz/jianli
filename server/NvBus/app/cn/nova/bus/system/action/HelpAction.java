package cn.nova.bus.system.action;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.HelpService;
import cn.nova.bus.system.service.impl.HelpServiceImpl;
import cn.nova.openapi.sevice.impl.OpenApiAdapterImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class HelpAction extends BaseAction{
	private String param;
	private String helpType;
	private String cityid;
	private List<Map<String, Object>> helpmap;// 查询时返回的数据集,

	private HelpService helpService;

	public String help() {
		helpService = new HelpServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo()!=null){
				if(StringUtils.isNotEmpty(cityid) && "StationHelp".equals(helpType)){
					helpmap = new OpenApiAdapterImpl().findReachtation(cityid, param);
				}else{
					helpmap = helpService.find(helpType, param,ServletPropertyFilterUtil.buildFromHttpRequest(),global);
				}
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public String helpNoAuth() {
		try {
			helpService = new HelpServiceImpl();
				helpmap = helpService.find(helpType, param,ServletPropertyFilterUtil.buildFromHttpRequest());
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	
	public String getCityid() {
		return cityid;
	}

	public void setCityid(String cityid) {
		this.cityid = cityid;
	}

	public String getHelpType() {
		return helpType;
	}

	public void setHelpType(String helpType) {
		this.helpType = helpType;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public List<Map<String, Object>> getHelpmap() {
		return helpmap;
	}

	public void setHelpmap(List<Map<String, Object>> helpmap) {
		this.helpmap = helpmap;
	}
}
