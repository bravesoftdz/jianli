package util;

public class SystemException extends Exception {

	 public int errorCode;

	  public SystemException()
	  {
	  }

	  public SystemException(String paramString)
	  {
	    super(paramString);
	  }

	  public SystemException(int paramInt)
	  {
	    this.errorCode = paramInt;
	  }

	
}
