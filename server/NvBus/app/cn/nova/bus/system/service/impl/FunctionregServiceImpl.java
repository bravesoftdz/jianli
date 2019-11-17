package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.FunctionpermissionregDao;
import cn.nova.bus.system.dao.FunctionregDao;
import cn.nova.bus.system.model.Functionpermissionreg;
import cn.nova.bus.system.model.Functionreg;
import cn.nova.bus.system.service.FunctionregService;
import cn.nova.utils.orm.PropertyFilter;


public class FunctionregServiceImpl implements FunctionregService {
	
	private FunctionregDao functionregDao = new FunctionregDao();
	
	private FunctionpermissionregDao functionpermissionregDao = new FunctionpermissionregDao();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return functionregDao.query(propertyFilters);
	}

	@Override
	public Functionreg add(Functionreg functionreg)  throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!name", functionreg.getName()));
		List<Functionreg> functionregs = functionregDao.find(Functionreg.class, propertyFilters);
		if(functionregs!=null&&functionregs.size()>0){
			throw new ServiceException("0219");
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!functionkey", functionreg.getFunctionkey()));
		functionregs = functionregDao.find(Functionreg.class, propertyFilters);
		if(functionregs!=null&&functionregs.size()>0){
			throw new ServiceException("0220");
		}
		return functionregDao.merge(functionreg);
	}

	@Override
	public Functionreg update(Functionreg functionreg)  throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!name", functionreg.getName()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", functionreg.getId()));
		List<Functionreg> functionregs = functionregDao.find(Functionreg.class, propertyFilters);
		if(functionregs!=null&&functionregs.size()>0){
			throw new ServiceException("0219");
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!functionkey", functionreg.getFunctionkey()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", functionreg.getId()));
		functionregs = functionregDao.find(Functionreg.class, propertyFilters);
		if(functionregs!=null&&functionregs.size()>0){
			throw new ServiceException("0220");
		}
		return functionregDao.merge(functionreg);
	}

	@Override
	public boolean delete(Functionreg functionreg) throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!functionregid", functionreg.getId()));
		List<Functionpermissionreg> functionpermissionregs = functionpermissionregDao.find(Functionpermissionreg.class, propertyFilters);
		if(functionpermissionregs!=null&&functionpermissionregs.size()>0){
			throw new ServiceException("0222");
		}
		return functionregDao.delete(functionreg);
	}

	public void setFunctionregDao(FunctionregDao functionregDao) {
		this.functionregDao = functionregDao;
	}

	public FunctionregDao getFunctionregDao() {
		return functionregDao;
	}

	@Override
	public List<Map<String, Object>> qryFuncByKey(String key) {	
		return functionregDao.qryInstruction(key);
	}

}
