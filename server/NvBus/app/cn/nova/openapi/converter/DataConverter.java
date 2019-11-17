package cn.nova.openapi.converter;

import java.math.BigDecimal;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.openapi.model.response.BusSchedule;
import cn.nova.openapi.model.response.DepartStation;
import cn.nova.openapi.model.response.BaseResponseModel;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 数据转换抽象类，用于远程数据对象与本地数据对象的适配
 * @author Mark
 *
 */
public abstract class DataConverter {
	
	/**
	 * 根据传入的类数组，用默认值初始化一个对象数组，用于转换，并传给客户端。
	 * @param types
	 * @return
	 */
	public static Object[] initialize(Class[] types){
		Object[] result = new Object[types.length];
		for (int i = 0; i < types.length; i++) {
			if(types[i] == Boolean.class){
				result[i] = 0;
			}else if(types[i] == Short.class){
				result[i] = (short)0;
			}else if(types[i] == Integer.class){
				result[i] = 0;
			}else if(types[i] == Long.class){
				result[i] = 0L;
			}else if(types[i] == Date.class){
				result[i] = new Date();
			}else if(types[i] == String.class){
				result[i] = "";
			}else if(types[i] == BigDecimal.class){
				result[i] = new BigDecimal(0);
			}else {
				result[i] = null;
			}
		}
		return result;
	}
}
