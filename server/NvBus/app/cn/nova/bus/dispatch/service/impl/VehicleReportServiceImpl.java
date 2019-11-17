package cn.nova.bus.dispatch.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import util.DateUtils;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.VehicleReportService;
import cn.nova.bus.report.dao.VehicleReportStatusDao;
import cn.nova.utils.orm.jpa.IDAO;

@SuppressWarnings("deprecation")
public class VehicleReportServiceImpl implements VehicleReportService {
	
	
	private IDAO<Vehiclereport> dao = new EntityManagerDaoSurport<Vehiclereport>();

	@Override
	public boolean save(Vehiclereport vehiclereport) {
		if (vehiclereport.getId() == 0) {
			return dao.save(vehiclereport);
		} else {
			return dao.update(vehiclereport);
		}
	}

	@Override
	public boolean delete(Vehiclereport vehiclereport) {
		return dao.delete(vehiclereport);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Vehiclereport.class, id);
	}

	@Override
	public List<Vehiclereport> query() {
		return dao.query(Vehiclereport.class, null);
	}

	@Override
	public Vehiclereport getById(Long id) {
		return dao.get(Vehiclereport.class, id);
	}

	@Override
	public List<Map<String, String>> getDriverReportInfo(String dateToDay,String timeToDay,
			String vehicleno) {
		
		VehicleReportStatusDao vehicleReportStatusDao = new VehicleReportStatusDao();
		Date date = DateUtils.strToDate(dateToDay);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time = null;
		try {
			if(StringUtils.isNotEmpty(timeToDay)){
				time = format.parse(timeToDay);
			}else{
				time = null;
			}
		} catch (ParseException e) {
		}
		List<Object> list = vehicleReportStatusDao.getDriverReportInfo(date,time,vehicleno);
		List<Map<String,String>> returnList = new ArrayList<Map<String,String>>();
		if(list.size()>0){
			for (Object object : list) {
				Map<String,String> map = new HashMap<String, String>();
				Object[] obj = (Object[])object;
				map.put("boolDriverReportValidity", "1");
				map.put("shceduleCode", obj[0].toString());
				map.put("repordid", obj[1].toString());
				map.put("strDriverNumbers", obj[2].toString());
				returnList.add(map);
			}
		}else{
			Map<String,String> map = new HashMap<String, String>();
			map.put("boolDriverReportValidity", "0");
			returnList.add(map);
		}
		return returnList;
	}
	@Override
	public Map<String, String> getPassengerOfNumber(String dateToDay,
			 String repordid) {
		Map<String,String> map = new HashMap<String, String>();
		Date date = DateUtils.strToDate(dateToDay);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		VehicleReportStatusDao vehicleReportStatusDao = new VehicleReportStatusDao();
		List<Object> list = vehicleReportStatusDao.getPassengerOfNumber(date,repordid);
		if(list.size()>0){
			Object[] obj = (Object[]) list.get(0);
			map.put("ticketRecordNumber", obj[0].toString());
			map.put("childrenTicketRecordNumber", obj[1].toString());
		}else{
		}
		return map;
	}
	

}
