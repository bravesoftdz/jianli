package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Vipbooktime;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：VIP订票取消时间设置</b><br/>
 * <b>类名称：</b>VipbooktimeService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VipbooktimeService {

	/**
	 * 查询不同会员等级的订票时间设置
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);

	/**
	 * 添加会修改会员订票时间
	 * @param vipbooktime
	 * @return
	 * @throws ServiceException
	 */
	public Vipbooktime merge(Vipbooktime vipbooktime) throws ServiceException;
	
	/**
	 * 删除会员 不同等级的订票时间设置
	 * @param vipbooktime
	 * @return
	 */
	public boolean delete(Vipbooktime vipbooktime) ;
	
}
