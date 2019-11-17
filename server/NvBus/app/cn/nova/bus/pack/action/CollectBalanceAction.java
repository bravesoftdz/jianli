package cn.nova.bus.pack.action;

import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.pack.model.CollectBalance;
import cn.nova.bus.pack.service.CollectBalanceService;
import cn.nova.bus.pack.service.impl.CollectBalanceServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 代收货款结算
 * @author Administrator
 *
 */
public class CollectBalanceAction extends BaseAction {
	private Long packid;
	private String packids;
	private Long vehicleid;
	private CollectBalance collectBalance;

	private Long balanceid;

	private List<Map<String, Object>> packList;

	private CollectBalanceService collectBalanceService;

	//列表查询
	public String getList(){
		collectBalanceService = new CollectBalanceServiceImpl();
		setPackList(collectBalanceService.getList(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	//单车结算
	public String balance(){
		try {
			collectBalanceService = new CollectBalanceServiceImpl();
			setBalanceid(collectBalanceService.balance(collectBalance, packids));
			markSuccess();
			setMsg("结算成功！");
		} catch (Exception e) {
			e.printStackTrace();
			markFail();
			setMsg("结算失败！");
		}
		return "json";
	}

	public Long getPackid() {
		return packid;
	}

	public void setPackid(Long packid) {
		this.packid = packid;
	}

	public String getPackids() {
		return packids;
	}

	public void setPackids(String packids) {
		this.packids = packids;
	}

	public CollectBalance getCollectBalance() {
		return collectBalance;
	}

	public void setCollectBalance(CollectBalance collectBalance) {
		this.collectBalance = collectBalance;
	}

	public Long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(Long balanceid) {
		this.balanceid = balanceid;
	}

	public List<Map<String, Object>> getPackList() {
		return packList;
	}

	public void setPackList(List<Map<String, Object>> packList) {
		this.packList = packList;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}
	
	
}
