package util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import play.modules.redis.RedisConnectionManager;
import redis.clients.jedis.Jedis;

public class RedisUtil {
	public enum RedisDBApp {
	    Operatorinfo,
	    ValidateImage,
	    Dictionary,
	    Lessee,
	    Reception,
	    Session,
	    temp6,
	    temp7,
	    openapi,
	    temp,
		global,
		undo,
		cancelSeat,
		returnTicket,
		cancelCheck,
		parameter
	}
	
	/**
	 * 更改当前数据库
	 * 切换到对应的数据库
	 * @param RedisDBApp 对应的应用枚举
	 * @return 没有返回值
	 */
	public static void ChangeDB(RedisDBApp appName) 
	{
		play.Logger.info("ChangeDB="+appName+",name="+appName.name());
		try
		{
			RedisConnectionManager.getRawConnection().select(appName.ordinal());
		}	catch (Exception e) {
			throw new play.exceptions.UnexpectedException("切换数据库出现错误");
		}
		
	}
	
	/**
	 * 向Redis库中添加信息
	 * @param db 库序号
	 * @param key 键
	 * @param value 值
	 * @ldl 重载 无切换redis库的方法
	 */
	public static void set(String key,Object value){
		play.Logger.info("无切换redis库的方法 set  key="+key);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().set(key.getBytes("UTF-8"), buf);
			RedisConnectionManager.closeConnection();
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 刷新Redis
	 */
	public static void flushAll() {
		RedisConnectionManager.getRawConnection().flushAll();
	}
	
	/**
	 * 获取Redis中某分区的key总数
	 * @param db
	 * @return
	 */
	public static long getKeysCount(RedisDBApp db) {
		ChangeDB(db);
		return RedisConnectionManager.getRawConnection().dbSize();
	}
	
	/**
	 * 向Redis库中添加信息并确认
	 * @param db 库序号
	 * @param key 键
	 * @param value 值
	 * @ldl 重载 无切换redis库的方法
	 */
	public static boolean setAndReply(RedisDBApp db,String key,Object value){
		play.Logger.info("db="+db.name()+",setAndReply key="+key);
		ChangeDB(db);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().set(key.getBytes("UTF-8"), buf);
			RedisConnectionManager.closeConnection();
			return true;
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
			return false;
		}
	}
		
	/**
	 * 向Redis库中添加信息并确认
	 * @param db 库序号
	 * @param key 键
	 * @param value 值
	 * @ldl 重载 无切换redis库的方法
	 */
	public static boolean setAndReply(RedisDBApp db,String key,Object value,int times){
		play.Logger.info("db="+db.name()+",setAndReply key="+key+",times="+times);
		ChangeDB(db);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().setex(key.getBytes("UTF-8"),60*times,buf);
			RedisConnectionManager.closeConnection();
			return true;
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
			return false;
		}
	}
	
	/**
	 * 向Redis库中添加信息
	 * @param db 库序号
	 * @param key 键
	 * @param value 值
	 */
	public static void set(RedisDBApp db,String key,Object value){
		play.Logger.info("db="+db.name()+ ", set key="+key);
		ChangeDB(db);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().set(key.getBytes("UTF-8"), buf);
			RedisConnectionManager.closeConnection();
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}
	/**
	 * 向Redis库中添加信息
	 * @param db 库序号
	 * @param key 键
	 * @param value 值
	 */
	public static void set(RedisDBApp db,String key,Object value,int expiretime){
		play.Logger.info("db="+db.name()+ ", set key="+key+",expiretime="+expiretime);
		ChangeDB(db);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().setex(key.getBytes("UTF-8"),expiretime*60, buf);
			RedisConnectionManager.closeConnection();
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 向Redis库中添加信息
	 * @param db 库序号
	 * @param key 键
	 * @param expiretime 超时时间(单位--分钟)
	 * @param value 值
	 * @ldl 重载 无切换redis库的方法
	 */
/*	public static void set(String key,Object value,int expiretime){
		play.Logger.info( "set key="+key+",expiretime="+expiretime);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().setex(key.getBytes("UTF-8"),expiretime*60, buf);
			RedisConnectionManager.closeConnection();
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}*/
	
	public static void set(RedisDBApp db,String key,String value){
		play.Logger.info("db="+db.name()+ ", set key="+key+",value="+value);
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().set(key, value);
		RedisConnectionManager.closeConnection();
		return;
	}
	
	public static void set(RedisDBApp db,String key,String value,int minutes){
		play.Logger.info("db="+db.name()+ ", set key="+key+",value="+value+",minutes="+minutes);
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().setex(key, minutes*60, value);
		RedisConnectionManager.closeConnection();
	}
	
	public static void setRemainSecond(RedisDBApp db,String key,String value,int seconds){
		play.Logger.info("db="+db.name()+ ", setRemainSecond key="+key+",value="+value+",seconds="+seconds);			
		ChangeDB(db);	
		RedisConnectionManager.getRawConnection().setex(key, seconds, value);
		RedisConnectionManager.closeConnection();
	}
	
	/**
	 * 向Redis库中添加信息
	 * @param db 库序号
	 * @param key 键
	 * @param value 值
	 */
	public static void set(RedisDBApp db,byte[] key,Object value){
		play.Logger.info("db="+db.name()+ ", set key="+key);
		ChangeDB(db);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().set(key, buf);
			RedisConnectionManager.closeConnection();
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}
	/**
	 * 向Redis库中添加信息
	 * @param db 库序号
	 * @param key 键
	 * @param expiretime 超时时间(单位--分钟)
	 * @param value 值
	 */
	public static void set(RedisDBApp db,byte[] key,Object value,int expiretime){
		play.Logger.info("db="+db.name()+ ", set expiretime="+expiretime);	
		ChangeDB(db);
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		ObjectOutputStream oos;
		try {
			oos = new ObjectOutputStream(baos);
			oos.writeObject(value);
			byte[] buf=baos.toByteArray();
			oos.flush();
			RedisConnectionManager.getRawConnection().setex(key,expiretime*60, buf);
			RedisConnectionManager.closeConnection();
		} catch (IOException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}
	
	
	public static String get(RedisDBApp db,String key){
		play.Logger.info("db="+db.name()+ ", get key="+key);	
		ChangeDB(db);
		String value=RedisConnectionManager.getRawConnection().get(key);
		RedisConnectionManager.closeConnection();
		return value;
	}
	/**
	 * 从Redis库中获得信息
	 * @param db 库序号
	 * @param key 键
	 * @return
	 */
	public static Object get(RedisDBApp db,byte[] key){
		play.Logger.info("db="+db.name()+ ", get key="+key);	
		ChangeDB(db);
		Object objVal=null;
		byte[] value=null;
		value=RedisConnectionManager.getRawConnection().get(key);
		if (value!=null) {
			ByteArrayInputStream bais=new ByteArrayInputStream(value);
			try {
				ObjectInputStream ois=new ObjectInputStream(bais);
				objVal=ois.readObject();
			} catch (IOException e) {
				play.Logger.error(e.getMessage(), e);
			} catch (ClassNotFoundException e) {
				play.Logger.error(e.getMessage(), e);
			}
		}
		RedisConnectionManager.closeConnection();
		return objVal;
	}
	
	/**
	 * 从Redis库中获得信息
	 * @param db 库序号
	 * @param key 键
	 * @liudl 重载无切换数据库的 获取数据方法
	 * @return
	 */
	public static Object getObject(RedisDBApp db,String key){
		play.Logger.info("db="+db.name()+ ", getObject key="+key);	
		ChangeDB(db);
		Object objVal=null;
		byte[] value=null;
		//Jedis jedis = RedisConnectionManager.getRawConnection();
		try {
			value=RedisConnectionManager.getRawConnection().get(key.getBytes("UTF-8"));
			//value = jedis.get(key.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			play.Logger.error(e.getMessage(), e);
		}
		if (value!=null) {
			ByteArrayInputStream bais=new ByteArrayInputStream(value);
			try {
				ObjectInputStream ois=new ObjectInputStream(bais);
				objVal=ois.readObject();
			} catch (IOException e) {
				play.Logger.error(e.getMessage(), e);
			} catch (ClassNotFoundException e) {
				play.Logger.error(e.getMessage(), e);
			}
		}
		return objVal;
	}
	
	/**
	 * 从Redis库中删除信息
	 * @param db 库序号
	 * @param key 键
	 */
	public static void delete(RedisDBApp db,String... key){
		play.Logger.info("db="+db.name()+ ", delete key="+key);	
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().del(key);
		RedisConnectionManager.closeConnection();
	}
	/**
	 * 从Redis库中删除信息
	 * @param db 库序号
	 * @param key 键
	 */
	public static void delete(RedisDBApp db,byte[]... key){
		play.Logger.info("db="+db.name()+ ", delete key="+key);	
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().del(key);
		RedisConnectionManager.closeConnection();
	}
	/**
	 * 根据类型获得一组键值对
	 * @param db 库序号
	 * @param type 类型
	 * @return
	 */
	public static Map<String, String> get(RedisDBApp db,int type){
		Map<String, String> map=new HashMap<String, String>();
		play.Logger.info("db="+db.name()+ ", getRemainTime type="+type);	
		ChangeDB(db);
		Set<String> keys=RedisConnectionManager.getRawConnection().keys(1+"*");
		Iterator<String> keyIter=keys.iterator();
		while (keyIter.hasNext()) {
			String key=keyIter.next();
			String value=RedisConnectionManager.getRawConnection().get(key);
			map.put(key, value);
		}
		RedisConnectionManager.closeConnection();
		return map;
	}
	
	/**
	 * 查询redis中key的剩余时间
	 * @param db
	 * @param key
	 * @return
	 */
	public static Long getRemainTime(RedisDBApp db,String key){
		play.Logger.info("db="+db.name()+ ", getRemainTime key="+key);	
		ChangeDB(db);
		long value=RedisConnectionManager.getRawConnection().ttl(key);
		RedisConnectionManager.closeConnection();
		return value;
	}
	/**
	 * 查询redis中key的剩余时间
	 * @param db
	 * @param key
	 * @return
	 */
	public static Long getRemainTime(RedisDBApp db,byte[] key){
		play.Logger.info("db="+db.name()+ ", getRemainTime key="+key);	
		ChangeDB(db);
		long value=RedisConnectionManager.getRawConnection().ttl(key);
		RedisConnectionManager.closeConnection();
		return value;
	}
	
	public static void flushdb(RedisDBApp db) {
		play.Logger.info("db="+db.name()+ ", flushdb");	
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().flushDB();
	}
	
	public static void rPush(RedisDBApp db,String key, String value){
		play.Logger.info("db="+db.name()+ ", rPush key="+key+",value="+value);	
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().rpush(key, value);
	}
	
	public static List<String> getList(RedisDBApp db,String key){
		play.Logger.info("db="+db.name()+ ", getList key="+key);	
		ChangeDB(db);
		List<String> list=RedisConnectionManager.getRawConnection().lrange(key, 0, -1);
		RedisConnectionManager.closeConnection();
		return  list;
	}
	
	public static void delOldList(RedisDBApp db, String key, int start){
		play.Logger.info("db="+db.name()+ ", delOldList key="+key+",start="+start);	
		if(start == 0){
			return;
		}
		ChangeDB(db);
		RedisConnectionManager.getRawConnection().ltrim(key, start, -1);
		RedisConnectionManager.closeConnection();
	}
	
	/**
	 * 获取key - list 所有值
	 * @param db
	 * @param key
	 * @return
	 */
	public static List<String> lrangeAll(RedisDBApp db, String key) {
		play.Logger.info("db=" + db.name() + ", getlist key=" + key);
		ChangeDB(db);
		return RedisConnectionManager.getRawConnection().lrange(key, 0, -1);
	}
	
	/**
	 * 获取key - set 所有值
	 * @param db
	 * @param key
	 * @return
	 */
	public static Set<String> smembers(RedisDBApp db, String key) {
		play.Logger.info("db=" + db.name() + ", getset key=" + key);
		ChangeDB(db);
		return RedisConnectionManager.getRawConnection().smembers(key);
	}
	
	/**
	 * 存储值到 key - set中
	 * 
	 * @param db
	 * @param key
	 * @return
	 */
	public static Long sadd(RedisDBApp db, String key, String value) {
		play.Logger.info("db=" + db.name() + ", sadd key=" + key);
		ChangeDB(db);
		return RedisConnectionManager.getRawConnection().sadd(key, value);
	}
	
	/**
	 * 从 key - set中 删除值
	 * 
	 * @param db
	 * @param key
	 * @return
	 */
	public static Long srem(RedisDBApp db, String key, String value) {
		play.Logger.info("db=" + db.name() + ", srem key=" + key);
		ChangeDB(db);
		return RedisConnectionManager.getRawConnection().srem(key, value);
	}
}
