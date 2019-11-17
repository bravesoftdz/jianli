package cn.nova.bus.encrypt;

import play.Play;
import cn.nova.bus.common.ParamterConst;

import com.bit.utils.BitEncryptUtils;
import com.bit.utils.VersionEnums;

public class BitAnswerEncode {
	
	private static String SN;
	private static String TERM;
	
	
	 static {
		try {
			String paramValue = AuthcodeEncode.getParamValue(ParamterConst.Param_1099);
			SN =Play.configuration.getProperty("application.sn");
			TERM =paramValue;
			play.Logger.info("SN === " + SN);
			play.Logger.info("TERM === " + TERM);
		} catch (RuntimeException e) {
			play.Logger.error("SQL错误");
			throw e;
		}
		if(SN == null || "".equals(SN)){
			throw new RuntimeException("SN为空");
		}
		if(TERM == null || "".equals(TERM)){
			throw new RuntimeException("TERM为空");
		}
	}
	
	
	public static String encode(String source){
		String version = VersionEnums.VERSION_2.getVersion();
		//SN="QQC7HAYFN4ZYRXIN";
		//play.Logger.info("<----------------------------->");
		play.Logger.info("原始数据===》"+source);
		String bitEncode = BitEncryptUtils.bitEncode(SN, TERM, source, version);
		play.Logger.info("加密后===>"+bitEncode);
		return bitEncode;
	}

	public static String decode(String source){
		//play.Logger.info("<----------------------------->");
		play.Logger.info("加密后===》"+source);
		String ss=source.substring(0, 2);
		if(!ss.equals("^@")){			
			return (1+Math.random()*(10))+"";	
		}
		String bitDecode = BitEncryptUtils.bitDecode(SN, TERM, source);
		play.Logger.info("解密后===>"+bitDecode);
		return bitDecode;
	}
	
	public static void test() {
		String source = "^@+EzD7CF0ICGT1UPLjAyJ29eqALs=";
		SN="QQC7HAYFN4ZYRXIN";
		TERM="4";
		String str1 = BitAnswerEncode.decode(source);
		//String str2 = BitAnswerEncode.encode(str1);
		System.out.println(str1);
		//System.out.println(str2);
	}
	
	public static void main(String[] args) {
		String source = "^@+EzD7CF0ICGT1UPLjAyJ29eqALs=";
		SN="QQC7HAYFN4ZYRXIN";
		TERM="4";
		String str1 = BitAnswerEncode.decode(source);
		//String str2 = BitAnswerEncode.encode(str1);
		System.out.println(str1);
		//System.out.println(str2);
	}
}
