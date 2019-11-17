package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketturnoverdetailAction extends BaseAction{
	private Ticketturnoverdetail ticketturnoverdetail;
	private List<Map<String, Object>> turnoverdetailMap;
	private List<Map<String, Object>> returnTicketnoMap;
	private List<Map<String, Object>> cancelTicketnoMap;
	private List<Map<String, Object>> billTicketnoMap;
	private List<Map<String, Object>> turnoverdetailCountMap;
	private String orgid;//打印日、月营收单时查询站务费参数
	private long seller;
	private long seller0;
	public long getSeller0() {
		return seller0;
	}
	public void setSeller0(long seller0) {
		this.seller0 = seller0;
	}

	private String lostmoney;

	private TicketturnoverdetailService turnoverdetailService;

	/**
	 * 查询票款支付明细
	 * @return
	 */
	public String qryticketturnoverdetailEPay(){
		try {
			turnoverdetailService = new TicketturnoverdetailServiceImpl();
			setTurnoverdetailMap(turnoverdetailService
					.qryticketturnoverdetailEPay(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 查询车票票款缴款明细
	 * @return
	 */
	public String query() {
		Global global = CurrentUtil.getGlobal();
		try {
			turnoverdetailService = new TicketturnoverdetailServiceImpl();
			setTurnoverdetailMap(turnoverdetailService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest(),seller,global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 查询上次欠款
	 * @return
	 */
	public String getlostmoney()
	{
		turnoverdetailService = new TicketturnoverdetailServiceImpl();
		lostmoney = turnoverdetailService.qrylastlostmoney(seller0);
		setLostmoney(lostmoney);
		return "json";
	}
	public String getLostmoney() {
		return lostmoney;
	}
	public void setLostmoney(String lostmoney) {
		this.lostmoney = lostmoney;
	}
	/**
	 * 查询车票票款对应的退票数
	 * @return
	 */
	public String queryReturnTicketno() {
		turnoverdetailService = new TicketturnoverdetailServiceImpl();
		setReturnTicketnoMap(turnoverdetailService
				.queryReturnTicketno(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}

	/**
	 * 查询车票票款对应的废票数
	 * @return
	 */
	public String queryCancelTicketno() {
		turnoverdetailService = new TicketturnoverdetailServiceImpl();
		setCancelTicketnoMap(turnoverdetailService
				.queryCancelTicketno(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}

	/**
	 * 查询车票票款对应的坏票登记数
	 * @return
	 */
	public String queryBillTicketno() {
		try {
			turnoverdetailService = new TicketturnoverdetailServiceImpl();
			setBillTicketnoMap(turnoverdetailService
					.queryBillTicketno(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			turnoverdetailService = new TicketturnoverdetailServiceImpl();
			if (ticketturnoverdetail != null) {
				if (ticketturnoverdetail.getId() > 0) {
					markSuccess();
					setMsg("修改成功");
				} else {
					markSuccess();
					setMsg("缴款成功");
					ticketturnoverdetail.setCreateby(global.getUserinfo()
							.getId());
					ticketturnoverdetail.setCreatetime(new Date());
				}
				if (!turnoverdetailService.save(ticketturnoverdetail)) {
					markSuccess();
					setMsg("缴款失败");
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("缴款异常 :" + e.getMessage());
		}
		return "json";
	}
	
	/**
	 * 统计某日,月票款明细信息，用来打营收表 
	 * @return
	 */
	public String queryTicketRevenue() {
		try {
			turnoverdetailService = new TicketturnoverdetailServiceImpl();
			setTurnoverdetailCountMap(turnoverdetailService
					.queryTicketRevenue(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	private String ticketturnoverdetailids; //缴款明细id，供打印西安汽车站售票缴款单查询退票使用
	private String ticketturnoverids;
	public String queryDetailBalanceAllow(){
		turnoverdetailService = new TicketturnoverdetailServiceImpl();
		setTurnoverdetailMap(turnoverdetailService.queryDetailBalanceAllow(ticketturnoverdetailids,ticketturnoverids));
		return "json";
	}
	public String getTicketturnoverdetailids() {
		return ticketturnoverdetailids;
	}
	public void setTicketturnoverdetailids(String ticketturnoverdetailids) {
		this.ticketturnoverdetailids = ticketturnoverdetailids;
	}
	public String getTicketturnoverids() {
		return ticketturnoverids;
	}
	public void setTicketturnoverids(String ticketturnoverids) {
		this.ticketturnoverids = ticketturnoverids;
	}
	public Ticketturnoverdetail getTicketturnoverdetail() {
		return ticketturnoverdetail;
	}

	public void setTicketturnoverdetail(
			Ticketturnoverdetail ticketturnoverdetail) {
		this.ticketturnoverdetail = ticketturnoverdetail;
	}

	public List<Map<String, Object>> getTurnoverdetailMap() {
		return turnoverdetailMap;
	}

	public void setTurnoverdetailMap(List<Map<String, Object>> turnoverdetailMap) {
		this.turnoverdetailMap = turnoverdetailMap;
	}

	public List<Map<String, Object>> getReturnTicketnoMap() {
		return returnTicketnoMap;
	}

	public void setReturnTicketnoMap(List<Map<String, Object>> returnTicketnoMap) {
		this.returnTicketnoMap = returnTicketnoMap;
	}

	public List<Map<String, Object>> getCancelTicketnoMap() {
		return cancelTicketnoMap;
	}

	public void setCancelTicketnoMap(List<Map<String, Object>> cancelTicketnoMap) {
		this.cancelTicketnoMap = cancelTicketnoMap;
	}

	public List<Map<String, Object>> getBillTicketnoMap() {
		return billTicketnoMap;
	}

	public void setBillTicketnoMap(List<Map<String, Object>> billTicketnoMap) {
		this.billTicketnoMap = billTicketnoMap;
	}

	public List<Map<String, Object>> getTurnoverdetailCountMap() {
		return turnoverdetailCountMap;
	}

	public void setTurnoverdetailCountMap(
			List<Map<String, Object>> turnoverdetailCountMap) {
		this.turnoverdetailCountMap = turnoverdetailCountMap;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public long getSeller() {
		return seller;
	}

	public void setSeller(long seller) {
		this.seller = seller;
	}

}
