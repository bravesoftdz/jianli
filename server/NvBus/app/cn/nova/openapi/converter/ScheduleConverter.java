package cn.nova.openapi.converter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.openapi.model.response.BusSchedule;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 班次转化
 * @author Mark
 *
 */
public class ScheduleConverter extends DataConverter{
	
	public final static Object[] FIELDS = new Object[]{
		"scheduleplanid","departdate","departtime","departstationid","reachstationid","routeid","isoriginator","issaleafterreport","isreported","scheduleid",
		"seatnum", "id","carrychildnum","districttype","endstationid","endtime","remarks","islinework","isovertime","isproprietary",
		"issellable","issellreturnticket","orgid","isdeparted","scheduletype","spacinginterval","startstationid","starttime","worktype","workways",
		"buspark","isbegincheck","isemptyvehicle","status","ticketentrance","fullprice","halfprice","issellable","unautocancelreserveseatnum","fixedreserveseatnum",
		"autocancelreserveseatnum","runtime","stationservicefee","fueladditionfee","seatnos", "residuecarrychildnum","seattype","soldeatnum","studentprice","distance",
		"balancedistance","toplimitprice","lowerlimitprice","residueseatnum","routename","returntripvaliddays","schedulecode","scheduleremarks","schedulesynccode","departstationname",
		"departstationcode","reachstationname","reachstationcode","reachstationsecondname","isroundtrip","startstationname","endstationname","planvehicletype","planvehiclegrade","planvehicletypecustomname",
		"planvheicletypeid","planvehicleno","planvehicleid","planunitname", "planunitid","planbrandmodel","planbrandmodelid" ,"moreprice","ticketentrancename","discountpriceticket","discountprice","sdpid","endstation","startstationprice","vcleseattype"};
	
	public final static Class[] TYPES = new Class[]{
		Long.class, Date.class, String.class, Long.class, Long.class, Long.class, Boolean.class, Boolean.class, Boolean.class,
		Long.class, Integer.class, Long.class, Short.class, String.class, Long.class, String.class, String.class, Boolean.class, Boolean.class,
		Boolean.class, Boolean.class, Boolean.class, Long.class, Boolean.class, String.class, Short.class, Long.class, String.class, String.class,
		String.class, String.class, Boolean.class, Boolean.class, String.class, String.class, BigDecimal.class, BigDecimal.class, Boolean.class, Short.class,
		Short.class, Short.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, String.class, Short.class, String.class, Short.class, BigDecimal.class,
		Integer.class, Integer.class, BigDecimal.class, BigDecimal.class, Integer.class, String.class, Short.class, String.class, String.class, String.class,
		String.class, String.class, String.class, String.class, String.class, Boolean.class, String.class, String.class, String.class, String.class,
		String.class, Long.class, String.class, Long.class, String.class, Long.class, String.class, Long.class, BigDecimal.class, String.class,Short.class,BigDecimal.class,Long.class,String.class,BigDecimal.class,String.class
	};
			
	public final static Object[] inited = initialize(TYPES);

	/**
	 * 构造器，将从openapi得到的数据，填充到已经初始化好的数组中。
	 * @param schedules
	 * @return
	 */
	public List<Map<String, Object>> converter(List<BusSchedule> schedules,Date departdate) {
		ArrayList<Object> list = new ArrayList<Object>();
		for (int i = 0; i < schedules.size(); i++) {
			Object[] row = inited.clone();
			row[1] = departdate;
			row[9] =  schedules.get(i).id;
			row[11] =  schedules.get(i).id;
			row[60] =  schedules.get(i).departorgcode;
			row[56] =  schedules.get(i).schedulecode;
			row[59] =  schedules.get(i).departorgname;
			row[2]  =  schedules.get(i).departtime;
			row[15] =  schedules.get(i).endtime;			
			row[46] =  schedules.get(i).seattype;						
			row[53] =  schedules.get(i).residualnumber;
			row[18] =  schedules.get(i).isaddschedule;
			row[17] =  schedules.get(i).islineschedule;
			row[35] =  schedules.get(i).fullprice;
//			row[60] =  schedules.get(i).discountprice;
			row[48] =  schedules.get(i).studentprice;
			row[36] =  schedules.get(i).halfprice;
			row[37] =  schedules.get(i).iscansell;
			row[62] =  schedules.get(i).reachstationcode;
			row[61] =  schedules.get(i).reachstationname;
			row[66] =  schedules.get(i).endstationname;
			row[41] =  schedules.get(i).runtime;
			row[49] =  schedules.get(i).rundistance;
			row[69] =  schedules.get(i).vehicletype;
			row[20] =  schedules.get(i).iscansell;
			row[34] =  schedules.get(i).ticketentrance;
			row[30] =  schedules.get(i).waitingroom;
			list.add(row);
		}
		return ListUtil.listToMap(FIELDS, list, TYPES); 
	}

}
