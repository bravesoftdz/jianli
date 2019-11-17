package cn.nova.bus.insure.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.utils.orm.PropertyFilter;

public interface InsuranceturnoverdetailService {

	public Insuranceturnoverdetail getInsuranceturnoverdetail(Long turnoverid,
			long startno);

	public boolean save(Insuranceturnoverdetail detail);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Insuranceturnoverdetail getById(long parseLong);

	public List<Map<String, Object>> queryReturnInsuranceno(
			List<PropertyFilter> buildFromHttpRequest);

	public List<Map<String, Object>> queryCancelInsuranceno(
			List<PropertyFilter> buildFromHttpRequest);

	public List<Map<String, Object>> queryBillInsuranceno(
			List<PropertyFilter> buildFromHttpRequest);
	
	/**
	 * 按用户取出当前应缴款明细记录
	 * @param sellerid  用户id
	 * @param startvoucherno 当前业务使用的票证号，可为空
	 * @return 用户出当前应缴款明细记录
	 */
	public Insuranceturnoverdetail getCurInsuranceturnoverdetail(long sellerid,String startvoucherno);
	
}
