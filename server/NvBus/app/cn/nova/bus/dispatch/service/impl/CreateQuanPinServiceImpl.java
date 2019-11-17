package cn.nova.bus.dispatch.service.impl;

import java.util.List;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.dispatch.dao.CreateQuanPinDao;
import cn.nova.bus.dispatch.service.CreateQuanPinService;

public class CreateQuanPinServiceImpl implements CreateQuanPinService {

	private CreateQuanPinDao createQuanPinDao;
	
	@Override
	public void queryDriver() {
		createQuanPinDao = new CreateQuanPinDao();
		List<Driver> list = createQuanPinDao.queryDriver();
		if (list != null && list.size() > 0) {
			for (Driver driver : list) {
				driver.setQuanpin(qryPingYin(driver.getName().trim()).toUpperCase());
				createQuanPinDao.merge(driver);
			}
		}
	}
	
	/**
	 * 根据汉字生成全拼
	 * @param src
	 * @return
	 */
	public static String qryPingYin(String src) {    
        char[] t1 = null;  
        t1 = src.toCharArray();  
        String[] t2 = new String[t1.length];  
        HanyuPinyinOutputFormat t3 = new HanyuPinyinOutputFormat();  
          
        t3.setCaseType(HanyuPinyinCaseType.LOWERCASE);  
        t3.setToneType(HanyuPinyinToneType.WITHOUT_TONE);  
        t3.setVCharType(HanyuPinyinVCharType.WITH_V);  
        String t4 = "";  
        int t0 = t1.length;  
        try {  
            for (int i = 0; i < t0; i++) {  
                // 判断是否为汉字字符  
                if (java.lang.Character.toString(t1[i]).matches(  
                        "[\\u4E00-\\u9FA5]+")) {  
                    t2 = PinyinHelper.toHanyuPinyinStringArray(t1[i], t3);  
                    t4 += t2[0];  
                } else  
                    t4 += java.lang.Character.toString(t1[i]);  
            }  
            // System.out.println(t4);  
            return t4;  
        } catch (BadHanyuPinyinOutputFormatCombination e1) {  
            e1.printStackTrace();  
        }  
        return t4;  
    }  

}
