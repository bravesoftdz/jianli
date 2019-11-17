package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.MenupermissionDao;
import cn.nova.bus.system.model.Menupermission;
import cn.nova.bus.system.service.MenupermissionService;
import cn.nova.utils.orm.PropertyFilter;


public class MenupermissionServiceImpl implements MenupermissionService{

	private MenupermissionDao menupermissionDao = new MenupermissionDao();

	@Override
	public List<Map<String, Object>> query(long roleid) {
		return getMenupermissionDao().query(roleid);
	}

	@Override
	public List<Map<String, Object>> queryByUserid(long userid) {
		return getMenupermissionDao().queryByUserid(userid);
	}

	@Override
	public boolean Save(List<Menupermission> menupermissions)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!roleid", menupermissions.get(0).getRoleid()));
		List<Menupermission> _menupermissions = menupermissionDao.find(Menupermission.class,propertyFilters);
		for (Menupermission menupermission : menupermissions) {
			boolean find = false;
			Menupermission oldmenupermission = null;
			for (Menupermission _menupermission : _menupermissions) {
				if(_menupermission.getMenuid()==menupermission.getMenuid()
					&&_menupermission.getType()==menupermission.getType()
					&&(_menupermission.getType()==0
					   || _menupermission.getFunctionpermissionregid().equals(menupermission.getFunctionpermissionregid())
					  )
				){
					find = true;
					oldmenupermission = _menupermission;
					break;
				}
			}
			if(menupermission.getIsselect()){
				if(!find){
					menupermissionDao.merge(menupermission);
				}
			}
			else{
				if(find){
					menupermissionDao.delete(oldmenupermission);
				}
			}
		}
		return true;
	}

	public void setMenupermissionDao(MenupermissionDao menupermissionDao) {
		this.menupermissionDao = menupermissionDao;
	}

	public MenupermissionDao getMenupermissionDao() {
		return menupermissionDao;
	}

	@Override
	public boolean Save(Global global, Date now, String menuids, String functionpermissionregids, long roleid) {
		String[] menuid = menuids.split(",");
		String[] functionpermissionregid = functionpermissionregids.split(",");
		long userid = global.getUserinfo().getId();
		menupermissionDao.deleteAll(roleid);
		for(int i=0;i<menuid.length;i++){
			Menupermission m = new Menupermission();
			m.setMenuid(Long.parseLong(menuid[i]));
			m.setRoleid(roleid);
			m.setFunctionpermissionregid(Long.parseLong(functionpermissionregid[i]));
			if(Long.parseLong(functionpermissionregid[i])>0){
				m.setType((byte)1);
			}else{
				m.setType((byte)0);
			}
			m.setCreateby(userid);
			m.setCreatetime(now);
			menupermissionDao.merge(m);
		}
		return true;
	}
	
}
