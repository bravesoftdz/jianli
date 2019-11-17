package models;


/**
 * 通用的返回结果
 * 
 */
public class Result {
	private boolean success; // 是否成功
	private String message; // 附加信息

	public Result() {
	}

	public Result(boolean success, String message) {
		super();
		this.success = success;
		this.message = message;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
