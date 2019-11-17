package cn.nova.bus.util;

import java.lang.reflect.Constructor;

public class ClassUtil {
	public static Object createClass(String name) throws Exception
	// 自动找到合适的构造方法并构造
	{
		Class<?> myClass = Class.forName(name);
		Constructor<?> cons = myClass.getConstructor();
		return cons.newInstance();

	}
}
