package cn.nova.bus.bill.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.dao.BillinventoryDao;
import cn.nova.bus.bill.dao.BillstorageDao;
import cn.nova.bus.bill.model.Billstorage;
import cn.nova.bus.bill.service.BillstorageService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author 蒋伟
 * 
 */

public class BillstorageServiceImpl implements BillstorageService {

	private BillstorageDao dao = new BillstorageDao();

	private BillinventoryDao inventoryDao = new BillinventoryDao();

	@Override
	public Billstorage save(Billstorage billstorage) throws ServiceException {
		if (billstorage.getId() <= 0) {
			if (getById("name", billstorage.getName(), null) != 0) {
				long billid = getById("name", billstorage.getName(), "0");
				if (billid > 0) {
					getBillstorage(billstorage, billid);
				} else {
					throw new ServiceException("0251");
				}
			}
			if (getById("code", billstorage.getCode(), null) != 0) {
				long billid = getById("code", billstorage.getCode(), "0");
				if (billid > 0) {
					getBillstorage(billstorage, billid);
				} else {
					throw new ServiceException("0252");
				}
			}
			return dao.merge(billstorage);
		} else {
			if (getById("name", billstorage.getName(), null) != 0) {
				if (billstorage.getId() != getById("name",
						billstorage.getName(), null)) {
					throw new ServiceException("0251");
				}
			}
			if (getById("code", billstorage.getCode(), null) != 0) {
				if (billstorage.getId() != getById("code",
						billstorage.getCode(), null)) {
					throw new ServiceException("0252");
				}
			}
			return dao.merge(billstorage);
		}
	}

	private void getBillstorage(Billstorage billstorage, long billid) {
		Billstorage storage = findById(billid);
		billstorage.setId(storage.getId());
		billstorage.setIsactive(true);
	}

	private long getById(String name, String value, String isactive) {
		return dao.getByid(name, value, isactive);
	}

	@Override
	public Billstorage findById(Long id) {
		return dao.get(Billstorage.class, id);
	}

	@Override
	public boolean delete(Long id) throws Exception {
//		String inusesql = "select (case b.availableenno when 0 then 0 else (b.availableenno-b.availablestartno+1) end)  as availablecount from Billinventory b where b.storageid='"
//				+ id + "'";
		String inusesql = "select r from Billinventory r where ( r.availablestartno<> 0 and r.availablestartno<>0) and r.isactive=1 and  "
				+ "r.storageid='"+ id + "'";
		@SuppressWarnings("rawtypes")
		List list = inventoryDao.find(inusesql);
		if (list.size() > 0) {
//		if ((Integer) list.get(0) > 0) {
			throw new Exception("该票库信息已被使用，不能删除 ");
		}
		Billstorage billstorage = findById(id);
		billstorage.setIsactive(false);
		return dao.update(billstorage);

	}

	@Override
	public List<Map<String, Object>> query(Object[] fileds, String sql) {
		// dao.find(clz, map)
		return null;
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Billstorage.class, "orgname",
				"createname" }, dao.query(propertyFilterList), new Object[] {
				Billstorage.class, String.class, String.class });
	}

}
