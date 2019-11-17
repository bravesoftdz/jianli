/**
 * 
 */
package cn.nova.bus.dispatch.service;

import cn.nova.bus.dispatch.exception.WSException;

/**
 * 半自动报班，客户端刷卡后列出班次，驾驶员选择班次后报到
 * @author ice
 * 
 */
public interface ICAutoReportService {
	
	public boolean autoReport(String cardno,long scheduleplanid,long departstationid) throws WSException;

}
