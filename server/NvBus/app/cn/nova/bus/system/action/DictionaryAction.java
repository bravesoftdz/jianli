package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.service.DictionaryService;
import cn.nova.bus.system.service.impl.DictionaryServiceImpl;

public class DictionaryAction extends BaseAction{
	private String tablename;

	private String columnname;
	private String code;
	private List<Map<String, Object>> diclist;

	private DictionaryService dictionaryService;

	public String query() {
		//用于测试，先去掉判断
		dictionaryService = new DictionaryServiceImpl();
		diclist = dictionaryService.find(tablename, columnname, code);
		/*
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserID() > 0)
				diclist = dictionaryService.find(tablename, columnname, code);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}*/
		return "json";
	}
	
	public String queryCheckcombox() {
		//用于测试，先去掉判断
		try {
			dictionaryService = new DictionaryServiceImpl();
			diclist = dictionaryService.getCheckcombox(tablename, columnname);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String getTablename() {
		return tablename;
	}

	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

	public String getColumnname() {
		return columnname;
	}

	public void setColumnname(String columnname) {
		this.columnname = columnname;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<Map<String, Object>> getDiclist() {
		return diclist;
	}

	public void setDiclist(List<Map<String, Object>> diclist) {
		this.diclist = diclist;
	}
}
