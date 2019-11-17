/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.bill.service<br/>
 * <b>文件名：</b>BilltypeService.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.bill.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface BilltypeService {

	public Billtype save(Billtype billstorage) throws ServiceException;

	public Billtype findById(Long id);

	public boolean delete(Long id) throws Exception;

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Billtype findByCode(String code);

	public Long getId(String code);
	
	public  List<Map<String, Object>> queryUsableBillType();

	public List<Map<String, Object>> qryvalue(String name);

}
