package cn.nova.bus.util;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import play.Play;

import com.alibaba.fastjson.JSON;

import util.JsonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import cn.nova.bus.query.vo.TicketsellQryVo;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.DelphiDS;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.orm.jpa.ReceiveOnly;

public class ReportUtil<T>{

	
	@SuppressWarnings({ "rawtypes"})
	public List saveToFile(List<T> list,Global global,String reportname){
		
		File file = new File(Play.applicationPath,"/tmp/"+reportname+global.getUserinfo().getCode()+"report.json");
		List pagelist=new ArrayList();
		try {
			PrintStream ps = new PrintStream(new FileOutputStream(file));
			//ps.println(list.size());
			pagelist=sumAll(list);
			for(T obj: list){
				String str2=JsonUtil.toFullString(obj);	
				//String str2=JsonUtil.toSimpleString(obj);
				ps.println(str2);
			}
			ps.close();			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		RedisUtil.set(RedisDBApp.temp,reportname+global.getSessionID(), list);
		return pagelist;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<T> sumAll(List<T> list) {
		// Class cla=oclass.getClass();
		List<T> totallist = new ArrayList<T>();
		if (list == null || list.size() == 0) {
			return null;
		}
		//T t = list.get(0);
		T t;
		try {
			t = (T) list.get(0).getClass().newInstance();
			try {
				for (int i = 0; i < list.size(); i++) {
					t = combine(t, list.get(i));
				}
				totallist.add(t);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (InstantiationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IllegalAccessException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}	

		return totallist;
	}

	public T combine(T obj1, T obj2) throws Exception {
	
		Class<? extends Object> clazz1 = obj1.getClass();
		Class<? extends Object> clazz2 = obj2.getClass();
		
		Field[] fields1 = clazz1.getDeclaredFields();
		Field[] fields2 = clazz2.getDeclaredFields();
		
		for (int i = 0; i < fields1.length; i++) {
			//System.out.println(fields1[i].getName());	
			String fieldname=fields1[i].getName();			
			if("serialVersionUID".equals(fieldname)||fields1[i].isAnnotationPresent(UnSum.class)){
				continue;
			}
			if(fieldname.equals("id")){
				Long n1 = (Long)fields1[i].get(obj1);
				if(n1==null){
					n1=(long) 0;
				}
				fields1[i].set(obj1, n1+1);
				continue;
			}			
			if(Integer.class == fields1[i].getType()||fieldname.equals("int")) {
				Integer n1 = (Integer)fields1[i].get(obj1);
				if(n1==null){
					n1=0;
				}
				Integer n2 = (Integer)fields2[i].get(obj2);
				if(n2==null){
					n2=0;
				}
				fields1[i].set(obj1, n1+n2);
			}			
			else if(Double.class == fields1[i].getType()||fieldname.equals("double")) {
				Double n1 = (Double)fields1[i].get(obj1);
				Double n2 = (Double)fields2[i].get(obj2);
				fields1[i].set(obj1, n1+n2);
			}else if(Float.class == fields1[i].getType()||fieldname.equals("float")) {
				Float n1 = (Float)fields1[i].get(obj1);
				Float n2 = (Float)fields2[i].get(obj2);
				fields1[i].set(obj1, n1+n2);
			}else if(BigDecimal.class == fields1[i].getType()) {
				BigDecimal n1 = (BigDecimal)fields1[i].get(obj1);
				if(n1==null){
					n1=new BigDecimal(0);
				}
				BigDecimal n2 = (BigDecimal)fields2[i].get(obj2);
				if(n2==null){
					n2=new BigDecimal(0);
				}
				fields1[i].set(obj1, n1.add(n2));
			}else if(Byte.class == fields1[i].getType()||fieldname.equals("byte")) {
				Byte n1 = (Byte)fields1[i].get(obj1);
				if(n1==null){
					n1=0;
				}
				Byte n2 = (Byte)fields2[i].get(obj2);
				if(n2==null){
					n2=0;
				}
				fields1[i].set(obj1, (byte) (n1+n2));
			}else if(Long.class == fields1[i].getType()||fieldname.equals("long")) {
				Long n1 = (Long)fields1[i].get(obj1);
				if(n1==null){
					n1=(long) 0;
				}
				Long n2 = (Long)fields2[i].get(obj2);
				if(n2==null){
					n2=(long) 0;
				}
				fields1[i].set(obj1, (n1+n2));
			}
		}		
		return obj1;
	}
	
	/** 
	 * 根据属性名获取属性值 
	 * */  
	public static Object getFieldValueByName(String fieldName, Object o) {  
	       try {    
	           String firstLetter = fieldName.substring(0, 1).toUpperCase();    
	           String getter = "get" + firstLetter + fieldName.substring(1);    
	           Method method = o.getClass().getMethod(getter, new Class[] {});    
	           Object value = method.invoke(o, new Object[] {});    
	           return value;    
	       } catch (Exception e) {    
	           play.Logger.error(e.getMessage(),e);    
	           return null;    
	       }    
	   } 
	



	/** 
	 * 根据属性名设置属性值 
	 * */  
	public static  Object setFieldValueByName(String fieldName, Object o) {  
	       try {    
	           String firstLetter = fieldName.substring(0, 1).toUpperCase();    
	           String getter = "set" + firstLetter + fieldName.substring(1);    
	           Method method = o.getClass().getMethod(getter, new Class[] {});    
	           Object value = method.invoke(o, new Object[] {});    
	           return value;    
	       } catch (Exception e) {    
	    	   play.Logger.error(e.getMessage(),e);    
	           return null;    
	       }    
	   } 
	
	/**
	 * 拼接在某属性的 set方法
	 * 
	 * @param fieldName
	 * @return String
	 */
	public static String parSetName(String fieldName) {
		if (null == fieldName || "".equals(fieldName)) {
			return null;
		}
		int startIndex = 0;
		if (fieldName.charAt(0) == '_')
			startIndex = 1;
		return "set"
				+ fieldName.substring(startIndex, startIndex + 1).toUpperCase()
				+ fieldName.substring(startIndex + 1);
	}

	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List<?> sumObj(List<?> list) {
		if (list == null) {
			return null;
		}
		List newlist = new ArrayList();
		Object newobj = null;
		if (list.size() > 0) {
			Class<?> cls = list.get(0).getClass();
			try {
				newobj = cls.newInstance();
				Field[] fields = cls.getDeclaredFields();
				for (Object ob : list) {
					for (int i = 0; i < fields.length; i++) {
						String filedName = fields[i].getName();
						if("serialVersionUID".equals(filedName)){
							continue;
						}
						String fieldtype=fields[i].getType().toString();
						System.out.println(fieldtype);
						if (fieldtype.equals("class java.math.BigDecimal")) {
							String fieldSetName = parSetName(filedName);
							Method fieldSetMet = cls.getMethod(fieldSetName,
									fields[i].getType());
							Object value = getFieldValueByName(filedName,ob);
							Object oldvalue = getFieldValueByName(filedName,newobj);
							if(oldvalue==null){
								fieldSetMet.invoke(newobj, new BigDecimal(0));
								oldvalue = getFieldValueByName(filedName,newobj);								
							}
							BigDecimal newvalue=new BigDecimal(oldvalue.toString()).add(new BigDecimal(value.toString()));
							fieldSetMet.invoke(newobj, newvalue);
						}else if (fieldtype.equals("class java.lang.Long")||fieldtype.equals("long")) {
							String fieldSetName = parSetName(filedName);
							Method fieldSetMet = cls.getMethod(fieldSetName,
									fields[i].getType());
							Object value = getFieldValueByName(filedName,ob);
							Object oldvalue = getFieldValueByName(filedName,newobj);
							if(oldvalue==null){
								fieldSetMet.invoke(newobj, new Long(0));
								oldvalue = getFieldValueByName(filedName,newobj);								
							}
							Long newvalue=new Long(oldvalue.toString())+new Long(value.toString());
							fieldSetMet.invoke(newobj, newvalue);
						}else if (fieldtype.equals("class java.lang.Integer")||fieldtype.equals("int")) {
							String fieldSetName = parSetName(filedName);
							Method fieldSetMet = cls.getMethod(fieldSetName,
									fields[i].getType());
							Object value =fields[i].get(ob) ;// getFieldValueByName(filedName,ob);
							Object oldvalue = getFieldValueByName(filedName,newobj);
							if(oldvalue==null){
								fieldSetMet.invoke(newobj, new Integer(0));
								oldvalue = getFieldValueByName(filedName,newobj);								
							}
							Integer newvalue=new Integer(oldvalue.toString())+new Integer(value.toString());
							fieldSetMet.invoke(newobj, newvalue);
						}
						
					}
				}
				newlist.add(newobj);
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 创建 JavaBean 对象
		}

		return newlist;

	}
	
	
	
	public static List<Map<String, Object>> readFromFile(Class<?> oclass,Global global,String reportname,int pagesize,int pages){
		//List<Object> list=new ArrayList<Object>();
		play.Logger.info("read2File.pagesize="+pagesize);
		/*List<Object> list2=(List<Object>) RedisUtil.getObject(RedisDBApp.temp,reportname+global.getSessionID());
		play.Logger.info("read2File.list2.size()="+list2.size());
		if(list2.size()>0){
			return ListUtil.listToMap(new Object[] {oclass} ,list2, new Object[] {oclass});
		}*/
		List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
		try {
			File file = new File(Play.applicationPath,"/tmp/"+reportname+global.getUserinfo().getCode()+"report.json");
			if(!file.exists()){
				return null;
			}
			BufferedReader bf = new BufferedReader(new FileReader(file));
			String str = null;
	        try {
	        	int i=1;
	        	//int record=0;
	        	if(pages<=0){
	        		pages=1;
	        	}
	        	Map<String,Object> map=null;
				while((str = bf.readLine()) != null) {
					if(i>pagesize*(pages-1)&&i<=pagesize*pages){
						//Object cl=JsonUtil.readJson2Entity(str, oclass);
						//list.add(cl);
						try {
							//map=utils.bus365.serial.JSONUtil.paseJson2Map(str);
							//play.Logger.info("i="+i);
							map=JSON.parseObject(str);
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						listmap.add(map);
					}
					i=i+1;
					if(i>pagesize*pages){
						break;
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				bf.close();
			} catch (IOException e) {
				e.printStackTrace();
			}				
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		play.Logger.info("getFieldType begin----");
		listmap.add(getFieldType(new Object[] {oclass},new Object[] {oclass}));
		play.Logger.info("read2File.list="+listmap.size());
		return listmap;
		//return ListUtil.listToMap(new Object[] {oclass} ,list, new Object[] {oclass});
	}
	
	 //获取字段名称对应的类型
	private static Map<String, Object> getFieldType(Object[] fileds,Object[] filedTypes) {
		
		HashMap<String, Object> hashMap = new HashMap<String, Object>();		

		for(int i=0;i<fileds.length;i++) {
			 Object obj= fileds[i];
			  Class<?> clazz = null;
			  clazz = (obj instanceof Class) ?  (Class<?>)obj : obj.getClass();
				if (clazz.isAnnotationPresent(Entity.class)||clazz.isAnnotationPresent(DelphiDS.class)) {
					Method readMethod;
					PropertyDescriptor pd;
					Field[] fds = clazz.getDeclaredFields();// 获取他的字段数组

					for (Field field : fds) {
						try {
								String filedName = field.getName();
								pd = new PropertyDescriptor(filedName,clazz);
								readMethod = pd.getReadMethod();
								// 如果没有子表
								if (!Collection.class.isAssignableFrom(readMethod.getReturnType())) {
									// 如果有主表
									if (readMethod.getReturnType().isAnnotationPresent(Entity.class)) {
											hashMap.put(field.getName()+ "id", Long.class);
									} else 
									{
										if (readMethod.getReturnType().equals(java.util.Date.class)){
											Temporal des=field.getAnnotation(Temporal.class);
											if(des!=null && des.value()==TemporalType.TIMESTAMP){
												hashMap.put(field.getName(),Timestamp.class);
											}
											else
											{
											hashMap.put(field.getName(),readMethod.getReturnType());
											}
										}
										else
										{
											hashMap.put(field.getName(),readMethod.getReturnType());
										}
									}
								}
							
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (IntrospectionException e) {
							e.printStackTrace();
						}
					}
				} else {
					if(filedTypes==null){
						hashMap.put(obj.toString(), String.class);
					}
					else{
						hashMap.put(obj.toString(), filedTypes[i]);
					}
				}
			}	
		hashMap.put("DATA-FLAG",String.class);	
		return hashMap;
	}
	
	public static List<Object> save2File(List<Object> list,Global global,String reportname){
		File file = new File(reportname+global.getSessionID()+"report.txt");
		List<Object> pagelist=new ArrayList<Object>();
		int i=0; 
		try {
			PrintStream ps = new PrintStream(new FileOutputStream(file));
			for(Object obj: list){
				String str2=JsonUtil.toFormatString(obj);	
				ps.println(str2);
				if(i<=PaginationReportName.PAGESIZE){
					pagelist.add(obj);
				}
				i=i++;
			}
			ps.close();			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pagelist;
	}
	

	public static List<Object> read2File(Global global,String reportname,int pagesize,int pages){
		List<Object> list=new ArrayList<Object>();
		List<Object> subList=new ArrayList<Object>();
		play.Logger.info("read2File.pagesize="+pagesize);
		try {
			File file = new File(reportname+global.getSessionID()+"report.txt");
			if(!file.exists()){
				return null;
			}
			BufferedReader bf = new BufferedReader(new FileReader(file));
			String str = null;
	        try {
				while((str = bf.readLine()) != null) {
					//Object cl=JsonUtil2.toObject(str, oclass);
					str=str.substring(1, str.length()-1);
					str=str.replaceAll("\"", "");
					Object[] cl=str.split(",");
					list.add(cl);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				bf.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (pagesize<=0){
				pagesize=PaginationReportName.PAGESIZE;
			}
			int totalcount=list.size();
			int pagecount=0;
			int m=totalcount%pagesize;
			if(m>0){
			     pagecount=totalcount/pagesize+1;
			 }else{
			     pagecount=totalcount/pagesize;
			 }
			 if (pagesize>=totalcount){
				 subList= list;
			 }else{
				 if(pagecount<=pages){
					 subList= list.subList((pagecount-1)*pagesize,pagesize*(pagecount));
				 }else{
					 subList= list.subList((pages-1)*pagesize,pagesize*(pages));
				 }
			 }
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		play.Logger.info("read2File.subList.size()="+subList.size());
		return subList;
	}	
	
}
