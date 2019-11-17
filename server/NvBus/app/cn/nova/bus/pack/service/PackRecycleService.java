package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface PackRecycleService {
	/**
	 * 根据行包单号查询
	 * @param packno
	 * @return
	 */
	public List<Map<String, Object>> getList(
			List<PropertyFilter> buildFromHttpRequest);	
	/**
	 * 对付回收
	 * @param packid
	 * @param vehicleid
	 */
	void recycle(Long packid, Long vehicleid);





}
