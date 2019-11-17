package util;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

public class DESUtil {
	
    /**
     * 加密
     * 
     * @param datasource 数据源
     * @param password  加密密码
     *  DES加密和解密过程中，密钥长度都必须是8的倍数
     * @return
     */
    public static byte[] desCrypto(byte[] datasource, String password) {
            try {           
                    SecureRandom secureRandom = new SecureRandom();
                    DESKeySpec deskey = new DESKeySpec(password.getBytes());
                    // 创建密钥工厂
                    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
                    SecretKey secretKey = keyFactory.generateSecret(deskey);
                    
                    Cipher cipher = Cipher.getInstance("DES");// 创建密码器
                    
                    cipher.init(Cipher.ENCRYPT_MODE, secretKey,secureRandom);// 用密钥初始化
                    //获取数据并加密
                    return cipher.doFinal(datasource);
            } catch (IllegalBlockSizeException e) {
                    e.printStackTrace();
            } catch (BadPaddingException e) {
                    e.printStackTrace();
            } catch (InvalidKeySpecException e) {
					e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
			} catch (NoSuchPaddingException e) {
					e.printStackTrace();
			} catch (InvalidKeyException e) {
					e.printStackTrace();
			}
            return null;
    }
    
    
    /**解密
     * @param src  待解密源
     * @param password 解密密钥
     * @return
     */
    public static byte[] decrypt(byte[] src, String password) {
            try {
            		 // DES算法要求有一个可信任的随机数源
            		 SecureRandom  secureRandom = new SecureRandom();
            		 //创建一个DESKeySpec对象
            		 DESKeySpec deskey = new DESKeySpec(password.getBytes());
            		 
            		 SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            		 SecretKey secretKey = keyFactory.generateSecret(deskey);
            		 
            		 Cipher cipher = Cipher.getInstance("DES");// 创建密码器
                     cipher.init(Cipher.DECRYPT_MODE, secretKey,secureRandom);// 初始化
                     //解密
                     return cipher.doFinal(src);
            } catch (NoSuchAlgorithmException e) {
                    e.printStackTrace();
            } catch (NoSuchPaddingException e) {
                    e.printStackTrace();
            } catch (InvalidKeyException e) {
                    e.printStackTrace();
            } catch (IllegalBlockSizeException e) {
                    e.printStackTrace();
            } catch (BadPaddingException e) {
                    e.printStackTrace();
            } catch (InvalidKeySpecException e) {
				e.printStackTrace();
			}
            return null;
    }
    /**将二进制转换成16进制
     * @param buf
     * @return
     */
    public static String parseByte2HexStr(byte buf[]) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < buf.length; i++) {
                    String hex = Integer.toHexString(buf[i] & 0xFF);
                    if (hex.length() == 1) {
                            hex = '0' + hex;
                    }
                    sb.append(hex.toUpperCase());
            }
            return sb.toString();
    }
    public static String generateEncrypt(String datasourcestr,String password)throws Exception{
    	
		byte[] encryptResult = desCrypto(datasourcestr.getBytes(),password);
		String encryptResultStr = parseByte2HexStr(encryptResult);
		return encryptResultStr;
    }
    public static void main(String[] args) {
    	//待加密内容  
    	String str = "测试内容";
    	//密码，长度要是8的倍数  
    	String password = "bus36501";
    	String result = null;
		try {
			result = DESUtil.generateEncrypt(str, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	System.out.println("加密后内容为："+(result));
	}
}
