package cn.nova.openapi.converter;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.openapi.model.response.ReachStation;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 到达站的转换
 * @author Mark
 *
 */
public class ReachStationConverter extends DataConverter{
	public static long OPEN_API_STATIONID_PRE = 90000000L;
	
	public final static Object[] FIELDS = new Object[]{
		"id", "code", "name", "helpcode", "jianpin", "isdepart", "grade"};
	
	public final static Class[] TYPES = new Class[]{ 
		Long.class, String.class, String.class,String.class, String.class, String.class, String.class};
	
	public final static Object[] inited = initialize(TYPES);

	/**
	 * 构造器，将从openapi得到的数据，填充到已经初始化好的数组中。
	 * @param stations
	 * @return
	 */
	public List<Map<String, Object>> converter(List<ReachStation> stations) {
		ArrayList<Object> list = new ArrayList<Object>();
		for (int i = 0; i < stations.size(); i++) {
			Object[] row = inited.clone();
			//因为openapi的id与我方id格式不正确，所以需要转换。补齐位数。
			row[0] = OPEN_API_STATIONID_PRE + i % OPEN_API_STATIONID_PRE;
			row[2] = stations.get(i).name;
			row[4] = stations.get(i).name_jianpin;
			list.add(row);
		}
		return ListUtil.listToMap(FIELDS, list, TYPES); 
	}

}
