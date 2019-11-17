package cn.nova.bus.checkticket.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Routechecktime;
import cn.nova.utils.orm.PropertyFilter;

public interface RoutechecktimeService {

	// 查询线路检票时间信息
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	public Routechecktime findById(Long id);
	public Long getRoutechecktimeId(Long orgid, Long routeid);
	// 保存或更新
	public Routechecktime save(Routechecktime routechecktime);
	// 删除
	public boolean delete(Long id); 
	
	public long getRoutechecktimeId(long routeid);
	
}
