package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;

public interface UserService {
	public Userinfo save(Userinfo userinfo) throws ServiceException;

	public List<Userinfo> findList();

	public Userinfo findById(Long id);

	public boolean delete(Long id);

	public List<Userinfo> findList(Map<String, Object> where);

	public List<Map<String, Object>> query(Object[] fileds, String sql);

	public List<Map<String, Object>> query(Object[] fileds, String sql,
			Object[] filedtype);

	public boolean checkPassword(String name, String password);

	public boolean updatepass(Userinfo user);

	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest);
	
	/**
	 * 行包入仓员
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> queryEntrypacker(
			List<PropertyFilter> buildFromHttpRequest);
	
	public Userinfo findByCard(String cardno);

	public boolean saveticketoutlet(Userinfo user, long ticketoutlet);

}
