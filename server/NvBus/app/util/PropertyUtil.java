package util;

import play.Play;

public class PropertyUtil {

	public static String getProperty(String key){
		return Play.configuration.getProperty(key);
	}
	public static Object getObject(String classPath) throws InstantiationException, IllegalAccessException{
		return Play.classloader.getClassIgnoreCase(classPath).newInstance();
	}
}
