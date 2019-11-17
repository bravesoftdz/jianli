package cn.nova.bus.checkticket.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface PackDepartinvoicesService {

//	public boolean save(Departinvoices departinvoices);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Packdepartinvoices getById(long id);

	// 注销结算单
	public boolean cancel(Packdepartinvoices departinvoices)
			throws ServiceException;
	public List<Map<String, Object>> FindPackDepNum(Date departdate,long scheduleplanid,long scheduleid);
//
//	// 得到补开结算单的信息
//	public List<Map<String, Object>> queryResult(String isdepartinvoices,
//			Long scheduleplanid, Long departinvoicesid, long vehiclereportid);
//
//	public boolean isDepartinvoices(long scheduleplanid)
//			throws ServiceException;

	// 发班打单后又换车再打单add by lck
//	public List<Map<String, Object>> chanageDepartinvoices(Global global,
//			long scheduleplanid, long vehiclereportid, long newvehicleid,
//			String printip, String departinvoicesno,
//			boolean iscomputeno, String departtime) throws ServiceException;
//	
//	public List<Map<String, Object>> qryunchecktickets(Date departdate,long vehicleid,long scheduleid);
//	
//	public List<Map<String, Object>> qryunchecktickets(List<PropertyFilter> propertyList);
	
	// 补开结算单
//	public List<Map<String, Object>> printDepartinvoices(Global global,
//			long scheduleplanid, long vehiclereportid,
//			String ticketids,String departinvoicesno) throws ServiceException;
//	
//	// 补开站外上车的票
//	public List<Map<String, Object>> printOutDepartinvoices(Global global,
//			long vehiclereportid,String ticketids,String departinvoicesno) throws ServiceException;
//	
//	
	//结算单明细
	public List<Map<String, Object>> qryDepartDetail(
			List<PropertyFilter> propertyList);
//	//结算单修改金额
//	public Object change(String departinvoicesno);
//
//	public List<Departinvoicesdetail> findDepartinvoicesdetail(String departinvoicesno);
	
}
