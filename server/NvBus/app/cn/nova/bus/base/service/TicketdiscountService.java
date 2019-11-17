/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service<br/>
 * <b>文件名：</b>TicketdiscountService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-1-9 上午10:13:33<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>TicketdiscountService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-1-9 上午10:13:33<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface TicketdiscountService {

	/**
	 * @param ticketdiscount
	 * @param global
	 */
	public Ticketdiscount save(Ticketdiscount ticketdiscount, Global global)
			throws ServiceException;

	/**
	 * @param id
	 * @return
	 */
	public boolean delete(long id);

	/**
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest);

}
