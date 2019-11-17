package cn.nova.bus.balance.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface BalanceformulaService {

	public List<Map<String, Object>> qryBalanceformulaitem();

	public List<Map<String, Object>> qryBalanceformula(
			List<PropertyFilter> propertyFilterList);

	public Balanceformula saveBalanceformula(Balanceformula balanceformula)
			throws ServiceException;

	public boolean delBalanceformula(Balanceformula balanceformula)
			throws ServiceException;

	// 校验表达式是否正确
	public boolean checkExpression(String formula);

	// 根据行包金额 得到结算金额
	public BigDecimal calPackBalancePrice(long orgid, long balanceunitid,
			long routeid, long vehicleid, BigDecimal packprice);

	// 根据包车金额 得到结算金额
	public BigDecimal calRentBalancePrice(long orgid, long balanceunitid,
			long routeid, long vehicleid, BigDecimal rentprice);
}
