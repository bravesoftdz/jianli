/**
 * 
 */
package cn.nova.bus.dispatch.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebService;

import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.DispatchServiceDao;
import cn.nova.bus.dispatch.exception.WSException;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.DispatchService;
import cn.nova.bus.dispatch.service.ICAutoReportService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * 半自动报班，客户端刷卡后列出班次，驾驶员选择班次后报到
 * @author ice
 *
 */
@WebService
public class ICAutoReportServiceImpl implements ICAutoReportService {
	
	
	private DispatchService dispatchService = new DispatchServiceImpl();
	
	private IDAO dao = new EntityManagerDaoSurport();	
	private DispatchServiceDao dispatchServiceDao = new DispatchServiceDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private OperationLogService operationlogservice = new OperationLogServiceImpl();
	
//	@WebMethod(exclude=true)
//	private String checkreporttime(long vehicleid,Scheduleplan scheduleplan,long departstationid){
//		//TODO 查询上次报到的非流水班发车时间     或者        流水班上次报到时间
//		int intervals = Integer.parseInt(parameterService.findParamByStation("2020", departstationid));
//		if(intervals>0){
//			Schedulestatus schedulestatus = dispatchServiceDao
//					.getSchedulestatus(departstationid, scheduleplan.getScheduleid(), scheduleplan.getDepartdate());
//			//取当天本车牌已报到班次的最大发车时间（ 正常班取发车时间，流水班取报到时间） 
//			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
//			propertyFilters.add(new PropertyFilter("EQD_sp!departdate", scheduleplan.getDepartdate()));
//			propertyFilters.add(new PropertyFilter("EQD_vr!departdate", scheduleplan.getDepartdate()));
//			propertyFilters.add(new PropertyFilter("EQD_ss!departdate", scheduleplan.getDepartdate()));
//			propertyFilters.add(new PropertyFilter("EQL_vr!vehicleid", vehicleid));
//			propertyFilters.add(new PropertyFilter("EQL_ss!departstationid", departstationid));
//			StringBuilder sb = new StringBuilder();
//			sb.append("select max(case when sp.islinework=1 ")
//			.append("         then to_char(vr.reporttime,'hh24:mi') else ss.departtime end)")
//			.append("    From vehiclereport vr,scheduleplan sp,schedulestatus ss")
//			.append("	where sp.id=vr.scheduleplanid")
//			.append("	and ss.scheduleplanid=sp.id")
//			.append("	and vr.isactive=1")
//			.append(PropertyFilter.toJpql(propertyFilters,true));
//			Query query = dao.getEntityManager().createNativeQuery(sb.toString());
//			JPAPropertyFilterUtil.setParameter(query, propertyFilters);
//			String lastdeparttimeschedule = (String) query.getSingleResult();
//			if(lastdeparttimeschedule!=null){
//				Date thisscheduledeparttime = null;
//				if(scheduleplan.getIslinework()){
//					thisscheduledeparttime = new Date();
//				}else{
//					thisscheduledeparttime = DateUtils.mergerDateAndTime(scheduleplan.getDepartdate(), schedulestatus.getDeparttime());
//				}
//				if(DateUtils.add(DateUtils.mergerDateAndTime(scheduleplan.getDepartdate(), lastdeparttimeschedule), 
//								Calendar.MINUTE, intervals)
//				  .after(thisscheduledeparttime)){
//					return "您本日已经报到其它班次，且发车时间距离本班次发车时间不足"+intervals+"分钟";
//				}
//			}
//		}
//		return null;
//	}


	/* (non-Javadoc)
	 * @see cn.nova.bus.dispatch.service.ICAutoReportService#autoReport(long, long, long)
	 */
	@Override
	@WebMethod
	public boolean autoReport(String cardno, long scheduleplanid,
			long departstationid) throws WSException {
		Date now = new Date();
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, scheduleplanid);
		if(scheduleplan==null){
			throw new WSException("找不到该班次计划");
		}
		Organization reportorg = organizationService.getOrgByStationId(departstationid);
		if(reportorg==null){
			throw new WSException("报到站ID有误");
		}
		//判断晚点
		try {
			long laterminute = dispatchService.laterMinutes(departstationid,scheduleplan.getScheduleid(),scheduleplan.getDepartdate());
			if(laterminute>0){
				throw new WSException("该班次已经晚点");
			}
		} catch (ServiceException e2) {
			throw new WSException(e2.getExceptionMessage());
		}
		
		MethodResult result = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!cardno", cardno));
		propertyFilters.add(new PropertyFilter("EQS_t!type", "0"));//报到卡
		propertyFilters.add(new PropertyFilter("EQS_t!status", "0"));//状态：0正常,1已退,2挂失,3作废,4过期 取数据字典
		Cardissue cardissue = (Cardissue) dao.uniqueResult(Cardissue.class,propertyFilters);
		if(cardissue==null){
			List<Cardissue> cardissues = dao.find(Cardissue.class,propertyFilters);
			if(cardissues!=null&&cardissues.size()>0){
				if (cardissues.get(0).getStatus().equals("1")) {
					throw new WSException("报到卡"+cardno+"已退");
				} else if (cardissues.get(0).getStatus().equals("2")) {
					throw new WSException("报到卡"+cardno+"已挂失");
				} else if (cardissues.get(0).getStatus().equals("3")) {
					throw new WSException("报到卡"+cardno+"已注销");
				} else if (cardissues.get(0).getStatus().equals("4")) {
					throw new WSException("报到卡"+cardno+"已过期");
				} else if (cardissues.get(0).getStatus().equals("5")) {
					throw new WSException("报到卡"+cardno+"已补卡");
				} else{
					throw new WSException("报到卡"+cardno+"状态未知异常");
				}
			}else{
				throw new WSException("没有该报到卡！");
			}
		}
		
		Vehicle vehicle = getDispatchServiceDao().getVehicle(cardno);
		if (vehicle == null) {
			// 该IC卡没有对应的车辆信息！
			throw new WSException((new ServiceException("0233")).getExceptionMessage());
		}
		if (!vehicle.isIsactive()) {
			// 该车辆已经注销不能报到！
			throw new WSException((new ServiceException("0235")).getExceptionMessage());
		}
		
		// 返回的-1未检 1合格 0不合格 2是无安检计划
		try {
			result = dispatchService.checkVehicle(vehicle.getId(), scheduleplan.getDepartdate(),reportorg.getId());
		} catch (ServiceException e1) {
			throw new WSException(e1.getExceptionMessage());
		}
		// 是否需要安检合格才报到，0：不需要，1：需要
		String mustcheck = getParameterService().findParamValue(ParamterConst.Param_2013,reportorg.getId());
		boolean ismustcheck = mustcheck.equals(ParamterConst.COMMON_FLAG.FALG_YES);
		if (ismustcheck) {
			if (result.getResult() == -1) {
				// 该车辆还未安检，不允许报到！
				throw new WSException((new ServiceException("0292")).getExceptionMessage());
			} else if (result.getResult() == 0) {
				// 该车辆安检不合格，不允许报到！
				throw new WSException((new ServiceException("0293")).getExceptionMessage());
			} else if (result.getResult() == 2) {
				// 该车辆没有安检计划，不允许报到！
				throw new WSException((new ServiceException("0294")).getExceptionMessage());
			}
		}

		//查询上次报到的非流水班发车时间     或者        流水班上次报到时间
		String checkreporttimeresult = dispatchService.checkreporttime(vehicle.getId(),scheduleplan,departstationid);
		if(checkreporttimeresult!=null){
			//您本日已经报到其它班次，且发车时间距离本班次发车时间不足?分钟
			throw new WSException(checkreporttimeresult);
		}
		
		Vehiclereport vehiclereport = new Vehiclereport();
		vehiclereport.setCreateby(0);
		vehiclereport.setCreatetime(now);
		vehiclereport.setDepartdate(scheduleplan.getDepartdate());
		vehiclereport.setDriver1(null);
		vehiclereport.setDriver2(null);
		vehiclereport.setDriver3(null);
		vehiclereport.setDriver4(null);
		vehiclereport.setIsactive(true);
		vehiclereport.setIsdeparted(false);
		vehiclereport.setIsTempVehicle(false);
//		vehiclereport.setOrdersno(orderno);
		vehiclereport.setOrgid(scheduleplan.getOrgid());
		vehiclereport.setReason(null);
		vehiclereport.setReportorgid(reportorg.getId());
		vehiclereport.setReporttime(now);
		vehiclereport.setReportway("0");
		vehiclereport.setScheduleid(scheduleplan.getScheduleid());
		vehiclereport.setScheduleplanid(scheduleplanid);
		vehiclereport.setSteward1(null);
		vehiclereport.setSteward2(null);
		vehiclereport.setUnitid(vehicle.getUnitid());
		vehiclereport.setUpdateby(0);
		vehiclereport.setUpdatetime(now);
		vehiclereport.setVehiclebrandid(vehicle.getVehiclebrandmodelid());
		vehiclereport.setVehicleid(vehicle.getId());

		try {
			Global global=new Global();
			Userinfo userinfo = (Userinfo) dao.get(Userinfo.class, 0L);
			global.setUserinfo(userinfo);
			global.setOrganization(reportorg);
			result = dispatchService.vehicleReport(vehiclereport, null,
					departstationid, vehicle.getVehicleno(),global);
			if(result.getResult()==MethodResult.SUCCESS){
				try {
					Operationlog operationlog = new Operationlog();
					operationlog.setUserid(0L);
					Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleplan.getScheduleid());
					Unit unit = (Unit) dao.get(Unit.class, vehicle.getUnitid());
					operationlog.setContent("报到车站: "+ reportorg.getName() 
											+",报到班次："+schedule.getCode() 
											+",报到车辆:" + vehicle.getVehicleno() 
											+",车属单位:" + unit.getName() 
											+",报到情况:正常");
					operationlog.setModule("自助报到机");
					operationlog.setOperation("报到");
					operationlog.setIp("127.0.0.1");
					operationlog.setSessionid("webserviceclient");
					operationlog.setOperatetime(new Date());
					operationlogservice.savelog(operationlog);
				} catch (Exception e) {
					play.Logger.error(e.getMessage(), e);
				}
			}else{
				throw new WSException(result.getResultMsg());
			}
		} catch (ServiceException e) {
			throw new WSException(e.getExceptionMessage());
		}
		return true;
	}

	@WebMethod(exclude = true)
	public DispatchService getDispatchService() {
		return dispatchService;
	}

	@WebMethod(exclude = true)
	public void setDispatchService(DispatchService dispatchService) {
		this.dispatchService = dispatchService;
	}

	@WebMethod(exclude = true)
	public DispatchServiceDao getDispatchServiceDao() {
		return dispatchServiceDao;
	}

	@WebMethod(exclude = true)
	public void setDispatchServiceDao(DispatchServiceDao dispatchServiceDao) {
		this.dispatchServiceDao = dispatchServiceDao;
	}

	@WebMethod(exclude = true)
	public IDAO getDao() {
		return dao;
	}

	@WebMethod(exclude = true)
	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	@WebMethod(exclude = true)
	public ParameterService getParameterService() {
		return parameterService;
	}

	@WebMethod(exclude = true)
	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	@WebMethod(exclude = true)
	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	@WebMethod(exclude = true)
	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}

	@WebMethod(exclude = true)
	public OperationLogService getOperationlogservice() {
		return operationlogservice;
	}

	@WebMethod(exclude = true)
	public void setOperationlogservice(OperationLogService operationlogservice) {
		this.operationlogservice = operationlogservice;
	}

}
