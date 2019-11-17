package util;

import java.math.BigDecimal;


public class AppContrast {
	public static final int TURE = 1;
	public static final int FALSE = 0;
	
	//表单类型
	public static final int FORM_FILE = 1;
	public static final int FORM_RECEIPT = 2;
	public static final int FORM_QUERY= 3;
	
	//表单组件
	public static final int INPUT_TEXT = 1;
	public static final int INPUT_NUMBER = 2;
	public static final int INPUT_HIDDEN = 3;
	public static final int INPUT_TEXTAREA = 4;
	public static final int INPUT_SELECT = 5;
	public static final int INPUT_CHECKBOX = 6;
	public static final int INPUT_DATE = 7;
	public static final int INPUT_COMBO = 8;
	public static final int INPUT_PASSWORD = 9;
	public static final int INPUT_DIGITSELECT = 10;
	
	public static final String PRINT_DEFAULT_FONT_NAME = "宋体";
	public static final BigDecimal PRINT_DEFAULT_FONT_SIZE = new BigDecimal(11);
	public static final int PRINT_DEFAULT_CHARACTER_WIDTH = 40;   //单位0.1毫米
	public static final int PRINT_DEFAULT_CHARACTER_HEIGHT = 40;   //单位0.1毫米
	public static final int PRINT_DEFAULT_ROW_SPACE = 40;   //单位0.1毫米
	public static final int PRINT_DEFAULT_WORD_SPACE = 40;   //单位0.1毫米
	
	public static final String PRINT_OPER_DELETE = "2";
	public static final String PRINT_OPER_ADD = "4";
	public static final String PRINT_OPER_MODIFY = "8";

}
