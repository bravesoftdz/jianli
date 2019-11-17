package controllers.AutoGateService.utils;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import com.sun.org.apache.xml.internal.security.utils.Base64;

/**
 * 
 * @todo
 * @author lck
 */
public class Encryption
{

    /***
     * @author lck 加密算法 加密 解密
     */
    public static final String Encode   = "Encode";

    public static final String Decode   = "Decode";

    public static final String chartset = "UTF-8";

    public static final String key      = "BUSCXBXWFVCH5LK4N1U";
    /**
     * 若返回true为合格票号，否则不合格
     * @param ticketno
     * @param tikstr
     * @return
     */
    public static boolean chkTicketno(String ticketno,String tikstr){
    	if(ticketno==null ||ticketno.length()==0){
    		return false;
    	}
    	if(tikstr==null ||tikstr.length()==0){
    		return false;
    	}
//    	play.Logger.info("ticketno="+ticketno);
        String res = authcodeDecode(tikstr, key);//解密YGHYXCXBXWFVCH5LK4N1UO76BJE20ZRA3S8
//    	play.Logger.info("authcodeDecode res="+res);
        if(ticketno.equals(res)){
             return true;
        }else{
        	 return false;
        }
    	
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
    public static String CutString(final String strParam, final int startIndexParam, final int lengthParam)
    {
        String str = strParam;
        int startIndex = startIndexParam;
        int length = lengthParam;
        if (startIndex >= 0)
        {
            if (length < 0)
            {
                length = length * -1;
                if (startIndex - length < 0)
                {
                    length = startIndex;
                    startIndex = 0;
                }
                else
                {
                    startIndex = startIndex - length;
                }
            }

            if (startIndex > str.length())
            {
                return "";
            }

        }
        else
        {
            if (length < 0)
            {
                return "";
            }
            else
            {
                if (length + startIndex > 0)
                {
                    length = length + startIndex;
                    startIndex = 0;
                }
                else
                {
                    return "";
                }
            }
        }

        if (str.length() - startIndex < length)
        {

            length = str.length() - startIndex;
        }

        return str.substring(startIndex, startIndex + length);
    }

    /**
     * @功能：从字符串的指定位置开始截取到字符串结尾的了符串
     * @param str
     *            :原字符串
     * @param startIndex
     *            :子字符串的起始位置
     * @return:子字符串
     */
    public static String CutString(final String str, final int startIndex)
    {
        return CutString(str, startIndex, str.length());
    }

    /**
     * @功能:返回文件是否存在
     * @param filename
     *            :文件名
     * @return:是否存在
     */
    public static boolean FileExists(final String filename)
    {
        File f = new File(filename);
        return f.exists();
    }

    /**
     * @：功能MD5函数
     * @param str
     *            :原始字符串
     * @return:原始字符串
     * @throws UnsupportedEncodingException
     */
    public static String MD5(final String str) throws UnsupportedEncodingException
    {
        // return md5.convert(str);
        StringBuilder sb = new StringBuilder();
        String part = null;

        MessageDigest md;
        try
        {
            md = MessageDigest.getInstance("MD5");
            byte[] md5 = md.digest(str.getBytes(chartset));

            for (int i = 0; i < md5.length; i++)
            {
                part = Integer.toHexString(md5[i] & 0xFF);
                if (part.length() == 1)
                {
                    part = "0" + part;
                }
                sb.append(part);
            }
        }
        catch (NoSuchAlgorithmException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return sb.toString();
    }

    /**
     * 功能:字段串是否为Null或为
     * 
     * @param str
     * @return
     */
    public static boolean StrIsNullOrEmpty(final String str)
    {
        // #if NET1
        if (str == null || ("").equals(str.trim()))
        {
            return true;
        }

        return false;
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
    private static byte[] GetKey(final byte[] pass, final int kLen)
    {
        byte[] mBox = new byte[kLen];

        for (int i = 0; i < kLen; i++)
        {
            mBox[i] = (byte) i;
        }

        int j = 0;
        for (int i = 0; i < kLen; i++)
        {

            j = (j + (mBox[i] + 256) % 256 + pass[i % pass.length]) % kLen;

            byte temp = mBox[i];
            mBox[i] = mBox[j];
            mBox[j] = temp;
        }

        return mBox;
    }

    /**
     * 功能：生成随机字符
     * 
     * @param lens
     *            :随机字符长度
     * @return:随机字符
     */
    public static String RandomString(final int lens)
    {
        char[] CharArray =
        { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
                'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
        int clens = CharArray.length;
        String sCode = "";
        Random random = new Random();
        for (int i = 0; i < lens; i++)
        {
            sCode += CharArray[Math.abs(random.nextInt(clens))];
        }
        return sCode;
    }

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
    public static String authcodeEncode(final String source, final String key)
    {
        return decipher(source, key, Encode, 0);

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
    private static byte[] RC4(final byte[] input, final String pass) throws UnsupportedEncodingException
    {
        if (input == null || pass == null)
        {
            return null;
        }

        byte[] output = new byte[input.length];
        byte[] mBox = GetKey(pass.getBytes(), 256);

        // 加密
        int i = 0;
        int j = 0;

        for (int offset = 0; offset < input.length; offset++)
        {
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

    public static int toInt(final byte b)
    {
        return (b + 256) % 256;
    }

    public long getUnixTimestamp()
    {
        Calendar cal = Calendar.getInstance();
        return cal.getTimeInMillis() / 1000;
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
    private static String decipher(final String sourceParam,
                                   final String keyParam,
                                   final String operation,
                                   final int expiry)
    {

        try
        {
            String key = keyParam;
            String source = sourceParam;
            if (source == null || key == null)
            {
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

            keyc = ckey_length > 0 ? (operation.equals(Decode) ? CutString(source, 0, ckey_length)
                    : RandomString(ckey_length)) : "";
            cryptkey = keya + MD5(keya + keyc);
            source = "0000000000" + CutString(MD5(source + keyb), 0, 16) + source;

            byte[] temp = RC4(source.getBytes(chartset), cryptkey);

            return keyc + Base64.encode(temp);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return "";
        }
    }

    public static void main(final String[] args) throws UnsupportedEncodingException
    {
        //String key = "ZHGBWXXBXWFVCH5LK4N1UO76BJE20ZRA3S8";//"MYYGCXBXWFVCH5LK4N1UO76BJE20ZRA3S8";
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		Date dep=new Date();
		try {
			dep=df.parse("20160614200944");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    String xml = "888"+dep+"888";
        String reXMl = authcodeEncode(xml, key);//加密
        System.out.println("加密="+reXMl);
        if(reXMl.equals("b32uuw6yEnyhOg4Fzmf1fLq7mvuw5tA/qXWCjWE7+8UBbGVldSQJBFQ/b1A8Zw==")){
            System.out.println("合法");
        }else{
            System.out.println("不合法");
        }
        String reXML = authcodeDecode(reXMl, key);//解密YGHYXCXBXWFVCH5LK4N1UO76BJE20ZRA3S8
        if(reXML.equals(xml)){
            System.out.println("合法");
        }else{
            System.out.println("不合法");
        }
        System.out.println(reXML);
        System.out.println("----");
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
    private static String authcode(final String sourceParam,
                                   final String keyParam,
                                   final String operation,
                                   final int expiry)
    {
        try
        {
            String key = keyParam;
            String source = sourceParam;
            if (source == null || key == null)
            {
                return "";
            }

            int ckey_length = 4;
            String keya = "";
            String keyb = "";
            String keyc = "";
            String cryptkey = "";
            String result = "";

            key = MD5(key);

            keya = MD5(CutString(key, 0, 16));

            keyb = MD5(CutString(key, 16, 16));

            keyc = ckey_length > 0 ? (operation.equals(Decode) ? CutString(source, 0, ckey_length)
                    : RandomString(ckey_length)) : "";
            cryptkey = keya + MD5(keya + keyc);

            if (operation.equals(Decode))
            {
                byte[] temp;

                temp = Base64.decode(CutString(source, ckey_length));
                result = new String(RC4(temp, cryptkey), chartset);
                if (CutString(result, 10, 16).equals(CutString(MD5(CutString(result, 26) + keyb), 0, 16)))
                {
                    return CutString(result, 26);
                }
                else
                {
                    temp = Base64.decode(CutString(source + "=", ckey_length));
                    result = new String(RC4(temp, cryptkey), chartset);
                    if (CutString(result, 10, 16).equals(CutString(MD5(CutString(result, 26) + keyb), 0, 16)))
                    {
                        return CutString(result, 26);
                    }
                    else
                    {
                        temp = Base64.decode(CutString(source + "==", ckey_length));
                        result = new String(RC4(temp, cryptkey), chartset);
                        if (CutString(result, 10, 16).equals(CutString(MD5(CutString(result, 26) + keyb), 0, 16)))
                        {
                            return CutString(result, 26);
                        }
                        else
                        {
                            return "2";
                        }
                    }
                }
            }
            else
            {
                return "加密操作不正确";
            }
        }
        catch (Exception e)
        {
            return "";
        }
    }

    /**
     * @author 
     * @功能：解密算法
     * @param source
     * @param key
     * @param expiry
     * @return
     * @date 20150107
     */
    public static String authcodeDecode(final String source, final String key)
    {
        return authcode(source, key, Decode, 0);

    }
}
