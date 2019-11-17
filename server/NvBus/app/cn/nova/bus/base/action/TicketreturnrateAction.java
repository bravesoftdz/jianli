package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import play.data.binding.As;
import util.CurrentUtil;
import cn.nova.bus.base.model.Ticketreturnrate;
import cn.nova.bus.base.service.TicketreturnrateService;
import cn.nova.bus.base.service.impl.TicketreturnrateServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketreturnrateAction extends BaseAction{
	private Ticketreturnrate ticketreturnrate;
	private Long id;
	private boolean islinework;
	private List<Map<String, Object>> ticketreturnrates;
	
	private TicketreturnrateService ticketreturnrateService;

	public String query() {
		ticketreturnrateService = new TicketreturnrateServiceImpl();
		setTicketreturnrates(ticketreturnrateService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		return "json";
	}

	public String save() {
		ticketreturnrateService = new TicketreturnrateServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (ticketreturnrate != null) {
			if (ticketreturnrate.getId() > 0) {
				msg = "修改成功！";
				ticketreturnrate.setUpdateby(global.getUserinfo().getId());
				ticketreturnrate.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			} else {
				msg = "添加成功！";
				ticketreturnrate.setCreateby(global.getUserinfo().getId());
				ticketreturnrate.setUpdateby(global.getUserinfo().getId());
				ticketreturnrate.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				ticketreturnrate.setCreatetime(new Timestamp(System.currentTimeMillis()));
			}
			try {
				ticketreturnrate = ticketreturnrateService.merge(ticketreturnrate);
				setId(ticketreturnrate.getId());
				markSuccess();
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markFail();
			}
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			ticketreturnrateService = new TicketreturnrateServiceImpl();
			ticketreturnrateService.delete(ticketreturnrate);
			msg = "删除成功！";
			markSuccess();
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		}
		return "json";
	}

	//当前时间距发车时间小时数
	private long hoursbetweendeparttime;
	private Date departdatetime;
	private BigDecimal returnrate;
	
	public String findticketreturnrate() {
		Global global = CurrentUtil.getGlobal();
		ticketreturnrateService = new TicketreturnrateServiceImpl();
		Date now=new Date();		
		/*if(departdatetime.getTime()-now.getTime()>0){
			hoursbetweendeparttime=(departdatetime.getTime()-now.getTime())/1000/60/60;
		}else{
			hoursbetweendeparttime=(now.getTime()-departdatetime.getTime())/1000/60/60-1;			
		}*/
		BigDecimal hoursbetweendeparttime=new BigDecimal(0);
		hoursbetweendeparttime=(new BigDecimal(departdatetime.getTime()-now.getTime())).
				divide(new BigDecimal(1000)).divide(
				new BigDecimal(60),BigDecimal.ROUND_UP).divide(
						new BigDecimal(60),BigDecimal.ROUND_UP);
		play.Logger.info(String.valueOf(hoursbetweendeparttime));
		//hoursbetweendeparttime=(departdatetime.getTime()-now.getTime())/1000/60/60;
		
		returnrate = ticketreturnrateService.getticketreturnrate(global.getOrganization().getId(), hoursbetweendeparttime,departdatetime, islinework);
		
		
		markSuccess();
		return "json";
	}
	
	public Date getDepartdatetime() {
		return departdatetime;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setDepartdatetime(Date departdatetime) {
		this.departdatetime = departdatetime;
	}

	public List<Map<String, Object>> getTicketreturnrates() {
		return ticketreturnrates;
	}

	public void setTicketreturnrates(List<Map<String, Object>> ticketreturnrates) {
		this.ticketreturnrates = ticketreturnrates;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Ticketreturnrate getTicketreturnrate() {
		return ticketreturnrate;
	}

	public void setTicketreturnrate(Ticketreturnrate ticketreturnrate) {
		this.ticketreturnrate = ticketreturnrate;
	}

	public long getHoursbetweendeparttime() {
		return hoursbetweendeparttime;
	}

	public void setHoursbetweendeparttime(long hoursbetweendeparttime) {
		this.hoursbetweendeparttime = hoursbetweendeparttime;
	}

	public BigDecimal getReturnrate() {
		return returnrate;
	}

	public void setReturnrate(BigDecimal returnrate) {
		this.returnrate = returnrate;
	}

	public boolean isIslinework() {
		return islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}
	

}
