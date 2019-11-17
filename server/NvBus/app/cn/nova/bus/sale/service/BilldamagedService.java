package cn.nova.bus.sale.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface BilldamagedService {

	/**
	 * 坏票登记
	 * @param billdamaged
	 * @param recipients
	 * @return
	 * @throws ServiceException
	 */
	public boolean save(Billdamaged billdamaged, long recipients) throws ServiceException;

	public boolean delete(Billdamaged billdamaged);

	public boolean delete(Long id) throws ServiceException;

	public List<Billdamaged> query();

	public Billdamaged getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public MethodResult saveOnedamaged(Billdamaged billdamaged, Long recipients);

}
