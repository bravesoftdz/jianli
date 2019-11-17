package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packarriver;
import cn.nova.utils.orm.PropertyFilter;

public interface PackWarehousingService {
	/**
	 * 查询到货入仓
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);
	/**
	 * 到货入仓,保存  行包单号和行包收讫单号
	 * @return
	 * @throws ServiceException
	 */
	public Packarriver savePackWarehousing(Pack pack , Packarriver packarriver) throws ServiceException; 
	public Pack savePackWarehousing(Pack pack) throws ServiceException;
	/**
	 * 根据条件查询行包单号
	 * @param param
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryPackno(String param,List<PropertyFilter> propertyFilters);
	
	/**
	 * 条码扫描星行包单号修改其状态为入库状态
	 * @param param
	 * @param propertyFilters
	 * @return
	 */
	public int packnoUpStatus(Pack pack) throws ServiceException;
	/**
	 * 重打受理单时新添加一条记录同时把重打的数据改为废弃状态
	 * @param packid
	 * @param userinfoid
	 * @return
	 * @throws ServiceException
	 */
	public Packarriver whackpack(Packarriver packarriver)throws ServiceException;
}
