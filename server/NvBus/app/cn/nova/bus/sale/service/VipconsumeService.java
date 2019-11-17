/**
 * 
 */
package cn.nova.bus.sale.service;

import cn.nova.bus.archive.model.Vip;

/**
 * @author ice
 *
 */
public interface VipconsumeService {
	
	/**
	 * 根据消费记录查询VIP信息
	 * @param consumeType 消费类型
	 * @param isselfschedule
	 * @param sellid
	 * @return
	 */
	public Vip getConsumeVip(boolean isselfschedule,long sellid);

}
