package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.balance.service.BalanceformulaService;
import cn.nova.bus.balance.service.impl.BalanceformulaServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 结算公式管理
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public class BalanceformulaAction extends BaseAction{
	private Long curid;
	private Balanceformula balanceformula;
	private List<Map<String, Object>> balanceformulas;
	private List<Map<String, Object>> balanceformulaitems;
	private BigDecimal packbalanceprice;
	private BigDecimal packprice;
	private BigDecimal rentbalanceprice;
	private BigDecimal rentprice;
	private long balanceunitid;
	private long routeid;
	private long vehicleid;

	private BalanceformulaService balanceformulaService;

	public String qryBalanceformulaitem() {
		try {
			balanceformulaService = new BalanceformulaServiceImpl();
			setBalanceformulaitems(balanceformulaService
					.qryBalanceformulaitem());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryBalanceformula() {
		try {
			balanceformulaService = new BalanceformulaServiceImpl();
			setBalanceformulas(balanceformulaService
					.qryBalanceformula(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveBalanceformula() {
		Global global = CurrentUtil.getGlobal();
		try {
			balanceformulaService = new BalanceformulaServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				balanceformula.setIsactive(true);
				if (balanceformula.getId() == 0) {
					markSuccess();
					setMsg("添加成功！");
					balanceformula.setCreateby(global.getUserinfo().getId());
					balanceformula.setUpdateby(global.getUserinfo().getId());
					balanceformula.setCreatetime(new Date());
					balanceformula.setUpdatetime(new Date());
				} else {
					markSuccess();
					setMsg("修改成功！");
					balanceformula.setUpdateby(global.getUserinfo().getId());
					balanceformula.setUpdatetime(new Date());
				}
				balanceformula = balanceformulaService
						.saveBalanceformula(balanceformula);
				setCurid(balanceformula.getId());
			}
		} catch (ServiceException se) {
			System.out.println("ServiceException------------------");
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}

	public String delBalanceformula() {
		balanceformulaService = new BalanceformulaServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balanceformulaService.delBalanceformula(balanceformula)) {
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}

	public String calPackBalancePrice() {
		Global global = CurrentUtil.getGlobal();
		try {
			balanceformulaService = new BalanceformulaServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				packbalanceprice = balanceformulaService.calPackBalancePrice(
						global.getOrganization().getId(), balanceunitid,
						routeid, vehicleid, packprice);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			packbalanceprice = new BigDecimal(0);
		}
		return "json";
	}

	public String calRentBalancePrice() {
		balanceformulaService = new BalanceformulaServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				rentbalanceprice = balanceformulaService.calRentBalancePrice(
						global.getOrganization().getId(), balanceunitid,
						routeid, vehicleid, rentprice);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			packbalanceprice = new BigDecimal(0);
		}
		return "json";

	}

	public Long getCurid() {
		return curid;
	}

	public void setCurid(Long curid) {
		this.curid = curid;
	}

	@Transient
	public Balanceformula getBalanceformula() {
		return balanceformula;
	}

	public void setBalanceformula(Balanceformula balanceformula) {
		this.balanceformula = balanceformula;
	}

	public List<Map<String, Object>> getBalanceformulas() {
		return balanceformulas;
	}

	public void setBalanceformulas(List<Map<String, Object>> balanceformulas) {
		this.balanceformulas = balanceformulas;
	}

	public List<Map<String, Object>> getBalanceformulaitems() {
		return balanceformulaitems;
	}

	public void setBalanceformulaitems(
			List<Map<String, Object>> balanceformulaitems) {
		this.balanceformulaitems = balanceformulaitems;
	}

	public BigDecimal getPackbalanceprice() {
		return packbalanceprice;
	}

	public void setPackbalanceprice(BigDecimal packbalanceprice) {
		this.packbalanceprice = packbalanceprice;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	public BigDecimal getRentbalanceprice() {
		return rentbalanceprice;
	}

	public void setRentbalanceprice(BigDecimal rentbalanceprice) {
		this.rentbalanceprice = rentbalanceprice;
	}

	public BigDecimal getRentprice() {
		return rentprice;
	}

	public void setRentprice(BigDecimal rentprice) {
		this.rentprice = rentprice;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

}
