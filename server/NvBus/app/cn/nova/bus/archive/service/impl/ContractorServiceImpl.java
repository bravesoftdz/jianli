package cn.nova.bus.archive.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.ContractorDao;
import cn.nova.bus.archive.model.Contractor;
import cn.nova.bus.archive.service.ContractorService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

public class ContractorServiceImpl implements ContractorService {

	private IDAO<Contractor> dao = new EntityManagerDaoSurport<Contractor>();

	private ContractorDao contractorDao = new ContractorDao();

	@Override
	public Contractor saveContractor(Contractor contractor)
			throws ServiceException {
		// 查找出所有的合同编码，严重编码是否唯一
		List<Contractor> existContractno = contractorDao
				.getContractor(contractor.getContractno());
		if (existContractno != null) {
			for (int j = 0; j < existContractno.size(); j++) {
				Contractor no = existContractno.get(j);
				if (contractor.getId() == 0 || no.getId() != contractor.getId()) {
					throw new ServiceException("0267");
				}
			}
		}
		// 判断在合同期内 承包车 是否已经被其他人承包
		List<Object> contranctorlist = contractorDao
				.isExistContractor(contractor);
		Contractor c = null;
		for (int i = 0; i < contranctorlist.size(); i++) {
			c = (Contractor) contranctorlist.get(i);
			if (c != null && contractor.getId() == 0) {
				throw new ServiceException("0266");
			}
			if (c != null && c.getId() != contractor.getId()) {
				throw new ServiceException("0266");
			}
		}
		if (contractor.getId() != 0) {
			Contractor cont = dao.get(Contractor.class, contractor.getId());
			contractor.setSynccode(cont.getSynccode());
		}
		return dao.merge(contractor);
	}

	@Override
	public Boolean delContractor(long id) {
		return contractorDao.updateByid(id);
	}

	@Override
	public List<Map<String, Object>> queryContractor(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Contractor.class, "orgname", "vehiclename",
				"createname", "updatename" };// 初始化要查询的字段
		Object[] filedtypes = { Contractor.class, String.class, String.class,
				String.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				contractorDao.queryContractor(propertyFilterList), filedtypes);

	}

}
