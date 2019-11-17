package cn.nova.bus.sale.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.service.InsurancereturnService;
import cn.nova.bus.insure.service.impl.InsurancereturnServiceImpl;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.impl.TicketreturnServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;


public class TicketreturnAction extends BaseAction{
	private List<Map<String,Object>> ticketreturnquery;
	private List<Map<String,Object>> ticketreturnempty;
	private List<Ticketreturn> ticketreturns;
	private TicketreturnService ticketreturnService;
	//是否打印凭证增加用户前端控制
	private boolean canprint;
	
	//换票号重打退票凭证接收参数
	private boolean isselfschedule;
	private	long ticketsellid;
	private String curTicketNo;
	
	private BigDecimal ticketfee;
	private BigDecimal returnfee;
	private long returnby;
	/**
	 * 查询车票的票价分项合计
	 * @return
	 */
	public String findticketfee(){
		try {
			ticketreturnService = new TicketreturnServiceImpl();
			ticketfee = ticketreturnService.findticketfee(isselfschedule,ticketsellid);
			markSuccess();
		} catch (Exception e) {
			markFailure();
			setMsg("查询失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String findreturnfee(){
		try {
			ticketreturnService = new TicketreturnServiceImpl();
			returnfee = ticketreturnService.findReturnFee(ticketsellid);
			markSuccess();
		} catch (Exception e) {
			markFailure();
			setMsg("查询失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String find(){
		try {
			Global global = CurrentUtil.getGlobal();
			List<PropertyFilter> propertyFilters = ServletPropertyFilterUtil.buildFromHttpRequest();
			ticketreturnService = new TicketreturnServiceImpl();
			MethodResult methodResult = ticketreturnService.find(propertyFilters,global.getOrganization().getId());
			if(methodResult.getResult() == MethodResult.SUCCESS){
				markSuccess();
				setMsg("查询成功！");
				setTicketreturnquery((List<Map<String, Object>>) methodResult.getObject()); 
			}else{
				markFailure();
				setMsg("查询失败:"+methodResult.getResultMsg());
			}
		} catch (Exception e) {
			markFailure();
			play.Logger.error(e.getMessage());
			setMsg("查询失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String findEmpty(){
		setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		return "json";
	}
	
	private String vipcardno;//VIP卡号
	private String vipgrade;//VIP当前等级
	private BigDecimal vipmoney;//VIP当前余额
	private BigDecimal vippoint;//VIP当前积分
	public String returnTickets(){
		try {
			Global global = CurrentUtil.getGlobal();
			Date now = new Date();
			for (Ticketreturn ticketreturn : getTicketreturns()) {
				ticketreturn.setCreateby(global.getUserinfo().getId());
				ticketreturn.setCreatetime(now);
				ticketreturn.setReturnby(global.getUserinfo().getId());
				ticketreturn.setReturnip(global.getIpAddress());
				ticketreturn.setReturntime(now);
				ticketreturn.setUpdateby(global.getUserinfo().getId());
				ticketreturn.setUpdatetime(now);
			}
			ticketreturnService = new TicketreturnServiceImpl();
			ticketreturnService.returnTickets(getTicketreturns(), global,vipcardno,vipgrade,vipmoney,vippoint,canprint,returnby);
			List<Object> _ticketreturns = new ArrayList<Object>();
			_ticketreturns.addAll(ticketreturns);
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, _ticketreturns));
			markSuccess();
			setMsg("退票成功！");
		} catch (ServiceException e) {
			e.printStackTrace();
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
			markFailure();
			setMsg("退票失败:"+e.getMessage());
		}catch (BusinessException se) {
			markFail();
			setMsg("退票失败:"+se.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		} catch (Exception e) {
			e.printStackTrace();
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
			markFailure();
			setMsg("退票失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String rePrintTicketreturnAndChangeTicketNo(){
			Global global = CurrentUtil.getGlobal();
		try {
			ticketreturnService = new TicketreturnServiceImpl();
			Ticketreturn ticketreturn = ticketreturnService.rePrintTicketreturnAndChangeTicketNo(getIsselfschedule(), getTicketsellid(), getCurTicketNo(), global);
			List<Object> objects = new ArrayList<Object>();
			objects.add(ticketreturn);
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, objects));
			markSuccess();
			setMsg("换票号重打退票凭证成功");
		} catch (BusinessException se) {
			markFail();
			setMsg("换票好重打退票凭证失败:"+se.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		}catch (ServiceException e) {
			markFailure();
			setMsg("换票号重打退票凭证失败:"+e.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		}
		return "json";
	}

	public String returninsures(){
		Global global = CurrentUtil.getGlobal();
		InsurancereturnService insurancereturnService = new InsurancereturnServiceImpl();
		try {
			
			insurancereturnService.returnInsuranceAtreturnTicket(getTicketreturns(), global);
			List<Object> _ticketreturns = new ArrayList<Object>();
			_ticketreturns.addAll(ticketreturns);
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, _ticketreturns));
			markSuccess();
			setMsg("单独退保险成功！");
		} catch (ServiceException e) {
			markFailure();
			setMsg("单独退保险失败:"+e.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		}catch (BusinessException se) {
			markFail();
			setMsg("单独退保险失败:"+se.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		} catch (Exception e) {
			markFailure();
			setMsg("单独退保险失败:" + e.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
			return "json";
		}
		return "json";
	}
	
	/**
	 * 重打退票凭证
	 */
	public String reprintReturnvoucher(){
		try {
			ticketreturnService = new TicketreturnServiceImpl();
			setTicketreturnempty(ticketreturnService.reprintReturnvoucher(
					CurrentUtil.getGlobal(), ticketsellid, curTicketNo));
			markSuccess();
			setMsg("重打退票凭证成功！");
		} catch (Exception e) {
			e.printStackTrace();
			play.Logger.error("重打退票凭证失败！", e);
			markFailure();
			setMsg("重打退票凭证失败:" + e.getMessage());
			setTicketreturnempty(ListUtil.listToMap(new Object[]{Ticketreturn.class}, null));
		}
		return "json";
	}
	
	public void setTicketreturnquery(List<Map<String,Object>> ticketreturnquery) {
		this.ticketreturnquery = ticketreturnquery;
	}
	public List<Map<String,Object>> getTicketreturnquery() {
		return ticketreturnquery;
	}
	public void setTicketreturns(List<Ticketreturn> ticketreturns) {
		this.ticketreturns = ticketreturns;
	}
	@Transient
	public List<Ticketreturn> getTicketreturns() {
		return ticketreturns;
	}

	public void setTicketreturnempty(List<Map<String,Object>> ticketreturnempty) {
		this.ticketreturnempty = ticketreturnempty;
	}

	public List<Map<String,Object>> getTicketreturnempty() {
		return ticketreturnempty;
	}

	@Transient
	public String getCurTicketNo() {
		return curTicketNo;
	}

	public void setCurTicketNo(String curTicketNo) {
		this.curTicketNo = curTicketNo;
	}

	@Transient
	public long getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	@Transient
	public boolean getIsselfschedule() {
		return isselfschedule;
	}

	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
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

	public BigDecimal getTicketfee() {
		return ticketfee;
	}

	public void setTicketfee(BigDecimal ticketfee) {
		this.ticketfee = ticketfee;
	}
	public boolean isCanprint() {
		return canprint;
	}

	public void setCanprint(boolean canprint) {
		this.canprint = canprint;
	}

	public BigDecimal getReturnfee() {
		return returnfee;
	}

	public void setReturnfee(BigDecimal returnfee) {
		this.returnfee = returnfee;
	}

	public long getReturnby() {
		return returnby;
	}

	public void setReturnby(long returnby) {
		this.returnby = returnby;
	}
	
}
