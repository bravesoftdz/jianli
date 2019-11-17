package util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.slf4j.LoggerFactory;

/**
 * 
 * @author lanckun
 * @function 日期计算工具
 */
public class DateUtils {
	private static org.slf4j.Logger log = LoggerFactory.getLogger(DateUtils.class);
	public final static String yyyy_MM_dd = "yyyy-MM-dd";
	public final static String yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss";
	public final static String yyyy_MM_dd_HH_mm_ss_SSS = "yyyy-MM-dd HH:mm:ss.SSS";
	public final static String yyyyMMdd = "yyyyMMdd";
	/**
	 * 日期转换成字符串
	 * 
	 * @param date
	 * @return str
	 */
	public static String DateToStr(Date date) {

		SimpleDateFormat format = new SimpleDateFormat(yyyy_MM_dd);
		String str = format.format(date);
		return str;
	}

	/**
	 * 字符串转换成日期
	 * 
	 * @param str
	 * @return date
	 */
	public static Date strToDate(String str) {

		SimpleDateFormat format = new SimpleDateFormat(yyyy_MM_dd);
		Date date = null;
		try {
			date = format.parse(str);
		} catch (ParseException e) {
		}
		return date;
	}

	/**
	 * 转成日期yyyy-MM-dd-HH-mm-ss-SSS 格式日期
	 * 
	 * @param str
	 * @return
	 */
	public static Date strToDateTime(String str) {

		SimpleDateFormat format = new SimpleDateFormat(yyyy_MM_dd_HH_mm_ss_SSS);
		Date date = null;
		try {
			date = format.parse(str);
		} catch (ParseException e) {
		}
		return date;
	}
	/**
	 * 转成日期yyyy-MM-dd-HH-mm-ss 格式日期
	 * 
	 * @param str
	 * @return
	 */
	public static Date strToDateTimeNosss(String str) {

		SimpleDateFormat format = new SimpleDateFormat(yyyy_MM_dd_HH_mm_ss);
		Date date = null;
		try {
			date = format.parse(str);
		} catch (ParseException e) {
		}
		return date;
	}
	/**
	 * 格式出输出为yyyy-MM-dd
	 * 
	 * @param date
	 * @return
	 */
	public static String formatDate(Date date) {
		SimpleDateFormat sf = new SimpleDateFormat(yyyy_MM_dd);
		return sf.format(date);
	}

	/**
	 * 格式出输出为yyyy-MM-dd HH:mm:ss
	 * 
	 * @param date
	 * @return
	 */
	public static String formatDatetime(Date date) {
		SimpleDateFormat sf = new SimpleDateFormat(yyyy_MM_dd_HH_mm_ss);
		return sf.format(date);
	}

	/**
	 * 返回自定义格式日期时间字符串
	 * 
	 * @param format
	 *            日期时间格式
	 * @return
	 */
	public static String formatDatetime(Date date, String format) {
		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(date);
	}

	/**
	 * 求两个日期之间相隔的天数<br>
	 * 
	 * @param startday
	 *            ,endday
	 * @return 间隔天数
	 */
	public static int getIntervalDays(Date startday, Date endday) {
		if (startday.after(endday)) {
			Date cal = startday;
			startday = endday;
			endday = cal;
		}
		long sl = startday.getTime();
		long el = endday.getTime();
		long ei = el - sl;
		return (int) (ei / (1000 * 60 * 60 * 24));
	}

	/**
	 * 获取当前日期对应的星期<br>
	 * 
	 * @param date
	 * @return 当前日期是星期几
	 */
	public static int getCurWeekDay(Date date) {
		GregorianCalendar cale = new GregorianCalendar(); // 格里高利日历
		cale.setTime(date); // 绑定当前日期
		return cale.get(Calendar.DAY_OF_WEEK);
	}
	public static String DateToStrNoAcross(Date date) {

		SimpleDateFormat format = new SimpleDateFormat(yyyyMMdd);
		String str = format.format(date);
		return str;
	}
	/**
	 * 获取当前日期是星期几<br>
	 * 
	 * @param dt
	 * @return 当前日期是星期几
	 */
	public static String getWeekOfDate(Date dt) {
		String[] weekDays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0)
			w = 0;
		return weekDays[w];
	}

	/**
	 * // 让日期加n<br>
	 * 
	 * @param dt
	 * @return 日期
	 */
	public static Date add(Date dt, int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dt);
		calendar.add(Calendar.DAY_OF_MONTH, n);
		return calendar.getTime();
	}

	/**
	 * // 让日期加n<br>
	 * 
	 * @param dt
	 * @return 日期
	 */
	public static Date add(Date dt, Long n) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dt);
		calendar.add(Calendar.DAY_OF_MONTH, n.intValue());
		return calendar.getTime();
	}

	/**
	 * 让日期加n type(年/月/日)
	 * 
	 * @param dt
	 * @param addtype
	 *            要加的类型(年/月/日)
	 * @return 日期
	 */
	public static Date add(Date dt, int addtype, int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dt);
		calendar.add(addtype, n);
		return calendar.getTime();
	}

	/**
	 * // 获取指定日期所在月的总天数<br>
	 * 
	 * @param dt
	 * @return 一个月总共有多少天 author qjw time 2011-04-25
	 */
	public static int getMonth_Date(Date dt) {
		// SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		// Date date = format.parse(dt);
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(dt);
		// System.out.println("qjw="+calendar.getActualMaximum(Calendar.DAY_OF_MONTH));

		return calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 获取该日期的号数<br>
	 * 
	 * @param dt
	 * @return
	 */
	public static String getDay(Date dt) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(dt);
		return String.valueOf(cld.get(Calendar.DAY_OF_MONTH));
	}

	final static long[] lunarInfo = new long[] { 0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2, 0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977, 0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7,
			0x0c950, 0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950, 0x06aa0, 0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6, 0x095b0, 0x049b0,
			0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570, 0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5, 0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60,
			0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530, 0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0 };

	final public static int lYearDays(int y)// ====== 传回农历 y年的总天数
	{
		int i, sum = 348;
		for (i = 0x8000; i > 0x8; i >>= 1) {
			if ((lunarInfo[y - 1900] & i) != 0)
				sum += 1;
		}
		return (sum + leapDays(y));
	}

	final public static int leapDays(int y)// ====== 传回农历 y年闰月的天数
	{
		if (leapMonth(y) != 0) {
			if ((lunarInfo[y - 1900] & 0x10000) != 0)
				return 30;
			else
				return 29;
		} else
			return 0;
	}

	final public static int leapMonth(int y)// ====== 传回农历 y年闰哪个月 1-12 , 没闰传回 0
	{
		return (int) (lunarInfo[y - 1900] & 0xf);
	}

	final public static int monthDays(int y, int m)// ====== 传回农历 y年m月的总天数
	{
		if ((lunarInfo[y - 1900] & (0x10000 >> m)) == 0)
			return 29;
		else
			return 30;
	}

	@SuppressWarnings("deprecation")
	final public long[] Lunar(int y, int m)// 传出农历.year0 .month1 .day2 .yearCyl3
											// .monCyl4
	// .dayCyl5 .isLeap6
	{
		final int[] year20 = new int[] { 1, 4, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1 };
		final int[] year19 = new int[] { 0, 3, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0 };
		final int[] year2000 = new int[] { 0, 3, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1 };
		long[] nongDate = new long[7];
		int i = 0, temp = 0, leap = 0;
		Date baseDate = new Date(1900, 1, 31);
		Date objDate = new Date(y, m, 1);
		long offset = (objDate.getTime() - baseDate.getTime()) / 86400000L;
		if (y < 2000)
			offset += year19[m - 1];
		if (y > 2000)
			offset += year20[m - 1];
		if (y == 2000)
			offset += year2000[m - 1];
		nongDate[5] = offset + 40;
		nongDate[4] = 14;

		for (i = 1900; i < 2050 && offset > 0; i++) {
			temp = lYearDays(i);
			offset -= temp;
			nongDate[4] += 12;
		}
		if (offset < 0) {
			offset += temp;
			i--;
			nongDate[4] -= 12;
		}
		nongDate[0] = i;
		nongDate[3] = i - 1864;
		leap = leapMonth(i); // 闰哪个月
		nongDate[6] = 0;

		for (i = 1; i < 13 && offset > 0; i++) {
			// 闰月
			if (leap > 0 && i == (leap + 1) && nongDate[6] == 0) {
				--i;
				nongDate[6] = 1;
				temp = leapDays((int) nongDate[0]);
			} else {
				temp = monthDays((int) nongDate[0], i);
			}

			// 解除闰月
			if (nongDate[6] == 1 && i == (leap + 1))
				nongDate[6] = 0;
			offset -= temp;
			if (nongDate[6] == 0)
				nongDate[4]++;
		}

		if (offset == 0 && leap > 0 && i == leap + 1) {
			if (nongDate[6] == 1) {
				nongDate[6] = 0;
			} else {
				nongDate[6] = 1;
				--i;
				--nongDate[4];
			}
		}
		if (offset < 0) {
			offset += temp;
			--i;
			--nongDate[4];
		}
		nongDate[1] = i;
		nongDate[2] = offset + 1;
		return nongDate;
	}

	@SuppressWarnings("deprecation")
	final public static long[] calElement(int y, int m, int d)
	// 传出y年m月d日对应的农历.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
	{
		long[] nongDate = new long[7];
		int i = 0, temp = 0, leap = 0;
		Date baseDate = new Date(0, 0, 31);
		Date objDate = new Date(y - 1900, m - 1, d);
		long offset = (objDate.getTime() - baseDate.getTime()) / 86400000L;
		nongDate[5] = offset + 40;
		nongDate[4] = 14;

		for (i = 1900; i < 2050 && offset > 0; i++) {
			temp = lYearDays(i);
			offset -= temp;
			nongDate[4] += 12;
		}
		if (offset < 0) {
			offset += temp;
			i--;
			nongDate[4] -= 12;
		}
		nongDate[0] = i;
		nongDate[3] = i - 1864;
		leap = leapMonth(i); // 闰哪个月
		nongDate[6] = 0;

		for (i = 1; i < 13 && offset > 0; i++) {
			// 闰月
			if (leap > 0 && i == (leap + 1) && nongDate[6] == 0) {
				--i;
				nongDate[6] = 1;
				temp = leapDays((int) nongDate[0]);
			} else {
				temp = monthDays((int) nongDate[0], i);
			}

			// 解除闰月
			if (nongDate[6] == 1 && i == (leap + 1))
				nongDate[6] = 0;
			offset -= temp;
			if (nongDate[6] == 0)
				nongDate[4]++;
		}

		if (offset == 0 && leap > 0 && i == leap + 1) {
			if (nongDate[6] == 1) {
				nongDate[6] = 0;
			} else {
				nongDate[6] = 1;
				--i;
				--nongDate[4];
			}
		}
		if (offset < 0) {
			offset += temp;
			--i;
			--nongDate[4];
		}
		nongDate[1] = i;
		nongDate[2] = offset + 1;
		return nongDate;
	}

	public static String getchina(int day) {
		String a = "";
		if (day == 10)
			return "初十";
		int two = (int) ((day) / 10);
		if (two == 0)
			a = "初";
		if (two == 1)
			a = "十";
		if (two == 2)
			a = "廿";
		if (two == 2)
			a = "卅";
		int one = (int) (day % 10);
		switch (one) {
		case 1:
			a += "一";
			break;
		case 2:
			a += "二";
			break;
		case 3:
			a += "三";
			break;
		case 4:
			a += "四";
			break;
		case 5:
			a += "五";
			break;
		case 6:
			a += "六";
			break;
		case 7:
			a += "七";
			break;
		case 8:
			a += "八";
			break;
		case 9:
			a += "九";
			break;
		}
		return a;
	}

	public static String getchinaNum(int day) {
		String a = "";
		if (day == 10)
			return "初十";
		int two = (int) ((day) / 10);
		if (two == 0)
			a = "初";
		if (two == 1)
			a = "十";
		if (two == 2)
			a = "廿";
		if (two == 2)
			a = "卅";
		int one = (int) (day % 10);
		switch (one) {
		case 1:
			a += "一";
			break;
		case 2:
			a += "二";
			break;
		case 3:
			a += "三";
			break;
		case 4:
			a += "四";
			break;
		case 5:
			a += "五";
			break;
		case 6:
			a += "六";
			break;
		case 7:
			a += "七";
			break;
		case 8:
			a += "八";
			break;
		case 9:
			a += "九";
			break;
		}
		return a;
	}

	/**
	 * 根据公历日期计算农历日历<br>
	 * 
	 * @param dt
	 * @return 10
	 */
	public static String getLunar(Date date) {
		Calendar cld = Calendar.getInstance();
		cld.setTime(date);
		int year = cld.get(Calendar.YEAR);
		int month = cld.get(Calendar.MONTH) + 1;
		int day = cld.get(Calendar.DAY_OF_MONTH);
		long[] lunar = calElement(year, month, day);
		// return getchina((int) (lunar[2]));
		return String.valueOf(lunar[2]);
	}

//	// 传出y年m月d日对应的农历.year0 .month1 .day2 .yearCyl3 .monCyl4 .dayCyl5 .isLeap6
//	public static void main(String[] args) throws ParseException {
//		// DateUtils ss = new DateUtils();
//		// String source = "2011-04-03";
//		// SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//		// Date date = format.parse(source);
//		// ss.getMonth_Date(date);
//		for (int i = 0; i < 10; i++) {
//
//		}
//
//		Calendar cld = Calendar.getInstance();
//		Calendar cld2 = Calendar.getInstance();
//		try {
//			Date date1 = new SimpleDateFormat("HH:mm").parse("06:20");
//			Date date2 = new SimpleDateFormat("HH:mm").parse("19:20");
//			cld.setTime(date1);
//			int hour1 = cld.get(Calendar.HOUR_OF_DAY);
//			System.out.println(hour1);
//			int minute1 = cld.get(Calendar.MINUTE);
//			minute1 = hour1 * 60 + minute1;
//			System.out.println(minute1);
//			cld2.setTime(date2);
//			int hour2 = cld2.get(Calendar.HOUR_OF_DAY);
//			System.out.println(hour2);
//			int minute2 = cld2.get(Calendar.MINUTE);
//			minute2 = hour2 * 60 + minute2;
//			System.out.println(minute2);
//			System.out.println(minute2 - minute1);
//		} catch (ParseException e) {
//		}

		/*
		 * Calendar cld = Calendar.getInstance(); int year =
		 * cld.get(Calendar.YEAR); int month = cld.get(Calendar.MONTH) + 1; int
		 * day = cld.get(Calendar.DAY_OF_MONTH); String week = ""; long[] l =
		 * calElement(year, month, day);
		 * 
		 * switch (cld.get(Calendar.DAY_OF_WEEK)) { case 1: week = "日"; break;
		 * case 2: week = "一"; break; case 3: week = "二"; break; case 4: week =
		 * "三"; break; case 5: week = "四"; break; case 6: week = "五"; break;
		 * case 7: week = "六"; break; }
		 * 
		 * String n = ""; switch ((int) (l[1])) { case 1: n = "一"; break; case
		 * 2: n = "二"; break; case 3: n = "三"; break; case 4: n = "四"; break;
		 * case 5: n = "五"; break; case 6: n = "六"; break; case 7: n = "七";
		 * break; case 8: n = "八"; break; case 9: n = "九"; break; case 10: n =
		 * "十"; break; case 11: n = "十一"; break; case 12: n = "十二"; break; } try
		 * { String a = "北京时间： " + year + "年" + month + "月" + day + "日    星期" +
		 * week + "　农历" + n + "月" + getchina((int) (l[2]));
		 * System.out.println(a); } catch (Exception e) { play.Logger.error(e.getMessage(), e); }
		 */
//	}

	/**
	 * 根据时间转为分钟<br>
	 * 
	 * @param
	 * @return
	 */
	public static int toMinute(String starttime) {
		Calendar cld = Calendar.getInstance();
		try {
			Date date1 = new SimpleDateFormat("HH:mm").parse(starttime);
			cld.setTime(date1);
			int hour = cld.get(Calendar.HOUR_OF_DAY);
			int minute = cld.get(Calendar.MINUTE);
			return minute = hour * 60 + minute;
		} catch (ParseException e) {
			System.out.println("时间格式错误！");
		}
		return 0;
	}

	/**
	 * 根据分钟转为字符串<br>
	 * 
	 * @param
	 * @return
	 */
	public static String minuteToStr(int minute) {
		int hour = minute / 60;
		minute = minute % 60;
		String hours = "";
		String minutes = "";
		if (String.valueOf(hour).length() != 2) {
			hours = "0" + hour;
		} else {
			hours = hour + "";
		}
		if (String.valueOf(minute).length() != 2) {
			minutes = "0" + minute;
		} else {
			minutes = minute + "";
		}
		return hours + ":" + minutes;
	}

	/**
	 * 根据时间转为分钟<br>
	 * 
	 * @param
	 * @return
	 */
	public static int strtoMinute(String starttime) {
		Calendar cld = Calendar.getInstance();
		try {
			Date date1 = new SimpleDateFormat("HH:mm").parse(starttime);
			cld.setTime(date1);
			int hour = cld.get(Calendar.HOUR_OF_DAY);
			int minute = cld.get(Calendar.MINUTE);
			return minute = hour * 60 + minute;
		} catch (ParseException e) {
			System.out.println("时间格式错误！");
		}
		return 0;
	}

	/**
	 * 日期对比<br>
	 * 
	 * @param dt
	 * @return -1,0,1
	 */
	public static int compare(Date date1, Date date2) {
		String sdf = "yyyy-MM-dd";
		return compare(date1, date2, sdf);
	}

	/**
	 * 日期对比<br>
	 * 
	 * @param dt
	 * @return -1,0,1
	 */
	public static int compare(Date date1, Date date2, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		try {
			long dt1 = sdf.parse(sdf.format(date1)).getTime();
			long dt2 = sdf.parse(sdf.format(date2)).getTime();
			if (dt1 > dt2) {
				return 1;
			} else if (dt1 == dt2) {
				return 0;
			} else {
				return -1;
			}
		} catch (Exception ex) {
			log.error("日期对比:compare" + date1 + "," + date2 + "," + format, ex.getStackTrace());
		}
		return 0;
	}

	// 获取某一日期当月的第一天
	public static Date getFirstDayOfMonth(Date curdate) {
		Calendar lastDate = Calendar.getInstance();
		lastDate.setTime(curdate);
		lastDate.set(Calendar.DATE, 1);// 设为当前月的1号
		return lastDate.getTime();
	}

	// 计算当月最后一天,返回字符串

	public static Date getLastDayOfMonth(Date curdate) {
		Calendar lastDate = Calendar.getInstance();
		lastDate.setTime(curdate);
		lastDate.set(Calendar.DATE, 1);// 设为当前月的1号
		lastDate.add(Calendar.MONTH, 1);// 加一个月，变为下月的1号
		lastDate.add(Calendar.DATE, -1);// 减去一天，变为当月最后一天
		return lastDate.getTime();

	}

	public static Date trunc(Date date) {
		return mergerDateAndTime(date, "00:00");
	}

	/**
	 * 合并日期和时间
	 * 
	 * @param date
	 * @param time
	 *            格式为HH:mm:ss或HH:mm
	 * @return
	 */
	public static Date mergerDateAndTime(Date date, String time) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int HH = new Integer(time.substring(0, 2));
		int mm = new Integer(time.substring(3, 5));
		int ss = 0;
		if (time.length() == 8) {
			ss = new Integer(time.substring(6, 8));
		}
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH), HH, mm, ss);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();

	}
	
	public static Long minuteDiff(Date startdate,Date endDate){
//		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		 java.util.Date begin=dfs.parse("2004-01-02 11:30:24");
//		 java.util.Date end = dfs.parse("2004-03-26 13:31:40");
		long between=(endDate.getTime()-startdate.getTime())/1000/60;//除以1000是为了转换成秒
		return between;
	}
	
	public static void main(String[] args)throws Exception {
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 java.util.Date begin=dfs.parse("2014-05-06 17:31:24");
		 java.util.Date end = dfs.parse("2014-05-06 17:51:40");
		System.out.println(minuteDiff(begin,end));
	}

	public static Object getPayBatchno(Date date) {
		if(date==null){
			date = new Date();
		}
		SimpleDateFormat dfs = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return dfs.format(date);
	}

}
