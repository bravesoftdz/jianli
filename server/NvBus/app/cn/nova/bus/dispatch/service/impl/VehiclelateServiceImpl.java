/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service.impl<br/>
 * <b>文件名：</b>VehiclelateServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-上午11:27:55<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.dispatch.dao.VehiclelateDao;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.dispatch.service.VehiclelateService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.security.Global;

/**
 * <b>类描述：车辆晚点处理服务</b><br/>
 * <b>类名称：</b>VehiclelateServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class VehiclelateServiceImpl implements VehiclelateService {

	
	private VehiclelateDao vehiclelateDao = new VehiclelateDao();
	
	private OperationLogService operationLogService = new OperationLogServiceImpl();
	/*
	 * getVehiclelates方法：返回车辆晚点记录信息<br/> <br/>
	 * 
	 * @param fromdepart
	 * 
	 * @param enddepart
	 * 
	 * @param vehicleids
	 * 
	 * @return List<Vehiclelate>
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.VehiclelateService#getVehiclelates(java.
	 * util.Date, java.util.Date, java.lang.String)
	 * 
	 * @exception
	 */
	@Override
	public List<Vehiclelate> qryVehiclelates(Date fromdepart, Date enddepart,
			String vehicleids) {
		return vehiclelateDao.qryVehiclelate(fromdepart, enddepart, vehicleids);
	}

	/*
	 * getVehiclelatesDeduct方法：<br/> <br/>
	 * 
	 * @param fromdepart
	 * 
	 * @param enddepart
	 * 
	 * @param vehicleids
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.VehiclelateService#getVehiclelatesDeduct
	 * (java.util.Date, java.util.Date, java.lang.String)
	 * 
	 * @exception
	 */
	@Override
	public BigDecimal qryVehiclelatesDeduct(Date fromdepart, Date enddepart,
			String vehicleids) {
		return vehiclelateDao.getVehiclelatesDeduct(vehicleids);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean schVehicleLater(long schedulestatusid,Global global)throws ServiceException{
		Schedulestatus ss = (Schedulestatus) vehiclelateDao.get(
				Schedulestatus.class, schedulestatusid);
		if (ss != null) {
			if(!ss.getStatus().equals("0")){
				//该班次状态不是正常状态，不能做晚点处理	
				throw	new  ServiceException("0382");
			}
			if(ss.getIsreported()){
				//该班次已经报到，不能做晚点处理
				throw	new  ServiceException("0383");
			}
			Schedule s=(Schedule) vehiclelateDao.get(Schedule.class, ss.getScheduleid());
			String result="班次号："+s.getCode()+",发车日期："+ss.getDepartdate()+",发车时间："+ss.getDeparttime();
			ss.setStatus("2");
			ss.setUpdateby(global.getUserinfo().getId());
			ss.setUpdatetime(new Date());
			vehiclelateDao.merge(ss);
			Operationlog operationLog = new Operationlog();
			operationLog.setIp(global.getIpAddress());
			operationLog.setContent(result + "进行班次晚点处理");
			operationLog.setModule("综合调度->IC卡报班");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("晚点处理");
			operationLog.setSessionid("无session");
			operationLog.setUserid(global.getUserinfo().getId());
			operationLogService.savelog(operationLog);	
			return true;
		}
		return false;
	}

}
