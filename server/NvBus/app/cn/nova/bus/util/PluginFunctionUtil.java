package cn.nova.bus.util;

import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import models.ActionNode;

import play.Play;
import play.data.binding.Binder;
import util.Appvar;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;

public class PluginFunctionUtil {

	public static Map<Object, Object> DoPlugin(Object object, Global global,
			ActionNode actionNode) throws ServiceException {

		if (actionNode != null) {// 不为空,则存在此插件
			Class pluginClass = Play.classloader
					.getClassIgnoreCase(actionNode.controller);// 插件类

			HashMap<String, String[]> requstMap = new HashMap<String, String[]>();
			// 初始化flag与msg为1
			requstMap.put("action.flag", new String[] { "1" });
			requstMap.put("action.msg", new String[] { "操作成功！" });

			// 调用play包，反序列化requstMap成对象
			Object result = Binder.bindInternal("action", pluginClass,
					pluginClass, new Annotation[] {}, requstMap, "", null);
			try {
				// 反射调用 action类的方法
				Method methodName = pluginClass.getMethod(actionNode.action,
						new Class[] { Object.class, Global.class });// 插件方法
				try {
					Map<Object, Object> pluginResult = (Map<Object, Object>) methodName
							.invoke(result, new Object[] { object,
									global });// 调用插件方法
					return pluginResult;
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	/**
	 * 
	 * @param pluginName 调取插件时的plugin的名称（PluginReg中定义）
	 * @param requestMap 插件调用的请求参数
	 * 
	 * @return pluginResult : 返回值pluginResult，包含:调用插件的返回值和 isUsePlugin
	 * 		返回值pluginResult中的元素 isUsePlugin : 用来标识是否启用插件：0未启用，1 启用。
	 * 			isUsePlugin 使用场景：需求*只要插件返回值时*用 isUsePlugin 判断
	 * @throws ServiceException
	 */
	public static Map<Object, Object> doPlugin(String pluginName,
			Map<String, Object> requestMap) throws ServiceException {
		Map<Object, Object> pluginResult = new HashMap<Object, Object>();// 本方法的返回结果

		ActionNode actionNode = Appvar.routes.get(pluginName); // 通过插件名，得到扩展点相关信息

		if (actionNode != null) {	// 不为空,则存在此插件
			Class pluginClass = Play.classloader
					.getClassIgnoreCase(actionNode.controller);// 插件类

			HashMap<String, String[]> requstMap = new HashMap<String, String[]>();
			// 初始化flag与msg为1
			requstMap.put("action.flag", new String[] { "1" });
			requstMap.put("action.msg", new String[] { "操作成功！" });

			// 调用play包，反序列化requstMap成对象
			Object result = Binder.bindInternal("action", pluginClass,
					pluginClass, new Annotation[] {}, requstMap, "", null);
			try {
				// 反射调用 action类的方法
				Method methodName = pluginClass.getMethod(actionNode.action,
						new Class[] { Map.class });// 插件方法
				try {
					pluginResult = (Map<Object, Object>) methodName.invoke(
							result, new Object[] { requestMap });// 调用扩展点中的方法,返回Map结果
					pluginResult.put("isUsePlugin", "1"); // 标识量：使用插件
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				}
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			}
		} else {
			// 为空,则不存在此插件
			pluginResult.put("isUsePlugin", "0");// 标识量：未使用插件
		}
		return pluginResult;
	}
}

