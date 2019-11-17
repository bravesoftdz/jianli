package cn.nova.bus.dispatch.service.impl;


import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.service.SecuritycheckService;
import cn.nova.bus.check.service.impl.SecuritycheckServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.ScheduleReportDao;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.ScheduleReportService;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class ScheduleReportServiceImpl implements ScheduleReportService {

	
	private IDAO<Object> dao = new EntityManagerDaoSurport<Object>();
	
	private ScheduleReportDao scheduleReportDao = new ScheduleReportDao();
	
	private SecuritycheckService securitycheckService = new SecuritycheckServiceImpl();
	
	private ParameterService parameterService = new ParameterServiceImpl();

	private List<Vehicle> vehiclelist;
	private MethodResult methodResult;
	private List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist;
	private List<Schedulestatus> schedulestatuslist;
	

	

	@Override   //参数flag 为0时未报到班次 为1时已报到班次
	public List<Map<String, Object>> query(String flag,long departstationId,Date departDate,String vehicleno) {
		List<Object> reportList = scheduleReportDao.Query(flag, departstationId, departDate, vehicleno);	
		if (flag.equals("0")){
			return ListUtil.listToMap(new Object[]{"ddzName","routename","sfzname","code","zdzname","cxname","departtime","vehicleno","dwname","seatnum"
					,"yzs","jpk","buspark","jsy1","jsy2","jsy3","jsy4","cwy1","cwy2","scheduleid","planscheduleid","czorgid","bdorgid","vehicleid","departdate"},
					reportList,new Object[]{String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class
					,String.class,short.class,long.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class
					,long.class,long.class,long.class,long.class,long.class,Date.class});
		}else{
			return ListUtil.listToMap(new Object[]{"ddzName","routename","sfzname","code","zdzname","cxname","departtime","vehicleno","bdvehicleno","reporttime","dwname","seatnum"
					,"yzs","jpk","buspark","jsy1","bdjsy1","jsy2","bdjsy2","jsy3","bdjsy3","jsy4","bdjsy4","cwy1","bdcwy1","cwy2","bdcwy2"},
					reportList,new Object[]{String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class
					,String.class,short.class,long.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class,String.class
					,String.class,String.class,String.class,String.class,String.class});
		}
		
	
	}
	
	

	//参数cardNo 为IC卡号 通过此卡号关联相应车辆报到
	@Override
	public String  reportbycard(long orgId,Vehiclereport vehiclereport,long departstationId,String cardNo,Date checkDate,long curUserId){
		//1、把IC卡卡号转换为相应车牌号及对应车辆Id		
		vehiclelist = scheduleReportDao.getVehicleIdbyCardNo(cardNo);
		if ((vehiclelist != null) && (vehiclelist.size()<1)){
			return "您输入的IC卡号不正确,请重新输入!";
		}
		//判断是否为始发站
		methodResult = securitycheckService.getVehicleCheckResult(vehiclelist.get(0).getId(),checkDate,orgId);
		//2、判断根据车辆ID判断车辆是否在安检计划中存在 并且是否合格
		if (methodResult.getResult()==0){
			return methodResult.getResultMsg();
		}else if (methodResult.getResult()==-1){
			return methodResult.getResultMsg();
		}
		//3、更新班次运行计划表和状态表及写报到记录				
		schedulevehiclepeopleplanlist = scheduleReportDao.getchedulevehiclepeopleplanlist(departstationId, vehiclelist.get(0).getId(), checkDate);
		schedulestatuslist = scheduleReportDao.getSchedulestatuslist(departstationId, vehiclelist.get(0).getId(), checkDate);
		if (schedulestatuslist.get(0).getIsreported()){
			return "车辆"+vehiclelist.get(0).getVehicleno()+" 已经报到,不需要再报到!";
		}	
		//4、更新班次状态表为报到后售票状态和插入车辆报到记录	
		updateScheduleStatus(schedulestatuslist.get(0),orgId);		
		insertVehicleReport(vehiclereport,schedulevehiclepeopleplanlist.get(0),schedulestatuslist.get(0),"0",curUserId);   //新增报到记录表
		
		//5、返回报到成功
		return "车辆"+vehiclelist.get(0).getVehicleno()+" 报到成功!";		
		
	}
	
	
	//通过班次运行计划Id更新班次状态表	
	@SuppressWarnings("deprecation")
	public boolean updateScheduleStatus(Schedulestatus schedulestatus,long orgId){
		//schedulestatus = schedulestatusService.getById(scheduleplanid);
		if (schedulestatus == null){
			return false;
		}
		schedulestatus.setIsreported(true);
		//1为报到后自动为可检票
		if ( parameterService.findParamValue(ParamterConst.Param_2009,orgId).equals(ParamterConst.COMMON_FLAG.FALG_YES)){
			schedulestatus.setIsbegincheck(true);
		}
		if (dao.save(schedulestatus)) {//更新班次状态表为报到后售票状态
			return true;
		}else{
			return false;
		}
	}
	
	//新增报到记录表
	@SuppressWarnings("deprecation")
	public boolean insertVehicleReport(Vehiclereport vehiclereport,Schedulevehiclepeopleplan schedulevehiclepeopleplan,Schedulestatus schedulestatus,String reportway,long curUserId){
				
		vehiclereport.setScheduleplanid(schedulevehiclepeopleplan.getScheduleplan().getId());  
		vehiclereport.setScheduleid(schedulestatus.getScheduleid());
		vehiclereport.setOrgid(schedulevehiclepeopleplan.getScheduleplan().getOrgid());
		vehiclereport.setReportorgid(schedulestatus.getOrgid());
		vehiclereport.setDepartdate(schedulestatus.getDepartdate());		
		vehiclereport.setReportway(reportway);	//0为自动报到记录  1手动报到
		vehiclereport.setOrderno(schedulevehiclepeopleplan.getOrderno());
		vehiclereport.setReporttime(new Timestamp(System.currentTimeMillis()));
		vehiclereport.setVehicleid(schedulevehiclepeopleplan.getPlanvehicle().getId());
//		以下为报到车辆时把相应司乘人员也报到的代码		
//		vehiclereport.setDriver1id(schedulevehiclepeopleplan.getPlandriver1().getId());
//		vehiclereport.setDriver2id(schedulevehiclepeopleplan.getPlandriver2().getId());
//		vehiclereport.setDriver3id(schedulevehiclepeopleplan.getPlandriver3().getId());
//		vehiclereport.setDriver4id(schedulevehiclepeopleplan.getPlandriver4().getId());
//		vehiclereport.setSteward1id(schedulevehiclepeopleplan.getPlansteward1().getId());
//		vehiclereport.setSteward2id(schedulevehiclepeopleplan.getPlansteward2().getId());
		vehiclereport.setIsactive(false);  //0为正常报到记录  1取消报到
		vehiclereport.setCreatetime(new Timestamp(System.currentTimeMillis()));		
		vehiclereport.setCreateby(curUserId);		
		if (dao.save(vehiclereport)) {//保存新增车辆报到记录
			return true;
		}else{
			return false;
		}
	}

}
