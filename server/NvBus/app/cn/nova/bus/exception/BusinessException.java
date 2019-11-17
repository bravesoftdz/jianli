/**
 * 
 */
package cn.nova.bus.exception;

/**
 * @author ice
 *
 */
public class BusinessException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	private String code;
	
	public BusinessException(String code,String msg){
		super(msg);
		setCode(code);
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public BusinessException(String msg){
		super(msg);
	}
}
