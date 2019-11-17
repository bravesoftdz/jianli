package cn.nova.bus.sale.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.service.InsurancecancelService;
import cn.nova.bus.insure.service.impl.InsurancecancelServiceImpl;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.sale.service.TicketcancelService;
import cn.nova.bus.sale.service.impl.TicketcancelServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import util.CurrentUtil;
import util.TransactionUtil;

public class TicketcancelAction extends BaseAction{
	private List<Map<String,Object>> ticketcancelquery;
	private List<Map<String,Object>> ticketcancelempty;
	private List<Ticketcancel> ticketcancels;
	private TicketcancelService ticketcancelService;
	
	public String find(){
		ticketcancelService = new TicketcancelServiceImpl();
		try {
			Global global = CurrentUtil.getGlobal();
			List<PropertyFilter> propertyFilters = ServletPropertyFilterUtil.buildFromHttpRequest();
			MethodResult methodResult = ticketcancelService.find(propertyFilters,global.getOrganization().getId());
			if(methodResult.getResult()==MethodResult.SUCCESS){
				markSuccess();
				setMsg("查询成功！");
				setTicketcancelquery((List<Map<String, Object>>) methodResult.getObject()); 
			}else{
				markFailure();
				setMsg("查询失败:"+methodResult.getResultMsg());
			}
		} catch (Exception e) {
			markFailure();
			setMsg("查询失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String findEmpty(){
		setTicketcancelempty(ListUtil.listToMap(new Object[]{Ticketcancel.class}, null));
		return "json";
	}
	
	private String vipcardno;//VIP卡号
	private String vipgrade;//VIP当前等级
	private BigDecimal vipmoney;//VIP当前余额
	private BigDecimal vippoint;//VIP当前积分
	public String cancelTickets(){
		ticketcancelService = new TicketcancelServiceImpl();
		try {
			Global global = CurrentUtil.getGlobal();
			Date now = new Date();
			for (Ticketcancel ticketcancel : getTicketcancels()) {
				ticketcancel.setCreateby(global.getUserinfo().getId());
				ticketcancel.setCreatetime(now);
				ticketcancel.setCancelby(global.getUserinfo().getId());
				ticketcancel.setCancelip(global.getIpAddress());
				ticketcancel.setCanceltime(now);
				ticketcancel.setUpdateby(global.getUserinfo().getId());
				ticketcancel.setUpdatetime(now);
			}
			ticketcancelService.cancelTickets(getTicketcancels(), global,vipcardno,vipgrade,vipmoney,vippoint);
			List<Object> _ticketcancels = new ArrayList<Object>();
			_ticketcancels.addAll(ticketcancels);
			setTicketcancelempty(ListUtil.listToMap(new Object[]{Ticketcancel.class}, _ticketcancels));
			markSuccess();
			setMsg("废票成功！");
		} catch (ServiceException e) {
			setTicketcancelempty(ListUtil.listToMap(new Object[]{Ticketcancel.class}, null));
			markFailure();
			TransactionUtil.setRollbackOnly();
			setMsg("废票失败:"+e.getMessage());
		} catch (Exception e) {
			setTicketcancelempty(ListUtil.listToMap(new Object[]{Ticketcancel.class}, null));
			markFailure();
			TransactionUtil.setRollbackOnly();
			setMsg("废票失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String findspecialticket(){
		ticketcancelService = new TicketcancelServiceImpl();
		try {
			List<PropertyFilter> propertyFilters = ServletPropertyFilterUtil.buildFromHttpRequest();
			
			setTicketcancelquery(ticketcancelService.findspecialticket(propertyFilters)); 
		}
			catch (Exception e) {
			markFailure();
			setMsg("查询失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String cancelinsures(){
		InsurancecancelService insurancecancelService = new InsurancecancelServiceImpl();
		try {
			Global global = CurrentUtil.getGlobal();
			insurancecancelService.cancelInsuranceAtcancelTicket(getTicketcancels(), global);
			List<Object> _ticketcancels = new ArrayList<Object>();
			_ticketcancels.addAll(ticketcancels);
			setTicketcancelempty(ListUtil.listToMap(new Object[]{Ticketcancel.class}, _ticketcancels));
			markSuccess();
			setMsg("废保险成功！");
		}catch (Exception e) {
			setTicketcancelempty(ListUtil.listToMap(new Object[]{Ticketcancel.class}, null));
			markFailure();
			TransactionUtil.setRollbackOnly();
			setMsg("废保险失败:"+e.getMessage());
		}
		return "json";
	}
	
	public void setTicketcancelquery(List<Map<String,Object>> ticketcancelquery) {
		this.ticketcancelquery = ticketcancelquery;
	}
	public List<Map<String,Object>> getTicketcancelquery() {
		return ticketcancelquery;
	}
	public void setTicketcancels(List<Ticketcancel> ticketcancels) {
		this.ticketcancels = ticketcancels;
	}
	@Transient
	public List<Ticketcancel> getTicketcancels() {
		return ticketcancels;
	}

	public void setTicketcancelempty(List<Map<String,Object>> ticketcancelempty) {
		this.ticketcancelempty = ticketcancelempty;
	}

	public List<Map<String,Object>> getTicketcancelempty() {
		return ticketcancelempty;
	}

	public String getVipcardno() {
		return vipcardno;
	}

	public void setVipcardno(String vipcardno) {
		this.vipcardno = vipcardno;
	}

	public String getVipgrade() {
		return vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

	public BigDecimal getVipmoney() {
		return vipmoney;
	}

	public void setVipmoney(BigDecimal vipmoney) {
		this.vipmoney = vipmoney;
	}

	public BigDecimal getVippoint() {
		return vippoint;
	}

	public void setVippoint(BigDecimal vippoint) {
		this.vippoint = vippoint;
	}

}
