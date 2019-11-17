package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Vipbooktime;
import cn.nova.bus.balance.model.Complexfee;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;


/**
 * <b>类描述：综合收费信息设置与打印</b><br/>
 * <b>类名称：</b>ComplexfeeService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface ComplexfeeService {
	
	/**
	 * 查询已经添加的综合收费信息
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);

	/**
	 * 添加或修改综合收费信息
	 * @param Complexfee
	 * @return
	 * @throws ServiceException
	 */
	public Complexfee merge(Complexfee complexfee);
	
	/**
	 * 删除 综合收费信息
	 * @param Complexfee
	 * @return
	 */
	public boolean delete(Complexfee complexfee) ;
}
