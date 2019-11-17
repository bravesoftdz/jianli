package cn.nova.bus.report.action;

import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.report.service.SellerTaskService;
import cn.nova.bus.report.service.impl.SellerTaskServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SellerTaskAction extends BaseAction{
	
	private List<Map<String, Object>> resultmap;
	
	public String query() {
		try {
			SellerTaskService  sellerTaskService = new SellerTaskServiceImpl();
			setResultmap(sellerTaskService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	
	
}
