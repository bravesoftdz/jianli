package cn.nova.bus.query.action;

import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.query.service.QuerySpecialOrderInfoService;
import cn.nova.bus.query.service.impl.QuerySpecialOrderInfoServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class QuerySpecialOrderInfoAction extends BaseAction{
	/**
	 * 特殊订单退款明细
	 * @param propertyFilterList
	 * @return
	 */
	private List<Map<String,Object>>  resultmap;
	public QuerySpecialOrderInfoService querySpecialOrderInfoService;
	
	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}
	
	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	
	public String querySpecialOrderInfo(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			querySpecialOrderInfoService = new QuerySpecialOrderInfoServiceImpl();
			setResultmap(querySpecialOrderInfoService.querySpecialOrderInfo(propertyFilterList));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
}
