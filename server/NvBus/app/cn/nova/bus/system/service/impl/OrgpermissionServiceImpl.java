package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.OrgpermissionDao;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Orgpermission;
import cn.nova.bus.system.service.OrgpermissionService;
import cn.nova.utils.orm.PropertyFilter;

public class OrgpermissionServiceImpl implements OrgpermissionService{

	private OrgpermissionDao orgpermissionDao = new OrgpermissionDao();

	public void setOrgpermissionDao(OrgpermissionDao orgpermissionDao) {
		this.orgpermissionDao = orgpermissionDao;
	}

	public OrgpermissionDao getOrgpermissionDao() {
		return orgpermissionDao;
	}

	@Override
	public List<Map<String, Object>> query(long roleid) {
		return orgpermissionDao.query(roleid);
	}

	@Override
	public List<Map<String, Object>> query(long roleid,long curuserid) {
		return orgpermissionDao.query(roleid,curuserid);
	}

	@Override
	public boolean Save(List<Orgpermission> orgpermissions)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!roleid", orgpermissions.get(0).getRoleid()));
		List<Orgpermission> _orgpermissions = orgpermissionDao.find(Orgpermission.class,propertyFilters);
		for (Orgpermission orgpermission : orgpermissions) {
			boolean find = false;
			Orgpermission oldorgpermission = null;
			for (Orgpermission _orgpermission : _orgpermissions) {
				if(_orgpermission.getOrgid()==orgpermission.getOrgid()){
					find = true;
					oldorgpermission = _orgpermission;
					break;
				}
			}
			if(orgpermission.getIsselect()){
				if(!find){
					orgpermissionDao.merge(orgpermission);
				}
			}
			else{
				if(find){
					orgpermissionDao.delete(oldorgpermission);
				}
			}
		}
		return true;
	}

	@Override
	public List<Organization> queryOrgPermission(long userid) {
		return orgpermissionDao.queryOrgPermission(userid);
	}


}
