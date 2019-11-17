package cn.nova.bus.dispatch.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUserID;
import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.dispatch.model.TicketLoss;
import cn.nova.bus.dispatch.service.TicketLossService;
import cn.nova.bus.dispatch.service.impl.TicketLossServiceImpl;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.impl.TicketSellServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketLossAction extends BaseAction{

	private List<Map<String, Object>> ticketlosslist;
	private List<Map<String, Object>> ticketselllist;
	private Ticketsell ts;
	private TicketLoss tl;
	
	private TicketLossService tlService = null;
	private TicketSellService tsService;
	
	private String msg;
	private Long flag;
	public String query(){
		tlService = new TicketLossServiceImpl();
		setTicketlosslist(tlService.query(tl));
		return "json";
	}
	
	public String queryTicketSell() {
		try {
			tlService = new TicketLossServiceImpl();
			setTicketselllist(tlService.queryTicketSell(ts));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String TicketLossAdd(){
		UserTransaction tr = new UserTransaction();
		try {
			tr.begin();
			tlService = new TicketLossServiceImpl();
			tsService = new TicketSellServiceImpl();
			
			Ticketsell ticketsell = tsService.getTicketsellById(ts.getId());
			tsService.updateTicketStatusById(ticketsell.getId(), 4);
			
			List<TicketLoss> tllist = tlService.getTicketLossByTicketSellId(ticketsell.getId());
			TicketLoss ticketLoss = null;
			if(tllist != null && tllist.size() > 0){
				ticketLoss = tllist.get(0);
			} else {
				ticketLoss = new TicketLoss(); 
			}
			ticketLoss.setLossby(CurrentUtil.getGlobal().getUserinfo().getId());
			ticketLoss.setLosstime(new Date());
			ticketLoss.setScheduleid(ticketsell.getScheduleid());
			ticketLoss.setTicketsellid(ticketsell.getId());
			ticketLoss.setStatus(1L);
			tlService.save(ticketLoss);
			setMsg("挂失成功");
			markSuccess();
			
			tr.commit();
		} catch (Exception e) {
			try {
				tr.rollback();
				setMsg("挂失失败");
				markFail();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String TicketLossCancel(){
		System.out.println("id="+tl.getId());
		tlService = new TicketLossServiceImpl();
		tsService = new TicketSellServiceImpl();
		UserTransaction tr = new UserTransaction();
		TicketLoss ticketLoss = tlService.getTicketLossById(tl.getId());
		try{
			tr.begin();
			ticketLoss.setStatus(0L);
			tlService.update(ticketLoss);
			tsService.updateTicketStatusById(ticketLoss.getTicketsellid(), 0);  //车票状态：0-正常，1-退票，2-废票 取数据字典
			tr.commit();
			setMsg("取消挂失成功！");
			markSuccess();
		}catch(Exception e){
			try {
				tr.rollback();
				setMsg("取消挂失失败！");
				markFail();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public void setTs(Ticketsell ts) {
		this.ts = ts;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Long getFlag() {
		return flag;
	}

	public void setFlag(Long flag) {
		this.flag = flag;
	}

	public TicketLoss getTl() {
		return tl;
	}

	public void setTl(TicketLoss tl) {
		this.tl = tl;
	}

	public List<Map<String, Object>> getTicketlosslist() {
		return ticketlosslist;
	}

	public void setTicketlosslist(List<Map<String, Object>> ticketlosslist) {
		this.ticketlosslist = ticketlosslist;
	}

	public List<Map<String, Object>> getTicketselllist() {
		return ticketselllist;
	}

	public void setTicketselllist(List<Map<String, Object>> ticketselllist) {
		this.ticketselllist = ticketselllist;
	}
}
