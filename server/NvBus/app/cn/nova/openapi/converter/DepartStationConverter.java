package cn.nova.openapi.converter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.openapi.model.response.BusSchedule;
import cn.nova.openapi.model.response.DepartStation;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 发车站的转换
 * @author Mark
 *
 */
public class DepartStationConverter extends DataConverter{
	
	/**
	 * 为了在客户端显示，区别与本地的站点，所以openapi过来的站点都加上字段，用于区别
	 */
	public final static String ADDED_NAME="[联网]";
	
	public final static Object[] FIELDS = new Object[]{
		"id", "code", "name", "helpcode", "jianpin", "isdepart", "grade", "orgtype","isnet" };
	
	public final static Class[] TYPES = new Class[]{ 
		Long.class, String.class, String.class,String.class, String.class, String.class, String.class,String.class,Integer.class };
	
	public final static Object[] inited = initialize(TYPES);

	/**
	 * 构造器，将从openapi得到的数据，填充到已经初始化好的数组中。
	 * @param stations
	 * @return
	 */
	public List<Object> builder(List<DepartStation> stations){
		ArrayList<Object> list = new ArrayList<Object>();
		for (int i = 0; i < stations.size(); i++) {
			Object[] row = inited.clone();
			row[0] = stations.get(i).id;
			row[2] = stations.get(i).findname + ADDED_NAME;
			row[4] = stations.get(i).find_quanpin;
			row[8] = 2;
			list.add(row);
		}
		return list;
	}
	
	public List<Map<String, Object>> converter(List<DepartStation> stations) {
		return ListUtil.listToMap(FIELDS, builder(stations), TYPES); 
	}

}
