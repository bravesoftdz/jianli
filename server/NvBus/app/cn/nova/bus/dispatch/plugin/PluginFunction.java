package cn.nova.bus.dispatch.plugin;

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

public class PluginFunction {

	public static void DoPlugin(Object object, Global global,
			ActionNode actionNode) throws ServiceException {

		if (actionNode != null) {// 不为空,则存在此插件
			Class pluginClass = Play.classloader
					.getClassIgnoreCase(actionNode.controller);// 插件类

			HashMap<String, String[]> requstMap = new HashMap<String, String[]>();
			// 初始化flag与msg为1
			requstMap.put("action.flag", new String[] { "1" });
			requstMap.put("action.msg", new String[] { "操作成功！" });
			if (pluginClass != null) {
				// 调用play包，反序列化requstMap成对象
				Object result = Binder.bindInternal("action", pluginClass,
						pluginClass, new Annotation[] {}, requstMap, "", null);
				try {
					// 反射调用 action类的方法
					Method methodName = pluginClass.getMethod(
							actionNode.action, new Class[] { Object.class,
									Global.class });// 插件方法
					try {
						Map<Object, Object> pluginResult = (Map<Object, Object>) methodName
								.invoke(result, new Object[] { object, global });// 调用插件方法
						boolean isaudit = (Boolean) pluginResult.get("isaudit"); // 插件返回结果1：是否审核通过
						if (!isaudit) {
							// 审核不通过，抛出审核不通过提示0480
							throw new ServiceException(
									(String) pluginResult.get("exceptionCode"));// 插件返回结果2：抛出审核不通过提示
						}
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
		}
	}
}
