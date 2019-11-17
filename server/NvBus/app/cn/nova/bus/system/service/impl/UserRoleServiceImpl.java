package cn.nova.bus.system.service.impl;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Userrole;
import cn.nova.bus.system.service.UserRoleService;
import cn.nova.utils.orm.jpa.IDAO;

public class UserRoleServiceImpl implements UserRoleService {

	private IDAO<Userrole> dao = new EntityManagerDaoSurport<Userrole>();
	@Override
	public boolean save(Userrole userrole) {
		return dao.save(userrole);
	}

	@Override
	public boolean delete(long id) {
		String sql="delete from Userrole ur where ur.userid="+id;
		dao.execute(sql);
		return true;
	}

}
