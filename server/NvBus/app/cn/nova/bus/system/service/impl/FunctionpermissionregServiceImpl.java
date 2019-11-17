package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.FunctionpermissionregDao;
import cn.nova.bus.system.model.Functionpermissionreg;
import cn.nova.bus.system.service.FunctionpermissionregService;
import cn.nova.utils.orm.PropertyFilter;


public class FunctionpermissionregServiceImpl implements FunctionpermissionregService {

	private FunctionpermissionregDao functionpermissionregDao = new FunctionpermissionregDao();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return getFunctionpermissionregDao().query(propertyFilters);
	}

	@Override
	public Functionpermissionreg add(Functionpermissionreg functionpermissionreg)  throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!permissionkey", functionpermissionreg.getPermissionkey()));
		List<Functionpermissionreg> functionpermissionregs = getFunctionpermissionregDao().find(Functionpermissionreg.class, propertyFilters);
		if(functionpermissionregs!=null&&functionpermissionregs.size()>0){
			throw new ServiceException("0221");
		}
		return getFunctionpermissionregDao().merge(functionpermissionreg);
	}

	@Override
	public Functionpermissionreg update(Functionpermissionreg functionpermissionreg)  throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!permissionkey", functionpermissionreg.getPermissionkey()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", functionpermissionreg.getId()));
		List<Functionpermissionreg> functionpermissionregs = getFunctionpermissionregDao().find(Functionpermissionreg.class, propertyFilters);
		if(functionpermissionregs!=null&&functionpermissionregs.size()>0){
			throw new ServiceException("0221");
		}
		return getFunctionpermissionregDao().merge(functionpermissionreg);
	}

	@Override
	public boolean delete(Functionpermissionreg functionreg) {
		return getFunctionpermissionregDao().delete(functionreg);
	}

	public void setFunctionpermissionregDao(FunctionpermissionregDao functionpermissionregDao) {
		this.functionpermissionregDao = functionpermissionregDao;
	}

	public FunctionpermissionregDao getFunctionpermissionregDao() {
		return functionpermissionregDao;
	}


}
