package cn.nova.bus.bill.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Ticketchargeoff;

/**
 * <b>类描述：票据核销</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-8-19 下午	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface TicketChargeoffService {


	/**
	 * 查询退，废，改签，坏票 核销情况
	 * @param orgid
	 * @param userid
	 * @param begindate
	 * @param enddate
	 * @return
	 */
	public List<Map<String, Object>> queryTicketChargeoff(
			String orgid,Long userid,Date begindate,Date enddate);
	

	/**
	 * 保存核销记录
	 * @param chargeoff
	 * @return
	 */
	public boolean saveTicketChargeoff(Ticketchargeoff chargeoff) ;
}
