/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.query.service.impl<br/>
 * <b>文件名：</b>InsuranceQryServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-2-22 上午09:47:49<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.InsuranceQryDao;
import cn.nova.bus.query.service.InsuranceQryService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>InsuranceQryServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-2-22 上午09:47:49<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class InsuranceQryServiceImpl implements InsuranceQryService {
	private InsuranceQryDao insuranceDao = new InsuranceQryDao();

	/*
	 * (non-Javadoc) 保险销售明细查询
	 * 
	 * @see
	 * cn.nova.bus.query.service.InsuranceQryService#queryInsurance(java.util
	 * .List)
	 */
	@Override
	public List<Map<String, Object>> queryInsurance(
			List<PropertyFilter> buildFromHttpRequest, long routeid,
			long scheduleid, String orderno) {
		//InsuranceQryDao insuranceDao = new InsuranceQryDao();
		String schedulecode="";
		if(scheduleid>0){
			schedulecode = insuranceDao.queryScheduleCode(scheduleid);
		}
		List<Object> list=insuranceDao.qryInsurance(buildFromHttpRequest, routeid, schedulecode, orderno);
		return ListUtil.listToMap(new Object[] { "sellorg","htsellorg","ticketname", "ticketno",
				"departdate", "routename", "code", "endname", "departtime",
				"insuranceno", "customername", "mobilephone", "certificateno",
				"insurername", "typename", "premium", "insureamount",
				"insurancestatus", "sellname", "selltime", "paymethod",
				"sellway", "sellip", "polnumber",
				"insuranceprintdatetime", "ywmoney", "shmoney", "emoney",
				"emmoney", "reprintnum", "outletsaddress","returnorcancelby", 
				"returnorcanceltime", "insurersbankcode", "startname", "insuretypecode",
				"islinework", "seatno", "sellby", "orgcode",
				"certificatetype","isreturninsure","ischecked","isdepartinvoices","insuranceid","orderno","ticketstatus",
				"returnfeemode","isdeparted","iorderno"},
				list , new Object[] {String.class, String.class, 
				String.class, String.class, Date.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, BigDecimal.class, BigDecimal.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class,
				String.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				boolean.class, String.class, String.class, String.class,
				String.class,Boolean.class,Boolean.class,Boolean.class,Long.class, String.class,String.class,
				String.class,Boolean.class,String.class});
	}
	
	/*
	 * (non-Javadoc) 废保明细查询
	 * 
	 * 
	 */
	public List<Map<String, Object>> queryCancelInsurance(
			List<PropertyFilter> propertyFilters) {
		List<Object> list=insuranceDao.summaryQuery(propertyFilters);
		return ListUtil.listToMap(new Object[] { "cancelorgid", "ticketno", "insuranceno", "departdate", "departtime", "routename", "code", "typename", "premium", "insurername", "sellname", "cancelname", "canceltime", "cancelip"},
				list, new Object[] { String.class,String.class,String.class, Date.class, String.class, String.class, String.class, String.class, BigDecimal.class, String.class, String.class, String.class, String.class, String.class});
	}
	/*
	 * (non-Javadoc) 保险销售汇总查询
	 * 
	 * 
	 */
	@Override
	public List<Map<String, Object>> queryInsurancedetail(List<PropertyFilter> buildFromHttpRequest) {
		//InsuranceQryDao insuranceDao = new InsuranceQryDao();
		List<Object> list=insuranceDao.queryInsurancedetail(buildFromHttpRequest);
		return ListUtil.listToMap(new Object[] { "sellorg","htsellorg","irsname", "sellisnum",
				"sellismount", "returnisnum", "returnismount", "cancelisnum", "cancelimount",
				"subtotal", "stationget"},
				list , new Object[] {String.class, String.class, String.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,Double.class });
	}

	/*
	 * (non-Javadoc) 售票员保险销售统计
	 * 
	 * @see
	 * cn.nova.bus.query.service.InsuranceQryService#insuranceReport(java.util
	 * .List)
	 */
	@Override
	public List<Map<String, Object>> insuranceReport(
			List<PropertyFilter> buildFromHttpRequest, long routeid,long returnOrcanceluserid,String begindate,String enddate,String orgids,Date departbegindate,Date departenddate, String paymethod) {
		//InsuranceQryDao insuranceDao = new InsuranceQryDao();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return ListUtil.listToMap(new Object[] { "sellby","code",
					"sellnum", "totalpremium", "returnnum", "returnpremium","cancelnum","cancelpremium","ticketnum","premium",
					"mininsuranceno","maxinsuranceno","cashnum","nocashnum","cashprice","nocashprice" },
					insuranceDao.insuranceReport(buildFromHttpRequest, routeid,returnOrcanceluserid,sf.parse(begindate),sf.parse(enddate),orgids,departbegindate,departenddate, paymethod),
					new Object[] { String.class,String.class, Integer.class,
							BigDecimal.class, Integer.class,BigDecimal.class,  Integer.class ,BigDecimal.class,
							Integer.class,BigDecimal.class, String.class, String.class,Integer.class,Integer.class,
							BigDecimal.class,BigDecimal.class});
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
		
	}


}
