package util;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

public class JSUtil {
	public static ScriptEngineManager manager;
	public static ScriptEngine engine;
	public static String rs = null;
	
	public static String format(String function, String value){
		if (manager == null) {
			manager = new ScriptEngineManager();
			engine = (ScriptEngine) manager.getEngineByName("javascript");
		}
		StringBuilder js = new StringBuilder("(");
		js.append(function);
		js.append(")("+value+")");
		try {
			rs = (String) engine.eval(js.toString());
		} catch (ScriptException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return rs;
	}
}
