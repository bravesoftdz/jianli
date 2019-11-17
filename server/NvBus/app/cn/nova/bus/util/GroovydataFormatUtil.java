/**
 * 
 */
package cn.nova.bus.util;

import java.math.BigDecimal;

/**
 * @description Groovy数据转换为java数据工具类
 * @author lxh
 * 2014年3月1日
 */
public class GroovydataFormatUtil {
	
	/**
	 * 将对象转换为BigDecimal
	 * @param o
	 * @return
	 */
	public static BigDecimal format(Object o){
		BigDecimal bigDecimal = null;
		if(o instanceof BigDecimal){
			bigDecimal = (BigDecimal) o;
		} else if(o instanceof Integer) {
			int temp = ((Integer) o).intValue();
			bigDecimal = new BigDecimal(temp);
		} else if(o instanceof Double){
			double tmep = ((Double)o).doubleValue();
			bigDecimal = new BigDecimal(tmep);
		}
		bigDecimal = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_EVEN);
		return bigDecimal;
	}
}
