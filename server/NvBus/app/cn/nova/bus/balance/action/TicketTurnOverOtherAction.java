package cn.nova.bus.balance.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.balance.model.TicketTurnOverOther;
import cn.nova.bus.balance.service.TicketTurnOverOtherService;
import cn.nova.bus.balance.service.impl.TicketTurnOverOtherServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketTurnOverOtherAction extends BaseAction {
	private TicketTurnOverOther ticketTurnOverOther;
	private List<Map<String, Object>> resultList;
	
	TicketTurnOverOtherService ticketTurnOverOtherService;

	// 保存
	public String seveTicketTurnOverOther() {
		Global global = CurrentUtil.getGlobal();
		try {
			ticketTurnOverOtherService = new TicketTurnOverOtherServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketTurnOverOther.setCreateby(global.getUserinfo().getId());
				ticketTurnOverOther.setCreatetime(new Date());
				ticketTurnOverOther.setUpdateby(global.getUserinfo().getId());
				ticketTurnOverOther.setUpdatetime(new Date());
				ticketTurnOverOther = ticketTurnOverOtherService
						.saveTicketTurnOverOther(ticketTurnOverOther);
				markSuccess();
				setMsg("缴款成功！");
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("缴款失败");
		}
		return "json";
	}

	// 查询
	public String qryTicketTurnOverOther() {
		try {
			ticketTurnOverOtherService = new TicketTurnOverOtherServiceImpl();
			setResultList(ticketTurnOverOtherService.qryTicketTurnOverOther((ServletPropertyFilterUtil
					.buildFromHttpRequest())));
			return "json";
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public TicketTurnOverOther getTicketTurnOverOther() {
		return ticketTurnOverOther;
	}

	public void setTicketTurnOverOther(TicketTurnOverOther ticketTurnOverOther) {
		this.ticketTurnOverOther = ticketTurnOverOther;
	}

	public List<Map<String, Object>> getResultList() {
		return resultList;
	}

	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}
	
	

}
