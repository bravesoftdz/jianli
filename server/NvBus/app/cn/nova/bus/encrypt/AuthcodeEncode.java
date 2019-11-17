package cn.nova.bus.encrypt;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import com.sun.org.apache.xml.internal.security.utils.Base64;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.system.dao.ParameterDao;
import util.Encryption;

public class AuthcodeEncode {

	/***
	 * @author lck 加密算法 加密 解密
	 */
	public static final String Encode = "Encode";

	public static final String Decode = "Decode";

	public static final String chartset = "UTF-8";

	public static final String key = "BUSCXBXWFVCH5LK4N1U";

	/**
	 * @author
	 * @功能：加密算法
	 * @param source
	 *            ：需要解密的字符串
	 * @param key
	 *            ：加密的秘钥
	 * @param expiry
	 * @return
	 * @date 20150107
	 */
	public static String authcodeEncode(final String source) {
		String paramValue = getParamValue(ParamterConst.Param_1098);
		if("1".equals(paramValue)){
			return BitAnswerEncode.encode(source);
		}else{
			return decipher(source, key, Encode, 0);
		}
		
	}

	public static String getParamValue(String param) {
		// TODO Auto-generated method stub
		return new ParameterDao().findParamValue(param, null);
	}

	/**
	 * @功能：从字符串的指定位置截取指定长度的子字符串
	 * @param str
	 *            :原字符串
	 * @param startIndex
	 *            :子字符串的起始位置
	 * @param length
	 * @return:子字符串
	 */
	public static String CutString(final String strParam, final int startIndexParam, final int lengthParam) {
		String str = strParam;
		int startIndex = startIndexParam;
		int length = lengthParam;
		if (startIndex >= 0) {
			if (length < 0) {
				length = length * -1;
				if (startIndex - length < 0) {
					length = startIndex;
					startIndex = 0;
				} else {
					startIndex = startIndex - length;
				}
			}

			if (startIndex > str.length()) {
				return "";
			}

		} else {
			if (length < 0) {
				return "";
			} else {
				if (length + startIndex > 0) {
					length = length + startIndex;
					startIndex = 0;
				} else {
					return "";
				}
			}
		}

		if (str.length() - startIndex < length) {

			length = str.length() - startIndex;
		}

		return str.substring(startIndex, startIndex + length);
	}

	/**
	 * @：功能MD5函数
	 * @param str
	 *            :原始字符串
	 * @return:原始字符串
	 * @throws UnsupportedEncodingException
	 */
	public static String MD5(final String str) throws UnsupportedEncodingException {
		// return md5.convert(str);
		StringBuilder sb = new StringBuilder();
		String part = null;

		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			byte[] md5 = md.digest(str.getBytes(chartset));

			for (int i = 0; i < md5.length; i++) {
				part = Integer.toHexString(md5[i] & 0xFF);
				if (part.length() == 1) {
					part = "0" + part;
				}
				sb.append(part);
			}
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return sb.toString();
	}

	/**
	 * 功能：生成随机字符
	 * 
	 * @param lens
	 *            :随机字符长度
	 * @return:随机字符
	 */
	public static String RandomString(final int lens) {
		char[] CharArray = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
				't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
		int clens = CharArray.length;
		String sCode = "";
		Random random = new Random();
		for(int i = 0; i < lens; i++) {
			sCode += CharArray[Math.abs(random.nextInt(clens))];
		}
		return sCode;
	}

	/**
	 * @param source
	 *            :原始字符串
	 * @param key
	 *            ：秘钥
	 * @param operation
	 *            ：加解密操作
	 * @param expiry
	 *            ：加密字串过期时间
	 * @return：加密后的字符串
	 */
	private static String decipher(final String sourceParam, final String keyParam, final String operation,
			final int expiry) {

		try {
			String key = keyParam;
			String source = sourceParam;
			if (source == null || key == null) {
				return "";
			}

			int ckey_length = 4;
			String keya = "";
			String keyb = "";
			String keyc = "";
			String cryptkey = "";
			// String result = "";

			key = MD5(key);

			keya = MD5(CutString(key, 0, 16));

			keyb = MD5(CutString(key, 16, 16));

			keyc = ckey_length > 0
					? (operation.equals(Decode) ? CutString(source, 0, ckey_length) : RandomString(ckey_length)) : "";
			cryptkey = keya + MD5(keya + keyc);
			source = "0000000000" + CutString(MD5(source + keyb), 0, 16) + source;

			byte[] temp = RC4(source.getBytes(chartset), cryptkey);

			return keyc + Base64.encode(temp);
		} catch (Exception e) {
			play.Logger.info("---------------售票加密失败！---------------");
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * 功能:RC4 原始算法
	 * 
	 * @param input
	 *            :原始字串数组
	 * @param pass
	 *            :密钥
	 * @return:处理后的字串数组
	 * @throws UnsupportedEncodingException
	 */
	private static byte[] RC4(final byte[] input, final String pass) throws UnsupportedEncodingException {
		if (input == null || pass == null) {
			return null;
		}

		byte[] output = new byte[input.length];
		byte[] mBox = GetKey(pass.getBytes(), 256);

		// 加密
		int i = 0;
		int j = 0;

		for (int offset = 0; offset < input.length; offset++) {
			i = (i + 1) % mBox.length;
			j = (j + (mBox[i] + 256) % 256) % mBox.length;

			byte temp = mBox[i];
			mBox[i] = mBox[j];
			mBox[j] = temp;
			byte a = input[offset];

			// byte b = mBox[(mBox[i] + mBox[j] % mBox.Length) % mBox.Length];
			// mBox[j] 一定比 mBox.Length 小，不需要在取模
			byte b = mBox[(toInt(mBox[i]) + toInt(mBox[j])) % mBox.length];

			output[offset] = (byte) (a ^ toInt(b));
		}

		return output;
	}

	public static int toInt(final byte b) {
		return (b + 256) % 256;
	}

	/**
	 * 功能：用于 RC4 处理密码
	 * 
	 * @param pass
	 *            :密码字串
	 * @param kLen
	 *            :>密钥长度，一般为 256
	 * @return
	 */
	private static byte[] GetKey(final byte[] pass, final int kLen) {
		byte[] mBox = new byte[kLen];

		for (int i = 0; i < kLen; i++) {
			mBox[i] = (byte) i;
		}

		int j = 0;
		for (int i = 0; i < kLen; i++) {

			j = (j + (mBox[i] + 256) % 256 + pass[i % pass.length]) % kLen;

			byte temp = mBox[i];
			mBox[i] = mBox[j];
			mBox[j] = temp;
		}

		return mBox;
	}
}
