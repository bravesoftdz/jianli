package cn.nova.bus.sale.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.persistence.Transient;
import javax.xml.crypto.Data;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import models.RemoteTransaction;
import play.db.jpa.JPA;
import play.mvc.Http.Request;
import util.AppConstant;
import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;
import util.TransactionUtil;
import util.TransactionUtil.TransactionType;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.service.RouteService;
import cn.nova.bus.base.service.impl.RouteServiceImpl;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.dispatch.service.impl.TicketpriceServiceImpl;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.netsale.service.NetTicketSellOtherService;
import cn.nova.bus.netsale.service.impl.NetTicketSellOtherServiceImpl;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.service.ScheduleDiscountPriceService;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.price.service.impl.ScheduleDiscountPriceServiceImpl;
import cn.nova.bus.price.service.impl.TicketpriceformulaServiceImpl;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.bus.sale.model.ScheduleDetail;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.impl.TicketSellServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.openapi.converter.DictConverter;
import cn.nova.openapi.model.EncryptRequest;
import cn.nova.openapi.model.request.SeatOrder;
import cn.nova.openapi.model.request.TicketSellOrder;
import cn.nova.openapi.sevice.OpenApiAdapter;
import cn.nova.openapi.sevice.impl.OpenApiAdapterImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

@SuppressWarnings("unused")
public class TicketSellAction extends BaseAction{
	private TicketSellService ticketSellService;
	private NetTicketSellOtherService netTicketSellOtherService;
	private ScheduleDiscountPriceService sdiscountpriceService;

	private OrganizationService organizationService;
	
	//公用变量
	private int isnet;//是否请求联网票 0不联网，1本集团联网，2省中心联网
	private Date departdate;
	private String schedulesynccode;
	private String departstationcode;
	private String reachstationcode;
	
	private String ticketentrance;
	private String buspark;
	
	//班次查询条件
	private ScheduleAskCondition scheduleAskCondition;
	//班次查询结果
	private List<Map<String,Object>> preSaleSchedules;
	private BigDecimal discountprice;
	private BigDecimal roundprice;
	private BigDecimal connectprice;
	public String findSchedule(){
		Global global = CurrentUtil.getGlobal();
		if(isnet == 1){
			netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
			MethodResult methodResult;
			try {
				methodResult = netTicketSellOtherService.findNetSchedule(getScheduleAskCondition(), global);
				setPreSaleSchedules((List<Map<String, Object>>) methodResult.getObject());
				setMsg(methodResult.getResultMsg());
				markFlag(methodResult.getResult());
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markFlag(MethodResult.FAILURE);
				TransactionUtil.setRollbackOnly();
			}
		}else if(isnet == 2){
			OpenApiAdapter oa = new OpenApiAdapterImpl();
			MethodResult result;
			try {
				result = oa.findSchedule(scheduleAskCondition);
				if(result.getResult() == MethodResult.SUCCESS){
					setPreSaleSchedules((List<Map<String, Object>>) result.getObject());
					markSuccess();
				}else{
					markFail();
					setMsg(result.getResultMsg());
				}
			} catch (Exception e) {
				markFail();
				setMsg("查询班次失败！");
				play.Logger.error(e.getMessage(), e);
			}
		}else{
			ticketSellService = new TicketSellServiceImpl();
			setPreSaleSchedules(ticketSellService.findSchedule(getScheduleAskCondition(),global));
			setMsg("");
			markSuccess();
		}
		return "json";
	}
	
	//查询联网、不联网已售详情
	private ScheduleDetail scheduleDetail;
	private List<Map<String,Object>> saleSchedulesDetail1;
	private List<Map<String,Object>> saleSchedulesDetail2;
	private int soldnum;
	private int reserved;
	
	public String  findScheduleDetail(){
		Global global = CurrentUtil.getGlobal();
		MethodResult methodResult;
		if(isnet == 1){
			play.Logger.info("isnet == 1 findSchedule begin");
			netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
			try {
				methodResult = netTicketSellOtherService.findNetScheduleDetail(getScheduleDetail(), global);
				Object[] remoteresult = JsonUtil.toObjctArray(methodResult.getObject());
				List<Map<String, Object>> result =null;
				if(remoteresult.length>1){
					List<Ticketprice> ts = JsonUtil.parseArray(remoteresult[1], Ticketprice.class);
					if(ts!=null){
						int s=ts.get(0).getAutocancelreserveseatnum()+ts.get(0).getUnautocancelreserveseatnum()+ts.get(0).getFixedreserveseatnum();
						int soldnum = ts.get(0).getSoldeatnum();
						int seatnum = ts.get(0).getSeatnum();
						setSeatnum(seatnum);
						setResidueseatnum(seatnum-soldnum-s);
						setSoldnum(soldnum);
						setReserved(s);
					}
					result = JSON.parseObject(remoteresult[0].toString(),new TypeReference<List<Map<String,Object>>>(){});
				}else{
					result = JSON.parseObject(methodResult.getObject().toString(),new TypeReference<List<Map<String,Object>>>(){});
				}
				setSaleSchedulesDetail1(result);
				setMsg(methodResult.getResultMsg());
				markFlag(methodResult.getResult());
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markFlag(MethodResult.FAILURE);
			}
			play.Logger.info("isnet == 1 findSchedule end");
		}else{
			//跨区配载班次 查中心数据
			if("3".equals(getScheduleDetail().getWorktype())&&!getScheduleDetail().isIslinework()){
				NetTicketSellOtherService netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
				try {
					methodResult = netTicketSellOtherService.findStowageScheduleDetail(getScheduleDetail(), global);
					setSaleSchedulesDetail1((List<Map<String, Object>>) methodResult.getObject());
					setMsg(methodResult.getResultMsg());
					markFlag(methodResult.getResult());
				} catch (Exception e) {
					play.Logger.error(e.getMessage(), e);
					setMsg(e.getMessage());
					markFlag(MethodResult.FAILURE);
				}
			}else{
				ticketSellService = new TicketSellServiceImpl();
				setSaleSchedulesDetail1(ticketSellService.findScheduleDetail(getScheduleDetail()));
				setMsg("");
				markSuccess();
			}
		}
		return "json";
	}
	public String  findScheduleDetail2(){
		Global global = CurrentUtil.getGlobal();
		MethodResult methodResult;
		if(isnet == 1){
			play.Logger.info("isnet == 1 findScheduleDetail2 begin");
			netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
			try {
				methodResult = netTicketSellOtherService.findNetScheduleDetail(getScheduleDetail(), global);
				setSaleSchedulesDetail2((List<Map<String, Object>>) methodResult.getObject());
				setMsg(methodResult.getResultMsg());
				markFlag(methodResult.getResult());
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markFlag(MethodResult.FAILURE);
			}
			play.Logger.info("isnet == 1 findScheduleDetail2 end");
		}else{
			if("3".equals(getScheduleDetail().getWorktype())&&!getScheduleDetail().isIslinework()){
				NetTicketSellOtherService netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
				try {
					methodResult = netTicketSellOtherService.findStowageScheduleDetail(getScheduleDetail(), global);
					setSaleSchedulesDetail2((List<Map<String, Object>>) methodResult.getObject());
					setMsg(methodResult.getResultMsg());
					markFlag(methodResult.getResult());
				} catch (Exception e) {
					play.Logger.error(e.getMessage(), e);
					setMsg(e.getMessage());
					markFlag(MethodResult.FAILURE);
				}
			}else{
				ticketSellService = new TicketSellServiceImpl();
				setSaleSchedulesDetail2(ticketSellService.findScheduleDetail2(getScheduleDetail()));
				setMsg("");
				markSuccess();
			}
		}
		return "json";
	}
	
	
	//查询剩余座位及票价输入参数
	private String sellway;
	private long ticketpriceid;
	
	private String seattype;

	//班次座位状态查询结果
	private List<Map<String,Object>> scheduleseats;
	private int seatnum;
	private int residueseatnum;
	private BigDecimal halfprice;
	private BigDecimal studentprice;
	private String departtime;
	private String departtimeinput;
	private Boolean isrealnameticket;
	/**
	 * 取座位状态信息列表、座位数、余票、发车时间、票价
	 * @return scheduleseats seatnum residueseatnum halfprice studentprice departtime
	 * @throws Exception 
	 */
	public String findScheduleseats(){
		ticketSellService = new TicketSellServiceImpl();
		Global global = CurrentUtil.getGlobal();
		List<PropertyFilter> propertyFilters = ServletPropertyFilterUtil.buildFromHttpRequest();
		netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
		if(isnet == 1){
			//取剩余座数及最新票价
			MethodResult methodResult = null;
			try {
				methodResult = netTicketSellOtherService.findTicketPrices(getDepartdate(),getSchedulesynccode(),getDepartstationcode(),getReachstationcode(),getSeattype(), global,departtimeinput);
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markFlag(MethodResult.FAILURE);
				TransactionUtil.setRollbackOnly();
				return "json";
			}
			if(methodResult.getResult()==1){
				Object[] remoteresult = (Object[]) methodResult.getObject();
				Ticketprice ticketprice = (Ticketprice) remoteresult[0];
				setSeatnum(ticketprice.getSeatnum());
				setResidueseatnum(ticketprice.getSeatnum()-ticketprice.getSoldeatnum()-ticketprice.getFixedreserveseatnum()
							-ticketprice.getAutocancelreserveseatnum()-ticketprice.getUnautocancelreserveseatnum());
				if(getResidueseatnum()<0){
					setResidueseatnum(0);
				}
				setIsrealnameticket((Boolean)remoteresult[3]);
				setFullprice(ticketprice.getFullprice());
				setHalfprice(ticketprice.getHalfprice());
				setStudentprice(ticketprice.getStudentprice());
				setDiscountprice(ticketprice.getDiscountprice());
				setRoundprice(ticketprice.getRoundprice());
				setConnectprice(ticketprice.getConnectprice());
				setDeparttime((String) remoteresult[1]);
				//判断是内部联网还是江西省联网
				organizationService = new OrganizationServiceImpl();
				Organization departorg = organizationService.getOrgByStationCode(departstationcode);
				if("8".equals(departorg.getType())){
					//模拟座位图
					List<Object> scheduleseatss = new ArrayList<Object>();
					Date now = new Date();
					for (int i = 0; i < getSeatnum(); i++) {
						Scheduleseats scheduleseats = new Scheduleseats();
						scheduleseats.setCreateby(0L);
						scheduleseats.setCreatetime(now);
						scheduleseats.setDepartdate(getDepartdate());
						scheduleseats.setId(i);
						scheduleseats.setOrgid(0L);
						scheduleseats.setScheduleid(0L);
						scheduleseats.setSeatno((short) (i+1));
						scheduleseats.setSeattype(getSeattype());
						scheduleseats.setStatus("0");
						scheduleseats.setTickettype(null);
						scheduleseats.setUpdateby(0L);
						scheduleseats.setUpdatetime(now);
						scheduleseatss.add(scheduleseats);
					}
					setScheduleseats(ListUtil.listToMap(new Object[]{Scheduleseats.class}, scheduleseatss));
				}else{
					//合并取票价和座位图的过程，在同一个methodresult中返回
					if(remoteresult.length>2){
						List<Map<String, Object>> result = JSON.parseObject(remoteresult[2].toString(),new TypeReference<List<Map<String,Object>>>(){});
//						setScheduleseats((List<Map<String, Object>>) remoteresult[2]);
						setScheduleseats(result);
					}else{
						try {
							methodResult =	netTicketSellOtherService.findScheduleseats(getDepartdate(),getSchedulesynccode(),getDepartstationcode(), global);
						} catch (Exception e) {
							play.Logger.error(e.getMessage(), e);
							markFlag(MethodResult.FAILURE);
							setMsg(e.getMessage());
							TransactionUtil.setRollbackOnly();
							return "json";
						}
						if(methodResult.getResult()==1){
							setScheduleseats((List<Map<String, Object>>) methodResult.getObject());
//							setResidueseatnum(0);
//							for (Map<String, Object> scheduleseat : getScheduleseats()) {
//								//座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位  取数据字典
//								if("0".equals(scheduleseat.get("status"))){
//									setResidueseatnum(getResidueseatnum()+1);
//								}
//							}
						}
						else{
							setMsg(methodResult.getResultMsg());
							markFlag(methodResult.getResult());
							setScheduleseats(ListUtil.listToMap(new Object[]{Scheduleseats.class}, null));
							return "json";
						}
					}
				}
			}
			else{
				play.Logger.info(methodResult.getResultMsg());
				setMsg(methodResult.getResultMsg());
				markFlag(methodResult.getResult());
				return "json";
			}
		}
		else{
			MethodResult methodResult = null;
			try {
				CheckticketService checkticketService = new CheckticketServiceImpl();
			    checkticketService.seatnums(scheduleplanid);
				methodResult = ticketSellService.findScheduleseatsByTicketpriceId(ticketpriceid,global);
				play.Logger.info(methodResult.getResultMsg());
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				markFlag(MethodResult.FAILURE);
				setMsg(e.getMessage());
				return "json";
			}
			if(methodResult.getResult()==1){
				setScheduleseats((List<Map<String, Object>>) methodResult.getObject());
			}
			else{
				setMsg(methodResult.getResultMsg());
				markFlag(methodResult.getResult());
				setScheduleseats(ListUtil.listToMap(new Object[]{Scheduleseats.class}, null));
				return "json";
			}
			//取剩余座数及最新票价
			Ticketprice ticketprice = ticketSellService.findTicketPrices(getTicketpriceid(),global.getTicketoutlets().getId());
			setSeatnum(ticketprice.getSeatnum());
			setResidueseatnum(0);
			if("2".equals(ticketprice.getScheduleplan().getWorktype())){
				for (Map<String, Object> scheduleseat : getScheduleseats()) {
					//座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位  取数据字典
					if("0".equals(scheduleseat.get("status"))){
						setResidueseatnum(getResidueseatnum()+1);
					}
				}
			}else{
				setResidueseatnum(ticketprice.getSeatnum()-ticketprice.getSoldeatnum()-ticketprice.getFixedreserveseatnum());
				if(!"6".equals(getSellway())){
					setResidueseatnum(getResidueseatnum()-ticketprice.getAutocancelreserveseatnum()-ticketprice.getUnautocancelreserveseatnum());
				}
			}
			setFullprice(ticketprice.getFullprice());
			setHalfprice(ticketprice.getHalfprice());
			setStudentprice(ticketprice.getStudentprice());
			setDiscountprice(ticketprice.getDiscountprice());
			setRoundprice(ticketprice.getRoundprice());
			setConnectprice(ticketprice.getConnectprice());
		}
		setMsg("");
		markSuccess();
		return "json";
	}
	
	private List<Map<String,Object>> schedulestops;//班次停靠点信息
	/**
	 * 查询班次停靠点列表
	 * @return schedulestops
	 */
	public String findSchedulestops(){
		netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
		TicketpriceService ticketpriceService = new TicketpriceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		//支持查询联网班次
		if(isnet == 1){
			MethodResult methodResult = null;
			try {
				methodResult = netTicketSellOtherService.findSchedulestops(getDepartdate(), getSchedulesynccode(), getDepartstationcode(), global);
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
			}
			if(methodResult.getResult()==1){
				setSchedulestops((List<Map<String, Object>>) methodResult.getObject());
			}
			else{
				setMsg(methodResult.getResultMsg());
				markFlag(methodResult.getResult());
				List<PropertyFilter> propertyFilterList = new ArrayList<PropertyFilter>();
				propertyFilterList.add(new PropertyFilter("EQL_t!departstationid", -11111));
				setSchedulestops(ticketpriceService.findSchedulestops(propertyFilterList));
				return "json";
			}
		}
		else{
			List<PropertyFilter> propertyFilterList = new ArrayList<PropertyFilter>();
			propertyFilterList.add(new PropertyFilter("EQL_t!departstationid", departstationid));
			propertyFilterList.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplanid));
			setSchedulestops(ticketpriceService.findSchedulestops(propertyFilterList));
		}
		markSuccess();
		return "json";
	}
	
	private String tickettypecode;
	private BigDecimal fullprice;
	private BigDecimal tickettypeprice; //返回该车票类型的票价
	private long scheduleid;
	/**
	 * 根据全票价取其它票种票价
	 * @return
	 */
	public String findTickettypePrice(){
		try {
			Global global = CurrentUtil.getGlobal();
			TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();
			BigDecimal price = ticketpriceformulaService.getPrice(scheduleid, getDepartdate(), getTickettypecode(), getFullprice());
			setTickettypeprice(price);
			markSuccess();
			setMsg("");
		} catch (Exception e) {
			markFailure();
			setMsg("获取票种票价失败:"+e.getMessage());
		}
		return "json";
	}
	
	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}	
	
	//锁位相关输入参数
	private String orderno;
	private Long scheduleplanid;
	private long departstationid;
	private String seatnos_S;
	private String selectSeatStatus_S;
	private String selectSeattype;
	private String routecode;
	private String tickettypes_S;
	private String pricess_S;
	
	private String outseatnos_S;
	private String outJxsEticketid_S; //江西省电子票号
	private Date unlocktime;//锁位成功，返回解锁时间
	
	private int takekidnum; //锁位带儿童数
	
	public String lockSeat(){
		try {
			ticketSellService = new TicketSellServiceImpl();
			netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
			setOutseatnos_S("");
			setOutJxsEticketid_S("");
			Global global = CurrentUtil.getGlobal();
			List<Short> seatnos = null;
			if(isnet==1 || isnet==0){
			  seatnos = ConverStringToListShort(getSeatnos_S()); 
			}
			if(isnet == 1){
				//判断是内部联网还是江西省联网，调用不同的接口
				organizationService = new OrganizationServiceImpl();
				Organization departorg = organizationService.getOrgByStationCode(departstationcode);
				if("8".equals(departorg.getType())){
					MethodResult methodResult =	netTicketSellOtherService.lockSeat_Jxs(departdate, departtime, getRoutecode(), schedulesynccode, 
																				departstationcode, reachstationcode, UUID.fromString(getOrderno()), 
																				seatnos,ConverStringToListString(tickettypes_S), 
																				ConverStringToListBigDecimal(pricess_S), selectSeattype, global,getTakekidnum());
					if(methodResult.getResult()==1){
						Object[] returnresult= (Object[]) methodResult.getObject();
						setUnlocktime((Date) returnresult[0]);
						List<String> eticketids = (List<String>) returnresult[1];
						for (String eticketid : eticketids) {
							if("".equals(getOutJxsEticketid_S())){
								setOutJxsEticketid_S(eticketid.toString());
							}
							else{
								setOutJxsEticketid_S(getOutJxsEticketid_S()+","+eticketid);
							}
						}
					}
					else{
						setMsg(methodResult.getResultMsg());
						markFlag(methodResult.getResult());
						return "json";
					}
				}else{
					MethodResult methodResult =	netTicketSellOtherService.lockSeat(UUID.fromString(getOrderno()), 
							getDepartdate(),getSchedulesynccode(),getDepartstationcode(),seatnos,
							ConverStringToListString(getSelectSeatStatus_S()),getSelectSeattype(),global);
					if(methodResult.getResult()==1){
						setUnlocktime((Date) methodResult.getObject());
					}
					else{
						setMsg(methodResult.getResultMsg());
						markFlag(methodResult.getResult());
						return "json";
					}
				}
			}else if(isnet == 2){
				SeatOrder seat = new SeatOrder();
				seat.departorgcode = departstationcode;
				seat.schedulecode = schedulesynccode;
				seat.reachstationcode = reachstationcode;
				seat.departdate = CommonUtil.formatSimpleDate2String(departdate);				
				seat.orderno = AppConstant.getValue("openapi.preorderno")+getOrderno();
//				seat.seattype = DictConverter.convertSeatType(selectSeattype);
				seat.seattype = selectSeattype;
				seat.buildTickets(tickettypes_S, pricess_S);
				OpenApiAdapter openapi = new OpenApiAdapterImpl();
				MethodResult methodResult = openapi.lockSeat(seat);
				if(methodResult.getResult()==1){
					Object[] obj =  (Object[])methodResult.getObject();					
					setUnlocktime((Date)obj[1]);
					String strseatnos = String.valueOf(obj[0]);
					seatnos = ConverStringToListShort(strseatnos);
				}
				else{
					setMsg(methodResult.getResultMsg());
					markFlag(methodResult.getResult());
					return "json";
				}
			}else{
				setUnlocktime(ticketSellService.lockSeat(UUID.fromString(getOrderno()), getScheduleplanid(), 
						seatnos,
						ConverStringToListString(getSelectSeatStatus_S()),
						getSelectSeattype(),global));
			}
			
			Collections.sort(seatnos);
			for (Short seatno : seatnos) {
				if("".equals(getOutseatnos_S())){
					setOutseatnos_S(seatno.toString());
				}
				else{
					setOutseatnos_S(getOutseatnos_S()+","+seatno);
				}
			}
			
			markSuccess();
			setMsg("");
		} catch (Exception e) {
			markFailure();
			setMsg("锁座位失败:"+e.getMessage());
		}
		return "json";
	}

	public String unlockSeat(){
		ticketSellService = new TicketSellServiceImpl();
		netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
		try {
			if(isnet == 1){
				Global global = CurrentUtil.getGlobal();
				MethodResult methodResult =	netTicketSellOtherService.unlockSeat(UUID.fromString(getOrderno()),getDepartstationcode(),global);
				markFlag(methodResult.getResult());
				if(methodResult.getResult()!=1){
					setMsg(methodResult.getResultMsg());
				}
			}else if(isnet == 2){
				OpenApiAdapter openApi = new OpenApiAdapterImpl();
				EncryptRequest param = new EncryptRequest();
				param.put("uid", param.getUid());
				param.put("version",AppConstant.getValue("openapi.version"));
				param.put("orderno", AppConstant.getValue("openapi.preorderno")+getOrderno());
//				param.put("ticketid", ); 单一的电子票号
				MethodResult methodResult = openApi.unLockSeat(param );
				markResult(methodResult);
			}
			else{
				boolean result = false;
				result=ticketSellService.unlockSeat(UUID.fromString(getOrderno()),getScheduleplanid(),ConverStringToListShort(getSeatnos_S()));
				if (result){
					markSuccess();
					setMsg("");
				}
				else{
					markFailure();
					setMsg("解锁座位失败");
				}
			}

		} catch (Exception e) {
			markFailure();
			setMsg("解锁座位失败:"+e.getMessage());
		}
		return "json";
	}

	private TicketOrder order;  //售票订单信息
//	private Long ticketIdToBeChange; //改签的原车票ID
//	private Long insuranceIdToBeChange; //改签的原保单ID
	private String ticketIdToBeChanges; //改签的原车票ID
	private String insuranceIdToBeChanges; //改签的原保单ID
	private int discountpricenum;//售票时输入的优惠票数
	private  BigDecimal hirebustotalprice;//包车票或团体票总金额
	private List<TicketPrintInfo> sellTickets; //售票明细列晴
	private List<Map<String,Object>> ticketsPrintInfo; //售票成功返回车票打印信息
	@SuppressWarnings("unchecked")
	public String sellTicket(){
		ticketSellService = new TicketSellServiceImpl();
		netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
		sdiscountpriceService = new ScheduleDiscountPriceServiceImpl();
		RemoteTransaction remoteTransaction = new RemoteTransaction();
		try {
			remoteTransaction.id = UUID.randomUUID().toString();
			remoteTransaction.formip = Request.current().host;
			remoteTransaction.type = TransactionType.SELL_TICKET.ordinal();
			remoteTransaction.createDate = new Date();
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("order", JsonUtil.toFormatString(order));
			remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
			remoteTransaction.save();
			
			//提交并新开事务
			JPA.em().getTransaction().commit();
			JPA.em().getTransaction().begin();
			
			remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_ING;
			remoteTransaction.save();
			
			if(sellTickets!=null&&sellTickets.size()>0){
				int count = 0;
				Iterator<TicketPrintInfo> ticketprintIterator = sellTickets.iterator();
				while(ticketprintIterator.hasNext()){
					TicketPrintInfo ticketPrintInfo = ticketprintIterator.next();
					if (ticketPrintInfo.getTickettype()!=null) {
					  if(!(ticketPrintInfo.getTickettype().equals("H")||ticketPrintInfo.getTickettype().equals("T"))){
						  hirebustotalprice = hirebustotalprice.subtract(ticketPrintInfo.getPrice());
					  }
					  	
					  if(ticketPrintInfo.getTickettype().equals("H") && count==0){
						  ticketPrintInfo.setPrice(hirebustotalprice);
					  }else if(ticketPrintInfo.getTickettype().equals("H")){
						  ticketPrintInfo.setPrice(new BigDecimal(0));
					  }
					  if(ticketPrintInfo.getTickettype().equals("H")){
					     count++;
					  }   
					}
					if (ticketPrintInfo.getOpertype()!=null){
						if("2".equals(ticketPrintInfo.getOpertype())){
							  ticketprintIterator.remove();
						  }
					}
					  					
					
				}
				if("T".equals(sellTickets.get(0).getTickettype())){
//					BigDecimal tuanTotalmoney = hirebustotalprice;//包车票或团体票总金额（包含保险金额），则打印车票票面上包含保险金额，售票员缴款时团体票保险会重复
					BigDecimal tuanTotalmoney = order.getTotalmoney();//包车票或团体票总金额，不包含保险金额
					
					if((ticketIdToBeChanges != null) && (!"".equals(ticketIdToBeChanges))){
						//改签：
						tuanTotalmoney = order.getTotalmoney().subtract(hirebustotalprice);//改签时票款 = 总收费 - 手续费
					}else{
						//非改签
						tuanTotalmoney = order.getTotalmoney();//包车票或团体票总金额，不包含保险金额
					}
					//前台界面修改团体票价 改为修改单张票价。不用再计算每张票价。此处计算的票价不均衡
					//计算团体票每张票的票价
//					int ticketCount = sellTickets.size();//团体票总张数
//					BigDecimal averageTicketprice = tuanTotalmoney.divide(
//							BigDecimal.valueOf(ticketCount), 1,
//							BigDecimal.ROUND_HALF_EVEN);// 团体票平均票价=团体票总金额/团体票总张数（保留1位小数）
//					BigDecimal firstTicketPrice = BigDecimal.valueOf(averageTicketprice.intValue());//前面的车票票价取整数
//					BigDecimal lastTicketPrice = tuanTotalmoney
//							.subtract(firstTicketPrice.multiply(BigDecimal
//									.valueOf(ticketCount - 1)));// 最后一张票票价 = 总票价-（前面平均票价*（总张数-1））
//					int tempCount = 0;//循环生成团体票时第N张团体票
//					for (int i = 1; i <= sellTickets.size(); i++) {
//						TicketPrintInfo ticketPrintInfo = sellTickets.get(i - 1);
//						if(i < ticketCount){
//							ticketPrintInfo.setPrice(firstTicketPrice);
//						}else{
//							ticketPrintInfo.setPrice(lastTicketPrice);//最后一张团体票票价
//						}
//					}
				}
			}
			order.setTickets(getSellTickets());
			Global global = CurrentUtil.getGlobal();
			order.setSeller(global.getUserinfo().getId());
			MethodResult methodResult = null;
			
			if(isnet == 1){
				//添加事务
				play.Logger.info("-----------本集团联网售票开始-----------");
				methodResult =	netTicketSellOtherService.sellTicket(remoteTransaction.id, order, global);
				play.Logger.info("-----------本集团联网售票结束-----------");
				remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_SUCCESS;
				remoteTransaction.save();
			}else if(isnet == 2){
				OpenApiAdapterImpl openApi = new OpenApiAdapterImpl();
				TicketSellOrder param = new TicketSellOrder();
				param.uid = AppConstant.getValue("openapi.uid");
				param.version = AppConstant.getValue("openapi.version");
				param.equipmentproviders = AppConstant.getValue("openapi.suppliercode");
				param.orderno = AppConstant.getValue("openapi.preorderno")+order.getOrderno();
				param.startticketno = order.getStartTicketNO() ;
				play.Logger.info("-----------省中心联网售票开始-----------");
				methodResult = openApi.sellTick(param, order, ticketentrance, buspark);
				play.Logger.info("-----------省中心联网售票结束-----------");
				markResult(methodResult);
			}
			else if(getTicketIdToBeChanges()!=null&&!getTicketIdToBeChanges().trim().equals("")){
				List<Long> ticketIdToBeChange_list = new ArrayList<Long>(); 
				String[] ticketIdToBeChange_ss = getTicketIdToBeChanges().split(",");
				for (String ticketIdToBeChange_s : ticketIdToBeChange_ss) {
					if(ticketIdToBeChange_s==null||ticketIdToBeChange_s.trim().equals("")){
						ticketIdToBeChange_list.add(new Long(0));
					}
					else{
						ticketIdToBeChange_list.add(new Long(ticketIdToBeChange_s));
					}
				}
				List<Long> insuranceIdToBeChange_list = new ArrayList<Long>(); 
              if(insuranceIdToBeChanges!=null){
				String[] insuranceIdToBeChange_ss = getInsuranceIdToBeChanges().split(",");
				for (String insuranceIdToBeChange_s : insuranceIdToBeChange_ss) {
					if(insuranceIdToBeChange_s==null||insuranceIdToBeChange_s.trim().equals("")){
						insuranceIdToBeChange_list.add(new Long(0));
					}
					else{
						insuranceIdToBeChange_list.add(new Long(insuranceIdToBeChange_s));
					}
				}
              }else{
            	  for(int i=0;i<ticketIdToBeChange_list.size();i++){
            		  insuranceIdToBeChange_list.add(new Long(0));
            	  }
				}
                play.Logger.info("-----------改签开始-----------");
				//methodResult=ticketSellService.changeTicket(remoteTransaction.id, order,ticketIdToBeChange_list,insuranceIdToBeChange_list,global);
				methodResult=ticketSellService.changeTicket_All(remoteTransaction.id, order,ticketIdToBeChange_list,insuranceIdToBeChange_list,global);
				play.Logger.info("-----------改签结束-----------");
			}
			else{
				methodResult=ticketSellService.sellTicket(remoteTransaction.id, order,global);	
			}
			if (methodResult.getResult()==1){
				markSuccess();
				setMsg(methodResult.getResultMsg());
				setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, (List<Object>) methodResult.getObject()));
				if(discountpricenum>0){
					if(sellTickets!=null&&sellTickets.size()>0){//修改折扣票数
						long sdpscheduleid = sellTickets.get(0).getScheduleid();
						long sdpdepartstationid = sellTickets.get(0).getDepartstationid();
						long sdpreachstationid = sellTickets.get(0).getReachstationid();					
						sdiscountpriceService.modifyScheduleDiscountPrice(sdpscheduleid, sdpdepartstationid, sdpreachstationid,global.getUserinfo().getId(),discountpricenum);									
					}
				}
				methodResult = ticketSellService.proEticketsell(methodResult);
				if(methodResult.getResult()!=1){
					markFailure();
					setMsg("售票失败:"+methodResult.getResultMsg());
					TransactionUtil.setRollbackOnly();
					setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, coveListObject(getSellTickets())));
				}								
				if (JPA.em().getTransaction().isActive())
					JPA.em().getTransaction().commit();
												
			}
			else{
				markFailure();
				setMsg("售票失败:"+methodResult.getResultMsg());
				TransactionUtil.setRollbackOnly();
				setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, coveListObject(getSellTickets())));
			}
		} catch (Exception e) {
			String transactionid = remoteTransaction.id;
			play.Logger.error(e.getMessage(), e);
			String remoteurl =  CurrentUtil.getFlash("remoteurl");
			if(transactionid != null && remoteurl != null){
				TransactionUtil.addUndoJob(transactionid, remoteurl);
			}
			play.Logger.info("remove sell fail,id="+ transactionid );
			TransactionUtil.setRollbackOnly();
			markFailure();
			//JPA.em().getTransaction().commit();
			play.Logger.error(org.apache.commons.lang.exception.ExceptionUtils.getFullStackTrace(e));
			setMsg("售票失败!"+e.getMessage());
			setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, coveListObject(getSellTickets())));
		}
		return "json";
	}
	
	private List<Object> coveListObject(List<TicketPrintInfo> _sellTickets){
		if(_sellTickets==null){
			return null;
		}else{
			List<Object> result = new ArrayList<Object>();
			for (Object object : _sellTickets) {
				result.add(object);
			}
			return result;
		}
	}
	
	private long ticketsellid;  //重打车票用，原售票ID
	private String curticketno; //当前票号，用于换票号重新车票或换票号重打退票凭证
	/**
	 * 换票号重打车票
	 * @return 车票打印信息
	 */
	public String findTicketBuffer(){
		ticketSellService = new TicketSellServiceImpl();
		netTicketSellOtherService = new NetTicketSellOtherServiceImpl();
		if(ticketsellid>0){
			//判断电子票是否取票
			try {
				ticketSellService.qryTicketsellotherByTicketsellid(ticketsellid);
			} catch (Exception e) {
				markFail();
				setMsg(e.getMessage());
				setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, null));
				return "json";
			}
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			Ticketsell ts = (Ticketsell) ticketSellService.getTicketsellById(ticketsellid);
			String oldticketno = ts.getTicketno();
			propertyFilters.clear();
			if(ts.getTicketno().length()!=8 & ts.getTicketno().length() !=12) {
				propertyFilters.add(new PropertyFilter("EQL_t!id", ts.getId()));
			}else {
				propertyFilters.add(new PropertyFilter("LIKELS_t!ticketno", ts.getTicketno()));
			}
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ts.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", ts.getDepartdate()));
			propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
			List<Object> objects = new ArrayList<Object>();
			Global global = CurrentUtil.getGlobal();

			if (isnet == 0){
				if(getCurticketno()!=null&&!getCurticketno().trim().equals("")){
					try {
						ticketSellService.getTicketPrintInfoAndChangeTicketNo(ticketsellid, getCurticketno(), global);
						ts = (Ticketsell) ticketSellService.getTicketsellById(ticketsellid);
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("LIKELS_t!ticketno", oldticketno));
						propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", ts.getScheduleplanid()));
						propertyFilters.add(new PropertyFilter("EQD_t!departdate", ts.getDepartdate()));
						propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
						objects.addAll(ticketSellService.getTicketPrintInfo(propertyFilters,oldticketno));
					} catch (ServiceException e) {
						markFailure();
						setMsg("换票号重打车票失败:"+e.getMessage());
						setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, null));
						return "json";
					}
				}
				else{
					objects.addAll(ticketSellService.getTicketPrintInfo(propertyFilters,null));
				}
			}else {
				//取售异站票信息
				if(getCurticketno()!=null&&!getCurticketno().trim().equals("")){
//					setZero();
//					setMsg("换票号重打车票失败:联网票不支持换票号重打车票");
//					setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, null));
//					return "json";
					try {
						objects.add(netTicketSellOtherService.getTicketPrintInfoAndChangeTicketNo(ticketsellid, getCurticketno(), global));
					} catch (Exception e) {
						markFailure();
						setMsg("换票号重打车票失败:"+e.getMessage());
						setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, null));
						return "json";
					}
				}
				else{
					objects.addAll(netTicketSellOtherService.getTicketPrintInfo(propertyFilters));
				}
			}
			setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, objects));
		}
		else{
			setTicketsPrintInfo(ListUtil.listToMap(new Object[]{TicketPrintInfo.class}, null));
		}
		markSuccess();
		return "json";
	}

//	private String certificatetype;
//	private String certificateno;
//	@Action(value="findSeatreserve")
//	public String findSeatreserve(){
//		return "json";
//	}

	private List<Map<String, Object>> seatreserves;
	public String qryseatreserve() {
		ticketSellService = new TicketSellServiceImpl();
		try {
			Global global = CurrentUtil.getGlobal();
			setSeatreserves(ticketSellService
					.qryseatreserve(ServletPropertyFilterUtil.buildFromHttpRequest(),global.getOrganization().getId()));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	private List<Short> ConverStringToListShort(String strs){
		if (strs==null||strs.trim().length()==0){
			return null;
		}
		else{
			List<Short> listShort = new ArrayList<Short>(); 
			for (String seatno : strs.split(",")) {
				listShort.add(new Short(seatno));
			}
			return 	listShort;
		}
	}

	private List<BigDecimal> ConverStringToListBigDecimal(String strs){
		if (strs==null||strs.trim().length()==0){
			return null;
		}
		else{
			List<BigDecimal> listBigDecimal = new ArrayList<BigDecimal>(); 
			for (String seatno : strs.split(",")) {
				listBigDecimal.add(new BigDecimal(seatno));
			}
			return 	listBigDecimal;
		}
	}
	
	private List<String> ConverStringToListString(String strs){
		if (strs==null||strs.trim().length()==0){
			return null;
		}
		else{
			List<String> listStr = new ArrayList<String>(); 
			for (String _selectSeatStatus : strs.split(",")) {
				listStr.add(_selectSeatStatus);
			}
			return 	listStr;
		}
	}
	
	private Schedule schedule; 
	public String findisrealnameticket(){
		Global global = CurrentUtil.getGlobal();
		RouteService routeService = new RouteServiceImpl();

			boolean isrealnameticket  = routeService.findisrealnameticket(schedule);
			if(isrealnameticket){
			setMsg("1");
			}
			else{
				setMsg("0");	
			}				
		markSuccess();
		return "json";
	}
	
	
	public Schedule getSchedule() {
		return schedule;
	}
	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}
	
	/**
	 * @param scheduleAskCondition the scheduleAskCondition to set
	 */
	public void setScheduleAskCondition(ScheduleAskCondition scheduleAskCondition) {
		this.scheduleAskCondition = scheduleAskCondition;
	}

	/**
	 * @return the scheduleAskCondition
	 */
	@Transient
	public ScheduleAskCondition getScheduleAskCondition() {
		return scheduleAskCondition;
	}

	/**
	 * @param preSaleSchedules the preSaleSchedules to set
	 */
	public void setPreSaleSchedules(List<Map<String,Object>> preSaleSchedules) {
		this.preSaleSchedules = preSaleSchedules;
	}

	/**
	 * @return the preSaleSchedules
	 */
	public List<Map<String,Object>> getPreSaleSchedules() {
		return preSaleSchedules;
	}

	public void setScheduleseats(List<Map<String,Object>> scheduleseats) {
		this.scheduleseats = scheduleseats;
	}

	public List<Map<String,Object>> getScheduleseats() {
		return scheduleseats;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	@Transient
	public String getOrderno() {
		return orderno;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	@Transient
	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setUnlocktime(Date unlocktime) {
		this.unlocktime = unlocktime;
	}

	public Date getUnlocktime() {
		return unlocktime;
	}

	public void setOrder(TicketOrder order) {
		this.order = order;
	}

	@Transient
	public TicketOrder getOrder() {
		return order;
	}

	public void setSellTickets(List<TicketPrintInfo> sellTickets) {
		this.sellTickets = sellTickets;
	}

	@Transient
	public List<TicketPrintInfo> getSellTickets() {
		return sellTickets;
	}

	@Transient
	public void setTicketsPrintInfo(List<Map<String,Object>> ticketsPrintInfo) {
		this.ticketsPrintInfo = ticketsPrintInfo;
	}

	public List<Map<String,Object>> getTicketsPrintInfo() {
		return ticketsPrintInfo;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	@Transient
	public Date getDepartdate() {
		return departdate;
	}

	public void setTickettypecode(String tickettypecode) {
		this.tickettypecode = tickettypecode;
	}

	@Transient
	public String getTickettypecode() {
		return tickettypecode;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getFullprice() {
		return fullprice;
	}

	public void setTickettypeprice(BigDecimal tickettypeprice) {
		this.tickettypeprice = tickettypeprice;
	}

	public BigDecimal getTickettypeprice() {
		return tickettypeprice;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	@Transient
	public long getTicketsellid() {
		return ticketsellid;
	}

	public void setSeatnum(int seatnum) {
		this.seatnum = seatnum;
	}

	public int getSeatnum() {
		return seatnum;
	}

	public void setResidueseatnum(int residueseatnum) {
		this.residueseatnum = residueseatnum;
	}

	public int getResidueseatnum() {
		return residueseatnum;
	}

	public void setSellway(String sellway) {
		this.sellway = sellway;
	}

	@Transient
	public String getSellway() {
		return sellway;
	}

	public void setSelectSeatStatus_S(String selectSeatStatus_S) {
		this.selectSeatStatus_S = selectSeatStatus_S;
	}

	@Transient
	public String getSelectSeatStatus_S() {
		return selectSeatStatus_S;
	}

	public void setSelectSeattype(String selectSeattype) {
		this.selectSeattype = selectSeattype;
	}

	public String getSelectSeattype() {
		return selectSeattype;
	}

	public void setSeatnos_S(String seatnos_S) {
		this.seatnos_S = seatnos_S;
	}

	@Transient
	public String getSeatnos_S() {
		return seatnos_S;
	}

	public void setOutseatnos_S(String outseatnos_S) {
		this.outseatnos_S = outseatnos_S;
	}

	public String getOutseatnos_S() {
		return outseatnos_S;
	}

	public List<Map<String,Object>> getSchedulestops() {
		return schedulestops;
	}

	public void setSchedulestops(List<Map<String,Object>> schedulestops) {
		this.schedulestops = schedulestops;
	}

	/**
	 * @return the isnet
	 */
	public int getIsnet() {
		return isnet;
	}

	/**
	 * @param isnet the isnet to set
	 */
	public void setIsnet(int isnet) {
		this.isnet = isnet;
	}

	/**
	 * @return the departstationcode 用于联网票解锁座位
	 */
	@Transient
	public String getDepartstationcode() {
		return departstationcode;
	}

	/**
	 * @param departstationcode the departstationcode to set
	 */
	public void setDepartstationcode(String departstationcode) {
		this.departstationcode = departstationcode;
	}

	public BigDecimal getHalfprice() {
		return halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public BigDecimal getStudentprice() {
		return studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}

	@Transient
	public long getTicketpriceid() {
		return ticketpriceid;
	}

	public void setTicketpriceid(long ticketpriceid) {
		this.ticketpriceid = ticketpriceid;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public String getCurticketno() {
		return curticketno;
	}

	public void setCurticketno(String curticketno) {
		this.curticketno = curticketno;
	}

	public List<Map<String, Object>> getSeatreserves() {
		return seatreserves;
	}

	public void setSeatreserves(List<Map<String, Object>> seatreserves) {
		this.seatreserves = seatreserves;
	}

	public String getSeattype() {
		return seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public String getSchedulesynccode() {
		return schedulesynccode;
	}

	public void setSchedulesynccode(String schedulesynccode) {
		this.schedulesynccode = schedulesynccode;
	}

	public String getReachstationcode() {
		return reachstationcode;
	}

	public void setReachstationcode(String reachstationcode) {
		this.reachstationcode = reachstationcode;
	}

	@Transient
	public String getTicketIdToBeChanges() {
		return ticketIdToBeChanges;
	}

	public void setTicketIdToBeChanges(String ticketIdToBeChanges) {
		this.ticketIdToBeChanges = ticketIdToBeChanges;
	}

	@Transient
	public String getInsuranceIdToBeChanges() {
		return insuranceIdToBeChanges;
	}

	public void setInsuranceIdToBeChanges(String insuranceIdToBeChanges) {
		this.insuranceIdToBeChanges = insuranceIdToBeChanges;
	}

	public String getRoutecode() {
		return routecode;
	}

	public void setRoutecode(String routecode) {
		this.routecode = routecode;
	}

	public String getTickettypes_S() {
		return tickettypes_S;
	}

	public void setTickettypes_S(String tickettypes_S) {
		this.tickettypes_S = tickettypes_S;
	}

	public String getPricess_S() {
		return pricess_S;
	}

	public void setPricess_S(String pricess_S) {
		this.pricess_S = pricess_S;
	}

	public String getOutJxsEticketid_S() {
		return outJxsEticketid_S;
	}

	public void setOutJxsEticketid_S(String outJxsEticketid_S) {
		this.outJxsEticketid_S = outJxsEticketid_S;
	}

	public int getTakekidnum() {
		return takekidnum;
	}

	public void setTakekidnum(int takekidnum) {
		this.takekidnum = takekidnum;
	}

	public String getDeparttimeinput() {
		return departtimeinput;
	}

	public void setDeparttimeinput(String departtimeinput) {
		this.departtimeinput = departtimeinput;
	}

	public String getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public String getBuspark() {
		return buspark;
	}

	public void setBuspark(String buspark) {
		this.buspark = buspark;
	}
	
	public int getDiscountpricenum() {
		return discountpricenum;
	}

	public void setDiscountpricenum(int discountpricenum) {
		this.discountpricenum = discountpricenum;
	}

	public BigDecimal getHirebustotalprice() {
		return hirebustotalprice;
	}

	public void setHirebustotalprice(BigDecimal hirebustotalprice) {
		this.hirebustotalprice = hirebustotalprice;
	}
	public ScheduleDetail getScheduleDetail() {
		return scheduleDetail;
	}
	public void setScheduleDetail(ScheduleDetail scheduleDetail) {
		this.scheduleDetail = scheduleDetail;
	}
	public List<Map<String, Object>> getSaleSchedulesDetail1() {
		return saleSchedulesDetail1;
	}
	public void setSaleSchedulesDetail1(
			List<Map<String, Object>> saleSchedulesDetail1) {
		this.saleSchedulesDetail1 = saleSchedulesDetail1;
	}
	public List<Map<String, Object>> getSaleSchedulesDetail2() {
		return saleSchedulesDetail2;
	}
	public void setSaleSchedulesDetail2(
			List<Map<String, Object>> saleSchedulesDetail2) {
		this.saleSchedulesDetail2 = saleSchedulesDetail2;
	}
	public int getSoldnum() {
		return soldnum;
	}
	public void setSoldnum(int soldnum) {
		this.soldnum = soldnum;
	}
	public int getReserved() {
		return reserved;
	}
	public void setReserved(int reserved) {
		this.reserved = reserved;
	}
	public Boolean getIsrealnameticket() {
		return isrealnameticket;
	}
	public void setIsrealnameticket(Boolean isrealnameticket) {
		this.isrealnameticket = isrealnameticket;
	}
	
	
	public BigDecimal getDiscountprice() {
		return discountprice;
	}
	public void setDiscountprice(BigDecimal discountprice) {
		this.discountprice = discountprice;
	}
	public BigDecimal getRoundprice() {
		return roundprice;
	}
	public void setRoundprice(BigDecimal roundprice) {
		this.roundprice = roundprice;
	}
	public BigDecimal getConnectprice() {
		return connectprice;
	}
	public void setConnectprice(BigDecimal connectprice) {
		this.connectprice = connectprice;
	}
	
}
