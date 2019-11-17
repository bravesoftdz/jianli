/**
 * MD5
 * <p>Description: 不可逆加密算法 </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: Nova</p>
 * @author
 * @version 1.0
 */

package cn.nova.bus.encrypt;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base32;

import sun.misc.BASE64Encoder;

public class MD5 {
	private final static String ALGORITHM = "MD5";

	private static MessageDigest md = null;

	/**
	 * Can't make these: all the methods are static
	 */
	private MD5() {
	}

	public static String HEXAndMd5(String plainText) {  
		   try {  
		     MessageDigest md = MessageDigest.getInstance("MD5");  
		     try {  
		       md.update(plainText.getBytes("UTF8"));  
		     } catch (UnsupportedEncodingException e) {  
		       e.printStackTrace();  
		     }  
		     byte b[] = md.digest();  
		     int i;  
		     StringBuffer buf = new StringBuffer(200);  
		     for (int offset = 0; offset < b.length; offset++) {  
		       i = b[offset] & 0xff;  
		       if (i < 16) buf.append("0");  
		       buf.append(Integer.toHexString(i));  
		     }  
		     return buf.toString();  
		   } catch (NoSuchAlgorithmException e) {  
		     return null;  
		   }  
		 }     
	public static void main(String[] args) {
		try {
			/*MessageDigest md5=MessageDigest.getInstance("MD5");
	        BASE64Encoder base64en = new BASE64Encoder();
	        Base32 base32 = new Base32();*/
	        String str = "220100007黄河站点吉林省吉林市永吉县客运中心站(黄河路站)BUS365!@#";
	        //str = new StringBuffer(str).reverse().toString();
	        System.out.println(HEXAndMd5(str));
	        //System.out.println(cryptPassword(str));
	        /*md5.digest(str.getBytes("utf-8"));
	        char[] newstr=hexDump(md5.digest(str.getBytes("utf-8")));
	        
			System.out.println(base32.encode(newstr));*/
		} catch (Exception ex) {
		}
	}

	/**
	 * Turn a byte array into a char array containing a printable hex
	 * representation of the bytes. Each byte in the source array contributes a
	 * pair of hex digits to the output array.
	 * 
	 * @param src
	 *            the source array
	 * @return a char array containing a printable version of the source data
	 */
	private static char[] hexDump(byte src[]) {
		char buf[] = new char[src.length * 2];
		for (int b = 0; b < src.length; b++) {
			String byt = Integer.toHexString(src[b] & 0xFF);
			if (byt.length() < 2) {
				buf[b * 2 + 0] = '0';
				buf[b * 2 + 1] = byt.charAt(0);
			} else {
				buf[b * 2 + 0] = byt.charAt(0);
				buf[b * 2 + 1] = byt.charAt(1);
			}
		}
		return buf;
	}

	/**
	 * Zero the contents of the specified array. Typically used to erase
	 * temporary storage that has held plaintext passwords so that we don't
	 * leave them lying around in memory.
	 * 
	 * @param pwd
	 *            the array to zero
	 */
	// 该方法暂时不用 del by lck 20100706
	/*
	 * private static void smudge(char pwd[]) {
	 * 
	 * if (null != pwd) { for (int b = 0; b < pwd.length; b++) { pwd[b] = 0; } }
	 * }
	 */

	/**
	 * Zero the contents of the specified array.
	 * 
	 * @param pwd
	 *            the array to zero
	 */
	private static void smudge(byte pwd[]) {
		if (null != pwd) {
			for (int b = 0; b < pwd.length; b++) {
				pwd[b] = 0;
			}
		}
	}

	/**
	 * Perform MD5 hashing on the supplied password and return a char array
	 * containing the encrypted password as a printable string. The hash is
	 * computed on the low 8 bits of each character.
	 * 
	 * @param password
	 *            The password to encrypt
	 * @throws Exception
	 * @return a character array containing a 32 character String hex encoded
	 *         MD5 hash of the password
	 */
	public static char[] cryptPassword(String password) {
		char pwd[] = password.toCharArray();
		if (null == md) {
			try {
				md = MessageDigest.getInstance(ALGORITHM);
			} catch (NoSuchAlgorithmException e) {
				//加密出错
				play.Logger.error(e.getMessage(), e);
			}
		}
		md.reset();
		byte pwdb[] = new byte[pwd.length];
		for (int b = 0; b < pwd.length; b++) {
			pwdb[b] = (byte) pwd[b];
		}
		char crypt[] = hexDump(md.digest(pwdb));
		smudge(pwdb);
		return crypt;
	}

}
