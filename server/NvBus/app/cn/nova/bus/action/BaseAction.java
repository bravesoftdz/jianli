package cn.nova.bus.action;

import cn.nova.utils.commons.MethodResult;
import util.TransactionUtil;

/**
 * 
 * 2014年11月29日
 * @author hechaoyang
 */
public class BaseAction {
	public static final Long SUCCESS = 1L; 
	public static final Long FAIL = -1L; 
	public static final Long ERROR = -2L; 
	public static final Long FAILURE = 0L; 

	protected String msg;
	/**
	 * 因为涉及事务管理与否，所以请使用markXXXX系列方法与setFlag方法
	 */	
	private Long flag;
	
	/**
	 * 标示服务器处理结果成功 flag =1
	 */
	public void markSuccess(){
		flag = SUCCESS;
	};
	
	/**
	 * 标示服务器处理结果失败  flag = -1
	 */
	public void markFail(){
		TransactionUtil.setRollbackOnly();
		flag = FAIL;
	};
	
	/**
	 * 标示服务器处理时出现异常  flag = -2
	 */
	public void markError(){
		TransactionUtil.setRollbackOnly();
		flag = ERROR;
	};
	
	/**
	 * 标示服务器处理结果失败  flag = 0
	 * 因为之前开发系统，没有事先统一规范，所以存在0与-1标示失败，推荐使用-1的markFail() 
	 */
	public void markFailure(){
		TransactionUtil.setRollbackOnly();
		flag = FAILURE;
	};
	
	/**
	 * 因为之前flag有int与long两种方法，此处有低转高，不失精度。
	 */
	public void markFlag(int flag){
		markFlag((long)flag);
	};
	
	/**
	 * 设定flag的值
	 * markFlag()与setFlag()不同之处，markFlag涉及事务管理，如果flag不表示此次查询失败，不需要回滚数据，请使用setFlag()
	 * 如果是明确结果，推荐使用markSuccess()/markFail()/markError
	 */
	public void markFlag(long flag){
		if(flag == SUCCESS){
			markSuccess();
		}else if(flag == FAIL){
			markFail();
		}else if(flag == ERROR){
			markError();
		}else if(flag == FAILURE){
			markFailure();
		}else{
			setFlag(flag);
		}
	};

	/**
	 * 设定flag的值
	 * markFlag()与setFlag()不同之处，markFlag涉及事务管理，如果flag表示此次查询失败，需要回滚数据，请使用markFlag()
	 */
	public void setFlag(Long flag) {
		this.flag = flag;
	}
	
	public Long getFlag() {
		return flag;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	

	/**
	 * 根据methodresult设定flag与msg的值。在与第三方交互的时候采用，有利于代码整洁
	 */
	public void markResult(MethodResult methodResult){
		markFlag(methodResult.getResult());
		if(methodResult.getResult() == MethodResult.FAILURE){
			setMsg(methodResult.getResultMsg());
		}
	}

}
