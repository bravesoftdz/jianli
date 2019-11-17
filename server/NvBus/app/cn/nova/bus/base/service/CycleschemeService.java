package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Schedulecycle;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface CycleschemeService {
	//查询循环信息 
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilterList);
	public Cycleschemes save(Cycleschemes cyclescheme) throws ServiceException;
	public boolean delCyclescheme(Cycleschemes cyclescheme) throws ServiceException;
	public List<Map<String,Object>> qrySchedulecycle(Cycleschemes cyclescheme);	
	public List<Map<String,Object>> qrySchedulecycles(Cycleschemes cyclescheme);	
	public boolean saveSchedulecycle(Schedulecycle schedulecycle) throws ServiceException;
	public boolean delSchedulecycle(Schedulecycle schedulecycle) throws ServiceException;	
	//循环班次
	public List<Map<String,Object>> qryCycleschemesschedule(Cycleschemes cyclescheme);		
	public boolean saveCycleschemesschedule(Cycleschemesschedule cycleschemesschedule,Long types) throws ServiceException;
	public boolean delCycleschemesschedule(Cycleschemesschedule cycleschemesschedule) throws ServiceException;		
	public boolean nextCycleschemesschedule(Cycleschemesschedule cycleschemesschedule) throws ServiceException;		
	public boolean priorCycleschemesschedule(Cycleschemesschedule cycleschemesschedule) throws ServiceException;		

	//循环车辆
	public List<Map<String,Object>> qryCycleschemesvehicle(Cycleschemes cyclescheme);		
	public boolean saveCycleschemesvehicle(Cycleschemesvehicle cycleschemesvehicle) throws ServiceException;
	public boolean delCycleschemesvehicle(Cycleschemesvehicle cycleschemesvehicle) throws ServiceException;		
	public boolean nextCycleschemesvehicle(Cycleschemesvehicle cycleschemesvehicle) throws ServiceException;		
	public boolean priorCycleschemesvehicle(Cycleschemesvehicle cycleschemesvehicle) throws ServiceException;		

	//循环驾驶员
	public List<Map<String,Object>> qryCycleschemesdrive(Cycleschemes cyclescheme);		
	public boolean saveCycleschemesdrive(Cycleschemesdriver cycleschemesdrive) throws ServiceException;
	public boolean delCycleschemesdrive(Cycleschemesdriver cycleschemesdrive) throws ServiceException;		
	public boolean nextCycleschemesdrive(Cycleschemesdriver cycleschemesdrive) throws ServiceException;		
	public boolean priorCycleschemesdrive(Cycleschemesdriver cycleschemesdrive) throws ServiceException;		
	
	//循环乘务员
	public List<Map<String,Object>> qryCycleschemessteward(Cycleschemes cyclescheme);		
	public boolean saveCycleschemessteward(Cycleschemessteward cycleschemessteward) throws ServiceException;
	public boolean delCycleschemessteward(Cycleschemessteward cycleschemessteward) throws ServiceException;		
	public boolean nextCycleschemessteward(Cycleschemessteward cycleschemessteward) throws ServiceException;		
	public boolean priorCycleschemessteward(Cycleschemessteward cycleschemessteward) throws ServiceException;		
}
