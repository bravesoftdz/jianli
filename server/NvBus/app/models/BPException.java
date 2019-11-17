/**
 * 
 */
package models;

import play.i18n.Messages;

/**
 * @description
 * @author lxh
 * 2013年12月18日
 */
public class BPException extends Exception {
	
	private String ecode;
	
	private Throwable e;
	
	
	public BPException(String message){
		super(message);
	}

	public BPException(String ecode, String message){
		super(message);
		this.ecode = ecode;
	}
	
	
	public BPException(String ecode , Throwable e){
		super(ecode,e);
		this.ecode = ecode;
		this.e = e;
	}
	/**
	 * @return the ecode
	 */
	public String getEcode() {
		return ecode;
	}

	/**
	 * @param ecode the ecode to set
	 */
	public void setEcode(String ecode) {
		this.ecode = ecode;
	}

	/**
	 * @return the e
	 */
	public Throwable getE() {
		return e;
	}

	/**
	 * @param e the e to set
	 */
	public void setE(Throwable e) {
		this.e = e;
	}
	
	@Override
	public void printStackTrace() {
		if(e == null){
			super.printStackTrace();
		}else{
			play.Logger.error(e.getMessage(), e);
		}
	}
	
	
}
