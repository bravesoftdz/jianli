package util;

import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
/**
 * Created by Administrator on 2017-07-24.
 */
public class NewDESUtil {
//    private static final String Key = "bus36501";
    private static final String Algorithm = "DES";  //定义 加密算法,可用 DES,DESede,Blowfish
    // 加密字符串
    public static String desCrypto(String src, String keyStr) {
        String hexStr = "";
        try {
            Cipher c1 = Cipher.getInstance("DES/ECB/NoPadding");
            SecretKey key = new SecretKeySpec(keyStr.getBytes(), Algorithm);//生成加密解密需要的Key
            c1.init(Cipher.ENCRYPT_MODE, key);
            byte[] bytes = c1.doFinal(getByte(src));
//            String strs = new BASE64Encoder().encode(bytes).replace("\n", "").replace("\r", "");
//            System.out.println("转base64："+ strs);
            hexStr = bytesToHexString(bytes);
        } catch (java.security.NoSuchAlgorithmException e1) {
            e1.printStackTrace();
        } catch (javax.crypto.NoSuchPaddingException e2) {
            e2.printStackTrace();
        } catch (java.lang.Exception e3) {
            e3.printStackTrace();
        }
        return hexStr;
    }
    //解密字符串
    public static String decrypt(String hexStr, String keyStr) {
        String src = "";
        try {
            Cipher c1 = Cipher.getInstance("DES/ECB/NoPadding");
            SecretKey deskey = new SecretKeySpec(keyStr.getBytes(), Algorithm);//生成加密解密需要的Key
            c1.init(Cipher.DECRYPT_MODE , deskey);
            byte[] bytes = c1.doFinal(hexString2Bytes(hexStr));
            src = new String(bytes).trim();
        }catch (java.security.NoSuchAlgorithmException e1) {
            e1.printStackTrace();
        }catch (javax.crypto.NoSuchPaddingException e2) {
            e2.printStackTrace();
        }catch (java.lang.Exception e3) {
            e3.printStackTrace();
        }
        return src;
    }
    public static String bytesToHexString(byte[] digestByte) {
        byte[] rtChar = new byte[digestByte.length * 2];
        for (int i = 0; i < digestByte.length; i++) {
            byte b1 = (byte) (digestByte[i] >> 4 & 0x0f);
            byte b2 = (byte) (digestByte[i] & 0x0f);
            rtChar[i * 2] = (byte) (b1 < 10 ? b1 + 48 : b1 + 55);
            rtChar[i * 2 + 1] = (byte) (b2 < 10 ? b2 + 48 : b2 + 55);
        }
        return new String(rtChar).toUpperCase();
    }
    public static byte[] getByte(String szSrc){
        int length = szSrc.length();
        int a = length % 8;
        int b = length / 8;
        int len = 0;
        if (a == 0){
            len = b*8;
        }else{
            len = (b+1)*8;
        }
        byte[] src = new byte[len];
        byte[] bytes = szSrc.getBytes();
        for (int i = 0;i<bytes.length;i++){
            src[i] = bytes[i];
        }
        return src;
    }
    public static byte[] hexString2Bytes(String src) {
        int len = src.length();
        byte[] ret = new byte[len/2];
        byte[] tmp = src.getBytes();
        for(int i=0; i<len/2; ++i )
        {
            ret[i] = uniteBytes(tmp[i*2], tmp[i*2+1]);
        }
        return ret;
    }
    private static byte uniteBytes(byte src0, byte src1) {
        byte _b0 = Byte.decode("0x" + new String(new byte[]{src0})).byteValue();
        _b0 = (byte) (_b0 << 4);
        byte _b1 = Byte.decode("0x" + new String(new byte[]{src1})).byteValue();
        byte ret = (byte) (_b0 | _b1);
        return ret;
    }
    public static String generateEncrypt(String datasourcestr, String key){
        return desCrypto(datasourcestr, key);
    }
    public static void main(String[] args){
        //000002970608
        //192.168.20.245989710000002970608|END
        //192.168.20.245|9897|1|0|000002970607|||dsfadsfdsfdsfdsa|END
        //166v5070e7.iask.in1568510000002970608
        //166v5070e7.iask.in:15685
        //166v5070e7.iask.in15685010000002970608
        //166v5070e7.iask.in|15685|01|0|000002970608|||
        //A02FCE5A83375FA3BE465BA7BB5DBA71D1A7F8DC3FD84F21AD28A11AF5422A032BD5FD094234E54C277B8E9477E64F62|END
        //192.168.20.100|9898|1|2|1832811716|||C335A59B475A8104295989564B006A28365221F97CDDFDA24783A57318E0F695|END
//        System.out.println("密码："+Key);
        String szSrc = "127.0.0.1989811420114199211085159";
        System.out.println("加密前的字符串:" + szSrc);
        String s = generateEncrypt(szSrc, "bus36501");
        System.out.println("加密后的字符串:" + s);
//        String s1 = NewDESUtil.generateEncrypt(szSrc, "bus36501");
//        System.out.println("解密后的字符串:" + s1);
    }
}