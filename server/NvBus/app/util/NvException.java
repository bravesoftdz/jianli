package util;

public class NvException extends Exception{
	public NvException(String msg) {
		super(msg);
	}
	
	public String getNvMsg(){
		return getMessage();
	}
}
