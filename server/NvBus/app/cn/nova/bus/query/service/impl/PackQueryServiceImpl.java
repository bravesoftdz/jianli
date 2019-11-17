package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.query.dao.PackQueryDao;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.query.service.PackQueryService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackQueryServiceImpl implements PackQueryService {

	private PackQueryDao packQueryDao = new PackQueryDao();
	private ParameterService parameterService = new ParameterServiceImpl();

	@Override
	public List<Map<String, Object>> queryPackShipment(
			List<PropertyFilter> propertyFilters) {
		packQueryDao= new PackQueryDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				// "orgid", "orgname", "vehicleno", "departdate", "pieces",
				"orgid", "orgname", "departdate", "pieces", "shipprice",
				"packfee", "handfee", "custodial", "transitfee",
				"insurancefee", "deliveryfee", "insurance", "otherfee",
				"totalfee" }, packQueryDao.queryPackShipment(propertyFilters),
				new Object[] {
						// Long.class, String.class,String.class,
						Long.class, String.class, String.class, Integer.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class });
		return result;
	}

	@Override
	public List<Map<String, Object>> queryPackReceive(
			List<PropertyFilter> propertyFilters) {
		packQueryDao= new PackQueryDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				// "orgid", "orgname","vehicleno", "departdate", "pieces",
				"orgid", "orgname", "departdate", "pieces", "shipprice",
				"handfee", "packfee", "totalfee", "goodsprice" },
				packQueryDao.queryPackReceive(propertyFilters), new Object[] {
						// Long.class, String.class, String.class,String.class,
						Long.class, String.class, String.class, Integer.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class });
		return result;
	}

	@Override
	public List<Map<String, Object>> queryGoods(
			List<PropertyFilter> propertyFilters, Boolean isbysellgroup) {
		packQueryDao= new PackQueryDao();
		List<Map<String, Object>> result = ListUtil
				.listToMap(new Object[] { "orgid", "orgname", "sellbyname","sellbytime", 
						"depositpieces", "depositprice", "recaptionspieces","recaptionsprice",
						"totalfee" }, packQueryDao.queryGoods(propertyFilters,
						isbysellgroup), new Object[] { Long.class,
						String.class, String.class, String.class,
						Long.class, BigDecimal.class,Long.class, BigDecimal.class,
						BigDecimal.class });
		return result;
	}

	@Override
	public List<Map<String, Object>> queryPackVehiclePrice(
			List<PropertyFilter> propertyFilters) {
		packQueryDao= new PackQueryDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"orgid", "orgname", "vehicleno", "departdate", "totalfee",
				"vehicleprice","vehiclenum"},
				packQueryDao.queryPackVehiclePrice(propertyFilters), new Object[] {
						Long.class, String.class, String.class,String.class,
						BigDecimal.class, BigDecimal.class,long.class});
		return result;
	}

	@Override
	public List<Map<String, Object>> queryPackDetails(Global global,
			List<PropertyFilter> buildFromHttpRequest) {
		// TODO Auto-generated method stub
		packQueryDao = new PackQueryDao();
		String balancefeerate = parameterService.findParamValue(ParamterConst.Param_8099, global
				.getUserinfo().getOrgid());

		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"departdate", "packno", "singbillno", "name1", "pieces",
				"shipprice", "handfee", "transitfee", "otherfee", "totalfee",
				"shishoujine", "jiesuanjine", "name2", "chepaihao","status" },
				packQueryDao.queryPackDetails(Float.parseFloat(balancefeerate),
						buildFromHttpRequest), new Object[] { Date.class,
						String.class, String.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, String.class });
		return result;
	}

	@Override
	public List<Map<String, Object>> qryLibraryDetails(
			List<PropertyFilter> buildFromHttpRequest) {
		// TODO Auto-generated method stub
		packQueryDao = new PackQueryDao();

		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"departdate", "packno", "sendstationid", "status", "vehicleno",
				"pieces", "shipprice", "packprice", "servicefee", "custodial",
				"balancby", "balancetime", "updatetime", "code" },
				packQueryDao.qryLibraryDetails(buildFromHttpRequest), new Object[] {
						Date.class, String.class, String.class, String.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, Date.class, Date.class, String.class });// java.sql.Timestamp
		return result;
	}

	@Override
	public List<Map<String, Object>> queryCollectDetail(
			List<PropertyFilter> buildFromHttpRequest) {
		// TODO Auto-generated method stub
		packQueryDao = new PackQueryDao();

		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"tostation", "vehicleno", "packprice", "departdate", "sellby",
				"packno", "packbalanceno", "createtime", "recyclestatus",
				"recycleby", "recycledate","status" },
				packQueryDao.queryCollectDetail(buildFromHttpRequest), new Object[] {
						String.class, String.class, BigDecimal.class,
						Date.class, String.class, String.class, String.class,
						Date.class, String.class, String.class, Date.class,String.class });// java.sql.Timestamp
		return result;
	}

	@Override
	public List<Map<String, Object>> querySendGoodsdGetails(
			List<PropertyFilter> buildFromHttpRequest) {
		// TODO Auto-generated method stub
		packQueryDao = new PackQueryDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"sendstationname", "packno", "tostationname", "packname",
				"goodtype", "pieces", "weight", "sender", "senderphone",
				"senderaddress", "consignee", "consigneephone",
				"consigneeaddress", "departdate", "shiptype", "paymethod",
				"packstatus", "sellby", "singbillno","vehicleno","departtime","driverhpone","signby", "signtime",
				"volume",
				"packed", "shipprice", "packfee", "handfee", "transitfee",
				"insurancefee", "deliveryfee", "otherfee", "servicefee",
				"packprice", "totalfee",
				"remak", "createtime", "createby", "updatetime", "updateby" },
				packQueryDao.querySendGoodsdGetails(buildFromHttpRequest),
				new Object[] { String.class, String.class, String.class,
						String.class, String.class, String.class,
						BigDecimal.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						Date.class, String.class, String.class, String.class,
						String.class, String.class, String.class,String.class,String.class,String.class, Date.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, Date.class, String.class, Date.class,
						String.class });
		
		return result;
	}


}
