package util;

import java.util.ResourceBundle;


public class ResourceConfig {
	private static ResourceBundle rb = ResourceBundle.getBundle("resource");
	public static String getValue(String key) {
		return (rb.getString(key));
	}
}
