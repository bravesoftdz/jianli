package cn.nova.bus.checkticket.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface DepartinvoicesdetailService {

	public boolean save(Departinvoicesdetail departinvoicesdetail);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public List<Departinvoicesdetail> getResult(Long scheduleplanid);

	public Departinvoicesdetail getDepartinvoicesdetail(Long id);
	
	public List<Map<String,Object>> qrydeailBydepartinvoicesid(long departinvoicesid);
	
	public Long savedetail(Departinvoicesdetail detail) throws ServiceException;
	

}
