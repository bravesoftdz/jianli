package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.ClientDao;
import cn.nova.bus.pack.model.Client;
import cn.nova.bus.pack.service.ClientService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;



public class ClientServiceImpl implements ClientService {

	
	private ClientDao clientdao = new ClientDao();
	
	@SuppressWarnings("unchecked")
	@Override
	public Client saveClient(Client client) throws ServiceException  {
		
		if (client.getId() == 0) {
			clientdao.save(client);
		} else {
			clientdao.getEntityManager().merge(client);
		}
		return client;
	}
	
	

	@Override
	public Boolean delClient(long id) {
		return clientdao.update(id);
	}

	@Override
	public List<Map<String, Object>> queryClient(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = {Client.class,"orgname","createname","updatename"};
		Object[] filedtypes = { 
				Client.class,String.class,String.class,String.class};
	return ListUtil.listToMap(fileds, clientdao.queryClient(propertyFilterList),filedtypes);	
	}



	@Override
	public Boolean updateClientIntegrater(long id, long integrater)
			throws ServiceException {
		return clientdao.updateClientIntegrater(id,integrater);
	}



	@Override
	public Boolean updateClientIntegrater(long id, BigDecimal price)
			throws ServiceException {
		return clientdao.updateClientIntegrater(id,price);
	}
	
	
	
}
