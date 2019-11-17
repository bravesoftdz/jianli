package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;





public interface ScheduleReportService {	

	//参数flag 为0时未报到班次 为1时已报到班次
	List<Map<String, Object>>  query(String flag,long departstationId,Date departDate,String vehicleno);

	//参数cardNo 为IC卡号 通过此卡号关联相应车辆报到
	String  reportbycard(long orgId,Vehiclereport vehiclereport,long departstationId,String cardNo,Date checkDate,long curUserId);	
	
	//更新班次状态表
	boolean updateScheduleStatus(Schedulestatus schedulestatus,long orgId);
	//新增报到记录表 reportway为0自动报到 为1手动报到
	boolean insertVehicleReport(Vehiclereport vehiclereport,Schedulevehiclepeopleplan schedulevehiclepeopleplan,Schedulestatus schedulestatus,String reportway,long curUserId);

}
