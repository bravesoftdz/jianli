package cn.nova.bus.checkticket.remote.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.CommonUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.checkticket.dao.RemoteCheckTicketDao;
import cn.nova.bus.checkticket.remote.service.CheckTicketClientService;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.utils.commons.ParamCheckTicketIn;
import cn.nova.utils.commons.ParamCheckTicketOut;

public class CheckTicketClientServiceImpl implements CheckTicketClientService {

	private OrganizationService organizationService = new OrganizationServiceImpl();
	final private int insideInvokFalse = -67101735;
	private RemoteCheckTicketDao remoteCheckTicketDao = new RemoteCheckTicketDao();

	final private Logger log = LoggerFactory.getLogger(getClass());

//	private CenterCheckTicketService getCentreInterface(
//			MethodResult methodResult, Organization localorg) {
//		Organization centreOrg = organizationService
//				.getDirectlyParentOrg(localorg);
//		if (centreOrg == null) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到" + localorg.getName()
//					+ "的上级机构");
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//		try {
//			return (CenterCheckTicketService) EJBFactory.getRemoteEJB(
//					CenterCheckTicketService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:" + e.getMessage());
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//	}

	@Override
	public ParamCheckTicketOut findTicketsell(ParamCheckTicketIn inparam,
			Global global) {
		ParamCheckTicketOut paramCheckTicketOut = new ParamCheckTicketOut();
		try {
//			CenterCheckTicketService remoteCheckTicketService = getCentreInterface(methodResult, global.getOrganization());
//			if (remoteCheckTicketService == null) {
//				paramCheckTicketOut.setResult(methodResult.getResult());
//				paramCheckTicketOut.setResultMsg(methodResult.getResultMsg());
//				return paramCheckTicketOut;
//			}
//			paramCheckTicketOut = remoteCheckTicketService.findTicketsell(inparam);
			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("inparam", JsonUtil.toFormatString(inparam));

			String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_TICKET_SELL, requestMap);		
			paramCheckTicketOut = JsonUtil.parseObject(resultstr, ParamCheckTicketOut.class);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			paramCheckTicketOut.setResult(-1);
			paramCheckTicketOut.setResultMsg("执行异常");
		}
		return paramCheckTicketOut;
	}

	@SuppressWarnings("unchecked")
	@Override
	public ParamCheckTicketOut checkTicketsell(ParamCheckTicketIn inparam,
			Global global)throws Exception {
		Date now = new Date();
		ParamCheckTicketOut outparam = new ParamCheckTicketOut();
//		MethodResult methodResult = new MethodResult();
//		CenterCheckTicketService remoteCheckTicketService = getCentreInterface(methodResult, global.getOrganization());
//		if (remoteCheckTicketService == null) {
//			outparam.setResult(methodResult.getResult());
//			outparam.setResultMsg(methodResult.getResultMsg());
//			return outparam;
//		}
		
		inparam.setCheckorgcode(global.getOrganization().getCode());
		Vehicle vehicle = remoteCheckTicketDao.getVehicle(inparam.getVehicleno());
		Vehiclereport vr = (Vehiclereport) remoteCheckTicketDao.get(Vehiclereport.class, inparam.getReportid());
		Vehiclebrandmodel vb = (Vehiclebrandmodel) remoteCheckTicketDao.get(Vehiclebrandmodel.class, vehicle.getVehiclebrandmodelid());
		Station station = (Station) remoteCheckTicketDao.get(Station.class,global.getOrganization().getStation().getId());
		Organization departorg = remoteCheckTicketDao.getOrganization(inparam.getDepartorgcode());
		inparam.setCheckstationcode(station.getCode());
		inparam.setVehiclebrandmodelname(vb.getBrandname());
		
		
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("inparam", JsonUtil.toFormatString(inparam));

		String resultstr = RpcUtil.remoteCall(centreOrg.getServersaddress(), RemoteApi.CHECK_TICKET_SELL, requestMap);		
		outparam = JsonUtil.parseObject(resultstr, ParamCheckTicketOut.class);
		
		
//		outparam = remoteCheckTicketService.checkTicketsell(inparam);
		long updateby = global.getUserinfo().getId();
		String seatno="";
		if (outparam.getResult() == 1) {
			Organization sellorg = remoteCheckTicketDao.getOrganization(outparam.getTicketsellorgcode());
			RemoteTicketsell rst = new RemoteTicketsell();
			rst.setAdditionfee(outparam.getAdditionfee());
			rst.setBatchno(outparam.getBatchno());
			rst.setBuspark(outparam.getBuspark());
			rst.setCarrychildnum(outparam.getCarrychildnum());
			rst.setChecktype("1");// 0：被检，1：检入
			rst.setComputefee(outparam.getComputefee());
			rst.setCoolairfee(outparam.getCoolairfee());
			rst.setCreateby(0);
			rst.setCreatetime(now);
			rst.setTicketsellorgid(sellorg.getId());
			rst.setCheckby(inparam.getCheckby());
			rst.setChecktime(now);
			rst.setDepartdate(outparam.getDepartDate());
			Station dstation = (Station) remoteCheckTicketDao
					.getStation(outparam.getDepartStationCode());
			rst.setDepartstationid(dstation.getId());
			rst.setDeparttime(outparam.getDeparttime());
			rst.setCheckorgid(global.getOrganization().getId());
			rst.setDiscountrate(outparam.getDiscountrate());
			rst.setDistance(outparam.getDistance());
			rst.setFueladditionfee(outparam.getFueladditionfee());
			rst.setFullprice(outparam.getFullprice());
			rst.setInsurefee(outparam.getInsurefee());
			rst.setIslinework(outparam.isIslinework());
			rst.setMoreprice(outparam.getMoreprice());
			rst.setOrderno(outparam.getOrderno());
			rst.setDepartorgid(departorg.getId());
			rst.setOtherfee(outparam.getOtherfee());
			rst.setPaymethod(outparam.getPaymethod());
			rst.setPrice(outparam.getPrice());
			Station rstation = (Station) remoteCheckTicketDao
					.getStation(outparam.getReachStationCode());
			rst.setReachstationid(rstation.getId());
			rst.setSchedulecode(outparam.getScheduleCode());
			rst.setSeatno(outparam.getSeatno());
			rst.setSeattype(outparam.getSeattype());
			rst.setSellby(outparam.getSellby());
			rst.setSellip(outparam.getSellip());
			rst.setSelltime(outparam.getSelltime());
			rst.setSellway(outparam.getSellway());
			rst.setServicefee(outparam.getServicefee());
			rst.setServiceprice(outparam.getServicefee());
			rst.setStationservicefee(outparam.getStationservicefee());
			rst.setTicketentrance(outparam.getTicketentrance());
			rst.setTicketno(outparam.getTicketno());
			rst.setTicketoutletsname(outparam.getTicketoutletsname());
			rst.setTicketstatus(outparam.getTicketstatus());
			rst.setTickettype(outparam.getTickettype());
			rst.setToplimitprice(outparam.getToplimitprice());
			rst.setUpdateby(0);
			rst.setIschecked(true);
			rst.setUpdatetime(now);
			rst.setIsdepartinvoices(false);
			rst.setVehicleno(inparam.getVehicleno());
			rst.setVehicletypename(outparam.getVehicletypename());
			rst.setWaterfee(outparam.getWaterfee());
			rst.setScheduleplanid(vr.getScheduleplanid());
			rst.setVehiclereportid(vr.getId());
			remoteCheckTicketDao.merge(rst);
			Scheduleplan sp = (Scheduleplan) remoteCheckTicketDao.get(
					Scheduleplan.class, vr.getScheduleplanid());
			if (!sp.getIslinework()) {
				List<Scheduleseats> sslist = sp.getScheduleseatslist();
				boolean isfind = false;
				for (Scheduleseats ss : sslist) {
					if (ss.getSeatno() == outparam.getSeatno()) {
							ss.setStatus("7");
							seatno=ss.getSeatno()+"";
							ss.setSeattype(outparam.getSeattype());
							ss.setTickettype(outparam.getTickettype());
							ss.setUpdateby(updateby);
							ss.setUpdatetime(now);
							remoteCheckTicketDao.merge(ss);
							isfind = true;
							break;
					}
				}
				if (!isfind) {
					for (Scheduleseats ss : sslist) {
						if (ss.getStatus().equals("0")) {
							ss.setStatus("7");
							ss.setSeattype(outparam.getSeattype());
							ss.setTickettype(outparam.getTickettype());
							ss.setUpdateby(updateby);
							ss.setUpdatetime(now);
							seatno=ss.getSeatno()+"";
							remoteCheckTicketDao.merge(ss);
							isfind = true;
							break;
						}
					}
				}
			}

		}
		if(outparam.getResult()==1){
			outparam.setResultMsg("票号:"+inparam.getTicketno()+"远程检票成功，检到"+seatno+"号座位");
		}
		return outparam;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String qryOrgSell(Date departdate, long scheduleid,Global global)
			throws ServiceException {
		String info="";
		try {
			Schedule sc=(Schedule) remoteCheckTicketDao.get(Schedule.class, scheduleid);
			if (sc.getWorktype().equals("3")) {
				
//				MethodResult methodResult = new MethodResult();
//				CenterCheckTicketService remoteCheckTicketService = getCentreInterface(methodResult, global.getOrganization());
//				if (remoteCheckTicketService == null) {
//					return "";
//				}
//				info = remoteCheckTicketService.qryOrgSell(departdate,sc.getSynccode());
				Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
				requestMap.put("schsynccode", sc.getSynccode());

				String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.QRY_ORG_SELL, requestMap);		
				info = resultstr;			
			} else {
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
				String  begin=df.format(departdate);
				StringBuilder sql = new StringBuilder();
				sql.append("select s1.name || '：' || count(t.id) || '张'")
						.append(" from ticketsell t, station s1")
						.append(" where t.departstationid = s1.id and t.ticketstatus = '0'")
						.append(" and t.scheduleid =:scheduleid  and t.departdate =to_date('"+begin+"','yyyymmdd') ")
						.append(" group by s1.name");
				Query query = remoteCheckTicketDao.getEntityManager()
						.createNativeQuery(sql.toString());
				//query.setParameter("departdate", departdate);
				query.setParameter("scheduleid", scheduleid);
				List<Object> list = query.getResultList();
				for (Object ob : list) {
					info = info + ob.toString() + ",";
				}
				return info;
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return info;
	}

}
