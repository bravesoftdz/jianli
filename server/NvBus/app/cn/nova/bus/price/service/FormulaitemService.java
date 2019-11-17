package cn.nova.bus.price.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemorggrade;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Formulaitemroadgrade;
import cn.nova.bus.price.model.Formulaitemroute;
import cn.nova.bus.price.model.Formulaitemroutestop;
import cn.nova.bus.price.model.Formulaitemschedule;
import cn.nova.bus.price.model.Formulaitemvehcile;
import cn.nova.bus.price.model.Formulaitemvehcileroadgrad;
import cn.nova.bus.price.model.Ticketpriceformulaitem;

public interface FormulaitemService {
	public List<Map<String, Object>> query(String flag, Ticketpriceformulaitem ticketpriceformulaitem);
	
	public boolean saveformulaitemvehcile(Formulaitemvehcile formulaitemvehcile)throws ServiceException;	
	public boolean delformulaitemvehcile(Formulaitemvehcile formulaitemvehcile)throws ServiceException;
	
	public boolean saveformulaitemroute(Formulaitemroute formulaitemroute)throws ServiceException;
	public boolean saveformulaitemroutes(Formulaitemroute formulaitemroute,String routeidlist)throws ServiceException;	
	public boolean delformulaitemroute(Formulaitemroute formulaitemroute)throws ServiceException;
	
	public boolean saveformulaitemrouteStop(Formulaitemroutestop formulaitemroutestop)throws ServiceException;
	public boolean delformulaitemrouteStop(Formulaitemroutestop formulaitemroutestop)throws ServiceException;		

	public boolean saveformulaitemdistance(Formulaitemdistance formulaitemdistance)throws ServiceException;
	public boolean delformulaitemdistance(Formulaitemdistance formulaitemdistance)throws ServiceException;		

	public boolean saveformulaitemprice(Formulaitemprice formulaitemprice)throws ServiceException;
	public boolean delformulaitemprice(Formulaitemprice formulaitemprice)throws ServiceException;		

	public boolean saveformulaitemStationGrade(Formulaitemorggrade formulaitemorggrade)throws ServiceException;
	public boolean delformulaitemStationGrade(Formulaitemorggrade formulaitemorggrade)throws ServiceException;		

	public boolean saveformulaitemRoadGrade(Formulaitemroadgrade formulaitemroadgrade)throws ServiceException;
	public boolean delformulaitemRoadGrade(Formulaitemroadgrade formulaitemroadgrade)throws ServiceException;		
	
	public boolean saveformulaitemVehRoadGrade(Formulaitemvehcileroadgrad formulaitemvehcileroadgrad)throws ServiceException;
	public boolean delformulaitemVehRoadGrade(Formulaitemvehcileroadgrad formulaitemvehcileroadgrad)throws ServiceException;		

	public boolean saveformulaitemSchedule(Formulaitemschedule formulaitemschedule)throws ServiceException;
	public boolean delformulaitemSchedule(Formulaitemschedule formulaitemschedule)throws ServiceException;		
	
}
