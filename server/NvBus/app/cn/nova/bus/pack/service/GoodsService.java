package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Goods;
import cn.nova.utils.orm.PropertyFilter;

public interface GoodsService {
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) ;
	public Goods saveGoods(Goods goods) throws ServiceException ;
	/**
	 * 作废
	 * @param goods
	 * @return
	 * @throws ServiceException
	 */
	public boolean wasteGoods(Goods goods) throws ServiceException; 
	
	/**
	 * 查找寄存单号
	 * @param param
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryGgoodsno(String param,List<PropertyFilter> propertyFilters);
	
	/**
	 * 上传图片
	 */
	public String uploadGoodsPicture(String picture);
	
	/**
	 * 小件寄存修改的时候获取图片
	 * @param id
	 */
	public String downloadGoodsPicture(long id); 
}
