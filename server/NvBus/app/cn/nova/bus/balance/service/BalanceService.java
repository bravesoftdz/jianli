package cn.nova.bus.balance.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balancestationdeduct;
import cn.nova.bus.balance.vo.OtherBalanceinfo;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface BalanceService {
	// 创建车牌目录树
	public List<Map<String, Object>> createTree(long orgid);

	// 生成结算扣费数据
	public boolean genBalanceData(Date fromdapart, Date todapart,
			String invoinceids, long createby) throws ServiceException;
	
	public boolean genBalanceData(Date fromdapart, Date todapart,
			String invoinceids, Global global) throws ServiceException;
	
	// 删除结算扣费数据
	public boolean delBalanceData(Date fromdepart, Date todepart,
			String invoinceids) throws ServiceException;

	// 删除结算扣费数据
	public boolean delBalanceData(String invoicesids) throws ServiceException;

	// 查询结算单信息
	public List<Map<String, Object>> qryDepartinvoices(
			List<PropertyFilter> propertyFilterList, String invoinceids,String orgids,int departinvoicestype);

	// 查询结算单信息
	public List<Map<String, Object>> qryDepartinvoicesByNo(
			String departinvoicesno);

	// 根据结算单ID查询结算单扣费明细信息
	public List<Map<String, Object>> qryInvoicesdeductdetail(
			long departinvoicesid);

	// 根据结算单ID查询手工输入的扣费明细信息
	public List<Map<String, Object>> qryInvoicesdeductdetail(String invoicesids);

	// 实现结算过程invoicesids 格式：(12,45)
	public Balance invoicesBalance(Balance balance,int balancetype, String invoicesids,
			String vehicleids, List<Balancedeductdetail> dds, Global global,String otherinvoicesids, Date qryfromdate, Date qrytodate,
			String schedulelosttreatmentIds)
			throws ServiceException;

	// 查询其他结算信息
	public OtherBalanceinfo qryOtherBalance(long orgid, Date fromdepart,
			Date todepart, String vehicleids, String balanceobject,
			long objectid, String invoicesids,Global global);

	//
	public BigDecimal getOtherDeduct(String invoicesids);

	// 查询结算扣费明细
	public List<Map<String, Object>> qryBalanceDeduct(long balanceid,
			Boolean isdeductbeforebalance);

	// 结算时，查询结算扣费明细
	public List<Map<String, Object>> qryBalanceDeduct(int balancetype,long orgid,
			long balanceunitid, String invoinceids, String vehicleids);

	/**
	 * 已结算单查询 -- by hhz
	 * 
	 * @param balanceid
	 * @return
	 */
	public List<Map<String, Object>> queryBalanced(
			List<PropertyFilter> propertyFilterList);

	public boolean cancelBalanceno(long balanceid, long cancelby,
			String cancelip) throws ServiceException;

	// 查询结账单信息
	public String qryBalanceByNo(String departinvoicesno);

	// 重新计算结算数据
	public boolean recalDepartinvoices(Date startdate, Date enddate,
			String invoinceids,String otherinvoicesids, long updateby,Global global) throws ServiceException;

	// 重新计算结算数据，本计算只获取结果，不对原数据进行变更
	public BigDecimal calDepartinvoices(Date startdate, Date enddate,String invoinceids,Global global);
	
	// 打印结算扣费明细
	public List<Map<String, Object>> qryBalanceDeductDetail(long balanceid);

	// 结算时查询设置附加费

	public List<Map<String, Object>> qryAdditionFee(String invoicesids,
			long vehicleid, long orgid,String otherinvoicesids);

	// 结算时查询设置附加费
	public BigDecimal qryAdditionFee(String invoicesids, String vehicleids,
			long orgid);

	// 更新设置附加费
	public boolean updateAdditionFee(List<Balancestationdeduct> bsds,
			long createby);

	// 判断车辆附加费扣费是否一致
	public boolean additionFeeIsSame(String vehicleids, long orgid);

	// 查询客运代理费比例
	public BigDecimal qryAgentrate(String vehicleids, long orgid);
	
	//查询车辆的营运线路
	public String qryRoutename(String vehicleno);
	
	// 查询单车已结算信息
	public List<Map<String, Object>> qryVehicleBalanced(Date startdate,Date enddate,
			String orgids,long vehicleid,long unitid);
	
	// 结算月报表
	public List<Map<String, Object>> qryBalancedMonth(Date startdate, Date enddate);
	
	// 查询单车企业运输费
	public List<Map<String, Object>> qryBalancedBusTransport(List<PropertyFilter> propertyFilters);
	
	public Departinvoices editDepartinvoices(String ticketsellids,long departinvoicesid,long fromstationid,long reachstationid,String tickettype, BigDecimal price);


	public List<Map<String, Object>> qryvehicleno(String param,List<PropertyFilter> buildFromHttpRequest);
	
	//查看是否有路单结算插件
	public List<Map<String, Object>> isHaveDepartinvoicePlugin(Global global);
	
	//新增方法通过参数规则进行四舍五入返回结果到前端  20151109  liyi
	public String roundLeaveBalance(long orgid,String leaveBalance);

	public List<Map<String, Object>> qrybalanceACPrintinfo(Long balanceid);

	public boolean saveagentfee(long departinvoicesid, String deductmoney,BigDecimal balanceamount);

	public String getVehicleUnitname(long id);

	public BigDecimal qryBaoChePrice(String otherinvoicesids);

	public MethodResult savetoredis(long departinvoicesid, String savemode);

	public List<Map<String, Object>> checktempfromredis(Global global);

	public List<Map<String, Object>> qryCleanfee(Long balanceid);
}
