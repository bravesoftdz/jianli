package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface NetSaleControlService {

	List<Map<String, Object>> queryschbyrouteid(List<PropertyFilter> buildFromHttpRequest);

	MethodResult saveNetSaleControl(String scheduleidlist, String orgid, String netorgid, long routeid, String savestyle);

	List<Map<String, Object>> queryNetSaleControl(List<PropertyFilter> buildFromHttpRequest);

	boolean delNetSaleControl(long id);

}
