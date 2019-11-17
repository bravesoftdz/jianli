/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service.impl<br/>
 * <b>文件名：</b>ViprechargeServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-30 下午05:35:02<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.ViprechargeDao;
import cn.nova.bus.base.service.ViprechargeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ViprechargeServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-30 下午05:35:02<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class ViprechargeServiceImpl implements ViprechargeService {


	private ViprechargeDao dao = new ViprechargeDao();

	/*
	 * (non-Javadoc) VIP充值明细查询
	 * 
	 * @see
	 * cn.nova.bus.base.service.ViprechargeService#queryViprecharge(java.util
	 * .List)
	 */
	@Override
	public List<Map<String, Object>> queryViprecharge(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "activityname", "vipcardno",
				"vipmoney", "vipamount", "money", "rechargename", "createname",
				"updatename", "isturnover", "rechargetime", "createtime",
				"updatetime" }, dao.queryViprecharge(buildFromHttpRequest),
				new Object[] { String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class,
						String.class, String.class, Boolean.class,
						Timestamp.class, Timestamp.class, Timestamp.class });
	}

	/*
	 * (non-Javadoc) VIP消费明细查询
	 * 
	 * @see
	 * cn.nova.bus.base.service.ViprechargeService#queryVipconsume(java.util
	 * .List)
	 */
	@Override
	public List<Map<String, Object>> queryVipconsumeldetail(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "customername", "createname",
				"id", "vipcardno", "moneychange", "pointchange", "remainmoney",
				"remainpoint", "createtime", "ticketno", "departdate",
				"departtime", "selltime", "code", "startname", "endname",
				"paymethod", "sellway", "ticketstatus", "money", "vipamount",
				"sellname", "type", "vipgrade", "price" },
				dao.queryVipconsumeldetail(propertyFilterList), new Object[] {
						String.class, String.class, Long.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, Timestamp.class, String.class,
						Timestamp.class, String.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class,
						String.class, BigDecimal.class });

	}

	/*
	 * (non-Javadoc) VIP购票汇总表
	 * 
	 * @see
	 * cn.nova.bus.base.service.ViprechargeService#qryVipsellticket(java.util
	 * .List)
	 */
	@Override
	public List<Map<String, Object>> qryVipsellticket(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "name", "vipcardno",
				"departdate", "sellnum", "price", "charges", "returnnum" },
				dao.queryVipsellticket(buildFromHttpRequest), new Object[] {
						String.class, String.class, Timestamp.class,
						Long.class, BigDecimal.class, BigDecimal.class,
						Long.class });
	}

	/*
	 * (non-Javadoc) VIP消费查询
	 * 
	 * @see
	 * cn.nova.bus.base.service.ViprechargeService#queryVipconsume(java.util
	 * .List)
	 */
	@Override
	public List<Map<String, Object>> queryVipconsume(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "customername", "createname",
				"id", "vipcardno", "moneychange", "pointchange", "remainmoney",
				"remainpoint", "createtime", "money", "vipamount", "type",
				"vipgrade" }, dao.queryVipconsume(propertyFilterList),
				new Object[] { String.class, String.class, Long.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, Timestamp.class,
						BigDecimal.class, BigDecimal.class, String.class,
						String.class });
	}

}
