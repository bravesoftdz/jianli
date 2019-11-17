package cn.nova.bus.log.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.log.dao.OperationlogDao;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;



public class OperationLogServiceImpl implements OperationLogService {


	public IDAO<Operationlog> dao = new EntityManagerDaoSurport<Operationlog>();
	
	private OperationlogDao operationdao = new OperationlogDao();
	@Override
	public boolean savelog(Operationlog operationLog) {
		if (operationLog.getId()>0) {
			return dao.update(operationLog);
		}else{
			return dao.save(operationLog);
		}
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return  ListUtil.listToMap(new Object[] {Operationlog.class,"username"}, operationdao.query(propertyFilterList),
				new Object[] {Operationlog.class,String.class });
	}

}
