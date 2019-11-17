package cn.nova.bus.insure.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.InsuranceOrder;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface InsuranceSellService { 
	
	public MethodResult sell(InsuranceOrder order,int isnet);

	public List<Map<String, Object>> findTicket(List<PropertyFilter> propertyFilters,int isnet);

	/**
	 * 九江模式预售保险 
	 * @param ticketno
	 * @param certificateno
	 * @param customername
	 * @param insuranceno
	 * @param insuretypecode
	 * @return
	 */
	public MethodResult JJPreSell(String ticketno,String certificateno,String customername,String insuranceno,String insuretypecode);
	/**
	 * 九江模式打印保单成功，更新保单号
	 * @param insuranceno
	 * @param polnumber
	 * @return
	 */
	public MethodResult JJSellCommit(String insuranceno,String polnumber,String bkserial,String validatecode);
	/**
	 * 九江模式打印保单失败，取消售保险
	 * @param insuranceno
	 * @return
	 */
	public MethodResult JJSellRollback(String insuranceno);
	
	/**
	 * 
	 * uploadInsurance方法：上报保险数据<br/>
	 * <br/> 
	 * @exception
	 */
	public void uploadInsurance() ;
	/**
	 * bus365保险服务器售保险
	 * @return 
	 */
	public void autoPlatformSellInsurance();
	/**
	 * bus365保险服务器保险产品同步
	 */
	public void syncPlatformInsureType();
	
	/**
	 * bus365保险服务器退保险
	 */
	public void autoPlatformReturnInsurance();
	/**
	 * 当前机构是否可以售平台保险
	 * @param param2626
	 * @return
	 */
	public String findParamValue(String param2626);
	
	//换票号重打
	public  boolean changenoreprint(long oldinsuranceid,String insuranceno,Global global)  throws ServiceException;
}
