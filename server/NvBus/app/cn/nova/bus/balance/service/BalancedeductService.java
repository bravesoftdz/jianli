package cn.nova.bus.balance.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;

public interface BalancedeductService {

	// 返回打单时的客运代理费扣费
	public Departinvoicesdeductdetail getAgentfee(Date departdate,
			Schedule schedule, Vehicle vehicle,
			List<Balanceformulaitem> balanceformulaitems)
			throws ServiceException;

	// 返回其他扣费明细，用于班次发班时的扣费调用
	public List<Departinvoicesdeductdetail> getOthterfee(Date departdate,
			Schedule schedule, Vehicle vehicle, long ticketnum,
			boolean isdeductbeforebalance) throws ServiceException;

	// 返回打单时的扣费明细，用于班次发班时的扣费调用
	public List<Map<String, Object>>  qryDeductfee(long departinvoiceid) throws ServiceException;
	
	
	// 返回所有的固定扣费明细1
	public List<Departinvoicesdeductdetail> getAllDeductfee(
			Scheduleplan scheduleplan, Vehicle vehicle, String ticketids,
			long ticketnum, boolean isdeductbeforebalance)
			throws ServiceException;

	// 返回所有的固定扣费明细2
	public Departinvoices createDepartinvoices(Scheduleplan scheduleplan,
			Vehicle vehicle, List<Ticketsell> ticketsells,String departtime,long createdby,Global global)
			throws ServiceException;

	// 根据结算单生成其他扣费明细,用于结算时结算扣费数据生成调用
	public List<Balancedeductdetail> genOthterfee(Departinvoices departinvoices, long createby,long balanceunitid)
			throws ServiceException;

	// 生成班次计划时获取站务费的应用
	public Balancedeductapply getStationservicefeeApp(Date departdate,
			Schedule schedule, Unit unit, long vehicleid);

	// 生成班次计划时获取站务费
	public BigDecimal getStationservicefee(Balancedeductapply bp,
			long distance, BigDecimal price, long orgid);

	// 生成班次计划时获取燃油费的应用
	public Balancedeductapply getFueladditionfeeApp(Date departdate,
			Schedule schedule, Unit unit, long vehicleid);

	// 生成班次计划时获取燃油费
	public BigDecimal getFueladditionfee(Balancedeductapply bp, long distance,
			BigDecimal price, long orgid);

	// 获取固定扣费信息，如：站务费扣费信息、获取燃油费扣费信息
	public Departinvoicesdeductdetail getDeductdetail(
			Balancedeductapply stationfeeapply);

	// 获取固定扣费信息，如：站务费扣费信息、获取燃油费扣费信息
	public Departinvoicesdeductdetail getDeductdetail(long stationfeeapplyid);

	// 查询结算时的固定扣费金额,除公式扣费、站务费、燃油费等打单时的扣费项目外，即生成的扣费项目
	public BigDecimal getOthterfee(String invoicesids);

	// 获取结算通知单的扣费打印信息
	public List<Map<String, Object>> qryBalanceDeduct(long balanceid, Boolean isdeductbeforebalance);

	// 售票时获取票价固定扣费
	public DeductInfo getDeductfee(Ticketsell ticket);
	//结算固定扣费项目，公式扣费时候获取公式对应项和对应项的值
	public Map getBalanceformulaitemAndValue(Departinvoices departinvoices);
	//结算固定扣费项目，公式扣费时候通过传入的公式把公式的对应项替换成对应项的值
	public BigDecimal replaceFormula(String formula,Departinvoices departinvoices);

}
