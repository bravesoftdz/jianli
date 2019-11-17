package cn.nova.bus.pack.action;

import java.util.List;
import java.util.Map;

import util.CurrentUtil;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.balance.service.impl.BalanceServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.service.PackBalanceService;
import cn.nova.bus.pack.service.impl.PackBalanceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 货物结算单结算
 * @author Administrator
 *
 */
public class PackBalanceAction extends BaseAction {
	private Long packid;
	private String packids;
	private PackBalance packBalance;

	private Long balanceid;

	private List<Map<String, Object>> packList;

	private PackBalanceService packBalanceService;

	//列表查询
	public String getList(){
		packBalanceService = new PackBalanceServiceImpl();
		setPackList(packBalanceService.getList(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
//	//单位结算/单车结算	
//	public String balance(){
//		try {
//			packBalanceService = new PackBalanceServiceImpl();
//			setBalanceid(packBalanceService.balance(packBalance, packids));
//			markSuccess();
//			setMsg("结算成功！");
//		} catch (Exception e) {
//			e.printStackTrace();
//			markFail();
//			setMsg("结算失败！");
//		}
//		return "json";
//	}
	
	public List<Map<String, Object>> getPackList() {
		return packList;
	}

	public void setPackList(List<Map<String, Object>> packList) {
		this.packList = packList;
	}

	public Long getPackid() {
		return packid;
	}

	public void setPackid(Long packid) {
		this.packid = packid;
	}
	
	public Long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(Long balanceid) {
		this.balanceid = balanceid;
	}
	
	public String getPackids() {
		return packids;
	}

	public void setPackids(String packids) {
		this.packids = packids;
	}

	public PackBalance getPackBalance() {
		return packBalance;
	}

	public void setPackBalance(PackBalance packBalance) {
		this.packBalance = packBalance;
	}
}
