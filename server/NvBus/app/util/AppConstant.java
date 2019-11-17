package util;

import java.io.File;
import java.util.ResourceBundle;

import play.Play;

public class AppConstant {
	public static final int REMOTE_TRANSACTION_BEGIN = 0;
	public static final int REMOTE_TRANSACTION_ING = 1;
	public static final int REMOTE_TRANSACTION_UNDOING = 2;
	public static final int REMOTE_TRANSACTION_UNDO_SUCCESS = 3;
	public static final int REMOTE_TRANSACTION_SUCCESS = 9;
	
	public static final int ACCESSLOG_TYPE_STASTION = 0;
	public static final int ACCESSLOG_TYPE_SOCKET = 1;
	public static final int ACCESSLOG_TYPE_WEBSERVICE = 2;
	
	public static final int DEFAULT_SERVICE_FEE = 3;
	
	private static ResourceBundle rb = ResourceBundle.getBundle("options");
	public static String getValue(String key) {
		try{
			return (rb.getString(key)==null?"":rb.getString(key));
		}
		catch(Exception e){
			play.Logger.error("",e);
			e.printStackTrace();
			return "";
		}
	}
}
