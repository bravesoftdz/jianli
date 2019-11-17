package cn.nova.bus.checkticket.remote.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import play.data.binding.As;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.checkticket.dao.RemoteCheckTicketDao;
import cn.nova.bus.checkticket.remote.service.CheckTicketStationService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.ParamCheckTicketIn;
import cn.nova.utils.commons.ParamCheckTicketOut;

public class CheckTicketStationServiceImpl implements CheckTicketStationService {
	private TicketDao ticketDao = new TicketDao();
	private ParameterService parameterService = new ParameterServiceImpl();
	private TicketService ticketService = new TicketServiceImpl();
	private RemoteCheckTicketDao remoteCheckTicketDao = new RemoteCheckTicketDao();

	@SuppressWarnings("unchecked")
	@Override
	public ParamCheckTicketOut findTicketsell(ParamCheckTicketIn inparam) {
		ParamCheckTicketOut outparam=new ParamCheckTicketOut();
		Organization org=remoteCheckTicketDao.getOrganization(inparam.getDepartorgcode());
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开  3019改3041
		int days =  new Integer(opendays);
		Date departdate=new Date();
		if (days > 0){
			departdate = DateUtils.add(new Date(), -days);
		}else{
			departdate = new Date();
		}
		String ticketno=inparam.getTicketno();
		// 获取车票并锁住
		//如果取不到车票，提示“该车票不存在，或过了补开天数”
		Ticketsell ticket = ticketDao.getTicket(ticketno, departdate);
		if (ticket == null) {
			// 该车票不存在，或过了补开天数
			outparam.setResult(-1);
			outparam.setResultMsg("该车票不存在，或过了补开天数");
			return outparam;
		}
		if(ticket.getTicketstatus().equals("1")){
			outparam.setResult(-1);
			outparam.setResultMsg("该车票已经退票！");
			return outparam;
		}
		if(ticket.getTicketstatus().equals("2")){
			outparam.setResult(-1);
			outparam.setResultMsg("该车票已经废票！");
			return outparam;
		}
		if(ticket.getIschecked()){
			outparam.setResult(-1);
			outparam.setResultMsg("该车票已检！");
			return outparam;
		}
		Station dstation=(Station) remoteCheckTicketDao.get(Station.class, ticket.getDepartstationid());
		Station rstation=(Station) remoteCheckTicketDao.get(Station.class, ticket.getReachstationid());
		Tickettype tickettype=remoteCheckTicketDao.getTickettype(ticket.getTickettype());
		Schedule schedule=(Schedule) remoteCheckTicketDao.get(Schedule.class, ticket.getScheduleid());
		Organization sellorg=(Organization) remoteCheckTicketDao.get(Organization.class, ticket.getOrgid());
		outparam.setDepartStationCode(dstation.getCode());
		outparam.setDepartStationName(dstation.getName());
		outparam.setReachStationCode(rstation.getCode());
		outparam.setReachStationName(rstation.getName());
		outparam.setReachStationSecondName(rstation.getSecondname());
		outparam.setTickettypeCode(tickettype.getCode());
		outparam.setTickettypeName(tickettype.getPrintname());
		outparam.setSeatno(ticket.getSeatno());
		outparam.setTicketsellorgcode(sellorg.getCode());
		outparam.setCarrychildnum(ticket.getCarrychildnum());
		outparam.setPrice(ticket.getPrice());
		outparam.setDepartDate(ticket.getDepartdate());
		outparam.setDeparttime(ticket.getDeparttime());
		outparam.setScheduleCode(schedule.getCode());
		outparam.setTicketentrance(ticket.getTicketentrance());
		outparam.setBuspark(ticket.getBuspark());
		outparam.setTicketno(ticketno);
		outparam.setTicketstatus(ticket.getTicketstatus());
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		outparam.setStrdepartdate(sf.format(ticket.getDepartdate()));
		outparam.setScheduleCode(schedule.getCode());
		outparam.setResult(1);
		outparam.setResultMsg("查询成功");
		return outparam;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public ParamCheckTicketOut checkTicketsell(ParamCheckTicketIn inparam) {
		ParamCheckTicketOut outparam=new ParamCheckTicketOut();
		Organization org=remoteCheckTicketDao.getOrganization(inparam.getDepartorgcode());
		Organization checkorg=remoteCheckTicketDao.getOrganization(inparam.getCheckorgcode());
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate=new Date();
		if (days > 0){
			departdate = DateUtils.add(new Date(), -days);
		}else{
			departdate = new Date();
		}
		String ticketno=inparam.getTicketno();
		// 获取车票并锁住
		//如果取不到车票，提示“该车票不存在，或过了补开天数”
		Ticketsell ticket=null;
		try {
			ticket = ticketService.getTicket(ticketno, departdate);
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage(), e);
			outparam.setResult(-1);
			outparam.setResultMsg("未找到该车票信息！");
			return outparam;
		}
		if(ticket==null){
			outparam.setResult(-1);
			outparam.setResultMsg("未找到该车票信息！");
			return outparam;
		}
		if(ticket.getTicketstatus().equals("1")){
			outparam.setResult(-1);
			outparam.setResultMsg("该车票已经退票！");
			return outparam;
		}
		if(ticket.getTicketstatus().equals("2")){
			outparam.setResult(-1);
			outparam.setResultMsg("该车票已经废票！");
			return outparam;
		}	
		if(ticket.getIschecked()){
			outparam.setResult(-1);
			outparam.setResultMsg("该车票已检！");
			return outparam;
		}		
		Vehicle vehicle=remoteCheckTicketDao.getVehicle(inparam.getVehicleno());
		Date now=new Date();
		Station checkstation=remoteCheckTicketDao.getStation(inparam.getCheckstationcode());
		Userinfo userinfo=(Userinfo) remoteCheckTicketDao.get(Userinfo.class,new Long(0));
		Station dstation=(Station) remoteCheckTicketDao.get(Station.class, ticket.getDepartstationid());
		Station rstation=(Station) remoteCheckTicketDao.get(Station.class, ticket.getReachstationid());
		Tickettype tickettype=remoteCheckTicketDao.getTickettype(ticket.getTickettype());
		Vehicletype vehicletype=(Vehicletype) remoteCheckTicketDao.get(Vehicletype.class, vehicle.getVehicletypeid());
		Schedule schedule=(Schedule) remoteCheckTicketDao.get(Schedule.class, ticket.getScheduleid());
		Ticketoutlets ts= (Ticketoutlets) remoteCheckTicketDao.get(Ticketoutlets.class, ticket.getTicketoutletsid());
		Organization sellorg=(Organization) remoteCheckTicketDao.get(Organization.class, ticket.getOrgid());		
		outparam.setDepartStationCode(dstation.getCode());
		outparam.setDepartStationName(dstation.getName());
		outparam.setReachStationCode(rstation.getCode());
		outparam.setReachStationName(rstation.getName());
		outparam.setVehicletypename(vehicletype.getName());
		outparam.setReachStationSecondName(rstation.getSecondname());
		outparam.setTickettypeCode(tickettype.getCode());
		outparam.setTickettypeName(tickettype.getPrintname());
		outparam.setSeatno(ticket.getSeatno());
		outparam.setCarrychildnum(ticket.getCarrychildnum());
		outparam.setPrice(ticket.getPrice());
		outparam.setTicketsellorgcode(sellorg.getCode());
		outparam.setDepartDate(ticket.getDepartdate());
		outparam.setDeparttime(ticket.getDeparttime());
		outparam.setScheduleCode(schedule.getCode());
		outparam.setTicketentrance(ticket.getTicketentrance());
		outparam.setBuspark(ticket.getBuspark());
		outparam.setTicketno(ticketno);
		outparam.setTicketoutletsname(ts.getName());
		outparam.setAdditionfee(ticket.getAdditionfee());
		outparam.setBatchno(ticket.getBatchno());
		outparam.setCheckby(inparam.getCheckby());
		outparam.setChecktime(now);
		outparam.setComputefee(ticket.getComputefee());
		outparam.setCoolairfee(ticket.getCoolairfee());
		outparam.setDiscountrate(ticket.getDiscountrate());
		outparam.setDistance(ticket.getDistance());
		outparam.setFueladditionfee(ticket.getFueladditionfee());
		outparam.setFullprice(ticket.getFullprice());
		outparam.setInsurefee(ticket.getInsurefee());
		outparam.setIslinework(ticket.getIslinework());
		outparam.setMoreprice(ticket.getMoreprice());
		outparam.setOrderno(ticket.getOrderno());
		outparam.setOtherfee(ticket.getOtherfee());
		outparam.setPaymethod(ticket.getPaymethod());
		outparam.setSeattype(ticket.getSeattype());
		Userinfo userinfo2=(Userinfo) remoteCheckTicketDao.get(Userinfo.class,ticket.getSellby());
		outparam.setSellby(userinfo2.getName());
		outparam.setSellip(ticket.getSellip());
		outparam.setSelltime(ticket.getSelltime());
		outparam.setSellway(ticket.getSellway());
		outparam.setServicefee(ticket.getServicefee());
		outparam.setStationservicefee(ticket.getStationservicefee());
		outparam.setTicketstatus(ticket.getTicketstatus());
		outparam.setTickettype(ticket.getTickettype());
		outparam.setToplimitprice(ticket.getToplimitprice());
		outparam.setWaterfee(ticket.getWaterfee());
		outparam.setVehicleno(inparam.getVehicleno());
		RemoteTicketsell rst=new RemoteTicketsell();
		rst.setAdditionfee(ticket.getAdditionfee());
		rst.setBatchno(ticket.getBatchno());
		rst.setBuspark(ticket.getBuspark());
		rst.setCarrychildnum(ticket.getCarrychildnum());
		rst.setChecktype("0");//0：被检，1：检入
		rst.setComputefee(ticket.getComputefee());
		rst.setCoolairfee(ticket.getCoolairfee());
		rst.setCreateby(0);
		rst.setCreatetime(now);
		rst.setDepartdate(ticket.getDepartdate());
		rst.setDepartstationid(ticket.getDepartstationid());
		rst.setDeparttime(ticket.getDeparttime());
		rst.setDiscountrate(ticket.getDiscountrate());
		rst.setDistance(ticket.getDistance());
		rst.setFueladditionfee(ticket.getFueladditionfee());
		rst.setFullprice(ticket.getFullprice());
		rst.setInsurefee(ticket.getInsurefee());
		rst.setIslinework(ticket.getIslinework());
		rst.setMoreprice(ticket.getMoreprice());
		rst.setOrderno(ticket.getOrderno());
		rst.setDepartorgid(org.getId());
		rst.setCheckorgid(checkorg.getId());
		rst.setOtherfee(ticket.getOtherfee());
		rst.setPaymethod(ticket.getPaymethod());
		rst.setPrice(ticket.getPrice());
		rst.setReachstationid(ticket.getReachstationid());
		rst.setSchedulecode(schedule.getCode());
		rst.setSeatno(ticket.getSeatno());
		rst.setSeattype(ticket.getSeattype());
		rst.setSellip(ticket.getSellip());
		rst.setSelltime(ticket.getSelltime());
		rst.setSellway(ticket.getSellway());
		rst.setServicefee(ticket.getServicefee());
		rst.setServiceprice(ticket.getServicefee());
		rst.setStationservicefee(ticket.getStationservicefee());
		rst.setTicketoutletsname(ts.getName());
		rst.setTicketentrance(ticket.getTicketentrance());
		rst.setTicketno(ticket.getTicketno());
		rst.setTicketstatus(ticket.getTicketstatus());
		rst.setTickettype(ticket.getTickettype());
		rst.setToplimitprice(ticket.getToplimitprice());
		rst.setIsdepartinvoices(false);
		rst.setUpdateby(0);
		rst.setUpdatetime(now);
		rst.setIschecked(true);		
		rst.setVehicleno(inparam.getVehicleno());
		rst.setVehicletypename(vehicletype.getName());
		rst.setWaterfee(ticket.getWaterfee());
		rst.setCheckby(inparam.getCheckby());
		rst.setChecktime(now);
		rst.setSellby(userinfo2.getName());
		remoteCheckTicketDao.merge(rst);
		ticket.setChecktime(now);
		ticket.setCheckedby(userinfo);
		ticket.setCheckstation(checkstation);
		ticket.setIschecked(true);
		ticket.setUpdateby(0);
		ticket.setUpdatetime(now);		
		remoteCheckTicketDao.merge(ticket);		
		outparam.setResult(1);
		outparam.setResultMsg("票号:"+ticketno+"检票成功");
		return outparam;
	}
	@SuppressWarnings("unchecked")
	@Override
	public MethodResult cancelRemoteTicketCheck(String ticketno, String departorgcode,Date departdate){
		MethodResult methodResult=new MethodResult();
		
		Organization org=remoteCheckTicketDao.getOrganization(departorgcode);
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate4search=new Date();
		if (days > 0){
			departdate4search = DateUtils.add(new Date(), -days);
		}else{
			departdate4search = new Date();
		}

		Ticketsell ticket=null;
		try {
			ticket = ticketService.getTicket(ticketno, departdate4search);
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage(), e);
			methodResult.setResult(-1);
			methodResult.setResultMsg("未找到该车票信息！");
			return methodResult;
		}
		if(ticket==null){
			methodResult.setResult(-1);
			methodResult.setResultMsg("未找到该车票信息！");
			return methodResult;
		}

		if(!ticket.getIschecked()){
			methodResult.setResult(-1);
			methodResult.setResultMsg("该车票未检！");
			return methodResult;
		}		
		
		remoteCheckTicketDao.deleteRemoteCheck(ticketno, org.getId(), departdate);
		
		ticket.setIschecked(false);
		ticket.setUpdateby(0);
		ticket.setUpdatetime(new Date());		
		remoteCheckTicketDao.merge(ticket);		
		methodResult.setResult(1);
		methodResult.setResultMsg("票号:"+ticketno+"退检成功");
		return methodResult;
	}
}
