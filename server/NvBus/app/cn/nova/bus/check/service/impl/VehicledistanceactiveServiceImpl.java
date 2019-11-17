/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.check.service.impl<br/>
 * <b>文件名：</b>VehicledistanceactiveServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-5  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.check.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.dao.VehicledistanceactiveDao;
import cn.nova.bus.check.model.Vehicledistanceactive;
import cn.nova.bus.check.service.VehicledistanceactiveService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：车辆行驶里程管理</b><br/>
 * <b>类名称：</b>VehicledistanceactiveServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-5-3  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicledistanceactiveServiceImpl implements VehicledistanceactiveService{

	
	private VehicledistanceactiveDao vdao = new VehicledistanceactiveDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	/**
	 * 查询最后一次激活记录以及发车里程，显示在车辆行驶里程管理主页面
	 */
	@Override
	public List<Map<String, Object>>  queryLastActive(Date startdate,Date enddate,
			long vehicleid,long userid,long orgid) {
		return ListUtil.listToMap(new Object[]  { 
				"vehicleno","vehicleid","maintainvaliddate","distancelimit","createtime",
				"createname","departdistance","lastactivetime"}, 
				vdao.queryLastActive(startdate,enddate,vehicleid,userid,orgid),
				new Object[] { 
				String.class,long.class,Date.class,BigDecimal.class,Timestamp.class,
				String.class, BigDecimal.class,Timestamp.class });
	}
	
	//查找车辆行驶里程二维有效期，用于安检和报到，
	@Override
	public String qryVheicledistiance(
			long vehicleid,long orgid,boolean iscomparedate) throws ServiceException {
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[]  { 
				"vehicleno","vehicleid","maintainvaliddate","distancelimit","createtime",
				"createname","departdistance","lastactivetime"}, 
				vdao.queryLastActive(null,null,vehicleid,0,orgid),
				new Object[] { 
				String.class,long.class,Timestamp.class,long.class,Timestamp.class,
				String.class,long.class,Timestamp.class });
		//限制里程
		int limitdistance;
		//发班里程
		int departdistance;
		//二维有效期
		Date maintainvaliddate;
		String temp = "";
		//证件有效期到期提示天数
//		int showdate = Integer.parseInt(parameterService.findParamValue("2024", orgid));
		Vehicle reportvehicle = (Vehicle) vdao.get(Vehicle.class,	vehicleid);
		if ( reportvehicle.getContractenddate() !=null
				&&DateUtils.compare(reportvehicle.getContractenddate(),new Date()) < 0 ){
			throw new ServiceException("0499");	//第三者责任险已过期 不允许报班！					
		}
		/*if ( reportvehicle.getContractenddate() !=null
				&&DateUtils.compare(reportvehicle.getContractenddate(),new Date()) >= 0 
				&&DateUtils.compare( DateUtils.add(reportvehicle.getContractenddate(),-showdate) ,new Date())<0){
			temp =" "+DateUtils.getIntervalDays(new Date(),DateUtils.add(reportvehicle.getContractenddate(),2))+"天第三方责任险过期!";
		}*/
		if (result!=null && result.size()>1){
			Map<String, Object> map = result.get(0);
			if(!iscomparedate){
				limitdistance = Integer.parseInt(map.get("distancelimit").toString());
				departdistance = Integer.parseInt(map.get("departdistance").toString());
				if(limitdistance <= departdistance){
					//该车辆的发班里程已大于限制里程,请激活该车辆的里程限制!
					throw new ServiceException("0435");
				}
				//车辆二期维护里程剩下多少公里,弹出提示
				int messagedistance = Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_6004,orgid));
				//当剩余发班里程大于设置的提醒数，提示还剩多少 达到限制
	            if ((limitdistance-departdistance) <= messagedistance){
	            	//该车辆还有```
	            	temp = "该车辆还有 "+(limitdistance-departdistance)+" 公里到达限制.";
	            }
			}else{
				if(map.get("maintainvaliddate")!=null){
					maintainvaliddate = (Date) map.get("maintainvaliddate") ;
					Date nowdate= new Date();
					int messagedate;
					if(DateUtils.compare(maintainvaliddate, nowdate) <0){
						//该车辆已经过了二维有效期!
						throw new ServiceException("0437");
					}	
					
					//报班程序中暂时不提示，会阻断报班操作
					//提示天数
		            messagedate =Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_6005,orgid));
		            //天数差
		            long intervalDays = DateUtils.getIntervalDays(
		            		DateUtils.mergerDateAndTime(maintainvaliddate, "00:00:00"),
		            		DateUtils.mergerDateAndTime(nowdate, "00:00:00"));
					if(intervalDays < messagedate){
						//该车辆还有```(intervalDays==0?intervalDays+1:intervalDays)
						temp = "该车辆还有 "+(intervalDays+1)+" 天 过二维有效期！";
					}    
				}
			}

			/*if ( reportvehicle.getContractenddate() !=null
					&&DateUtils.compare(reportvehicle.getContractenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(reportvehicle.getContractenddate(),-showdate) ,new Date())<0){
				throw new ServiceException(" "+temp,"0436",true);
			}*/
		}		
		return temp;		
	}	

	@Override
	public List<Map<String, Object>> queryHistoryActive(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[]  { 
				"vehicleno","distancelimit","createtime","lastactivetime",
				"createname","departdistance"}, 
				vdao.queryHistoryActive(propertyFilterList),
				new Object[] { 
				String.class, BigDecimal.class,Timestamp.class,Timestamp.class,
				String.class, BigDecimal.class});
	}
	/**
	 * 激活车辆里程限制,同时激活车辆二期维护有效期，将天数加上参数设置的默认天数。
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Vehicledistanceactive saveVehicledistanceactive(Vehicledistanceactive v) {		 
		Vehicle ve = (Vehicle) vdao.get(Vehicle.class, v.getVehicleid());
		Userinfo user = (Userinfo) vdao.get(Userinfo.class, v.getCreateby());
		//是否开启车辆二期维护有效期
		String isopen = parameterService.findParamValue(ParamterConst.Param_6006, user.getOrgid());
		//如果是，激活时，才需要修改车辆的二维有效期。
		if(isopen.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
			//激活车辆二期维护有效期默认添加的月数
			int months = Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_6007, user.getOrgid()));
			//每次激活，车辆的二维有效期 的月分都在当天的基础上默认值。
			ve.setMaintainvaliddate(DateUtils.add(new Date() ,2, months));//2:参数类型为月，月份加上参数值
			//修改车辆信息，更改车辆二维有效期的值
			vdao.merge(ve);		
		}
		Vehicledistanceactive newvehicleactive = (Vehicledistanceactive) vdao.merge(v);		
		return newvehicleactive ;
		
	}

}
