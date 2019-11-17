package cn.nova.bus.checkticket.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface DepartinvoicesManagerService {

	public boolean save(Departinvoices departinvoices);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Departinvoices getById(long id);

	// 注销结算单
	public boolean cancel(Departinvoices departinvoices,Global global)
			throws ServiceException;

	// 得到补开结算单的信息
	public List<Map<String, Object>> queryResult(String isdepartinvoices,
			Long scheduleplanid, Long departinvoicesid, long vehiclereportid);

	public boolean isDepartinvoices(long scheduleplanid)
			throws ServiceException;

	// 发班打单后又换车再打单add by lck
	public List<Map<String, Object>> chanageDepartinvoices(Global global,
			long scheduleplanid, long vehiclereportid, long newvehicleid,
			String printip, String departinvoicesno,
			boolean iscomputeno) throws ServiceException, ParseException;
	
	public List<Map<String, Object>> qryunchecktickets(Date departdate,long vehicleid,String batchno,String ticketno,String schedulecode,String departtime);
	
	
	// 补开结算单
	public List<Map<String, Object>> printDepartinvoices(Global global,
			long scheduleplanid, long vehiclereportid,
			String ticketids,String departinvoicesno) throws ServiceException, ParseException;

	public String qryvehisecuresult(Long vehiclereportid);

	/**
	 * 获取一个班次的所有结算单
	 * @param scheduleplanid
	 * @return
	 */
	public List<Departinvoices> queryDepartInvoicesBySchedulePlanId (
			long scheduleplanid) throws ServiceException;

	/**
	 * 将此结算单关联的违规罚金查出来，并将结算单ID更新为空，并且将“已打单”状态更新为“未结算”；
	 * @param departinvoicesid
	 */
	public void updateVehicleviolation(long departinvoicesid);

	/**
	 * 根据车辆id,查询车辆的报到记录
	 * @param vehicleid
	 * @param departdate
	 * @return
	 */
	public List<Map<String, Object>> qryVehicleReport(long vehicleid,
			Date departdate,long scheduleplanid);
	
	//查询异常班次信息
	public List<Map<String, Object>> qryNonomalSch(long stationid);
		
	public List<Map<String, Object>> qryNonomalSchadd(Global global);
	
	public List<Map<String, Object>> qryTicketsellsByVehicle(Date departdate,long vehiclereportid,long scheduleplanid,String departinvoicesno);	

	//查询结算单信息 
	public List<Map<String, Object>> qryDepartinvoices(Date departdate,long vehicleid,long printorgid,Date departdateend);
	//查询车辆在当前机构的报班班次
	public List<Map<String, Object>> qryReportSchs(Date departdate,long vehicleid,long orgid);
		
}
