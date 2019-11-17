package cn.nova.bus.system.service.impl;

import java.util.List;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.NovaConnectionService;
import cn.nova.utils.orm.jpa.IDAO;

public class NovaConnectionServiceImpl implements NovaConnectionService {
	
	
	private IDAO<Organization> dao = new EntityManagerDaoSurport<Organization>();

	@SuppressWarnings("unchecked")
	@Override
	public boolean connectionstatus() {
		String sql = "select d from Organization d";		
		List<Object> list=dao.find(sql);
		return list!=null && list.size()>0?true:false;
	}

}
