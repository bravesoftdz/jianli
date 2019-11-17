package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.wltea.expression.ExpressionEvaluator;

import cn.nova.bus.balance.dao.BalanceformulaDao;
import cn.nova.bus.balance.dao.BalanceformulaapplyDao;
import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.service.BalanceformulaService;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalanceformulaServiceImpl implements BalanceformulaService {

	
	private BalanceformulaDao balanceformulaDao = new BalanceformulaDao();
	
	private BalanceformulaapplyDao applydao = new BalanceformulaapplyDao();

	@Override
	public List<Map<String, Object>> qryBalanceformulaitem() {
		return ListUtil.listToMap(new Object[] { Balanceformulaitem.class },
				balanceformulaDao.qryBalanceformulaitem(),
				new Object[] { Balanceformulaitem.class });
	}

	@Override
	public List<Map<String, Object>> qryBalanceformula(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Balanceformula.class,
				"createname", "updatename", "orgname" },
				balanceformulaDao.qryBalanceformula(propertyFilterList),
				new Object[] { Balanceformula.class, String.class,
						String.class, String.class });
	}

	@Override
	public Balanceformula saveBalanceformula(Balanceformula balanceformula)
			throws ServiceException {
		if(balanceformulaDao.isExistbyName(balanceformula)){
			throw new ServiceException("0180");
		}		
		String formula=balanceformula.getFormula();
		if (!balanceformula.getFormulatype().equals("3") && checkExpression(formula)){
			//你输入的公式有误，请检查！
			throw new ServiceException("0165");
		}

		return balanceformulaDao.getEntityManager().merge(balanceformula);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delBalanceformula(Balanceformula balanceformula)
			throws ServiceException {
		Balanceformula obj = (Balanceformula) balanceformulaDao.get(
				Balanceformula.class, balanceformula.getId());
		if (obj.getIsaudited()) {
			//该结算公式已经审核，不能删除！
			throw new ServiceException("0166");
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_b!balanceformulaid", balanceformula.getId()));
		List<Object> exitlist = applydao.qryBalanceformulaapply(propertyFilters);
		if(exitlist!=null && exitlist.size()>0){
			//该公式已经在结算扣费公式应用中应用了，不能删除！
			throw new ServiceException("0432");
		}
		obj.setIsactive(false);
		obj.setUpdateby(balanceformula.getUpdateby());
		obj.setUpdatetime(new Date());
		balanceformulaDao.getEntityManager().merge(obj);
		return true;
	}

	@Override
	public boolean checkExpression(String formula) {
		int pos=0;
		char item;
		boolean iserror=true;
		while (pos < formula.length()) {
			item = formula.charAt(pos);
			if (ConstDefiniens.ITEM.indexOf(item) >= 0) {
				formula=formula.replaceAll(Character.toString(item), "1");
			}
			pos++;
		}
		try {
			Object result=ExpressionEvaluator.evaluate(formula);
			new BigDecimal(result.toString());
			iserror=false;
		}
		catch(Exception ex){
			iserror=true;
		}
		return iserror;
	}

	@Override
	public BigDecimal calPackBalancePrice(long orgid,
			long balanceunitid,long routeid,long vehicleid,BigDecimal packprice) {
		
		Balanceformula bf=balanceformulaDao.qryBalanceformula(orgid,
				balanceunitid,routeid,vehicleid,"1");
		if(bf==null){
			return new BigDecimal(0);
		}
		BigDecimal balanceprice= new BigDecimal(0);
		String formula=bf.getFormula();
		//for (int i = 0; i < formula.length(); i++) {
		//	    char item = formula.charAt(i);
		formula = formula.replaceAll("P",packprice.toString());
		//}
		try {
			balanceprice = new BigDecimal(ExpressionEvaluator.evaluate(formula)
					.toString());
			balanceprice = balanceprice.divide(new BigDecimal(1), 2,
					BigDecimal.ROUND_HALF_UP);
		} catch (Exception ex) {
			System.out.println("计算行包结算金额出现异常：" + formula);
		}
		return packprice.subtract(balanceprice);
	}

	@Override
	public BigDecimal calRentBalancePrice(long orgid,long balanceunitid,long routeid,long vehicleid,
			BigDecimal rentprice) {
		
		Balanceformula bf=balanceformulaDao.qryBalanceformula(orgid,
				balanceunitid,routeid,vehicleid,"2");
		if(bf==null){
			return new BigDecimal(0);
		}
		BigDecimal balanceprice= new BigDecimal(0);
		String formula=bf.getFormula();
		formula = formula.replaceAll("Z",rentprice.toString());
		//}
		try {
			balanceprice = new BigDecimal(ExpressionEvaluator.evaluate(formula)
					.toString());
			balanceprice = balanceprice.divide(new BigDecimal(1), 2,
					BigDecimal.ROUND_HALF_UP);
		} catch (Exception ex) {
			System.out.println("计算包车结算金额出现异常：" + formula);
		}
		return rentprice.subtract(balanceprice);
	}

}
