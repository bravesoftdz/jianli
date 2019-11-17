package cn.nova.bus.sale.service;

import java.math.BigDecimal;

import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.sale.model.Ticketsell;

/**
 * <b>类名称：</b>TicketpriceReturnService <br/>
 * <b>类描述：</b>原路退款 Service <br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2018年6月13日 上午9:06:54<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
  * <b>任务号：</b>2018年6月13日 上午9:06:54<br/>
 */

public interface TicketpriceReturnService {
	
	/**
	 * @Title returnTickets
	 * @Description 原路退款(不更改车票状态、营收...仅在 TicketpriceReturn 增加数据供线上退款使用)
	 * @param ticketsellids 原路退款车票 IDS 字符串 (,分隔) 
	 * @param remark 原路退款原因
	 * @param totalticketnum 原路退款车票张数
	 * @param totalinsurancenum 原路退款保险张数
	 * @param totalticketmoney 原路退款车票金额
	 * @param totalinsurancemoney 原路退款保险金额
	 * void 
	 * @author tianhb
	 * @date 2018年6月13日-下午2:22:37
	 * @update 
	 * @throws
	 */
	public void returnTickets(String ticketsellids, String remark, Integer totalticketnum,
			Integer totalinsurancenum, BigDecimal totalticketmoney, BigDecimal totalinsurancemoney) throws BusinessException;
	
	/**
	 * @Title isCanReturnBack
	 * @Description 根据车票判断该车票是否可以执行原路退款操作(不判断 3 天之内，供退票使用)
	 * @param ts
	 * @return Boolean 
	 * @author tianhb
	 * @date 2018年6月14日-上午10:30:17
	 * @update 
	 * @throws
	 */
	public Boolean isCanReturnBack(Ticketsell ts);
	
	/**
	 * @Title isExistTicketpriceReturn
	 * @Description 根据 车票 ID 判断是否存在原路退款数据
	 * @param sellid
	 * @return Boolean TRUE:存在，FALSE:不存在
	 * @author tianhb
	 * @date 2018年6月13日-下午3:50:34
	 * @update 
	 * @throws
	 */
	public Boolean isExistTicketpriceReturn(Long sellid);
}
