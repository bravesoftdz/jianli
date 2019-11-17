package cn.nova.bus.system.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Useronline;
import cn.nova.utils.orm.PropertyFilter;

public interface UseronlineService {

	public boolean save(Useronline useronline);

	public boolean delete(Long id);

	public List<Useronline> query();

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Date getById(Long userid);

	public Useronline getByUserid(Long userid);

	public boolean logout(long userid,Global global);
	
	//已在线掉线后重新上线
	public boolean relogin(long userid,Global global);
}
