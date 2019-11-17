package cn.nova.bus.system.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.RoleDao;
import cn.nova.bus.system.model.Role;
import cn.nova.bus.system.service.RoleService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class RoleServiceImpl implements RoleService {

	
	private IDAO<Role> dao = new EntityManagerDaoSurport<Role>();

	
	private RoleDao roleDao = new RoleDao();

	public Role save(Role role) throws ServiceException {
		if (roleDao.isExistRole(role)) {
			throw new ServiceException("0106");
		}
		if (role.getId() == 0) {
			role.setCreatetime(new Date());
			role.setUpdatetime(new Date());
		} else {
			role.setUpdatetime(new Date());
		}
		return dao.merge(role);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Role.class, "orgname",
				"createname", "updatename" },
				roleDao.queryRole(propertyFilterList), new Object[] {
						Role.class, String.class, String.class, String.class });
	}

	@Override
	public boolean delete(Role role) throws ServiceException {
		if (roleDao.isUseRole(role)) {
			throw new ServiceException("0107");
		} else if (roleDao.isApplOrgpermission(role.getId())) {
			throw new ServiceException("0107");
		} else if (roleDao.isApplyMenupermission(role.getId())) {
			throw new ServiceException("0107");
		}
		dao.delete(dao.get(Role.class, role.getId()));
		return true;
	}

	@Override
	public List<Role> query(long userid) {
		return roleDao.qryRole(userid);
	}

	@Override
	public List<Map<String, Object>> queryroles(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { Role.class, "orgname",
				"createname", "updatename" },
				roleDao.query(buildFromHttpRequest), new Object[] { Role.class,
						String.class, String.class, String.class });
	}

	@Override
	public List<Role> querybyid(long id) {
		return roleDao.qryRolebyid(id);
	}

	@Override
	public boolean qryuser(long roleid) {
		return roleDao.qryUser(roleid);
	}

}
