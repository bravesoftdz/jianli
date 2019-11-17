/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.bill.service.impl<br/>
 * <b>文件名：</b>BilltypeServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.bill.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.dao.BillinventoryDao;
import cn.nova.bus.bill.dao.BilltypeDao;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class BilltypeServiceImpl implements BilltypeService {
	
	private BilltypeDao dao = new BilltypeDao();
	
	private BillinventoryDao inventoryDao = new BillinventoryDao();

	@Override
	public Billtype save(Billtype billtype) throws ServiceException {
		if (billtype.getId() <= 0) {
			if (isExistName(billtype.getName(), null) != null) {
				Billtype type = isExistName(billtype.getName(), "0");
				if (type != null) {
					getBilltype(billtype, type);
				}
				throw new ServiceException("0273");
			}
			if (isExistCode(billtype.getCode(), null) != null) {
				Billtype type = isExistCode(billtype.getCode(), "0");
				if (type != null) {
					getBilltype(billtype, type);
				}
				throw new ServiceException("0274");
			}
			return dao.merge(billtype);
		} else {
			return dao.merge(billtype);
		}
	}

	private void getBilltype(Billtype billtype, Billtype type) {
		billtype.setCode(type.getCode());
		billtype.setName(type.getName());
		billtype.setId(type.getId());
		billtype.setIsactive(true);
	}

	private Billtype isExistCode(String code, String string) {
		return dao.getBilltypeByCode(code, string);
	}

	private Billtype isExistName(String name, String value) {
		return dao.getBilltypeByName(name, value);
	}

	@Override
	public Billtype findById(Long id) {
		return dao.get(Billtype.class, id);
	}

	@SuppressWarnings("rawtypes")
	public boolean delete(Long id) throws Exception {
		String inusesql = "select r from Billinventory r where r.billtypeid='"
				+ id + "'";
		List list = inventoryDao.find(inusesql);
		if (list.size() > 0) {
			throw new Exception("该票据类型已被使用，不能删除 ");
		}
		Billtype billtype = findById(id);
		billtype.setIsactive(false);
		return dao.update(billtype);

	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Billtype.class },
				dao.query(propertyFilterList), new Object[] { Billtype.class });
	}

	@Override
	public Billtype findByCode(String code) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!code", code));
		return (Billtype) dao.uniqueResult(Billtype.class, propertyFilters);
	}

	@Override
	public Long getId(String code) {
		return dao.getIdByCode(code);
	}

	@Override
	public List<Map<String, Object>> queryUsableBillType() {
		return ListUtil.listToMap(new Object[] { "id", "code", "name", "ticketnolength" },
				dao.queryUsableBillType(), new Object[] { Long.class, String.class, String.class,
			Long.class });
	}
	@Override
	public List<Map<String, Object>> qryvalue(String name) {
		return ListUtil.listToMap(new Object[] { "parvalue" },
				dao.qryvalue(name), new Object[] { String.class});
	}

}
