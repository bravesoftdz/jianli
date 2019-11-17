package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import models.RemoteTransaction;
import play.db.jpa.JPA;
import play.mvc.Http.Request;
import util.AppConstant;
import util.CurrentUtil;
import util.JsonUtil;
import util.TransactionUtil;
import util.TransactionUtil.TransactionType;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Seatreserveagent;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.dispatch.service.impl.SeatreserveServiceImpl;
import cn.nova.bus.netsale.service.NetTicketSellOtherService;
import cn.nova.bus.netsale.service.impl.NetTicketSellOtherServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SeatreserveAction extends BaseAction{
	private Seatreserve seatreserve;
	private List<Map<String, Object>> seatreservemap;
	private String seatnos;
	private List<Seatreserve> seatreserves;

	private SeatreserveService seatreserveService;
	
	private boolean isnet;
	private RemoteTransaction remoteTransaction;

	public String qryempty() {
		setSeatreservemap(ListUtil.listToMap(
				new Object[] { Seatreserve.class }, null));
		return "json";
	}

	public String querySingleTable() {
		seatreserveService = new SeatreserveServiceImpl();
		setSeatreservemap(ListUtil.listToMap(
				new Object[] { Seatreserve.class },
				seatreserveService.querySingleTable(ServletPropertyFilterUtil
						.buildFromHttpRequest())));
		return "json";
	}
	
	private long customerid;
	private int bookunsellcount;
	public String querybookunsellcount() {//按顾客查询订票未取次数
		bookunsellcount = 0;
		try {
			seatreserveService = new SeatreserveServiceImpl();
			bookunsellcount = seatreserveService.querybookunsellcount(customerid);
			msg = "查询订票未取次数成功！";
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "查询订票未取次数失败:" + e.getMessage();
			markFail();
		}
		return "json";
	}

	/*之前的订票方法，不支持联网订票
	public String reservelist() {// 留位（批量）
		Global global = CurrentUtil.getGlobal();
		for (Seatreserve seatreserve : seatreserves) {
			Date now = new Date();
			seatreserve.setReserveby(global.getUserinfo().getId());
			seatreserve.setReserveip(global.getIpAddress());
			seatreserve.setCreateby(global.getUserinfo().getId());
			seatreserve.setUpdateby(global.getUserinfo().getId());
			seatreserve.setReserveway("1");// 订票
			seatreserve.setTurnoverdetail(null);
			seatreserve.setCreatetime(now);
			seatreserve.setUpdatetime(now);
			seatreserve.setReservetime(now);
		}
		try {
			seatreserveService = new SeatreserveServiceImpl();
			MethodResult res=seatreserveService.save(seatreserves);
			msg = res.getResultMsg();
			markFlag(res.getResult());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "订票失败:" + e.getMessage();
			markFail();
		}
		return "json";
	}
	*/
	
	/**
	 * 本地/联网   订票
	 * @return
	 */
	public String reservelist() {// 留位（批量）
		Global global = CurrentUtil.getGlobal();
		for (Seatreserve sret : seatreserves) {
			Date now = new Date();
			sret.setReserveby(global.getUserinfo().getId());
			sret.setReserveip(global.getIpAddress());
			sret.setCreateby(global.getUserinfo().getId());
			sret.setUpdateby(global.getUserinfo().getId());
			sret.setReserveway("1");// 订票
			sret.setTurnoverdetail(null);
			sret.setCreatetime(now);
			sret.setUpdatetime(now);
			sret.setReservetime(now);
			sret.setReserveorgid(global.getUserinfo().getOrgid());
			isnet = sret.getIsnet();
		}
		play.Logger.info("是否是联网订票: " + isnet);
		
		Iterator<Seatreserve> iterator = seatreserves.iterator();
		while (iterator.hasNext()) {
			Seatreserve seatreserve = iterator.next();
			if ("E".equals(seatreserve.getTickettype())) {
				//留位时，若为儿童票，则移除
				play.Logger.info("留位参数移除儿童票：Scheduleplanid=" + seatreserve.getScheduleplanid() + "，seatno=" + seatreserve.getSeatno());
				iterator.remove();
			}
		}
		
		try {
			MethodResult res = new MethodResult();
			if(isnet){
				RemoteTransaction remoteTransaction = new RemoteTransaction();
				remoteTransaction.id = UUID.randomUUID().toString();
				remoteTransaction.formip = Request.current().host;
				remoteTransaction.type = TransactionType.SELL_TICKET.ordinal();
				remoteTransaction.createDate = new Date();
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("seatreserves", JsonUtil.toFormatString(seatreserves));
				remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
				remoteTransaction.save();
				
				NetTicketSellOtherService netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
				res = netTicketSellOtherService.reserveSeat(remoteTransaction.id, seatreserves,global);
				
				remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_SUCCESS;
				remoteTransaction.save();
			}else{
				seatreserveService = new SeatreserveServiceImpl();
				res=seatreserveService.save(seatreserves);
			}
			msg = res.getResultMsg();
			markFlag(res.getResult());
		} catch (Exception e) {
			play.Logger.error("订票失败:" + e.getMessage());
			msg = "订票失败:" + e.getMessage();
			markFail();
		}
		return "json";
	}
	
	public String query() {
		try {
			seatreserveService = new SeatreserveServiceImpl();
			setSeatreservemap(seatreserveService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String sell() {
		Global global = CurrentUtil.getGlobal();
		try {
			seatreserveService = new SeatreserveServiceImpl();
			if (seatreserve != null) {
				if (seatreserve.getId() > 0) {
					Seatreserve reserve = seatreserveService
							.getById(seatreserve.getId());
					reserve.setTickettype(seatreserve.getTickettype());
					reserve.setFullprice(seatreserve.getFullprice());
					reserve.setReserveby(global.getUserinfo().getId());
					reserve.setReserveip(global.getIpAddress());
					reserve.setUpdateby(global.getUserinfo().getId());
					reserve.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					reserve.setSellstate("S");
					markSuccess();
					//setMsg("留位售出成功！");
					MethodResult res=seatreserveService.save(reserve, null);
					markFlag(res.getResult());
					setMsg(res.getResultMsg());
					
				}
			}
		} catch (Exception e) {
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String reserve() {// 留位
		Global global = CurrentUtil.getGlobal();
		seatreserveService = new SeatreserveServiceImpl();
		if (seatreserve != null) {
			
			//添加事务
			RemoteTransaction remoteTransaction = RemoteTransaction.makeRemoteTransaction(TransactionType.RESERVE_SEAT);
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("seatreserve", JsonUtil.toFormatString(seatreserve));
			requestMap.put("seatnos", seatnos);
			remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
			remoteTransaction.save();
			
			//提交并新开事务
			JPA.em().getTransaction().commit();
			JPA.em().getTransaction().begin();
			
			try {
				if (seatreserve.getId() == 0) {
					msg = "你要的座位已经预留成功了！";
					markSuccess();
					seatreserve.setReserveby(global.getUserinfo().getId());
					seatreserve.setReserveip(global.getIpAddress());
					seatreserve.setCreateby(global.getUserinfo().getId());
					seatreserve.setUpdateby(global.getUserinfo().getId());
					seatreserve.setReserveway("0");// 数据字典调度留票对应的CODE
					seatreserve.setTurnoverdetail(null);
					seatreserve.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					seatreserve.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					seatreserve.setReservetime(new Timestamp(System
							.currentTimeMillis()));
				}
				seatreserve.setOrgid(global.getOrganization().getId());
				MethodResult res=seatreserveService.save(remoteTransaction.id, seatreserve, seatnos);
				markFlag(res.getResult());
				setMsg(res.getResultMsg());
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "留位失败:" + e.getMessage();
				markFail();
				
				TransactionUtil.setRollbackOnly();
				String transactionid = remoteTransaction.id;
				String remoteurl =  CurrentUtil.getFlash("remoteurl");
				if(transactionid != null && remoteurl != null){
					TransactionUtil.addUndoJob(transactionid, remoteurl);
				}
			}
		}
		return "json";
	}

	public String cancel() {// 取消留位
		Global global = CurrentUtil.getGlobal();
		seatreserveService = new SeatreserveServiceImpl();
		if (seatreserve != null) {
			try {
				if (seatreserve.getId() == 0) {
					seatreserve.setCancel(global.getUserinfo());
					seatreserve.setUpdateby(global.getUserinfo().getId());
					seatreserve.setCanceltime(new Timestamp(System
							.currentTimeMillis()));
					seatreserve.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "你要取消的座位已成功取消了！";
					markSuccess();
				}
				seatreserve.setOrgid(global.getOrganization().getId());
				MethodResult res=seatreserveService.cancelReserve(seatreserve, seatnos);
				if (res.getResult()==0) {
					msg = "取消留位保存失败！";
					markFail();
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "取消留位异常:" + e.getMessage();
				markFail();

				TransactionUtil.setRollbackOnly();
			}
		}
		return "json";
	}

	public String cancelseatreserve() {
		Global global = CurrentUtil.getGlobal();
		try {
			seatreserveService = new SeatreserveServiceImpl();
			if (seatreserve != null) {
				if (seatreserve.getId() > 0) {
					Seatreserve reserve = seatreserveService
							.getById(seatreserve.getId());
					
					/**联网订票暂不支持取消  #6946 【十堰中心】联网票，订位之后取消留位，出现null */
					if (reserve == null) {
						Seatreserveagent reserveAgent = seatreserveService.getAgentById(seatreserve.getId());
						if (reserveAgent!=null) {
							setMsg("联网订票不支持取消留位！");
						}else {
							setMsg("留位取消失败！");
						}
						markFail();
						return "json";
					}
					
					reserve.setSellstate("C");
					reserve.setCancel(global.getUserinfo());
					reserve.setCanceltime(new Date());
					reserve.setUpdateby(global.getUserinfo().getId());
					reserve.setUpdatetime(new Date());
					markSuccess();
					setMsg("留位取消成功！");
					seatreserve.setOrgid(global.getOrganization().getId());
					MethodResult res=seatreserveService.cancelReserve(reserve, null);
					if (res.getResult()==0) {
						TransactionUtil.setRollbackOnly();
						markSuccess();
						setMsg("留位取消失败！");
						return "json";
					}
				}
			}
		} catch (Exception e) {
			markFail();
			setMsg("留位取消异常:" + e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public Seatreserve getSeatreserve() {
		return seatreserve;
	}

	public void setSeatreserve(Seatreserve seatreserve) {
		this.seatreserve = seatreserve;
	}

	public List<Map<String, Object>> getSeatreservemap() {
		return seatreservemap;
	}

	public void setSeatreservemap(List<Map<String, Object>> seatreservemap) {
		this.seatreservemap = seatreservemap;
	}

	public String getSeatnos() {
		return seatnos;
	}

	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}

	public void setSeatreserves(List<Seatreserve> seatreserves) {
		this.seatreserves = seatreserves;
	}

	public List<Seatreserve> getSeatreserves() {
		return seatreserves;
	}

	public long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public int getBookunsellcount() {
		return bookunsellcount;
	}

	public void setBookunsellcount(int bookunsellcount) {
		this.bookunsellcount = bookunsellcount;
	}

}
