package cn.nova.bus.price.service;

import java.util.Date;
import java.util.List;
import java.util.Map;


import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketoutletsprice;
import cn.nova.utils.orm.PropertyFilter;


/**
 * <b>类描述：售票点票价差额管理</b><br/>
 * <b>类名称：</b>TicketoutletspriceService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-11-01  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface TicketoutletspriceService {

	/**
	 * 主列表查询：关联查询出售票点名称
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) ;
	
	/**
	 * 子列表查询：查询出不同的站点车型，对应的售票点差额
	 * @param scheduleid
	 * @param ticketoutletsid
	 * @return
	 */
	public List<Map<String, Object>> qryTicketoutletsprice(Long scheduleid,Long ticketoutletsid);
	
	/**
	 * 编辑界面的售票点票价差额 查询功能
	 * @param ticketoutletsprice
	 * @return
	 * @throws ServiceException
	 */
	public List<Map<String, Object>> qryEdtTicketoutletPrice(Ticketoutletsprice ticketoutletsprice,String saveorupdateflag)
			throws ServiceException ;
	

	/**
	 * 保存 或修改售票点票价差设置
	 * @param ticketoutletspricelist
	 * @param iscopyvehicletype
	 * @param userid
	 * @param currticketoutlets
	 * @return
	 * @throws ServiceException
	 */
	public List<Map<String, Object>> save(List<Ticketoutletsprice> ticketoutletspricelist,
			boolean iscopyvehicletype, Long userid,Ticketoutletsprice currticketoutlets,String getDateTime) throws ServiceException ;
	
	/**
	 * 删除售票点票价差额：删除班次或线路或机构
	 * @param propertyFilterList
	 * @return
	 * @throws ServiceException
	 */

	public boolean delTicketoutletsprice(List<PropertyFilter> propertyFilterList)
	throws ServiceException;

	public List<Map<String, Object>> queryRouteinfo(List<PropertyFilter> buildFromHttpRequest) throws ServiceException;

	public List<Map<String, Object>> queryTicketoutletsRoutePriceinfo(List<PropertyFilter> buildFromHttpRequest);

	public List<Map<String, Object>> queryRouteStopinfo(List<PropertyFilter> buildFromHttpRequest, Date startdate, Date enddate, Long ticketoutletsid);

	public boolean saveTicketoutletsRoutePrice(long routeid, Date startdate, Date enddate, String station_price,
			Long ticketoutletsid, String ticketoutletsidstr);

	public boolean delTicketoutletsRoutePrice(long routeid, Date startdate, Date enddate, Long ticketoutletsid);
	
}
