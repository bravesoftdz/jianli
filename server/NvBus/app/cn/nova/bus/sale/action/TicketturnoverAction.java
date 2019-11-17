package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CommonUtil;
import util.CurrentUtil;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketturnover;
import cn.nova.bus.sale.service.TicketturnoverService;
import cn.nova.bus.sale.service.impl.TicketturnoverServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketturnoverAction extends BaseAction{
	private Ticketturnover ticketturnover;
	private List<Map<String, Object>> turnoverMap;
	private List<Map<String, Object>> ticketturnoverMap;
	private List<Map<String,Object>>  ticketturnoverdetailMap;//用来存储缴款的退票和废票明细
	public List<Map<String, Object>> getTicketturnoverdetailMap() {
		return ticketturnoverdetailMap;
	}

	public void setTicketturnoverdetailMap(
			List<Map<String, Object>> ticketturnoverdetailMap) {
		this.ticketturnoverdetailMap = ticketturnoverdetailMap;
	}

	private Long ticketturnoverid;
	private String ticketdetail;
	private String insuredetail;
	private long seller;
	private String returnticketno;
	private String cancelticketno;
	private String damagedticketno;
	private String returninsureno;
	private String cancelinsureno;
	private String damagedinsureno;
	private Date moneydate;
	private Long billtypeid;
	
	private TicketturnoverService turnoverService;

	/**
	 * 查询售票员已缴款信息，用来重打缴款单
	 * @return
	 */
	public String queryTurnover() {
		Global global = CurrentUtil.getGlobal();
		turnoverService = new TicketturnoverServiceImpl();
		setTurnoverMap(turnoverService.query(ServletPropertyFilterUtil
				.buildFromHttpRequest(),global));
		return "json";
	}

	/**
	 * 根据缴款ID，获取缴款的信息，用来打印缴款单
	 * @return
	 */
	public String queryTicketturnover() {
		turnoverService = new TicketturnoverServiceImpl();
		setTicketturnoverMap(turnoverService
				.queryTicketturnover(ticketturnoverid));
		return "json";
	}
/**
 * 根据缴款ID，来获取缴款的退票明细（票号和金额）废票明细（票号和金额）
 * @return
 */
	public String queryticketturnoverReturnAndCancel()
	{
		turnoverService = new TicketturnoverServiceImpl();
		setTicketturnoverdetailMap(turnoverService.queryticketturnoverReturnAndCancel(ticketturnoverid));
		return "json";
	}
	
	/**
	 * 查询未缴款营收或已缴款营收的  退票/废票  票号和金额
	 * @param buildFromHttpRequest：包含多个或单个ticketturnoverdeatilid和是否已缴款isturnover
	 * 此类似于上面的方法，上面的方法只能查询  某个tickturnover 对应的记录
	 * @return
	 */
	public String qryRtnCelByTktoverDetails(){
		turnoverService = new TicketturnoverServiceImpl();
		setTicketturnoverdetailMap(turnoverService.qryRtnCelByTktoverDetails(
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String query() {//该方法已停用
		try {
//			setTicketturnoverMap(turnoverService.queryTicketturnover(
//					ticketturnoverid, returnticketno, cancelticketno,
//					damagedticketno, returninsureno, cancelinsureno,
//					damagedinsureno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryTicket() {
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTurnoverMap(turnoverService.queryTurnover(seller));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			turnoverService = new TicketturnoverServiceImpl();
			if (ticketturnover != null) {
				if (ticketturnover.getId() > 0) {
					markSuccess();
					setMsg("修改成功");
				} else {
					markSuccess();
					
					setMsg("缴款成功");
					ticketturnover.setCreatetime(new Date());
					ticketturnover.setReceipttime(new Date());
					ticketturnover.setTurnovertime(new Date());
					ticketturnover.setReceiptip(global.getIpAddress());
					ticketturnover.setCreateby(global.getUserinfo().getId());
					ticketturnover.setReceiver(global.getUserinfo().getId());
					ticketturnover.setReceiptorgid(global.getOrganization()
							.getId());
				}
//				ticketturnover = turnoverService.save(ticketturnover,
//						ticketdetail, insuredetail);
				//调用新的缴款方法，同吉林版本：将保险和车票的缴款明细添加 实收和本期溢欠款字段 并赋值
				ticketturnover = turnoverService.saveTicketturnover(ticketturnover, ticketdetail, insuredetail);
				setTicketturnoverid(ticketturnover.getId());  
				
				
				if (ticketturnover.getId() == 0) {
					markSuccess();
					setMsg("缴款失败");
				}
			}
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String queryticket() {
//		setTicketturnoverMap(turnoverService.queryTicketturnover(5203251,
//				returnticketno, cancelticketno, damagedticketno,
//				returninsureno, cancelinsureno, damagedinsureno));
		return "json";
	}

	public String queryTicketturnovermoney(){
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTicketturnoverMap(turnoverService.queryTurnoverMoney(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 售票员解款情况查询
	 * @return
	 */
	public String queryTicketseller(){
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTicketturnoverMap(turnoverService.queryTicketseller(moneydate, seller));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	private String turnoverid;
	
	public String cancelturnover() {
		Global global = CurrentUtil.getGlobal();
		try {
			turnoverService = new TicketturnoverServiceImpl();
			if (CommonUtil.isEmptyString(turnoverid)) {
				markSuccess();
				setMsg("注销缴款成功！");
			}else {
				if (turnoverService.cancelTurnover(turnoverid,global)) {
					markSuccess();
					setMsg("注销缴款成功！");
				}else {
					markFail();
					setMsg("注销缴款失败！");
				}
			}
		} catch (BusinessException e) {
			markFail();
			setMsg(e.getMessage());
		} catch (Exception e) {
			markFail();
			play.Logger.error("注销缴款失败！", e);
			setMsg("注销缴款失败！");
		}
		return "json";
	}
	
	public String getTurnoverid() {
		return turnoverid;
	}

	public void setTurnoverid(String turnoverid) {
		this.turnoverid = turnoverid;
	}

	/**
	 * 日营收单查询
	 * @return
	 */
	public String queryRevenueOfDay(){
		play.Logger.info("billtypeid:%s", billtypeid);
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTicketturnoverMap(turnoverService.queryRevenueOfDay(billtypeid,ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 根据缴款ID，来获取缴款的退保明细（票号和金额）废保明细（票号和金额）
	 * @return
	 */
	public String queryinsurenceturnover(){
		turnoverService = new TicketturnoverServiceImpl();
		setTicketturnoverMap(turnoverService.queryinsurenceturnover(ticketturnoverid));
		return "json";
	}
	/**
	 * 查询退费改保记录
	 * @return
	 */
	public String queryinsurenceturnoverReturnAndCancel(){
		turnoverService = new TicketturnoverServiceImpl();
		setTicketturnoverdetailMap(turnoverService.queryinsurenceturnoverReturnAndCancel(ticketturnoverid));
		return "json";
	}
	/**
	 * 查询退保，废保，改保张数
	 * @return
	 */
	public String qryRtnCelByIstoverDetails(){
		turnoverService = new TicketturnoverServiceImpl();
		setTicketturnoverdetailMap(turnoverService.qryRtnCelByIstoverDetails(
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	/**
	 * 根据缴款id 查询电子退票相关的打印数据源
	 * @return
	 */
	private String ticketturnoverids;
	
	public String qryReturnMoney(){
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTicketturnoverMap(turnoverService.qryReturnMoney(ticketturnoverids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String getTicketturnoverids() {
		return ticketturnoverids;
	}

	public void setTicketturnoverids(String ticketturnoverids) {
		this.ticketturnoverids = ticketturnoverids;
	}

	/**
	 * 缴款之后查询网售取票张数和金额
	 * turnover/queryWebTakedInfo
	 * @return
	 */
	private List<Map<String, Object>> tickettakedMap;
	
	public List<Map<String, Object>> getTickettakedMap() {
		return tickettakedMap;
	}

	public void setTickettakedMap(List<Map<String, Object>> tickettakedMap) {
		this.tickettakedMap = tickettakedMap;
	}

	public String queryWebTakedInfo()	{
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTickettakedMap(turnoverService.queryWebTakedInfo(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 售票员解款情况查询
	 * @return
	 */
	public String queryWebInfoGroup(){
		try {
			turnoverService = new TicketturnoverServiceImpl();
			setTicketturnoverMap(turnoverService.queryWebInfoGroup(ticketturnoverid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public Ticketturnover getTicketturnover() {
		return ticketturnover;
	}

	public void setTicketturnover(Ticketturnover ticketturnover) {
		this.ticketturnover = ticketturnover;
	}

	public List<Map<String, Object>> getTurnoverMap() {
		return turnoverMap;
	}

	public void setTurnoverMap(List<Map<String, Object>> turnoverMap) {
		this.turnoverMap = turnoverMap;
	}

	public String getTicketdetail() {
		return ticketdetail;
	}

	public void setTicketdetail(String ticketdetail) {
		this.ticketdetail = ticketdetail;
	}

	public String getInsuredetail() {
		return insuredetail;
	}

	public void setInsuredetail(String insuredetail) {
		this.insuredetail = insuredetail;
	}

	public long getSeller() {
		return seller;
	}

	public void setSeller(long seller) {
		this.seller = seller;
	}

	public String getReturnticketno() {
		return returnticketno;
	}

	public void setReturnticketno(String returnticketno) {
		this.returnticketno = returnticketno;
	}

	public String getCancelticketno() {
		return cancelticketno;
	}

	public void setCancelticketno(String cancelticketno) {
		this.cancelticketno = cancelticketno;
	}

	public String getDamagedticketno() {
		return damagedticketno;
	}

	public void setDamagedticketno(String damagedticketno) {
		this.damagedticketno = damagedticketno;
	}

	public String getReturninsureno() {
		return returninsureno;
	}

	public void setReturninsureno(String returninsureno) {
		this.returninsureno = returninsureno;
	}

	public String getCancelinsureno() {
		return cancelinsureno;
	}

	public void setCancelinsureno(String cancelinsureno) {
		this.cancelinsureno = cancelinsureno;
	}

	public String getDamagedinsureno() {
		return damagedinsureno;
	}

	public void setDamagedinsureno(String damagedinsureno) {
		this.damagedinsureno = damagedinsureno;
	}

	public List<Map<String, Object>> getTicketturnoverMap() {
		return ticketturnoverMap;
	}

	public void setTicketturnoverMap(List<Map<String, Object>> ticketturnoverMap) {
		this.ticketturnoverMap = ticketturnoverMap;
	}

	public Long getTicketturnoverid() {
		return ticketturnoverid;
	}

	public void setTicketturnoverid(Long ticketturnoverid) {
		this.ticketturnoverid = ticketturnoverid;
	}

	public Date getMoneydate() {
		return moneydate;
	}

	public void setMoneydate(Date moneydate) {
		this.moneydate = moneydate;
	}

	public Long getBilltypeid() {
		return billtypeid;
	}

	public void setBilltypeid(Long billtypeid) {
		this.billtypeid = billtypeid;
	}


	
}
