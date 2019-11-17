package cn.nova.bus.exception;

import java.io.Serializable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

import cn.nova.bus.system.dao.ExceptioninfoDao;

/**
 * 业务异常改为从RuntimeException继承，以便在服务层抛出此异常后自动回滚事务。
 * 但编译器不会显示的提示要捕获此异常了，记得在action中捕获此异常
 * @author Administrator
 */
//@javax.ejb.ApplicationException(rollback=true)
public class ServiceException extends Exception implements Serializable{  //Exception 
  private static final Logger log= LoggerFactory.getLogger(ServiceException.class);
  
	/**
	 * 自定义异常类
	 * 系统所有的DDL操作都必须捕获该异常
	 * lanck
	 */
	private static final long serialVersionUID = -8604911568843326459L;
	private String exceptionCode;//自定义的异常代码
	private String exceptionMessage;//自定义的异常信息
	private String inputMsg;//创建异常时输入信息，如用户输入的某个字段的值


	//@EJB
	transient private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();

	public ServiceException(String exceptionCode) {
		super(exceptionCode);
		setExceptionCode(exceptionCode);
		setExceptionMessage(getExceptionMessageByExceptionCode(exceptionCode));
	}

	public ServiceException(String inputMsg, String exceptionCode) {
		super(exceptionCode);
		setInputMsg(inputMsg);
		setExceptionCode(exceptionCode);
		setExceptionMessage(inputMsg + ":"
				+ getExceptionMessageByExceptionCode(exceptionCode));
	}

	public ServiceException(String inputMsg, String exceptionCode,boolean isappend) {
		super(inputMsg);
		setInputMsg(inputMsg);
		setExceptionCode(exceptionCode);
		if(isappend){
			setExceptionMessage(getExceptionMessageByExceptionCode(exceptionCode) + ":"
					+ inputMsg);
		}
		else{
			setExceptionMessage(inputMsg + ":"
					+ getExceptionMessageByExceptionCode(exceptionCode));
		}
	}

	public String getMessage() {
		return exceptionMessage;
	}

	public void setExceptionCode(String exceptionCode) {
		this.exceptionCode = exceptionCode;
	}

	public String getExceptionCode() {
		return exceptionCode;
	}

	public void setExceptionMessage(String exceptionMessage) {
		this.exceptionMessage = exceptionMessage;
	}

	public String getExceptionMessage() {
		return exceptionMessage;
	}

	public String getExceptionMessageByExceptionCode(String exceptionCode) {
		try {
//		exceptioninfoDao = new ExceptioninfoDao();
//		return exceptioninfoDao.getExceptioninfo(exceptionCode);
		String info = RedisUtil.get(RedisDBApp.temp, exceptionCode);
		if(info==null||"".equals(info)){
			exceptioninfoDao = new ExceptioninfoDao();
			info =  exceptioninfoDao.getExceptioninfo(exceptionCode);
			RedisUtil.set(RedisDBApp.temp ,exceptionCode, info, 600);
		}
		return info;
    } catch (Exception e) {
      log.error("通过jndi( java:global/NvBus/NvBusEJB/ExceptioninfoDao )获取ejb时发成异常",e);
      return "发生异常(exceptionCode="+exceptionCode+")，暂时无法返回更详细的异常信息";
    }
	}
	public String getInputMsg() {
		return inputMsg;
	}

	public void setInputMsg(String inputMsg) {
		this.inputMsg = inputMsg;
	}
}
