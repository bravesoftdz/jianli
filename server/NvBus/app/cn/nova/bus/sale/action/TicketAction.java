package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketAction extends BaseAction{
	private Ticketsell ticketsell;
	private List<Map<String, Object>> ticketsellmap;

	private TicketService ticketService;
	
	private String ticketno;//用来判断流水班是否有发车记录
	private String departdate;//用来判断流水班是否有发车记录
	
	private Long departinvoicesotherid;
	
	public String getDepartdate() {
		return departdate;
	}


	public void setDepartdate(String departdate) {
		this.departdate = departdate;
	}

	private boolean isexitlinework;//用来判断流水班是否有发车记录的返回结果
	
	public boolean isIsexitlinework() {
		return isexitlinework;
	}


	public void setIsexitlinework(boolean isexitlinework) {
		this.isexitlinework = isexitlinework;
	}


	public String getTicketno() {
		return ticketno;
	}


	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public Long getDepartinvoicesotherid() {
		return departinvoicesotherid;
	}


	public void setDepartinvoicesotherid(Long departinvoicesotherid) {
		this.departinvoicesotherid = departinvoicesotherid;
	}


	/**
	 * 查询单表(售票表)，用于重的车票
	 * @return
	 */
	public String query() {
		try {
			ticketService = new TicketServiceImpl();
			setTicketsellmap(ticketService.find(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * @Title queryTicketByTicketno
	 * @Description 查询单表(售票表)，关联departinvoicesothersell
	 * @param ticketno
	 * @return String 
	 * @author tianhb
	 * @date 2016年6月13日-下午9:47:56
	 * @update 
	 * @throws
	 */
	public String queryTicketByTicketno() {
		try {
			ticketService = new TicketServiceImpl();
			setTicketsellmap(ticketService.queryTicketByTicketno(ticketno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * @Title queryTicketByDepartinvoicesotherdetailid
	 * @Description 查询(售票表)，关联departinvoicesothersell
	 * @param departinvoicesotherid
	 * @return 
	 * String 
	 * @author tianhb
	 * @date 2016年6月13日-下午9:47:34
	 * @update 
	 * @throws
	 */
	private Long departinvoicesotherdetailid;
	public Long getDepartinvoicesotherdetailid() {
		return departinvoicesotherdetailid;
	}


	public void setDepartinvoicesotherdetailid(Long departinvoicesotherdetailid) {
		this.departinvoicesotherdetailid = departinvoicesotherdetailid;
	}


	public String queryTicketByDepartinvoicesotherdetailid() {
		try {
			ticketService = new TicketServiceImpl();
			setTicketsellmap(ticketService.queryTicketByDepartinvoicesotherdetailid(departinvoicesotherdetailid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 查询当前票号对应的线路下的流水班是否存在发车记录
	 * @return
	 */
	public String findlineworkIsdepart()
	{
		try {
			ticketService = new TicketServiceImpl();
			isexitlinework = ticketService.lineworkexistdepart(ticketno,departdate);
			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
		
		
	}
	
	/**
	 * 改票查询
	 * @return
	 */
	public String findTicketChange() {
		try {
			ticketService = new TicketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			setTicketsellmap(ticketService.findTicketChange(ServletPropertyFilterUtil
					.buildFromHttpRequest(),global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询售本站票+售异站票的总数
	 * @return
	 */
	public String qryticketsellwham() {
		try {
			ticketService = new TicketServiceImpl();
			setTicketsellmap(ticketService.qryTicketsell(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public Ticketsell getTicketsell() {
		return ticketsell;
	}

	public void setTicketsell(Ticketsell ticketsell) {
		this.ticketsell = ticketsell;
	}

	public List<Map<String, Object>> getTicketsellmap() {
		return ticketsellmap;
	}

	public void setTicketsellmap(List<Map<String, Object>> ticketsellmap) {
		this.ticketsellmap = ticketsellmap;
	}

}
