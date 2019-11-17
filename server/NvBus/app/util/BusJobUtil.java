package util;

import java.util.HashMap;
import java.util.Map;

import org.joda.time.DateTime;
import org.joda.time.LocalTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import cn.nova.bus.job.model.Jobconfig;

public class BusJobUtil {
	public final static Map<String, Jobconfig> 	JOB_CONFIGS = new HashMap<String, Jobconfig>();
	public static Jobconfig getJobConfig(String jobname){
		return JOB_CONFIGS.get(jobname);
	}

	public static boolean isTimeBetween4now(String beginTime,String endTime){
		DateTimeFormatter formatter = DateTimeFormat.forPattern("HH:mm");
		LocalTime bt = formatter.parseDateTime(beginTime).toLocalTime();
		LocalTime et = formatter.parseDateTime(endTime).toLocalTime();
		LocalTime it = new LocalTime();
		return bt.isBefore(et) ? it.isBefore(et) && it.isAfter(bt) : !it.isBefore(bt) && it.isAfter(et); 
	}
}
