package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Vehiclereport;


public interface VehicleReportService {
	
	boolean save(Vehiclereport vehiclereport);
	
	boolean delete(Vehiclereport vehiclereport);

	boolean delete(Long id);

	List<Vehiclereport> query();

	Vehiclereport getById(Long id);

	List<Map<String, String>> getDriverReportInfo(String dateToDay, String timeToDay,
			String strDriverNumbers);

	Map<String, String> getPassengerOfNumber(String dateToDay, String repordid);

}
