package util;

import java.io.IOException;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Query;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import play.Logger;
import play.Play;
import play.db.jpa.JPA;
import play.libs.IO;
import play.mvc.Http;
import play.vfs.VirtualFile;

import com.alibaba.fastjson.JSON;


public class CommonUtil {
	public enum TableIndex { 
		menuinfo,            //菜单信息表
		roleinfo,            //角色信息表
		rolePermissions,     //角色权限表
		userinfo,            //用户信息表
		userroleinfo,        //用户角色表
		ticketType,          //票证类型表
		departInfo,          //部门信息表
		departUserInfo,      //用户部门关系表
		systemParames        //系统参数表
	}
	public enum RequestType {
	    JSON, 
	    HTML, 
	    XML; 
	}
	public enum DateFormatType{
		DATETIME("yyyy-MM-dd HH:mm:ss"),
		DATE("yyyy-MM-dd");
		
		public String format;
		private DateFormatType(String format){
			this.format = format;
		}
	}
	
	public static String dateToString(Date date, String format){
		DateFormat df = new SimpleDateFormat(format);
		return df.format(date);
	}

	public static String dateToFullString(Date date){
		return dateToString(date, DateFormatType.DATETIME.format);
	}
	
	public static String dateToSimpleString(Date date){
		return dateToString(date, DateFormatType.DATE.format);
	}
	
	public static Date stringToDate(String strDate) throws Exception{
		 DateFormat df = new SimpleDateFormat(JSON.DEFFAULT_DATE_FORMAT); 
		 Date date = new Date();
		try {
			date = df.parse(strDate);
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
			throw new Exception("时间错误", e);
		}
	     return date; 
	}
	/**
	 * 获得某表的ID
	 * 根据LocalID取得ID，独立事务，每调用一次自动加1
	 * @param localID 地区编号
	 * @TableIndex 表的索引号
	 * @return 返回一个ID
	 */
	public static long GetPKID(TableIndex tableIndex,String localID) 
	{
		long PKID=0,id=0;
		long bit=10000000000L;
		//try
		{
			//先增加再取值
			//JPA.em().createNativeQuery("Update PKidentity Set PKID=PKID+1 where TableIndex=1").executeUpdate();
			if (JPA.em().getTransaction().isActive()==false)
				JPA.em().getTransaction().begin();
			Query query = JPA.em().createNativeQuery("Update idbuild Set currentid=currentid+1 where tablename=?1");
//			System.out.println(query);
//			System.out.println(tableIndex.name());
			query.setParameter(1, tableIndex.name()); 
			int result = query.executeUpdate(); //影响的记录数 
//			System.out.println(result);
			if (result>0)
			{
				//int i=1/0;
				Query querySelect = JPA.em().createNativeQuery("Select currentid from idbuild Where tablename=?1");
				querySelect.setParameter(1, tableIndex.name());
				BigInteger rs=(BigInteger) querySelect.getSingleResult();
				id=rs.longValue();
				PKID=(100+tableIndex.ordinal());
				PKID=PKID*bit+id;
				JPA.em().getTransaction().commit();
				JPA.em().getTransaction().begin();
				//JPA.em().joinTransaction()
				return PKID;
			}
			else
			{
				JPA.em().getTransaction().rollback();
				JPA.em().getTransaction().begin();
				throw new play.exceptions.UnexpectedException("获得ID号失败，没有更新任何一条记录");
			}
		}//catch (Exception e) {
			//throw new play.exceptions.UnexpectedException("获得ID号出现错误");
		//}
		
	}	
	/**
	 * 获得请求类型
	 * 根据Request对象获得请求类型
	 * @param Http.Request 请求对象
	 * @return 返回类型
	 */
	public static RequestType GetRequestType(Http.Request r) 
	{
//		功能测试时，没有accept 所以此处用作测试时打开
		if(r.headers.get("accept") == null){
			return RequestType.JSON;
		}
		
		String accept= r.headers.get("accept").toString();
		String s[]=accept.split(",");
		if (s[0].equalsIgnoreCase("[text/html"))
			return RequestType.HTML;
		else if (s[0].equalsIgnoreCase("[application/json"))
			return RequestType.JSON;
		else if (s[0].equalsIgnoreCase("[text/xml"))
			return RequestType.XML;
		else
			return RequestType.HTML;
	}
	
	
	/**
	 * 判断是否为空字符
	 * @param val
	 * @return
	 */
	public static boolean isNotEmptyString(String val){
		if(val!=null&&!"".equals(val.trim())){  
			return true;
		}
		return false;
	}
	
	public static boolean isEmptyString(String val){
		if(val==null || "".equals(val.trim())){
			return true;
		}
		return false;
	}
	/**
	 * 判断集合是否是空的
	 * @param collections
	 * @return
	 */
	public static boolean isNotEmptyCollection(Collection<?> collections){
		if(collections!=null&& collections.size()>0){  
			return true;
		}
		return false;
	}
	
	public static String nullToString(String val){
		if(val==null || "".equals(val.trim())){
			return "";
		}
		return val;
	}
	/**
	 * 获得UUID
	 * @return
	 */
	public static String getUUID(){
		UUID uuid = UUID.randomUUID();
		return uuid.toString();
	}
	
	public static String[] getAllPropertiesOnObject(Class<?> c) throws Exception{
		try {
			if (c != null) {//if (object!=null )  ----begin
				   // 获取实体类的所有属性，返回Field数组
				   Field[] fields = c.getFields();
				   String[] proarr = new String[fields.length];
				   for (int i = 0; i < fields.length; i++) {
					   proarr[i] = fields[i].getName().toString();
				}
				 return proarr;
			}
			return null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			throw new Exception(e.getMessage());
		}
	}
	
	public static Date parseStringToDate(String strDate, String formateStr){
		SimpleDateFormat sdf=new SimpleDateFormat(formateStr);
		Date date=null;
		try {
			date=new Date(sdf.parse(strDate).getTime());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return date;
	}
	
	public static Date parseStringToDate(String strDate){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Date date=null;
		try {
			date=new Date(sdf.parse(strDate).getTime());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return date;
	}
	
	public static Timestamp parseStringToTimestamp(String strTimestamp){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Timestamp ts=null;
		try {
			ts=new Timestamp(sdf.parse(strTimestamp).getTime());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return ts;
	}
	
	public static Time parseStringToTime(String strTime, String formateStr){
		SimpleDateFormat sdf=new SimpleDateFormat(formateStr);
		Time time=null;
		try {
			time=new Time(sdf.parse(strTime).getTime());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return time;
	}
	
	
	public static Time parseStringToTime(String strTime){
		SimpleDateFormat sdf=new SimpleDateFormat("hh:mm:ss");
		Time time=null;
		try {
			time=new Time(sdf.parse(strTime).getTime());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return time;
	}
	
	public static String appendParam(String returns, String paramId, String paramValue) {
		if (returns != "") {
			if (paramValue != "") {

				returns += "&" + paramId + "=" + paramValue;
			}

		} else {

			if (paramValue != "") {
				returns = paramId + "=" + paramValue;
			}
		}

		return returns;
	}
	/**
	 * 安装时间生成ID
	 * @return
	 */
	public static String createID() {
		Calendar calendar=Calendar.getInstance();
		int year=calendar.get(Calendar.YEAR);
		int month=calendar.get(Calendar.MONTH)+1;
		int date=calendar.get(Calendar.DATE);
		int hour=calendar.get(Calendar.HOUR_OF_DAY);
		int minute=calendar.get(Calendar.MINUTE);
		int second=calendar.get(Calendar.SECOND);
		StringBuilder id=new StringBuilder();
		id.append((year+"").substring(2));
		if (month<10) {
			id.append("0"+month);
		}else {
			id.append(month);
		}
		if (date<10) {
			id.append("0"+date);
		}else {
			id.append(date);
		}
		if (hour<10) {
			id.append("0"+hour);
		}else {
			id.append(hour);
		}
		if (minute<10) {
			id.append("0"+minute);
		}else {
			id.append(minute);
		}
		if (second<10) {
			id.append("0"+second);
		}else {
			id.append(second);
		}
		return id.toString();
	}
	public static String getNetTicketno(){
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddhhmmssSSS");
		return format.format(date);
	}
	
	/**
     * Looks for extra db configs in config
     * @return list of all extra db config names found
     * @author ldl
     */
    public static Set<String> detectedExtraDBConfigs() {
    	Properties props = null;
    	VirtualFile appRoot = VirtualFile.open(Play.applicationPath);
    	VirtualFile conf = appRoot.child("conf/application.conf");
    	try {
    		props = IO.readUtf8Properties(conf.inputstream());
        } catch (RuntimeException e) {
            if (e.getCause() instanceof IOException) {
                Logger.fatal("Cannot read application.conf");
                System.exit(-1);
            }
        }
    	
        Set<String> names = new LinkedHashSet<String>(0); //preserve order
        Pattern pattern = Pattern.compile("^db\\_([^\\.]+)(?:$|\\..*)");
        for( String propName : props.stringPropertyNames()) {
            Matcher m = pattern.matcher(propName);
            if (m.find()) {
                String configName = m.group(1);
                if (!names.contains(configName)) {
                    names.add(configName);
                    System.out.println("dbconfg:"+configName);
                }
            }
        }
        return names;
    }
    public static String stringFormat(String msg,String... args){
    	for (int i = 0; i < args.length; i++) {
			msg = msg.replaceFirst("%\\d", args[i]);
		}
		return msg;
    }
    public static boolean isSelfDomain(String netname,String netaddress,String domain){
    	if(netaddress==null || netname==null || "".equals(netaddress) || "".equals(netname) ||
					netaddress.equals(domain) || netname.equals(domain)){
    		return true;
    	}else {
			return false;
		}
    	/*if(netaddress==null || netname==null || "".equals(netaddress) || "".equals(netname) || netname.equals(domain)){
    		return true;
    	}else {
			return false;
		}*/
    }
    
	/**
	 * @param source int数组字符串
	 * @return 转化完成的字符串
	 * @throws Exception 数组字符串结构错误
	 */
	public static String convertIntArrayStringForSql(String source) throws Exception{
		Pattern pt = Pattern.compile("^\\d+(_\\d+)*$");
		Matcher matcher = pt.matcher(source);
		if(!matcher.find()){
		//	throw new BPException("validation.match");
		}
		return source.replace('_', ',');
	}
	
	public static String formatDate2String(java.util.Date source){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(source);
	}
	
	public static String formatSimpleDate2String(java.util.Date source){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(source);
	}
	
	public static <T> List<T> json2Array(String jsonstr, Class<T[]> clazz) {
		ObjectMapper mapper = new ObjectMapper();
		String pattern = Play.configuration.getProperty("date.format");
		DateFormat df = new SimpleDateFormat(pattern);
		mapper.setDateFormat(df);
		T[] resultArr = null;
		try {
			resultArr = (T[]) mapper.readValue(jsonstr, clazz);
			return Arrays.asList(resultArr);
		} catch (JsonParseException e) {
			play.Logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			play.Logger.error(e.getMessage(), e);
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return new ArrayList<T>();
	}
	
	public static List<Map<String, Object>> list2Map(List list, String[] fields) {
		List<Map<String,Object>> outerlist = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		Object[] item = null;
		for(Object obj : list){
			map = new HashMap<String, Object>();
			item = (Object[]) obj;
			for(int i = 0; i < fields.length; i++){
				map.put(fields[i], item[i]);
			}
			outerlist.add(map);
		}
		return outerlist;
	}
	
	/**
	 * 判断表是否存在(oracle)
	 * @param sourcename
	 * @return
	 */
	public static boolean isTableExist(String sourcename) {
		String sql = "select count(1) from user_tables where table_name = upper('"+sourcename+"')";
		Query query = JPA.em().createNativeQuery(sql);
		int count = ((BigDecimal)query.getSingleResult()).intValue();
		if(count > 0){
			return true;
		}
		return false;
	}
	
	public static boolean isColumnExist(String tablename,String columnname){
		String sql = "select count(1) from user_tab_columns where table_name = upper('"+tablename+"') and column_name = upper('"+columnname+"')";
		Query query = JPA.em().createNativeQuery(sql);
		int count = ((BigDecimal)query.getSingleResult()).intValue();
		if(count > 0){
			return true;
		}
		return false;
	}
}
