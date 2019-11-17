package cn.nova.bus.eticketsale.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.dao.ScheduleDao;
import cn.nova.bus.base.dao.StationDao;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.service.ScheduleperselldaysService;
import cn.nova.bus.base.service.impl.ScheduleperselldaysServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.eticketsale.service.ETicketSellService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.price.service.impl.TicketpriceformulaServiceImpl;
import cn.nova.bus.sale.dao.TicketsellotherDao;
import cn.nova.bus.sale.model.Order;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.sale.model.SeatlockPK;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.service.TakeTicketService;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TakeTicketServiceImpl;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.dao.ExceptioninfoDao;
import cn.nova.bus.system.dao.OrganizationDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.model.Organization;
import cn.nova.centre.ws.model.LockSeateOrderInfo;
import cn.nova.centre.ws.model.LockSeateOrderOut;
import cn.nova.centre.ws.model.LockSeatesInfo;
import cn.nova.centre.ws.model.LockSeatesOut;
import cn.nova.centre.ws.model.QueriedSeatOrderOut;
import cn.nova.centre.ws.model.QueriedSeatsOrderOut;
import cn.nova.centre.ws.model.SellSeatOrderInfo;
import cn.nova.centre.ws.model.SellSeatOrderOut;
import cn.nova.centre.ws.model.SellseatsOrderInfo;
import cn.nova.centre.ws.model.SellseatsOrderOut;
import cn.nova.centre.ws.model.TicketOrderOut;
import cn.nova.centre.ws.model.TicketOrdersOut;
import cn.nova.centre.ws.model.UpdateEticketInfo;
import cn.nova.centre.ws.model.UpdateEticketsInfo;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
/**
 * 
 * <b>类描述：该类提供给电子票售票使用</b><br/>
 * <b>类名称：</b>ETicketSellServiceImpl<br/>
 * <b>创建人：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
public class ETicketSellServiceImpl implements ETicketSellService {
	private TicketSellService ticketSellService;
	private TicketService ticketService = new TicketServiceImpl();
	
	@SuppressWarnings("rawtypes")
	private IDAO dao = new EntityManagerDaoSurport();
	private DigitaldictionarydetailDao digitaldictionarydetailDao = new DigitaldictionarydetailDao();
	private TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();
	private OrganizationDao organizationDao = new OrganizationDao();
	private SchedulestatusDao schedulestatusDao = new SchedulestatusDao();
	private ScheduleDao scheduleDao = new ScheduleDao();
	private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();
	private StationDao stationDao = new StationDao();
	private TakeTicketService takeTicketService = new TakeTicketServiceImpl();
	private TicketsellotherDao ticketsellotherDao = new TicketsellotherDao();
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();
	private ScheduleperselldaysService scheduleperselldaysService = new ScheduleperselldaysServiceImpl();
	private Map<String,String> seattypes;
	private Map<String,String> tickettypes;

	/* (non-Javadoc)
	 * @see cn.nova.bus.eticketsale.service.ETicketSellService#lockSeat(cn.nova.centre.ws.model.LockSeatesInfo)
	 */
	@Override
	public MethodResult lockSeat(LockSeatesInfo lockSeatesInfo) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", lockSeatesInfo.getScode()));
		Station departstation = (Station) dao.uniqueResult(Station.class, propertyFilters);
		if(departstation==null){
			methodResult.setResult(102);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(lockSeatesInfo.getScode()).append("的站点").toString());
			return methodResult;
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", lockSeatesInfo.getEcode()));
		Station reachstation = (Station) dao.uniqueResult(Station.class, propertyFilters);
		if(reachstation==null){
			methodResult.setResult(102);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(lockSeatesInfo.getEcode()).append("的站点").toString());
			return methodResult;
		}
		
		long orgid = organizationDao.getOrgByStationCode(lockSeatesInfo.getScode()).getId();
//		propertyFilters.clear();
//		propertyFilters.add(new PropertyFilter("EQS_t!code", lockSeatesInfo.getRegularno()));
//		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//		Schedule schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
		Schedule schedule = scheduleDao.getScheduleByCode(lockSeatesInfo.getRegularno(),orgid,lockSeatesInfo.getDdate());
		if(schedule==null){
			methodResult.setResult(101);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(lockSeatesInfo.getRegularno()).append("的班次").toString());
			return methodResult;
		}
		if(!getScheduleperselldaysService().inPreSalePeriod(schedule.getId(), lockSeatesInfo.getDdate())){
			methodResult.setResult(105);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0394"));//该班次不在预售期内
			return methodResult;
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", lockSeatesInfo.getDdate()));
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(Scheduleplan.class, propertyFilters);
		if(scheduleplan==null){
			methodResult.setResult(105);
			methodResult.setResultMsg(new StringBuilder().append("找不到发车日期为").append(lockSeatesInfo.getDdate())
									.append(",编码为").append(lockSeatesInfo.getRegularno()).append("的班次计划").toString());
			return methodResult;
		}
		if(!scheduleplan.getIssellable()){
			methodResult.setResult(110);
			methodResult.setResultMsg(new StringBuilder().append("发车日期为").append(lockSeatesInfo.getDdate())
					.append(",编码为").append(lockSeatesInfo.getRegularno()).append("的班次计划不可售").toString());
			return methodResult;
		}
				
		methodResult = checkSchedulestatus(scheduleplan.getId(),departstation.getId());
		Schedulestatus schedulestatus = null;
		if (methodResult.getResult()==1){
			schedulestatus = (Schedulestatus) methodResult.getObject();
		}
		else{
			return methodResult;
		}
		//判断时间是否已经变化
		if(!schedulestatus.getDeparttime().equals(lockSeatesInfo.getDtime())){
			methodResult.setResult(115);
			methodResult.setResultMsg(new StringBuilder().append("发车时间不一致：最新的发车时间为").append(schedulestatus.getDeparttime()).toString());
			return methodResult;
		}
		//判断此订单号是否已经提交过
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", lockSeatesInfo.getOrderid()));
		List<Seatlock> otherseatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(otherseatlocks!=null&&otherseatlocks.size()>0){
			//判断重复提交座位数及座位类型是否一致
			Map<String, Integer> seattypenum = new HashMap<String, Integer>();
			for (LockSeateOrderInfo lockSeateOrderInfo : lockSeatesInfo.getLockSeatOrderInfoList()) {
				if(seattypenum.containsKey(lockSeateOrderInfo.getSeattypeid())){
					seattypenum.put(lockSeateOrderInfo.getSeattypeid(), seattypenum.get(lockSeateOrderInfo.getSeattypeid())+1);
				}
				else{
					seattypenum.put(lockSeateOrderInfo.getSeattypeid(), 1);	
				}
			}
			StringBuilder sql = new StringBuilder();
			sql.append("select ss ")
			   .append(" from Scheduleseats ss,Seatlock sl")
			   .append(" where ss.scheduleplan.id=sl.id.scheduleplanid")
			   .append(" and ss.seatno=sl.id.seatno")
			   .append(" and sl.orderno='").append(lockSeatesInfo.getOrderid()).append("'")
			   .append(" order by ss.seattype");
			List<Scheduleseats> scheduleseats = dao.find(sql.toString());
			Map<String, Integer> _seattypenum = new HashMap<String, Integer>();
			for (Scheduleseats scheduleseat : scheduleseats) {
				if(_seattypenum.containsKey(scheduleseat.getSeattype())){
					_seattypenum.put(scheduleseat.getSeattype(), _seattypenum.get(scheduleseat.getSeattype())+1);
				}
				else{
					_seattypenum.put(scheduleseat.getSeattype(), 1);	
				}
			}
			if(seattypenum.size()!=_seattypenum.size()){
				methodResult.setResult(201);
				methodResult.setResultMsg("该订单号为重复提交，但前后提交的座位类型或座位数不一致");
				return methodResult;
			}
			for (String key : seattypenum.keySet()) {
				if(!_seattypenum.containsKey(key)||seattypenum.get(key).intValue()!=_seattypenum.get(key).intValue()){
					methodResult.setResult(201);
					methodResult.setResultMsg("该订单号为重复提交，但前后提交的座位类型或座位数不一致");
					return methodResult;
				}
			}
			//返回之前锁定的座位信息
			methodResult.setResult(1);
			methodResult.setResultMsg("该订单号为重复提交");
			LockSeatesOut lockSeatesOut = new LockSeatesOut();
			lockSeatesOut.setLockedseat(new ArrayList<LockSeateOrderOut>());
			initTickettyes();
			initSeattypes();
			for (LockSeateOrderInfo lockSeateOrderInfo : lockSeatesInfo.getLockSeatOrderInfoList()) {
				LockSeateOrderOut lockSeateOrderOut = new LockSeateOrderOut();
				lockSeateOrderOut.setPrice(lockSeateOrderInfo.getPrice());
				lockSeateOrderOut.setPricetypeid(lockSeateOrderInfo.getPricetypeid());
				lockSeateOrderOut.setPricetypename(tickettypes.get(lockSeateOrderInfo.getPricetypeid()));
				lockSeateOrderOut.setSeattypeid(lockSeateOrderInfo.getSeattypeid());
				lockSeateOrderOut.setSeattypename(seattypes.get(lockSeateOrderInfo.getSeattypeid()));
				for (Scheduleseats scheduleseat : scheduleseats) {
					boolean hasused = false;
					for (LockSeateOrderOut _lockSeateOrderOut : lockSeatesOut.getLockedseat()) {
						if(_lockSeateOrderOut.getSeatno().equals((int)scheduleseat.getSeatno())){
							hasused = true;
							break;
						}
					}
					if(hasused){
						continue;
					}
					else{
						lockSeateOrderOut.setSeatno((int) scheduleseat.getSeatno());
						break;
					}
				}
				//lockSeateOrderOut.setTicketid(lockSeateOrderInfo.getTicketeid());
				//unlocktime
				lockSeatesOut.getLockedseat().add(lockSeateOrderOut);
			}
			lockSeatesOut.setDtime(schedulestatus.getDeparttime());
			lockSeatesOut.setOrderid(lockSeatesInfo.getOrderid());
			lockSeatesOut.setSeatnums(lockSeatesInfo.getSeatnums());
			methodResult.setResult(1);
			methodResult.setObject(lockSeatesOut);
			return methodResult;
		}
		
		Date locktime = new Date();
		//取锁定时间
		int locktimeout=lockSeatesInfo.getLocktime()*60;
		Calendar cld= Calendar.getInstance();
		cld.setTime(locktime);
		cld.add(Calendar.SECOND, locktimeout);
		Date unlocktime = cld.getTime(); 
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		List<Scheduleseats> scheduleseats = dao.find(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
		
		LockSeatesOut lockSeatesOut = new LockSeatesOut();
		lockSeatesOut.setLockedseat(new ArrayList<LockSeateOrderOut>());
		Map<String,Ticketprice> ticketprices = new HashMap<String, Ticketprice>();
		for (LockSeateOrderInfo lockSeateOrderInfo : lockSeatesInfo.getLockSeatOrderInfoList()) {
			//校验票价
			methodResult =  checkTickettypeAndPrice(scheduleplan,departstation,reachstation,lockSeateOrderInfo.getSeattypeid(),lockSeateOrderInfo.getPricetypeid(),new BigDecimal(lockSeateOrderInfo.getPrice().toString()));
			if(methodResult.getResult()!=1){
				return methodResult;
			}
			
			Scheduleseats scheduleseat = null;
			for (Scheduleseats _scheduleseat : scheduleseats) {
				if(_scheduleseat.getSeattype().equals(lockSeateOrderInfo.getSeattypeid())&&_scheduleseat.getStatus().equals("0")){
					scheduleseat = _scheduleseat;
					break;
				}
			}
			if(scheduleseat==null){
				methodResult.setResult(202);
				methodResult.setResultMsg("剩余座位数不够");
				return methodResult;
			}
			Seatlock seatlock = new Seatlock();
			seatlock.setOldstatus(scheduleseat.getStatus());
			scheduleseat.setStatus("1"); //锁定
			SeatlockPK seatlockPK = new SeatlockPK();
			seatlockPK.setScheduleplanid(scheduleplan.getId());
			seatlockPK.setSeatno(scheduleseat.getSeatno());
			seatlock.setId(seatlockPK);
			seatlock.setLocktime(locktime);
			seatlock.setAutounlocktime(unlocktime);
			seatlock.setDepartdate(scheduleplan.getDepartdate());
			seatlock.setLockby(0);
			//TODO 取远程调用者的IP地址
			seatlock.setLockip("127.0.0.1");
			seatlock.setLockorgid(0);
			seatlock.setLockticketoutletsid(0);
			seatlock.setOrderno(lockSeatesInfo.getOrderid());
			seatlock.setScheduleid(scheduleplan.getScheduleid());
			dao.merge(scheduleseat);
			dao.merge(seatlock);
			LockSeateOrderOut lockSeateOrderOut = new LockSeateOrderOut();
			lockSeateOrderOut.setPrice(lockSeateOrderInfo.getPrice());
			lockSeateOrderOut.setPricetypeid(lockSeateOrderInfo.getPricetypeid());
			lockSeateOrderOut.setPricetypename(tickettypes.get(lockSeateOrderInfo.getPricetypeid()));
			lockSeateOrderOut.setSeatno((int) scheduleseat.getSeatno());
			lockSeateOrderOut.setSeattypeid(lockSeateOrderInfo.getSeattypeid());
			lockSeateOrderOut.setSeattypename(seattypes.get(lockSeateOrderInfo.getSeattypeid()));
			//lockSeateOrderOut.setTicketid(lockSeateOrderInfo.getTicketeid());
			//unlocktime
			lockSeatesOut.getLockedseat().add(lockSeateOrderOut);
		}
		lockSeatesOut.setDtime(schedulestatus.getDeparttime());
		lockSeatesOut.setOrderid(lockSeatesInfo.getOrderid());
		lockSeatesOut.setSeatnums(lockSeatesInfo.getSeatnums());
		methodResult.setResult(1);
		methodResult.setObject(lockSeatesOut);
		return methodResult;
	}
	
	private void initSeattypes(){
		if(seattypes==null){
			seattypes = new HashMap<String, String>();
			List<Digitaldictionarydetail> digitaldictionarydetails;
			digitaldictionarydetails = digitaldictionarydetailDao.find("handprice","seattype");
			for (Digitaldictionarydetail digitaldictionarydetail : digitaldictionarydetails) {
				seattypes.put(digitaldictionarydetail.getCode(), digitaldictionarydetail.getValue());
			}
			
		}
	}
	
	private boolean checkSeattype(String seattype){
		boolean result = false;
		initSeattypes();
		for (String _seattype : seattypes.keySet()) {
			if(_seattype.equals(seattype)){
				result = true;
				break;
			}
		}
		return result;
	}
	
	private void initTickettyes(){
		if(tickettypes==null){
			tickettypes = new HashMap<String, String>();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
			propertyFilters.add(new PropertyFilter("GTY_t!orderno", (byte)0));
			List<Tickettype> _tickettypes = dao.find(Tickettype.class,propertyFilters);
			for (Tickettype _tickettype : _tickettypes) {
				tickettypes.put(_tickettype.getCode(), _tickettype.getName());
			}
		}
	}
	
	private MethodResult checkTickettypeAndPrice(Scheduleplan scheduleplan,Station departstation,Station reachstation,String seattype,String tickettype,BigDecimal price){
		MethodResult methodResult = new MethodResult(); 
		Map<String,Ticketprice> ticketprices = new HashMap<String, Ticketprice>();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		initTickettyes();
		if(!tickettypes.containsKey(tickettype)){
			methodResult.setResult(103);
			methodResult.setResultMsg(new StringBuilder().append(departstation.getName()).append("不支持编码为").append(tickettype).append("的票种售票").toString());
			return methodResult;
		}
		if(!checkSeattype(seattype)){
			methodResult.setResult(104);
			methodResult.setResultMsg(new StringBuilder().append(departstation.getName()).append("不支持编码为").append(seattype).append("的座位类型").toString());
			return methodResult;
		}
		if(!ticketprices.containsKey(seattype)){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", departstation.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", reachstation.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", seattype));
			List<Ticketprice> _ticketprices = dao.find(Ticketprice.class,propertyFilters);
			if(_ticketprices==null||_ticketprices.size()==0){
				methodResult.setResult(106);
				methodResult.setResultMsg(new StringBuilder().append("找不到座位类型(").append(seattypes.get(seattype))
						                 .append(")发车站(").append(departstation.getCode()).append(")至(")
										 .append(reachstation.getCode()).append(")的票价").toString());
				return methodResult;
			}
			if(!_ticketprices.get(0).getIssellable()){
				methodResult.setResult(111);
				methodResult.setResultMsg(new StringBuilder().append("座位类型(").append(seattypes.get(seattype))
		                 .append(")发车站(").append(departstation.getCode()).append(")至(")
						 .append(reachstation.getCode()).append(")的票价不可售").toString());
				return methodResult;
			}
			ticketprices.put(seattype, _ticketprices.get(0));
		}
		//校验票价
		BigDecimal _price;
		switch (tickettype.charAt(0)) {
		case 'Q':
			_price = ticketprices.get(seattype).getFullprice();
			break;
		case 'B':
			_price = ticketprices.get(seattype).getFullprice();
			break;
		case 'X':
			_price = ticketprices.get(seattype).getFullprice();
			break;
		default:
			_price = ticketpriceformulaService.getPrice(scheduleplan.getOrgid(), scheduleplan.getDepartdate(), tickettype, ticketprices.get(seattype).getFullprice());
			break;
		}
		if(price.compareTo(_price)!=0){
			methodResult.setResult(107);
			methodResult.setResultMsg("票价不一致");
			return methodResult;
		}
		methodResult.setResult(1);
		return methodResult;
	}

	@Override
	public MethodResult unlockSeat(String orderno) {
		MethodResult methodResult = new MethodResult();

		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno));
		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(seatlocks==null){
			methodResult.setResult(1);
			return methodResult;
		}
		for (Seatlock seatlock : seatlocks) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", seatlock.getId().getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatlock.getId().getSeatno()));
			Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
			if(scheduleseat!=null){
				scheduleseat.setStatus(seatlock.getOldstatus());
				dao.merge(scheduleseat);
			}
			dao.delete(seatlock);
		}
		methodResult.setResult(1);
		return methodResult;
	}

	@Override
	public MethodResult sellTicket(String sellorgcode,SellseatsOrderInfo order) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", order.getScode()));
		Station departstation = (Station) dao.uniqueResult(Station.class, propertyFilters);		
		//Station departstation = stationDao.getByCode(order.getScode(), null);
		if(departstation==null){
			methodResult.setResult(102);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(order.getScode()).append("的站点").toString());
			return methodResult;
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", order.getEcode()));
		Station reachstation = (Station) dao.uniqueResult(Station.class, propertyFilters);		
		//Station reachstation = stationDao.getByCode(order.getEcode(), null);
		if(reachstation==null){
			methodResult.setResult(102);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(order.getEcode()).append("的站点").toString());
			return methodResult;
		}
		//取发车机构
		Organization organization = organizationDao.getOrgByStationCode(order.getScode());
		//售票机构
		Organization organization_sell = organizationDao.getOrgByCode(sellorgcode);
		//取班次
//		propertyFilters.clear();
//		propertyFilters.add(new PropertyFilter("EQL_t!orgid", organization.getId()));
//		propertyFilters.add(new PropertyFilter("EQS_t!code", order.getRegularno()));
//		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//		Schedule schedule = (Schedule) dao.uniqueResult(Schedule.class, propertyFilters);
		Schedule schedule = scheduleDao.getScheduleByCode(order.getRegularno(),organization.getId(),order.getDdate());
		//取班次计划
		propertyFilters.clear();
//		propertyFilters.add(new PropertyFilter("EQL_t!orgid", organization.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", order.getDdate()));
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
		
		Date now = new Date();
		List<Seatlock> seatlocks = null;
		List<Scheduleseats> scheduleseatss = null;
		if(!scheduleplan.getIslinework()){
			//判断重复提交座位数及座位类型是否一致
			Map<String, Integer> seattypenum = new HashMap<String, Integer>();
			for (SellSeatOrderInfo sellSeatOrderInfo : order.getSellseatOrderList()) {
				if(seattypenum.containsKey(sellSeatOrderInfo.getSeattypeid())){
					seattypenum.put(sellSeatOrderInfo.getSeattypeid(), seattypenum.get(sellSeatOrderInfo.getSeattypeid())+1);
				}
				else{
					seattypenum.put(sellSeatOrderInfo.getSeattypeid(), 1);	
				}
			}
			StringBuilder sql = new StringBuilder();
			sql.append("select ss,sl ")
			   .append(" from Scheduleseats ss,Seatlock sl")
			   .append(" where ss.scheduleplan.id=sl.id.scheduleplanid")
			   .append(" and ss.seatno=sl.id.seatno")
			   .append(" and sl.orderno='").append(order.getOrderid()).append("'")
			   .append(" and sl.id.scheduleplanid=").append(scheduleplan.getId())
			   .append(" order by ss.seattype");
			List<Object[]> objects = dao.find(LockModeType.PESSIMISTIC_READ,sql.toString());
			if(objects==null||objects.size()==0){
				//锁位记录不存在
				methodResult.setResult(203);
				methodResult.setResultMsg("订单号:"+order.getOrderid()+"，日期:"+order.getDdate()+"，班次号:"+order.getRegularno()+getExceptioninfoDao().getExceptioninfo("0206"));
				return methodResult;
			}
			else if(order.getSeatnums()!=objects.size()){
				//锁位数量不对
				methodResult.setResult(204);
				methodResult.setResultMsg("订单号:"+order.getOrderid()+"，日期:"+order.getDdate()+"，班次号:"+order.getRegularno()+"锁位数量不正确");
				return methodResult;
			}
			else{
				scheduleseatss = new ArrayList<Scheduleseats>();
				seatlocks = new ArrayList<Seatlock>();
				for (Object[] _objects : objects) {
					scheduleseatss.add((Scheduleseats) _objects[0]);
					seatlocks.add((Seatlock) _objects[1]);
				}
			}
			
			
			Map<String, Integer> _seattypenum = new HashMap<String, Integer>();
			for (Scheduleseats scheduleseat : scheduleseatss) {
				if(_seattypenum.containsKey(scheduleseat.getSeattype())){
					_seattypenum.put(scheduleseat.getSeattype(), _seattypenum.get(scheduleseat.getSeattype())+1);
				}
				else{
					_seattypenum.put(scheduleseat.getSeattype(), 1);	
				}
			}
			if(seattypenum.size()!=_seattypenum.size()){
				methodResult.setResult(205);
				methodResult.setResultMsg("订单号:"+order.getOrderid()+"，日期:"+order.getDdate()+"，班次号:"+order.getRegularno()+"锁位的座位类型不一致");
				return methodResult;
			}
			for (String key : seattypenum.keySet()) {
				if(!_seattypenum.containsKey(key)||seattypenum.get(key).intValue()!=_seattypenum.get(key).intValue()){
					methodResult.setResult(205);
					methodResult.setResultMsg("订单号:"+order.getOrderid()+"，日期:"+order.getDdate()+"，班次号:"+order.getRegularno()+"锁位的座位类型不一致");
					return methodResult;
				}
			}
		}
		
		methodResult = checkSchedulestatus(scheduleplan.getId(),departstation.getId());
		Schedulestatus schedulestatus = null;
		if (methodResult.getResult()==1){
			schedulestatus = (Schedulestatus) methodResult.getObject();
		}
		else{
			return methodResult;
		}
		//判断时间是否已经变化
		if(!schedulestatus.getDeparttime().equals(order.getDtime())){
			methodResult.setResult(115);
			methodResult.setResultMsg(new StringBuilder().append("发车时间不一致：最新的发车时间为").append(schedulestatus.getDeparttime()).toString());
			return methodResult;
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQO_t!scheduleplan", scheduleplan));
		propertyFilters.add(new PropertyFilter("EQR_t!orderno", (short) 0));
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = (Schedulevehiclepeopleplan) dao.uniqueResult(Schedulevehiclepeopleplan.class, propertyFilters);
		Vehiclebrandmodel planvehiclebrandmodel = (Vehiclebrandmodel) dao.get(Vehiclebrandmodel.class, schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());
		SellseatsOrderOut sellseatsOrderOut = new SellseatsOrderOut();
		sellseatsOrderOut.setDtime(schedulestatus.getDeparttime());
		sellseatsOrderOut.setOrderid(order.getOrderid());
		sellseatsOrderOut.setSellseats(new ArrayList<SellSeatOrderOut>());
		//TODO 赣州升级要把此注释放开
		//-------------------------------------------------------------------------------------------------------------------------------
		Customer buy_customer=(Customer) dao.uniqueResult("select c from Customer c where c.name='"+order.getCustomername()+"' and c.certificatetype='0' and c.certificateno='"+order.getOrdercardid()+"'");
		
		if(buy_customer==null){
			buy_customer=new Customer();
		}
		buy_customer.setName(order.getCustomername());
		buy_customer.setSex("男");
		buy_customer.setBirthday(null);
		buy_customer.setCertificatetype("0");
		buy_customer.setCertificateno(order.getOrdercardid());
		buy_customer.setEducation(null);
		buy_customer.setFamilyaddress(null);
		buy_customer.setFamilyphone(null);
		buy_customer.setMobilephone(order.getCustomerphone());
		buy_customer.setOrgid(organization_sell.getId());
		buy_customer.setTicketoutletsid(null);
		buy_customer.setInputway("3");
		buy_customer.setLastbuytickettime(new Date());
		buy_customer.setRemarks(null);
		buy_customer.setCreatetime(now);
		buy_customer.setCreateby(0L);
		buy_customer.setUpdateby(0L);
		buy_customer.setUpdatetime(now);
		buy_customer.setIsactive(true);
		buy_customer.setIslocaldelete(false);
		buy_customer.setEmail(null);
		buy_customer=(Customer) dao.merge(buy_customer); 
		//--------------------------------------------------------------------------------------------------------------------------
		
		for (SellSeatOrderInfo detail : order.getSellseatOrderList()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", order.getScode()));
			Station station_depart = (Station) dao.uniqueResult(Station.class, propertyFilters);
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", order.getEcode()));
			Station station_reach = (Station) dao.uniqueResult(Station.class, propertyFilters);
			//校验票价
			methodResult =  checkTickettypeAndPrice(scheduleplan,departstation,reachstation,detail.getSeattypeid(),detail.getPricetypeid(),new BigDecimal(detail.getPrice().toString()));
			if(methodResult.getResult()!=1){
				return methodResult;
			}
			//锁定班次并更新剩余票数
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()+1));
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", station_depart.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", station_reach.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", detail.getSeattypeid()));
			Ticketprice ticketprice = (Ticketprice) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			ticketprice.setSoldeatnum((short) (ticketprice.getSoldeatnum()+1));
			Ticketsell ticketsell = new Ticketsell();
			if(!scheduleplan.getIslinework()){
				ticketsell.setSeatno((short) 0);
				for (Scheduleseats scheduleseat : scheduleseatss) {
					if(scheduleseat.getSeattype().equals(detail.getSeattypeid())&&!scheduleseat.getStatus().equals("2")){
						if(!"1".equals(scheduleseat.getStatus())){
							//座位不是锁定状态
							methodResult.setResult(301);
							methodResult.setResultMsg("日期:"+order.getDdate()+"班次号:"+order.getRegularno()+"座位号:"+scheduleseat.getSeatno()+getExceptioninfoDao().getExceptioninfo("0205"));
							return methodResult;
						}
						Seatlock seatlock = seatlocks.get(scheduleseatss.indexOf(scheduleseat));
						if("4".equals(seatlock.getOldstatus())||"5".equals(seatlock.getOldstatus())){
							//留座位记录不存在,无法售出留座。
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", scheduleplan.getId()));
							propertyFilters.add(new PropertyFilter("EQR_t!seatno", scheduleseat.getSeatno()));
							Seatreserve seatreserve = (Seatreserve) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatreserve.class, propertyFilters);
							if(seatreserve==null){
								methodResult.setResultMsg("日期:"+order.getDdate()+"班次号:"+order.getRegularno()+"座位号:"+scheduleseat.getSeatno()+getExceptioninfoDao().getExceptioninfo("0207"));
								return methodResult;
							}
							else{
								if("R".equals(seatreserve.getSellstate())){
									seatreserve.setSellstate("S");
									dao.merge(seatreserve);
								}
								else{
									if("C".equals(seatreserve.getSellstate())){
										//留座位记录状态为已取消,无法售出留座。
										methodResult.setResultMsg("日期:"+order.getDdate()+"班次号:"+order.getRegularno()+"座位号:"+scheduleseat.getSeatno()+getExceptioninfoDao().getExceptioninfo("0208"));
										return methodResult;
									}
									else if("S".equals(seatreserve.getSellstate())){
										//留座位记录状态为已售,无法售出留座。
										methodResult.setResultMsg("日期:"+order.getDdate()+"班次号:"+order.getRegularno()+"座位号:"+scheduleseat.getSeatno()+getExceptioninfoDao().getExceptioninfo("0209"));
										return methodResult;
									}
									return methodResult;
								}
							}
							if("4".equals(seatlock.getOldstatus())){
								ticketprice.setAutocancelreserveseatnum((short) (ticketprice.getAutocancelreserveseatnum()-1));
								scheduleplan.setAutocancelreserveseatnum((short) (scheduleplan.getAutocancelreserveseatnum()-1));
							}
							else if("5".equals(seatlock.getOldstatus())){
								ticketprice.setUnautocancelreserveseatnum((short) (ticketprice.getUnautocancelreserveseatnum()-1));
								scheduleplan.setUnautocancelreserveseatnum((short) (scheduleplan.getUnautocancelreserveseatnum()-1));
							} 
						}
						//更新座位状态
						scheduleseat.setStatus("2");
						scheduleseat.setTickettype(detail.getPricetypeid());
						dao.delete(seatlock);
						dao.merge(scheduleseat);
						ticketsell.setSeatno(scheduleseat.getSeatno());
						break;
					}
				}
				assert ticketsell.getSeatno()!=0;
			}
			else{
				//流水班次没有留位
				//取已售张数的最大值作为座位号
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", scheduleplan.getId()));
				ticketsell.setSeatno((short)(dao.countTotalRows(Ticketsell.class, propertyFilters, "id")+1));
				//往回更新
//					detail.setSeatno(ticketsell.getSeatno());
			}
			dao.merge(ticketprice);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", detail.getSeattypeid()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			if(ticketprices.size()>1){
				for (Ticketprice _ticketprice : ticketprices){
					_ticketprice.setSoldeatnum(ticketprice.getSoldeatnum());
					_ticketprice.setAutocancelreserveseatnum(ticketprice.getAutocancelreserveseatnum());
					_ticketprice.setUnautocancelreserveseatnum(ticketprice.getUnautocancelreserveseatnum());
					dao.merge(_ticketprice);
				}
			}
			
			dao.merge(scheduleplan);
			ticketsell.setBuspark(schedulestatus.getBuspark());
			ticketsell.setCarrychildnum((byte) 0);
			ticketsell.setCheckedby(null);
			ticketsell.setCheckstation(null);
			ticketsell.setChecktime(null);
			ticketsell.setCreateby(0L);
			ticketsell.setCreatetime(now);
			
			// TODO 2013-09-24 customerid不为空
			//TODO 赣州升级要把此注释放开
			//------------------------------------------------------------------------------------------
			ticketsell.setCustomer(null);
			
			if(detail.getCustomername()==null||detail.getCustomerphone()==null||detail.getTicketcardid()==null||detail.getTicketservicecharge()==null){
				methodResult.setResult(0);
				methodResult.setResultMsg("姓名、电话号码、取票身份证号码、服务费金额不允许为空");
				return methodResult;
			}
			else{
				Customer customer=(Customer) dao.uniqueResult("select c from Customer c where c.name='"+detail.getCustomername()+"'  and c.certificatetype='0' and c.certificateno='"+detail.getTicketcardid()+"'");
				if(customer==null){
					customer = new Customer();
				}
				customer.setName(detail.getCustomername());
				customer.setSex("男");
				customer.setBirthday(null);
				customer.setCertificatetype("0");
				customer.setCertificateno(detail.getTicketcardid());
				customer.setEducation(null);
				customer.setFamilyaddress(null);
				customer.setFamilyphone(null);
				customer.setMobilephone(detail.getCustomerphone());
				customer.setOrgid(organization_sell.getId());
				customer.setTicketoutletsid(null);
				customer.setInputway("3");
				customer.setLastbuytickettime(new Date());
				customer.setRemarks(null);
				customer.setCreatetime(now);
				customer.setCreateby(0L);
				customer.setUpdateby(0L);
				customer.setUpdatetime(now);
				customer.setIsactive(true);
				customer.setIslocaldelete(false);
				customer.setEmail(null);
				customer=(Customer) dao.merge(customer);
				ticketsell.setCustomer(customer);
				
			}
			//------------------------------------------------------------------------------------------
			ticketsell.setDepartdate(schedulestatus.getDepartdate());
			ticketsell.setDepartinvoicesby(null);
			ticketsell.setDepartinvoices(null);
			ticketsell.setDepartinvoicestime(null);
			ticketsell.setDepartstationid(station_depart.getId());
			ticketsell.setDeparttime(schedulestatus.getDeparttime());
			ticketsell.setDiscountrate(new BigDecimal(detail.getPrice().toString()).divide(ticketprice.getFullprice()));
			ticketsell.setDistance((long) ticketprice.getDistance());
			ticketsell.setFullprice(ticketprice.getFullprice());
			ticketsell.setHandticketoutlets(null);
			ticketsell.setIschecked(false);
			ticketsell.setIsdepartinvoices(false);
			ticketsell.setIslinework(scheduleplan.getIslinework());
			//加参数传入售票机构
			ticketsell.setOrgid(organization_sell.getId());
			ticketsell.setPaymethod("1");//银联卡
			ticketsell.setPrice(new BigDecimal(detail.getPrice().toString()));
			ticketsell.setMoreprice(ticketprice.getMoreprice());
			ticketsell.setServicefee(new BigDecimal(0));
			ticketsell.setReachstationid(station_reach.getId());
			ticketsell.setScheduleid(scheduleplan.getScheduleid());
			ticketsell.setScheduleplanid(scheduleplan.getId());
			ticketsell.setSellby(0L);
			ticketsell.setSellip("127.0.0.1");
			ticketsell.setSelltime(now);
			ticketsell.setSellway("7");//网上售票
			ticketsell.setStationservicefee(ticketprice.getStationservicefee());
			ticketsell.setFueladditionfee(ticketprice.getFueladditionfee());
			ticketsell.setBatchno("0");
			ticketsell.setTicketentrance(schedulestatus.getTicketentrance());
			ticketsell.setTicketno(detail.getTicketno());
			//往回更新
//			detail.setTicketno(ticketsell.getTicketno());
			ticketsell.setTicketoutletsid(0);
			ticketsell.setTicketoutletsname(organization_sell.getName());
			ticketsell.setTicketstatus("0"); //正常
			ticketsell.setTickettype(detail.getPricetypeid());
			ticketsell.setUpdateby(0L);
			ticketsell.setUpdatetime(now);
			ticketsell.setSeattype(detail.getSeattypeid());
			ticketsell.setToplimitprice(ticketprice.getToplimitprice());
			//取票价组成项费用
			DeductInfo deductInfo = balancedeductService.getDeductfee(ticketsell);
			ticketsell.setFueladditionfee(deductInfo.getFueladditionfee());
			ticketsell.setStationservicefee(deductInfo.getStationfee());
			ticketsell.setComputefee(deductInfo.getComputefee());
			ticketsell.setCoolairfee(deductInfo.getCoolairfee());
			ticketsell.setAdditionfee(deductInfo.getAdditionfee());
			ticketsell.setWaterfee(deductInfo.getWaterfee());
			ticketsell.setInsurefee(deductInfo.getInsurefee());
			ticketsell.setOtherfee(deductInfo.getOtherfee());
			ticketsell.setOrderno(order.getOrderid());
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			
			
			//生成Ticketsellother
			Ticketsellother ticketsellother =  new Ticketsellother();
			ticketsellother.setAgentname(organization_sell.getName());
			ticketsellother.setCreateby(0);
			ticketsellother.setCreatetime(now);
			ticketsellother.setEticketid(detail.getTicketid());
			ticketsellother.setEticketno(detail.getTicketno());
			ticketsellother.setIstaked(false);
			ticketsellother.setOrderno(order.getOrderid());
			ticketsellother.setPassword(detail.getTicketauthcode());
			ticketsellother.setPrintby(null);
			
			// TODO 判断电子票服务费金额是否为空
			ticketsellother.setServiceprice(new BigDecimal(0));
//			if(detail.getTicketservicecharge()==null){
//				ticketsellother.setServiceprice(new BigDecimal(0));
//			}else{
//				ticketsellother.setServiceprice(new BigDecimal(detail.getTicketservicecharge()));
//			}
			
			ticketsellother.setTicketsellid(ticketsell.getId());
			ticketsellother.setUpdateby(0);
			ticketsellother.setUpdatetime(now);
			dao.merge(ticketsellother);
			SellSeatOrderOut sellSeatOrderOut = new SellSeatOrderOut();
			sellSeatOrderOut.setCartype(planvehiclebrandmodel.getBrandname());
			sellSeatOrderOut.setCheckport(ticketsell.getTicketentrance());
			sellSeatOrderOut.setLinename(schedule.getRoute().getName());
			sellSeatOrderOut.setPrice(ticketsell.getPrice().floatValue());
			sellSeatOrderOut.setPricetypeid(ticketsell.getTickettype());
			sellSeatOrderOut.setPricetypename(tickettypes.get(ticketsell.getTickettype()));
			sellSeatOrderOut.setRidingpos(ticketsell.getBuspark());
			sellSeatOrderOut.setSeatno((int) ticketsell.getSeatno());
			sellSeatOrderOut.setSeattypeid(detail.getSeattypeid());
			sellSeatOrderOut.setSeattypename(seattypes.get(detail.getSeattypeid()));
			sellSeatOrderOut.setTicketid(detail.getTicketid());
			sellSeatOrderOut.setDistance(ticketsell.getDistance());
			sellSeatOrderOut.setFullprice(ticketsell.getFullprice());
			sellSeatOrderOut.setToplimitprice(ticketsell.getToplimitprice());
			sellSeatOrderOut.setAdditionfee(ticketsell.getAdditionfee());
			sellSeatOrderOut.setComputefee(ticketsell.getComputefee());
			sellSeatOrderOut.setCoolairfee(ticketsell.getCoolairfee());
			sellSeatOrderOut.setFueladditionfee(ticketsell.getFueladditionfee());
			sellSeatOrderOut.setStationservicefee(ticketsell.getStationservicefee());
			sellSeatOrderOut.setWaterfee(ticketsell.getWaterfee());
			sellSeatOrderOut.setInsurefee(ticketsell.getInsurefee());
			sellSeatOrderOut.setOtherfee(ticketsell.getOtherfee());
			sellSeatOrderOut.setMoreprice(ticketsell.getMoreprice());
			sellseatsOrderOut.getSellseats().add(sellSeatOrderOut);
		}
		//TODO 赣州升级要把此注释放开
		//------------------------------------------------------------------------------------------——————
		//生成Order
		Order netorder=new Order();
		netorder.setCreateby(0);
		netorder.setUpdateby(0);
		netorder.setCreatetime(now);
		netorder.setUpdatetime(now);
		//保存的是发车机构
		netorder.setDepartorgid(organization.getId());
		netorder.setOrderid(order.getOrderid());
		netorder.setOrderno(order.getOrderno());
		netorder.setCustomerid(buy_customer.getId());
		//TODO 身份证保存的是购买者的身份证号
		netorder.setOrdercardid(order.getOrdercardid());
		if(order.getOrderservicecharge()==null || order.getOrderservicecharge().equals("")){
			netorder.setOrderservicecharge(new BigDecimal(0));
		}else{
			netorder.setOrderservicecharge(new BigDecimal(order.getOrderservicecharge()));
		}
		netorder.setOrderauthcode(order.getOrderauthcode());
		netorder.setSeatnum(order.getSeatnums());
		netorder.setSellorgid(organization_sell.getId());
		netorder.setStatus("0");
		dao.merge(netorder);
		
		//------------------------------------------------------------------------------------------——————
		
		methodResult.setResult(1);
		methodResult.setObject(sellseatsOrderOut);
		return methodResult;
	}

	@Override
	public MethodResult GetOrderInfo(String orderno) {
		MethodResult result = new MethodResult();
		List<Ticketsellother> ticketsellothers = ticketsellotherDao.findByOrderno(orderno);
		if(ticketsellothers==null||ticketsellothers.size()==0){
			result.setResult(401);
			result.setResultMsg("找不到订单ID"+orderno);
			return result;
		}
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketsellothers.get(0).getTicketsellid());
		Station departstation = (Station) stationDao.get(Station.class, ticketsell.getDepartstationid());
		Station reachstation = (Station) stationDao.get(Station.class, ticketsell.getReachstationid());
		
		//校验售票记录的密文是否正确
		if(!ticketService.checkTicketByTicket(ticketsell)){
			result.setResult(0);
			result.setResultMsg("售票记录密文错误！");
			return result;
		}
		//取发车机构
		Organization organization = organizationDao.getOrgByStationCode(departstation.getCode());
		//售票机构
//		Organization organization_sell = organizationDao.getOrgByCode(sellorgcode);
		//取班次
		Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());
		//取班次计划
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, ticketsell.getScheduleplanid());
		
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQO_t!scheduleplan", scheduleplan));
		propertyFilters.add(new PropertyFilter("EQR_t!orderno", (short) 0));
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = (Schedulevehiclepeopleplan) dao.uniqueResult(Schedulevehiclepeopleplan.class, propertyFilters);
		Vehiclebrandmodel planvehiclebrandmodel = (Vehiclebrandmodel) dao.get(Vehiclebrandmodel.class, schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());

		TicketOrdersOut ticketOrdersOut = new TicketOrdersOut();
		ticketOrdersOut.setDdate(scheduleplan.getDepartdate());
		ticketOrdersOut.setEcode(reachstation.getCode());
		ticketOrdersOut.setEname(reachstation.getName());
		ticketOrdersOut.setOrderid(ticketsellothers.get(0).getOrderno());
		ticketOrdersOut.setRegularno(schedule.getCode());
		ticketOrdersOut.setScode(departstation.getCode());
		ticketOrdersOut.setSitename(departstation.getName());
		ticketOrdersOut.setSname(departstation.getName());
		ticketOrdersOut.setTicketinfos(new ArrayList<TicketOrderOut>());
		for (Ticketsellother ticketsellother : ticketsellothers) {
			Ticketsell _ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketsellother.getTicketsellid());
			TicketOrderOut ticketOrderOut = new TicketOrderOut();
			ticketOrderOut.setCartype(planvehiclebrandmodel.getBrandname());
			ticketOrderOut.setCheckport(ticketsell.getTicketentrance());
			ticketOrderOut.setCheckticket(_ticketsell.getIschecked());
			ticketOrderOut.setChecktime(_ticketsell.getChecktime());
			ticketOrderOut.setExchangeticket(ticketsellother.getIstaked());
			ticketOrderOut.setExchangetime(ticketsellother.getTaketime());
			ticketOrderOut.setLinename(schedule.getRoute().getName());
			ticketOrderOut.setPrice(_ticketsell.getPrice().floatValue());
			if(ticketsellother.getIstaked()){
				ticketOrderOut.setPrintticketno(_ticketsell.getTicketno());
			}
			else{
				ticketOrderOut.setPrintticketno(null);
			}
			ticketOrderOut.setPrinttickettime(ticketsellother.getTaketime());
			ticketOrderOut.setRidingpos(_ticketsell.getBuspark());
			ticketOrderOut.setSeatno(_ticketsell.getSeatno());
			ticketOrderOut.setSeattypeid(_ticketsell.getSeattype());
			ticketOrderOut.setSelltickettime(_ticketsell.getSelltime());
			ticketOrderOut.setTicketauthcode(ticketsellother.getPassword());
			ticketOrderOut.setTicketid(ticketsellother.getEticketid());
			ticketOrderOut.setTicketno(ticketsellother.getEticketno());
			ticketOrdersOut.getTicketinfos().add(ticketOrderOut);
		}
		result.setResult(1);
		result.setObject(ticketOrdersOut);
		return result;
	}

	@SuppressWarnings("unchecked")
  @Override
	public MethodResult GetSeatInfo(Date departdate, String schedulecode,
			String departstationcode, String reachstationcode) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", departstationcode));
		Station departstation = (Station) dao.uniqueResult(Station.class, propertyFilters);
		if(departstation==null){
			methodResult.setResult(102);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(departstationcode).append("的站点").toString());
			return methodResult;
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", reachstationcode));
		Station reachstation = (Station) dao.uniqueResult(Station.class, propertyFilters);
		if(reachstation==null){
			methodResult.setResult(102);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(reachstationcode).append("的站点").toString());
			return methodResult;
		}
		
		long orgid = organizationDao.getOrgByStationCode(departstationcode).getId();
//		propertyFilters.clear();
//		propertyFilters.add(new PropertyFilter("EQS_t!code", schedulecode));
//		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//		Schedule schedule = (Schedule) dao.uniqueResult(Schedule.class,propertyFilters);
		Schedule schedule = scheduleDao.getScheduleByCode(schedulecode,orgid,departdate);
		if(schedule==null){
			methodResult.setResult(101);
			methodResult.setResultMsg(new StringBuilder().append("找不到编码为").append(schedulecode).append("的班次").toString());
			return methodResult;
		}
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(Scheduleplan.class, propertyFilters);
		if(scheduleplan==null){
			methodResult.setResult(105);
			methodResult.setResultMsg(new StringBuilder().append("找不到发车日期为").append(departdate)
									.append(",班次编码为").append(schedulecode).append("的班次").toString());
			return methodResult;
		}
		initTickettyes();
		//取票价记录
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!departstationid", departstation.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", reachstation.getId()));
		List<Ticketprice> _ticketprices = dao.find(Ticketprice.class,propertyFilters);
		if(_ticketprices==null||_ticketprices.size()==0){
			methodResult.setResult(106);
			methodResult.setResultMsg(new StringBuilder().append("找不到发车站(").append(departstationcode).append(")至(")
									 .append(reachstationcode).append(")的票价").toString());
			return methodResult;
		}
		
		QueriedSeatsOrderOut queriedSeatsOrderOut = new QueriedSeatsOrderOut();
		queriedSeatsOrderOut.setQueriedSeat(new ArrayList<QueriedSeatOrderOut>());
		queriedSeatsOrderOut.setSeatnums(0);
		Schedulestatus schedulestatus = schedulestatusDao.getSchedulestatus(scheduleplan.getId(), departstation.getId());
		if(schedulestatus==null){
			methodResult.setResult(109);
			methodResult.setResultMsg(new StringBuilder().append("找不到发车日期为").append(departdate)
					.append(",班次编码为").append(schedulecode).append("发车站为").append(departstation.getName()).append("的班次状态").toString());
			return methodResult;
		}
		queriedSeatsOrderOut.setDtime(schedulestatus.getDeparttime());
		if(scheduleplan.getIssellable()&&!scheduleplan.getIsproprietary()&&(schedulestatus.getStatus().equals("0")||schedulestatus.getStatus().equals("2"))){
			//班次状态（正常、报停、晚点、被并、脱班、停售）取数据字典
			queriedSeatsOrderOut.setCansell(1);
		}
		else{
			queriedSeatsOrderOut.setCansell(0);
		}
		if( (scheduleplan.getIsoriginator()
				 || scheduleplan.getIssaleafterreport()
				)
				&&!schedulestatus.getIsreported()
			  ){
			queriedSeatsOrderOut.setCansell(0);
		}

		initSeattypes();
		for (Ticketprice ticketprice : _ticketprices) {
			//校验票价
			int leaveseatnum = ticketprice.getSeatnum()
					-ticketprice.getAutocancelreserveseatnum()
					-ticketprice.getFixedreserveseatnum()
					-ticketprice.getSoldeatnum()
					-ticketprice.getUnautocancelreserveseatnum();
			if(!ticketprice.getIssellable()){
				queriedSeatsOrderOut.setCansell(0);
			}
			for (String tickettype : tickettypes.keySet()) {
				QueriedSeatOrderOut queriedSeatOrderOut = new QueriedSeatOrderOut();
				BigDecimal price=new BigDecimal(0);
				switch (tickettype.charAt(0)) {
				case 'Q':
					price = ticketprice.getFullprice();
					break;
				case 'B':
					price = ticketprice.getHalfprice();
					break;
				case 'X':
					price = ticketprice.getStudentprice();
					break;
				default:
					try {
						price = ticketpriceformulaService.getPrice(orgid, departdate, tickettype, ticketprice.getFullprice());
					} catch (Exception e) {
						price = ticketprice.getFullprice();
					}
					break;
				}
				queriedSeatOrderOut.setPrice(price.floatValue());
				queriedSeatOrderOut.setPricetypeid(tickettype);
				queriedSeatOrderOut.setPricetypename(tickettypes.get(tickettype));
				queriedSeatOrderOut.setSeatnum(leaveseatnum);
				queriedSeatOrderOut.setSeattypeid(ticketprice.getSeattype());
				queriedSeatOrderOut.setSeattypename(seattypes.get(ticketprice.getSeattype()));
				queriedSeatsOrderOut.getQueriedSeat().add(queriedSeatOrderOut);
			} 
			queriedSeatsOrderOut.setSeatnums(queriedSeatsOrderOut.getSeatnums()+leaveseatnum);
		} 
		methodResult.setResult(1);
		methodResult.setObject(queriedSeatsOrderOut);
		return methodResult;
	}

	@Override
	public MethodResult UpdateEticket(UpdateEticketsInfo updateEticketsInfo) {
		MethodResult methodResult = new MethodResult();
		List<Ticketsellother> ticketsellothers = ticketsellotherDao.findByOrderno(updateEticketsInfo.getOrderid());
		for (UpdateEticketInfo updateEticketInfo : updateEticketsInfo.getETicketInfoList()) {
			boolean findticket = false;
			for (Ticketsellother ticketsellother : ticketsellothers) {
				if(ticketsellother.getEticketid().equals(updateEticketInfo.getTicketid())){
					if(!ticketsellother.getEticketno().equals(updateEticketInfo.getOrgticketno())
					  ||!ticketsellother.getPassword().equals(updateEticketInfo.getOrgticketauthcode())){
						methodResult.setResult(402);
						methodResult.setResultMsg("电子票ID"+updateEticketInfo.getTicketid()+"的原电子票号或验证码不正确");
						return methodResult;
					}
					//更新
					ticketsellother.setEticketno(updateEticketInfo.getNewticketno());
					ticketsellother.setPassword(updateEticketInfo.getNewticketauthcode());
					dao.merge(ticketsellother);
					findticket = true;
					break;
				}
			}
			if(!findticket){
				methodResult.setResult(403);
				methodResult.setResultMsg("找不到电子票ID"+updateEticketInfo.getTicketid());
				return methodResult;
			}
			
		}
		methodResult.setResult(1);
		return methodResult;
	}
	
	@Override
	public MethodResult takeTicket(String batchno, String ticketno,
			String eticketid) {
		MethodResult result = new MethodResult();
		Ticketsellother ticketsellother = ticketsellotherDao.getByETicketid(eticketid);
		if(ticketsellother==null){
			result.setResult(403);
			result.setResultMsg("找不到电子票ID"+eticketid);
			return result;
		}
		//校验售票记录密文是否正确
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketsellother.getTicketsellid());
		if(!ticketService.checkTicketByTicket(ticketsell)){
			result.setResult(0);
			result.setResultMsg("售票记录密文错误！");
			return result;
		}
		try {
			takeTicketService.remoteTakeTicket(batchno, ticketno, ticketsellother.getEticketno(), null,"2");
		} catch (ServiceException e) {
			result.setResult(404); //new Integer(e.getExceptionCode())
			result.setResultMsg("电子票已经取票，不能再取"); //e.getExceptionMessage()
		}
		result.setResult(1);
		return result;
	}
	
	private MethodResult checkSchedulestatus(long scheduleplanid,long departstationid){
		MethodResult methodResult = new MethodResult();
		//检查班次状态
		Schedulestatus schedulestatus = schedulestatusDao.getSchedulestatus(scheduleplanid, departstationid);
		if(schedulestatus==null){
			//班次状态记录不存在
			methodResult.setResult(109);
			methodResult.setResultMsg(getExceptioninfoDao().getExceptioninfo("0203"));
			return methodResult;
		}
		else if(schedulestatus.getIsdeparted()){
			//该班次已发班
			methodResult.setResult(109);
			methodResult.setResultMsg(getExceptioninfoDao().getExceptioninfo("0198"));
			return methodResult;
		}
		else if("1".equals(schedulestatus.getStatus())){
			//该班次班次已报停
			methodResult.setResult(109);
			methodResult.setResultMsg(getExceptioninfoDao().getExceptioninfo("0199"));
			return methodResult;
		}
		else if("3".equals(schedulestatus.getStatus())){
			//该班次班次已被并
			methodResult.setResult(109);
			methodResult.setResultMsg(getExceptioninfoDao().getExceptioninfo("0200"));
			return methodResult;
		}
		else if("4".equals(schedulestatus.getStatus())){
			//该班次班次已脱班
			methodResult.setResult(109);
			methodResult.setResultMsg(getExceptioninfoDao().getExceptioninfo("0201"));
			return methodResult;
		}
		else if("5".equals(schedulestatus.getStatus())){
			//该班次班次已停售
			methodResult.setResult(109);
			methodResult.setResultMsg(getExceptioninfoDao().getExceptioninfo("0202"));
			return methodResult;
		}
		//检查是否是专营班次
		if(schedulestatus.getScheduleplan().getIsproprietary()){
			methodResult.setResult(116);
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0351"));//该班次为发车站专营班次，不允许售联网票
			return methodResult;
		}
		//验证不可售
		if(!schedulestatus.getScheduleplan().getIssellable()){
			//班次不可售
			methodResult.setResult(110);
			methodResult.setResultMsg("班次不可售");
			return methodResult;
		}
		//报到后可售
		if( (schedulestatus.getScheduleplan().getIsoriginator()
				 || schedulestatus.getScheduleplan().getIssaleafterreport()
				)
				&&!schedulestatus.getIsreported()
			  ){
				methodResult.setResult(117);
				methodResult.setResultMsg("该班次报到后才允许售票");
				return methodResult;
			}
		methodResult.setResult(1);
		methodResult.setObject(schedulestatus);
		return methodResult;
	}


	public TicketSellService getTicketSellService() {
		return ticketSellService;
	}

	public void setTicketSellService(TicketSellService ticketSellService) {
		this.ticketSellService = ticketSellService;
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	public DigitaldictionarydetailDao getDigitaldictionarydetailDao() {
		return digitaldictionarydetailDao;
	}

	public void setDigitaldictionarydetailDao(DigitaldictionarydetailDao digitaldictionarydetailDao) {
		this.digitaldictionarydetailDao = digitaldictionarydetailDao;
	}

	public TicketpriceformulaService getTicketpriceformulaService() {
		return ticketpriceformulaService;
	}

	public void setTicketpriceformulaService(TicketpriceformulaService ticketpriceformulaService) {
		this.ticketpriceformulaService = ticketpriceformulaService;
	}

	public OrganizationDao getOrganizationDao() {
		return organizationDao;
	}

	public void setOrganizationDao(OrganizationDao organizationDao) {
		this.organizationDao = organizationDao;
	}

	public SchedulestatusDao getSchedulestatusDao() {
		return schedulestatusDao;
	}

	public void setSchedulestatusDao(SchedulestatusDao schedulestatusDao) {
		this.schedulestatusDao = schedulestatusDao;
	}

	public ExceptioninfoDao getExceptioninfoDao() {
		return exceptioninfoDao;
	}

	public void setExceptioninfoDao(ExceptioninfoDao exceptioninfoDao) {
		this.exceptioninfoDao = exceptioninfoDao;
	}

	public StationDao getStationDao() {
		return stationDao;
	}

	public void setStationDao(StationDao stationDao) {
		this.stationDao = stationDao;
	}

	public TakeTicketService getTakeTicketService() {
		return takeTicketService;
	}

	public void setTakeTicketService(TakeTicketService takeTicketService) {
		this.takeTicketService = takeTicketService;
	}

	public TicketsellotherDao getTicketsellotherDao() {
		return ticketsellotherDao;
	}

	public void setTicketsellotherDao(TicketsellotherDao ticketsellotherDao) {
		this.ticketsellotherDao = ticketsellotherDao;
	}

	public BalancedeductService getBalancedeductService() {
		return balancedeductService;
	}

	public void setBalancedeductService(BalancedeductService balancedeductService) {
		this.balancedeductService = balancedeductService;
	}

	public ScheduleDao getScheduleDao() {
		return scheduleDao;
	}

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	public ScheduleperselldaysService getScheduleperselldaysService() {
		return scheduleperselldaysService;
	}

	public void setScheduleperselldaysService(ScheduleperselldaysService scheduleperselldaysService) {
		this.scheduleperselldaysService = scheduleperselldaysService;
	}

}
