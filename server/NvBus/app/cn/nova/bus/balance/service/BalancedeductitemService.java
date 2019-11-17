package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balancedeductitemdistance;
import cn.nova.bus.balance.model.Balancedeductitemprice;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface BalancedeductitemService {

	public List<Map<String, Object>> qryDeductitem(
			List<PropertyFilter> propertyFilterList, long balancedeductitemid);

	public Balancedeductitem saveDeductitem(Balancedeductitem balancedeductitem)
			throws ServiceException;
	
	//保存行包扣费项目
	public Balancedeductitem savePackDuctitem(long  createby,long orgid);

	public boolean delDeductitem(Balancedeductitem balancedeductitem)
			throws ServiceException;

	public List<Map<String, Object>> createTree(long orgid);

	public List<Map<String, Object>> qryDeductitemdetail(
			long balancedeductitemid);

	public Balancedeductitemdistance saveDeductitemdistance(
			Balancedeductitemdistance balancedeductitemdistance)
			throws ServiceException;

	public boolean delaboutDistance(long id) throws ServiceException;

	public Balancedeductitemprice saveBalancedeductitemprice(
			Balancedeductitemprice balancedeductitemprice)
			throws ServiceException;

	public boolean delaboutPrice(long id) throws ServiceException;
	
	public Balancedeductitem qryBalancedeductitem(Balancedeductitem balancedeductitem);
}
