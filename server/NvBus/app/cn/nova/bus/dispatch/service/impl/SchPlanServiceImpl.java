package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;
import util.NvException;
import util.RemoteApi;
import util.RpcUtil;
import util.TransactionUtil;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.service.RouteService;
import cn.nova.bus.base.service.ScheduleService;
import cn.nova.bus.base.service.impl.RouteServiceImpl;
import cn.nova.bus.base.service.impl.ScheduleServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.dao.SchPlanDao;
import cn.nova.bus.dispatch.model.UpdateScheduleSeats;
import cn.nova.bus.dispatch.model.UpdateSeatReserve;
import cn.nova.bus.dispatch.model.UpdateTicketSell;
import cn.nova.bus.dispatch.service.SchPlanService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.DictionaryService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.DictionaryServiceImpl;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class SchPlanServiceImpl implements SchPlanService {
	
	private SchPlanDao schPlanDao = new SchPlanDao();
	
	private OperationLogService operationLogService = new OperationLogServiceImpl();
	
	private	RouteService routeService = new RouteServiceImpl();
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private ScheduleService scheduleService = new ScheduleServiceImpl();
	
	private DictionaryService dictionaryService = new DictionaryServiceImpl();
	@Override
	public List<Map<String, Object>> qryTicketprice(long scheduleplanid) {
		return ListUtil.listToMap(
				new Object[] { "id", "scheduleplanid", "scheduleid", "departstationid", "reachstationid", "seattype",
						"fullprice", "halfprice", "studentprice", "issellable", "toplimitprice", "moreprice",
						"departstationname", "reachstationname", "discountprice", "roundprice", "connectprice" },
				schPlanDao.queryTicketprice(scheduleplanid),
				new Object[] { Long.class, Long.class, Long.class, Long.class, Long.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, Boolean.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean batchsaveticketprice(String scheduleids,boolean iscopytostation,
			List<Ticketprice> ticketpricelist, Date fromdate, Date enddate,
			long updateby, String ipAddress) throws ServiceException {
		long days = DateUtils.getIntervalDays(fromdate, enddate) + 1;
		String[] scid = scheduleids.split(",");
		//boolean iscopytostation=true;
		/*for (Ticketprice stp : ticketpricelist) {
			List<Ticketpriceitem> ttis=schPlanDao.qryTicketpriceitems(fromdate,stp.getId());
			stp.setTicketpriceitemlist(ttis);
		}*/
		for (String curid : scid) {
			long scheduleid = new Long(curid);
		//	long a=System.currentTimeMillis();
			for (int i = 0; i < days; i++) {
				Date departdate = DateUtils.add(fromdate, i);
				List<Ticketprice> tps = schPlanDao.qryTicketprices(departdate,
						scheduleid);
				for (Ticketprice tp : tps) {
					if(iscopytostation){
						long startstationid=tp.getScheduleplan().getStartstationid();
						List<Ticketprice> startstationprices=new ArrayList<Ticketprice>();
						for (Ticketprice stp : ticketpricelist) {
							if(stp.getDepartstationid()==startstationid){
								startstationprices.add(stp);
							}
						}
						for (Ticketprice oldtp : startstationprices) {
							if ( tp.getReachstationid() == oldtp
											.getReachstationid()
									&& tp.getSeattype().equals(oldtp.getSeattype())) {
								savePriceChangeLog(tp, oldtp, updateby, ipAddress);
								tp.setIssellable(oldtp.getIssellable());
								tp.setFullprice(oldtp.getFullprice());
								tp.setHalfprice(oldtp.getHalfprice());
								tp.setStudentprice(oldtp.getStudentprice());
								tp.setUpdateby(updateby);
								tp.setMoreprice(oldtp.getMoreprice());
								tp.setToplimitprice(oldtp.getToplimitprice());
								tp.setDiscountprice(oldtp.getDiscountprice());
								tp.setRoundprice(oldtp.getRoundprice());
								tp.setConnectprice(oldtp.getConnectprice());
								tp.setUpdatetime(new Date());
								schPlanDao.merge(tp);
								updatepriceitem(updateby, tp,oldtp.getId(),fromdate);// 修改基础运费
								continue;
							}
						}
					}else{
						for (Ticketprice oldtp : ticketpricelist) {
							if (tp.getDepartstationid() == oldtp
									.getDepartstationid()
									&& tp.getReachstationid() == oldtp
											.getReachstationid()
									&& tp.getSeattype().equals(oldtp.getSeattype())) {
								savePriceChangeLog(tp, oldtp, updateby, ipAddress);
								tp.setIssellable(oldtp.getIssellable());
								tp.setFullprice(oldtp.getFullprice());
								tp.setHalfprice(oldtp.getHalfprice());
								tp.setStudentprice(oldtp.getStudentprice());
								tp.setUpdateby(updateby);
								tp.setMoreprice(oldtp.getMoreprice());
								tp.setToplimitprice(oldtp.getToplimitprice());
								tp.setDiscountprice(oldtp.getDiscountprice());
								tp.setRoundprice(oldtp.getRoundprice());
								tp.setConnectprice(oldtp.getConnectprice());
								tp.setUpdatetime(new Date());
								schPlanDao.merge(tp);
								updatepriceitem(updateby, tp,oldtp.getId(),fromdate);// 修改基础运费
								continue;
							}
						}
					}
				}
			}
			//long b=System.currentTimeMillis();
			//System.out.println("1="+(b-a));
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	private void updatepriceitem(long updateby, Ticketprice price, long oldpriceid,Date departdate)
			throws ServiceException {
		//long a=System.currentTimeMillis();  
		//List<Ticketpriceitem> priceitems=schPlanDao.qryTicketpriceitems(price.getDepartdate(),price.getId());
		List<Ticketpriceitem> olditems=schPlanDao.qryTicketpriceitems(departdate,oldpriceid);
		List<Ticketpriceitem> priceitems=price.getTicketpriceitemlist();
		//long b=System.currentTimeMillis();
		//System.out.println("  2="+(b-a));
		for(Ticketpriceitem item:priceitems){
			for(Ticketpriceitem tti:olditems){
			    if(item.getTicketpriceformulaitemid()==tti.getTicketpriceformulaitemid()
			    &&item.getTickettype()==tti.getTickettype()){
			    	item.setPrice(tti.getPrice());
			    	break;
			    }
			}
		}
		BigDecimal fprice=new BigDecimal(0);
		for(Ticketpriceitem item:priceitems){
			if(!item.isIsautoadjust() && item.getTickettype().equals("Q")){
				fprice=fprice.add(item.getPrice());
			}
		}
		if (price.getFullprice().compareTo(fprice) < 0) {
			throw new ServiceException("全票票价分项总和为：" + fprice, "0324");
		}
		for(Ticketpriceitem item:priceitems){
			if(item.isIsautoadjust()){
				item.setPrice(price.getFullprice().subtract(fprice));
			}
	    	item.setUpdatetime(new Date());
	    	item.setUpdateby(updateby);
	    	schPlanDao.merge(item);
		}
		/*
		Ticketpriceitem fullpriceitem = schPlanDao.findPriceitem(price.getId(),
				'Q',price.getDepartdate());
		if (fullpriceitem != null) {
			BigDecimal fullprice = schPlanDao.getIsfreight(price.getId(), 'Q');
			if (price.getFullprice().compareTo(fullprice) <= 0) {
				throw new ServiceException("全票票价分项总和为：" + fullprice, "0324");
			}
			fullpriceitem.setPrice(price.getFullprice().subtract(fullprice));
			fullpriceitem.setUpdateby(updateby);
			fullpriceitem.setUpdatetime(new Date());
			schPlanDao.merge(fullpriceitem);
		}

		Ticketpriceitem studentpriceitem = schPlanDao.findPriceitem(
				price.getId(), 'X',price.getDepartdate());
		if (studentpriceitem != null) {
			BigDecimal studentprice = schPlanDao.getIsfreight(price.getId(),
					'X');
			if (price.getStudentprice().compareTo(studentprice) <= 0) {
				throw new ServiceException("学生票票价分项总和为：" + studentprice, "0324");
			}
			studentpriceitem.setPrice(price.getStudentprice().subtract(
					studentprice));
			studentpriceitem.setUpdateby(updateby);
			studentpriceitem.setUpdatetime(new Date());
			schPlanDao.merge(studentpriceitem);
		}

		Ticketpriceitem halfpriceitem = schPlanDao.findPriceitem(price.getId(),
				'B',price.getDepartdate());
		if (halfpriceitem != null) {
			BigDecimal halfprice = schPlanDao.getIsfreight(price.getId(), 'B');
			if(halfprice!=null){
				if (price.getHalfprice().compareTo(halfprice) <= 0) {
					throw new ServiceException("半票票价分项总和为：" + halfprice, "0324");
				}
				halfpriceitem.setPrice(price.getHalfprice().subtract(halfprice));
				halfpriceitem.setUpdateby(updateby);
				halfpriceitem.setUpdatetime(new Date());
				schPlanDao.merge(halfpriceitem);
			}
		}

		Ticketpriceitem toplimitpriceitem = schPlanDao.findPriceitem(
				price.getId(), 'S',price.getDepartdate());
		if (toplimitpriceitem != null) {
			BigDecimal toplimitprice = schPlanDao.getIsfreight(price.getId(),
					'S');
			if (price.getHalfprice().compareTo(toplimitprice) <= 0) {
				throw new ServiceException("上限价分项总和为：" + toplimitprice, "0324");
			}
			toplimitpriceitem.setPrice(price.getToplimitprice().subtract(
					toplimitprice));
			toplimitpriceitem.setUpdateby(updateby);
			toplimitpriceitem.setUpdatetime(new Date());
			schPlanDao.merge(toplimitpriceitem);
		}
		*/
	}

	@SuppressWarnings("unchecked")
	private void savePriceChangeLog(Ticketprice price, Ticketprice ticketprice,
			long updateby, String ip) {
		Schedule schedule = (Schedule) schPlanDao.get(Schedule.class,
				price.getScheduleid());
		Station departstation = (Station) schPlanDao.get(Station.class,
				price.getDepartstationid());
		Station reachstation = (Station) schPlanDao.get(Station.class,
				price.getReachstationid());
		StringBuilder result = new StringBuilder();
		result.append("调整票价,班次号：").append(schedule.getCode()).append(",发车日期:")
				.append(DateUtils.formatDate(price.getDepartdate()))
				.append(",发车站").append(departstation.getName()).append(",到达站")
				.append(reachstation.getName());
		boolean pricehaschang = false;
		if (price.getFullprice().compareTo(ticketprice.getFullprice()) != 0) {
			result.append(" 全票价由").append(price.getFullprice()).append("调整为：")
					.append(ticketprice.getFullprice());
			pricehaschang = true;
		}
		if (price.getStudentprice().compareTo(ticketprice.getStudentprice()) != 0) {
			result.append(" 学生票价由").append(price.getStudentprice())
					.append("调整为：").append(ticketprice.getStudentprice());
			pricehaschang = true;
		}
		if (price.getHalfprice().compareTo(ticketprice.getHalfprice()) != 0) {
			result.append(" 半票价由").append(price.getHalfprice()).append("调整为：")
					.append(ticketprice.getHalfprice());
			pricehaschang = true;
		}
		if (price.getMoreprice().compareTo(ticketprice.getMoreprice()) != 0) {
			result.append(" 票价差由").append(price.getMoreprice()).append("调整为：")
					.append(ticketprice.getMoreprice());
			pricehaschang = true;
		}
		if (price.getIssellable() && !ticketprice.getIssellable()) {
			result.append(" 停靠站点由可售调整为不可售");
			pricehaschang = true;
		}
		if (!price.getIssellable() && ticketprice.getIssellable()) {
			result.append(" 停靠站点由不可售调整为可售");
			pricehaschang = true;
		}
		if (pricehaschang) {
			Operationlog operationLog = new Operationlog();
			operationLog.setIp(ip);
			operationLog.setContent(result.toString());
			operationLog.setModule("综合调度->修改站点票价");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("调整票价");
			operationLog.setSessionid("无session");
			operationLog.setUserid(updateby);
			schPlanDao.merge(operationLog);
		}
	}

	/**
	 * @param resultInfo：修改营运类别返回信息
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean updateScheduleplan(Date startdate, Date enddate,
			Schedulestatus ss, String scheduleids, String ip,String workways,
			String remark,String worktype,boolean isworkline,String childnum, StringBuffer resultInfo)
			throws ServiceException, NvException {
		String param1061 = parameterService.findParamValue(ParamterConst.Param_1061, CurrentUtil.getGlobal().getUserinfo().getOrgid());
		String param1012 = parameterService.findParamValue(ParamterConst.Param_1012, CurrentUtil.getGlobal().getUserinfo().getOrgid());
		String result = "批量修改:";
		result = result + "开始日期:" + DateUtils.formatDate(startdate) + ",结束日期："
				+ DateUtils.formatDate(enddate) + ",班次号:";
		if(startdate.getTime()>enddate.getTime()){
			enddate=startdate;
		}
		int days = DateUtils.getIntervalDays(startdate, enddate);
		Date departdate = startdate;
		Schedulestatus oldss = (Schedulestatus) schPlanDao.get(
				Schedulestatus.class, ss.getId());
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		String[] scheduleidarray = scheduleids.split(",");
		for (String scheduleid : scheduleidarray) {
			long curscheduleid = new Long(scheduleid);
			Schedule schedule = (Schedule) schPlanDao.get(Schedule.class,
					curscheduleid);
			result = result + schedule.getCode() + ",";
			// 循环天数
			for (int i = 0; i <= days; i++) {
				departdate = DateUtils.add(startdate, i);
				Schedulestatus curss = schPlanDao.qrySchedulestatus(departdate,
						curscheduleid, oldss.getDepartstationid());
				if (curss == null) {
					continue;
				}
				//判断携童数是否超出 孙越  2016年9月23日 11:56:32-----------------------------------
				if(Integer.parseInt(childnum==null||"".equals(childnum)?"0":childnum) > 0){
					//1012班次最多免票带儿童数，0固定个数，1班次座位数的百分比，默认为1。提示:设置此参数后需设置参数1061才生效
					//1061班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。提示：设置此参数前需先设置参数1012
					long maxChildNums = 0;
					long carrychildnum = curss.getScheduleplan().getCarrychildnum();
					
					//比例剩余
					if("1".equals(param1012)){
						float CarrychildRate = Float.valueOf(param1061) / 100;
						maxChildNums=(int) (CarrychildRate * (curss.getScheduleplan().getSeatnum() - curss.getScheduleplan().getFixedreserveseatnum()));
					}else{//剩余固定数
						maxChildNums=new Integer(param1061);
					}
					
					if(maxChildNums < Integer.parseInt(childnum) || (maxChildNums - carrychildnum) < 0){
						play.Logger.info("该班次剩余免票儿童数不够，已售免票儿童数" + curss.getScheduleplan().getCarrychildnum());
						return false;
					}
				}
				//-----------------------------------
				result = result + "的,发车日期:" + departdate + ","
						+ curss.getTicketentrance() + "检票口->"
						+ ss.getTicketentrance() + "," + curss.getBuspark()
						+ "乘车库->" + ss.getBuspark() + ",发车时间："
						+ curss.getDeparttime() + "->" + ss.getDeparttime()
						+ ",";
				if (curss.getScheduleid() == ss.getScheduleid()) {
					curss.setDeparttime(ss.getDeparttime());
				}
				//Scheduleplan sp=curss.getScheduleplan();
				//改为重新查询班次计划表并进行加锁操作
				filters.clear();
				filters.add(new PropertyFilter("EQD_t!departdate", curss.getDepartdate()));
				filters.add(new PropertyFilter("EQL_t!id", curss.getScheduleplan().getId()));
				Scheduleplan sp = (Scheduleplan) schPlanDao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, filters);
				//
				if (!sp.getWorkways().equals(workways)){
					String temp="";
					//直达、普通、城乡公交、的士
					temp=dictionaryService.getColumnValue("schedule", "workways", sp.getWorkways());
					result=result+"营运方式:"+temp+"->";
					temp=dictionaryService.getColumnValue("schedule", "workways", workways);
					result=result+temp;
					sp.setWorkways(workways);
				}
				if (!sp.getWorktype().equals(worktype)){
					//校验是否允许修改班次营运类型：若该班次存在预售票，则不允许修改
					if(unableUpdateWorktype(sp)){
						resultInfo.append(schedule.getCode()).append(" ")
							.append(util.DateUtils.formatDate(sp.getDepartdate())).append("，");//修改营运类别返回信息
						continue;
					}
					
					//由跨区配载改为单营
					if("3".equals(sp.getWorktype()) && "0".equals(worktype) && 
							hasSelledTicket(sp.getId() ,sp.getDepartdate(),schedule.getSynccode(),sp.getStartstationid(),sp.getEndstationid())){
						TransactionUtil.setRollbackOnly();
						throw new ServiceException("0473");
					}
					
					//由单营改为跨区配载
					if("0".equals(sp.getWorktype()) && "3".equals(worktype)){
						modifyNetSchedulePlanStatus(sp.getId(), sp.getSynccode());
					}
					
					String temp="";
					//直达、普通、城乡公交、的士
					temp=dictionaryService.getColumnValue("schedule", "worktype", sp.getWorktype());
					result=result+"营运类别:"+temp+"->";
					temp=dictionaryService.getColumnValue("schedule", "worktype", worktype);
					result=result+temp;
					sp.setWorktype(worktype);
				}
				if (remark!=null){
					String temp=sp.getRemarks();
					if(temp==null){
						temp="";
					}
					result=result+"班次备注:"+temp+"->"+remark;
					sp.setRemarks(remark);

				}	
				if(sp.getIslinework()!=isworkline){
					result=result+"是否流水班属性:"+sp.getIslinework()+"->"+isworkline;
					sp.setIslinework(isworkline);
				}
				//对于流水班进行修改时间操作时.既保存发车时间 也保存末班时间
				if(sp.getIslinework()){
					sp.setEndtime(ss.getDeparttime());
				}
				if(childnum!=null){
					if(Integer.parseInt(childnum)>0){
						sp.setCarrychildnum(Short.parseShort(childnum));
					}
				}
				sp.setUpdateby(ss.getUpdateby());
				sp.setUpdatetime(new Date());
				schPlanDao.getEntityManager().merge(sp);
				curss.setBuspark(ss.getBuspark());
				curss.setTicketentrance(ss.getTicketentrance());
				curss.setUpdateby(ss.getUpdateby());
				curss.setUpdatetime(new Date());
				schPlanDao.getEntityManager().merge(curss);
			}
		}
		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		if(result.length()>=3000){
			result = result.substring(0,3000);
			}
		operationLog.setContent(result);
		operationLog.setModule("综合调度->修改班次营运计划信息");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("修改班次营运计划信息");
		operationLog.setSessionid("无session");
		operationLog.setUserid(ss.getUpdateby());
		operationLogService.savelog(operationLog);
		
		if(resultInfo.toString().length() > 0){
			resultInfo.append("该班次已有售票记录，营运类别不可修改！");
			play.Logger.info(resultInfo.toString());//记录修改营运类别时未修改成功的班次信息
		}
		return true;

	}
	
	/**
	 * 校验该班次是否允许修改营运类型：若存在售票记录，则不允许修改
	 * @param scheduleplan
	 * @return
	 */
	private boolean unableUpdateWorktype(Scheduleplan scheduleplan){
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.add(new PropertyFilter("EQD_t!departdate", scheduleplan.getDepartdate()));
		filters.add(new PropertyFilter("EQL_t!scheduleplanid", scheduleplan.getId()));
		filters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
		List<Ticketsell> list = schPlanDao.find(Ticketsell.class, filters);
		return (list != null && list.size() > 0) ? true : false;
	}

	private boolean hasSelledTicket(Long scheduleplanid, Date departdate, String synccode,
			long startstationid, long endstationid) throws ServiceException{
		if(schPlanDao.hasSelledTicket(scheduleplanid)){
			return true;
		}
		
		Station startStation = (Station) schPlanDao.get(Station.class, startstationid);
		Station endStation = (Station) schPlanDao.get(Station.class, endstationid);
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
		requestMap.put("schedulesynccode", synccode);
		requestMap.put("departstationcode", startStation.getCode());
		requestMap.put("reachstationcode", endStation.getCode());
		Organization centreOrg = new OrganizationServiceImpl().getDirectlyParentOrg(CurrentUtil.getGlobal().getOrganization());
		try {
			MethodResult methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_SECTION_TICKET, requestMap);
			if(methodResult.getResult()==MethodResult.SUCCESS) {
				//根据发车站、到达站查售票表。交叉的座位不可售
				List<Object> selledseats = (List<Object>) methodResult.getObject();
				if(selledseats==null||selledseats.size() == 0){
					return false;
				}
			}
		} catch (Exception e) {
			play.Logger.error("远处调用数据中心失败");
			throw new ServiceException("0474");
		}
		
		return true;
	}
	
	private void modifyNetSchedulePlanStatus(long scheduleplanid,String scheduleplansynccode) throws ServiceException, NvException{
		List<UpdateSeatReserve> seatReserve = schPlanDao.querySeatReserve4Update(scheduleplanid);
		List<UpdateTicketSell> ticketSell = schPlanDao.queryTicketSell4Update(scheduleplanid);
		List<UpdateScheduleSeats> scheduleSeats = schPlanDao.queryScheduleSeat4Update(scheduleplanid);
		
		Organization localorg = CurrentUtil.getGlobal().getOrganization();
		Organization centreOrg = new OrganizationServiceImpl().getDirectlyParentOrg(localorg);

		Global global = CurrentUtil.getGlobal();
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("scheduleplansynccode", scheduleplansynccode);
		requestMap.put("seats", JsonUtil.toFullString(seatReserve));
		requestMap.put("tickets", JsonUtil.toFullString(ticketSell));
		requestMap.put("scheduleseats", JsonUtil.toFullString(scheduleSeats));
		requestMap.put("orgsynccode", localorg.getSynccode());
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		MethodResult methodResult = null;
		try {
			methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.MODIFY_NETSCHDULE_STATUS, requestMap);
		} catch (Exception e) {
			play.Logger.error("远处调用数据中心失败");
			throw new ServiceException("0474");
		}
		if(methodResult.getResult()!=MethodResult.SUCCESS){
			throw new NvException(methodResult.getResultMsg());
		}
	}
	
	@Override
	public List<Map<String, Object>> qrySameRouteSch(Date departdate,
			long routeid, long departstationid,long scheduleplanid) {
		return ListUtil.listToMap(new Object[] { "id", "departtime", "code",
				"checked" }, schPlanDao.qrySameRouteSch(departdate, routeid,
				departstationid,scheduleplanid), new Object[] { Long.class, String.class,
				String.class, boolean.class });
	}

	// 添加停靠点票价
	@SuppressWarnings("unchecked")
	@Override
	public boolean addStationprice(long scheduleplanid, String departstationids, long reachstationid,
			BigDecimal fullprice, BigDecimal halfprice, BigDecimal studentprice, BigDecimal moreprice,
			BigDecimal topprice, int distance, Global global, BigDecimal discountprice, BigDecimal roundprice,
			BigDecimal connectprice) throws ServiceException {
		 long createby=global.getUserinfo().getId();
		Scheduleplan sp = (Scheduleplan) schPlanDao.get(Scheduleplan.class,
				scheduleplanid);
		Schedule sc = (Schedule) schPlanDao.get(Schedule.class,
				sp.getScheduleid());		
		List<Ticketprice> tps = sp.getTicketpricelist();
		Ticketprice oldtp = tps.get(0);
		List<Ticketpriceitem> tpis = tps.get(0).getTicketpriceitemlist();
		for (Ticketprice curtp : tps) {
			if (curtp.getReachstationid() == sp.getEndstationid()) {
				oldtp = curtp;
				tpis = curtp.getTicketpriceitemlist();
			}
		}
		String departstationsid[] = departstationids.split(",");
		//取出第一条记录的班次状态用来存储
		Schedulestatus schedulestatus = schPlanDao.qrySchedulestatus(sp.getDepartdate(), sp.getScheduleid(), Long.parseLong(departstationsid[0]));
		for (String departstationid : departstationsid) {
			long curdepartstationid = new Long(departstationid);
			//把新增加的线路停靠点添加点班次状态表中
			if(departstationid!=departstationsid[0])
			{
				schedulestatus = schPlanDao.qrySchedulestatus(sp.getDepartdate(), sp.getScheduleid(), Long.parseLong(departstationid));
				schPlanDao.merge(schedulestatus);
			}
			boolean isexist = false;
			for (Ticketprice curtp : tps) {
				if (curtp.getDepartstationid() == curdepartstationid
						&& curtp.getReachstationid() == reachstationid) {
					isexist = true;
				}
			}
			if (!isexist) {
				
				List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
				filters.add(new PropertyFilter("EQL_t!route.id",sc.getRoute().getId()));
				filters.add(new PropertyFilter("EQL_t!stationid",reachstationid));
				List<Routestop> rs = schPlanDao.find(Routestop.class, filters);
				if(rs==null || rs.size()==0){
					Routestop routestop=new Routestop();
					routestop.setBalancedistance(distance);
					routestop.setCreateby(createby);
					routestop.setCreatetime(new Date());
					routestop.setDistance(distance);
					routestop.setIsactive(false);
					routestop.setRoute(sc.getRoute());			
					routestop.setStationid(reachstationid);
					routestop.setUpdateby(createby);
					routestop.setUpdatetime(new Date());
					routestop=routeService.addRoutestop(routestop, global);
					schPlanDao.getEntityManager().flush();
					routeService.deleteRoutestop(routestop,createby);
				}
				filters.clear();
				filters.add(new PropertyFilter("EQL_t!schedule.id",sc.getId()));
				filters.add(new PropertyFilter("EQL_t!stationid",reachstationid));
				List<Schedulestop> sst = schPlanDao.find(Schedulestop.class, filters);
				if(sst==null || sst.size()==0){
					Schedulestop ss=new Schedulestop();
					ss.setId(0);
					ss.setCreateby(createby);
					ss.setCreatetime(new Date());
					ss.setIsactive(false);
					ss.setSchedule(sc);
					ss.setIsdepart(false);
					ss.setIssellable(true);
					ss.setStationid(reachstationid);
					ss.setUpdateby(createby);
					ss.setUpdatetime(new Date());
					ss=scheduleService.saveScheduleStop(ss);
					schPlanDao.getEntityManager().flush();
					scheduleService.delScheduleStop(ss.getId(),createby);
				}
				Ticketprice tp = new Ticketprice();
				tp.setAutocancelreserveseatnum(oldtp
						.getAutocancelreserveseatnum());
				tp.setBalancedistance(distance);
				tp.setCreateby(createby);
				tp.setCreatetime(new Date());
				tp.setDepartdate(oldtp.getDepartdate());
				tp.setDepartstationid(curdepartstationid);
				tp.setDistance(distance);
				tp.setFueladditionfee(oldtp.getFueladditionfee());
				tp.setFixedreserveseatnum(oldtp.getFixedreserveseatnum());
				tp.setFullprice(fullprice);
				tp.setHalfprice(halfprice);
				tp.setIssellable(true);
				tp.setLowerlimitprice(oldtp.getLowerlimitprice());
				tp.setMoreprice(moreprice);
				tp.setOrgid(oldtp.getOrgid());
				tp.setReachstationid(reachstationid);
				tp.setRuntime(oldtp.getRuntime());
				tp.setScheduleid(oldtp.getScheduleid());
				tp.setScheduleplan(oldtp.getScheduleplan());
				tp.setSeatnos(oldtp.getSeatnos());
				tp.setSoldeatnum(oldtp.getSoldeatnum());
				tp.setSeatnum(oldtp.getSeatnum());
				tp.setSeattype(oldtp.getSeattype());
				tp.setStationservicefee(oldtp.getStationservicefee());
				tp.setStudentprice(studentprice);
				tp.setToplimitprice(topprice);
				tp.setUnautocancelreserveseatnum(oldtp
						.getUnautocancelreserveseatnum());
				tp.setUpdateby(createby);
				tp.setUpdatetime(new Date());
				tp.setDiscountprice(discountprice);
				tp.setRoundprice(roundprice);
				tp.setConnectprice(connectprice);
				List<Ticketpriceitem> newtips = new ArrayList<Ticketpriceitem>();
				BigDecimal fullticketpriceitem = new BigDecimal(0);
				BigDecimal halfticketpriceitem = new BigDecimal(0);
				BigDecimal studticketpriceitem = new BigDecimal(0);
				BigDecimal topticketpriceitem = new BigDecimal(0);
				BigDecimal discountpriceitem = new BigDecimal(0);
				BigDecimal roundpriceitem = new BigDecimal(0);
				BigDecimal connectpriceitem = new BigDecimal(0);
				for (Ticketpriceitem otpi : tpis) {
					if (!otpi.isIsautoadjust()) {
						if ("Q".equals(otpi.getCode())) {
							fullticketpriceitem = fullticketpriceitem.add(otpi
									.getPrice());
						} else if ("B".equals(otpi.getClass())) {
							halfticketpriceitem = halfticketpriceitem.add(otpi
									.getPrice());
						} else if ("X".equals(otpi.getClass())) {
							studticketpriceitem = studticketpriceitem.add(otpi
									.getPrice());
						} else if ("S".equals(otpi.getClass())) {
							topticketpriceitem = topticketpriceitem.add(otpi
									.getPrice());
						} else if ("Y".equals(otpi.getClass())) {
							discountpriceitem = topticketpriceitem.add(otpi
									.getPrice());
						} else if ("W".equals(otpi.getClass())) {
							roundpriceitem = topticketpriceitem.add(otpi
									.getPrice());
						} else if ("L".equals(otpi.getClass())) {
							connectpriceitem = topticketpriceitem.add(otpi
									.getPrice());
						}
					}
					Ticketpriceitem tpi = new Ticketpriceitem();
					tpi.setCode(otpi.getCode());
					tpi.setCreateby(createby);
					tpi.setCreatetime(new Date());
					tpi.setDepartdate(otpi.getDepartdate());
					tpi.setIsautoadjust(otpi.isIsautoadjust());
					tpi.setName(otpi.getName());
					tpi.setPrice(otpi.getPrice());
					tpi.setScheduleid(otpi.getScheduleid());
					tpi.setTicketprice(tp);
					tpi.setTicketpriceformulaitemid(otpi
							.getTicketpriceformulaitemid());
					tpi.setTickettype(otpi.getTickettype());
					tpi.setUpdateby(createby);
					tpi.setUpdatetime(new Date());
					newtips.add(tpi);
				}
				for (Ticketpriceitem ntpi : newtips) {
					if (ntpi.isIsautoadjust()) {
						if ("Q".equals(ntpi.getCode())) {
							ntpi.setPrice(fullprice.subtract(fullticketpriceitem));
						} else if ("B".equals(ntpi.getClass())) {
							ntpi.setPrice(halfprice.subtract(halfticketpriceitem));
						} else if ("X".equals(ntpi.getClass())) {
							ntpi.setPrice(studentprice.subtract(studticketpriceitem));
						} else if ("S".equals(ntpi.getClass())) {
							ntpi.setPrice(topprice.subtract(topticketpriceitem));
						} else if ("Y".equals(ntpi.getClass())) {
							ntpi.setPrice(topprice.subtract(discountpriceitem));
						} else if ("W".equals(ntpi.getClass())) {
							ntpi.setPrice(topprice.subtract(roundpriceitem));
						} else if ("L".equals(ntpi.getClass())) {
							ntpi.setPrice(topprice.subtract(connectpriceitem));
						}
					}
				}

				tp.setTicketpriceitemlist(newtips);
				tps.add(tp);
				schPlanDao.merge(sp);
			}
		}

		return true;
	}

	// 查询站点票价
	@Override
	public List<Map<String, Object>> qryStationprice(long departstationid,
			long reachstationid) throws ServiceException {
		return ListUtil.listToMap(new Object[] { "fullprice", "halfprice",
				"studentprice", "toplimitprice", "moreprice","distance","discountprice","roundprice","connectprice" },
				schPlanDao.qryStationprice(departstationid, reachstationid),
				new Object[] { BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						long.class, BigDecimal.class, BigDecimal.class, BigDecimal.class});
	}

	@Override
	public List<Map<String, Object>> qryDepartTime(long scheduleplanid,
			long departstationid,Date departdate) throws ServiceException {
		return ListUtil.listToMap(new Object[] { "id", 
				"departtime", "code", "stationname","scheduleid","departstationid"},
				schPlanDao.qryDepartTime(scheduleplanid, departstationid,departdate),
				new Object[] { BigDecimal.class,
					String.class, String.class, String.class,long.class,long.class});
	}

	@Override
	public boolean saveDepartTimes(Date fromdate,Date enddate,long departstationid,
			List<Schedulestatus> sslist,Global global )
			throws ServiceException {
		Date now=new Date();
		long updateby=global.getUserinfo().getId();
		String ip=global.getIpAddress();
		String result="";
		String sessionid=global.getSessionID();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		List<Schedulestatus> slist=schPlanDao.qrySchedulestatus(sslist.get(0).getScheduleid(),
				departstationid,fromdate, enddate);
		for(Schedulestatus _ss:slist){			
			for(Schedulestatus ss:sslist){		
				if(_ss.getDepartstationid()==ss.getDepartstationid()){
					//Schedulestatus _ss=(Schedulestatus) schPlanDao.get(Schedulestatus.class, ss.getId());
					String olddepartime=_ss.getDeparttime();
					String deparstation=ss.getStationname();
					_ss.setDeparttime(ss.getDeparttime());
					_ss.setUpdateby(updateby);
					_ss.setUpdatetime(now);
					schPlanDao.merge(_ss);
					String departdate=sf.format(_ss.getDepartdate());
					result="发车日期:"+departdate+",班次号:"+ss.getCode();
					result=result+",发车站:"+deparstation+",发车时间:"+olddepartime+"改为:"+ss.getDeparttime();
					Operationlog operationLog = new Operationlog();
					operationLog.setIp(ip);
					operationLog.setContent(result);
					operationLog.setModule("综合调度->修改");
					operationLog.setOperatetime(now);
					operationLog.setOperation("修改配客点发车时间");
					operationLog.setSessionid(sessionid);
					operationLog.setUserid(updateby);
					operationLogService.savelog(operationLog);
					break;
				}
			}
		}
		return true;
	}
	
	@Override
	public List<Map<String, Object>> qryChildNum(long scheduleplanid) {
		return ListUtil.listToMap(new Object[] { "carrychildnum" }, schPlanDao.qryChildNum(scheduleplanid),
				new Object[] { String.class });
	}
}
