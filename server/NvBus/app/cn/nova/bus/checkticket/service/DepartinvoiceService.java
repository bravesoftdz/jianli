package cn.nova.bus.checkticket.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.service.impl.DepartinvoiceServiceImpl;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public interface DepartinvoiceService {

	// 车辆发班操作,返回结算单主表打印信息
	/*
	public DepartinvoicesVo vehicleDepartinvoice(long departstationid,
			long scheduleplanid, long vehiclereportid,
			String printip, long createdby,String departinvoicesno,String printlway) throws ServiceException;
	*/
	//只发班、不打印，只修改班次状态
	public boolean schDepartinvoice(Global global,long scheduleplanid, long vehiclereportid) throws ServiceException;
    
	
	// 车辆发班操作,返回结算单主表打印信息,
	//包含手动单:只保存数据不打印，微机单
	public List<Map<String, Object>> schDepartinvoice(Global global,
			long scheduleplanid, long vehiclereportid,
			String printip,String departinvoicesno,
			String printway,boolean iscomputeno) throws ServiceException, ParseException;
	
	// 查询打印远检票的机构
	//public List<Map<String, Object>> qryRemoteTickOrgid(long scheduleplanid,long vehiclereportid);
	//打印远检票
	
    //重打结算单
	public List<Map<String, Object>> reprintDepartinvoice(long departstationid,
			long scheduleplanid, long vehiclereportid,
			String printip, long createdby,String departinvoicesno,boolean isprintbynewticketno) throws ServiceException;
	//自助打单重打结算单
	public List<Map<String, Object>> reprintDepartinvoice(long departstationid,
				long scheduleplanid, long vehiclereportid,
				String printip, long createdby,String departinvoicesno,boolean isprintbynewticketno, String originaldepartinvoicesno) throws ServiceException;
		
	// 查询结算单主表打印信息
	public List<Map<String, Object>> qryInvoicePrintInfo(long departinvoicesid);

	// 查询结算单明细打印信息
	public List<Map<String, Object>> qryInvoicesDetailPrintInfo(
			long departinvoicesid);
	
	// 查询结算单明细打印信息->作为路单打印信息
	public List<Map<String, Object>> qryInvoicesDetailtoRoadbill(
			long scheduleplanid);

	public boolean save(Departinvoices departinvoices);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public boolean delete(long id);

	// 补开结算单
	public List<Map<String, Object>> printDepartinvoices(Global global,
			long scheduleplanid, long vehiclereportid,
			String printip,String departinvoicesno) throws ServiceException, ParseException;
	
	//取消发班
	public boolean cancelDepartinvoices(long departstationid, long scheduleplanid,
			long vehiclereportid, long cancelby) throws ServiceException;
	
	//他站售票情况，打印在运量单上
	public String getOthersellmessage(long departinvoicesid,Date departdate);
	
	public Departinvoices findDepartinvoice(long vehiclereportid,Date departdate,long scheduleplanid,long scheduleid);
	
	public List<Map<String, Object>> queryFirstCheck(Long scheduleplanid, Long departstationid, Long vehiclereportid, boolean islinework,Long firstcheckid);
	
	
	//新增判断报到车辆最后一次按键是否合格
	public boolean isSecurityQualify(long vehiclereportid);
	//通过车牌号和发车日期
//	public boolean isSecurityQualify(long vehicleid,Date departdate);


	public List<Map<String, Object>> qryBalancedetailPrint(long balanceid);
	
	public List<Map<String, Object>> qryBalancedetail(long balanceid);
	
	//20151114 查询结算单按照站点和站点票价进行分组的明细  liyi
	public List<Map<String,Object>> qryBalanceStationdetailPrint(long balanceid,String isByprice);


	public List<Map<String, Object>> qryScheduleReport(String cardno, long reportorgid)throws ServiceException;
	
	// 查询AcReport打印结算单时的车票明细和结算单明细
	public List<Map<String, Object>> queryTicketDetail(List<PropertyFilter> propertyFilterList);
	
	// 打印结算单:只查询检到该结算单上的车票，包括：【座号】、【票号】、【到达站】、【票价】、【售票员】
	public List<Map<String, Object>> qryDptTicketdetail(List<PropertyFilter> propertyFilterList);

	/**
	 * 自助发班检查同一天同一车前前一个报到班次是否发班
	 * @param vehiclereportid
	 * @param reporttime 
	 * @param departdate 
	 * @return
	 */
	public boolean checkPreDepart(long vehicleid, Date departdate,
			String reporttime)throws ServiceException;
	/**
	 * 补开初检单查询
	 * @param scheduleplanid
	 * @param departstationid
	 * @param vehiclereportid
	 * @param islinework
	 * @return
	 */
	public List<Map<String, Object>> queryOpenFirstCheck(Long scheduleplanid, Long departstationid, Long vehiclereportid, boolean islinework);


	/**
	 * 查询手工单明细
	 * @param departinvoicesid
	 * @return
	 */
	public List<Map<String, Object>> qryDepartInvoicesOtherDetailPrintInfo(Long departinvoicesid);


	/**
	 * 26035 内蒙古+音德尔+结算通知单打印加入司机姓名变量
	 * @param vehicleids
	 * @return
	 */
	public String qryDriverName(String vehicleids);


	public boolean departinvoicesapproveing(long id, Global global);

}
