package cn.nova.openapi.converter;

/**
 * 字典转换，将openapi与本地的数据中的字典字段，进行转换。
 * @author Mark
 *
 */
public class DictConverter extends DataConverter {
	public static String convertSeatType(String type){
		return convertSeatType(Integer.valueOf(type));
	}
	
	public static String convertSeatType(int type){
		switch (type) {
		case 0:
			return "普通座";
		case 1:
			return "卧铺";
		case 2:
			return "商务座";
		default:
			return "普通座";
		}
	}
	
	public static String parseSeatType(String typename){
		if("typename".equals("普通座")){
			return "0";
		}else if("typename".equals("卧铺")){
			return "1";
		}else if("typename".equals("商务座")){
			return "2";
		}else{
			return "3";
		}
	}
	
	public static String convertTicketType(String type){
		return convertTicketType(Integer.valueOf(type));
	}
	
	public static String convertTicketType(int type){
		switch (type) {
		case 1:
			return "Q";
		case 2:
			return "B";
		case 3:
			return "X";
		case 4:
			return "Z";
		default:
			return "Q";
		}		
	}
	
	public static int parseTicketType(String typename){
		if("typename".equals("Q")){
			return 1;
		}else if("typename".equals("B")){
			return 2;
		}else if("typename".equals("X")){
			return 3;
		}else if("typename".equals("Z")){
			return 4;
		}else{
			return 1;
		}
	}
}
