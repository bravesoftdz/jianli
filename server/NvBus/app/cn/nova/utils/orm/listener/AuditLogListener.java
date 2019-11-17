package cn.nova.utils.orm.listener;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.PostPersist;
import javax.persistence.PostRemove;
import javax.persistence.PreUpdate;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import play.db.jpa.JPA;
import play.db.jpa.JPAPlugin;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.jpa.IDAO;


/**
 * <b>类描述：</b>数据审计日志生成的监听器<br/>
 * <b>类名称：</b>AuditLogListener<br/>
 * <b>创建人：</b>余敏<br/>
 * <b>修改：</b>原本中心和车站工程分别有实现此监听器，后将统一两者合并到此工程中<br/>
 * <b>修改时间：</b>2012-03-13<br/>
 * <b>修改人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 */
public final class AuditLogListener {
  static private final Logger log=LoggerFactory.getLogger(AuditLogListener.class);
  
  @SuppressWarnings("rawtypes")
  private IDAO dao=null;
	
	@SuppressWarnings("rawtypes")
  public IDAO getDao() {
//    try {
      if(dao==null)
//        dao=(IDAO) EjbFinder.getEJB(NvSystemConfig.getIDaoImpl(), false);
    	  JPAPlugin.startTx(false);
    	  dao=new EntityManagerDaoSurport();
//    } catch (NamingException e) {
//      log.error("获取IDAO的实现"+NvSystemConfig.getIDaoImpl()+"异常",e);
//    }
      
    return dao;
  }

  private Set<Object> updateObject = new LinkedHashSet<Object>();
	
	@SuppressWarnings("unchecked")
  @PostRemove
	public void PostRemove(Object object){
		if (getDao()!=null) {
			Auditlog log = createAuditlog(object);
			log.setOperation("2");
			log.setContent(getRecordStr(object));
			Object id = getIdValue(object);
			if(id instanceof Long){
				log.setDataid((Long)id);
			}
			
			getDao().merge(log);
		}
	}
	
	@SuppressWarnings("unchecked")
  @PostPersist
	public void PostPersist(Object object){
		if (getDao()!=null) {
			Auditlog log = createAuditlog(object);
			log.setOperation("0");
			log.setContent(getRecordStr(object));
			Object id = getIdValue(object);
			if(id instanceof Long){
				log.setDataid((Long)id);
			}
			getDao().merge(log);
		}
	}
	
	private Auditlog createAuditlog(Object object){
		Auditlog log = new Auditlog();
		log.setTablename(object.getClass().getName());
		log.setIp(getRemoteHost());
		log.setOccurtime(new Date());
		log.setSessionid(getSessionId());
		log.setUserid(getUserId());
		return log;
	}
	
	private String getRecordStr(Object object){
		StringBuilder recordChange = new StringBuilder();
//	recordChange.append("表名：").append( object.getClass().getName() ).append("。");
		for (Field f : object.getClass().getDeclaredFields()) {
		  if(Modifier.isStatic(f.getModifiers())){
		    continue;
		  }
		  
			PropertyDescriptor pd = null;
			Method readMethod;
			String fieldName = f.getName();
			try {
				pd = new PropertyDescriptor(fieldName,object.getClass());
				readMethod = pd.getReadMethod();
				if(Collection.class.isAssignableFrom(readMethod.getReturnType())){
					continue;
				}
			} catch (IntrospectionException e) {
			  log.info(e.getMessage());
			}
			
			if(f.getName().equalsIgnoreCase("createtime")
					||f.getName().equalsIgnoreCase("createby")
					||f.getName().equalsIgnoreCase("updatetime")
					||f.getName().equalsIgnoreCase("updateby")
					||f.getName().equalsIgnoreCase("connectionstatus")
					||f.getName().equalsIgnoreCase("lastruntime")
			){
				continue;
			}else{
				recordChange.append(getFieldValue(f,object));
			}
		}
		return recordChange.toString();
	}
	
  @SuppressWarnings("unchecked")
  @PreUpdate
	public void PreUpdate(Object object){
  	//在回调方法中查询会自动提交，引起回调死循环 
  	//解决办法：第一次循环时记录，记录要提交的object
  	if (updateObject.contains(object)) {
		  return;
	  } else {
  		updateObject.add(object);
  	}
    	
		if (getDao()!=null) {
			Object object_old = getOldRecord(object);
			StringBuilder recordChange = new StringBuilder();
			boolean recordChanged = false;
//			recordChange.append("表名：").append(
//					object.getClass().getName()).append("。");
			for (Field f : object.getClass().getDeclaredFields()) { 
				PropertyDescriptor pd = null;
				Method readMethod;
				String filedName = f.getName();
				try {
					pd = new PropertyDescriptor(filedName,object.getClass());
					readMethod = pd.getReadMethod();
					//子表
					if(Collection.class.isAssignableFrom(readMethod.getReturnType())){
						continue;
					}
				} catch (IntrospectionException e) {
//					play.Logger.error(e.getMessage(), e);
				}
				if(f.getName().equalsIgnoreCase("createtime")
						||f.getName().equalsIgnoreCase("createby")
						||f.getName().equalsIgnoreCase("updatetime")
						||f.getName().equalsIgnoreCase("updateby")
						||f.getName().equalsIgnoreCase("connectionstatus")
						||f.getName().equalsIgnoreCase("lastruntime")
				)
				{
					continue;
				}
				String fieldChange = getFieldChange(f,object,object_old);
				if (fieldChange!=null&&!fieldChange.equals("")) {
					recordChanged = true;
					recordChange.append(fieldChange);
				}

			}
			
			if(recordChanged){
//				System.out.println(recordChange.toString());
				Auditlog log = createAuditlog(object);
				//TODO 如何从表得到正在操作的模块
				log.setOperation("1");
				log.setContent(recordChange.toString());
				Object id = getIdValue(object);
				if(id instanceof Long){
					log.setDataid((Long)id);
				}
				getDao().merge(log);
			}		
		}
		updateObject.remove(object);
	}
    
	private Long getUserId() {
		// TODO 取实际登陆用户ID
		return new Long(0);
	}

	private String getSessionId() {
		// TODO 取实际session ID
		return "session id";
	}

	private String getRemoteHost() {
		// TODO 取实际登陆IP
		return "127.0.0.1";
	}

	//查出保存前的值
  @SuppressWarnings("unchecked")
  private Object getOldRecord(Object object) {
  	if (getDao()!=null) {
  		return getDao().getNoCache(object.getClass(), getIdValue(object));
  	}
		return null;
	}

	private Object getIdValue(Object object) {
		Object result = null;
		for (Field field : object.getClass().getDeclaredFields()) {
			if (field.getAnnotation(javax.persistence.Id.class)!=null) {
				try {
					PropertyDescriptor pd = new PropertyDescriptor(field.getName(), object.getClass());
					Method readMethod = pd.getReadMethod();
					try {
						result = readMethod.invoke(object, null);
					} catch (IllegalArgumentException e) {
						play.Logger.error(e.getMessage(), e);
						result =  null;
					} catch (IllegalAccessException e) {
						play.Logger.error(e.getMessage(), e);
						result = null;
					} catch (InvocationTargetException e) {
						play.Logger.error(e.getMessage(), e);
						result = null;
					}
				} catch (IntrospectionException e) {
					play.Logger.error(e.getMessage(), e);
					result = null;
				}
				break;
			}
		}
		if (result == null) {
			for (Method method : object.getClass().getDeclaredMethods()) {
				if (method.getAnnotation(javax.persistence.Id.class)!=null) {
					try {
						result =method.invoke(object, null);
					} catch (IllegalArgumentException e) {
						play.Logger.error(e.getMessage(), e);
						result = null;
					} catch (IllegalAccessException e) {
						play.Logger.error(e.getMessage(), e);
						result = null;
					} catch (InvocationTargetException e) {
						play.Logger.error(e.getMessage(), e);
						result = null;
					}
					break;
				} 
			}
		}
		return result;
	}

	public String getFieldChange(Field field,Object object,Object object_old){
    	String result = null;
		PropertyDescriptor pd;
		try {
			pd = new PropertyDescriptor(field.getName(), object.getClass());
			Method methodGet = pd.getReadMethod();
			if(methodGet!=null){
				Object getValue;
				Object getValue_old;
				try {
					getValue = methodGet.invoke(object, null);
					getValue_old = methodGet.invoke(object_old, null);
					if (Collection.class.isAssignableFrom(methodGet.getReturnType())) {
						//子表
						return result;						
					}
					else if (methodGet.getReturnType().isAnnotationPresent(Entity.class)) {
						// 如果是主表
						Object idvalue = null;
						Object idvalue_old = null;
						if (getValue != null) {
							Method readidMethod = getIdReadMethod(getValue);
							idvalue = readidMethod.invoke(getValue);
						}
						if (getValue_old != null) {
							Method readidMethod = getIdReadMethod(getValue_old);
							idvalue_old = readidMethod.invoke(getValue_old);
						}
						if (idvalue == null
								^ idvalue_old == null) {
							result = field.getName()+":"+idvalue_old+" -> "+idvalue+";";
						} else if (idvalue != null
								&& idvalue_old != null) {
							if (!idvalue.equals(idvalue_old)) {
								result = field.getName()+":"+idvalue_old+" -> "+idvalue+";";
							}
						}
					}
					else{
						//其它类型
						if (getValue == null ^ getValue_old == null) {
							result = field.getName()+":"+getValue_old+" -> "+getValue+";";
						} else if (getValue != null
								&& getValue_old != null) {
							if (!getValue.equals(getValue_old)) {
								result = field.getName()+":"+getValue_old+" -> "+getValue+";";
							}
						}
					}
				} catch (IllegalArgumentException e) {
					play.Logger.error(e.getMessage(), e);
				} catch (IllegalAccessException e) {
					play.Logger.error(e.getMessage(), e);
				} catch (InvocationTargetException e) {
					play.Logger.error(e.getMessage(), e);
				}
			}
		} catch (IntrospectionException e) {
//			play.Logger.error(e.getMessage(), e);
		}
		return result;
  }

	public String getFieldValue(Field field,Object object){
    	String result = null;
		PropertyDescriptor pd;
		try {
			pd = new PropertyDescriptor(field.getName(), object.getClass());
			Method methodGet = pd.getReadMethod();
			if(methodGet!=null){
				Object getValue;
				try {
					getValue = methodGet.invoke(object, null);
					if(getValue!=null){
						if(getValue instanceof  Collection){
							return result;						
						}
						else{
							result = field.getName()+":"+getValue+";";
						}
					}
				} catch (IllegalArgumentException e) {
					play.Logger.error(e.getMessage(), e);
				} catch (IllegalAccessException e) {
					play.Logger.error(e.getMessage(), e);
				} catch (InvocationTargetException e) {
					play.Logger.error(e.getMessage(), e);
				}
			}
		} catch (IntrospectionException e) {
//			play.Logger.error(e.getMessage(), e);
		}
		return result;
    }

	public static Method getIdReadMethod(Object parentObject) throws IntrospectionException{
		for (Field field : parentObject.getClass().getFields()) {
			if(field.getAnnotation(javax.persistence.Id.class)!=null){
				return (new PropertyDescriptor(field.getName(),parentObject.getClass())).getReadMethod();
			}
		}
		for (Field field : parentObject.getClass().getDeclaredFields()) {
			if(field.getAnnotation(javax.persistence.Id.class)!=null){
				return (new PropertyDescriptor(field.getName(),parentObject.getClass())).getReadMethod();
			}
		}
		for (Method method: parentObject.getClass().getMethods()) {
			if(method.getAnnotation(javax.persistence.Id.class)!=null){
				return method;
			}
		}
		return null;
	}	

}
