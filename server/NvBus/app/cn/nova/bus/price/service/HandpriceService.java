package cn.nova.bus.price.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface HandpriceService {
	public List<Map<String, Object>> qryHandPrice(Long scheduleid)
			throws ServiceException;

	public List<Map<String, Object>> qryHandPrice(Handprice handprice)
			throws ServiceException;

	public List<Map<String, Object>> qryScheduleVehicletype(Long scheduleid,Global global);

	public List<Map<String, Object>> qryScheduleStop(Long scheduleid);

	public List<Map<String, Object>> qryScheduleStop(Long scheduleid,
			boolean isdepart);

	public List<Map<String, Object>> save(List<Handprice> handpricelist,
			boolean iscopyvehicletype, Long userid ,Handprice pHandprice) throws ServiceException;

	// 查询车辆厂牌的座位号
	public String qryScheduleSeats(Long vehiclebrandmodelid, String seattype);

	public boolean delHandPrice(List<PropertyFilter> propertyFilterList)
			throws ServiceException;// 删除硬调票价

	public boolean adjustHandprice(String adjusttype) throws ServiceException;

	public boolean copyHandprice(long scheduleid, String vehicletypeids,
			String stationids, String scheduleids, long createby)
			throws ServiceException;

	// 查询同线路的所有班次
	public List<Map<String, Object>> qrySchedules(long routeid, long scheduleid);

	// 查询班次的车型
	public List<Map<String, Object>> qrySchedulevehicletype(long scheduleid);

	// 查询班次的停靠点
	public List<Map<String, Object>> qrySchedulestation(long scheduleid);

	// 查询票价分项信息
	public List<Map<String, Object>> qryHandpriceitem(long handpriceid,
			String tickettype);

	// 保存票价分项信息
	public List<Map<String, Object>> saveHandpriceitem(
			List<Handpriceitem> handpriceitemlist, long userid,
			boolean iscopyothersch) throws ServiceException;

	// 复制始发站票价到配客站点上
	public boolean copyHandpricetoStatioin(long scheduleid, long updateby)
			throws ServiceException;

	/**
	 * @param enddate 
	 * @param fromdate 
	 * 
	 * saveTicketpriceItem方法：保存执行票价票价分项的值<br/>
	 * <br/>
	 * 
	 * @param ticketpriceitemlist
	 * @param userid
	 * @param iscopyothersch
	 *            是否复制到本线路其他班次的相同停靠点去
	 * @return
	 * @throws ServiceException
	 * @exception
	 */
	public List<Map<String, Object>> saveTicketpriceItem(
			List<Ticketpriceitem> ticketpriceitemlist, long userid,
			boolean iscopyothersch, Date fromdate, Date enddate) throws ServiceException;

	/**
	 * 
	 * saveStationPrice方法：设置站点票价<br/>
	 * <br/>
	 * 
	 * @param adjusttype
	 * @param optype
	 * @param departstationids
	 * @param scheduleids
	 * @param handprice
	 * @return
	 * @throws ServiceException
	 * @exception
	 */
	public boolean saveStationPrice(String adjusttype,String departstationids, String scheduleids, Handprice handprice)
			throws ServiceException;
	
	public List<Map<String, Object>> qrySameStations(String departstationids,
			long reachstationid) 	throws ServiceException;

}
