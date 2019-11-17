package cn.nova.bus.system.service;

import cn.nova.bus.system.model.Userrole;

public interface UserRoleService {
	boolean save(Userrole userrole);

	boolean delete(long id);

}
