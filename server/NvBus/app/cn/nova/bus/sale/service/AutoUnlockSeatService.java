/**
 * 
 */
package cn.nova.bus.sale.service;

/**
 * @author ice
 *
 */
public interface AutoUnlockSeatService {
	//开始后台解锁座位服务
	public void start(long milliseconds);

	//开始后台解锁座位服务
	public void start();
}
